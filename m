Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BF6E1041
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDMOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjDMOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:44:13 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C9AF0F;
        Thu, 13 Apr 2023 07:43:52 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v10so13672863vsf.6;
        Thu, 13 Apr 2023 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681397023; x=1683989023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eeh91nWUJjVxzujFyKecjRMcqdUP/e5Kpsx1SGaM6Cg=;
        b=kf21yXJX/BSobeW10Mv2MGkr+jeLgLiCNginPFYyQoPGG0QHXGsTDB3W5VVx02sHRP
         Ycj16DbWdWF9JiYzqm+kh4en2OH26VocsjCtUaLLH2siIqu1i0ApWldQ3S377kvOIAoJ
         jM/I3k8/RT38GFYD/eA7gSy3MBuRjqL0pFhXFXMeP1uWFLI1UHPo90aYFXoiz8oSEjLX
         mmOCqQdhZouaMap8NwS7HEdVyUSmFJTVUa1JVJykt/FjGf+L9VjPJilPHE+98xB1Yojs
         uZn88gu7Ec3w5nMiwrdw0qxuIOUqOkc3/1Z/UuFGhT4lLzrGHbj7NS1UCqRNWW9GCnde
         Vsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681397023; x=1683989023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eeh91nWUJjVxzujFyKecjRMcqdUP/e5Kpsx1SGaM6Cg=;
        b=T+aA/OL2llb/WCZ/ZOjHhpXmzc0Y9pUUSwUkKE8d2A/XV+XkD71VM56pUCZlSxesGB
         0HCl0q28/trFR+Yr4/43tIJ9dx4FUUQ5B7GFbD9swu/7QlemLLoxZFz2JdAUO1gNTwNf
         F9a9RnDdi+lDqZRohQz/g0QYy8erk9s+pO982nxgSixWu3na1H8K1TtVo/wJKetxu6WQ
         yvKWl769CbstE791PoDaT7qNnU4iNZjTTNEjfVoU8Hpm5d4STSGHr9bzL6qkbk5MY7uY
         oaTUlIc4Ev0cS4cfga2amHZdpTjr8V+Ig+WowOwryQ+GyhvjMW9SEEPT55R0jW1U9e0Z
         QJag==
X-Gm-Message-State: AAQBX9dMI1VUBKq+kShmYs6q15YDJijuaC0tIgoG3hGLvlHen19O1jXf
        G/ItcgKNxUGzO8EEeEG91jg=
X-Google-Smtp-Source: AKy350ZavVP0wGsAyJ9u6DNYBZAMvG5os9XiGqZLvy2/rsOf464i5nwJTV0qpUWGIw0azEkyy8x+5w==
X-Received: by 2002:a05:6102:3a70:b0:412:4816:6cc3 with SMTP id bf16-20020a0561023a7000b0041248166cc3mr932227vsb.17.1681397023495;
        Thu, 13 Apr 2023 07:43:43 -0700 (PDT)
Received: from localhost.localdomain ([98.58.151.237])
        by smtp.googlemail.com with ESMTPSA id w14-20020ab05a8e000000b00771d1670401sm223637uae.35.2023.04.13.07.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 07:43:43 -0700 (PDT)
From:   John Clark <inindev@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Clark <inindev@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add pinctrl gpio-ranges for rk356x
Date:   Thu, 13 Apr 2023 10:43:16 -0400
Message-Id: <20230413144316.4247-1-inindev@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-range properties to the pinctrl gpio nodes in rk356x.dtsi

Signed-off-by: John Clark <inindev@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 802fcc96384e..793dbcb981dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1796,11 +1796,11 @@ usb2phy1_otg: otg-port {
 
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
+		ranges;
 		rockchip,grf = <&grf>;
 		rockchip,pmu = <&pmugrf>;
 		#address-cells = <2>;
 		#size-cells = <2>;
-		ranges;
 
 		gpio0: gpio@fdd60000 {
 			compatible = "rockchip,gpio-bank";
@@ -1808,6 +1808,7 @@ gpio0: gpio@fdd60000 {
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1819,6 +1820,7 @@ gpio1: gpio@fe740000 {
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 32 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1830,6 +1832,7 @@ gpio2: gpio@fe750000 {
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 64 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1841,6 +1844,7 @@ gpio3: gpio@fe760000 {
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 96 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
@@ -1852,6 +1856,7 @@ gpio4: gpio@fe770000 {
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
+			gpio-ranges = <&pinctrl 0 128 32>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-- 
2.39.2

