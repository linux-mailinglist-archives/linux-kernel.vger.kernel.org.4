Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F058F6F3BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 03:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjEBBGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 21:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEBBGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 21:06:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF83C19;
        Mon,  1 May 2023 18:05:52 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5465fc13so2389552b3a.3;
        Mon, 01 May 2023 18:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682989551; x=1685581551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u6KvYmG6iKLAMHd7vkBOqn94kNNGYev+CUO7axt/3Ec=;
        b=Gs+6By193FhxXRhpOqSjVLXXF7EyDRAAejY2VpLNrjFnvJlzkhj6XnGPVMwsw/Xq54
         LyYhFqDbi/OvQNt97O4SXohp7Qo221vNnI4nseGo3J3zKbwBKOu/+dGBsfBaTiDfbXcC
         BZGlPdIM+MxRu2XGepI7exzL41Kw48lPj6EVNjFDtkEjAnx/Lo5evCa8JnQrQRMg/xwi
         pb7fFeCqwVNqT8+jK+5yGu+ptWjU5iygYwDBVFBBZrKCWDkxcrgox5Q8z445S+uvUDiv
         6G//ZUlJC8UdPD3yT9Ir3R8WKMMqhPdZ/fvqKcsyPNBO3i923HA372U0ag9Yy+Tp5BCu
         m3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682989551; x=1685581551;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6KvYmG6iKLAMHd7vkBOqn94kNNGYev+CUO7axt/3Ec=;
        b=PWmpMPgVB5SxFlNpGLe25CxHVsQ6QgzjX867l8tY5LgOnnPzlgDF6hNI9wJZjEDKx5
         YfHYOIDBBCoONwMbbu7OfAIp9sonVA3hOfQU1v09wx5C7bjuNQ6M7EqYjYuXi9Yu+QT1
         /NfWRb11i/8Wo3dQXzAhEn/Qm9aIUO6rObMmSwC8Wqjp7ODLhVlLZEsFNAjGmJBlzQVT
         ZSAjTAp6TUfHfEMqRBPpHWW2LmIwEySUEhzqzbeBaayM04TKBtqx/7+s67i1fxLDQs5+
         ZleV2OkelXrlBpGOA1Z/eu+xOMef86nx9VZdeYCKmqd9msbHrEpE2LKFrGhV+pXa9w6M
         SECg==
X-Gm-Message-State: AC+VfDy4mrV4hW5OeGV1Nn1uiQK7QQnO0MYRJo2qBfG5M7ZMoGLWneCo
        4GQ/7QUaHF56+nT/4xJb+ds8ShSM5dQkDegb
X-Google-Smtp-Source: ACHHUZ4ngoQ7ohSxrNtlyRwdY/M+Wmel/KQQoo9L21BpjGtXxf0YTlp8Awswni/nvFNX47qFMBMitQ==
X-Received: by 2002:a05:6a00:2e18:b0:62d:8376:3712 with SMTP id fc24-20020a056a002e1800b0062d83763712mr15725872pfb.28.1682989551282;
        Mon, 01 May 2023 18:05:51 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5ac8:de82:eedb:43ac:e372])
        by smtp.gmail.com with ESMTPSA id m15-20020a056a00080f00b00627e87f51a5sm16001440pfk.161.2023.05.01.18.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 18:05:50 -0700 (PDT)
Date:   Tue, 2 May 2023 06:35:43 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: media: usbvision: Remove comparision to NULL
Message-ID: <ZFBh54sbwiRFKyG+@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparison to null in file usbvision-core.c and usbvision-i2c.c.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/staging/media/usbvision/usbvision-core.c | 8 ++++----
 drivers/staging/media/usbvision/usbvision-i2c.c  | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/usbvision/usbvision-core.c b/drivers/staging/media/usbvision/usbvision-core.c
index e35dee35b068..a38104b2a0f9 100644
--- a/drivers/staging/media/usbvision/usbvision-core.c
+++ b/drivers/staging/media/usbvision/usbvision-core.c
@@ -349,7 +349,7 @@ int usbvision_scratch_alloc(struct usb_usbvision *usbvision)
 {
 	usbvision->scratch = vmalloc_32(scratch_buf_size);
 	scratch_reset(usbvision);
-	if (usbvision->scratch == NULL) {
+	if (!usbvision->scratch) {
 		dev_err(&usbvision->dev->dev,
 			"%s: unable to allocate %d bytes for scratch\n",
 				__func__, scratch_buf_size);
@@ -374,7 +374,7 @@ int usbvision_decompress_alloc(struct usb_usbvision *usbvision)
 	int IFB_size = MAX_FRAME_WIDTH * MAX_FRAME_HEIGHT * 3 / 2;
 
 	usbvision->intra_frame_buffer = vmalloc_32(IFB_size);
-	if (usbvision->intra_frame_buffer == NULL) {
+	if (!usbvision->intra_frame_buffer) {
 		dev_err(&usbvision->dev->dev,
 			"%s: unable to allocate %d for compr. frame buffer\n",
 				__func__, IFB_size);
@@ -2284,7 +2284,7 @@ int usbvision_init_isoc(struct usb_usbvision *usbvision)
 		struct urb *urb;
 
 		urb = usb_alloc_urb(USBVISION_URB_FRAMES, GFP_KERNEL);
-		if (urb == NULL)
+		if (!urb)
 			return -ENOMEM;
 		usbvision->sbuf[buf_idx].urb = urb;
 		usbvision->sbuf[buf_idx].data =
@@ -2343,7 +2343,7 @@ void usbvision_stop_isoc(struct usb_usbvision *usbvision)
 	int buf_idx, err_code, reg_value;
 	int sb_size = USBVISION_URB_FRAMES * usbvision->isoc_packet_size;
 
-	if ((usbvision->streaming == stream_off) || (usbvision->dev == NULL))
+	if ((usbvision->streaming == stream_off) || (!usbvision->dev))
 		return;
 
 	/* Unschedule all of the iso td's */
diff --git a/drivers/staging/media/usbvision/usbvision-i2c.c b/drivers/staging/media/usbvision/usbvision-i2c.c
index 6e4df3335b1b..3bba93293463 100644
--- a/drivers/staging/media/usbvision/usbvision-i2c.c
+++ b/drivers/staging/media/usbvision/usbvision-i2c.c
@@ -233,7 +233,7 @@ int usbvision_i2c_register(struct usb_usbvision *usbvision)
 				&usbvision->i2c_adap,
 				"tuner", 0, v4l2_i2c_tuner_addrs(type));
 
-		if (sd == NULL)
+		if (!sd)
 			return -ENODEV;
 		if (usbvision->tuner_type != -1) {
 			tun_setup.mode_mask = T_ANALOG_TV | T_RADIO;
-- 
2.34.1

