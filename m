Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85416E90CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbjDTKrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjDTKrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:47:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FADB7EEC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:46:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec816d64afso2129573e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987565; x=1684579565;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80SojS+YK6rf+PZpCfST1iOuGqJ3pEykM8qTTcyCRd4=;
        b=GJIra68uw1rAkAbJtYLv7w4lvAIJsPxuev4NQonvt3LZ7vUYLGloU31PSCD2uo8cmh
         EmuqHe6GkeA4INjfWzwDeTvHvCI8y4ONJZmNdvzLtCtTDZviBt7VH06tJ6ArRMtIxpc2
         UMMBVqHa7BqAJAyOwEWR0wTdtBwNUqKUE5lmQSt87RQO0lMiEaEHbW1UCOyjbBc+94/S
         cBSiN+X9NX8qo3BlTMK3KiYQPOckEak/FaJNn5kW2yPf5mp8QrdRvJL/6oTNN8Ybt08F
         cCvhAnEKfDyEOtR6xuGT0Asm1FF91e5yOZhgY9md3ad1ap+NiXeuhXGo/tOsQyESJ0hg
         zHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987565; x=1684579565;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80SojS+YK6rf+PZpCfST1iOuGqJ3pEykM8qTTcyCRd4=;
        b=h+EoRYo3N+Mx4vlWxTO4KWYHn6mHnA2dsF6W6Xgo1vdXh6fcpUqFeJp1U90lmE+SKp
         H2F545uLz3eo8PEkB7tQ+dVJKvF4oHG5Hex7K5Jec4l0YulCoKC8fjRWhPfkGZWXtqH9
         vO8itgUvSLwz5vqimtawmHLhVAzfKaTiCeLK8LoaB1zfOKMNWfB6VhS+cBWENjjMWvXW
         BUL8chh4AXvE1RIq2eqb9Fv1Uw02a1LMyvU5kPFCAXLGJXm0ydgEbZMcQJS8vkEVPQ0w
         f1GaB3vunUDZanDiWUAXqm0t46Qcqg6T4pJrfpQ+5IBe2LRnhpN/JXSuJVGSfQrdHrBJ
         Xt6A==
X-Gm-Message-State: AAQBX9ebRzhKNhK3EtkIoGvC78PqgC4rc0BoHAXs0XZ71wU58qKKARKt
        WrZNt1uB5grORVGFZX9zVBubQA==
X-Google-Smtp-Source: AKy350YF4pf/6KJ/ncjSu3Hj84EceiAiVMKepHlvmqFHZ8Ld21hmiDFQmMuCVNox2xMdzyrE8jfl5A==
X-Received: by 2002:ac2:5628:0:b0:4dc:790c:910b with SMTP id b8-20020ac25628000000b004dc790c910bmr433318lff.20.1681987564863;
        Thu, 20 Apr 2023 03:46:04 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id p5-20020ac246c5000000b004eafabb4dc1sm172566lfo.250.2023.04.20.03.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:46:04 -0700 (PDT)
Message-ID: <287d234d-db6f-d814-d173-c5cf233488b9@linaro.org>
Date:   Thu, 20 Apr 2023 12:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 03/10] ARM: dts: qcom: msm8974: correct pronto
 unit-address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
 <20230420075053.41976-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420075053.41976-3-krzysztof.kozlowski@linaro.org>
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



On 20.04.2023 09:50, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/remoteproc@fb21b000: simple-bus unit address format error, expected "fb204000"
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 788d9540fab8..939449a0c695 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -707,7 +707,7 @@ rng@f9bff000 {
>  			clock-names = "core";
>  		};
>  
> -		pronto: remoteproc@fb21b000 {
> +		pronto: remoteproc@fb204000 {
>  			compatible = "qcom,pronto-v2-pil", "qcom,pronto";
>  			reg = <0xfb204000 0x2000>, <0xfb202000 0x1000>, <0xfb21b000 0x3000>;
>  			reg-names = "ccu", "dxe", "pmu";
