Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A36600782
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJQHRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQHRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:17:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B901E28E34
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:17:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sc25so22746642ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTbbFD+gjgbQXX2LBmI+E75ORM8YiSCeM7mZ239f43Y=;
        b=lQBlwYnkb/uHR9h9ekdJK9DprRvCAtDRMxD4XHdgh/+LheFX5ZiQJeowxeHY1jqtu5
         Zgo6DCs432kETKpjRbyjSsyxMxfK1+d3EXbz80G2/A2vZihCygUJrgQ4Ag0reQ9Pn6dm
         iZb04PG0kJ6DRHMwJhjE6g4KN+X3b6Cx5cBT4sHGoNpvAp/2Y1CM/p1pm4e2s1F7W0IX
         kVtiPbUqOoL+NVsZdbKwav58q/Zjo3MaOB9nhEwlYExZ2omR+m3q2aM4RMNVGC/Z1JK+
         Cj32qzEMvKPW0HtmnT3bV4nYdTi+/mqy4QhZ8n0WGAbaNgG1Y/zTvsTgEBfORoumBRTK
         4Qzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTbbFD+gjgbQXX2LBmI+E75ORM8YiSCeM7mZ239f43Y=;
        b=nCzn51Aj3YGpkwn8AwiCNW4V+HVnbx0xG1QOr0Es9oNRagcznHFPRyPKf4NJcJy8BV
         CHr2Za+OcKwheH4wvEQuf0tPn8OmWVYerOFD+cUSsvIPpUmCoEjYO8n52UgZAA+Wtvzw
         YWUKxKQBbc0/iuUhld5TS681FJs71pj3fs78ZPiPD22Ix12OHB4GSVK68/nhTAxUosGj
         9Dayb+9jHbAAk4XKMRizoQCOod57+G8JmN5G8j/tKNbY15pda6k/B56DRaQCGsAdXBZU
         ePQLdDUKHhT74UOddLHGgLo4OIyexPG1ACMDAwUs0DVxOiJ/sjCjFfMHd3yhUjZIq1Fp
         Q5jQ==
X-Gm-Message-State: ACrzQf126d4QnvCC0aJErE8i79mgybwuYRFr0Quc+G1tmAvthwBzpr9W
        GuKeZtxlx52vTHWmYBSVURI=
X-Google-Smtp-Source: AMsMyM7xEckB6MUGEv7KdcQvLp4KeKB6N/zcQyks1ZYNFmuz0+oN/wOyuz5R+2UjePwVD9cmhA3Vyw==
X-Received: by 2002:a17:907:d22:b0:78e:2788:51ae with SMTP id gn34-20020a1709070d2200b0078e278851aemr7297386ejc.689.1665991056156;
        Mon, 17 Oct 2022 00:17:36 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906191000b0078ae49ad169sm5766054eje.91.2022.10.17.00.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 00:17:35 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Tom Rini <trini@konsulko.com>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] nvmem: u-boot-env: add Broadcom format support
Date:   Mon, 17 Oct 2022 09:17:22 +0200
Message-Id: <20221017071722.32731-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. They
decided to store U-Boot environment data inside U-Boot partition and to
use a custom header (with "uEnv" magic and env data length).

Add support for Broadcom's specific binding and their custom format.

Ref: c34f9f5499278 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/nvmem/u-boot-env.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 8e72d1bbd649..049330660fd7 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -16,6 +16,7 @@
 enum u_boot_env_format {
 	U_BOOT_FORMAT_SINGLE,
 	U_BOOT_FORMAT_REDUNDANT,
+	U_BOOT_FORMAT_BROADCOM,
 };
 
 struct u_boot_env {
@@ -40,6 +41,13 @@ struct u_boot_env_image_redundant {
 	uint8_t data[];
 } __packed;
 
+struct u_boot_env_image_broadcom {
+	__le32 magic;
+	__le32 len;
+	__le32 crc32;
+	uint8_t data[0];
+} __packed;
+
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
 			   size_t bytes)
 {
@@ -138,6 +146,11 @@ static int u_boot_env_parse(struct u_boot_env *priv)
 		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, mark);
 		data_offset = offsetof(struct u_boot_env_image_redundant, data);
 		break;
+	case U_BOOT_FORMAT_BROADCOM:
+		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
+		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
+		break;
 	}
 	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
 	crc32_data_len = priv->mtd->size - crc32_data_offset;
@@ -202,6 +215,7 @@ static const struct of_device_id u_boot_env_of_match_table[] = {
 	{ .compatible = "u-boot,env", .data = (void *)U_BOOT_FORMAT_SINGLE, },
 	{ .compatible = "u-boot,env-redundant-bool", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
 	{ .compatible = "u-boot,env-redundant-count", .data = (void *)U_BOOT_FORMAT_REDUNDANT, },
+	{ .compatible = "brcm,env", .data = (void *)U_BOOT_FORMAT_BROADCOM, },
 	{},
 };
 
-- 
2.34.1

