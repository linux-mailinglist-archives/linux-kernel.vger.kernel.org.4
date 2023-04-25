Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59296EDB13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjDYFNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjDYFNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:13:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019683F2;
        Mon, 24 Apr 2023 22:13:00 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33P5CcSi096405;
        Tue, 25 Apr 2023 00:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682399558;
        bh=yTpLxKrg7egiAi3pgpp2MMWenJzUolnAKdOhNyVQSGE=;
        h=From:To:CC:Subject:Date;
        b=xylo8B9RG1M1v74Y/4DJrozj8IWmhd2h5X9HyLK+aJPAPpnj43LJuTK6lXK3jL7xV
         Jix1Fg8s6/YvgylxHE/EZ4lAK18KU/A9HZ0lrRwmOtoU3v3DK1Aub2LEURCjyBLY4q
         PH3qt5HdcS0lq5qrryvOLMu2SyTn6O7jwEgkMDhc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33P5CcC3130651
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Apr 2023 00:12:38 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 25
 Apr 2023 00:12:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 25 Apr 2023 00:12:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33P5Ca7W059470;
        Tue, 25 Apr 2023 00:12:37 -0500
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
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
Subject: [PATCH 0/2] arm64: dts: ti: Add OLDI panel DT overlay
Date:   Tue, 25 Apr 2023 10:42:33 +0530
Message-ID: <20230425051235.15533-1-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.1
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

This patch series adds support for the Rocktech RK101II01D-CT OLDI
panel, on top of AM654 base-board EVM.

Moreover, it enables support for TI ECAP and TI EHRPWM drivers to
provide SW control of backlight.

The first patch of this series,
"arm64: dts: ti: Add overlay for OLDI-LCD1EVM Display and touch screen"
was picked up from TI's public tree [1] based on 5.10 LTS kernel.

[1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dts?h=ti-linux-5.10.y

Aradhya Bhatia (1):
  arm64: defconfig: Enable PWM drivers for TI ECAP and EHRPWM

Jyri Sarha (1):
  arm64: dts: ti: Add overlay for OLDI-LCD1EVM Display and touch screen

 arch/arm64/boot/dts/ti/Makefile               |  2 +
 .../dts/ti/k3-am654-evm-oldi-lcd1evm.dtso     | 70 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  2 +
 3 files changed, 74 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am654-evm-oldi-lcd1evm.dtso

-- 
2.39.1

