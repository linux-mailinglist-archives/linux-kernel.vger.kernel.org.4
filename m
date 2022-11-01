Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AA9615482
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiKAV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKAV63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:58:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BC72BD9;
        Tue,  1 Nov 2022 14:58:26 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A1Lw70U128366;
        Tue, 1 Nov 2022 16:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667339887;
        bh=xz3MVvX826/jB7ymb5mYpupJ0Zh7v1aK1WyZn5W//P4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ndL0WpHHYafQEwIIRKtmaOgclvZrYc0LuQJzpOtitXAmAa/8sPoasdRhdNdulYsHG
         j2pQZ3E0RjSwtdxxFeKUW8/IKZ74t7cQgsffe2K+NW1vH5BJyOO50PkRHXoWHpAb2Z
         qsBbaNjqjKb1wWvtaCPmqPILga/fsEGbsGGu/S2o=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A1Lw7Ve066657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Nov 2022 16:58:07 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 1 Nov
 2022 16:58:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 1 Nov 2022 16:58:07 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A1Lw44o117953;
        Tue, 1 Nov 2022 16:58:06 -0500
From:   Andrew Davis <afd@ti.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 3/9] ARM: dts: nspire: Fix cpu node to conform with DT binding
Date:   Tue, 1 Nov 2022 16:57:58 -0500
Message-ID: <20221101215804.16262-4-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221101215804.16262-1-afd@ti.com>
References: <20221101215804.16262-1-afd@ti.com>
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

This node does not follow the DT binding schema, correct this.
Should result in no functional change.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
index 48fbc9d533c39..cb72370515126 100644
--- a/arch/arm/boot/dts/nspire.dtsi
+++ b/arch/arm/boot/dts/nspire.dtsi
@@ -11,8 +11,13 @@ / {
 	interrupt-parent = <&intc>;
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
 			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+			reg = <0>;
 		};
 	};
 
-- 
2.37.3

