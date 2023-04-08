Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD746DBB54
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDHOAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDHOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:00:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9FEF99
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:00:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z26so798455ljq.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680962411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKXpLgAj8oYLPVx9dT3CyvVPJYt5S8RGly9fby3z6Dw=;
        b=ZfID8vQLen9+HbzQFTdwlnVtA9gqNJ5n43+AlmLtozGMLUNgC5e2BeiXsajnSp7gHp
         28SU6IxWcNxilrUqYgYmLYB1htCk7v1bRPLPFLogQGDJ9vZmDlpAYzgMdYWUQIT7MV5g
         C+p8Gvg6v23dmhENGQ0dNixY4vKYpoyG13krrWcg/r4Kyc6fC5xFDFvr9p9VJk5onmQP
         DmE+wF5ZAu/SCqfT7hyGoF/zl98HFrxmSg5TPcoMEiCmwgWZK3Bflou3GZnlVlQTCTI4
         Illx0wF4zyF7raynL/EqV8yuFuMSW/Vy3+pg1fccGIgxRiFo+IK1VnOxnJ546lZl6O/W
         tCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680962411;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKXpLgAj8oYLPVx9dT3CyvVPJYt5S8RGly9fby3z6Dw=;
        b=q5WRNTnUoMOyEz2GeYzPLWB7Y9Xh5uSTpdMeCn69Si5jlvvAkdH5aK491OVAI623+I
         Ged0Avkxmv5e3S4Bwi2N/FJFU1FXGNrotJrKDedeB1t0b0L61bPRxfFJbQ1tTArHu/Fh
         LIBBtEs2xfdZbqJelKSnjWyZJjDWesJlXRnDG3qUl+kWFgd5Kfjl6bKYD8eciaSK9I7S
         rBNTrG5OvE5rEmUxEyAkXKHQJctj7a1fRHN+bCXY+Y6gZZWbikLhw3V8kLHWyiBzRVSb
         jC8a569LHxHawaDxwYrXNKZOGgFNQWX6jyWp3v/cyJJoQ09uBjGkJe17E2ixXW87BjEa
         AQBQ==
X-Gm-Message-State: AAQBX9cQRv7czF1JZ75SttyJlPwHiORMAmfi5a7All79X3dMsZopLCW2
        yK52RPO6eRlrNsFnLOpDi+Ba5A==
X-Google-Smtp-Source: AKy350YicaKIH5gF5CDEcHwGFd6sZpvU8tMcMkbbWAgPmpL1eSTAf7vWL2i7lPWKgroeeoi2gSpJQQ==
X-Received: by 2002:a2e:9f44:0:b0:295:9010:6f76 with SMTP id v4-20020a2e9f44000000b0029590106f76mr1377025ljk.1.1680962410882;
        Sat, 08 Apr 2023 07:00:10 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id v26-20020a19741a000000b004d58bf6a61asm1177051lfe.230.2023.04.08.07.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 07:00:10 -0700 (PDT)
Message-ID: <4808aa04-67f6-82d9-0d77-337b30aeb442@linaro.org>
Date:   Sat, 8 Apr 2023 16:00:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,gcc-sm8250: add missing
 bi_tcxo_ao clock
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230408134820.76050-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.04.2023 15:48, Krzysztof Kozlowski wrote:
> Without actual explanation commit 76bd127e6ca5 ("arm64: dts: qcom:
> sm8250: add bi_tcxo_ao to gcc clocks") added bi_tcxo_ao clock input to
> the GCC clock controller, so update the bindings hoping this is really
> needed.  This fixes warnings like:
The initial commit 3e5770921a88
("clk: qcom: gcc: Add global clock controller driver for SM8250")
already consumed it on the .c side, so the bindings were wrong..

> 
>   sm8250-xiaomi-elish-csot.dtb: clock-controller@100000: clock-names: ['bi_tcxo', 'bi_tcxo_ao', 'sleep_clk'] is too long
> 
> Fixes: 76bd127e6ca5 ("arm64: dts: qcom: sm8250: add bi_tcxo_ao to gcc clocks")
s/this/98394efb48f5 ("dt-bindings: clock: Add SM8250 GCC clock bindings")

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
> index b752542ee20c..ead6665b9a45 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sm8250.yaml
> @@ -23,11 +23,13 @@ properties:
>    clocks:
>      items:
>        - description: Board XO source
> +      - description: Board active XO source
>        - description: Sleep clock source
>  
>    clock-names:
>      items:
>        - const: bi_tcxo
> +      - const: bi_tcxo_ao
>        - const: sleep_clk
>  
>  required:
> @@ -47,8 +49,9 @@ examples:
>        compatible = "qcom,gcc-sm8250";
>        reg = <0x00100000 0x1f0000>;
>        clocks = <&rpmhcc RPMH_CXO_CLK>,
> +               <&rpmhcc RPMH_CXO_CLK_A>,
>                 <&sleep_clk>;
> -      clock-names = "bi_tcxo", "sleep_clk";
> +      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
>        #clock-cells = <1>;
>        #reset-cells = <1>;
>        #power-domain-cells = <1>;
