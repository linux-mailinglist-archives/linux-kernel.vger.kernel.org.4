Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7C654825
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 23:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiLVWBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 17:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiLVWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 17:01:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BBF27CF9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:01:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id cf42so4674396lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 14:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hwyt8ZdI5ZWUHfUGRX4s0PkLUr1UuuhJWewTj+QujR0=;
        b=sdyRfPiBd704FQG4bNjO87wMafWV6TlycxRFOCRg6C1jFqskYPrheu40WnKLXd97VD
         9awr9681ZZ40f3yEZ2IV7TOgT6N9WWG8ibxUc6eDGIm+JUjyZLX3o+sCaKvKuvXbGC/K
         FhxTq13RxetjjMC19nCQz2Cd1WynTrH/8q7rY/Q0ugj5DGuvoBsDN0X830KHShnuh/FQ
         SlGLo97+D1lqnHkOgPdteqpHcC/bRwOEBxgtL2oG9pTqonU5RBKciuJ/xsbJgR0BIKsl
         iWxKGuexHDXtiOQgKoz3mSY1ZLtgf0sbmw+VTgwLb4GN7btlbcv4CDGIcClg7UDOwjgS
         8Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwyt8ZdI5ZWUHfUGRX4s0PkLUr1UuuhJWewTj+QujR0=;
        b=MwZzs2vXI7jdfRM7Gn49Z+jc3Qb/w6qcFYaB2g3NxybPnfBXfpkA5T8KF0T35J+I5d
         KWuNTTNCIHfknWFsAzAhfndTfAyOxbrxDIjo3teS/8zQwsOH+OxymEOkjg2OFzBsjt+s
         4qyg2woCRZKl/Il8eWi+W6701V7iR7FycxsodzY5Pti3qrqh1kyIy/GVXXogmYsB84ir
         KdIzHKNqw88BcaFKG3LuauikQiTEiwGhPBhQxbnmKcELkDl7JSnFg1sQMYzB71SbwBbY
         Dwvp0pOBb8vF9Ywb/7HNhcIjf4A135f+P2FtyMzRzdpQ9fo/Z5PQKN/xS48fi7agRRG9
         spIw==
X-Gm-Message-State: AFqh2krs0V74h2AuBTam//DIpmGGX+60kCro2/TTnwbvKFUfbsBGi1bj
        BnujA3poTqjTrxh6oY+JNLHGiw==
X-Google-Smtp-Source: AMrXdXtCv726/Ll7RZS1LYdA1OYHa3A5hq1rDXIE2Lyae6+L1yQnAfH8gZRKJugpTYZo5pID48KFog==
X-Received: by 2002:a05:6512:16a8:b0:4b5:a70f:8efc with SMTP id bu40-20020a05651216a800b004b5a70f8efcmr3436708lfb.64.1671746501410;
        Thu, 22 Dec 2022 14:01:41 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id s20-20020a195e14000000b004b0b2212315sm224362lfb.121.2022.12.22.14.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 14:01:40 -0800 (PST)
Message-ID: <144d7b69-fb67-60dd-2c40-c004fbbba288@linaro.org>
Date:   Thu, 22 Dec 2022 23:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6350-lena: Flatten gpio-keys
 pinctrl state
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222215906.324092-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222215906.324092-1-marijn.suijten@somainline.org>
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



On 22.12.2022 22:59, Marijn Suijten wrote:
> Pinctrl states typically collate multiple related pins.  In the case of
> gpio-keys there's no hardware-defined relation at all except all pins
> representing a key; and especially on Sony's lena board there's only one
> pin regardless. Flatten it similar to other boards [1].
> 
> As a drive-by fix, clean up the label string.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/11174eb6-0a9d-7df1-6f06-da4010f76453@linaro.org/
> 
> Fixes: 2b8bbe985659 ("arm64: dts: qcom: sm6350-lena: Include pm6350 and configure buttons")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 
> - Replace accidental semicolon in patch title with colon.
> 
> v1: https://lore.kernel.org/linux-arm-msm/20221222212634.298135-1-marijn.suijten@somainline.org/T/#u
> 
>  .../qcom/sm6350-sony-xperia-lena-pdx213.dts    | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> index 94f77d376662..4916d0db5b47 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
> @@ -35,10 +35,10 @@ framebuffer: framebuffer@a0000000 {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&gpio_keys_state>;
> +		pinctrl-0 = <&vol_down_n>;
>  
>  		key-volume-down {
> -			label = "volume_down";
> +			label = "Volume Down";
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			gpios = <&pm6350_gpios 2 GPIO_ACTIVE_LOW>;
>  		};
> @@ -305,14 +305,12 @@ touchscreen@48 {
>  };
>  
>  &pm6350_gpios {
> -	gpio_keys_state: gpio-keys-state {
> -		key-volume-down-pins {
> -			pins = "gpio2";
> -			function = PMIC_GPIO_FUNC_NORMAL;
> -			power-source = <0>;
> -			bias-disable;
> -			input-enable;
> -		};
> +	vol_down_n: vol-down-n-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-disable;
> +		input-enable;
>  	};
>  };
>  
