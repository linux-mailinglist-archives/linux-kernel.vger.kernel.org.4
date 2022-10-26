Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950CE60E0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiJZMjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiJZMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13C5D8F69;
        Wed, 26 Oct 2022 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787943; x=1698323943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zHMbls1sfBccXhUtDFJopE8ns7Bw0UkRfit7bHE2T5E=;
  b=yNH6dMLST/Wmg0wjr1wUYSrH7MvyYlVyH8dEUj7GUTu9hjl8afZ7U1nN
   Eu8dBJu/ZA+cfduWit+ANazDc0V6Uh3FmmusSz2I2GH1VdsLe0P6olTUb
   T0JTntj4unoEEgmH+6AvzI0uxU4K0b2/rluc53VAz6ICmnShYBLYePz4a
   5dXurj80wk2FxHQAE2l0jm23puM+yn+K1OqEukgq2rmGVknk3oskvigJ7
   z3BgYPNYITkpiPnazGAoXRJnQAyJZNRmYhaBSWmd3VJ8Tt6+KmHep/ovV
   6mTDPrAq5SVdBuIbMYCZBXdSixUIqV/07fgm6aPXz9kAlJKQL8bFHfVLY
   g==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="120430613"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 00/11] ARM: at91: fixes and enhancement
Date:   Wed, 26 Oct 2022 15:41:03 +0300
Message-ID: <20221026124114.985876-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series adds:
- one fix for self-refresh on SAMA7G5 (patch 1/11)
- thermal management support for SAMA7G5 (patches 2/11-9/11)
- 2 cleanup patches (patches 10/11, 11/11)

Thank you,
Claudiu Beznea

Claudiu Beznea (11):
  ARM: at91: pm: avoid soft resetting AC DLL
  ARM: dts: at91: sama7g5: add otpc node
  ARM: dts: at91: add io-channel-cells to adc node
  ARM: dts: at91: sama7g5: add cells for temperature calibration
  ARM: dts: at91: sama7g5: add temperature sensor
  ARM: dts: at91: sama7g5: add thermal zones node
  ARM: configs: at91: sama7: use make savedefconfig
  ARM: configs: at91: sama7: add config for microchip otpc
  ARM: configs: at91: sama7: add config for thermal management
  ARM: dts: at91: sama7g5: use generic name for securam
  ARM: dts: at91: sam9x60ek: remove status = "okay" for regulators

 arch/arm/boot/dts/at91-sam9x60ek.dts |  4 --
 arch/arm/boot/dts/sama7g5.dtsi       | 67 +++++++++++++++++++++++++++-
 arch/arm/configs/sama7_defconfig     |  9 +++-
 arch/arm/mach-at91/pm_suspend.S      |  7 ++-
 include/soc/at91/sama7-ddr.h         |  5 ++-
 5 files changed, 83 insertions(+), 9 deletions(-)

-- 
2.34.1

