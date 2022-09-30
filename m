Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D45F12E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 21:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiI3Tl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiI3Tlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:41:55 -0400
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C3F149D20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:41:54 -0700 (PDT)
Received: from [192.168.1.101] (95.49.31.201.neoplus.adsl.tpnet.pl [95.49.31.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BAD52201B5;
        Fri, 30 Sep 2022 21:41:49 +0200 (CEST)
Message-ID: <880e62cc-a12c-33b2-2509-f0e05a0871af@somainline.org>
Date:   Fri, 30 Sep 2022 21:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm850-samsung-w737: correct I2C12
 pins drive strength
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Xilin Wu <wuxilin123@gmail.com>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220930192039.240486-1-krzysztof.kozlowski@linaro.org>
 <20220930192039.240486-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220930192039.240486-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.09.2022 21:20, Krzysztof Kozlowski wrote:
> The pin configuration (done with generic pin controller helpers and
> as expressed by bindings) requires children nodes with either:
> 1. "pins" property and the actual configuration,
> 2. another set of nodes with above point.
> 
> The qup_i2c12_default pin configuration used second method - with a
> "pinmux" child.
> 
> Fixes: d4b341269efb ("arm64: dts: qcom: Add support for Samsung Galaxy Book2")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> index f954fe5cb61a..d028a7eb364a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
> @@ -415,8 +415,10 @@ pinconf {
>  };
>  
>  &qup_i2c12_default {
> -	drive-strength = <2>;
> -	bias-disable;
> +	pinmux {
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
>  };
>  
>  &qup_uart6_default {
