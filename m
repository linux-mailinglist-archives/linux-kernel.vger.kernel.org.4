Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606FB64A8F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbiLLU6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiLLU6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:58:40 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4817059
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:58:39 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id c184so12617833vsc.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKlgFL8VmX9JU/WhcQ2Bam3+gwPcuhRUKzrP4zlGwcY=;
        b=EVo9AbwGxKkXRl06t/oyFzhiEDDvPDnjq7bEhoFC1UvLE0eXBWduNjcjXmcqtiegsY
         EBPuaplnzrCjVPtHqECt2THPOz7rNFlF+79lSwX28DLvohCdhmeElI87scJfZ0M6m3hr
         ZsKD9BcFiJa10Z1pr2SqZxBwOZm70dNifd69pnluYqVLjUzWTuxvMigJKkGDwl3Cs8fk
         dopNQeCG6NXQpPSGxqqmbunqp8834/2ZhD+hvarvNqFTevyHxZyLlBMPVF4y9vakAFMa
         XXf//5zP3HDv4wMnDhw3a26mD2tuGowvQdymrwQJ9RTvMBUfrxycx3fM89bAYVRnvjNa
         U00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKlgFL8VmX9JU/WhcQ2Bam3+gwPcuhRUKzrP4zlGwcY=;
        b=lCgmmnuQmbJTZduKmbvUVAq+W6I5ECuPWyo4BNtPfYYHYuoo7syNt6YhaQL8c8PfX8
         UhYL+begvdNtYiWnfx0AxpQQYkn/8herf6XGD7akn5TQ/B9FSmNCbN4DLm/Av+ssMNlW
         gZ+RxQ2SioqSgvUshXumS3Z0XL73l/Saitwno9NDq4Y7W+VYLVX+M5+nnGwfqv9E4dmN
         graiaAla6hGFTyyt2NDQKhvwo7p4vHoV7QxHDzQwt8Km6ic1xu3aldZHDjd9Q0vCLtAy
         mOWu6jHOn0O8p0RzsyvGC5zeT6KsHkpy3KCLPJuldh67eoaXb1AdVwHp509N8uptmJRV
         6Krg==
X-Gm-Message-State: ANoB5pmnaoE73wkiA3+dQ3BH24i+1YBZ/A782W0poEaOdWDNyvg8uazd
        /TlWibKBplzNUrjkgzP0wRjM4WgCSm6XHA==
X-Google-Smtp-Source: AA0mqf6/0ApvNu41NVWvF/ffwT4hdrpuOy+lQ28zsg8f4BPqaKmJsjBszYafsqiUpl/YDVFbk1NVJw==
X-Received: by 2002:a05:6102:11f8:b0:3b2:f921:1761 with SMTP id e24-20020a05610211f800b003b2f9211761mr1291476vsg.1.1670878718615;
        Mon, 12 Dec 2022 12:58:38 -0800 (PST)
Received: from lenovo-y720.. (097-101-018-014.res.spectrum.com. [97.101.18.14])
        by smtp.gmail.com with ESMTPSA id f5-20020a9f2bc5000000b00419b8ef0435sm1489004uaj.25.2022.12.12.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:58:38 -0800 (PST)
From:   Moises Cardona <moisesmcardona@gmail.com>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        Moises Cardona <moisesmcardona@gmail.com>
Subject: [PATCH] Add HP Stream 8 to bytcr_rt5640.c
Date:   Mon, 12 Dec 2022 15:58:35 -0500
Message-Id: <20221212205835.994911-1-moisesmcardona@gmail.com>
X-Mailer: git-send-email 2.37.2
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

The HP Stream 8 tablet is identical to the HP Stream 7 in terms of the PCB,
with the exception of the added SIM Card Slot. 
Therefore, I'm submitting this patch which properly initializes the audio 
and enables the headphone jack to work, just like it does in the 
HP Stream 7.

Signed-off-by: Moises Cardona <moisesmcardona@gmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index fb9d9e271845..1d964b1ceff4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -796,6 +796,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{	/* HP Stream 8 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "HP Stream 8 Tablet"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{	/* I.T.Works TW891 */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "To be filled by O.E.M."),
-- 
2.37.2

