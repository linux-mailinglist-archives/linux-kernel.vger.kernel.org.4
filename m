Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0625A65EDF8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjAEN4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjAENzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:55:21 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD34EC93
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:53:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id x22so90154091ejs.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwpb044KqtjBhtl1Bm719/ilzZh9PY8FBAW1s12for8=;
        b=ZYMrlUCbRxHnFzr8zaLMwgwXxcqPD0BqE9J7pn/nLICBPF7i0mVyIBbvfhYGtrC2A3
         O14lbBksh4tUrKNB5XOxv+qd7nH1vxd98bEw6gDaXz33ZfTVIcwMW/VpLCSRL1HrUlM1
         ipQUqgXb6OYvSSyPMawrFEWxNv1v357UsqZvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwpb044KqtjBhtl1Bm719/ilzZh9PY8FBAW1s12for8=;
        b=LQdt4WbqMkcozTjPAcNbfnF37h6/KgGMAZIMst6EfPFiKd14EIZHnvMWwuTz0N/ifS
         gUsvsE8UQF3HegWesTGT+SOU6SD8cdclfWgKzyrfm4XnmgoEuPiyAdV9rcVTSK+TArl1
         CdUopbxmlm863KD60f6GpQwe571nD+VZCTJoJ/b7uN04cywtmjhBZExcdftl6L3Uu3Yn
         7dJI7KDybabdst+0UbWu5OPihbPzAipdTwTUMKR+6vJfoxmG8xTf+arHXbN1t3PeKcLS
         0NytqQ7jucapQjbxOsuY8o4G+YZXc4AKdRrFuBKgzcox59iypoDy8hsQdfRJAVFOqmJF
         ADQg==
X-Gm-Message-State: AFqh2kqVyYewdPdExxCbCHWnURznPvjjqT9Pr+ND6YSaILAsPn61q7by
        RdQVoNitqgF+1om4/PU+Ay3KdA==
X-Google-Smtp-Source: AMrXdXsrIg5VWskMm9cojCnRsO3whyhLzgBk+hufNJimzWdvytWr9UtvPvczNrMHxPPlcn+4TFdP/A==
X-Received: by 2002:a17:906:144a:b0:78d:f455:b4d5 with SMTP id q10-20020a170906144a00b0078df455b4d5mr45426428ejc.60.1672926795598;
        Thu, 05 Jan 2023 05:53:15 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id x11-20020a170906b08b00b007806c1474e1sm16459084ejy.127.2023.01.05.05.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:53:15 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 14:52:52 +0100
Subject: [PATCH v2 1/7] Revert "media: uvcvideo: Fix power line control for
 Lenovo Integrated Camera"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v2-1-2ba6c660d6f5@chromium.org>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=NB7jQ6QoKPyFq1qlyN4fB4I79KDSooYKz0aYGFsDK/0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjttY9tEZb73sYruETdZwdLJ0gV88cNYKG1Nx86Bu1
 Tu9wjCSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bWPQAKCRDRN9E+zzrEiNEDD/
 wPk9NdfRCdNp9BX4cKabhZGov01wsU9WYT/Z6u0I4snGVOydguAgqZC+l6W2jcfCh7GPxlXMGWtcJp
 OCJVoQXUVq6nMjo/nOSNr494ZGqWkesAhSKYFlpOeWw+kO2A1kR76XQj4MmK7Md5HS5VcMT22Z83Jq
 wwdDdmI+7cPs5Y2hLspwRKYkmOklyaaMFtzxXdfCOAfuGnkq+wrTJad49QmI3akWDQ6aCcuuO8V6DK
 LGOhkKae12nDmzgy8GM6cYlNoGyUgB/j5dHY6fAyF7EDBXeu2Bha0/5pxTUJ0TTTaQxZEy0OUT2J2/
 8aUrLdLyi2pwZTkDU3nGNAHFEAamVU0+xYt59OjD0LXEdEB3yRjuhhzx6PUOZ/8rS9fxT4fbqWcV/e
 tlVDPKzEU/eTWf8GVUZUP57ZqQuQFaSGsHl+pHjllZzeTa0wm8iZQ0BmUU1JdXQZQvoiNO83FsNVM9
 Ylk1lv566KtdYjvEts50fTVIHGLscp0r/Bi5Q0h0DXdBblgl2kF+RtJuPb93vzVNy4NIxE2XFsVEin
 aNbkuxPjjscbGRCGsVHFkXjaMNkFYa+E0R43FfREkM3dx0QOHRKtXLqH8k2HN74RPjM92wcFwSP/aO
 GNIE6mpe+dlV0Yp6o1hQ7/9GpNctzQxmv9CjOWMRQl3qlfz/InfaGwakeSnA==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJECT_DRUG_GAP_L autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit fb1316b0ff3fc3cd98637040ee17ab7be753aac7.

As today, the minimum version of GCC required to build the kernel is
5.1, which does not support static const structure initialization.

Error:
drivers/media/usb/uvc/uvc_ctrl.c:737:2: error: initializer element is not a compile-time constant

Fixes: fb1316b0ff3f ("media: uvcvideo: Fix power line control for Lenovo Integrated Camera")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 24 +++++++++++-------------
 drivers/media/usb/uvc/uvc_driver.c | 16 ----------------
 drivers/media/usb/uvc/uvcvideo.h   |  1 -
 3 files changed, 11 insertions(+), 30 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index e07b56bbf853..06bb3822c05d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -722,20 +722,18 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 	},
 };
 
-const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11 = {
-	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
-	.entity		= UVC_GUID_UVC_PROCESSING,
-	.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
-	.size		= 2,
-	.offset		= 0,
-	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
-	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
-	.menu_info	= power_line_frequency_controls,
-	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
-};
-
 static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
-	uvc_ctrl_power_line_mapping_uvc11,
+	{
+		.id		= V4L2_CID_POWER_LINE_FREQUENCY,
+		.entity		= UVC_GUID_UVC_PROCESSING,
+		.selector	= UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
+		.size		= 2,
+		.offset		= 0,
+		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
+		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
+		.menu_info	= power_line_frequency_controls,
+		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
+	},
 };
 
 static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 72c025d8e20b..2f59ee80a0af 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2378,13 +2378,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
  * Driver initialization and cleanup
  */
 
-static const struct uvc_device_info uvc_ctrl_power_line_uvc11 = {
-	.mappings = (const struct uvc_control_mapping *[]) {
-		&uvc_ctrl_power_line_mapping_uvc11,
-		NULL, /* Sentinel */
-	},
-};
-
 static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
 	{ 1, "50 Hz" },
 	{ 2, "60 Hz" },
@@ -2988,15 +2981,6 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_FORCE_BPP) },
-	/* Lenovo Integrated Camera */
-	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
-				| USB_DEVICE_ID_MATCH_INT_INFO,
-	  .idVendor		= 0x30c9,
-	  .idProduct		= 0x0093,
-	  .bInterfaceClass	= USB_CLASS_VIDEO,
-	  .bInterfaceSubClass	= 1,
-	  .bInterfaceProtocol	= UVC_PC_PROTOCOL_15,
-	  .driver_info		= (kernel_ulong_t)&uvc_ctrl_power_line_uvc11 },
 	/* Sonix Technology USB 2.0 Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index ae0066eceffd..a8eec43cd860 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -747,7 +747,6 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags);
 void uvc_status_stop(struct uvc_device *dev);
 
 /* Controls */
-extern const struct uvc_control_mapping uvc_ctrl_power_line_mapping_uvc11;
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 
 int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,

-- 
2.39.0.314.g84b9a713c41-goog-b4-0.11.0-dev-696ae
