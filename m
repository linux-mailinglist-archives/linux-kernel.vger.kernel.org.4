Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21F56034C2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiJRVQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiJRVP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:59 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFE1A0336;
        Tue, 18 Oct 2022 14:15:55 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFYMV079148;
        Tue, 18 Oct 2022 16:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127734;
        bh=ynh9GaLBqPQbclUIR+Esf/ZvXo6qcycSdKYSXZvKn6c=;
        h=From:To:CC:Subject:Date;
        b=McQSZZlG3hj+N3DaDLKpbLZdnUSFYnwaFD0j0BjxitPJpSk6XBan5QgRGZnsR2NsF
         Kwyh/vaAvuMmc6ioe6SLv64ymyji+x2az8N5Wq2ixMJss5ILCTyQqhu/1qkaH2/Poy
         GzU2bJibdJm+uA02yIj7aKc0gH0Wfbpj11+erCmE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFYxN005798
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:34 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:34 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoA014456;
        Tue, 18 Oct 2022 16:15:33 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 00/10] AM62x Disable Incomplete DT Nodes
Date:   Tue, 18 Oct 2022 16:15:23 -0500
Message-ID: <20221018211533.21335-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Same story as for AM64x[0], this time for AM62x. If there
are no objections here then the J7x platforms are next.

Thanks,
Andrew

[0] https://www.spinics.net/lists/arm-kernel/msg1018532.html

Andrew Davis (10):
  arm64: dts: ti: k3-am62: Enable UART nodes at the board level
  arm64: dts: ti: k3-am62: Enable I2C nodes at the board level
  arm64: dts: ti: k3-am62: Enable SPI nodes at the board level
  arm64: dts: ti: k3-am62: Enable EPWM nodes at the board level
  arm64: dts: ti: k3-am62: Enable ECAP nodes at the board level
  arm64: dts: ti: k3-am62: MDIO pinmux should belong to the MDIO node
  arm64: dts: ti: k3-am62: Enable MDIO nodes at the board level
  arm64: dts: ti: k3-am62: Enable MCAN nodes at the board level
  arm64: dts: ti: k3-am62: Enable SDHCI nodes at the board level
  arm64: dts: ti: k3-am62: Enable OSPI nodes at the board level

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 26 +++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  4 ++
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  2 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts     | 81 +++-------------------
 4 files changed, 43 insertions(+), 70 deletions(-)

-- 
2.37.3

