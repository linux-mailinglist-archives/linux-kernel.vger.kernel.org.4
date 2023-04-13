Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91E46E131B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDMREf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjDMREa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:04:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB017D8E;
        Thu, 13 Apr 2023 10:04:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t16so3265585ybi.13;
        Thu, 13 Apr 2023 10:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681405467; x=1683997467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYntzwA2QnPK9xOrgshDrAFUujV3P0eNxGswFpFhQIk=;
        b=sM2sUKt9yEmz9cXYenp9w3rAdPtPDxXn5V00HanFFuNjensfF+Us6VTipZGJBgNVB5
         L+ydky9CuQxAva8RGKpp5QmWSVhgLxHwWy9cF6bGzvFArG1+KpsNI8JRZlH1TIyyjADC
         3YkYHxQwv8urME75tdYyX+pTuXz7C6qjwHzURon2oiUo9zx9HAoXTTyKAN1MkgS8Z+SG
         J9YTiAqLCEKD2s9jduzRpcjsvNhqa6v7vru+zGfmy0Kj+B0tta95TurO4yzG5VpPNsS1
         3A8BYGlILPiizjVPZBqcN14ZBXdClgpg70tYejRqqZ0KozFUUng55C7Z4rouWd/ZOqQS
         rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405467; x=1683997467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYntzwA2QnPK9xOrgshDrAFUujV3P0eNxGswFpFhQIk=;
        b=J8qL2nQMoSZnzwu/VzCbH65BAwtsh2ImWwTe/EGdv4+PEPK72HO7zR6G9SWLzSkA4y
         20ARex0Djrr5cbQ8iHAYdFjrBJzSHymSvsIHHBc9pir9kXP2Wv0p/A2gt51q6FhFdb0U
         oQ5XjTXkhbMquJWq+LBLXgwAlvyplS/DmysgY2Cc0l9e8++0f8IR7WZqx0//ejc66pOc
         2qxckWDPgQlwwQ3cN2xIweL9LXY30zKhGr9TKjw1l+R9tiLVyPDrvqlZh4Le3TT6dPZ4
         B9BD+RJ06LTgQNR7awAM3Dw9IoosCO33X2LWPKSunjrZc6QOG2Zsjp2HQEv++uBGBU1V
         IXgg==
X-Gm-Message-State: AAQBX9cOL9YxzWHUbVItBKjBapDnBRa9OppmivxHSD21Cjrj1E5GQupa
        /1fmQsGY8wTPK1PqWY7o10M=
X-Google-Smtp-Source: AKy350b5fAtiBx82KDTxqb9UUWUZXaxIURJwS64DLKUDnQ189qF+erBNEuCZxSLRT5D8yFzEjrs5LQ==
X-Received: by 2002:a25:2b4a:0:b0:b7d:d397:5c51 with SMTP id r71-20020a252b4a000000b00b7dd3975c51mr2557400ybr.17.1681405467692;
        Thu, 13 Apr 2023 10:04:27 -0700 (PDT)
Received: from localhost.localdomain ([98.58.151.237])
        by smtp.googlemail.com with ESMTPSA id e189-20020a2537c6000000b00b8f46c4b4casm572591yba.20.2023.04.13.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 10:04:27 -0700 (PDT)
From:   John Clark <inindev@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        John Clark <inindev@gmail.com>
Subject: [v2] arm64: dts: rockchip: Add pinctrl gpio-ranges for rk356x
Date:   Thu, 13 Apr 2023 13:03:37 -0400
Message-Id: <20230413170337.6815-1-inindev@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413144316.4247-1-inindev@gmail.com>
References: <20230413144316.4247-1-inindev@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 802fcc96384e..f62e0fd881a9 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
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

