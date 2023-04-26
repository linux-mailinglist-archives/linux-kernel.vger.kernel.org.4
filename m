Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E726EF2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbjDZK5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjDZK5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:57:35 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E548199B;
        Wed, 26 Apr 2023 03:57:34 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QAvN9q098609;
        Wed, 26 Apr 2023 05:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682506643;
        bh=u5140OEklBevtCTnI9XVLuiVqcGcid5zm2W6KeVt14U=;
        h=From:To:CC:Subject:Date;
        b=i6vb6lhWdEoQQWSq41rX0vJU3JWfjPJcl6IbJlzrhLdVqsx+0GmsKkZFXUq/HUZ1Z
         XdTLpDRt+Drno4gprkfIv4O/2t8jmHa4A/aELtt/Zv2E95n5h+FM9ZSUoMq7i1Poxk
         JiVooc//06F23byiHWjOJmmPGfe26UBLZb9PGCC0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QAvNe3038244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 05:57:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 05:57:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 05:57:23 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QAvJqT001570;
        Wed, 26 Apr 2023 05:57:19 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [RFC PATCH 0/2] Add MAIN CPSW2G DT support for J721S2
Date:   Wed, 26 Apr 2023 16:27:16 +0530
Message-ID: <20230426105718.118806-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds devicetree node for MAIN CPSW2G instance of CPSW
Ethernet Switch on TI's J721S2 SoC. Also, a devicetree overlay is added
in order to enable MAIN CPSW2G in RGMII-RXID mode using the GESI
Expansion Board connected to the J7 Common-Processor-Board.

This series applies on top of the following series:
https://lore.kernel.org/r/20230331090028.8373-1-r-gunasekaran@ti.com/

Regards,
Siddharth.

---

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
  arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 83 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 69 +++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso

-- 
2.25.1

