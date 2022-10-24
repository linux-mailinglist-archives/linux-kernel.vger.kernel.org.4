Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FB460B6A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiJXTGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbiJXTFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:05:25 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBFDCE7;
        Mon, 24 Oct 2022 10:45:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYdI8031173;
        Mon, 24 Oct 2022 12:34:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632880;
        bh=DG2Cypqan4dRmgBkwTCD4tPNOhMf/ldAIcyLku3uhSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YV2KXSECI9WQPr3u4hk52TgT0/NaCthMpqqg1+iFlkXhNiEdUw3lNsmDENdoRIezp
         9dyKFAThRaTaBxxivLP5ZG81Q5hrPjdQiMLM2D1nlcecZ8QxilH6rtMtPqspNUvuVO
         nlbEIu2Y3UsmvahneK9B02l6obwAZNoZW+Y94hsI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYdwT122848
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:39 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYJ3039154;
        Mon, 24 Oct 2022 12:34:38 -0500
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
Subject: [PATCH v2 5/7] arm64: dts: renesas: Rename DTB overlay source files from .dts to .dtso
Date:   Mon, 24 Oct 2022 12:34:32 -0500
Message-ID: <20221024173434.32518-6-afd@ti.com>
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

Convert the DTB overlay source files in the arm64/renesas directory.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 ...ebisu-panel-aa104xd12.dts => draak-ebisu-panel-aa104xd12.dtso} | 0
 ...salvator-panel-aa104xd12.dts => salvator-panel-aa104xd12.dtso} | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename arch/arm64/boot/dts/renesas/{draak-ebisu-panel-aa104xd12.dts => draak-ebisu-panel-aa104xd12.dtso} (100%)
 rename arch/arm64/boot/dts/renesas/{salvator-panel-aa104xd12.dts => salvator-panel-aa104xd12.dtso} (100%)

diff --git a/arch/arm64/boot/dts/renesas/draak-ebisu-panel-aa104xd12.dts b/arch/arm64/boot/dts/renesas/draak-ebisu-panel-aa104xd12.dtso
similarity index 100%
rename from arch/arm64/boot/dts/renesas/draak-ebisu-panel-aa104xd12.dts
rename to arch/arm64/boot/dts/renesas/draak-ebisu-panel-aa104xd12.dtso
diff --git a/arch/arm64/boot/dts/renesas/salvator-panel-aa104xd12.dts b/arch/arm64/boot/dts/renesas/salvator-panel-aa104xd12.dtso
similarity index 100%
rename from arch/arm64/boot/dts/renesas/salvator-panel-aa104xd12.dts
rename to arch/arm64/boot/dts/renesas/salvator-panel-aa104xd12.dtso
-- 
2.37.3

