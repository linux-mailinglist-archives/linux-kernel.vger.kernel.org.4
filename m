Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6B96B1B95
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjCIGf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCIGfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:35:25 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC0C7B498
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:35:23 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3296ZIeA062413;
        Thu, 9 Mar 2023 00:35:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678343718;
        bh=pTS0Z0bVGXfBwfRdmj4/b8pbbzCAzCerv52GJM2QR3w=;
        h=From:To:CC:Subject:Date;
        b=RfGmRZLx+5l8TjqiVXEKYM1cO53y7V8+IrahTrNsP0rP3VTHSmULkmx24QdFNdm6u
         aReePi1NNu8THXaE4b1HPf3Q2xrRPCJ9nzuZ5iYZuyVke9rWCVWteXdi4K4MilXmAn
         DXtC8srbhsvfvhjdafvW/wHR0hg/JwIYFX9DISuQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3296ZIgI110758
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 00:35:18 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 00:35:17 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 00:35:18 -0600
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3296ZEQn099087;
        Thu, 9 Mar 2023 00:35:15 -0600
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>, <rogerq@kernel.org>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/3] PHY-GMII-SEL: Add support for SGMII mode
Date:   Thu, 9 Mar 2023 12:05:11 +0530
Message-ID: <20230309063514.398705-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
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

Hello,

This series adds support to configure the CPSW MAC's PHY in SGMII mode.
Also, SGMII mode is enabled for TI's J7200 and J721E SoCs.

Changes from v1:
1. Add "break" statement within "case PHY_INTERFACE_MODE_SGMII".
2. Add newline before "default" case.
3. Update commit message of patch 1/3 to follow the existing convention.

v1:
https://lore.kernel.org/r/20230309062237.389444-1-s-vadapalli@ti.com/

Siddharth Vadapalli (3):
  phy: ti: gmii-sel: Add support for SGMII mode
  phy: ti: gmii-sel: Enable SGMII mode for J7200
  phy: ti: gmii-sel: Enable SGMII mode for J721E

 drivers/phy/ti/phy-gmii-sel.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.25.1

