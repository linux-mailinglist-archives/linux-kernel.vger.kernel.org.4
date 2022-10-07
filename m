Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F935F7E27
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJGTjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiJGTia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:38:30 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47439103DB9;
        Fri,  7 Oct 2022 12:38:29 -0700 (PDT)
Received: from [192.168.1.101] (95.49.30.201.neoplus.adsl.tpnet.pl [95.49.30.201])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0381B2009D;
        Fri,  7 Oct 2022 21:38:26 +0200 (CEST)
Message-ID: <450d2490-2640-6a4a-946f-e401ba68d52c@somainline.org>
Date:   Fri, 7 Oct 2022 21:38:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 3/6] arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix
 sx150xq node names and probe-reset property
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-3-0cbc006e2a30@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v1-3-0cbc006e2a30@linaro.org>
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



On 6.10.2022 11:58, Neil Armstrong wrote:
> Fix the sx150xq node names to pinctrl and use the right probe-reset property.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Could you please also fix up the property order (may be in a separate patchset ofc)?

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> index 30a110984597..a8304769b509 100644
> --- a/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> +++ b/arch/arm/boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts
> @@ -116,7 +116,7 @@ i2c@4 {
>  			#size-cells = <0>;
>  			reg = <4>;
>  
> -			gpioext0: gpio@3e {
> +			gpioext0: pinctrl@3e {
>  				/* GPIO Expander 0 Mapping :
>  				 * - 0: ARDUINO_RESET_Level shift
>  				 * - 1: BattChrgr_PG_N
> @@ -142,7 +142,7 @@ gpioext0: gpio@3e {
>  				interrupt-parent = <&gpioext1>;
>  				interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
>  
> -				probe-reset;
> +				semtech,probe-reset;
>  
>  				gpio-controller;
>  				interrupt-controller;
> @@ -154,7 +154,7 @@ i2c@5 {
>  			#size-cells = <0>;
>  			reg = <5>;
>  
> -			gpioext1: gpio@3f {
> +			gpioext1: pinctrl@3f {
>  				/* GPIO Expander 1 Mapping :
>  				 * - 0: GPIOEXP_INT1
>  				 * - 1: Battery detect
> @@ -183,7 +183,7 @@ gpioext1: gpio@3f {
>  				interrupt-parent = <&msmgpio>;
>  				interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
>  
> -				probe-reset;
> +				semtech,probe-reset;
>  
>  				gpio-controller;
>  				interrupt-controller;
> @@ -195,7 +195,7 @@ i2c@6 {
>  			#size-cells = <0>;
>  			reg = <6>;
>  
> -			gpioext2: gpio@70 {
> +			gpioext2: pinctrl@70 {
>  				/* GPIO Expander 2 Mapping :
>  				 * - 0: USB_HUB_INTn
>  				 * - 1: HUB_CONNECT
> @@ -221,7 +221,7 @@ gpioext2: gpio@70 {
>  				interrupt-parent = <&gpioext1>;
>  				interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
>  
> -				probe-reset;
> +				semtech,probe-reset;
>  
>  				gpio-controller;
>  				interrupt-controller;
> 
