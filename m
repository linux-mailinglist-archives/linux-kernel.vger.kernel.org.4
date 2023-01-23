Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04C6786C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjAWTsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjAWTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:48:29 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C6122A16;
        Mon, 23 Jan 2023 11:48:28 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmNQ6056304;
        Mon, 23 Jan 2023 13:48:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674503303;
        bh=rhxpVG5PV9ncmort8qjs25IwF7oHDgVPnpJ++ljtdWE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gZwceNe+Pgf8QQYNjtYZbIucDW2tArcDOJY50VYo0dNFRh8t3zKJZe4SGLz0H0bJy
         LyjmgHQm3xsQ2Pbb4i7IqPahh6VPa+CzTXCXmZlgq1dnC0zELU84SZufhREDmARVVZ
         AD1W10OKnPXeutOzjwddeXLyimKJlVH/F/a0Ki4A=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30NJmNA7074509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Jan 2023 13:48:23 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 23
 Jan 2023 13:48:23 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 23 Jan 2023 13:48:23 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30NJmJ0s031936;
        Mon, 23 Jan 2023 13:48:21 -0600
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v3 2/3] ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
Date:   Mon, 23 Jan 2023 13:48:17 -0600
Message-ID: <20230123194818.21448-3-afd@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230123194818.21448-1-afd@ti.com>
References: <20230123194818.21448-1-afd@ti.com>
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

The A3 revision of the AM57xx GP EVM has the same EVM feature set as the
original but is paired with an updated revision C BeagleBoard X15.

DT Overlays allow us to model this in the same way, we simply apply the
EVM overlay to the Rev C BeagleBoard to create the Rev A3 AM57xx GP EVM.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index fa14bdc36a99..ecc3b00bc2e2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -989,11 +989,13 @@ dtb-$(CONFIG_SOC_OMAP5) += \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
 am57xx-evm-dtbs := am57xx-beagle-x15.dtb am57xx-evm.dtbo
+am57xx-evm-reva3-dtbs := am57xx-beagle-x15-revc.dtb am57xx-evm.dtbo
 dtb-$(CONFIG_SOC_DRA7XX) += \
 	am57xx-beagle-x15.dtb \
 	am57xx-beagle-x15-revb1.dtb \
 	am57xx-beagle-x15-revc.dtb \
 	am57xx-evm.dtb \
+	am57xx-evm-reva3.dtb \
 	am5729-beagleboneai.dtb \
 	am57xx-cl-som-am57x.dtb \
 	am57xx-sbc-am57x.dtb \
-- 
2.38.1

