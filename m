Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C6C6FFD09
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbjEKXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbjEKXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:14:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8C059DC;
        Thu, 11 May 2023 16:14:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so1524186066b.2;
        Thu, 11 May 2023 16:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683846858; x=1686438858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udZm9qn498R0QUgsicv7hzCtWJWxnPlcjDTKukuQ0jk=;
        b=KfGSMne2sEcVDFYwErj0jDzCKsz9TXKKJ164bQeaYd+FDzQ7iMPeK57IyWfgy/6mhr
         MibE3cZ9M1E992ODcvCyTI4XFgNAe6kZtdb/jB/TstA0gORlrhfWZxjJrvAXMhasKeOb
         i5wa7Aht/K+56NSJzrUwVEwKh3Gxx8x+VSDqeD9ZuHdhNjHTasUTYQe5YZ8uht4uUqfn
         SWKgjLr0/4xJC34u6UvPkBFzTyDK8mmpJnUKYXLnBC7d23NdZq+rr8bmejjfTTsroSjX
         T0+0ydAQRFJq5I5JmEHvkDOzAhi3Sb1ZUCu60Nd9k4lM2lDDoHDv2fMYUHleRF/gmOwr
         C9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683846858; x=1686438858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udZm9qn498R0QUgsicv7hzCtWJWxnPlcjDTKukuQ0jk=;
        b=aI0MwHi19jWDngRhY4h1O0gk/wxMGl3FNd9nCegZTC4rvYYmGpVAeWxr5W/APtO4Td
         BKuMkY1tF3C7G91f9W1NhtCxkqM1jZJLC1+PQ3o7OKlXdo9zADoIgNztqynJpz7QxFb7
         jjjY6RVH9W+Q7bJZPyFiREr4Z++9aptn7X/UmJT4ieSQVOM/xUxawTngnCCTSFdDX6QY
         XyTEHn/gubmTrqkJxvNSY/hTVKBYRCa9LnTUJfF5FT5P2/HICOSxcst/Vdrx5Se1b83c
         F/YFdV4pw5/GTx7y/9OWNNtjNADcjvwrhhRqnDzTAgSd3DcRHevLIwaEQmpbg6LcJzZA
         xsEA==
X-Gm-Message-State: AC+VfDzAJVjpw9Ypl8+3vHv0OJJUnzLxBFspUxaSi6ju37YKD8z9CM1T
        RXBDQctVkru+AWWCKCcGqvw=
X-Google-Smtp-Source: ACHHUZ6iAlnfrRSk7IuQeZS4b2xJfCvQTlVbacLS+oD75KUuTXUpj3la1tjGEOnfgWLl7OJOEH22xA==
X-Received: by 2002:a17:906:eec5:b0:953:4775:baa7 with SMTP id wu5-20020a170906eec500b009534775baa7mr22383355ejb.52.1683846858377;
        Thu, 11 May 2023 16:14:18 -0700 (PDT)
Received: from wslxew193.fritz.box (p200300c7874f2f0049cdad3080524d03.dip0.t-ipconnect.de. [2003:c7:874f:2f00:49cd:ad30:8052:4d03])
        by smtp.gmail.com with ESMTPSA id hx8-20020a170906846800b00965e839f56bsm4543023ejc.182.2023.05.11.16.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:14:17 -0700 (PDT)
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
Subject: [PATCH v2 2/4] spi: add SPI_MOSI_IDLE_LOW mode bit
Date:   Fri, 12 May 2023 01:13:15 +0200
Message-Id: <20230511231317.158214-3-bstruempfel@ultratronik.de>
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

Some spi controller switch the mosi line to high, whenever they are
idle. This may not be desired in all use cases. For example neopixel
leds can get confused and flicker due to misinterpreting the idle state.
Therefore, we introduce a new spi-mode bit, with which the idle behaviour
can be overwritten on a per device basis.

Signed-off-by: Boerge Struempfel <bstruempfel@ultratronik.de>
---
 drivers/spi/spi.c            | 2 ++
 include/uapi/linux/spi/spi.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9291b2a0e8871..3ad538b317a84 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2260,6 +2260,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_property_read_bool(nc, "spi-mosi-idle-low"))
+		spi->mode |= SPI_MOSI_IDLE_LOW;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 9d5f580597039..ca56e477d1619 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,6 +28,7 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 #define	SPI_RX_CPHA_FLIP	_BITUL(16)	/* flip CPHA on Rx only xfer */
+#define SPI_MOSI_IDLE_LOW	_BITUL(17)	/* leave mosi line low when idle */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -37,6 +38,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(18) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.25.1

