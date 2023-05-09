Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF526FC3CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjEIKY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjEIKYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:24:22 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFECD879;
        Tue,  9 May 2023 03:24:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 349ANttG084602;
        Tue, 9 May 2023 05:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683627835;
        bh=unbZXmZdZ4FxgAl4cAtJiqnqRNuT+W4LkuEijgjP5+Y=;
        h=From:To:CC:Subject:Date;
        b=AScIXsLbiLSsZ3xHlnhcJ8uaj9RrnJsHUXde3lhBZ0QrFLOSqZIrtb6+5UnodyYrl
         IFwKCAmPuVuT2KmorkVgahZmfyM7pzUHxLXnCkrJXI40dioAMp1jX+kD7aBIA9pw3S
         Z77AewWICzFsE0EwM3qLqTPC8yP9yHvFufYO0tkM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 349ANt6M021905
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 May 2023 05:23:55 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 May 2023 05:23:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 May 2023 05:23:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 349ANs3b061667;
        Tue, 9 May 2023 05:23:55 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v4 0/2] arm64: dts: ti: Enable OLDI display on AM654 EVM
Date:   Tue, 9 May 2023 15:53:52 +0530
Message-ID: <20230509102354.10116-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.40.1
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

Hello,

This patch series adds support for the Rocktech RK101II01D-CT OLDI
panel, on top of AM654 base-board EVM.

Moreover, it enables support for TI ECAP and TI EHRPWM drivers to
provide SW control of backlight.

While the AM654 GP EVM also consists of usb/pcie expansion board, I have
only added support for base-board + OLDI panel as I do not have the
required hardware.

The first patch of this series, was picked up from TI's public tree[1]
based on 5.10 LTS kernel.

[1]:
https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dts?h=ti-linux-5.10.y

Change Log:
V1 -> V2:
  - Renamed the panel overlay file.
  - Added am654-gp-evm build option in DT Makefile.
  - Changes suggested by Tomi Valkeinen and Nishanth Menon.

V2 -> V3:
  - Added the product link in the overlay file.

V3 -> V4:
  - Added AM654 LCD EVM links for better information.

V1: https://lore.kernel.org/linux-devicetree/20230425051235.15533-1-a-bhatia1@ti.com/
V2: https://lore.kernel.org/linux-devicetree/20230426060612.19271-1-a-bhatia1@ti.com/
V3:  i. https://lore.kernel.org/all/20230427132304.6857-1-a-bhatia1@ti.com/
    ii. https://lore.kernel.org/all/20230427132436.7418-1-a-bhatia1@ti.com/

Aradhya Bhatia (1):
  arm64: defconfig: Enable PWM drivers for TI ECAP and EHRPWM

Jyri Sarha (1):
  arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 ...am654-base-board-rocktech-rk101-panel.dtso | 71 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 +
 3 files changed, 75 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso

-- 
2.40.1

