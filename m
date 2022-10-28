Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F8B61146C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiJ1OYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7CC7B;
        Fri, 28 Oct 2022 07:24:29 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOIhT023801;
        Fri, 28 Oct 2022 09:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967058;
        bh=kA5Mgq119+ATbl1YiCzW7OI1HyW0bjpkWthHyg3MhQs=;
        h=From:To:CC:Subject:Date;
        b=Dk3S4EvGluN/5qR0jkrhReZVmiBo73bTkVRZz9g8a1Eeoj44zjmYfdP9YD+/87GQz
         8m77Ug+4FJdVLN36uCha6/qOcnEDaOtm6GsKI/zWbZRZQD3SbvSqxo9XCqP2oSzGNv
         OD2JEIjB9Rr0IIoc1UTOe+6edh7Q8DAAoDh9jorI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOIj2030628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:18 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:18 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfP039275;
        Fri, 28 Oct 2022 09:24:17 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 00/11] AM65x Disable Incomplete DT Nodes
Date:   Fri, 28 Oct 2022 09:24:06 -0500
Message-ID: <20221028142417.10642-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Same story as for AM64x[0], AM62x[1], and J7x[2].

Last round for AM65x, but there are some boards that I do not have
(Simatic IOT2050), so testing very welcome!

Thanks,
Andrew

[0] https://www.spinics.net/lists/arm-kernel/msg1018532.html
[1] https://www.spinics.net/lists/arm-kernel/msg1018864.html
[2] https://www.spinics.net/lists/arm-kernel/msg1019544.html

Andrew Davis (11):
  arm64: dts: ti: k3-am65: Enable UART nodes at the board level
  arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
  arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
  arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
  arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
  arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
  arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
  arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
  arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
  arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
  arm64: dts: ti: k3-am65: Enable McASP nodes at the board level

 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 101 ++--------------
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  41 +++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  18 ++-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   2 +
 .../ti/k3-am6528-iot2050-basic-common.dtsi    |   1 +
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 113 ++++--------------
 .../ti/k3-am6548-iot2050-advanced-common.dtsi |   4 -
 7 files changed, 94 insertions(+), 186 deletions(-)

-- 
2.37.3

