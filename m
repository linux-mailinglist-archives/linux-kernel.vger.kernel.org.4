Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07206E407C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDQHP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjDQHPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:15:38 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE8D40EF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:15:35 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ba693f69so9680201fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681715733; x=1684307733;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/TvWr+9kp1knFvmmJU83VjiTcaI+1vPPsS8xOeXyBw=;
        b=by2bfYknZLhlnefPu3jGNQy/fIU/YTiWQl0oIBuddPpgeC0Ns4bayih5kn/Khdf/wu
         osvBJed8/Os4iuHftKq9O4Nu1PWeWq/ID6MCfbmrKs51jKG5inS65dmoUPz/mgh2ibEI
         8HZ5GZo8EOTmwa7RhHyFQZY9jQLHC17t0E7imaDm1N5sUsZoekGXGAzh+YAz/exf2pNg
         +ISSNU8WXKxwJIPcNd9sHwgtz2SyiIs0+PbCTQoGL7gT+KTuwR+IOLPMdARmkRjDQUXF
         Si+MLCtrxqjB3m7Jb3IKpH8/xyg6T//Zvz/zt06ft0eq9pFmoHi7HRl4iO0u5jZFfYkc
         imhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681715733; x=1684307733;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/TvWr+9kp1knFvmmJU83VjiTcaI+1vPPsS8xOeXyBw=;
        b=Kty50GN0WmYmcnqGfqqBr317KyJrlhvc2MAtIu71489gSBpwTI1eBpgEwM4vNFRTiU
         HRQSoOKa5fGtmESV2OJYoiyBAd659wGKCGw41MmK1g10BAnewUsZmS2CgZtoLNyAQemv
         b9rb/v/z1FKez5Jt8saF5nVnx2prI6fzBhwYcG23GeM/oOW3QhCyzGMhLibyb6aZn7KP
         o84hnp18PGJBl/UV5dHeRAVh+GCsoklcS8gGFMLr7Eyh6A7hqCS9UmQB/xSzvWaVNgMj
         r7Xfr64FGVMwwPhNtaYTD1uwCD+ZPPW9pMsMwd/H+uASfQr4IxhhQFBequGdhauNu+rI
         2VAQ==
X-Gm-Message-State: AAQBX9fKjZBrglgO/eoXxiXz1phmM4h0Uexnuf+8lmwEpyWTF9gs196S
        IUt0IYu9gYIjIcpKkeelA5OYUg==
X-Google-Smtp-Source: AKy350an8+ro3x7hphG8cQXuBVAUsJd84/VKghLb4vmdsgoe3LDwhPWhF64B1XYOHeW24M8EVyKFfA==
X-Received: by 2002:ac2:47e1:0:b0:4e9:ce2c:26b0 with SMTP id b1-20020ac247e1000000b004e9ce2c26b0mr1849734lfp.14.1681715733685;
        Mon, 17 Apr 2023 00:15:33 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004d856fe5121sm1949847lfq.194.2023.04.17.00.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:15:33 -0700 (PDT)
Message-ID: <e91d293a-fa6f-758f-dbb1-efad8cc9114a@linaro.org>
Date:   Mon, 17 Apr 2023 09:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sm8150: drop incorrect serial
 properties
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230416151311.346596-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.04.2023 17:13, Krzysztof Kozlowski wrote:
> Drop incorrect and unused serial properties - address/size-cells and
> reg-names:
> 
>   sa8155p-adp.dtb: geniqup@ac0000: serial@a84000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'reg-names' were unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index 27dcda0d4288..3846f5e0f656 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -1362,14 +1362,11 @@ spi9: spi@a84000 {
>  			uart9: serial@a84000 {
>  				compatible = "qcom,geni-uart";
>  				reg = <0x0 0x00a84000 0x0 0x4000>;
> -				reg-names = "se";
>  				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
>  				clock-names = "se";
>  				pinctrl-0 = <&qup_uart9_default>;
>  				pinctrl-names = "default";
>  				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  				status = "disabled";
>  			};
>  
