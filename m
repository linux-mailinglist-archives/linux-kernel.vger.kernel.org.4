Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C747A609587
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiJWSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJWSZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:25:22 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00911481D4;
        Sun, 23 Oct 2022 11:25:16 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29NIOgxE035579;
        Sun, 23 Oct 2022 13:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666549482;
        bh=CqQmCNnvDd0J0Q/Z1W5OTC4NOPgpy6mPC4/OCc6121Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oO6XGmN43tb0d6W/7dpANuS2IO2CDSTmgTjHYzDUHga89JKWOWcLqc+bt6OFTt3vR
         4wA9rIoeV83WaKb+2v9aH5ASgG9LhXTHgU/fKTcQi3xer3C4pRTq7SfpW1PbEoqc+l
         RDK1k9daktXVJCmRTN6SzZFXa0fmOTyN+Kh7/zCc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29NIOg7h021577
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Oct 2022 13:24:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 23
 Oct 2022 13:24:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 23 Oct 2022 13:24:42 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29NIObVb042708;
        Sun, 23 Oct 2022 13:24:41 -0500
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
Subject: [PATCH 4/6] arm64: dts: freescale: Rename DTB overlay source files from .dts to .dtso
Date:   Sun, 23 Oct 2022 13:24:35 -0500
Message-ID: <20221023182437.15263-5-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221023182437.15263-1-afd@ti.com>
References: <20221023182437.15263-1-afd@ti.com>
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

DTB Overlays (.dtbo) can now be built from source files with the
extension (.dtso). This makes it clear the content of the file
and differentiates them from base DTB source files.

Convert the DTB overlay source files in the arm64/freescale directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../{fsl-ls1028a-qds-13bb.dts => fsl-ls1028a-qds-13bb.dtso}       | 0
 .../{fsl-ls1028a-qds-65bb.dts => fsl-ls1028a-qds-65bb.dtso}       | 0
 .../{fsl-ls1028a-qds-7777.dts => fsl-ls1028a-qds-7777.dtso}       | 0
 .../{fsl-ls1028a-qds-85bb.dts => fsl-ls1028a-qds-85bb.dtso}       | 0
 .../{fsl-ls1028a-qds-899b.dts => fsl-ls1028a-qds-899b.dtso}       | 0
 .../{fsl-ls1028a-qds-9999.dts => fsl-ls1028a-qds-9999.dtso}       | 0
 ...e-gw72xx-0x-imx219.dts => imx8mm-venice-gw72xx-0x-imx219.dtso} | 0
 ...xx-0x-rs232-rts.dts => imx8mm-venice-gw72xx-0x-rs232-rts.dtso} | 0
 ...ice-gw72xx-0x-rs422.dts => imx8mm-venice-gw72xx-0x-rs422.dtso} | 0
 ...ice-gw72xx-0x-rs485.dts => imx8mm-venice-gw72xx-0x-rs485.dtso} | 0
 ...e-gw73xx-0x-imx219.dts => imx8mm-venice-gw73xx-0x-imx219.dtso} | 0
 ...xx-0x-rs232-rts.dts => imx8mm-venice-gw73xx-0x-rs232-rts.dtso} | 0
 ...ice-gw73xx-0x-rs422.dts => imx8mm-venice-gw73xx-0x-rs422.dtso} | 0
 ...ice-gw73xx-0x-rs485.dts => imx8mm-venice-gw73xx-0x-rs485.dtso} | 0
 14 files changed, 0 insertions(+), 0 deletions(-)
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

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-65bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-7777.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-85bb.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-899b.dtso
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dts
rename to arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-9999.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-imx219.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-imx219.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
similarity index 100%
rename from arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dts
rename to arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
-- 
2.37.3

