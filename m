Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE666CC36F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjC1Oxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjC1Oxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:53:48 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52B2BDC9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:53:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so50797745edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680015225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntLeAvwYo13KTBL/y3l0lVOyzh8Kzne6sGlhIyPSqF8=;
        b=PXvhstG7uj98LaXH//8Mek02Wg4U3UZ8zfWHZSNsOZd8YJ4UxzaxecApgTd4fjZ3bj
         Bbyx2nHV5Jkki3PUzUCenleDE4DicrZVJbxFuqg6V0VUSSuywv7I2S8SHztMCn1otkQQ
         COj9zRgbEEh1Uy6oA/0mPXK+peu0cCCbTfRYpVKcZLw4HfVDCdzN9yho8QsoqWKlFcCm
         BhwEXX2U+uUUXKEzzfOKG5bqGYXPJWh/vKncrAAmds6Y6ejr52/Cesq1aSjEpg4UpMqu
         SOsS3fulziPQ74G83lOibK3hS1iAX/CYFRexVyORkzvtGJNoNR0s+D7VZEdxHUO9OF1/
         EIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015225;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntLeAvwYo13KTBL/y3l0lVOyzh8Kzne6sGlhIyPSqF8=;
        b=R7UXwNBl+aB3Q17gLLFTNzH4+L3dUxvJQREER/UrYOWsc9kbyukLO+U6su9CAFxFAV
         IchQtL06DwglwDzR7L/a1JcC2lufwYnLFSIKkZG/jSHobxSy+ui5c+rKFUA/Y3ISsKvk
         kJzWSOQA49rcJkj12bqFyGSiC8kNlpRQOhBgL+whhfwLpiTw+NAlQtqHRhqDgtV4av8V
         oqXY98vWmff5Vy/WwSuCp95ot/0yG2KdJwJD+Y3klRDhD6jZ4GjHGBxIPvSxBWvh7YVV
         QkKCAK1pNOBoOQTuN6DqXsv7KW7E/BwpQ8kOqv49PQlLagEqzusbzgJKMX36wHO93fMu
         0buQ==
X-Gm-Message-State: AAQBX9dzQnldBC+doDtyHr2u/LgDTOnqceO0gB8J2xeDKvy4PW58aBUT
        qesukS1n/6CbhkstPQi5bge+Rw==
X-Google-Smtp-Source: AKy350ZSEV0js3KfJtOUIg3AsvSN0lpPFcekKk98Ii0WXFpPSUOeYbhZinzigEa1AusquOGm8BnhLg==
X-Received: by 2002:aa7:d815:0:b0:4fd:2533:f56 with SMTP id v21-20020aa7d815000000b004fd25330f56mr15055439edq.39.1680015225030;
        Tue, 28 Mar 2023 07:53:45 -0700 (PDT)
Received: from [10.105.135.205] ([88.128.92.162])
        by smtp.gmail.com with ESMTPSA id x21-20020a50d615000000b004bb810e0b87sm16032493edi.39.2023.03.28.07.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:53:44 -0700 (PDT)
Message-ID: <fc0738f5-0494-6142-56a4-ae3d0182a903@linaro.org>
Date:   Tue, 28 Mar 2023 16:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: dts: stm32: add FMC support on STM32MP13x SoC family
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alexandre.torgue@foss.st.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230328122606.191211-1-christophe.kerello@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328122606.191211-1-christophe.kerello@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 14:26, Christophe Kerello wrote:
> This patch adds the FMC support on STM32MP13x SoC family.

Do not use "This commit/patch", but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp131.dtsi | 34 +++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index 5949473cbbfd..7af3eb15c204 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -1137,6 +1137,40 @@ mdma: dma-controller@58000000 {
>  			dma-requests = <48>;
>  		};
>  
> +		fmc: memory-controller@58002000 {
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			compatible = "st,stm32mp1-fmc2-ebi";
> +			reg = <0x58002000 0x1000>;


compatible is first, reg is second. ranges if present should be third.

> +			clocks = <&rcc FMC_K>;
> +			resets = <&rcc FMC_R>;
> +			status = "disabled";
> +
> +			ranges = <0 0 0x60000000 0x04000000>, /* EBI CS 1 */

Best regards,
Krzysztof

