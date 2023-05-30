Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70A9716A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjE3Q7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjE3Q7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:59:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147AF184;
        Tue, 30 May 2023 09:59:10 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx19e078892;
        Tue, 30 May 2023 11:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685465941;
        bh=6M2aKEuRzEO5x6yCRaOU9u1elCkXurH6+7kxcN/ICaw=;
        h=From:To:CC:Subject:Date;
        b=qpHuNJ/q7e74dDkHn6lpvH5+UN2PyK8gdpotdItNsG+7NOSsSTQgJSl597mQrRf9Q
         KTARAiAk/2g1aP/j1v6kwy1M7G/621jjakkfzABYmrfhsReI8baINiySfxejCIykSl
         w9qdutWedxH0hzfeF0fiuyWO6ZAy1JbJP1lPyhOI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UGx16k087477
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 11:59:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 11:59:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 11:59:01 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UGx1Dd038965;
        Tue, 30 May 2023 11:59:01 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/7] arm64: dts: ti: Add additional secproxy instances
Date:   Tue, 30 May 2023 11:58:53 -0500
Message-ID: <20230530165900.47502-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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

Hi,

This series introduces secure proxies meant for usage with bootloaders
and firmware components in the SoC for all K3 SoCs. AM64x SoC is an odd
case here as the single instance of secure proxy is dual use for both
ROM and general purpose. All other SoCs have independent instances that
is used for firmware and bootloader communication.

Nitin had posted [1] to address one of the SoCs (AM62), I am cleaning
that patch a bit in this series.

Nishanth Menon (6):
  arm64: dts: ti: k3-am62a-main: Add sa3_secproxy
  arm64: dts: ti: k3-am65-mcu: Add mcu_secproxy
  arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
  arm64: dts: ti: k3-j721e-mcu: Add mcu_secproxy
  arm64: dts: ti: k3-j721s2-mcu-wakeup: Add sa3_secproxy and
    mcu_sec_proxy
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Add sa3_secproxy and
    mcu_sec_proxy

Nitin Yadav (1):
  arm64: dts: ti: k3-am62-main: Add sa3_secproxy

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi      | 15 ++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi     | 15 ++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 15 ++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 15 ++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      | 15 ++++++++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 30 +++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 30 +++++++++++++++++++
 7 files changed, 135 insertions(+)

[1] https://lore.kernel.org/all/20230519113434.1024206-3-n-yadav@ti.com/
-- 
2.40.0

