Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE6C8DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCYMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:03:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B45113DF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:03:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y15so5467819lfa.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679745817;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6j1VQpMAyc7WS9oetMlOZogxFB7dE/fVbl9yOMaHBRY=;
        b=GiHwvlAQ4X6GhvAwXr/mBga1uvXb22rx0lW9XQ19QE2FiB4mJ11kkMb7ZH624BMK1y
         dISAG4gT7tdF6XLkbYVSREf3e118u8/OPoOGda1dvAttMwj9KZFNeGjv4TIuugILgj9n
         KECcHTwyj6lxhToi4AjVJwTeWw4iXAvBblaY1hmb3NfBGPzHoEHe1hWvNsM2bkHZ9fbU
         PjystD/0azs/4TLvi6st0FhPoqEUieqCpr1j9iUJNNc41k3xa2KBbxX/rCVZ1ubbuOFi
         EcDLclt8935MZ1zI/tt1L3BjnJ9dVRaZKhnfn3W4tj7CAIvoLWGrRx7oCT7H0fgjVjgj
         e9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679745817;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6j1VQpMAyc7WS9oetMlOZogxFB7dE/fVbl9yOMaHBRY=;
        b=HVV2M3VYdvVLYI7Qcr+LMJ98XeFwdCsW53qrzLEwgzMHXWMg2BUCQkBSTlDddga+o6
         bOoRMeom9GTQArWpH1dS1oDoC134D9DNaaV2QpNCBv/kkq3cRbbC6sTjgcGTFDoUN56M
         UWyFxPPaxINLhXL4QGLxB1ZPfc7k/2o2ofzXV4esOJqR6WWBJBjdvZz21pdct2OjL9bh
         k97vefS/bArT73UO/dKBRr1oRWfm7vAvamC960XU4ANqAZFgyIiziYjWCxAj/AluHwRF
         Ze/W7HkWaJFK0QTMKx5/bDGKL3SqVR4d0deXT/j/uwhCAOTU+ocUEVtCwCCj9DrPZFBs
         eNmQ==
X-Gm-Message-State: AAQBX9fxWDoKa/DLEa1+WuW8LyHHnZg08ayCY8DxXMeWSLUn3ZPypYfY
        c7ytT9IREvbZ7nyE4ZIP6nlOcw==
X-Google-Smtp-Source: AKy350ZzN9OJhP/Ot1TSpNvOZEsVl9lYEzZ7Q/BLVb1/ztv6yS1z6ei13XsxcqimDHzvulXz6jwyfg==
X-Received: by 2002:ac2:43a4:0:b0:4ea:f526:5bee with SMTP id t4-20020ac243a4000000b004eaf5265beemr1490748lfl.11.1679745817306;
        Sat, 25 Mar 2023 05:03:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id h16-20020a05651211d000b004db3e445f1fsm3788770lfr.97.2023.03.25.05.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:03:37 -0700 (PDT)
Message-ID: <9c2d3f35-00cb-0b32-d943-436234cf0a68@linaro.org>
Date:   Sat, 25 Mar 2023 13:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] arm64: dts: qcom: msm8996-xiaomi: drop simple-bus
 from clocks
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
 <20230324202244.744271-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230324202244.744271-4-krzysztof.kozlowski@linaro.org>
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



On 24.03.2023 21:22, Krzysztof Kozlowski wrote:
> 'clocks' node is not a bus, but just a placeholder for clocks:
> 
>   msm8996-xiaomi-gemini.dtb: clocks: $nodename:0: 'clocks' does not match '^([a-z][a-z0-9\\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
>     From schema: dtschema/schemas/simple-bus.yaml
>   msm8996-xiaomi-gemini.dtb: clocks: xo-board: {'compatible': ['fixed-clock'], '#clock-cells': [[0]], ...
>     From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> index 446b1d23dec0..1ce5df0a3405 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996-xiaomi-common.dtsi
> @@ -12,8 +12,6 @@
>  
>  / {
>  	clocks {
> -		compatible = "simple-bus";
> -
>  		divclk1_cdc: divclk1 {
>  			compatible = "gpio-gate-clock";
>  			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
