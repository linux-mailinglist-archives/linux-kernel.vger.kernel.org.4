Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DD6540C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 13:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiLVMLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 07:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235670AbiLVMLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 07:11:08 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B23579F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:02:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id bp15so2368943lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0/WYYRiZBUptmaI66MTLgo9LuZpA2AGvxzbCPWDdlk=;
        b=hr2UUO/mNiySg/OJe785T6rDWQsaL5wuR+cKg25Sfx3KJL7RnyGRxe4vjovpzRI5Vq
         pXrSDrQsDX2uU6riY9SAob/gXpuIbx+NvDfC1tVmj00LQt05D35HdRs3QQdeeos6Dpzq
         WCUZ59QJLlzwg4u2RVxEUjw9ZNwZ7R7IQ44bSTCneUnI71TaIJYO4IR0Vc9ZdKtC+Hsg
         tff3ylJ54TJmNwuYmcwZzkVBc0iDr2f92NBxR/Cc8+Ffc4kmWv2xzrRSvSvfOZdGDp2K
         h9eVECZtnwGS7svAsm+dDRoHjf2C03mTeERC22jwdMtif0MX9TDdeonYN0k0XwOnvrFx
         qoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0/WYYRiZBUptmaI66MTLgo9LuZpA2AGvxzbCPWDdlk=;
        b=dt+5h+75x9HdKPriO2ivz3j//EY+85D2F7fSFWxU7IzBuLqAbfmuGmwzbVYf/RKM2Z
         0ka53xkmsfBFJPNaIdkqtqPt9W12ioyTP8YAUZDwf6lnnRmmQsjRv5gnoghd9Z+ocu4g
         +wAwdAj3YZ9kB+eoQ1U1WEXdty+3UslG6YpHMQpr76+s5HPJNoTnmvejWIMxuaBjVhSP
         JP1zBrZDaoO3Ew+qIao3zM0F43YXqxhSWdKmyyifOwntDlJbo52KLar8p5Kal4N9PPfi
         3CtmTpZHGZ7CDMeB5G28NfEiLpBPEXiPBQpek2EE3lkwkviI97m1DbnU0c94/GSALMl2
         XL6Q==
X-Gm-Message-State: AFqh2krEOgE4yr65DJ6YV0QpdLaIvnb9BzJP1RDcavcleT/xvXTYH3Zj
        1r6OOYTgLJ5acWTIZBy448PExhQudPFw1ddd
X-Google-Smtp-Source: AMrXdXuJycJoLh9UbvXcMVXUe6Q2RHi1EKx0BHBv+IoJX0TXdcdFnDm5Mz6e2aCQ1xgovOVI4v4dAg==
X-Received: by 2002:a05:6512:4005:b0:4b5:9183:5ad0 with SMTP id br5-20020a056512400500b004b591835ad0mr3126053lfb.63.1671710567857;
        Thu, 22 Dec 2022 04:02:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d9-20020a056512368900b004a26ba3458fsm50812lfs.62.2022.12.22.04.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 04:02:47 -0800 (PST)
Message-ID: <e21d15f9-10fa-671b-b49c-a9f748aae75d@linaro.org>
Date:   Thu, 22 Dec 2022 13:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2: Add support for ADC nodes
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kristo@kernel.org, nm@ti.com
References: <20221221055144.7181-1-b-kapoor@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221055144.7181-1-b-kapoor@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 06:51, Bhavya Kapoor wrote:
> J721s2 has two instances of 8 channel ADCs in MCU domain. Add DT nodes
> for 8 channel ADCs for J721s2 SoC.
> 
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
> 
> Changelog v1 -> v2:
> 	- Updated Interrupt Values for tscadc
> 
>  .../dts/ti/k3-j721s2-common-proc-board.dts    | 14 +++++++
>  .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     | 42 ++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> index a7aa6cf08acd..67593aa69327 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
> @@ -309,3 +309,17 @@ &mcu_mcan1 {
>  	pinctrl-0 = <&mcu_mcan1_pins_default>;
>  	phys = <&transceiver2>;
>  };
> +
> +&tscadc0 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> +
> +&tscadc1 {
> +	status = "okay";
> +	adc {
> +		ti,adc-channels = <0 1 2 3 4 5 6 7>;
> +	};
> +};
> \ No newline at end of file

Same errors as before.

I don't know how many same patches we need to see - this is fourth. None
of them seems to be correct...

Best regards,
Krzysztof

