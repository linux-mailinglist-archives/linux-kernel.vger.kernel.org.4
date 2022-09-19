Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538115BD1EB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiISQK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiISQK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:10:56 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1B124BD8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:10:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i26so47734169lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vz0a4w2GFyT8m3ACo8Kto1JVNekh6584R9ZYJZE84xM=;
        b=jlllRahwq5fc/r6/tku2rInirf9zZga93Nq37DaOGeFJUI4dV4I9Lk/rgL8Mdca/DH
         AmXKnMKE7/gIsU2zd38Z6Mcqx2oAAj31a5ORAeDnz35kmEgEUBonzaA7FZDPlzBgce7x
         B5w2pY6XOkuCWyUsMkJkjBO347uFPpDE3RweGZZoaBdp/5WZksRo/C6eIhUaC/Ka/XWh
         0tGSwl85xfE105VYQW4vT058ZAORdp8KM6ddqVTi6sXv7k+4BX2uBb2R5lRkjTIp4pXA
         gpVH/rrVvylPRObiHwtDkfTf5tTJ3lZFxTvAvIrDpHbOc9s8PW0am3CVF972M+GBV3qi
         E4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vz0a4w2GFyT8m3ACo8Kto1JVNekh6584R9ZYJZE84xM=;
        b=tbDZVIl50kZ8X9CHvu6t1AdsrLWdDvb/DvyKm+vQofB48lJXbq2J4mVafqnE1/eWHw
         aOtPiQEBOm/PTAyFGf3uak+gKzI3AJewdWiobGfHNwkThpqEvTXkg3V42Zn0NBva8BT3
         o1xb7dYJGGIExUaBGJa89JnREVN7NwqkzDSiHqz1+HHxrk5BMpbfhjJqtoFa0KeyvBVj
         R2IoE9vc+Vm1F/DWqQU1Gbf7gQfsMM0AnOPyGDEKqIZKh3MCk2BhZZP1r3PwzM6JtVcM
         FcPr2V50wAaBQ99wB/sKqD98xBKlCp/dlygjzgVyFi9+8x9+T6wqeyVT/PwsdLfzX6s3
         4gAg==
X-Gm-Message-State: ACrzQf3bcRTdThCC+bR0kt2Mx/Vux0cR/j4FEgtei/BdlkKMaQkM0PDs
        CiIFZbaLhWMFH8l0wOxsT4dJ0Q==
X-Google-Smtp-Source: AMsMyM6ylOdKvZEqrEGFhsZKZwJOdBplQOBp04bfw2KEi8u6CdxHAaSC0nZm4kIsZzecInY8x4LHtg==
X-Received: by 2002:a05:6512:409:b0:49a:e44a:c6b1 with SMTP id u9-20020a056512040900b0049ae44ac6b1mr6405446lfk.222.1663603853087;
        Mon, 19 Sep 2022 09:10:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651c118a00b0026c4c1a0b4dsm684148ljo.126.2022.09.19.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 09:10:52 -0700 (PDT)
Message-ID: <c86d39c9-82d2-0f9f-9836-76ad3b6d8ede@linaro.org>
Date:   Mon, 19 Sep 2022 18:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Content-Language: en-US
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220919132236.264382-1-viorel.suman@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919132236.264382-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 15:22, Viorel Suman (OSS) wrote:
> From: Viorel Suman <viorel.suman@nxp.com>
> 
> Sync defines with the latest available SCFW kit version 1.13.0,
> may be found at the address below:
> 
> https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  include/dt-bindings/firmware/imx/rsrc.h | 294 ++++++++++++++++--------
>  1 file changed, 198 insertions(+), 96 deletions(-)
> 
> Changes since v1: https://lore.kernel.org/all/20220915181805.424670-1-viorel.suman@oss.nxp.com/
> 	Two patches squashed into one in order to keep changes bissectable
> 	and compilable as suggested by Alexander Stein.
> 
> Changes since v2: https://lore.kernel.org/all/20220919113715.243910-1-viorel.suman@oss.nxp.com/
> 	Added two more defines in backward compatibility section in order to
> 	to avoid breaking ABI, so there is no need to change the driver
> 	anymore.
> 
> diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
> index 1675de05ad33..ed33869f184e 100644
> --- a/include/dt-bindings/firmware/imx/rsrc.h
> +++ b/include/dt-bindings/firmware/imx/rsrc.h
> @@ -13,30 +13,30 @@
>   * never be changed or removed (only added to at the end of the list).
>   */
>  
> -#define IMX_SC_R_A53			0
> -#define IMX_SC_R_A53_0			1
> -#define IMX_SC_R_A53_1			2
> -#define IMX_SC_R_A53_2			3
> -#define IMX_SC_R_A53_3			4
> -#define IMX_SC_R_A72			5
> -#define IMX_SC_R_A72_0			6
> -#define IMX_SC_R_A72_1			7
> -#define IMX_SC_R_A72_2			8
> -#define IMX_SC_R_A72_3			9
> +#define IMX_SC_R_AP_0			0
> +#define IMX_SC_R_AP_0_0			1
> +#define IMX_SC_R_AP_0_1			2
> +#define IMX_SC_R_AP_0_2			3
> +#define IMX_SC_R_AP_0_3			4
> +#define IMX_SC_R_AP_1			5
> +#define IMX_SC_R_AP_1_0			6
> +#define IMX_SC_R_AP_1_1			7
> +#define IMX_SC_R_AP_1_2			8
> +#define IMX_SC_R_AP_1_3			9
>  #define IMX_SC_R_CCI			10
>  #define IMX_SC_R_DB			11
>  #define IMX_SC_R_DRC_0			12
>  #define IMX_SC_R_DRC_1			13
>  #define IMX_SC_R_GIC_SMMU		14
> -#define IMX_SC_R_IRQSTR_M4_0		15
> -#define IMX_SC_R_IRQSTR_M4_1		16
> -#define IMX_SC_R_SMMU			17
> -#define IMX_SC_R_GIC			18
> +#define IMX_SC_R_IRQSTR_MCU_0		15
> +#define IMX_SC_R_IRQSTR_MCU_1		16
> +#define IMX_SC_R_SMMU_0			17
> +#define IMX_SC_R_GIC_0			18
>  #define IMX_SC_R_DC_0_BLIT0		19
>  #define IMX_SC_R_DC_0_BLIT1		20
>  #define IMX_SC_R_DC_0_BLIT2		21
>  #define IMX_SC_R_DC_0_BLIT_OUT		22
> -#define IMX_SC_R_PERF			23
> +#define IMX_SC_R_PERF_0			23
>  #define IMX_SC_R_USB_1_PHY		24
>  #define IMX_SC_R_DC_0_WARP		25
>  #define IMX_SC_R_V2X_MU_0		26
> @@ -56,11 +56,14 @@
>  #define IMX_SC_R_V2X_MU_3		40
>  #define IMX_SC_R_V2X_MU_4		41
>  #define IMX_SC_R_DC_1_WARP		42
> +#define IMX_SC_R_STM			43
>  #define IMX_SC_R_SECVIO			44
>  #define IMX_SC_R_DC_1_VIDEO0		45
>  #define IMX_SC_R_DC_1_VIDEO1		46
>  #define IMX_SC_R_DC_1_FRAC0		47
> +#define IMX_SC_R_V2X			48
>  #define IMX_SC_R_DC_1			49
> +#define IMX_SC_R_UNUSED14		50
>  #define IMX_SC_R_DC_1_PLL_0		51
>  #define IMX_SC_R_DC_1_PLL_1		52
>  #define IMX_SC_R_SPI_0			53
> @@ -151,10 +154,10 @@
>  #define IMX_SC_R_DMA_1_CH29		137
>  #define IMX_SC_R_DMA_1_CH30		138
>  #define IMX_SC_R_DMA_1_CH31		139
> -#define IMX_SC_R_UNUSED1		140

This one disappears...

> -#define IMX_SC_R_UNUSED2		141
> -#define IMX_SC_R_UNUSED3		142
> -#define IMX_SC_R_UNUSED4		143

Best regards,
Krzysztof
