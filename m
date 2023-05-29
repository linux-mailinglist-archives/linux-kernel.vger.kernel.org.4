Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FD8714834
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjE2Ktb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjE2Kt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:49:29 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B1EB2;
        Mon, 29 May 2023 03:49:27 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34TAnH38073334;
        Mon, 29 May 2023 05:49:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685357357;
        bh=SWOwDnSrjE89U372WkTtHW6xpvQyBQuuHmKcVC93Ea4=;
        h=From:To:CC:Subject:Date;
        b=DoFrLF5Zf16OGYF4FEUJ+c7InNX7tzKqjLNj8JRBP3SZ9nuxZfFAqmUIoVARUfExD
         2NhlZg+TWNLYiDbBiZqbbRnXHscDW82k0AglHnlOy2Bl8ZPmqHHPXPYxAa2rccqVjV
         OJ7Y7nuU2Tey1a7fehBxlj9x8wGofpCGMC6qxxxk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34TAnHIi049175
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 May 2023 05:49:17 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 May 2023 05:49:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 May 2023 05:49:17 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34TAnDnm028618;
        Mon, 29 May 2023 05:49:14 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Add MAIN CPSW2G DT support for J721S2
Date:   Mon, 29 May 2023 16:19:11 +0530
Message-ID: <20230529104913.560045-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

NOTE: This series applies on top of the following series:
https://lore.kernel.org/r/20230331090028.8373-1-r-gunasekaran@ti.com/
which in turn has been applied on linux-next tagged next-20230525.

Regards,
Siddharth.

---

RFC series at:
https://lore.kernel.org/r/20230426105718.118806-1-s-vadapalli@ti.com

Changes since RFC series:
- Add GESI board product link in the device-tree overlay file.

Kishon Vijay Abraham I (2):
  arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
  arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  | 85 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 69 +++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso

-- 
2.25.1

