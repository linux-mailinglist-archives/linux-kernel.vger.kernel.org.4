Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363F66E9152
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjDTK7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjDTK6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:58:42 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590987EF3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:06 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso472558e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988153; x=1684580153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39KEn0YrQKNu+JfNoAy5DDW/UGTfFOqatf1VXJM6t8g=;
        b=SyQ7EgeOq2aphoUk1AhJ1mg8fwFgOfctW1xYx7ELF2Co15b3Zpd3gpQEw9m2SbfINH
         eXA3TR2TN5LhK3Au8bmn4EbKYOhK9L+gT3eZu7gzgzZOGR7+cznCGHt1jpZUuY/VcwLp
         IpyM/BTO4EjD3Qc/d1Wkk0zRGa7063Df+piL48k/Hv6lgxavJxRSDKxWnhoNUMbEKuQ6
         YJUrJoYhAiArjFaLORT+LMpHrSzZIvD0ysfbCKRRaox5pXvc5RFGPS35IsbUPX7vKeR0
         4hlQ0r2pwj3wcUIcEwXTQ8lTu2R9YJri0Ee/HMs8OAPBmpEYzqyKiaLmcLyIBMCGj/vW
         uMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988153; x=1684580153;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39KEn0YrQKNu+JfNoAy5DDW/UGTfFOqatf1VXJM6t8g=;
        b=HYFShAm3IZxKHo9jR8f659vjMhh5C4TKWub48C7KVXAu7+yU0z/CSlX7kKoIIjoNzr
         UbRCLPGRBaDbPhzoJ6TmNBvs+pq9Gl/tBy0C3+OKGLIrjdzsn5po0xpmsgRedWrHeeoR
         l/+K1/A4N06u8fGrAbKm1pnNT3Fn6xmf5CLrRLdy+Zx9CNmYjGh8j/POdA6qKuaDXx5G
         ncGCUbxRe178c9qD5bkIU8MYKkVjNfgaQiG9+unv5S4/BwctFR1sHRV67YZAaZbM7nnu
         MhydNOF+3Kdss3JlxKID+h40l1EmrvvZv+yGuYv4gy/YgvDSFFy7rB83mOe/ehfGZ7pf
         ZUeg==
X-Gm-Message-State: AAQBX9fdGimnugA8jPDLBZAn8Ufy5YVn5V6SC5EHq6oa74tOyBdpP/yc
        q4WDDTAKVQcGT/Nza2FSD8oeQQ==
X-Google-Smtp-Source: AKy350a2kAEH7+WLLI1ITrVWTrZeDXk6p4bqLumrKnIHUbCc8fxKRJ0lw2cmPJs7Tp0LKdtaKFyD2g==
X-Received: by 2002:ac2:48b2:0:b0:4a4:68b9:66f3 with SMTP id u18-20020ac248b2000000b004a468b966f3mr361539lfg.62.1681988153110;
        Thu, 20 Apr 2023 03:55:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id x16-20020ac25dd0000000b004eca8c303aesm176388lfq.214.2023.04.20.03.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:55:52 -0700 (PDT)
Message-ID: <e8b0011a-712b-e5ea-dc60-9e9ac4041ae4@linaro.org>
Date:   Thu, 20 Apr 2023 12:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 15/18] arm64: dts: qcom: sm8350: correct USB phy unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
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
 <20230419211856.79332-15-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-15-krzysztof.kozlowski@linaro.org>
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
>   Warning (simple_bus_reg): /soc@0/phy@88e9000: simple-bus unit address format error, expected "88e8000"
> 
> Fixes: 2458a305e80e ("arm64: dts: qcom: sm8350: switch to combo usb3/dp phy")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index 5ca21cd1cbec..425af2c38a37 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -2140,7 +2140,7 @@ usb_2_hsphy: phy@88e4000 {
>  			resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
>  		};
>  
> -		usb_1_qmpphy: phy@88e9000 {
> +		usb_1_qmpphy: phy@88e8000 {
>  			compatible = "qcom,sm8350-qmp-usb3-dp-phy";
>  			reg = <0 0x088e8000 0 0x3000>;
>  
