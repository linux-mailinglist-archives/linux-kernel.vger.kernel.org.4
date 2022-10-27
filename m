Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39DB60FFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbiJ0SOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiJ0SOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:14:02 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813463F1DD;
        Thu, 27 Oct 2022 11:14:00 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29RIDgC5039381;
        Thu, 27 Oct 2022 13:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666894422;
        bh=UvuXWgEi4XYpe3yMzYUWVXXK4/Vc2qSV9cHehSezeFk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VegjOvhWccCj4QEwO3ZREtbBS5IiXxyLjXwDAdU50IUqHK2LFqOrFMfIlRbn7pPsG
         N6JLB0ZWJXGwHkaHvuhjBVXL04A4pDbkCklpv3D9bM/JFSecqIPCkM500R+eqfYpOJ
         LqDe9yxQvYKI9L0DI+4FaT6rgsylPJllD2xJ/3Mk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29RIDgEm039690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Oct 2022 13:13:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 27
 Oct 2022 13:13:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 27 Oct 2022 13:13:42 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29RIDbe2108447;
        Thu, 27 Oct 2022 13:13:41 -0500
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
Subject: [PATCH v3 6/9] ARM: dts: nspire: Fix uart node to conform with DT binding
Date:   Thu, 27 Oct 2022 13:13:34 -0500
Message-ID: <20221027181337.8651-7-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221027181337.8651-1-afd@ti.com>
References: <20221027181337.8651-1-afd@ti.com>
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

This node does not follow the DT binding schema, correct this.
The arm,pl011 binding requires the first clock to be named "uartclk".
Should result in no functional change.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/boot/dts/nspire-cx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nspire-cx.dts b/arch/arm/boot/dts/nspire-cx.dts
index 590b7dff6ae5..837dbdd9af55 100644
--- a/arch/arm/boot/dts/nspire-cx.dts
+++ b/arch/arm/boot/dts/nspire-cx.dts
@@ -24,7 +24,7 @@ &uart {
 	compatible = "arm,pl011", "arm,primecell";
 
 	clocks = <&uart_clk>, <&apb_pclk>;
-	clock-names = "uart_clk", "apb_pclk";
+	clock-names = "uartclk", "apb_pclk";
 };
 
 &timer0 {
-- 
2.37.3

