Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A89B65B9FC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 05:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjACEVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 23:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 23:21:33 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0796B11C;
        Mon,  2 Jan 2023 20:21:30 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3034LGng005082;
        Mon, 2 Jan 2023 22:21:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672719676;
        bh=Tq+tgtZfIocYjd51t7cUIhRjhoMWNhRwFk05ySa7LTU=;
        h=From:To:CC:Subject:Date;
        b=UsoDrLCjUTJJ9338jXLTOO+an2Dy2SeRUKr998z5oY3be6FXIbLcOoGSwWHTWCPLN
         4BeXLE2Ih8oWc78w5w/OBIdy+6IF1ZkzQrgcq50LDz7yfhf3dAxcAIOchjA5qhsqk3
         iEJ3meT1wHgx+TsLJlG2EYv+bcjGd6RyTVqgSZV8=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3034LG0x025917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Jan 2023 22:21:16 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 2
 Jan 2023 22:21:16 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 2 Jan 2023 22:21:16 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3034LDwr084970;
        Mon, 2 Jan 2023 22:21:13 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bb@ti.com>
Subject: [PATCH 0/4] arm64: dts: ti: Enable misc peripherals
Date:   Tue, 3 Jan 2023 09:51:06 +0530
Message-ID: <20230103042110.1092122-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables few additional peripherals such as DMA, ethernet,
PWMs, GPIOs etc  on AM62A SoC and AM62A7 SK EVM.

Vignesh Raghavendra (4):
  arm64: dts: ti: k3-am62a-mcu: Add MCU domain peripherals
  arm64: dts: ti: k3-am62a-main: Add more peripheral nodes
  arm64: dts: ti: k3-am62a7-sk: Enable  ethernet port
  arm64: dts: ti: k3-am62a7-sk: Enable USB1 node

 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 365 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi  |  51 +++
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts   |  70 +++++
 3 files changed, 486 insertions(+)

-- 
2.39.0

