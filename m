Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8336DAC27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240582AbjDGLVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDGLVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:21:43 -0400
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3662524F;
        Fri,  7 Apr 2023 04:21:39 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 1518B720405;
        Fri,  7 Apr 2023 13:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1680866464;
        bh=FoEn3YsObVXDi6gcdkHWzEwSqr7RCXxkpwZ+Y3QsIN4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KkGmYzwu6Y3g7URm5cesBaR3ABadnLKzSiBYsDBl+zr1vf6bZU8dCm400kj2LM/Vh
         m8HwA9v8Qk6tl2dSubwRBPeiymwictyWg+cWo9gLy7ZFAZZBiz3pyAnyoD0WsxROuS
         i+xtTu2GZRMAGgOT8L7xS91dgpJGyT9/AeuALhvAXPfhZq4bDk28bYGoJNSvWDtu1e
         cwIBgHtfy5iZvY2tMAjWMwP75ar4UYZB7M0HHuEVtjrmz5wySgwTMDiDOVVW97Rv2e
         7o+jRWj+ykXxvzc7BGTHoCBOC4V7xDjEjJBR1Dhn8LJLsavPiwufAtAcogM3mSVI36
         h50vC9Wudo53A==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Apr 2023 12:50:51 +0200
Received: from localhost.localdomain (172.16.51.16) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26 via Frontend Transport; Fri, 7 Apr 2023 12:50:50 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        <kernel@dh-electronics.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 3/4] ARM: dts: imx6ull-dhcor: Remove mmc aliases from DHCOR SoM
Date:   Fri, 7 Apr 2023 12:49:42 +0200
Message-ID: <20230407104943.5794-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
References: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to define mmc aliases correctly for a DHCOR board
remove mmc aliases from the DHCOR SoM layer.

All DHCOM SoM boards are based on the DHCOR SoM, as the DHCOR
SoM is soldered on top of the DHCOM SoM. As a result, remove
the mmc /delete-property/ entries from the aliases node in
the DHCOM SoM layer, because this is already removed in the
DHCOR SoM layer below.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V3: - Add this patch to the series
V4: - Remove mmc /delete-property/ entries from the aliases node in
      the DHCOM SoM layer
---
 arch/arm/boot/dts/imx6ull-dhcom-som.dtsi | 2 --
 arch/arm/boot/dts/imx6ull-dhcor-som.dtsi | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-dhcom-som.dtsi b/arch/arm/boot/dts/imx6ull-dhcom-som.dtsi
index 17837663c0b0..830b5a5064f2 100644
--- a/arch/arm/boot/dts/imx6ull-dhcom-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-dhcom-som.dtsi
@@ -7,8 +7,6 @@
 
 / {
 	aliases {
-		/delete-property/ mmc0; /* Avoid double definitions */
-		/delete-property/ mmc1;
 		/delete-property/ spi2;
 		/delete-property/ spi3;
 		i2c0 = &i2c2;
diff --git a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
index 5882c7565f64..a386c1e9bed3 100644
--- a/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
+++ b/arch/arm/boot/dts/imx6ull-dhcor-som.dtsi
@@ -11,6 +11,11 @@
 #include "imx6ull.dtsi"
 
 / {
+	aliases {
+		/delete-property/ mmc0;
+		/delete-property/ mmc1;
+	};
+
 	memory@80000000 {
 		/* Appropriate memory size will be filled by U-Boot */
 		reg = <0x80000000 0>;
-- 
2.11.0

