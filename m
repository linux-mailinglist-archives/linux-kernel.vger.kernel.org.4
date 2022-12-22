Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3823F65432F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiLVOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLVOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:33:53 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F81903D;
        Thu, 22 Dec 2022 06:33:52 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jo4so5321705ejb.7;
        Thu, 22 Dec 2022 06:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3spaG/gmW2iurMqKAzeqtwdB73qDEY0NRjhBceQ6XKs=;
        b=CRqcUNirJ7ntkMUU3JTGsOB20UlhBrxRoqyYx/3ZS4wzpgONJrG2I2eRg06hDXUMcN
         CGWzv1hqWty3MdmlDNEkmXm5Wvd75JsO30NtYG6rUExTOsSTd2ejWM/Ph0Vvl4znq5cR
         ASJyzhJg7dtPga9J3IzuVm8cO4HrT5GWRX5Z2wnWWU8R+ioOxrk5PylVbB6v7DZuFC0I
         LJ6OcTUs0vB5PaNojBTWE7NVnvc8iR57BDNCFcPC5dyI2v2Z41IO48C8khaMVX+F2wOH
         2itQG6e4aRjBmTmFUmWle4aNRLym2mhAYcibcMvG+bDMR8Ho8oYFuUC6WFf/Q1+viOC9
         GsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3spaG/gmW2iurMqKAzeqtwdB73qDEY0NRjhBceQ6XKs=;
        b=qPB8+OvS5Qf8AbLQtbP5a21xgHSuPpVASEUTaPJZTsY/ZtUvBwweUX60x/DCOGHjAv
         Mo3Eh2Z4ryzKuf1G0L1AilxbzNwfi1p5G5/NxkXv7ep9LYShpJ9Tt947HGKnvX91O4UR
         TGaxgM2anEOozpwZM92gGLYIxpapXJspLyHN+/LQas20N6ID7rnmx17XLMyotfAIudpn
         Rt8o0H3RU+bgto3j1GgVTFfVGOz4C1bXuwLNeQgovD11J7UPipVIdDd2Z1EVxbdzCdq6
         +o4PaH5RPJadvNX5c2XdDbYBfGxB4eP1gCwA5hAvoK5MR3Em+a0eN2SlpL6xx+rkvwrA
         8GFg==
X-Gm-Message-State: AFqh2kosErui76+V+WlLqRonRDt0jojNvhr3PxjTZh21/2qmYWAhUiDG
        oEcRkFnW1V7M7JxJOx5mwsE=
X-Google-Smtp-Source: AMrXdXs5nNL5GxAUeP1wdSH8AGyRtbt3ZUxJM9gwb+vJpq0IniGq4U7xZeYGlX3TVYis4RhsdPUVwQ==
X-Received: by 2002:a17:907:6d95:b0:7c0:aabd:fef0 with SMTP id sb21-20020a1709076d9500b007c0aabdfef0mr5674298ejc.17.1671719630737;
        Thu, 22 Dec 2022 06:33:50 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170907985400b007c0b6e1c7fdsm304754ejc.104.2022.12.22.06.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:33:50 -0800 (PST)
Message-ID: <4df211eb-4fcd-ee20-48a1-ce7712de552c@gmail.com>
Date:   Thu, 22 Dec 2022 15:33:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 17/17] arm64: dts: rockchip: rk356x: remove hclk from dsi
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
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

