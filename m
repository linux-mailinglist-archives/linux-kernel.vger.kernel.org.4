Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C860B664
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJXS4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiJXSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:55:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05161A20A9;
        Mon, 24 Oct 2022 10:36:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYebx012535;
        Mon, 24 Oct 2022 12:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632881;
        bh=NBWWl42SSL4G3YUtPMkVXQP2CMrKN1xbC8aYMEj43O8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fR47W8GfFwNZN3+QM1UwUBG77eSBqQ5WeFsdgHcNQNkdq55ZtSjPpk5Xgf8F7QxQc
         LAGpgcLuIV4ecgJpoXrJosMow/P9UVZTKIctHu+bMKo86tFVRVYXdrdH5+xpe0ooVI
         C192ir0Fz+Tba0hQwp2aTlFvcnOdrWzZs5JFrFwQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYeek006895
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:40 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:40 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:40 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYJ4039154;
        Mon, 24 Oct 2022 12:34:39 -0500
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
Subject: [PATCH v2 6/7] arm64: dts: xilinx: Rename DTB overlay source files from .dts to .dtso
Date:   Mon, 24 Oct 2022 12:34:33 -0500
Message-ID: <20221024173434.32518-7-afd@ti.com>
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

Convert the DTB overlay source files in the arm64/xilinx directory.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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

