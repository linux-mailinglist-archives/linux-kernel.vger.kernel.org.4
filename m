Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD07F70D0F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjEWCP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjEWCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:15:13 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8A6186;
        Mon, 22 May 2023 19:14:44 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-333eb36e453so675005ab.3;
        Mon, 22 May 2023 19:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684808068; x=1687400068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zX10SJBU8S1HDBYkbi8trIiB7376uD4rHt1agT0RgVE=;
        b=OaujpSZZUqwVOx9NEQ6g6toA8bjHdiLSGCHF/k5eKXl3ABo1UGNtVSzhTAX0SAhrbE
         cgx3x15bwXRGHk0+mEh2cffCJ3is4InYof0oCRfm9gT0XYCNJhUQfjzpIy2jthkLRpWM
         eciWFP26qbGuLXO1Uf8zUXuD7HRpsvF5evYPF53lpz4UerC6UOC1F9lTMdeaI5n+EyjI
         v9sQUBd0qgmEdzEd6Mkc6G0G9WXl0LXrI9LSILXFeM7ET6fhdiX33OYpZ4kZlp1IQ5ht
         /oyvczEGS9vnKPLX8VcTgthDs3kdmKuTyRuPnCsCfTrKVKndpPrAS2GOUJHqCQig1F8k
         QFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684808068; x=1687400068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zX10SJBU8S1HDBYkbi8trIiB7376uD4rHt1agT0RgVE=;
        b=EK+67/SMp6rAyk2e9QeTg39GWeKs0ul31S+ZDQyVjbwh8lZ73WHQpuJkJKFKoVnBZc
         U+PMJ4Q1jrcHhbe1at/xJTMaolFtDMYb7/Mash84xhDsZQqqPKRBP5tCJb/CDcgD5M5v
         z3XowVEoNAbJuF5b53xmRUacws7csQfnetEtW0Kj4YI9YD77bazptsuAvrkjBIObpBxS
         CIEq4pwDwgy5pYWG6hiWA8NLiqZlbuP8jVxzm6vWG7mvQojgSMEOS6aqmUWuUfb9nGND
         no8dTEIS+ohpLJ4OVyCdp3FyYAx9OgvKbH627ksD3zLBfuczjvTguYIcZAY51OcUXP7r
         Cw+w==
X-Gm-Message-State: AC+VfDwbk94RGFUasphymmhsKdZz6hwkRh1g0h4zw5ClxHwXQ1PiaE3c
        3xzaUUYLD+0H5OcO/Vuq6TZsZHe9OGhfVA==
X-Google-Smtp-Source: ACHHUZ5F/Ce0ACQDapyA4JTnP2JZCUo2WThK1XKG2+ZKLbNVrxkTbmV0t/7CPbKthDMx/RVENWD5nQ==
X-Received: by 2002:a92:de46:0:b0:335:1ed:359b with SMTP id e6-20020a92de46000000b0033501ed359bmr8482325ilr.15.1684808068359;
        Mon, 22 May 2023 19:14:28 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id i1-20020a056638380100b00418647d4279sm2223488jav.69.2023.05.22.19.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:14:27 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: qe: Replace all non-returning strlcpy with strscpy
Date:   Tue, 23 May 2023 02:14:25 +0000
Message-ID: <20230523021425.2406309-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/soc/fsl/qe/qe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index b3c226eb5292..58746e570d14 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -524,7 +524,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	 * saved microcode information and put in the new.
 	 */
 	memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
-	strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
+	strscpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
 	qe_firmware_info.extended_modes = be64_to_cpu(firmware->extended_modes);
 	memcpy(qe_firmware_info.vtraps, firmware->vtraps,
 		sizeof(firmware->vtraps));
@@ -599,7 +599,7 @@ struct qe_firmware_info *qe_get_firmware_info(void)
 	/* Copy the data into qe_firmware_info*/
 	sprop = of_get_property(fw, "id", NULL);
 	if (sprop)
-		strlcpy(qe_firmware_info.id, sprop,
+		strscpy(qe_firmware_info.id, sprop,
 			sizeof(qe_firmware_info.id));
 
 	of_property_read_u64(fw, "extended-modes",

