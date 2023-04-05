Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB946D741B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 08:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236968AbjDEGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 02:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDEGFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 02:05:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E47E173A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 23:05:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so138393689ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680674701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZDZslHVpv1fPe3PRpzIKh87QrMyXSFVpUqfqLpLtPI=;
        b=a3hXxtU4sjiC345bUT2l7WpqL7hxAiqdYQWOr5eeC+IPIB3/0Z8sRPTziEux2pEqDB
         WEwld584/jXlqJr1VtU3FGCuOvh2EReIAAK/tDEb+QCsszs/jR+mKgMUgisvkqRI8qv0
         3EvbQ59ccBO8sVBKEcG2C4Gfw3qX44+4+lLLK43x6vZJVtyPQy+4BSbni/0b2wOCDfOX
         XSIN872xhioKJhJ6OHSOoUSOmML5heEvccusDOdxIIv7s6+vTZ4QOTcYVV5eIyAVVF0Y
         O9wTrm4903CqJ0/Ypmf+1h1X6mP3Td5zOqPr2AbSImlxjjAERhFjXQtWaZ5QwtnMjGpj
         DDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680674701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZDZslHVpv1fPe3PRpzIKh87QrMyXSFVpUqfqLpLtPI=;
        b=zSGMQOFO/dWoHwzH9/z+P8KWGnMdRnxKoLIeX7dWZdMk5kvRp8He51notkxZxiKjXS
         nfij7uF+wROKggM7eUv/2rKrb0FB8waDJ2EIizFdRQrVvPA28AK8R8t4AdlTj8QDmMNe
         HliDwnEGSPwZggolHXTBWILAt9NFXbX4JnnY3tkIB8ODpG4sr2M5rN9uc7iFECMYcx9c
         vbalhcP9qNHJhV9awYJQd07FbfSTfeGQYUt43JdRHofr/6/d6B8QDLt/HGdxO64wJKvv
         0kRN+MszWCUSjrvVGFBzliaFA7gtZ89qdNHKYAM9ZjGGxJIleB/AHSkPCiF0Jf6wr+Pv
         FW1A==
X-Gm-Message-State: AAQBX9eNyb0u0j8OQFUvArKE1SkD7G/EBEdSLEtnlxVvlLkURvxhZFe1
        OIf6Iius9LX74wYzd1Q2z8BeXw==
X-Google-Smtp-Source: AKy350Z/6OPzC6zUd5cxsjf+rmcPMrZ0ktlDp1eHyn49rndyx3WLIAc4n3NUanpTRUM4D071KEsBbg==
X-Received: by 2002:a17:906:e104:b0:930:a74:52bb with SMTP id gj4-20020a170906e10400b009300a7452bbmr1316323ejb.14.1680674700983;
        Tue, 04 Apr 2023 23:05:00 -0700 (PDT)
Received: from 1.. ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id hp17-20020a1709073e1100b008cecb8f374asm6929290ejc.0.2023.04.04.23.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:05:00 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tkuw584924@gmail.com, Takahiro.Kuwano@infineon.com,
        pratyush@kernel.org, michael@walle.cc
Cc:     bacem.daassi@infineon.com, miquel.raynal@bootlin.com,
        richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] mtd: spi-nor: spansion: Rename method to cypress_nor_get_page_size
Date:   Wed,  5 Apr 2023 09:04:56 +0300
Message-Id: <20230405060456.48986-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125; i=tudor.ambarus@linaro.org; h=from:subject; bh=YI1QpFTHgUfWn38+qHO/PLUJ/J7BtLp4MGr/WWSYC1c=; b=owEBbQGS/pANAwAKAUtVT0eljRTpAcsmYgBkLQ+I8CGoy169rMX7/F99qe4tH027tR9WuAGvl eZFkMRwwcCJATMEAAEKAB0WIQQdQirKzw7IbV4d/t9LVU9HpY0U6QUCZC0PiAAKCRBLVU9HpY0U 6YPPCACGYPwWIIlNHPlo2F0iger3QoJ3idbWHFMO/8WbzdxV+dVk9lKMvUjUi7gWHFc2bdh53NE d6Ti6HYukRBZSfNX9ih9MfZ+c1lHQYwUjG0Pk2gKE1hymrRF2RplhkS/xvpJSWcZ+OKFdVCKLxN XPhq3iSoVKXXfURRq5ylqWC0DJoBfn9qNEDW42CT3/1uBTX2SswqY5xnM76i2O7U6to7d1W9Gpi xuagMv6mw7+wPISpQICJ17w+P2R+ptugGq6UhbEYDa9NRrCqsXpXO+D1ktznhRB4a8x33agvp5a HAYfVpnczM9l2QLJH6bl23HkPGN7t5dDhrh0tO8Le8NYiXyc
X-Developer-Key: i=tudor.ambarus@linaro.org; a=openpgp; fpr=280B06FD4CAAD2980C46DDDF4DB1B079AD29CF3D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The method queries SPINOR_REG_CYPRESS_CFR3V to determine the page size.
Rename the method accordingly, s/set/get.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/spansion.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index ffeede78700d..c937f0ac61de 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -302,8 +302,7 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
 }
 
 /**
- * cypress_nor_set_page_size() - Set page size which corresponds to the flash
- *                               configuration.
+ * cypress_nor_get_page_size() - Get flash page size configuration.
  * @nor:	pointer to a 'struct spi_nor'
  *
  * The BFPT table advertises a 512B or 256B page size depending on part but the
@@ -312,7 +311,7 @@ static int cypress_nor_set_addr_mode_nbytes(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int cypress_nor_set_page_size(struct spi_nor *nor)
+static int cypress_nor_get_page_size(struct spi_nor *nor)
 {
 	struct spi_mem_op op =
 		CYPRESS_NOR_RD_ANY_REG_OP(nor->params->addr_mode_nbytes,
@@ -368,7 +367,7 @@ s25fs256t_post_bfpt_fixup(struct spi_nor *nor,
 	if (nor->bouncebuf[0])
 		return -ENODEV;
 
-	return cypress_nor_set_page_size(nor);
+	return cypress_nor_get_page_size(nor);
 }
 
 static void s25fs256t_post_sfdp_fixup(struct spi_nor *nor)
@@ -407,7 +406,7 @@ s25hx_t_post_bfpt_fixup(struct spi_nor *nor,
 	/* Replace Quad Enable with volatile version */
 	nor->params->quad_enable = cypress_nor_quad_enable_volatile;
 
-	return cypress_nor_set_page_size(nor);
+	return cypress_nor_get_page_size(nor);
 }
 
 static void s25hx_t_post_sfdp_fixup(struct spi_nor *nor)
@@ -502,7 +501,7 @@ static int s28hx_t_post_bfpt_fixup(struct spi_nor *nor,
 	if (ret)
 		return ret;
 
-	return cypress_nor_set_page_size(nor);
+	return cypress_nor_get_page_size(nor);
 }
 
 static void s28hx_t_late_init(struct spi_nor *nor)
-- 
2.34.1

