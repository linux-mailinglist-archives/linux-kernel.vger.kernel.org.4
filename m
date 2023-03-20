Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBEC6C144F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjCTOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjCTOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:05:23 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161623AA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:05:22 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s20so5018802ljp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679321120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyP8cPsTynEfs4jfCgbyH6l14kydhBexEBR3QMjvFNQ=;
        b=NRCaTomUVj+w6H5NMFXOC8rh+iD9ErqCuqCzyvw9xJP9z2Eh4NcRF3nIjQ8R+vSupO
         ykdi0Dt9QQ4vTtJ/I0oKy9KsY5g4+ABU6nj2QVUVEYJT3DCv9p98Yq5AI27sYxT6W5ZQ
         IPEP+Z4FjDzfguefmhj81nDOnoYneXRXKflLtUStSH6KeIKhCxnTnx0dncN0sIRZAm4r
         Pd+iZCmx1iG+wP4B161WfEVIwdfMceD6EGj5Yp44EHEmmOacArQ985BI/S8bTylA0htF
         naKuZ4F5ic+0OmjZIrr37vax26PTi1ICJM17Qw0NFy7jWMJ3lFLtMkhVvLH4fJy5fSHl
         uSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679321120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyP8cPsTynEfs4jfCgbyH6l14kydhBexEBR3QMjvFNQ=;
        b=wp+54FoXMzPNx4IUGPfgU3ZDOPFRiJn+D06AG7jsuSyFfqmKRe7BnM9ZBty8/oG/7L
         w09TVKluualaSjp7RhR6jHaoe88Zk6J3XQFv4MZGJHqPrtcGMn2L6FnTVoBUDPrfZvdT
         jYsBEBlEXR1DqbIQx+HRbTMZ5Q9QZdO322PA9yeVyfkV1b1FULklHvQoJmOq57cpa16S
         DWpFY+CD91hxrlDKeJfri8sGMTQzVN5O+W3NUwrRd0Y/zf8jHawcoQQJAyXEzGSfrBxg
         GpSSpOsiAfmvHUroxV1tppDgFXhycZgsuYioqz2rWmapcwfAoGZwg2eQvFLginReqMMA
         PK3g==
X-Gm-Message-State: AO0yUKWhzGBPg2VwGHnqTjcDQY7phzRAg7qWHZYGpMWXI3fCKP2KH0Lt
        AElU/7soAS1ovilix9euJv2+qlqLqmBIyZpg/ps=
X-Google-Smtp-Source: AK7set9pwNNzHb7r1wfH84CMm+tWb1ElKGpXvOV619Vgh+0XucIf7xLfDpkTfo+3Z+ID0GS8EPASTw==
X-Received: by 2002:a2e:9d43:0:b0:293:4b91:d03e with SMTP id y3-20020a2e9d43000000b002934b91d03emr33276ljj.1.1679321120277;
        Mon, 20 Mar 2023 07:05:20 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id s24-20020a2e98d8000000b002996e0e6461sm1763779ljj.29.2023.03.20.07.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:05:19 -0700 (PDT)
Message-ID: <165c8a48-3082-23f7-4b19-11c0d303b14f@linaro.org>
Date:   Mon, 20 Mar 2023 15:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg'
 property
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230320135710.1989-1-johan+linaro@kernel.org>
 <20230320135710.1989-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320135710.1989-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 14:57, Johan Hovold wrote:
> The SPMI PMIC register region width is fixed and should not be encoded
> in the devicetree.
> 
> Fixes: 42f45cc655d0 ("arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index 1411edd42b25..c35e7f6bd657 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -107,7 +107,7 @@ pmk8280_rtc: rtc@6100 {
>  
>  		pmk8280_sdam_6: nvram@8500 {
>  			compatible = "qcom,spmi-sdam";
> -			reg = <0x8500 0x100>;
> +			reg = <0x8500>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			ranges = <0 0x8500 0x100>;
