Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D2568D297
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjBGJUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjBGJU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:26 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555CD38012;
        Tue,  7 Feb 2023 01:20:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id j1so8478113pjd.0;
        Tue, 07 Feb 2023 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/uLvTJmmBzuds9Az0fvihrnUknv2MS6FQWlRinADjY=;
        b=JXM3wF6v+/awCvepJFCJFa5ce2kGsjRN2AMorylaobttOekgZO05b+YIe7bWF30k5E
         mtjOMqDkXGaZPxXd3P9eQJJZiGlFbGYb9kBpzG62FX57n9V/Einai9DmTNalhJZTIdu2
         SN1gP7zSX5vuKgjmzhMYz395aqXIpEVlmQdwOjyI0tbcYg9E/eliiJodepFzVvdoAtp0
         EERzFrqoiMIb2dJD/dvkZjKZGxUNrEkxPE/eyR5yiEnbROVob5Nj2x6GjPf6LOBhigJl
         qBREhlz7xa+EgZD97ljNN+Jas2e43eZXbcPQ3ulmdTxDpDPEiohwQvJsN4HOVfmRWF3x
         0arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/uLvTJmmBzuds9Az0fvihrnUknv2MS6FQWlRinADjY=;
        b=R6k7kI+g+YhWyoWgblNIyGi20sXnysTHav4EnpBtDkHHbAr2fsXHImBF7MxL4E0djA
         xIfZI/P/SykBn0Y5ePuPTtrEOKDljjO3zTTcedtTFkiheVDhJa8T26vSxiqRL/1kI4nE
         sigDw9huPuBm7LTpwLPumsrU0aMau0g6dL+g0fX6cCLb8G8HuxlH/5ZhrPzl1K3BZEjC
         /SJcrdZhRxSQ9vE2NDiKXIE75JtUxP3VkcPaMgnOU3uaJHpcEQhpanY+kepJKM6bxYxn
         axnE9q7kRSrq0FnpemW1ietLbV0CJFaa1hY6z198q+JnnimmbYcAiQKHA5d0iznh04ok
         Y/vQ==
X-Gm-Message-State: AO0yUKX3F1B+9DfslauHKRakcN7vBSCw+I03O9fkbH71TldKRXc/hj8h
        Cd97Qxakxkwhf08SJGF/Q1U=
X-Google-Smtp-Source: AK7set9enHtFRGhNWA3vwtPhxpii7h8jJM8ItLVAukRK79qbCXXbTt1HIDnYh0iHYhUOx27fonF+EA==
X-Received: by 2002:a17:902:db09:b0:199:18ac:cd48 with SMTP id m9-20020a170902db0900b0019918accd48mr2160313plx.53.1675761619678;
        Tue, 07 Feb 2023 01:20:19 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:19 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v11 4/7] media: v4l: Add HEXTILE compressed format
Date:   Tue,  7 Feb 2023 17:18:59 +0800
Message-Id: <20230207091902.2512905-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207091902.2512905-1-milkfafa@gmail.com>
References: <20230207091902.2512905-1-milkfafa@gmail.com>
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

Add HEXTILE compressed format which is defined in Remote Framebuffer
Protocol (RFC 6143, chapter 7.7.4 Hextile Encoding) and is used by
Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 73cd99828010..e6ee0eebe691 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -275,6 +275,13 @@ please make a proposal on the linux-media mailing list.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
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
index 8e0a0ff62a70..a0e387335139 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1494,6 +1494,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC08C:	descr = "QCOM Compressed 8-bit Format"; break;
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 1befd181a4cc..1ce21cc4fbf1 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -778,6 +778,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_QC08C    v4l2_fourcc('Q', '0', '8', 'C') /* Qualcomm 8-bit compressed */
 #define V4L2_PIX_FMT_QC10C    v4l2_fourcc('Q', '1', '0', 'C') /* Qualcomm 10-bit compressed */
 #define V4L2_PIX_FMT_AJPG     v4l2_fourcc('A', 'J', 'P', 'G') /* Aspeed JPEG */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compressed */
 
 /* 10bit raw packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.34.1

