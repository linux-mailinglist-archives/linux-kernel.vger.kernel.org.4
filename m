Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7A671F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjAROUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjAROTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:19:20 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ED9630BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:00:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so1463118wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQcO2IaT0FOKV1MQTA8SII+h9k76WhBkgGg9aNZUu9w=;
        b=uji/xkNaM1rV1qCS9v3LnQQKbo5F4NQk5YJGGVzweveSF/z2x0/NuTWuMRGfnbGAI0
         ntNPmQdcMAjK1BOwFgs6W/SiefTLSXc132LROUB5/luiROqJepKatuvLCeoIRnJmBxcI
         8fU1DU93YTAlkEVlAgPYzKWf3A/5NAZbHEJS5LzSz/xesCqVaxVV9X1q1FuM+Vfw3a8W
         E2AwKOqyHGRWclBFAZwaZ0I1l2JMB2AOn4s6mOyRgkHiQeFdCwUN72Benm0s8Uebm/vM
         uwICUCQIQ7+8LeIa3GFhlpJkylxQLqag3db1Fs+OoIFaQXiUodfNpLX+HDXdXAq1gxBL
         AsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQcO2IaT0FOKV1MQTA8SII+h9k76WhBkgGg9aNZUu9w=;
        b=pvBlZqlUxm4muWrKGxKa1my+auZWXCf0IqYYBcxnHXr6RPBmRvBAOCB0Tc9Rd0Wa0v
         VJai7fj3Kn1PsYkzKQza7NPZNPaUT15mDJDM5WzF0YhXuew72InCfB25oQrduY2LM9Nw
         3qVGOiFHu5XXHcBRxoYeNaYi07tTl+92amCagAcKwWyvbiad37rzuNmJ9jHKdbRky+QE
         MlPD1W5OMxOeBjYNk4yYntRk0EZEi8m3VardiFEJ7unUy7ggpy/WBaGEeXgw8N7/bdLo
         D/I+NqWkhTuTzsHB4C5313ymXS8q8WfbLFmMYuMHBmzKkFsxEAxTZlSXg7h+nrGgGUdQ
         kcGw==
X-Gm-Message-State: AFqh2krfvHmK5sZK6KHDdtRnKocRcqK2bjvnKtxBzill5NUJf3O4NvIR
        LWefYTqsMVm4rczD3SnfMP+4nw==
X-Google-Smtp-Source: AMrXdXtP7HnvLqU20jbKLCl8mo/VGfX2DO6Q+lGt4KT9IeLkg3zqjTnGnox2ZX6gZg+KG3RxXNXclQ==
X-Received: by 2002:a05:600c:34d1:b0:3db:1637:e415 with SMTP id d17-20020a05600c34d100b003db1637e415mr1892210wmq.22.1674050457671;
        Wed, 18 Jan 2023 06:00:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm31511568wrn.25.2023.01.18.06.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:00:57 -0800 (PST)
Message-ID: <019df6fb-6d22-77e5-0a58-095b589dd339@linaro.org>
Date:   Wed, 18 Jan 2023 15:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 13/17] arm64: dts: freescale: apalis-imx8: add bkl1_pwm
 functionality
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20230118072656.18845-1-marcel@ziswiler.com>
 <20230118072656.18845-14-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230118072656.18845-14-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 08:26, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add Apalis BKL1_PWM functionality.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
> Changes in v4:
> - New patch adding Apalis BKL1_PWM functionality.
> 
>  arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi      | 7 ++++++-
>  .../arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi | 7 ++++++-
>  .../arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi | 7 ++++++-
>  arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi      | 9 +++++++--
>  4 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
> index 060454f25c98..003bc5377ce7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
> @@ -106,7 +106,12 @@ &lsio_pwm3 {
>  
>  /* TODO: Apalis PCIE1 */
>  
> -/* TODO: Apalis BKL1_PWM */
> +/* Apalis BKL1_PWM */
> +&pwm_lvds1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm_bkl>;
> +	status = "okay";

You just added this file with that comment. This does not make sense.
The same patchset adding a line and them immediately changing it. It
means previous patch is incomplete or buggy. This must be squashed.

Best regards,
Krzysztof

