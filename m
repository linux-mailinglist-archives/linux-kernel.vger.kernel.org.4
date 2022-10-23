Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4D609589
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJWSZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 14:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJWSZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 14:25:21 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97899481FA;
        Sun, 23 Oct 2022 11:25:17 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29NIOiY1031002;
        Sun, 23 Oct 2022 13:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666549484;
        bh=9st99SOgqqJ97K4IHxXw4rse3SOpMoT1XJwiOcRMdnA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WW7lvUjehxsNPQSr5FaxNfwuJokggGP/iaF2FTQvKBVFQpuPn2AywnvxVlJE56kAH
         +kS8i9E4hZk/kBEzE2g0710fyIUvd8q9kHAm3ufBIuu1xuzakyoKoPGiuWYDVEUake
         lAJYHLBxoSsGtQ1862Rgx/fuCPNMVB0Iu4ovz8r4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29NIOiDC021588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Oct 2022 13:24:44 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sun, 23
 Oct 2022 13:24:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sun, 23 Oct 2022 13:24:44 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29NIObVd042708;
        Sun, 23 Oct 2022 13:24:43 -0500
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
Subject: [PATCH 6/6] arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
Date:   Sun, 23 Oct 2022 13:24:37 -0500
Message-ID: <20221023182437.15263-7-afd@ti.com>
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

Convert the DTB overlay source files in the arm64/xilinx directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso}       | 0
 .../{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso}       | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revA.dts => zynqmp-sck-kv-g-revA.dtso} (100%)
 rename arch/arm64/boot/dts/xilinx/{zynqmp-sck-kv-g-revB.dts => zynqmp-sck-kv-g-revB.dtso} (100%)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
similarity index 100%
rename from arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
rename to arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
-- 
2.37.3

