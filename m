Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776566E5850
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 07:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjDRFFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 01:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRFFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 01:05:31 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C67A3ABB;
        Mon, 17 Apr 2023 22:05:29 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I55Mtk055702;
        Tue, 18 Apr 2023 00:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681794322;
        bh=V+nGsErWtA6jdufLk2LE0f6l1Px9r4oo4MInT9OEVHA=;
        h=From:To:CC:Subject:Date;
        b=scUA+tjtos2KbgnYNlezJ0dg6BrwkJfmgWsGK6aCtjlpVUYA3DpEHUH99KouF/YOR
         aNGEgOynPWvlyiNom1Qoxo9J6elc5pDs+T1WovZNzS+coetoJ5PjXP4egscQ8KE8/X
         A6IBhsmfA30yEcyXOdsSG0z50aWPNl/HqGJk9CQ0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I55MAQ104139
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Apr 2023 00:05:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 18
 Apr 2023 00:05:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 18 Apr 2023 00:05:21 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I55Hc5046130;
        Tue, 18 Apr 2023 00:05:18 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>, <afd@ti.com>, <bb@ti.com>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 0/2] arm64: dts: ti: k3-j7200-common-proc-board fixes
Date:   Tue, 18 Apr 2023 10:35:12 +0530
Message-ID: <20230418050514.2392717-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the pin mux configuration and enable
wkup_i2c0 at board level.

Changes since v1:
https://lore.kernel.org/all/20230414181434.2046049-1-u-kumar1@ti.com/
Pin mux:
- Fixed commit message and author

wkup_i2c:
- Removed Fixes tag in commit message
- Moved wkup_i2c in som instead of common board
- Added eeprom as child device


Keerthy (1):
  arm64: dts: ti: k3-j7200: Fix  physical address of pin

Udit Kumar (1):
  arm64: dts: ti: k3-j7200-som: Enable I2C

 .../dts/ti/k3-j7200-common-proc-board.dts     | 28 +++++++++----------
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   |  8 ++++++
 2 files changed, 22 insertions(+), 14 deletions(-)

-- 
2.34.1

