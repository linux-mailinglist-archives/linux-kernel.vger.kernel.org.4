Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5102C6F068C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjD0NXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbjD0NXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:23:35 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240C94491;
        Thu, 27 Apr 2023 06:23:34 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33RDN65H009991;
        Thu, 27 Apr 2023 08:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682601786;
        bh=qx+2rWanAbJz4cU/ncaGhAX2oXK569XRnUuZHSp51hk=;
        h=From:To:CC:Subject:Date;
        b=UUmDIT+QDTHkYUEBzSCcNd0uAXMqJlxvXGfqsfODKLyIlrgVYeixLmHgvD+OKf5/t
         m5T2YjZ9fV2irsv5EfgzoOpeQuAgXWPFEONwQ4+g/hYhk8oF9DorlZmvVZXaCZSi7J
         i6YPRnZBVYyjY9HxonCmb9lq3ry6s5eovqX4rqKM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33RDN6wo021534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Apr 2023 08:23:06 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Apr 2023 08:23:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Apr 2023 08:23:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33RDN5kR040771;
        Thu, 27 Apr 2023 08:23:05 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: [PATCH v3 0/2] arm64: dts: ti: Enable OLDI display on AM654 EVM
Date:   Thu, 27 Apr 2023 18:53:02 +0530
Message-ID: <20230427132304.6857-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
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

V1: https://lore.kernel.org/linux-devicetree/20230425051235.15533-1-a-bhatia1@ti.com/
V2: https://lore.kernel.org/linux-devicetree/20230426060612.19271-1-a-bhatia1@ti.com/

Aradhya Bhatia (1):
  arm64: defconfig: Enable PWM drivers for TI ECAP and EHRPWM

Jyri Sarha (1):
  arm64: dts: ti: am65x: Add Rocktech OLDI panel DT overlay

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 ...am654-base-board-rocktech-rk101-panel.dtso | 70 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 +
 3 files changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-base-board-rocktech-rk101-panel.dtso

-- 
2.39.1

