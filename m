Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AAB6D175D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjCaG0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaG0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:26:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13139CDC8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 23:25:42 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32V6POpY019731;
        Fri, 31 Mar 2023 01:25:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680243924;
        bh=Ih2APHCMmMtKMPtRxTR0bLiEUuVP6ePuzNO3rxO44Qo=;
        h=From:To:CC:Subject:Date;
        b=JSokDDWSezQ5sfuB1bRK/3JxvrXfxZeqCt1XCmIAWkziy4n1tyV87cruHg9lQN1H6
         HgmkaK0WBR6X5MAk4D8+eAFWl1keyn+ILU6Y36s20BYlnoEnPZ2nCaqB/bvbOOqsPa
         o31Bd1PoW0jIwxKgR522vRYJUATFMVvXJb6HFkJw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32V6POW7074156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Mar 2023 01:25:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 31
 Mar 2023 01:25:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 31 Mar 2023 01:25:24 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32V6PLv9027504;
        Fri, 31 Mar 2023 01:25:22 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] PHY-GMII-SEL: Add support for J784S4 SoC
Date:   Fri, 31 Mar 2023 11:55:19 +0530
Message-ID: <20230331062521.529005-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series TI's J784S4 SoC. A new compatible is added for the J784S4 SoC,
with QSGMII mode enabled. Also, the CPSW9G instance of J784S4 SoC supports
USXGMII mode. Thus, add support to configure USXGMII mode.

Note:
This series is based on top of the following series:
https://lore.kernel.org/r/20230309063514.398705-1-s-vadapalli@ti.com/

The patch corresponding to the device-tree bindings for the compatible
"ti,j784s4-cpsw9g-phy-gmii-sel" is posted at:
https://lore.kernel.org/r/20230315092408.1722114-1-s-vadapalli@ti.com
Since the above patch has received an Acked-by from Krzysztof Kozlowski,
I am posting this series using the compatible.

Regards,
Siddharth.

Siddharth Vadapalli (2):
  phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J784S4
  phy: ti: gmii-sel: Enable USXGMII mode for J784S4

 drivers/phy/ti/phy-gmii-sel.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

-- 
2.25.1

