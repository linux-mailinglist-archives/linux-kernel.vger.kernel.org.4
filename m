Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417AC6E1D31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDNHdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjDNHdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8375D4C06;
        Fri, 14 Apr 2023 00:33:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYwA112596;
        Fri, 14 Apr 2023 02:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457614;
        bh=9Q11r37EsPWYcg2UDZouznm3MTN7XDRbMQ6G0q5YIfk=;
        h=From:To:CC:Subject:Date;
        b=B0ico70ZDGGM7KARVcD9VlYUjH+IRYs8g7EidB99LHdo0qV9YCoQ3Fv0S6Y9qRuLm
         ASENdsaKhlraqD900+ngajg8ItACUgbWdZn/5ND6oDAnVvO2ootiTCZhBX3r5kBPl/
         eV/6Xa2pJjDa1pSYIIQ2YlRQE6J20iOWiDIWO2Js=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XYWq091056
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:34 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYEA020515;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/10] arm64: dts: ti: k3-am64: Add missing properties used in u-boot
Date:   Fri, 14 Apr 2023 02:33:18 -0500
Message-ID: <20230414073328.381336-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while attempting to cleanup u-boot, I noticed that u-boot had some
additional nodes that were'nt in kernel.org, and this makes syncing the
kernel.org patches back to u-boot hard.

So, sync the same.

Bootlogs: (SK and evm)
https://gist.github.com/nmenon/6b09f55251225d3f3cce076c32a33bba

Baseline: next-20230413 (will be great if we can get into rc2 - will
make u-boot sync easier)

Nishanth Menon (10):
  arm64: dts: ti: k3-am64: Add general purpose timers
  arm64: dts: ti: k3-am642-sk: Fix mmc1 pinmux
  arm64: dts: ti: k3-am642-sk: Enable main_i2c0 and eeprom
  arm64: dts: ti: k3-am642-sk: Describe main_uart1 pins
  arm64: dts: ti: k3-am642-sk: Rename regulator node name
  arm64: dts: ti: k3-am642-evm: Enable main_i2c0 and eeprom
  arm64: dts: ti: k3-am642-evm: Describe main_uart1 pins
  arm64: dts: ti: k3-am642-evm: Rename regulator node name
  arm64: dts: ti: k3-am642-evm: Add VTT GPIO regulator for DDR
  arm64: dts: ti: k3-am642-sk|evm: Drop bootargs, add aliases

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 144 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  45 +++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  16 ---
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  76 ++++++++++--
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   |  69 ++++++++---
 5 files changed, 313 insertions(+), 37 deletions(-)

-- 
2.40.0

