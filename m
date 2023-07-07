Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F88D74AC45
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjGGHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjGGHuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:50:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601D71FDD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:50:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31438512cafso1594999f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688716212; x=1691308212;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xzJZgWFeHHGjXKAh4OaYqE3z7DeRElG2dg11xE9GqWA=;
        b=Wq7nkwenow+m00LJH3DXwOFMahQtljMEay80GmxnhXkPnM7oEDXjB+XHrOvcvOL6VC
         IIKGioCQeaAbTesF9F7eJnsPQ/4s23aH7LrJTC8fLkRsOZDlXboPDyxNIKjWBh7NgKn8
         YcgjiRf+gPoarIPP0tfnqZN0hMN3gNVe/A1BDPAU6Lxme6ofNMtWM8LYwU6FH0JiE7pa
         jo20zRz+up4lQWkYYC0acljJ6Kn6/S6LQB1ZHFh/drYq1dRA3WHjFw7MFjDxG/c9a/tt
         fElyV75oHDKkg+mls8gWZvv4nNyagJW3nP6qR3Ika4l/EXGHBMNpA6/79pVWMsGyHHWG
         z+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716212; x=1691308212;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzJZgWFeHHGjXKAh4OaYqE3z7DeRElG2dg11xE9GqWA=;
        b=larcVQRl6bFohSnJ3zOqTbRd1r/OxuKL4MZ8+IIUSV2P91Wt4FCq65K+2Oc2S1UsMt
         UVqzFY60vJpa7jQ+M7Wrhm85d+OQnpHul0taWpQzJvGPjABkYPK4iVqTc5R2DAy4/m1w
         0ECrjjDnbymsXxaayod90vuLtNhckPsScT5FFQNM3Ti0IZvW5m96/6Rjhn8+gGoin6/E
         b0ukROADItCsPz9xaieHbnuicwh1E3oyPIXfnjCsMLx3FmKGNXe1nE97HjWZ3AB2vTPx
         8Z1OXjiY99tafJrkRuQWpzrIt5AIJGBYyriN2B2Pt444C//FzfIdj2f0cnAeLZm9cvBI
         Ybmg==
X-Gm-Message-State: ABy/qLb2Nt3vL2tJ+hWCXeYJ5ZUuIugm9jC0biGjO/xvN4cSzANykt3A
        slTtXl7szq6OmMMs8kRP0fitow==
X-Google-Smtp-Source: APBJJlG5qX5zH+MbgQHt6l/RMXUjACz3YLpcUYX5x8n+MEzfvZ3cxiLnB41OwzrgRLGnyXmawFSZDQ==
X-Received: by 2002:adf:e581:0:b0:314:3587:ec72 with SMTP id l1-20020adfe581000000b003143587ec72mr3624852wrm.69.1688716211912;
        Fri, 07 Jul 2023 00:50:11 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b00313e4d02be8sm3763868wrr.55.2023.07.07.00.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:50:11 -0700 (PDT)
Message-ID: <b2205518-67bd-85a2-6af7-260dcf21416c@linaro.org>
Date:   Fri, 7 Jul 2023 09:50:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 3/4] soc: c3: Add support for power domains controller
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230707003710.2667989-4-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 02:37, Xianwei Zhao wrote:
> Add support for C3 Power controller. C3 power control
> registers are in secure domain, and should be accessed by SMC.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: Fixed some formatting.
> ---
>   drivers/soc/amlogic/meson-secure-pwrc.c | 26 +++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/soc/amlogic/meson-secure-pwrc.c b/drivers/soc/amlogic/meson-secure-pwrc.c
> index c11d65a3e3d9..a1ffebf70de3 100644
> --- a/drivers/soc/amlogic/meson-secure-pwrc.c
> +++ b/drivers/soc/amlogic/meson-secure-pwrc.c
> @@ -11,6 +11,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_domain.h>
>   #include <dt-bindings/power/meson-a1-power.h>
> +#include <dt-bindings/power/amlogic,c3-pwrc.h>
>   #include <dt-bindings/power/meson-s4-power.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/firmware/meson/meson_sm.h>
> @@ -120,6 +121,22 @@ static struct meson_secure_pwrc_domain_desc a1_pwrc_domains[] = {
>   	SEC_PD(RSA,	0),
>   };
>   
> +static struct meson_secure_pwrc_domain_desc c3_pwrc_domains[] = {
> +	SEC_PD(C3_NNA,	0),
> +	SEC_PD(C3_AUDIO,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_SDIOA,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_EMMC,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_USB_COMB, GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_SDCARD,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_ETH,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_GE2D,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_CVE,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_GDC_WRAP,	GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_ISP_TOP,		GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_MIPI_ISP_WRAP, GENPD_FLAG_ALWAYS_ON),
> +	SEC_PD(C3_VCODEC,	0),
> +};
> +
>   static struct meson_secure_pwrc_domain_desc s4_pwrc_domains[] = {
>   	SEC_PD(S4_DOS_HEVC,	0),
>   	SEC_PD(S4_DOS_VDEC,	0),
> @@ -202,6 +219,11 @@ static struct meson_secure_pwrc_domain_data meson_secure_a1_pwrc_data = {
>   	.count = ARRAY_SIZE(a1_pwrc_domains),
>   };
>   
> +static struct meson_secure_pwrc_domain_data amlogic_secure_c3_pwrc_data = {
> +	.domains = c3_pwrc_domains,
> +	.count = ARRAY_SIZE(c3_pwrc_domains),
> +};
> +
>   static struct meson_secure_pwrc_domain_data meson_secure_s4_pwrc_data = {
>   	.domains = s4_pwrc_domains,
>   	.count = ARRAY_SIZE(s4_pwrc_domains),
> @@ -212,6 +234,10 @@ static const struct of_device_id meson_secure_pwrc_match_table[] = {
>   		.compatible = "amlogic,meson-a1-pwrc",
>   		.data = &meson_secure_a1_pwrc_data,
>   	},
> +	{
> +		.compatible = "amlogic,c3-pwrc",
> +		.data = &amlogic_secure_c3_pwrc_data,
> +	},
>   	{
>   		.compatible = "amlogic,meson-s4-pwrc",
>   		.data = &meson_secure_s4_pwrc_data,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
