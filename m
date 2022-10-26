Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83860E0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbiJZMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiJZMj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C36BEC1F5;
        Wed, 26 Oct 2022 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787961; x=1698323961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iVoxQBlwpKU5kYBJRx5jbkUjy572KppbIP2UDBEugq8=;
  b=ZQBYrjZOvLmEaG72k/w4C2Mg3g1GXjFmWxiSWXPCfP969wDBSu/FZaMf
   7IsEmY8eDHbFkaA9wy8IIzwvUYFXsV/rir2Fr2h3zjzRDLsZwx5QqZhCD
   cDmOl4G0yYI6L37ox7BykMzcWjAr4Ia0LivOia++H4SB5XOzQlz3Np+ON
   AGWiIA1TQYoHtcaGZ2BY8ZN8Bk9KG2PkV12kCwipAZJgJiq+NRdvB1WzC
   oNtr5kqwgFEYr6JsWNVq9XJGed2csSvi65trH63Jiqa14LoFW7wBRmq5v
   xvCqLtWQzbfMmVTi5z1dg93sVwmNbG0jy6yzeAqi5Nx31yVdLQtj+cNE7
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197101717"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:21 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:18 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 07/11] ARM: configs: at91: sama7: use make savedefconfig
Date:   Wed, 26 Oct 2022 15:41:10 +0300
Message-ID: <20221026124114.985876-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221026124114.985876-1-claudiu.beznea@microchip.com>
References: <20221026124114.985876-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use make savedefconfig on sama7_defconfig.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 8f28c9d443f0..dcd2705b7c97 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -211,13 +211,13 @@ CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_LSM="N"
 CONFIG_CRYPTO_AUTHENC=y
-CONFIG_CRYPTO_GCM=y
+CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_CBC=y
 CONFIG_CRYPTO_CFB=y
 CONFIG_CRYPTO_OFB=y
 CONFIG_CRYPTO_XTS=y
+CONFIG_CRYPTO_GCM=y
 CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_DES=y
 CONFIG_CRYPTO_USER_API_HASH=m
 CONFIG_CRYPTO_USER_API_SKCIPHER=m
 CONFIG_CRYPTO_DEV_ATMEL_AES=y
-- 
2.34.1

