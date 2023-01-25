Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F9D67AD97
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbjAYJPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:15:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjAYJPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:15:39 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B02D4346A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:15:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q8so13214127wmo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hLYyMf8v6sX0CmntSwjS63uxAxPxvpyOkk5T320V7ls=;
        b=vQIeg+80cD1Jh0nHmdw6lIMdBYusiJ8CWnr+acIqPUQ8bgzxwSQV+fGSXvKjFVIEtz
         iwFgfpQ+PqMQT7N7huipewrSougdMtpDfSqzHshcM+zcqO/0qigO7GUsIx+ZVib7Vgmc
         4YzGL45GG3DY4I5YhdNjC6bkHnl7jh5Skej2L7BHl793N7X9B5DKoSApVtLxrece0pl7
         LDttDDg5eljQPKDffr1lM4ltoLQUC2uhAw+Jc/g+r5OA1itaP0kFHGJXxFzCmvu4a09A
         pDvFwZjLQippIXa/8ZeT9dFxC8PCnQJTHnoMHNaDJOtUYns09Nrw/vg51pEUhnfDbA6L
         +QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLYyMf8v6sX0CmntSwjS63uxAxPxvpyOkk5T320V7ls=;
        b=2IJrOGmH6ftgV0/uJOq/3C+tQ8rsm+4cShuRmJNpMa7nV0wexz4Suv+7LOG1YDeW2c
         rhjtEKGjIWneMGxtKG2a5TeZLgaNXUwERUtn5qglx+Eiqr2hzh8LAUAFlOLdb9MbkEq2
         Yd/zcsHgUF898ehcyx+ZIzF6EKNQpegn8mlxp9ogBxBwYaophsIQpwF6CDREzeTt7v79
         9jV2u+F4EXpX2JMl37QjjcKqoiBmKmdP0trq8ONnhSzVA8ivpeEKi3a10Dn7evbi/PfM
         R8XbOBymImgZZI4sy7GKinBRVfqBRfdpI3tDrUxlmGRY1/oipQgGdTI0wZoP9GwGd4+p
         aN5A==
X-Gm-Message-State: AFqh2kqs8bjXWdLnsljm92jgVrkncml9Shx6rtI88KPjK17OHyWFiWT1
        BGxqZYaaNz/PStmgZIqXIMMwhCVjU/zPs2J53fU=
X-Google-Smtp-Source: AMrXdXvWRskL0ALdre/zwBQd4CWcE4EeqG3qOzIokfuCHYl0YnH8WVH4If4CW54QDvyDULTACzs7sw==
X-Received: by 2002:a05:600c:35d4:b0:3dc:b1b:830 with SMTP id r20-20020a05600c35d400b003dc0b1b0830mr6688372wmq.33.1674638135988;
        Wed, 25 Jan 2023 01:15:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2f:6fa7:d25a:7047? ([2a01:e0a:982:cbb0:ad2f:6fa7:d25a:7047])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003db01178b62sm1191493wmc.40.2023.01.25.01.15.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:15:35 -0800 (PST)
Message-ID: <47b12a29-1438-3930-b471-69136d41e148@linaro.org>
Date:   Wed, 25 Jan 2023 10:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8250: Disable wsamacro and swr0 by
 default
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230124164616.228619-1-konrad.dybcio@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230124164616.228619-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 24/01/2023 17:46, Konrad Dybcio wrote:
> They are not used on all boards, so disable them by default.
> Enable them back on MTP/RB5, which were the only current users.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 6 ++++++
>   arch/arm64/boot/dts/qcom/sm8250-mtp.dts  | 6 ++++++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi     | 4 ++++
>   3 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index 8c64cb060e21..6802d36fb20c 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1007,6 +1007,8 @@ can@0 {
>   };
>   
>   &swr0 {
> +	status = "okay";
> +
>   	left_spkr: speaker@0,3 {
>   		compatible = "sdw10217211000";
>   		reg = <0 3>;
> @@ -1322,6 +1324,10 @@ &venus {
>   	status = "okay";
>   };
>   
> +&wsamacro {
> +	status = "okay";
> +};
> +
>   /* PINCTRL - additions to nodes defined in sm8250.dtsi */
>   &qup_spi0_cs_gpio {
>   	drive-strength = <6>;
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> index 0991b34a8e49..c0d83fa9a73b 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
> @@ -759,6 +759,8 @@ codec {
>   };
>   
>   &swr0 {
> +	status = "okay";
> +
>   	left_spkr: speaker@0,3 {
>   		compatible = "sdw10217211000";
>   		reg = <0 3>;
> @@ -892,3 +894,7 @@ &usb_2_qmpphy {
>   &venus {
>   	status = "okay";
>   };
> +
> +&wsamacro {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 95f1a6afcd43..a0ba166f89d8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -2277,6 +2277,8 @@ wsamacro: codec@3240000 {
>   
>   			pinctrl-names = "default";
>   			pinctrl-0 = <&wsa_swr_active>;
> +
> +			status = "disabled";
>   		};
>   
>   		swr0: soundwire-controller@3250000 {
> @@ -2297,6 +2299,8 @@ swr0: soundwire-controller@3250000 {
>   			#sound-dai-cells = <1>;
>   			#address-cells = <2>;
>   			#size-cells = <0>;
> +
> +			status = "disabled";
>   		};
>   
>   		audiocc: clock-controller@3300000 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
