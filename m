Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321467C4B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjAZHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAZHM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:12:28 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3772D44;
        Wed, 25 Jan 2023 23:12:27 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30Q7CBWU111108;
        Thu, 26 Jan 2023 01:12:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674717131;
        bh=x/FjT4ucuuDO/GzDfCuYukxslZ1OhZAfhowzpA1/hZw=;
        h=From:To:CC:Subject:Date;
        b=O76xqvG2wP/r3zFEDkCxCMD0g0TZKBNxoPA9OmACVY4nUIaXijNED1dmlE6FR2w+h
         qmZfZsIXuTxk3uo/br/A8LSCJhw9WBE7K7GPSs5iZ5rJRtX7Z+BgcHTLSRNs1Vho/j
         X8HO/Sw8PS6MW6k5ry9wD7aPfyJReO8lhLoQArVE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30Q7CBvQ027837
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Jan 2023 01:12:11 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 26
 Jan 2023 01:12:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 26 Jan 2023 01:12:11 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30Q7C7ZZ019592;
        Thu, 26 Jan 2023 01:12:08 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm64: dts: ti: Makefile: Rearrange entries alphabetically
Date:   Thu, 26 Jan 2023 12:41:59 +0530
Message-ID: <20230126071159.2337584-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Entries are first grouped as per SoC present on the board. Groups are
sorted alphabetically. This makes it easy to know SoC to board mapping
and also add new entries in alphabetical order.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
Based on top of linux-next + iot2050 m.2 board[1][2]

[1] lore.kernel.org/r/878e3a023767b5a6d9d2cff09015678aaba13fce.1674110442.git.jan.kiszka@siemens.com
[2] lore.kernel.org/r/20230119132958.124435-3-sabiya.d@ti.com

Here is what file looks like:
https://gist.github.com/r-vignesh/d54e6446b0615e0818c142d9ea152e27

 arch/arm64/boot/dts/ti/Makefile | 36 +++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 74c71d25e406..6acd12409d59 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -5,33 +5,43 @@
 #
 # Copyright (C) 2016-2021 Texas Instruments Incorporated - https://www.ti.com/
 #
+# Entries are grouped as per SoC present on the board. Groups are sorted
+# alphabetically.
 
-dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
+# Boards with AM62x SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
+
+# Boards with AM62Ax SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+
+# Boards with AM64x SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
+
+# Boards with AM65x SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic-pg2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-m2.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced-pg2.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
 
-DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
-
-dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
+# Boards with J7200 SoC
+dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
 
+# Boards with J721e SoC
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-beagleboneai64.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721e-sk.dtb
 
-dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
-
+# Boards with J721s2 SoC
+dtb-$(CONFIG_ARCH_K3) += k3-am68-sk-base-board.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
 
+# Boards with J784s4 SoC
 dtb-$(CONFIG_ARCH_K3) += k3-am69-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm.dtb
 
-dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
-dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
-
-dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
-
-dtb-$(CONFIG_ARCH_K3) += k3-am62a7-sk.dtb
+# Enable support for device-tree overlays
+DTC_FLAGS_k3-am6548-iot2050-advanced-m2 += -@
-- 
2.39.1

