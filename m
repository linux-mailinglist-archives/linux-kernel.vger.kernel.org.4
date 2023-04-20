Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626526E90F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjDTKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjDTKuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:50:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E49986A8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:48:11 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ec816d64afso2134426e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987688; x=1684579688;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fsxiP8G4oEn6JlqB9XuI8ZcfLivgy7X9ahb2+DnAxpE=;
        b=MZY98r19fNy0ZUfDhnKPW1Ry54YfueXOMh1S0sqJpect9nBLDL4zMvMa7q3dv7yQoh
         wrf49cKdMRWUIzQ2+jVe6WdtmP0mEjE05TraRx64KqvqGwzjn2PTCO8DKiOLL9C4sokV
         Ym8rT/b6bUu+CMjXg9BT68T9SAU0n84gRkjASCUgIsheZtIiNTtOWdCJsBvtJ9zBV76E
         GXD67jyO9iu0+DdA3WPXaX2wiZVd7pMiPZb2LKz3Y1DYESkCigw/6dgf2pmKZcS6sNBR
         tCTcQ5lIkc5yDaXwXCoAaen3nU6Zcu69/rdqyYXA0TreDEddQeJ1APqbS8RMFiblaMlE
         Mtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987688; x=1684579688;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fsxiP8G4oEn6JlqB9XuI8ZcfLivgy7X9ahb2+DnAxpE=;
        b=U21jjcMORlMp8uF/8mMjJWA11U5H2AxBpF4mvU3N3sZBBSZIPG3kKMrMkeChym6OG3
         amXHsmmc6iOR+Xnx+KxuQr8+lb/DpeikC6RIQdhv4KU1ZE3RCY6rAF5zojGPOoCdSine
         ibFTkEd6SIZfVFkUcDzGpIR7gOMN9qiC0opxJx8GxtUSZWOpDJfaanTsv8HEXiyWOCn/
         SkYXsXYoyDyl6f78L3WzorXtPztSwdCeoOYkJwfZmnFvqLWy3IqBJ7boRIs2FlTZcYUe
         PMb8TGo/k3mZwFddQMElrEOXaafYL70w0FORuEQveetJcGs3/Qj5wf6kMwxTITHiFM0e
         2XKg==
X-Gm-Message-State: AAQBX9crY1KEpiIDVr5FOzUZPGJLTmsWHjd650fE5Sm7NVeoj/0yPwgb
        vFY0W/N+LYn7UqIy4uTM3hjQeg==
X-Google-Smtp-Source: AKy350a72GUwVySIwYRmRXqSW7+Nw1xMipxhvAzwJnS/jQ4fyZ9bXJwC9i/7UkWXMOUwv/yHSk/aJg==
X-Received: by 2002:ac2:52bc:0:b0:4ea:e789:25b with SMTP id r28-20020ac252bc000000b004eae789025bmr430675lfm.30.1681987687938;
        Thu, 20 Apr 2023 03:48:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a19ac41000000b004d3d43c7569sm181659lfc.3.2023.04.20.03.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:48:07 -0700 (PDT)
Message-ID: <776bb753-6302-b140-ab8d-fe6fb1b0bcf8@linaro.org>
Date:   Thu, 20 Apr 2023 12:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 05/10] ARM: dts: qcom: ipq8064: drop invalid GCC
 thermal-sensor unit-address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
 <20230420075053.41976-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420075053.41976-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 09:50, Krzysztof Kozlowski wrote:
> GCC comes with syscon compatible so the thermal-sensor child node should
> not have unit-address (bindings also do not expect it):
> 
>   Warning (unit_address_vs_reg): /soc/clock-controller@900000/thermal-sensor@900000: node has a unit name, but no reg or ranges property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 182018d79a7b..49310520da1c 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -522,7 +522,7 @@ gcc: clock-controller@900000 {
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
>  
> -			tsens: thermal-sensor@900000 {
> +			tsens: thermal-sensor {
>  				compatible = "qcom,ipq8064-tsens";
>  
>  				nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
