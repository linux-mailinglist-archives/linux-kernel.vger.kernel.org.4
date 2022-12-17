Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7864F9CE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 16:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLQPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 10:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiLQPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 10:20:28 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F881400D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:20:26 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so5078412ljk.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3xo3YDasYRrDyRyPreLFtp1Yw7BHNALzC+h/Lv7dXA=;
        b=MDoB1OhCrRDxQ0Eu1HdOfBcX/kSIzjgCUuKTdCOWrzennYDSusByQHSxad46Asw2tM
         zj4Wp5AX8v8PRE+/mbisRKl6fQH9FJiJdMga4YDzONsygMBe/OzkMuEBYt8H1MoHc9So
         qQfmlSjAvZMmw8tVFW+gy/2K0U06NPVKhIkTlORGR46+rP0EY6RQw5qdHJXg0w8UcuQw
         BDVRwlRjdyihp7A/w6JrFvL3xM4YSdW8N7UoHGrGjzh8gfz7NtmfDZ2h3ZoXsLJdL0wa
         OD2J8jGvJOzggo12qFfB9kafSYShdDRSlPKZzYlLy1w+H91GvvZi4u2Hhawz9Cafy1sw
         GiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3xo3YDasYRrDyRyPreLFtp1Yw7BHNALzC+h/Lv7dXA=;
        b=oDlQnI+to2DpOMkTMi0fEDa92Yef5+SuQjYb6xBOo9KIckdv3UwXbuME7J6SQGqOPI
         qOsFCn9RPy4aTE9NrJAPadHynXuc5uTeCs8lPRZ/p+jhH1VOrTrVc1NT46lU4lv3yzYo
         aHrQwYHjBXNU+T4fQf5WBt5U1xOq2qC8uMH/1U+YQ7jzZfZoNOLuW3gSOqKn7XQuOw2B
         waClmj6aAqE5WPTvYzh4ps4uxo387ZLTjIZ9TvocR2yFrswJs2kR+AzYssGK+CJL7I/8
         XXJ3sBfGM8AZNbaWDBZ+vtTxv1fLAbVR6FQejEDLOXb7IipKosM4Bhu+NIMbwlriWv/g
         SLBQ==
X-Gm-Message-State: AFqh2kpIh8b9Ii/H+9jQtZrDpI0tFNmTfOqEG9AgDJJVoPAn9UXv7T/P
        Kei3SNMQk3UpPwyjyIXKDsFSAg==
X-Google-Smtp-Source: AMrXdXuoPMteCdBoPdTXfiod2FbdWWM2ANpoY4xs0rF0NUHPwtWwa07t069bY4IAXzPnGrp37DQW6A==
X-Received: by 2002:a05:651c:19a2:b0:27f:2885:4254 with SMTP id bx34-20020a05651c19a200b0027f28854254mr2743980ljb.30.1671290424932;
        Sat, 17 Dec 2022 07:20:24 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id bi24-20020a05651c231800b0026dc7b59d8esm376154ljb.22.2022.12.17.07.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 07:20:24 -0800 (PST)
Message-ID: <2a1ff9e6-2401-0ead-781a-ef92965319d9@linaro.org>
Date:   Sat, 17 Dec 2022 16:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm6125-seine: Enable GPI DMA 0,
 QUP 0 and I2C SEs
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Lux Aliaga <they@mint.lgbt>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221216233408.1283581-1-marijn.suijten@somainline.org>
 <20221216233408.1283581-4-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221216233408.1283581-4-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.12.2022 00:34, Marijn Suijten wrote:
> Enable I2C Serial Engines 1, 2 and 3 which are known to have hardware
> connected to them, leaving the rest disabled to save on power.  For
> this, only GPI DMA 0 and QUP 0 need to be enabled, as nothing seems to
> be connected to Serial Engines on GPU DMA 1 / QUP 1.  Beyond this
> downstream only defines a UART console available on Serial Engine 4
> which also resides on QUP 0.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../qcom/sm6125-sony-xperia-seine-pdx201.dts  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 1b9e40d3d269..b1de85d8f1c8 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -141,10 +141,35 @@ active-config0 {
>  	};
>  };
>  
> +&gpi_dma0 {
> +	status = "okay";
> +};
> +
>  &hsusb_phy1 {
>  	status = "okay";
>  };
>  
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* NXP PN553 NFC @ 28 */
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Samsung touchscreen @ 48 */
> +};
> +
> +&i2c3 {
> +	clock-frequency = <1000000>;
> +	status = "okay";
> +
> +	/* Cirrus Logic CS35L41 boosted audio amplifier @ 40 */
> +};
> +
>  &pm6125_adc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm &rf_pa1_therm>;
> @@ -246,6 +271,10 @@ &pon_resin {
>  	linux,code = <KEY_VOLUMEUP>;
>  };
>  
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
>  &sdc2_off_state {
>  	sd-cd-pins {
>  		pins = "gpio98";
