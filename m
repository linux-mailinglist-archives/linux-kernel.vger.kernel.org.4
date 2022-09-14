Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704FB5B853A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiINJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiINJjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:39:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4E13E2A;
        Wed, 14 Sep 2022 02:39:38 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dHpr113504;
        Wed, 14 Sep 2022 04:39:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148357;
        bh=tz0esUiBw+fs/fGqdL2ageAlRbnOyx30aKyyFKerigw=;
        h=From:To:CC:Subject:Date;
        b=xifIzj383SPv5SEpIQjUCw2N57wL2PO3BGe20ygtDWWG84GNUNeU05TdKGHkYOs4m
         V41PjNlJxbuP0h5QA4Gowr3t4QjQJYD2u5U2e0i7r9ggSLakRCr2pZjSQun7wkwcXo
         4fMsrLC+c6OSJNZ6NeArkub1i9QowlExZu++qY9g=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9dGVV119160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:16 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHD111966;
        Wed, 14 Sep 2022 04:39:12 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/6] Add support for J721e CPSW9G and SGMII mode
Date:   Wed, 14 Sep 2022 15:09:05 +0530
Message-ID: <20220914093911.187764-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for J721e CPSW9G.

Add support for SGMII mode in phy-gmii-sel driver for CPSW5G of J7200 and
CPSW9G of J721e.

Add SGMII support in phy-j721e-wiz driver for J721E_WIZ_16G.

Add support for PCIe + SGMII multilink configuration in phy-cadence-sierra
driver.

Siddharth Vadapalli (5):
  dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J721e
  phy: ti: gmii-sel: Add support for configuring CPSW5G ports in SGMII
    mode
  phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J721e
  phy: ti: gmii-sel: Enable SGMII mode configuration for J721E
  phy: ti: phy-j721e-wiz: Add SGMII support in wiz driver for J721E

Swapnil Jakhade (1):
  phy: cadence: Sierra: Add PCIe + SGMII PHY multilink configuration

 .../bindings/phy/ti,phy-gmii-sel.yaml         |  52 ++++++-
 drivers/phy/cadence/phy-cadence-sierra.c      | 141 +++++++++++++++++-
 drivers/phy/ti/phy-gmii-sel.c                 |  57 +++++--
 drivers/phy/ti/phy-j721e-wiz.c                |   1 +
 4 files changed, 232 insertions(+), 19 deletions(-)

-- 
2.25.1

