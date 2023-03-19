Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F046C046D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCSTg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 15:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCSTgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 15:36:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21014E8A;
        Sun, 19 Mar 2023 12:36:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cy23so39055374edb.12;
        Sun, 19 Mar 2023 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679254582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7L1LqFV6h0eVxcrS19DAAOXoiewf/UfXtUU8YR+EZ8=;
        b=VXK8qKk8Qgt8PyfEPszQSWYU35fN9eomwlpIhaShMc1cvh/KyLq9zLQ3trY9ePHsyN
         zJfErAwUceFATZ/j4aquZTRnWXhOhtR0RaNUxKm8VbuJMzp68eqiINuDVZf76uSzY8n7
         0hkbxIqxt+Z2Ss8+L7/KaaXXZbT0uhX3h31MFu6/0x+NkvGpoKH/RZTtckBhAeMK3sxs
         GE73JIP+uo0HcczFU+Y8pWqs2K+8sOqQRZUBnWXS9VQztT5XfqVcA6wyUF2FgAsZ7L7S
         BO8AL9lkqzYJ9J5AdD8brCwPa7QxkvjSWsAhBGt9pcr7qEhQT45Bq2NQsqhH2HCH+oc9
         +pVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679254582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7L1LqFV6h0eVxcrS19DAAOXoiewf/UfXtUU8YR+EZ8=;
        b=EtNsr4cSQs/GiRIdMxOXeyEku1wRX6P2TFRcbSdFdv00uQPM2Z1kHVUt+kh95TS1ei
         FMzff0MTRsNR9lbKQ87v/GKatt08vmqo9JXhvF6+uy7XCjfem7q137R9YAK4VVvddsmO
         Zu9BYWjBG99LW0B3kcEVeqyneKYrmjmssG9ffDzOwVx7cV8OdjAkVAFa3CoSiUmPkrHv
         F4o6I7nNqkgOgW4WMW4KLJb6BB89xwePWqzoXqXXsN9wjOOqwV7qOPbhUYFcdJJVXvg/
         ZQ9WlX1Zv8OKF78T/E2R50+e6jnmifCD1UFxMxtJ7hrLQPWVELf7hUYU2d5vQIOmWxUT
         tKnQ==
X-Gm-Message-State: AO0yUKUHwZuEkUDXmF5qUh+jri2qN+44l640VBBFi+aj2u0mYTPYGwc/
        zJUhPpH72k4THwU4d2T+gWWVy2gPQ8U=
X-Google-Smtp-Source: AK7set+K/7xKEFbJZW+IljzIrB1qb3ySKS9W32jzKyfVll8cr0qtIl0DsdZbSYQLF2fM7ect5yrT2w==
X-Received: by 2002:aa7:c948:0:b0:4bf:5981:e59f with SMTP id h8-20020aa7c948000000b004bf5981e59fmr8940849edt.6.1679254581675;
        Sun, 19 Mar 2023 12:36:21 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u3-20020a50d503000000b004fcd78d1215sm3916868edi.36.2023.03.19.12.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 12:36:21 -0700 (PDT)
Message-ID: <591bf126-1ab7-8a5d-0d3a-1cac4cd9b112@gmail.com>
Date:   Sun, 19 Mar 2023 20:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64/arm: dts: rockchip: Fix DSI node names
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230319174105.43978-1-robh@kernel.org>
Content-Language: en-US
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20230319174105.43978-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/23 18:41, Rob Herring wrote:
> DSI bus/controller nodes should be named 'dsi' rather than 'mipi'.

There's already a serie that does that.
Lack of communication becomes common. 
More thing must be fixed to comply then this patch alone.

[PATCH v6 09/17] ARM: dts: rockchip: rk3288: fix dsi node
https://lore.kernel.org/linux-rockchip/f3edcbff-4aef-1d24-8d65-e519c9451cda@gmail.com/

[PATCH v6 15/17] arm64: dts: rockchip: rk3399: fix dp node
https://lore.kernel.org/linux-rockchip/f6008819-db9b-0944-3f5b-5522b7cd8a8d@gmail.com/

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi            | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2ca76b69add7..d401b850583c 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1114,7 +1114,7 @@ vopl_mmu: iommu@ff940300 {
>  		status = "disabled";
>  	};
>  
> -	mipi_dsi: mipi@ff960000 {
> +	mipi_dsi: dsi@ff960000 {
>  		compatible = "rockchip,rk3288-mipi-dsi", "snps,dw-mipi-dsi";
>  		reg = <0x0 0xff960000 0x0 0x4000>;
>  		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 1881b4b71f91..e44e1c40c0ba 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1954,7 +1954,7 @@ hdmi_in_vopl: endpoint@1 {
>  		};
>  	};
>  
> -	mipi_dsi: mipi@ff960000 {
> +	mipi_dsi: dsi@ff960000 {
>  		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
>  		reg = <0x0 0xff960000 0x0 0x8000>;
>  		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH 0>;
> @@ -1990,7 +1990,7 @@ mipi_in_vopl: endpoint@1 {
>  		};
>  	};
>  
> -	mipi_dsi1: mipi@ff968000 {
> +	mipi_dsi1: dsi@ff968000 {
>  		compatible = "rockchip,rk3399-mipi-dsi", "snps,dw-mipi-dsi";
>  		reg = <0x0 0xff968000 0x0 0x8000>;
>  		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH 0>;
