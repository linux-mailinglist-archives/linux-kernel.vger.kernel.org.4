Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29BD60BE5A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiJXXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiJXXOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:14:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784E31B6E2;
        Mon, 24 Oct 2022 14:35:20 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYd1D012521;
        Mon, 24 Oct 2022 12:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632879;
        bh=L6XcoFGyR7HmQUHNnt8y16oVUY/v1odNW85+8MxB5To=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Niyw885wqwUJO9eyy8Cefbci/NHHdKb6IJ5wH7ykaJC9+eSBhsW/tSHLGIC5jxJ3w
         obDb0R9JfMoeWwhxTG04MZdxmjyJTOJDPQN2DJUABQGh0HFmLn/jX9gHDTe3NUDHvW
         Ukc0eeivcT4tiMTai3DgojTctDmDNhvi7HDGmqaw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYdEr019602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:39 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:38 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYJ2039154;
        Mon, 24 Oct 2022 12:34:37 -0500
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
Subject: [PATCH v2 4/7] arm64: dts: freescale: Rename DTB overlay source files from .dts to .dtso
Date:   Mon, 24 Oct 2022 12:34:31 -0500
Message-ID: <20221024173434.32518-5-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221024173434.32518-1-afd@ti.com>
References: <20221024173434.32518-1-afd@ti.com>
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
extension (.dtso). This makes it clear what is the content of the files
and differentiates them from base DTB source files.

Convert the DTB overlay source files in the arm64/freescale directory.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

