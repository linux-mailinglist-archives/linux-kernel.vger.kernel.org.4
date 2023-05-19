Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0ED70A344
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjESXYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjESXYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:24:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A28D1B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:24:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4ec8eca56cfso4243605e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684538655; x=1687130655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeXTcSjQ1u9WPirlSadWI4lW3NNlUgK10Dkih6okJFQ=;
        b=OO5rgIA7Iqshr5cs3rSGJ4XHDshZUm9a6cv9xjXEJ2aUbkpJ1cq20PeJsNohsxISX/
         4YLurx9dAH9Qmzw2i48VRcdF/GRRULUyD9W51Qnru5yw59zdVPv9eyPeaFCor7q0hYLI
         eL1/g6CpL0ToHl3aQpP6NX0jBa3e6IA7XsJE/yb/RGVg607oPFTTV/Nfyia9dnDYBC8z
         Qnw2BACEloMh9ujzM6MCoBIJ0bKf0Uk55rQTy1SYl747AVqTP7wWlCFoMIfinTxH9/Ca
         VoRXpDWXOraoW6GBlhSZJrrBtXpI5LFoeIkJzWGUln/Lcb2xVQMcuoJsfV1atDmK2+6B
         8MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684538655; x=1687130655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeXTcSjQ1u9WPirlSadWI4lW3NNlUgK10Dkih6okJFQ=;
        b=Eigu0mlY42ads1wL+SsHB1u/brww35vDHTL3acL/yg22I9VV19G3SNYMWYhqM/4Noc
         /nLTB0pewqugDHABqG2xJ38MH8Po/Jj0bwJxiF8zwDBQoYwPBiE09CF+bhcSJ1zZqRpT
         +C1ssqzs3ll7ofAvzhO8d6ua7MRpRRvgWHVyrzkmY7lb0si2V0i3IJh1onxiTfBgcLm7
         jHJEn+N9uQ1N/nA0++xoyWsuKfEF6sSUeg8iUrx8yZwli8mQDzgORGePyziIKrLHk4kk
         xRpmYkT3spY6zUbLpuyYYEE64uTnhT7CB130iWElce/oSKnc/aAXkwFp8OFPRUvKctB/
         VyMw==
X-Gm-Message-State: AC+VfDyOIke2Xa/csbtSGfXiiS9eUHawJ6n1dIt6NJ8gfwD4cK8CwLvg
        onbYGCzGFvxLUgO2UZhz5D41jE54MoFs33pB/Ts=
X-Google-Smtp-Source: ACHHUZ7DKkjO9fUHI9Nf4reCnLMCyIe5yBRYrCRS5Qj4H/L+Tf1xn/fenq+byrA4tAtTCDsbuCYqRQ==
X-Received: by 2002:ac2:420b:0:b0:4ef:e895:cff2 with SMTP id y11-20020ac2420b000000b004efe895cff2mr885589lfh.64.1684538655282;
        Fri, 19 May 2023 16:24:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25322000000b004d4d7fb0e07sm54480lfh.216.2023.05.19.16.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:24:14 -0700 (PDT)
Message-ID: <eed1bfec-70f4-953e-ae9b-38b987edc3bd@linaro.org>
Date:   Sat, 20 May 2023 01:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] ARM: dts: qcom: msm8226: Add rpm-stats device node
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230519210903.117030-1-matti.lehtimaki@gmail.com>
 <20230519210903.117030-4-matti.lehtimaki@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230519210903.117030-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.05.2023 23:09, Matti Lehtimäki wrote:
> Add device node for the rpm-stats pseudo device.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index e272a1e15b44..006263373348 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -597,6 +597,11 @@ frame@f9028000 {
>  			};
>  		};
>  
> +		sram@fc190000 {
> +			compatible = "qcom,msm8226-rpm-stats";
> +			reg = <0xfc190000 0x10000>;
> +		};
> +
>  		rpm_msg_ram: sram@fc428000 {
>  			compatible = "qcom,rpm-msg-ram";
>  			reg = <0xfc428000 0x4000>;
