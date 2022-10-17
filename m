Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA896017F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJQTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJQTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:44:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115061EEEA;
        Mon, 17 Oct 2022 12:44:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so27294477eje.10;
        Mon, 17 Oct 2022 12:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TATHs2k56ufe8lMmyZToJvN32Rg6lEJir/LHJFUdZoQ=;
        b=N3sgwEdi/Li9SwIj/vg8LX7AlvncoeCI/CvSob3JryDoMtcajL9Cd/gfa/CHNCK3V2
         /+e09Gsxp9TYe/Um/zGAOSjHpKWWCn705BM0SuiF2d2RfEM9Uemyj3dh+G/l+9fYWOGG
         bkL8KJH3p/ZHIb5bJL5DAg4abHZX86DtWHAuiKneynkSRDr/Ct0vEUIFnNEwU0p8Vp9U
         HVCjMCoBZqky86jWTElx7jHZgqj/cQNDLZpTU3QL91+EKAspLGMdmatW3Ef6ndE7xkWM
         Ili2sXBR2M8G/TbUFT8qf0GArmRWYYC24xWAucLpcMA3BVA6z7pZTy7ZMoXJfrXfc4P3
         vODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TATHs2k56ufe8lMmyZToJvN32Rg6lEJir/LHJFUdZoQ=;
        b=UUmRMUDHRv6GJtyta1aZERiVAShYUqXRYROL/Or5BLxtC1oLqdGFYazc+K3g2FCUOB
         Jgebej9xhM2zVjlD0xD1Xf+PvRZ7rg2KTg6H8a7MbzDsNtNVomXXFKWfM6sVAuibfHAz
         6o7WH4E5MBcHih9lToIRePpg8WmsKGWEvqzDV9r5MMiQKR7f0dVBVPKYbaeLqoKxCo22
         datxtmCzXNQim/mLKqENIP/RSuHssz08GCnAxha1rJjpe1Pli7/d92YZjSK+iKfxt/ZB
         LrNmKd+jEBjL5ZBPA49FGkemPy+hjl1LaiDH/2tIwagK97PsJcJkyKDwQcxmU8onAmiD
         fNBQ==
X-Gm-Message-State: ACrzQf03OKuMnyfWeW0kVOimW/yhoWqsxkm72L5PgyoIuSg4MQntLYV/
        tSHqzN4NNin2muYlDwdzwEs=
X-Google-Smtp-Source: AMsMyM6VFvvFARE0TYh11hDuODd833Jng1g6K9nzB2kniIQ47qpcVhXiqYHDBu0L24rK8hkcGYdGJg==
X-Received: by 2002:a17:907:1ded:b0:78d:4606:268 with SMTP id og45-20020a1709071ded00b0078d46060268mr10090820ejc.163.1666035881499;
        Mon, 17 Oct 2022 12:44:41 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id z5-20020a17090665c500b0078d9c2c8250sm6588957ejn.84.2022.10.17.12.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:44:40 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: hevc: Fix offset adjustments
Date:   Mon, 17 Oct 2022 21:44:13 +0200
Message-Id: <20221017194413.1198301-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
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

As it turns out, current padding size check works fine in theory but it
doesn't in practice. Most probable reason are caching issues.

Let's rework reading data from bitstream using Cedrus engine instead of
CPU. That way we avoid all cache issues and make sure that we're reading
same data as Cedrus.

Fixes: e7060d9a78c2 ("media: uapi: Change data_bit_offset definition")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/sunxi/cedrus/cedrus_h265.c  | 25 ++++++++++++++-----
 .../staging/media/sunxi/cedrus/cedrus_regs.h  |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 687f87598f78..d3a29359a5a2 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -241,6 +241,18 @@ static void cedrus_h265_skip_bits(struct cedrus_dev *dev, int num)
 	}
 }
 
+static u32 cedrus_h265_show_bits(struct cedrus_dev *dev, int num)
+{
+	cedrus_write(dev, VE_DEC_H265_TRIGGER,
+		     VE_DEC_H265_TRIGGER_SHOW_BITS |
+		     VE_DEC_H265_TRIGGER_TYPE_N_BITS(num));
+
+	cedrus_wait_for(dev, VE_DEC_H265_STATUS,
+			VE_DEC_H265_STATUS_VLD_BUSY);
+
+	return cedrus_read(dev, VE_DEC_H265_BITS_READ);
+}
+
 static void cedrus_h265_write_scaling_list(struct cedrus_ctx *ctx,
 					   struct cedrus_run *run)
 {
@@ -405,7 +417,7 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	u32 num_entry_point_offsets;
 	u32 output_pic_list_index;
 	u32 pic_order_cnt[2];
-	u8 *padding;
+	u8 padding;
 	int count;
 	u32 reg;
 
@@ -519,21 +531,22 @@ static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	if (slice_params->data_byte_offset == 0)
 		return -EOPNOTSUPP;
 
-	padding = (u8 *)vb2_plane_vaddr(&run->src->vb2_buf, 0) +
-		slice_params->data_byte_offset - 1;
+	cedrus_h265_skip_bits(dev, (slice_params->data_byte_offset - 1) * 8);
+
+	padding = cedrus_h265_show_bits(dev, 8);
 
 	/* at least one bit must be set in that byte */
-	if (*padding == 0)
+	if (padding == 0)
 		return -EINVAL;
 
 	for (count = 0; count < 8; count++)
-		if (*padding & (1 << count))
+		if (padding & (1 << count))
 			break;
 
 	/* Include the one bit. */
 	count++;
 
-	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8 - count);
+	cedrus_h265_skip_bits(dev, 8 - count);
 
 	/* Bitstream parameters. */
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
index d81f7513ade0..655c05b389cf 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_regs.h
@@ -505,6 +505,8 @@
 #define VE_DEC_H265_LOW_ADDR_ENTRY_POINTS_BUF(a) \
 	SHIFT_AND_MASK_BITS(a, 7, 0)
 
+#define VE_DEC_H265_BITS_READ			(VE_ENGINE_DEC_H265 + 0xdc)
+
 #define VE_DEC_H265_SRAM_OFFSET			(VE_ENGINE_DEC_H265 + 0xe0)
 
 #define VE_DEC_H265_SRAM_OFFSET_PRED_WEIGHT_LUMA_L0	0x00
-- 
2.38.0

