Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0760B6A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiJXTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiJXTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:06:05 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE0C820C;
        Mon, 24 Oct 2022 10:45:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYZrA031166;
        Mon, 24 Oct 2022 12:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632875;
        bh=bYB2FaSj8hi0qni5g1MXGuvwVR+hZVuPR2WQUXNnHAQ=;
        h=From:To:CC:Subject:Date;
        b=QYGfUKycPdh9v7Uei33H0Q6OZSKcgRJGXqnUWatbjPE+clSOEMRp+WvigAYHHe4Gv
         atky2CsYiHsb55bM768Ua4aimWRxUyJeA5Hg6YMZZLSy8ReR5E4UPYd0rd6V2I59/I
         mBFIIKw71Uu2n1P8eLcC1PUjRmNkymGtbVCgFrs8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYZui002353
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:35 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYIw039154;
        Mon, 24 Oct 2022 12:34:34 -0500
From:   Andrew Davis <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kbuild@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/7] Rename DTB overlay source files
Date:   Mon, 24 Oct 2022 12:34:27 -0500
Message-ID: <20221024173434.32518-1-afd@ti.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This is a series based on my patch here[0]. As suggested by Rob
I've resurrected Frank's patch and appended it to mine as a series.

First patch here is my original patch, 3rd is Frank's patch but with
the unittest changes pulled out into the 2nd patch. That was re-worked
moving the source building macro into scripts/Makefile.lib.

Patches 4, 5, and 6 are an attempt at renaming all the existing DTB
overlays. Split out by platform so they could be taken by platform
maintainers or if easier ACK'd here and taken all together.

This should cover all the DTB overlays so we can remove the old .dts
rule for overlays and make .dtso the only supported way, let me know
if we want that this cycle and I can post that too.

Thanks,
Andrew

Changes from v1[1]:
 - Added patch to rename pi433 overlay.
 - Cleaned wording on patch 4-6.
 - Collected some ACKs

[0] https://www.spinics.net/lists/kernel/msg4548509.html
[1] https://www.spinics.net/lists/arm-kernel/msg1020165.html

Andrew Davis (6):
  kbuild: Allow DTB overlays to built from .dtso named source files
  kbuild: Allow DTB overlays to built into .dtso.S files
  arm64: dts: freescale: Rename DTB overlay source files from .dts to
    .dtso
  arm64: dts: renesas: Rename DTB overlay source files from .dts to
    .dtso
  arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
  staging: pi433: overlay: Rename overlay source file from .dts to .dtso

Frank Rowand (1):
  of: overlay: rename overlay source files from .dts to .dtso

 ...qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} |  0
 ...qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} |  0
 ...qds-7777.dts => fsl-ls1028a-qds-7777.dtso} |  0
 ...qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} |  0
 ...qds-899b.dts => fsl-ls1028a-qds-899b.dtso} |  0
 ...qds-9999.dts => fsl-ls1028a-qds-9999.dtso} |  0
 ...ts => imx8mm-venice-gw72xx-0x-imx219.dtso} |  0
 ...=> imx8mm-venice-gw72xx-0x-rs232-rts.dtso} |  0
 ...dts => imx8mm-venice-gw72xx-0x-rs422.dtso} |  0
 ...dts => imx8mm-venice-gw72xx-0x-rs485.dtso} |  0
 ...ts => imx8mm-venice-gw73xx-0x-imx219.dtso} |  0
 ...=> imx8mm-venice-gw73xx-0x-rs232-rts.dtso} |  0
 ...dts => imx8mm-venice-gw73xx-0x-rs422.dtso} |  0
 ...dts => imx8mm-venice-gw73xx-0x-rs485.dtso} |  0
 ...2.dts => draak-ebisu-panel-aa104xd12.dtso} |  0
 ...xd12.dts => salvator-panel-aa104xd12.dtso} |  0
 ...v-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} |  0
 ...v-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} |  0
 drivers/of/unittest-data/Makefile             | 66 +++++++++----------
 .../{overlay.dts => overlay.dtso}             |  0
 .../{overlay_0.dts => overlay_0.dtso}         |  0
 .../{overlay_1.dts => overlay_1.dtso}         |  0
 .../{overlay_10.dts => overlay_10.dtso}       |  0
 .../{overlay_11.dts => overlay_11.dtso}       |  0
 .../{overlay_12.dts => overlay_12.dtso}       |  0
 .../{overlay_13.dts => overlay_13.dtso}       |  0
 .../{overlay_15.dts => overlay_15.dtso}       |  0
 .../{overlay_16.dts => overlay_16.dtso}       |  0
 .../{overlay_17.dts => overlay_17.dtso}       |  0
 .../{overlay_18.dts => overlay_18.dtso}       |  0
 .../{overlay_19.dts => overlay_19.dtso}       |  0
 .../{overlay_2.dts => overlay_2.dtso}         |  0
 .../{overlay_20.dts => overlay_20.dtso}       |  0
 .../{overlay_3.dts => overlay_3.dtso}         |  0
 .../{overlay_4.dts => overlay_4.dtso}         |  0
 .../{overlay_5.dts => overlay_5.dtso}         |  0
 .../{overlay_6.dts => overlay_6.dtso}         |  0
 .../{overlay_7.dts => overlay_7.dtso}         |  0
 .../{overlay_8.dts => overlay_8.dtso}         |  0
 .../{overlay_9.dts => overlay_9.dtso}         |  0
 ...node.dts => overlay_bad_add_dup_node.dtso} |  0
 ...prop.dts => overlay_bad_add_dup_prop.dtso} |  0
 ...d_phandle.dts => overlay_bad_phandle.dtso} |  0
 ...bad_symbol.dts => overlay_bad_symbol.dtso} |  0
 .../{overlay_base.dts => overlay_base.dtso}   |  0
 ...erlay_gpio_01.dts => overlay_gpio_01.dtso} |  0
 ...lay_gpio_02a.dts => overlay_gpio_02a.dtso} |  0
 ...lay_gpio_02b.dts => overlay_gpio_02b.dtso} |  0
 ...erlay_gpio_03.dts => overlay_gpio_03.dtso} |  0
 ...lay_gpio_04a.dts => overlay_gpio_04a.dtso} |  0
 ...lay_gpio_04b.dts => overlay_gpio_04b.dtso} |  0
 .../{testcases.dts => testcases.dtso}         |  0
 drivers/of/unittest.c                         | 48 +++++++-------
 .../{pi433-overlay.dts => pi433-overlay.dtso} |  0
 .../pi433/Documentation/devicetree/pi433.txt  |  6 +-
 scripts/Makefile.lib                          | 23 ++++++-
 56 files changed, 82 insertions(+), 61 deletions(-)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-7777.dts => fsl-ls1028a-qds-7777.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-899b.dts => fsl-ls1028a-qds-899b.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{fsl-ls1028a-qds-9999.dts => fsl-ls1028a-qds-9999.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-imx219.dts => imx8mm-venice-gw72xx-0x-imx219.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs232-rts.dts => imx8mm-venice-gw72xx-0x-rs232-rts.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs422.dts => imx8mm-venice-gw72xx-0x-rs422.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw72xx-0x-rs485.dts => imx8mm-venice-gw72xx-0x-rs485.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-imx219.dts => imx8mm-venice-gw73xx-0x-imx219.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs232-rts.dts => imx8mm-venice-gw73xx-0x-rs232-rts.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs422.dts => imx8mm-venice-gw73xx-0x-rs422.dtso} (100%)
 rename arch/arm64/boot/dts/freescale/{imx8mm-venice-gw73xx-0x-rs485.dts => imx8mm-venice-gw73xx-0x-rs485.dtso} (100%)
 rename arch/arm64/boot/dts/renesas/{draak-ebisu-panel-aa104xd12.dts => draak-ebisu-panel-aa104xd12.dtso} (100%)
 rename arch/arm64/boot/dts/renesas/{salvator-panel-aa104xd12.dts => salvator-panel-aa104xd12.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)
 rename drivers/of/unittest-data/{overlay.dts => overlay.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_0.dts => overlay_0.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_1.dts => overlay_1.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_10.dts => overlay_10.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_11.dts => overlay_11.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_12.dts => overlay_12.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_13.dts => overlay_13.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_15.dts => overlay_15.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_16.dts => overlay_16.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_17.dts => overlay_17.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_18.dts => overlay_18.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_19.dts => overlay_19.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_2.dts => overlay_2.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_20.dts => overlay_20.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_3.dts => overlay_3.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_4.dts => overlay_4.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_5.dts => overlay_5.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_6.dts => overlay_6.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_7.dts => overlay_7.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_8.dts => overlay_8.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_9.dts => overlay_9.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_node.dts => overlay_bad_add_dup_node.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_prop.dts => overlay_bad_add_dup_prop.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_phandle.dts => overlay_bad_phandle.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_symbol.dts => overlay_bad_symbol.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_base.dts => overlay_base.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_01.dts => overlay_gpio_01.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02a.dts => overlay_gpio_02a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02b.dts => overlay_gpio_02b.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_03.dts => overlay_gpio_03.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04a.dts => overlay_gpio_04a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04b.dts => overlay_gpio_04b.dtso} (100%)
 rename drivers/of/unittest-data/{testcases.dts => testcases.dtso} (100%)
 rename drivers/staging/pi433/Documentation/devicetree/{pi433-overlay.dts => pi433-overlay.dtso} (100%)

-- 
2.37.3

