Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CDE6F6751
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjEDI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEDI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:26:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB25FCA;
        Thu,  4 May 2023 01:19:40 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34483Apb087280;
        Thu, 4 May 2023 03:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683187390;
        bh=I2X0KPKJM3uvZgSX8cudKavkcP3ExFOXXsCHtKa23n0=;
        h=From:To:CC:Subject:Date;
        b=YuYLpGU7YxCKYYavi/f36ShfTMR+pQuif0vVbm25IugnOCQSYqv/iWPf2wed6GQ6n
         P4RLF8DQ7fxW+JtVGMhMzUddOijl4i/xY3cKeFWEsz2nDA64Rskj0XpGx3wzSmPoWt
         w6dA59sgGAEkH3roFe5YTRot6XXcrIhutpqnnTZY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34483Ar6096497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 03:03:10 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 03:03:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 03:03:10 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344836f1043802;
        Thu, 4 May 2023 03:03:06 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Dhruva Gole <d-gole@ti.com>,
        Udit Kumar <u-kumar1@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Subject: [PATCH v3 0/2] arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashes
Date:   Thu, 4 May 2023 13:33:03 +0530
Message-ID: <20230504080305.38986-1-a-nandan@ti.com>
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

From: Vaishnav Achath <vaishnav.a@ti.com>

J784S4 has S28HS512T OSPI flash connected to OSPI0 and MT25QU512A QSPI
flash connected to OSPI1, enable support for the same.

Changes in v3:
- Split the SoC dtsi changes and EVM dts changes into separate patches
- Added QSPI flash node and partition information in EVM dts
- Removed address-cells = <1>; and size-cells = <1>; in OSPI0 flash node
- Add flash partition information for OSPI flash.

Changes in v2:
- Fixed address 0x0 to 0x00
- Fixed dtbs_check errors (removed syscon and created simple bus)
- Fixed whitespace error

Apurva Nandan (2):
  arm64: dts: ti: k3-j784s4-mcu-wakeup: Add FSS OSPI0 and FSS OSPI1
  arm64: dts: ti: k3-j784s4-evm: Add support for OSPI and QSPI flashes

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 158 ++++++++++++++++++
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     |  41 +++++
 2 files changed, 199 insertions(+)

-- 
2.17.1

