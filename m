Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24165690297
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBII4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBII4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:56:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944DC59B64
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:56:13 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o18so1030644wrj.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vHXX9qLhodXXJcCyIc4Vb3hchdgHIWSikItEAmQCVMQ=;
        b=g2Tfj7rKtBD1AuogPIrMy5aMbYbFNiM++NPZVSP0TI1bU+NHwBROucFRpRHScfM2e4
         BLoraHq/ID3W7xW/xQRcHr7F+/mXzcmnP+m0adgIEZ3mLLn5UEu6bOVBPsAH48CIl789
         Jahr/klPPCXsU2jDrL2Elz/hogFAX/dDqpOeH6NgVycdWprmDSTqNxZRdiv8TKhgCgiS
         ZqRv/+KHPODXGI+x3dv04BHntUEoq8fzvX0ClbaecaHpA0wu5DEF1D4qkJfFbpRktKZo
         bhtXdwmHnmo4aQSyRww0HCirCFY8wUUvBCI60Dinb/B6IG9Y1AEYaFbAGSe6ywkkUY7G
         pLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHXX9qLhodXXJcCyIc4Vb3hchdgHIWSikItEAmQCVMQ=;
        b=W5i4ByKeTTF8kI7Jpz55L8DRTrI/fHY0Q/qoQIPdwfeoG5cgCyiS/uySp+crEtfbg0
         P20qqlbCMxQ7tjHyzmgJvFS7N87NqO/tKKQtkWwipcGw9WgUoqEKx2m6WJJPUYykyTZq
         zd8zglheQIHu20yBWyMnaJeCNFIymIHFt+NFqmQZmOLkxWpVOwrCoejn11DMEkHAX7vF
         tb89e1La8zj1juMvA2++cF/URQyb9q2jdG/V2ELE2zU5CGQvH55hINIuy6SYsjYASDJg
         gVMzCn/N+jQ0djc0DFdgp3NCWsaa4s+bASxamerA+zrACUNc2QyNKEfQCmBK4SxXREM+
         G/hA==
X-Gm-Message-State: AO0yUKXVYD2fDYxC/395D8EFNP9oizJ2xPtxwsIHso3sgEHQOTWA5L2J
        HAyDRRXsN/vFbC9ApmXktRv2/A==
X-Google-Smtp-Source: AK7set95IUJycacSsfuYlNaj8SvE/JO9E7p9MGBwzi5qVRVbawo9mppg1aUUqxY0a9BTuH9/G4LRJA==
X-Received: by 2002:a05:6000:1003:b0:2c4:745:13b8 with SMTP id a3-20020a056000100300b002c4074513b8mr2640568wrx.42.1675932972215;
        Thu, 09 Feb 2023 00:56:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id t2-20020adfe102000000b002c3f280bdc7sm711008wrz.96.2023.02.09.00.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:56:11 -0800 (PST)
Message-ID: <e2587e59-c735-0328-2695-96048ad77836@linaro.org>
Date:   Thu, 9 Feb 2023 09:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] ARM: dts: r9a06g032: add EB board device-tree
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?Q?Miqu=c3=a8l_Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230207145444.166950-1-clement.leger@bootlin.com>
 <20230207145444.166950-3-clement.leger@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230207145444.166950-3-clement.leger@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2023 15:54, Clément Léger wrote:
> The EB board (Expansion board) supports both RZ/N1D and RZ-N1S. Since this
> configuration targets only the RZ/N1D, it is named r9a06g032-rzn1d400-eb.
> It adds support for the 2 additional switch ports (port C and D) that are
> available on that board.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  arch/arm/boot/dts/Makefile                  |  1 +
>  arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts | 92 +++++++++++++++++++++
>  2 files changed, 93 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d08a3c450ce7..8938db01e939 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1123,6 +1123,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
>  	r8a7794-alt.dtb \
>  	r8a7794-silk.dtb \
>  	r9a06g032-rzn1d400-db.dtb \
> +	r9a06g032-rzn1d400-eb.dtb \
>  	sh73a0-kzm9g.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rv1108-elgin-r1.dtb \
> diff --git a/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> new file mode 100644
> index 000000000000..e986b6d2fd6f
> --- /dev/null
> +++ b/arch/arm/boot/dts/r9a06g032-rzn1d400-eb.dts
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the RZN1D-EB Board
> + *
> + * Copyright (C) 2023 Schneider-Electric
> + *
> + */
> +
> +#include "r9a06g032-rzn1d400-db.dts"
> +
> +/ {
> +	model = "RZN1D-EB Board";
> +	compatible = "renesas,rzn1d400-eb", "renesas,r9a06g032";
> +};
> +
> +&mii_conv2 {
> +	renesas,miic-input = <MIIC_SWITCH_PORTD>;
> +	status = "okay";
> +};
> +
> +&mii_conv3 {
> +	renesas,miic-input = <MIIC_SWITCH_PORTC>;
> +	status = "okay";
> +};
> +
> +&pinctrl{
> +	pins_eth1: pins_eth1 {

No underscores in node names, unless you override existing node with
such underscore.

Best regards,
Krzysztof

