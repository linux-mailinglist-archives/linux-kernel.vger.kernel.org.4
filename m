Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF006F7D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjEEGsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjEEGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:48:47 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A36A10C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 23:48:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so8996835e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 23:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683269319; x=1685861319;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rtN4oMlLlW4QqPQK8hFrv2bFItCp38Em6zDqy+ipvU0=;
        b=vO64qFhPeibbS/4AnTmWdoubVj/CcofJxbAXZG/2Y41HCD8tEwUGQEAjL8Sz3L3eMs
         LX/ry87diVtXsDk7srORWbWqwT+k9/SZhmiyEKoEzgUQj2bMyRIUL81E/3Xwwg3ExmOw
         MnLFZTa74zhK27T1vBLe1iNQuBenPHS+6X796U60BA+st7TbsDSwZYng5oMS58UgsTkT
         Mcnd80H/psqnwPUKwpicj2P+9Hl2zThdDJXYaD8q/ZLjbCy710sZxkU09/THy/BNTJDu
         6R8/KOUqdOiywRkmnOTYsWbnfVME+I28TOkiFHi6Z96CzhPT1zTaNHemCKRNorXI4cXm
         zEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683269319; x=1685861319;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rtN4oMlLlW4QqPQK8hFrv2bFItCp38Em6zDqy+ipvU0=;
        b=C9KoLzjxpgLLoq0QF0N1Seby5RjPkVy3g7H2DnTdJNiWR6m0xi7GIACj8V0b/vIO/G
         x55bJsUy2tL95OWzhONdt309+aLPGOAGXXm7wN7n5pfZJI3AN0W2/x/SA2FgrcS7lxdL
         e5DPSYKMQGzPquK0HG/4WCBKkBXDANRejBgxCmyJ/yEDlgsGNT54esqxOgwMN53lrsNG
         MpUNjyA2y/ySlPljW0TjaI+3Ht72ulPQ3F1Fopj2JUavhPTjXkqC6EOkErJ9LCB42iNj
         /J78rRSXEIMZYCcMGjJW+T7d5yjxN6Koz551D+rOgOZcDDAtFjVrhxrVJ+vc7f+jeT3u
         ZSxw==
X-Gm-Message-State: AC+VfDwVqAA6uS+jXtdxZ7Qek+NidwdvRbM/joA2IhMcJXuZzolLUE4q
        69Cajy+zlsVw2juFU2ZYYe4LcA==
X-Google-Smtp-Source: ACHHUZ4870aZXVeMzfgUOk5ToMNkHvIEW8SwW9PQdL63ZDDVaN64SJlt5Tv4kXOtRHhXWGxGJirb4w==
X-Received: by 2002:a1c:f310:0:b0:3f1:74bd:bc22 with SMTP id q16-20020a1cf310000000b003f174bdbc22mr250544wmq.6.1683269319442;
        Thu, 04 May 2023 23:48:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f548:bbaf:d95f:43ff? ([2a01:e0a:982:cbb0:f548:bbaf:d95f:43ff])
        by smtp.gmail.com with ESMTPSA id x2-20020a05600c21c200b003f182c11667sm6993181wmj.39.2023.05.04.23.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 23:48:38 -0700 (PDT)
Message-ID: <6f6afb3c-ae8b-5b33-1b51-2e97148c249b@linaro.org>
Date:   Fri, 5 May 2023 08:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/4] ARM: dts: Move .dts files to vendor sub-directories
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, soc@kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Persson <lars.persson@axis.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Wei Xu <xuwei5@hisilicon.com>,
        Jean-Marie Verdun <verdun@hpe.com>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Peter Rosin <peda@axentia.se>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Daniel Palmer <daniel@thingy.jp>,
        Romain Perier <romain.perier@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Marek Vasut <marex@denx.de>, Qin Jian <qinjian@cqplus1.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Paul Barker <paul.barker@sancloud.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
References: <20230504-arm-dts-mv-v1-0-2c8e51a2b6c4@kernel.org>
 <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20230504-arm-dts-mv-v1-4-2c8e51a2b6c4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 05:29, Rob Herring wrote:
> The arm dts directory has grown to 1553 boards which makes it a bit
> unwieldy to maintain and use. Past attempts stalled out due to plans to
> move .dts files out of the kernel tree. Doing that is no longer planned
> (any time soon at least), so let's go ahead and group .dts files by
> vendors. This move aligns arm with arm64 .dts file structure.
> 
> Doing this enables building subsets of dts files by vendor easily
> without changing kernel configs:
> 
> make allyesconfig
> make arch/arm/boot/dts/ti/
> 
> There's no change to dtbs_install as the flat structure is maintained on
> install.
> 
> The naming of vendor directories is roughly in this order of preference:
> - Matching original and current SoC vendor prefix/name (e.g. ti, qcom)
> - Current vendor prefix/name if still actively sold (SoCs which have
>    been aquired) (e.g. nxp/imx)
> - Existing platform name for older platforms not sold/maintained by any
>    company (e.g. gemini, nspire)
> 
> The whole move was scripted with the exception of MAINTAINERS.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   MAINTAINERS                                        |  181 +--

<snip>

>   arch/arm/boot/dts/amlogic/Makefile                 |    9 +
>   arch/arm/boot/dts/{ => amlogic}/meson.dtsi         |    0
>   arch/arm/boot/dts/{ => amlogic}/meson6-atv1200.dts |    0
>   arch/arm/boot/dts/{ => amlogic}/meson6.dtsi        |    0
>   .../boot/dts/{ => amlogic}/meson8-minix-neo-x8.dts |    0
>   arch/arm/boot/dts/{ => amlogic}/meson8.dtsi        |    0
>   arch/arm/boot/dts/{ => amlogic}/meson8b-ec100.dts  |    0
>   arch/arm/boot/dts/{ => amlogic}/meson8b-mxq.dts    |    0
>   .../boot/dts/{ => amlogic}/meson8b-odroidc1.dts    |    0
>   arch/arm/boot/dts/{ => amlogic}/meson8b.dtsi       |    0
>   .../boot/dts/{ => amlogic}/meson8m2-mxiii-plus.dts |    0
>   arch/arm/boot/dts/{ => amlogic}/meson8m2.dtsi      |    0

<snip>

> @@ -1909,7 +1909,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-amlogic@lists.infradead.org
>   S:	Maintained
>   W:	http://linux-meson.com/
> -F:	arch/arm/boot/dts/meson*
> +F:	arch/arm/boot/dts/amlogic/
>   F:	arch/arm/mach-meson/
>   F:	arch/arm64/boot/dts/amlogic/
>   F:	drivers/mmc/host/meson*

<snip>

> diff --git a/arch/arm/boot/dts/amlogic/Makefile b/arch/arm/boot/dts/amlogic/Makefile
> new file mode 100644
> index 000000000000..a84310780ea3
> --- /dev/null
> +++ b/arch/arm/boot/dts/amlogic/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_MACH_MESON6) += \
> +	meson6-atv1200.dtb
> +dtb-$(CONFIG_MACH_MESON8) += \
> +	meson8-minix-neo-x8.dtb \
> +	meson8b-ec100.dtb \
> +	meson8b-mxq.dtb \
> +	meson8b-odroidc1.dtb \
> +	meson8m2-mxiii-plus.dtb
> diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/amlogic/meson.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/meson.dtsi
> rename to arch/arm/boot/dts/amlogic/meson.dtsi
> diff --git a/arch/arm/boot/dts/meson6-atv1200.dts b/arch/arm/boot/dts/amlogic/meson6-atv1200.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson6-atv1200.dts
> rename to arch/arm/boot/dts/amlogic/meson6-atv1200.dts
> diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/amlogic/meson6.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/meson6.dtsi
> rename to arch/arm/boot/dts/amlogic/meson6.dtsi
> diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson8-minix-neo-x8.dts
> rename to arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/amlogic/meson8.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/meson8.dtsi
> rename to arch/arm/boot/dts/amlogic/meson8.dtsi
> diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/amlogic/meson8b-ec100.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson8b-ec100.dts
> rename to arch/arm/boot/dts/amlogic/meson8b-ec100.dts
> diff --git a/arch/arm/boot/dts/meson8b-mxq.dts b/arch/arm/boot/dts/amlogic/meson8b-mxq.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson8b-mxq.dts
> rename to arch/arm/boot/dts/amlogic/meson8b-mxq.dts
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson8b-odroidc1.dts
> rename to arch/arm/boot/dts/amlogic/meson8b-odroidc1.dts
> diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/amlogic/meson8b.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/meson8b.dtsi
> rename to arch/arm/boot/dts/amlogic/meson8b.dtsi
> diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
> similarity index 100%
> rename from arch/arm/boot/dts/meson8m2-mxiii-plus.dts
> rename to arch/arm/boot/dts/amlogic/meson8m2-mxiii-plus.dts
> diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/amlogic/meson8m2.dtsi
> similarity index 100%
> rename from arch/arm/boot/dts/meson8m2.dtsi
> rename to arch/arm/boot/dts/amlogic/meson8m2.dtsi


<snip>

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

