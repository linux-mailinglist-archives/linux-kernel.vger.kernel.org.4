Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C7B6AE61F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCGQRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGQRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:17:37 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5FE888A5;
        Tue,  7 Mar 2023 08:17:35 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327GHGGY086203;
        Tue, 7 Mar 2023 10:17:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678205836;
        bh=sPtMFiWn6qZxTPtmEurnBZdw8JvGBI4vyPPxBHsw0dk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wfNvLzXWWTzZT1iM6+x1gfwb8k9mlqXsTQ0rjMcbcqT3ObbslruxBO0L0f3C+MHAz
         u/d9TDpn0Zof21Ew7plvJYIQxmNwjzCPKdLmS4yl3JWEdc5tq1Lm4W2j85PudOdXBo
         Vrcy68lfura85x24BBUJLdI1RUxoKmRZnM5yiJkw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327GHG3X011281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 10:17:16 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 10:17:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 10:17:15 -0600
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327GHFEw003079;
        Tue, 7 Mar 2023 10:17:15 -0600
From:   Andrew Davis <afd@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 2/3] ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
Date:   Tue, 7 Mar 2023 10:17:14 -0600
Message-ID: <20230307161715.15209-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307161715.15209-1-afd@ti.com>
References: <20230307161715.15209-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 7f850cf5f063..c1297fd06d2a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -995,11 +995,13 @@ dtb-$(CONFIG_SOC_OMAP5) += \
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
2.39.2

