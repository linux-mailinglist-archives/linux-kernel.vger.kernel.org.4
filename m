Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E860BDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiJXWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiJXWyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:54:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD962D20DA;
        Mon, 24 Oct 2022 14:16:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYf43047071;
        Mon, 24 Oct 2022 12:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666632881;
        bh=URuwxbNYEGUMSbDDyc2DIB/HUev400go/YHiS1qkjHI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Z2Iupi4zP7ORMhwyHM3iv6CL6CmYDsLb5yo9OHCAYFxdYPZXc4/YBXL6pPiBnfMI6
         Co2iNGgUHilVjoFxCK+Gd1dpA/Dqlj3axccaaZtIDoQeQkhmGstGmfWne43AgSavv5
         KlvyiYvtT6XQcLYS+QfrNDTWYquINdAo38wOy1XM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29OHYfFf002389
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Oct 2022 12:34:41 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 24
 Oct 2022 12:34:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 24 Oct 2022 12:34:41 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29OHYYJ5039154;
        Mon, 24 Oct 2022 12:34:40 -0500
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
Subject: [PATCH v2 7/7] staging: pi433: overlay: Rename overlay source file from .dts to .dtso
Date:   Mon, 24 Oct 2022 12:34:34 -0500
Message-ID: <20221024173434.32518-8-afd@ti.com>
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

Rename the pi433-overlay.dts file to pi433-overlay.dtso and update
the information file pi433.txt for the same.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../devicetree/{pi433-overlay.dts => pi433-overlay.dtso}    | 0
 drivers/staging/pi433/Documentation/devicetree/pi433.txt    | 6 +++---
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/staging/pi433/Documentation/devicetree/{pi433-overlay.dts => pi433-overlay.dtso} (100%)

diff --git a/drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts b/drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
similarity index 100%
rename from drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dts
rename to drivers/staging/pi433/Documentation/devicetree/pi433-overlay.dtso
diff --git a/drivers/staging/pi433/Documentation/devicetree/pi433.txt b/drivers/staging/pi433/Documentation/devicetree/pi433.txt
index a810548c58572..d317c0ec3419e 100644
--- a/drivers/staging/pi433/Documentation/devicetree/pi433.txt
+++ b/drivers/staging/pi433/Documentation/devicetree/pi433.txt
@@ -48,13 +48,13 @@ For Raspbian users only
 =======================
 Since Raspbian supports device tree overlays, you may use an overlay instead
 of editing your boards device tree.
-To use the overlay, you need to compile the file pi433-overlay.dts which can
+To use the overlay, you need to compile the file pi433-overlay.dtso which can
 be found alongside this documentation.
 The file needs to be compiled - either manually or by integration in your kernel
 source tree. For a manual compile, you may use a command line like the following:
-'linux/scripts/dtc/dtc -@ -I dts -O dtb -o pi433.dtbo pi433-overlay.dts'
+'linux/scripts/dtc/dtc -@ -I dts -O dtb -o pi433.dtbo pi433-overlay.dtso'
 
-For compiling inside of the kernel tree, you need to copy pi433-overlay.dts to
+For compiling inside of the kernel tree, you need to copy pi433-overlay.dtso to
 arch/arm/boot/dts/overlays and you need to add the file to the list of files
 in the Makefile over there. Execute 'make dtbs' in kernel tree root to make the
 kernel make files compile the device tree overlay for you.
-- 
2.37.3

