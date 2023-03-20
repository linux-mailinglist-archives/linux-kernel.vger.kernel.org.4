Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAC96C1DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjCTR0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjCTR0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:26:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7717186A1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:21:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f18so15869702lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679332894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d33GSEIhjcgK4YD4SY5K2p9D8wPjnvBosktbw2bm0Mo=;
        b=Pn1ZBz2nUNUEy1NSl63mOH4VAEC+wNEYCMhw2cXsOIICIFpbAsvUyvTCeezvJNG+gc
         FNUtbsY/XzX4GlqUN6FsqxRmZCK9dLKUCMlsg3xpZjl+4N1V7VZS/ZvTkw7smXTQh6Sh
         CSI9HvqnziODiXRMZM19biXfs/BsHfwweqfO92O/7flcFxdguLRPL9SRMra54uQqa/KQ
         mQYg+GcPFD1rGizGM1SQJBNOVBuTGN4zZR+GGELsyCUglOvFO85awkVRXtAryLXu5A6U
         g5V94zofhui6KsjJE0CWP7hklMnwTmIcEJBx5GRoaSspbGluIgnC0GtHKdHySUZlZTXf
         n7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d33GSEIhjcgK4YD4SY5K2p9D8wPjnvBosktbw2bm0Mo=;
        b=QQ7tfqysfJXBgiZV6KpXErGhuiPzykdrMhWOoUHSylyT/eDdp+34WIwcGkIz+a+qTG
         0jnKOVQGU41CW32sir8B35xqFrT04iYGC+FLrf9on89jhc5E3WcUA2ADbeNCYgSlrMvH
         0XrrVyOPLMecjeG51v6hCzV72hdgtBQKNMSmYhPeeXXWBp/tFvF500A5MVtGcDUq+dJi
         A1gYSF5i5Knomw7LgzzKUQrcNVW9cg8VbWcOH+77KYqcAzeCsiLHFeNfVySwxqMJxRnq
         6Ba78uss3RL/3Tbr4n1IZqYeVnI4xFHqpDZtWzJq/kM+fu5FM1JB7m0mhtjbNU3PVKsE
         N/Jg==
X-Gm-Message-State: AO0yUKVbGg3l61TpgZ6+NwPMKNdr18HLIffvty2zLWQfWa9e+DyJUEUU
        /dgfAvuOmnmRU/XsLPZUf4jU0Q==
X-Google-Smtp-Source: AK7set/xYE1xVD8Q0baI5iE/hbOvvXi+ayGDN1+GxMvAoWpYZaX93eZn+HiD1Ac4EFUH3qe/YFoNhg==
X-Received: by 2002:ac2:4830:0:b0:4e8:401a:3e2b with SMTP id 16-20020ac24830000000b004e8401a3e2bmr198792lft.5.1679332894472;
        Mon, 20 Mar 2023 10:21:34 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id s1-20020a19ad41000000b004d023090504sm1775899lfd.84.2023.03.20.10.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 10:21:34 -0700 (PDT)
Message-ID: <50ec6d00-0a9a-ac2f-56fb-a11917f4f4e8@linaro.org>
Date:   Mon, 20 Mar 2023 18:21:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 04/15] arm64: dts: qcom: sa8775p: add the pdc node
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230320154841.327908-1-brgl@bgdev.pl>
 <20230320154841.327908-5-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320154841.327908-5-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 16:48, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the Power Domain Controller node for SA8775p.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 296ba69b81ab..797af99227e4 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -591,6 +591,47 @@ tcsr_mutex: hwlock@1f40000 {
>  			#hwlock-cells = <1>;
>  		};
>  
> +		pdc: interrupt-controller@b220000 {
> +			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
> +			reg = <0x0 0x0b220000 0x0 0x30000>,
> +			      <0x0 0x17c000f0 0x0 0x64>;
> +			qcom,pdc-ranges = <0 480 40>,
> +					  <40 140 14>,
> +					  <54 263 1>,
> +					  <55 306 4>,
> +					  <59 312 3>,
> +					  <62 374 2>,
> +					  <64 434 2>,
> +					  <66 438 2>,
> +					  <70 520 1>,
> +					  <73 523 1>,
> +					  <118 568 6>,
> +					  <124 609 3>,
> +					  <159 638 1>,
> +					  <160 720 3>,
> +					  <169 728 30>,
> +					  <199 416 2>,
> +					  <201 449 1>,
> +					  <202 89 1>,
> +					  <203 451 1>,
> +					  <204 462 1>,
> +					  <205 264 1>,
> +					  <206 579 1>,
> +					  <207 653 1>,
> +					  <208 656 1>,
> +					  <209 659 1>,
> +					  <210 122 1>,
> +					  <211 699 1>,
> +					  <212 705 1>,
> +					  <213 450 1>,
> +					  <214 643 2>,
> +					  <216 646 5>,
> +					  <221 390 5>;
My sources say

<226 700 2>,
<228 440 1>,
<229 663 1>,
<230 524 2>,
<232 612 3>,
<235 723 5>;

should be there too, please doublecheck.

Konrad
> +			#interrupt-cells = <2>;
> +			interrupt-parent = <&intc>;
> +			interrupt-controller;
> +		};
> +
>  		tlmm: pinctrl@f000000 {
>  			compatible = "qcom,sa8775p-tlmm";
>  			reg = <0x0 0x0f000000 0x0 0x1000000>;
