Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94719664D97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjAJUn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:43:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2E4C726
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:43:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so31739461ejm.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tBn6a5mqROf2ux/RUqvtiPAixck8rWx7TqClj/rZ30M=;
        b=GnJ9e51qhoXRcsPOK9yPQJirurHSYfA5N+CC3NI/ykAc2mDfNyevCeAY3UYdKP3RAl
         xn1a1LIKVvpDRkLybGBSKcbKjFoa87tCliab4jBFMagkYQLd7gcAbO/poJh1ukB+4LgN
         SgbQwqIfWfUlQ6igs46/dpS88Doxq4SyRTF8wHfB3aJsglWTx185wzI8oW9CkIKYMrNF
         epNhLNUNNA76m7GGrQWpQuG0kWEMycTiK1qcQt730zVmEZM62MucUhJMfDfZI/Kq5Dp4
         cZ6Q+s01FMHdD+/pJqiMCPYi8zC1dpevWegKY4kiD/q1AwHAWP8v/e3QygVSVmI0dpeM
         Jxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBn6a5mqROf2ux/RUqvtiPAixck8rWx7TqClj/rZ30M=;
        b=4r1/kivHYts8d2zX3msZ6IoL6+0r3ndEWf0bPCPXhMlDsIr/ZA7fEYHeRuB7nhgma1
         KbrvveB2l3QgGOtQtNHx1PAu96IwoFBfq2nYiY8thKOcLj0XCqA4GSLMZUm87aeAUtem
         8Mx/2I7eDfRGM2scozODtyNXs6Dr19mlh38d7gv5cOFKyn++8/gTzAAi0SifU7Nn8wev
         ZCB1XtKp6skYYeKAxjrgjIHnN9U21cYWVHpTxgzxEld2iXyyBPOQ3x+eAoQQQeTO32NX
         +7Q3HHnAvoVQUQqy121W0gsX+gmVwFdsKHU5TgKQjkZIkSx5E+th7mDTTwSm5RxYktsV
         ZCEw==
X-Gm-Message-State: AFqh2kqTb7vBGlaiVXQrutu9vPQAw/5Kc93xB/aD1RPiQzPlgwvDEZU+
        2s7f16lzpvIebjX6IFPQVD0=
X-Google-Smtp-Source: AMrXdXtR9++mivVh/HZDLLnDFezbpT4CJqhm6NCLX8+E443pWyNVQOb6GsBHruUCUKgIQcduR5yXnw==
X-Received: by 2002:a17:907:c68a:b0:84c:e9c4:5751 with SMTP id ue10-20020a170907c68a00b0084ce9c45751mr26644373ejc.74.1673383436031;
        Tue, 10 Jan 2023 12:43:56 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id lj1-20020a170906f9c100b0078d22b0bcf2sm5316479ejb.168.2023.01.10.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:43:55 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2] nvmem: core: fix nvmem_layout_get_match_data()
Date:   Tue, 10 Jan 2023 21:43:45 +0100
Message-Id: <20230110204345.7266-1-zajec5@gmail.com>
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

This function was trying to match wrong OF node (parent device's)
against an of_match_table. It was always returning NULL.

Make it match layout's OF node against layout's of_match_table.

Note: __maybe_unused is needed to avoid:
warning: variable 'layout_np' set but not used [-Wunused-but-set-variable]
(of_match_node() is no-op without CONFIG_OF).

Fixes: f5709a684a0a ("nvmem: core: introduce NVMEM layouts")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Michael Walle <michael@walle.cc>
---
 drivers/nvmem/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d112bb1328c1..d3be50ed2d0b 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -824,9 +824,11 @@ EXPORT_SYMBOL_GPL(of_nvmem_layout_get_container);
 const void *nvmem_layout_get_match_data(struct nvmem_device *nvmem,
 					struct nvmem_layout *layout)
 {
+	struct device_node __maybe_unused *layout_np;
 	const struct of_device_id *match;
 
-	match = of_match_node(layout->of_match_table, nvmem->dev.of_node);
+	layout_np = of_nvmem_layout_get_container(nvmem);
+	match = of_match_node(layout->of_match_table, layout_np);
 
 	return match ? match->data : NULL;
 }
-- 
2.34.1

