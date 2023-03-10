Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDBF6B3BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCJKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCJKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:14:20 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB7BB88;
        Fri, 10 Mar 2023 02:14:18 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32AAECol108115;
        Fri, 10 Mar 2023 04:14:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678443252;
        bh=thU5uov/bSfpJ2tqvq2wK0MJHJaTq5KtLyWMUxCIsvI=;
        h=From:To:CC:Subject:Date;
        b=bEyAvWZ6nheJ5ThMBqnGYtIMd405q2eJ52QnkhJL1zbGKIukwNiTrBuCsMLJ+BLRs
         S1pV5WAa5u9O2nzmT1Abq02TBAaxIgLLz/Y8R/Z43ovYJ57m2xGvk4uSmR7UWcCeD3
         VprmA0ox0omBSAH+Yc1ZvVIgdnqqhaIizHgVR5E8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32AAECVR063449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 04:14:12 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 04:14:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 04:14:11 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32AAE8f7024145;
        Fri, 10 Mar 2023 04:14:08 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Add device-tree support for CPSW5G on J7200 SoC
Date:   Fri, 10 Mar 2023 15:44:05 +0530
Message-ID: <20230310101407.722334-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds the device-tree nodes for CPSW5G instance of CPSW
Ethernet Switch on TI's J7200 SoC. Additionally, an overlay file is also
added to enable CPSW5G nodes in QSGMII mode with the Add-On J7 QUAD Port
Ethernet expansion QSGMII daughtercard.

Siddharth Vadapalli (2):
  arm64: dts: ti: j7200-main: Add CPSW5G nodes
  arm64: dts: ti: k3-j7200: Add overlay to enable CPSW5G ports in QSGMII
    mode

 arch/arm64/boot/dts/ti/Makefile               |   2 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     |  83 +++++++++++++++
 .../dts/ti/k3-j7200-quad-port-eth-exp.dtso    | 100 ++++++++++++++++++
 3 files changed, 185 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-quad-port-eth-exp.dtso

-- 
2.25.1

