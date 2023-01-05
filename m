Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EFD65EABE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjAEMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjAEMde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:33:34 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8EF485A6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 04:33:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m21so52550689edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 04:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwpb044KqtjBhtl1Bm719/ilzZh9PY8FBAW1s12for8=;
        b=AHs7dfOXIB/OKVfu5rgcTlKLDljanF9Ga/d/kCIzE482MT/5uh42FMdMpDvoJyHnvc
         213ywA409wYpmz26bnnjy0IVzLLjzO7vIBJO1/1ldLJCWJ6y9I0tINV88GsLfmIVyH31
         aypIudFY3fVIUORq8N7/FHE6RKp40yU3bOsYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwpb044KqtjBhtl1Bm719/ilzZh9PY8FBAW1s12for8=;
        b=GSifRiCgJdKllEjSZvkMkQss1O0UdHKfBOOWUef4Va+O2TjAT+lG1s3TZ5KP3ka8YY
         4M2c70zecXZWx5baID+XxH/X6Q+alCmknhcoqvaSGukqFzE4gxliLE9aAnkRIe5HdJaf
         87AKu/oCHukQ7srCfY71JOaYmFT/faLr/OKZjvmCMv8X2q++UK5KX8JLFvQZMqwRO8TM
         pw8ogvM8V52rUstYqILVlI6VucZbhuX6WpLpb40WqOZQMHbc2He4oloiuqE9Ig1QExK0
         2Po3UhwFG2qwdTtnsGWjwL41tHrvaIlhayISyO4Ke6nOBbWP6zCPHMy7PVJPzkKSBlhk
         6VHg==
X-Gm-Message-State: AFqh2kqtdMV+4d3hmZDWrUh6+1S6uU81zICNXmyl5pPhTtJHrOJ5L9Pz
        3n4oNmXFkJ42ynPVml45iT6z+A==
X-Google-Smtp-Source: AMrXdXuY072DkPeyaAWlteHrHjvbxqFbkBMg8j16ADhpQJ8PEueEuMq5YA0oI6vuJ86UtyBuhEvUaA==
X-Received: by 2002:a05:6402:150b:b0:493:a6eb:874f with SMTP id f11-20020a056402150b00b00493a6eb874fmr1216850edw.7.1672922007810;
        Thu, 05 Jan 2023 04:33:27 -0800 (PST)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:43c3:8ac4:5d6f:2251])
        by smtp.gmail.com with ESMTPSA id r17-20020aa7d591000000b004847513929csm13138909edq.72.2023.01.05.04.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 04:33:27 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Thu, 05 Jan 2023 13:32:12 +0100
Subject: [PATCH 1/6] Revert "media: uvcvideo: Fix power line control for
 Lenovo Integrated Camera"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230105-uvc-gcc5-v1-1-8550de720e82@chromium.org>
References: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
In-Reply-To: <20230105-uvc-gcc5-v1-0-8550de720e82@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=3972; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=NB7jQ6QoKPyFq1qlyN4fB4I79KDSooYKz0aYGFsDK/0=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjtsOJIPodmNM8YDX1mxcv+bsBZ0xhN/gnjG1qMcEq
 OFtGgkSJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY7bDiQAKCRDRN9E+zzrEiGbQD/
 0dquCOEhE2QMVsGXWdJ/8pVQtpSvtCELnj+O/2itym4znaIRsiB1k2abVwYPSfg/R+eRqMnbPkAmXm
 FSdf1lHx3vYI79+JOKKck9CSIXlZYsgLrkJ4839n7H1AuADUBzLqd34ZPDfTd3LERP+j0lKgSW4Vp3
 ZJOWfixEmgjpcf4z9UWX0ehbtDUb72Lno9fGOVBZUa+ZN7AWvLAX9SPOTNjlCioTNcPFgHuOPUme+R
 Cc14Y0yyUDV3qSSQJVGOgGCGjeVOajhLjrPNFvXZcwHYcf+YKeG7aSnFn9S5vU1OyQKE3Pbp/OO4sr
 VfWcY2haq8q8MSNCdZLxCUG1yv2kXbwykkVi1opeSlp0zcZ76YBHiA08bYI4AwpyIwd4ReGjoOJO0+
 psnJL0go7TVBxgPMKZDnOGSKRmgP+BbczD3tQqTJtBOitpGh91ldQ8ENZiY/0sxw1Sa95HDomSx4TR
 Ym1RQrudFtutLPO+KeKJOMsyV5yeBDOmA+bUxkxJGBXdLaigEgYonR8QhZFdM+riFjnEPNqKdeq9Ki
 R0Rfp5zzQqOh1FM018a+qqik5Wvbi+4SUiVfvDb8mjxILmQ3U5C2PvSEN5grNDRdddUop1S8MveGBv
 VoJjSrmceH2O8U5WTEUMGsglZDi1IghBi7z1SXdUqpkUGFUPuZoAb6ujmKCg==
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
