Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC64D6BD34D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjCPPWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjCPPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:22:06 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39994DF70E;
        Thu, 16 Mar 2023 08:22:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32GFLiWm123330;
        Thu, 16 Mar 2023 10:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678980104;
        bh=zNv0OvDjuXZMShZUxnmp1tUY03+OQ0ZLKXZ7KiF1vbM=;
        h=From:To:CC:Subject:Date;
        b=bLc1AnF9hvjP1vbQFkmAp9FlR1TINVJckjWeeyzpmvmTMjS/ETQWgMWagqhaacXRC
         RavrmqrgNdZEYF+OyyVuyzppWP8fOfK7CXlK8F99fH1f0+X7iaL96bu7KnA+wbqrPR
         zT+MtUkzQZnE7gcFLOozBn064YMrAbjZAUePZKWc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32GFLiqD082376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 10:21:44 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 10:21:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 10:21:44 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32GFLiFa117330;
        Thu, 16 Mar 2023 10:21:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Julien Panis <jpanis@baylibre.com>,
        Bryan Brattlof <bb@ti.com>, Andrew Davis <afd@ti.com>,
        Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: [PATCH V2 0/3] arm64: dts/defconfig/binding: Add support for BeaglePlay
Date:   Thu, 16 Mar 2023 10:21:40 -0500
Message-ID: <20230316152143.2438928-1-nm@ti.com>
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

BeagleBoard.org BeaglePlay[1][2] is an easy to use, affordable open source
hardware single board computer based on the Texas Instruments AM625
SoC. Add the base support for the same.

Bootlog: https://gist.github.com/nmenon/2e7647970a4d6af05017e545ac0f8218

Changes Since v1: (major ones)
- All patches updated
- signed-off-by order fixups
- Cleanup to drop errant pre-production board vestiges
- defconfig adds SPI to get to mikrobus spi interface.

V1: https://lore.kernel.org/all/20230311111022.23717-1-nm@ti.com/

Nishanth Menon (1):
  arm64: defconfig: Enable drivers for BeaglePlay

Robert Nelson (2):
  dt-bindings: arm: ti: Add BeaglePlay
  arm64: dts: ti: Add k3-am625-beagleplay

 .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   1 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts | 757 ++++++++++++++++++
 arch/arm64/configs/defconfig                  |   8 +
 4 files changed, 767 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts

[1] https://beagleplay.org/
[2] https://git.beagleboard.org/beagleplay/beagleplay
-- 
2.40.0

