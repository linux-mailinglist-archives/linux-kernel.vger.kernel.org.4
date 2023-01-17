Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2B66E302
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjAQQEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjAQQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:04:35 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B4302AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:04:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hw16so64591168ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IvUZoQWcp737GhLOhx0IrLcJeYUKu1TJMZ64ElkyCl0=;
        b=LtXG0J8zyzCjm9MqNSHDLaaBHsvltP39/0/ZrdCNDdzjhWSv5l2vOh06+NFtbm7clu
         6yezOJW7nbRHteQEA9b3sz9xUX7X/3xkBOklDNb63NzbXK4EcEeNr0safClfYW0bxFIk
         uqzBsCY2KAJNCwEcoNy1uTnnlCnvctNzq6TG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvUZoQWcp737GhLOhx0IrLcJeYUKu1TJMZ64ElkyCl0=;
        b=PUAi4UOfJy2yc3Z0Vi/lm0o1ng93ZT0GnxJTC/qvntqpsYITumkIJ8gZ+JTq9ACad1
         RS+URvBFDZntSAyYpPt7AUlpW08pals0VJwSsnoEx8eFjFHXUe4YoNF3T4PG5V48AoZl
         JN/tbJKPxx67qKgyTi23M4mrAppsHlnpgkEDOGU1OUhTumSKCUeu16lM7jM8kLpyb0Lk
         NhZRPoaTNklz86VSnn2hvOUtf/q8RszNJjbnnJ/4QaEEd/nmMg3NjjfuOJiaQY9YC+1t
         ld3wxzVVYf0oIdvOzjECwwckt+1aO2qEe14SMMUjepkQimyKlxMNEbQqD1nq3WXoKJDp
         5UpA==
X-Gm-Message-State: AFqh2koDANt8j9QFlZyf6atKQeoeNSa57eKkqsRUMNf4/SPWf8sMc+t/
        sQlYnIVykv6fLrEpfjtW1SCjnQ==
X-Google-Smtp-Source: AMrXdXuRdpf43xXLL55Q8i6Te5xdUfTedr8FobvHBMbn6dTtVK6ILKNXqAG9wnJ1c7mdHkXdzqgN5w==
X-Received: by 2002:a17:907:2a53:b0:86f:8ccb:5d1e with SMTP id fe19-20020a1709072a5300b0086f8ccb5d1emr2964275ejc.17.1673971472829;
        Tue, 17 Jan 2023 08:04:32 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:1201:2fe7:fd4c:25])
        by smtp.gmail.com with ESMTPSA id rf26-20020a1709076a1a00b00871a4ab4736sm2025263ejc.97.2023.01.17.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 08:04:32 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 17 Jan 2023 17:04:24 +0100
Subject: [PATCH v5] media: uvcvideo: Add a unique suffix to camera names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-meta-v5-0-3385df697370@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=6099; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=iU4HVpvEHbaMtfSC7qMPoQlBKp0dQdmQ9Dw5xYIxNh8=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjxscJ4er7DKd1CBv1Np3nCOKa6fiZgFvOTwFRLcEv
 wlZ/gZGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY8bHCQAKCRDRN9E+zzrEiO/0D/
 40WrUhPq2Bml6IMub5ptf1Je2k4LDbtB73M0PNrJa2A4VXmiRbjb2NZsbOve0pAEy4GTlNl1c4Kev9
 kDDym0dBRbhclp4vTMZKteaS2eMYmUWpOv573knhgUiC0vWSl3Gk3I+PhFpw8sck9YzMe0X2PVqzvN
 h21ehv4Ti0ayNk47sGhb52F4WfzMgEwl2qbs+iaSI7OQr+ROzrf8z1hNPj/NKrmD0sKM9FNXcN2cib
 d0iGDXXb9Hfw+ROTpX8myRtQ4lfMlQ3rCNlzzwHmDxKsF74OQP9MNRzSAQXeyp55UVBdeP2leNpfaq
 aXgU5CvXeO2tx/pe2jJJWqY+RJmt3NNGrm3sfihqELgJ8Fch6drIeoaBCdjwgA8gE2wm/cVrNEUvJ7
 ygrHuuLb4VBXk3oTrUXr7U/H5AEx0Itu3yvBrQVsdOmPJKlHCAfFNM8hLKSX4ulbLYx2tqViEVQ9tX
 XrTbi9ZmqdTPZxShguIrRzlk93PY1CwV2QjmLKILkMITJAETZspfKxGOL7NbSfJ+R5RzUGowJBgQZY
 BLIrz+wuAgD+mEQCej+gQHaURDb4NMfBKeSqAcJ0+QeJswK/45QkNn6nYysINes5AW+OihMAIDhbGS
 Pu9OKOBquvzWXHGSb7pNyL/g5NYJPKGbkulUcRI7KIvmbcTPZ38Tbhyqu6SQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
append a unique number to the device name.

Do it in a way where devices with only one input are not affected by the
change, to avoid any regression.

Fixes v4l2-compliance:
    Media Controller ioctls:
         fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
       test MEDIA_IOC_G_TOPOLOGY: FAIL
         fail: v4l2-test-media.cpp(394): num_data_links != num_links
       test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Add unique prefixes to uvc entities.

Some UVC devices have multiple subdevices (IR, RBG...), lets give
every entity an unique name.

While we do so, try to avoid as much regressions as possible, by
only adding prefix to multi subdevices.

To: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Yunke Cao <yunkec@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
Changes in v5:
- Remove all the changes to the core.
- Do not add suffix to the first video entity of each device.
- Link to v4: https://lore.kernel.org/r/20220920-resend-meta-v4-0-3ac355b66723@chromium.org

Changes in v4:
- Link to v3: https://lore.kernel.org/r/20220920-resend-meta-v1-0-dfcfba923204@chromium.org
---
 drivers/media/usb/uvc/uvc_driver.c   | 21 ++++++++++++++++-----
 drivers/media/usb/uvc/uvc_metadata.c |  4 ++--
 drivers/media/usb/uvc/uvcvideo.h     |  3 ++-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 215fb483efb0..01d5ca3da6ce 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1920,6 +1920,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
 
 int uvc_register_video_device(struct uvc_device *dev,
 			      struct uvc_streaming *stream,
+			      unsigned int index,
 			      struct video_device *vdev,
 			      struct uvc_video_queue *queue,
 			      enum v4l2_buf_type type,
@@ -1963,7 +1964,14 @@ int uvc_register_video_device(struct uvc_device *dev,
 		break;
 	}
 
-	strscpy(vdev->name, dev->name, sizeof(vdev->name));
+	if (index) {
+		snprintf(vdev->name, sizeof(vdev->name), "%s_%u%s", dev->name,
+			 index,
+			 type == V4L2_BUF_TYPE_META_CAPTURE ? "-Meta" : "");
+	} else {
+		snprintf(vdev->name, sizeof(vdev->name), "%s%s", dev->name,
+			 type == V4L2_BUF_TYPE_META_CAPTURE ? "-Meta" : "");
+	}
 
 	/*
 	 * Set the driver data before calling video_register_device, otherwise
@@ -1984,7 +1992,8 @@ int uvc_register_video_device(struct uvc_device *dev,
 }
 
 static int uvc_register_video(struct uvc_device *dev,
-		struct uvc_streaming *stream)
+			      struct uvc_streaming *stream,
+			      unsigned int index)
 {
 	int ret;
 
@@ -2005,7 +2014,7 @@ static int uvc_register_video(struct uvc_device *dev,
 	uvc_debugfs_init_stream(stream);
 
 	/* Register the device with V4L. */
-	return uvc_register_video_device(dev, stream, &stream->vdev,
+	return uvc_register_video_device(dev, stream, index, &stream->vdev,
 					 &stream->queue, stream->type,
 					 &uvc_fops, &uvc_ioctl_ops);
 }
@@ -2018,6 +2027,7 @@ static int uvc_register_terms(struct uvc_device *dev,
 {
 	struct uvc_streaming *stream;
 	struct uvc_entity *term;
+	unsigned int index = 0;
 	int ret;
 
 	list_for_each_entry(term, &chain->entities, chain) {
@@ -2033,7 +2043,7 @@ static int uvc_register_terms(struct uvc_device *dev,
 		}
 
 		stream->chain = chain;
-		ret = uvc_register_video(dev, stream);
+		ret = uvc_register_video(dev, stream, index);
 		if (ret < 0)
 			return ret;
 
@@ -2041,9 +2051,10 @@ static int uvc_register_terms(struct uvc_device *dev,
 		 * Register a metadata node, but ignore a possible failure,
 		 * complete registration of video nodes anyway.
 		 */
-		uvc_meta_register(stream);
+		uvc_meta_register(stream, index);
 
 		term->vdev = &stream->vdev;
+		index += 1;
 	}
 
 	return 0;
diff --git a/drivers/media/usb/uvc/uvc_metadata.c b/drivers/media/usb/uvc/uvc_metadata.c
index 82de7781f5b6..d28f2f147acd 100644
--- a/drivers/media/usb/uvc/uvc_metadata.c
+++ b/drivers/media/usb/uvc/uvc_metadata.c
@@ -156,7 +156,7 @@ static const struct v4l2_file_operations uvc_meta_fops = {
 	.mmap = vb2_fop_mmap,
 };
 
-int uvc_meta_register(struct uvc_streaming *stream)
+int uvc_meta_register(struct uvc_streaming *stream, unsigned int index)
 {
 	struct uvc_device *dev = stream->dev;
 	struct video_device *vdev = &stream->meta.vdev;
@@ -170,7 +170,7 @@ int uvc_meta_register(struct uvc_streaming *stream)
 	 */
 	vdev->queue = &queue->queue;
 
-	return uvc_register_video_device(dev, stream, vdev, queue,
+	return uvc_register_video_device(dev, stream, index, vdev, queue,
 					 V4L2_BUF_TYPE_META_CAPTURE,
 					 &uvc_meta_fops, &uvc_meta_ioctl_ops);
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index df93db259312..e87894b966f2 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -710,10 +710,11 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 void uvc_video_clock_update(struct uvc_streaming *stream,
 			    struct vb2_v4l2_buffer *vbuf,
 			    struct uvc_buffer *buf);
-int uvc_meta_register(struct uvc_streaming *stream);
+int uvc_meta_register(struct uvc_streaming *stream, unsigned int index);
 
 int uvc_register_video_device(struct uvc_device *dev,
 			      struct uvc_streaming *stream,
+			      unsigned int index,
 			      struct video_device *vdev,
 			      struct uvc_video_queue *queue,
 			      enum v4l2_buf_type type,

---
base-commit: a4412fdd49dc011bcc2c0d81ac4cab7457092650
change-id: 20220920-resend-meta-435c30209235

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
