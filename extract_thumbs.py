import cv2, os

videos = [
    'assets/media/videos/promo-marbella-1.mp4',
    'assets/media/videos/promo-marbella-3.mp4',
    'assets/media/videos/promo-marbella-5.mp4',
    'assets/media/videos/promo-jetski-action.mp4',
]

out_dir = 'assets/media/videos/thumbs'
os.makedirs(out_dir, exist_ok=True)

for vpath in videos:
    fname = os.path.splitext(os.path.basename(vpath))[0]
    cap = cv2.VideoCapture(vpath)
    total = int(cap.get(cv2.CAP_PROP_FRAME_COUNT))
    target = int(total * 0.25)
    cap.set(cv2.CAP_PROP_POS_FRAMES, target)
    ret, frame = cap.read()
    if ret:
        out = os.path.join(out_dir, f'{fname}-thumb.jpg')
        cv2.imwrite(out, frame, [cv2.IMWRITE_JPEG_QUALITY, 90])
        h, w = frame.shape[:2]
        print(f'OK: {out} ({w}x{h})')
    else:
        print(f'FAIL: {vpath}')
    cap.release()
