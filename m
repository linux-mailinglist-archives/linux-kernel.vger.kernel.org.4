Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C255648E3B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiLJKvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLJKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:50:57 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350F1C10F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:50:54 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c1so10896860lfi.7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 02:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDA7kzHD0wSeXE9lUVEr+JunSQpUfMbT+/Dt8szK8WY=;
        b=Qj3U4f7zU7uZc7imsQvIcSHrcI0JwELGl4nl4IyyJgZ7bggAqHgU6DyKmjUX08LETI
         E02/PhpQSIUwInNgAg9gh2RFdeNyrIqc6hnM+cFsi7LdcXx1BGc5S2FODlcJzqMqgUcH
         8DDmjl5msjzGTM8UBLXNxK8JkJyJu03z2P9HX42Jhi2ElmpwD097HKqFk6Uazd8pp2Cc
         WAYcxlwIsM+YV703lFvNu+2ZomFsS1WyluRw9YdH4hN9hItP3h5Lra4FC1Mwmcg1tygM
         GE8wm53x4i/S7MUy8G/7ApYH/w4Ozwos37iH/LTvdk4B3nxdJKgV0hVmgeQ6G6NJlvkC
         mvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDA7kzHD0wSeXE9lUVEr+JunSQpUfMbT+/Dt8szK8WY=;
        b=lWLStPiIiaTmUBgln6bF9lpx7UVCEtsisIJ9Pzn4kB+6GAaNcAhjqojtxODdqQeYzc
         nOG1NiwwpAfC3yA4aTVYgXHzOHPM6mjwXDbcSD85J/QdzZUXk3mMuPVpR4Y+A19BU7TU
         8+eU3shweA/2DZ2sTK67dZzmaYNamYLy0WZeLYOlX9OlOM/NlmchR0trBUaGl21oPcPi
         do4r+VPeoFhHpe4UayTS5XupKWUVYeJ6gWAGZDAxOwzrebD861n0z1wdSV80hMbM2VbZ
         G3QPE1evGu2/uWDsBug/K2XqKladEEeKpcOftdDymyEJC1u23tCKBQplXAoE888LJEC/
         Rlzw==
X-Gm-Message-State: ANoB5pnwaTOr+IL19i07XYEEWY6qXGsWhnCwUVpHgK7hQtohnAlIn75q
        PQSC0oAFTk6OwAlazLti21VU6g==
X-Google-Smtp-Source: AA0mqf6m/o/EMksGT87qFi6KgEsGB+5prCYmxw2WQ2Nn9uMcPLVu9rRkanXRvxdT8P6EGaJz95hqyw==
X-Received: by 2002:a05:6512:3e0a:b0:4aa:301f:3e3a with SMTP id i10-20020a0565123e0a00b004aa301f3e3amr5925939lfv.11.1670669453325;
        Sat, 10 Dec 2022 02:50:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b22-20020a0565120b9600b0047f7722b73csm662708lfv.142.2022.12.10.02.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 02:50:52 -0800 (PST)
Message-ID: <714ac62a-7bab-e16e-e3b6-bdd86e422699@linaro.org>
Date:   Sat, 10 Dec 2022 11:50:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH] arm64: dts: qcom: Use plural _gpios node label for
 PMIC gpios
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221209220450.1793421-1-marijn.suijten@somainline.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221209220450.1793421-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 23:04, Marijn Suijten wrote:
> The gpio node in PMIC dts'es define access to multiple GPIOs.  Most Qcom
> PMICs were already using the plural _gpios label to point to this node,
> but a few PMICs were left behind including the recently-pulled
> pm(i)8950.
> 
> Rename it from *_gpio to *_gpios for pm6125, pm6150(l), pm8005,
> pm(i)8950, and pm(i)8998.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> ---
> 
> This was brought up for discussion in [1] but hasn't seen any relevant
> reply, unfortunately.

This is just a label, it does not matter. Why changing all exisitng
files? I don't think it was a part of previous discussions...

To me it is unneeded churn.

> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221104234435.xwjpwfxs73puvfca@SoMainline.org/
> ---
>  arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts  |  8 ++++----
>  .../dts/qcom/msm8998-oneplus-cheeseburger.dts    |  4 ++--
>  .../boot/dts/qcom/msm8998-oneplus-common.dtsi    |  6 +++---
>  .../qcom/msm8998-sony-xperia-yoshino-maple.dts   |  4 ++--
>  .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi    | 16 ++++++++--------
>  .../arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6125.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6150.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm6150l.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8005.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8950.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pm8998.dtsi             |  4 ++--
>  arch/arm64/boot/dts/qcom/pmi8950.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi            |  4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-idp.dts          |  4 ++--
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi     |  4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi       |  4 ++--
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts       | 16 ++++++++--------
>  arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi   |  4 ++--
>  .../boot/dts/qcom/sdm845-oneplus-common.dtsi     |  6 +++---
>  .../arm64/boot/dts/qcom/sdm845-shift-axolotl.dts |  4 ++--
>  .../boot/dts/qcom/sdm845-sony-xperia-tama.dtsi   |  2 +-
>  .../dts/qcom/sdm845-xiaomi-beryllium-common.dtsi |  4 ++--
>  .../boot/dts/qcom/sdm845-xiaomi-polaris.dts      |  4 ++--
>  .../dts/qcom/sm6125-sony-xperia-seine-pdx201.dts |  2 +-
>  25 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> index 310f7a2df1e8..0e273938b59d 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
> @@ -113,7 +113,7 @@ gpio-keys {
>  			    <&cam_snapshot_pin_a>;
>  		button-vol-up {
>  			label = "Volume Up";
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			gpios = <&pm8998_gpios 6 GPIO_ACTIVE_LOW>;
>  			linux,input-type = <EV_KEY>;
>  			linux,code = <KEY_VOLUMEUP>;

Best regards,
Krzysztof

