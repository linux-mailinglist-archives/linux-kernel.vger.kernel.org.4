Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C0A6337B1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbiKVI6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiKVI55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:57:57 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4918364;
        Tue, 22 Nov 2022 00:57:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f3so13534097pgc.2;
        Tue, 22 Nov 2022 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlmLRxqta9FQgz2JIMdWJ3r/aF/SZlMHSxzhMoUS39c=;
        b=Vo0Nl4Te/9UfymwQw1CZZCYCcSr1W7cpjI0qNhN3xoeD2Db5PE7nJwDPEZH8+SuV2d
         e7aSHfd1J9QvRKO6Mt+pSGrwVmOgJuM0EelLqnM2RddYanJYPF5QQmTfSxOL5sk6JmZH
         SHH5xuYD4kdnmVseIZdGVQua2K24MJrMb53+jCHCg6gJdRm/wAW0PBIC3BQfdjIvaZJL
         0Ud5JSbk2x4XfDcRtnOZvoJtuk6jsgm2sRAZ/+AEcy6vSmc/0C4uA1+sH4kh9ZQ4tBJX
         tsKpsJv4espfgS0iuiPXXrevWsYOg643Mo1KPmMLZQLf2BjNDSW9sKsb/an6VzOujo6O
         c6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlmLRxqta9FQgz2JIMdWJ3r/aF/SZlMHSxzhMoUS39c=;
        b=2+vYYOnCWx2dc8PsjrUo1f7YwryY6Y9mqeHrxuyjrfAjOgMqXrSbZdRI13uht5QANI
         pFpN5X7bLBdc+Q9f511LLDQOOqiiMVbAddpjQ+dq9xAy44B11BVa+xaXvxYpIazBIvXQ
         QtFDXFZ7qhRZcnJ+QqhX2Sr9bg2hZsDl1HmVbttYqh5rLbkjJ4Q+RSLXtgrRhp/3/Bl/
         AqIoyTzvqmcfyvopJtSPjURZDqc2SuPh14Rvwt1rRdoY6cRDL04Jj50AocrGyvTdv2b3
         acqX2MxOyvQ0wqk0Hm/h9rg6oaZVAK3zR5bD7FrvRXpeKWvI2xZDPItWPSRtQQxoyoYH
         TX/w==
X-Gm-Message-State: ANoB5pk5F9epRoAOJ+4VZ54kyIKU0eDnN3liC47Whj0PcJVOt6adKZTX
        hiy+STPnGO25lYM7rl/Crk0=
X-Google-Smtp-Source: AA0mqf57PLEwdGGaJuZ2bnngInGWKv8zQweKSaVVovCF/hr3GzEVw85kM9en05tHuxrCTNCgmOsnmw==
X-Received: by 2002:a65:55cd:0:b0:477:1bb6:c6f4 with SMTP id k13-20020a6555cd000000b004771bb6c6f4mr19087749pgs.417.1669107475450;
        Tue, 22 Nov 2022 00:57:55 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b0017a0668befasm11400246ple.124.2022.11.22.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 00:57:55 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v7 4/7] media: v4l: Add HEXTILE compressed format
Date:   Tue, 22 Nov 2022 16:57:21 +0800
Message-Id: <20221122085724.3245078-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122085724.3245078-1-milkfafa@gmail.com>
References: <20221122085724.3245078-1-milkfafa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HEXTILE compressed format. This format is defined in Remote
Framebuffer Protocol (RFC 6143) and is used by Encoding Compression
Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 0ff68cd8cf62..b45d8aa2e8b0 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -258,6 +258,13 @@ please make a proposal on the linux-media mailing list.
         and it is used by various multimedia hardware blocks like GPU, display
         controllers, ISP and video accelerators.
         It contains four planes for progressive video.
+    * .. _V4L2-PIX-FMT-HEXTILE:
+
+      - ``V4L2_PIX_FMT_HEXTILE``
+      - 'HXTL'
+      - Compressed format used by Nuvoton NPCM video driver. This format is
+        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile
+        Encoding).
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index fddba75d9074..1dd68920cd76 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
 		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 29da1f4b4578..1148546665cb 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -775,6 +775,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

