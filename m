Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8062773438F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbjFQUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbjFQUgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:36:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FC4E6E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:36:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510d6b939bfso2849003a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687034205; x=1689626205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2aJz+RT/xyq0N/i2nhfM+NmOZutl67Cvwf+2Z6rBvnE=;
        b=KgsFph9+3TeTFwsHIYPeBYpJGSM/BFb++KvNOt2lJShBCESxyFR2hxFgEjCTMnSMUo
         if2aBcWChwui//SHSR/ZwfojH6ZW7hE9SIBnTWXfZzW6ERo0bAovKD5h6aILaY+1vFQl
         GHncrOxQze3YycrmK5cGDccCYic6U3TE+wp3LaYYERZAHa6LzOhEtedUcUauEOFC3C2g
         E1kG9DA+Q4jGt5iYKJi6JTg8dhSLesRpLPNKP78FzjZkA9fC+m5XRM6hyr8+HOKHGRp2
         DcYPP+9kjd9mrlc2UoFq+hOUYaQxXVoiYm19bLatwuKiGXN5j8GBWSVjcQlIboNpQVnt
         W4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687034205; x=1689626205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2aJz+RT/xyq0N/i2nhfM+NmOZutl67Cvwf+2Z6rBvnE=;
        b=SRWiilUTo38IRfFdEr/Wr8+XRhCZiW7ZKAzvxLbX1mcqNRdd7RGxW0lenGtbi4rX1K
         CbYzDC6pQi4Ul9AqO6p56BJIMOt7VCJprE3Nd+DG0auD6WKUqe1s4dTw304LmQb++A1F
         cZloGmNkhlI5LpIGf7LqaZGjkXocQWW6/1UI3dIQYDulr5MlN866Gi1ZrYWbfY7OnUa4
         NC3dUgq5cwn1c2wfDQCqDlU7czKe0mOuUhKYXDeMa9cEGCf6hs6RdQgyzXiuhQ1NgzmX
         VimDcQpdCMY916tnQDV36i1rDEQ+qMvblHNByoVP614QR+2p/WtATjRgwLYuXx5ZcoUy
         hVUw==
X-Gm-Message-State: AC+VfDwXYtatln2g5PxPr8VNR8zsAyxVTWYLhogFn77KiW9J5++Jo+iq
        qf1Ygws5SaeSg5II3n/mZMK9AA==
X-Google-Smtp-Source: ACHHUZ7YPFcNDwh5hs6abIefKOUQ+hQDS6/+wrmEAKKAg1RNr7W9xWwIqfkUZ7FXupdhoF1WejLc/A==
X-Received: by 2002:a17:907:3f87:b0:97d:9b73:690b with SMTP id hr7-20020a1709073f8700b0097d9b73690bmr6103013ejc.59.1687034205126;
        Sat, 17 Jun 2023 13:36:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090668c900b0098242730348sm6313405ejr.72.2023.06.17.13.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 13:36:44 -0700 (PDT)
Message-ID: <9e9c9f70-7b02-900f-36b9-27c734c12721@linaro.org>
Date:   Sat, 17 Jun 2023 22:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] arm64: dts: freescale: Add support for LX2162 SoM
 & Clearfog Board
Content-Language: en-US
To:     Josua Mayer <josua@solid-run.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>
References: <20230617134009.23042-1-josua@solid-run.com>
 <20230617134009.23042-5-josua@solid-run.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617134009.23042-5-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 15:40, Josua Mayer wrote:
> Add support for the SolidRun LX2162A System on Module (SoM), and the
> Clearfog evaluation board.
> 
> The SoM has few software-controllable features:
> - AR8035 Ethernet PHY
> - eMMC
> - SPI Flash
> - fan controller
> - various eeproms
> 
> The Clearfog evaluation board provides:
> - microSD connector
> - USB-A
> - 2x 10Gbps SFP+
> - 2x 25Gbps SFP+ with a retimer
> - 8x 2.5Gbps RJ45
> - 2x mPCI (assembly option / disables 2xRJ45)
> 
> The 8x RJ45 ports are connected with an 8-port PHY: Marvell 88E2580
> supporting up to 5Gbps, while SoC and magnetics are limited to 2.5Gbps.
> 
> However 2500 speed is untested due to documentation and drivier
> limitations. To avoid confusion the phy nodes have been explicitly
> limited to 1000 for now.
> 
> The PCI nodes are disabled, but explicitly added to mark that this board
> can have pci.
> It is expected that the bootloader will patch the status property
> "okay" and disable 2x RJ45 ports, according to active serdes configuration.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> V1 -> V2: reordered "compatible" and "reg" properties
> V1 -> V2: replaced chip-specific DT node names with generic ones
> 
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/fsl-lx2162a-clearfog.dts    | 371 ++++++++++++++++++
>  .../dts/freescale/fsl-lx2162a-sr-som.dtsi     |  75 ++++
>  3 files changed, 447 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index ef7d17aef58f..b4fb5044d1c7 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -34,6 +34,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-honeycomb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-qds.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2162a-clearfog.dtb
>  

...

> +
> +&fspi {
> +	status = "okay";
> +
> +	flash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;

Still wrong order of properties. compatible is always first, then reg.

Best regards,
Krzysztof

