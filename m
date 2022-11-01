Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98C6154CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiKAWL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiKAWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:11:17 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB461788F;
        Tue,  1 Nov 2022 15:11:17 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1MBDkM081499;
        Tue, 1 Nov 2022 17:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667340673;
        bh=t76/NsfJhc/UAPsjQj3wDq/rlBwPLOZ9zUVmC6141YA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b+3L6l0Osgad7DE+uvg+315gwIVopn8CAp2IaYYLJEENdHCSUlGqjCJ67N7sJ6SSj
         TFrCQ8SlwHLoq4rK3ABIjftIDMc86pfTcNJt68+ln68I1jPpEHKitcqtmYJ2xkAuj9
         iokV98HTmpWe4CsaaVHmTqeVgUHWwAyHNnXE8By8=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1MBDeI116147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 17:11:13 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 17:11:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 17:11:12 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1MBAl6016232;
        Tue, 1 Nov 2022 17:11:12 -0500
From:   Andrew Davis <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: ti: Add AM57xx GP EVM Rev A3 board support
Date:   Tue, 1 Nov 2022 17:11:10 -0500
Message-ID: <20221101221110.17885-3-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221101221110.17885-1-afd@ti.com>
References: <20221101221110.17885-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 0a281b81cc42a..6fb8e7cb4cf7b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -986,11 +986,13 @@ dtb-$(CONFIG_SOC_OMAP5) += \
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
2.37.3

