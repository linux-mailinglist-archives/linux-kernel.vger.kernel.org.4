Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36590653650
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbiLUS1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiLUS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:27:35 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256EF2654B;
        Wed, 21 Dec 2022 10:27:34 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z92so23255613ede.1;
        Wed, 21 Dec 2022 10:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3spaG/gmW2iurMqKAzeqtwdB73qDEY0NRjhBceQ6XKs=;
        b=HJYnALiuBC4czUJZQZMxToOk+mUn6hrTGkmT7s0lKwO+15/vlhSGhhp6Q0iPWhrq5q
         jOWyUmDPVqgwiEsndnL+9LELnFj6lN0IgQeahNtuNDeD6I+9cH8auJHEXoqQv84Uuol5
         erYbwdjgpaNPJ9tz9g2UA2S8H0NMz3Yi4TJpRa5YJt1y9Y9GRdzXybOKpJCs/fMECfbH
         G2gKgF0DKSGU8Fk9hd9k8cR46MpIslUAKhz0qYKLV5PwwtfWAx5Vz1WI462A8uNdCQbq
         2TN9iKaJ2Cd+e32bc8z/xsyMN47sBiKojufwCMUHB5x7LY21rNIoTndGXIUyaY/jRZC3
         b56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3spaG/gmW2iurMqKAzeqtwdB73qDEY0NRjhBceQ6XKs=;
        b=gADQdR1JoPiAl2IT7pfN5xG1GzDtdXX/bkkOkk65+0n+7si/ZsWbbLMxezoIbhiGEL
         wnMm5TmyIYVwWGAvPkvG4p68bHadG3s1Q8QiOlJcEretb+xaF1tHAlDCMcW14zeRLwhT
         8i8cvDyDIsOjYIzVFle6Q/qBZGLcPI4kMgtXUYD/aWBLxGGK0TNNxIpq6TMFPv2aiaPj
         jKS/NiSjJieZ/HOdfXj2Iqkh4ld5kRnq9t3rSmFN0o93YVfsXmFimN/2Vxshdu6VVsQx
         9Ax7kHC1o6zU63WKudlrGc+fl9cja1cwblNnUMf6aNnsraZB/0EIj45cksgjfhTEcnpx
         4r6A==
X-Gm-Message-State: AFqh2ko2sqtXYF+1n2KbzfjArXH2yDXDbKMU+MDRlMcPRPmALnI1M3Eu
        sIXi62W3zSsj9NeTaB1CQro=
X-Google-Smtp-Source: AMrXdXuuboy0Cy7pIoYaHpGBK0/px3c7JvHO5JGIK2vGuTSmoniRYvRFRSPlPt/0TZewWYO1okg75Q==
X-Received: by 2002:a05:6402:685:b0:479:ab7d:1dad with SMTP id f5-20020a056402068500b00479ab7d1dadmr2840833edy.32.1671647252722;
        Wed, 21 Dec 2022 10:27:32 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w26-20020a056402129a00b0046dd0c2a08esm7351683edv.36.2022.12.21.10.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:27:32 -0800 (PST)
Message-ID: <621bc5c4-340e-683d-fa61-520b9ed45e1e@gmail.com>
Date:   Wed, 21 Dec 2022 19:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 12/12] arm64: dts: rockchip: rk356x: remove hclk from dsi
 node
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hclk is not used in the dw-mipi-dsi-rockchip.c driver,
so remove hclk from the rk356x.dtsi dsi node.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 5706c3e24..2cb61a783 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -743,8 +743,8 @@
 		compatible = "rockchip,rk3568-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x00 0xfe060000 0x00 0x10000>;
 		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-		clock-names = "pclk", "hclk";
-		clocks = <&cru PCLK_DSITX_0>, <&cru HCLK_VO>;
+		clock-names = "pclk";
+		clocks = <&cru PCLK_DSITX_0>;
 		phy-names = "dphy";
 		phys = <&dsi_dphy0>;
 		power-domains = <&power RK3568_PD_VO>;
@@ -771,8 +771,8 @@
 		compatible = "rockchip,rk3568-mipi-dsi", "snps,dw-mipi-dsi";
 		reg = <0x0 0xfe070000 0x0 0x10000>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
-		clock-names = "pclk", "hclk";
-		clocks = <&cru PCLK_DSITX_1>, <&cru HCLK_VO>;
+		clock-names = "pclk";
+		clocks = <&cru PCLK_DSITX_1>;
 		phy-names = "dphy";
 		phys = <&dsi_dphy1>;
 		power-domains = <&power RK3568_PD_VO>;
--
2.20.1

