Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BBE6E9159
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjDTK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjDTK7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:59:25 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763C902D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:54 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id h8so2324378ljf.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988211; x=1684580211;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bvpe3R+29oL0L28vY5LD7eClw24OPj+V9LPwrg2dXOI=;
        b=ZjHpc4hMWzdfkz2hMx35Yf9+jjkA4E8hYqB6A2Ln1TDdH4RRtG91gd4VLVvyCCY75U
         sn7PNjSilWnq2QFhsxEoRxRpF0Lm5FVb4ICDUMWNHXB1fHTfzYHivpoRHPv+/AjPdtce
         srVioag+LVPE9Wwx2w6uZfvf1bbZgT23oe2zmBAJ+kBWX/Kt9VZlVQoCgBRUBJ75PyzA
         lQUO046X4Ej5KlLBSiYrtUysDGyY7Vyx/x2eiPvVcaGuuxQNI/J9uQphfuOQXcGwj3Y8
         ElzZURyDBPVMWVzGSHr/p7NQGfgvHZK0ZKBNCNdy8PDjMBL38/mV+tjobxNKBnkzbYmS
         c/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988211; x=1684580211;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bvpe3R+29oL0L28vY5LD7eClw24OPj+V9LPwrg2dXOI=;
        b=Ap2sC0YV302MRTIKwGb02e30gz/1lUYHSTCvESjJxLAkgLObzIUJIoMNTOTd+puGBJ
         Y22il6SKWBkkPRi7EGE9KM4EAk5wr9+2tdjeMOULbveu4CHPUFYrGhlJfxsqE7XJ/0Sf
         MsnBymhSxT3qUQfGEMXQkVzCBWIeUReNshffytDOhI3+ar5SySKCRrt7ZSGTE3tSNiuE
         prosQUI9L0g9YVU1Jo09vBV1PiFwwTiD5N/OyV1aw26BPwKsuSBJaQDNWtVwWzaPKb+h
         32GSX7hCrlk3rdRnJYNIYZ9WH1yFj34K49VjJIeyr3jPiC8IbqBQowc4kfZpN8atizHo
         0c3Q==
X-Gm-Message-State: AAQBX9dmNM8y/RDfiymhSYMPf3zc/IITqX3X3jxZ9oW3ADae81ji4Bon
        PhUk5FSzxBrhx2aMSBJErCGNPw==
X-Google-Smtp-Source: AKy350b7WGDKwsmJQEuXvAwMw3qik2GTjVrgxQijKkl5bPwvgHR0KqkNNxg40hiyoyW4SM7trZZ0AA==
X-Received: by 2002:a2e:9d56:0:b0:2a7:7734:c4b3 with SMTP id y22-20020a2e9d56000000b002a77734c4b3mr228406ljj.4.1681988210785;
        Thu, 20 Apr 2023 03:56:50 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25685000000b004ec7c0f2178sm179939lfr.63.2023.04.20.03.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:56:50 -0700 (PDT)
Message-ID: <618ab118-a9b8-3b6d-66ff-8e7aed88f06a@linaro.org>
Date:   Thu, 20 Apr 2023 12:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 17/18] arm64: dts: qcom: sm8550: correct pinctrl unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
 <20230419211856.79332-17-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-17-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc@0/pinctrl@f000000: simple-bus unit address format error, expected "f100000"
> 
> Fixes: ffc50b2d3828 ("arm64: dts: qcom: Add base SM8550 dtsi")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 90d2b7057b75..eef46045df93 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2883,7 +2883,7 @@ spmi_bus: spmi@c400000 {
>  			#interrupt-cells = <4>;
>  		};
>  
> -		tlmm: pinctrl@f000000 {
> +		tlmm: pinctrl@f100000 {
>  			compatible = "qcom,sm8550-tlmm";
>  			reg = <0 0x0f100000 0 0x300000>;
>  			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
