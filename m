Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24E74D212
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGJJsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjGJJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:48:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ECA49C1;
        Mon, 10 Jul 2023 02:43:45 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36A9hXGd125482;
        Mon, 10 Jul 2023 04:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1688982213;
        bh=Xd9VjjS0LR5c07Nf9HdVJdilMmAEApoL2gu4g7OR5dU=;
        h=From:To:CC:Subject:Date;
        b=Dw97Mc4tKQ9l+pnb0O8u/hkt6HL7C55E2xryC5OnknPw68fQ7Vyn4Ajx4hBNnL5LI
         8l6oQIfjyQ9gzUzQfGdNGN6X3RM2RXwnl3xGb7ngP3L81n1xA0BNJ1mrkYAc83fGbF
         XbFfE0TLpKglZi879FyFBMAHrU+tPKMZykP5gY7o=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36A9hXhB101503
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jul 2023 04:43:33 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jul 2023 04:43:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jul 2023 04:43:32 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36A9hT7n031422;
        Mon, 10 Jul 2023 04:43:29 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <afd@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2 0/2] Add MAIN CPSW2G DT support for J721S2
Date:   Mon, 10 Jul 2023 15:13:26 +0530
Message-ID: <20230710094328.1359377-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

Regards,
Siddharth.

---
This series is based on linux-next tagged next-20230710.

v1:
https://lore.kernel.org/r/20230529104913.560045-1-s-vadapalli@ti.com/
Changes since v1:
- Rebase series on next-20230710.

RFC:
https://lore.kernel.org/r/20230426105718.118806-1-s-vadapalli@ti.com/
Changes since RFC:
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
2.34.1

