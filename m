Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E046FFD0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjEKXOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbjEKXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:14:27 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C824D5B8C;
        Thu, 11 May 2023 16:14:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc1612940so16698031a12.2;
        Thu, 11 May 2023 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846860; x=1686438860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2VsN8atgMi+3hxkQqcD7Uds4tmy7HqZMS9gPdrmsb4=;
        b=pkuQKYnnCEdft/G+uiYZJ8uWi/2kTtLl0j2agga0xhMKI/ziSUNGiFld/hG/AgBZNZ
         BrtnO3GlFynmbRq/MkB1WyaYbe3/UAMmYb24ub6pp4SoxNtLs3bucSN5tdGxMFsrrloe
         QR0HzL7A60P6DHpR8rU53MTdtwbJJWMuATbIPgrMdwvxWSPDMzhaSn2TVhkqmuoR64Sc
         4wv+4YD9oV6RzyFf5YjeJMOBmOR/ZZKRvEyYeXkjB4do9tkvFw8Tt4ymc00m8MAyULT9
         CxrUWDTUDlQYlUa4Eq+G/afe+sNlpvUhFqvWWP78/zDbqPbM3d9AzfzuJxbU3/nS3tIz
         1thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846860; x=1686438860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2VsN8atgMi+3hxkQqcD7Uds4tmy7HqZMS9gPdrmsb4=;
        b=JkzvjXf2HowaTFlDH0Bro6D8FNNdoqBcSi9Hdr9wutIvJ/MIOut+ij/nnwHNTO7l0F
         rFUxouJZhIJcQ/9J9fdrSmh2kjP57TE7ILjyUbANUeUtzdh0j0l79JK0nQ8Jcw9gzx2T
         YiomCJWyYIyMXV7U8nNLvXyooYt6u80/YHATKXxAFCvLFktVMgZdnaSWR/GceOif9Bl0
         3xfNbuGRTf42+f0u8JmfO1LRaiZmFRI/TGt4qVx/2WiD2vog/zoF8datYZvPCo5HmiBv
         ZTa1W9Yx1alTwxUDAd6A5hKAWbdT0TrKE+1pgDZvf5yMkf7GMGgE7COqaoR6zO3TtEdY
         A5OA==
X-Gm-Message-State: AC+VfDy6n6W/xrK0d44wMkmkDDVJi5pUA78K/D3C5NNr8+S6pj0zzmdm
        ffc7/ZPKxFYR4GoA7EZP7COZExfBLF3uTQT5
X-Google-Smtp-Source: ACHHUZ77bHdjVSfvFyyDQR4vgqCTNKD6gRFnm6VieLTdykuJJ5rYhLVSHX8aHqbXliTmbb99aS9ZdQ==
X-Received: by 2002:a17:907:31c9:b0:94f:6627:22b5 with SMTP id xf9-20020a17090731c900b0094f662722b5mr19742819ejb.47.1683846859987;
        Thu, 11 May 2023 16:14:19 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c7874f2f0049cdad3080524d03.dip0.t-ipconnect.de. [2003:c7:874f:2f00:49cd:ad30:8052:4d03])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm4543023ejc.182.2023.05.11.16.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:14:19 -0700 (PDT)
From:   Boerge Struempfel <boerge.struempfel@gmail.com>
X-Google-Original-From: Boerge Struempfel <bstruempfel@ultratronik.de>
Cc:     boerge.struempfel@gmail.com, bstruempfel@ultratronik.de,
        andy.shevchenko@gmail.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] spi: spi-imx: add support for SPI_MOSI_IDLE_LOW mode bit
Date:   Fri, 12 May 2023 01:13:16 +0200
Message-Id: <20230511231317.158214-4-bstruempfel@ultratronik.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230511231317.158214-1-bstruempfel@ultratronik.de>
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
 <20230511231317.158214-1-bstruempfel@ultratronik.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the spi-imx controller pulls the mosi line high, whenever it
is idle. This behaviour can be inverted per CS by setting the
corresponding DATA_CTL bit in the config register of the controller.

Also, since the controller mode-bits have to be touched anyways, the
SPI_CPOL and SPI_CPHA are replaced by the combined SPI_MODE_X_MASK flag.

Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
---
 drivers/spi/spi-imx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 34e5f81ec431e..cb6c088706b21 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -281,6 +281,7 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 #define MX51_ECSPI_CONFIG_SCLKPOL(cs)	(1 << ((cs & 3) +  4))
 #define MX51_ECSPI_CONFIG_SBBCTRL(cs)	(1 << ((cs & 3) +  8))
 #define MX51_ECSPI_CONFIG_SSBPOL(cs)	(1 << ((cs & 3) + 12))
+#define MX51_ECSPI_CONFIG_DATACTL(cs)	(1 << ((cs & 3) + 16))
 #define MX51_ECSPI_CONFIG_SCLKCTL(cs)	(1 << ((cs & 3) + 20))
 
 #define MX51_ECSPI_INT		0x10
@@ -573,6 +574,11 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi_get_chipselect(spi, 0));
 	}
 
+	if (spi->mode & SPI_MOSI_IDLE_LOW)
+		cfg |= MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_DATACTL(spi->chip_select);
+
 	if (spi->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi_get_chipselect(spi, 0));
 	else
@@ -1743,7 +1749,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->controller->prepare_message = spi_imx_prepare_message;
 	spi_imx->controller->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->controller->slave_abort = spi_imx_slave_abort;
-	spi_imx->controller->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_NO_CS;
+	spi_imx->controller->mode_bits = SPI_MODE_X_MASK | SPI_CS_HIGH | SPI_NO_CS |
+					 SPI_MOSI_IDLE_LOW;
 
 	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx) ||
 	    is_imx53_ecspi(spi_imx))
-- 
2.25.1

