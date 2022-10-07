Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB135F7E30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJGTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJGTjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:39:49 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81236178
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:39:37 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3BFA01F8F4;
        Fri,  7 Oct 2022 21:39:35 +0200 (CEST)
Message-ID: <c8c48b34-974d-7497-c44d-992d0c4116cb@somainline.org>
Date:   Fri, 7 Oct 2022 21:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm630: correct I2C8 pin functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221006104104.171368-1-krzysztof.kozlowski@linaro.org>
 <20221006104104.171368-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221006104104.171368-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.10.2022 12:41, Krzysztof Kozlowski wrote:
> The I2C8 pins are split into i2c8_a (GPIO30 and GPIO31) and i2c8_b
> (GPIO44 and GPIO52).  Correct the name of function for I2C8 pins.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index bc7c341e793c..796c19b9b2eb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -885,14 +885,14 @@ i2c7_sleep: i2c7-sleep {
>  
>  			i2c8_default: i2c8-default {
>  				pins = "gpio30", "gpio31";
> -				function = "blsp_i2c8";
> +				function = "blsp_i2c8_a";
>  				drive-strength = <2>;
>  				bias-disable;
>  			};
>  
>  			i2c8_sleep: i2c8-sleep {
>  				pins = "gpio30", "gpio31";
> -				function = "blsp_i2c8";
> +				function = "blsp_i2c8_a";
>  				drive-strength = <2>;
>  				bias-pull-up;
>  			};
