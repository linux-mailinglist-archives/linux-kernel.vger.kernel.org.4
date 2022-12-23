Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6CF6550F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiLWNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiLWNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:22:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF33140B1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:22:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g13so7083060lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=soK7jySXnMg+Xdlxcdmo/Eg51l8gaiSZN7O3V9Ct6Xk=;
        b=IqNmHhVsCfTAgOHaRBvTZKBF4razBaSskjsQcg+rG9urIs/WEtBAflh+0equkNZiKA
         sabxiqptQdmjUy6ImZVedbL8du+0tz9TOCXlNr6tKAZmVouYORBJ2mxZauoySO36DJjx
         kdFmkYmSXbJhG4VtY7BlqL/8W9QYq8PFVwLJ+aOBJd250mYW8CRJwyTGXvX+GyNA2f8a
         4SDDutWWOPyWr/YpP+T8uHTG+UB59ND7SzTHRFBf0fyvt/f7f/CGjWCYuHZbsssAg+sh
         Uh11JkU1lwZAuZnsnS5W9gSBOyt6onsIkML4HOEJF/qLaaOJrn1Ud61DXz7Je1QToo+H
         HpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soK7jySXnMg+Xdlxcdmo/Eg51l8gaiSZN7O3V9Ct6Xk=;
        b=W2eMnTwvVUNuSXx9HSFQRcbQFpmoOYy72E8pQ33Ev+pi1jp2wZLcRRpDkXplTjV5Uh
         6NIg3eX6RxmPo46Je8fSx6Yp9HpSFQchbi1WIL5wJ7FrEK7a2TC6XhTyejHZWaaWLp1a
         OdoxVBJKKG8/yQt+nJhBI3clBeXie9S0sm5lPYI698y5NOzdVzfA+IKAp5FBTk5Tx+Ft
         ATVJ6EPTfCuOwmzM380V0M9MoKm6HAF0qc1z3hN6kwG6XSV4ELDR/6bpTahhxeT5fl7k
         5bIjpOEnQejESEkkQ0G2IoGZLyCpwsZ5gqNmxQ91xT67EZHEhFxSyPO+djzhXCahCY00
         TNtw==
X-Gm-Message-State: AFqh2konFqCWsgxoZCP22MB9hf06waN5M4CV33BSt19l6ccL1J8FXNZW
        Pa1543FpaOatOpqjKP6tKbRwEQ==
X-Google-Smtp-Source: AMrXdXvv9z4x3R54XG2AyKYluKMMU/SALua3H4ram8M1439Lhk6UnS8nP/KK9czWrq4nsEKvfzHxvg==
X-Received: by 2002:a05:6512:2216:b0:4b5:959f:6498 with SMTP id h22-20020a056512221600b004b5959f6498mr3354518lfu.62.1671801753301;
        Fri, 23 Dec 2022 05:22:33 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id du13-20020a056512298d00b00492b494c4e8sm521957lfb.298.2022.12.23.05.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 05:22:32 -0800 (PST)
Message-ID: <dfd52b43-216d-29e8-e6ba-e2257d972eeb@linaro.org>
Date:   Fri, 23 Dec 2022 14:22:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: correct Soundwire wakeup
 interrupt name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221223132121.81130-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221223132121.81130-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.12.2022 14:21, Krzysztof Kozlowski wrote:
> The bindings expect second Soundwire interrupt to be "wakeup" (Linux
> driver takes by index):
> 
>   sm8450-hdk.dtb: soundwire-controller@33b0000: interrupt-names:1: 'wakeup' was expected
> 
> Fixes: 14341e76dbc7 ("arm64: dts: qcom: sm8450: add Soundwire and LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 570475040d95..eb3318516243 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -2263,7 +2263,7 @@ swr2: soundwire-controller@33b0000 {
>  			reg = <0 0x33b0000 0 0x2000>;
>  			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>  					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> -			interrupt-names = "core", "wake";
> +			interrupt-names = "core", "wakeup";
>  
>  			clocks = <&vamacro>;
>  			clock-names = "iface";
