Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0560E0F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiJZMkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiJZMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296125C6;
        Wed, 26 Oct 2022 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787967; x=1698323967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2/GBXC4XF/5HlvdcWRuX3hCZqwDOJ+Wb6xvf5NS+68=;
  b=UEK+cQsXKnjAqVhbEyb0Elf+vWlMxj++nVITwHqu/9l3Ak/ChG2aa5uM
   0ExIbZ+KN0ogXum5S9RZoFHkycjc9ve8hxrW9qyUo3X7fpjQk2I9bHxQm
   Lh3texvDQEOQBpgIjKMg4YkWytmQ24dPmOPSfhv6zwrYbnd4cIz1WsL+w
   BxK9+usozVucWCKrKpxgUtMKTUYN0SZO1S02q8KHNydm5J3kATyERxtdb
   sQE730z3UgFLaa2X7LgJ+tArUo/TsuwMkxqTz+UOltlLpfF7mesNyI5ht
   F5eq3hCrKsgcELSeiKOxcq0xsjbcHC1RzjRSt9hm83in+zmMOEdrq6Bmd
   w==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="197101762"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 09/11] ARM: configs: at91: sama7: add config for thermal management
Date:   Wed, 26 Oct 2022 15:41:12 +0300
Message-ID: <20221026124114.985876-10-claudiu.beznea@microchip.com>
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

Add config flags for thermal management.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index d5b748e2e772..9b98e190f405 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -128,6 +128,10 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_AT91_RESET=y
 CONFIG_POWER_RESET_AT91_SAMA5D2_SHDWC=y
 # CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_THERMAL_STATISTICS=y
+CONFIG_CPU_THERMAL=y
+CONFIG_GENERIC_ADC_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_SAMA5D4_WATCHDOG=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
-- 
2.34.1

