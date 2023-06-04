Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B827214B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjFDEzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjFDEzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:55:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D24DA;
        Sat,  3 Jun 2023 21:55:52 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3544tZOK020096;
        Sat, 3 Jun 2023 23:55:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685854535;
        bh=KNGElMYwlfphIU/Y6CaXJGP5kn7+NJmA6loRpx0ORg8=;
        h=From:To:CC:Subject:Date;
        b=MmfZDEqCjkcnhG7dhL4M7DroolH5CxKlq9+NbbL8vvt1JpoVX6AxqOxm3ADCfDJS0
         CRdLVDN/foYnMimuKtdVI9/b6j4gfh6NPDZeEURf3r7XhlmrAXvle/7YDQVsV6ZJYK
         lAKHCOXjSJpVffSMuDxyCkrhvSNaLafbuR8IjSV0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3544tZvS081213
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Jun 2023 23:55:35 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 3
 Jun 2023 23:55:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 3 Jun 2023 23:55:35 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3544tVqY052201;
        Sat, 3 Jun 2023 23:55:32 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3 0/5] arm64: dts: ti: k3-j7200: Add properties and sync with uboot
Date:   Sun, 4 Jun 2023 10:25:20 +0530
Message-ID: <20230604045525.1889083-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

In continuation of patch series posted by Nishanth
for sync of uboot device tree with kernel device tree for AM64 SOC.
https://lore.kernel.org/linux-arm-kernel/20230414073328.381336-1-nm@ti.com/

This series extend device tree sync/clean up for J7200 SOC.

This patch series build on top of
https://lore.kernel.org/all/20230419040007.3022780-1-u-kumar1@ti.com


Changes since v2:
https://lore.kernel.org/all/20230601093744.1565802-1-u-kumar1@ti.com/
* Configure pinctrl for timer IO pads
  Added reviewed by Tony Lindgren

* Add uart pin mux in main_pmx0
  Changed subject of patch

Changes since v1:
https://lore.kernel.org/all/20230426103219.1565266-1-u-kumar1@ti.com/
* Add general purpose timers:
  Addded CLKSEL_VD clock for odd numbered timers
  Marked MCU_Timer as reserved, fixed clock index for main_timer13

*Configure pinctrl for timer IO pads
 Marked mcu_timerio_input as reserved

*main_pmx0 clean up
 Splitted into two patches, One for UART and second for
 i2c duplication removal

*Add uart pin mux in wkup_pmx0
  No change

*Add bootph-pre-ram for u-boot
 patch dropped, later will add bootph-pre-ram property
 later for all nodes.


Udit Kumar (5):
  arm64: dts: ti: k3-j7200: Add general purpose timers
  arm64: dts: ti: k3-j7200: Configure pinctrl for timer IO pads
  arm64: dts: ti: k3-j7200-common-proc-board: Add uart pin mux in
    main_pmx0
  arm64: dts: ti: k3-j7200-common-proc-board: remove duplicate main_i2c0
    pin mux
  arm64: dts: ti: k3-j7200-common-proc-board: Add uart pin mux in
    wkup_pmx0

 .../dts/ti/k3-j7200-common-proc-board.dts     |  32 ++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 258 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 150 ++++++++++
 3 files changed, 436 insertions(+), 4 deletions(-)

-- 
2.34.1

