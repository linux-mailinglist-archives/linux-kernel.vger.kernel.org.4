Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4596B6B3A7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCJJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjCJJbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:14 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238E5F506;
        Fri, 10 Mar 2023 01:28:36 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32A9S8kB098753;
        Fri, 10 Mar 2023 03:28:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678440488;
        bh=+JfeQWty8/QVJkWAFiie12dn+8/e+hGKbpThjIMMLd0=;
        h=From:To:CC:Subject:Date;
        b=RVo4nniDT+iWg7r1LkjSrzvxmqPhBYvM5ZENL11GzcIv1nHNMehHgty6cyCY7pQhL
         JYBWK2pFsXD6tASj2bv1b8E65qLZiotsEnbHY3wKWSeYjCNkN3PMqIygLdTHLUOxz3
         /UHWUD58rXjNslGFJ7AQKNFPd/h3FVv8g9y6ncYg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32A9S85W031039
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Mar 2023 03:28:08 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 10
 Mar 2023 03:28:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 10 Mar 2023 03:28:08 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32A9S4LG022476;
        Fri, 10 Mar 2023 03:28:05 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Add device-tree support for CPSW9G on J721E SoC
Date:   Fri, 10 Mar 2023 14:58:02 +0530
Message-ID: <20230310092804.692303-1-s-vadapalli@ti.com>
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

This series adds the device-tree nodes for CPSW9G instance of CPSW
Ethernet Switch on TI's J721E SoC. Additionally, an overlay file is also
added to enable CPSW9G nodes in QSGMII mode with the Add-On J7 QUAD Port
Ethernet expansion QSGMII daughtercard.

Siddharth Vadapalli (2):
  arm64: dts: ti: k3-j721e: Add CPSW9G nodes
  arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports in QSGMII
    mode

 arch/arm64/boot/dts/ti/Makefile               |   4 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 107 +++++++++++++
 .../dts/ti/k3-j721e-quad-port-eth-exp.dtso    | 148 ++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |   1 +
 4 files changed, 260 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-quad-port-eth-exp.dtso

-- 
2.25.1

