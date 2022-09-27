Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23655EC2EF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiI0Mjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiI0MjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:39:25 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B301215D66E;
        Tue, 27 Sep 2022 05:39:23 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id ACEAB3F35C;
        Tue, 27 Sep 2022 14:39:21 +0200 (CEST)
Message-ID: <72a150f1-c91b-cd46-6933-3ef101a428f9@somainline.org>
Date:   Tue, 27 Sep 2022 14:39:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sm6125-sony-xperia: add missing
 SD CD GPIO functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220925110608.145728-1-krzysztof.kozlowski@linaro.org>
 <20220925110608.145728-10-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925110608.145728-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 13:06, Krzysztof Kozlowski wrote:
> Add default GPIO function to SD card detect pins on SM6125 Sony Xperia,
> as required by bindings:
> 
>   qcom/sm6125-sony-xperia-seine-pdx201.dtb: pinctrl@500000: sdc2-off-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'clk-pins', 'cmd-pins', 'data-pins', 'sd-cd-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> index 6a8b88cc4385..9af4b76fa6d7 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
> @@ -89,6 +89,7 @@ &hsusb_phy1 {
>  &sdc2_off_state {
>  	sd-cd-pins {
>  		pins = "gpio98";
> +		function = "gpio";
>  		drive-strength = <2>;
>  		bias-disable;
>  	};
> @@ -97,6 +98,7 @@ sd-cd-pins {
>  &sdc2_on_state {
>  	sd-cd-pins {
>  		pins = "gpio98";
> +		function = "gpio";
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
