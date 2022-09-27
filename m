Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A045EC2D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiI0Mhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiI0Mhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:37:46 -0400
X-Greylist: delayed 242 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 05:37:45 PDT
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488F14B86B;
        Tue, 27 Sep 2022 05:37:45 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 49C6A3F093;
        Tue, 27 Sep 2022 14:37:43 +0200 (CEST)
Message-ID: <95d3274c-5318-5af3-f59e-b7e7939d5f9b@somainline.org>
Date:   Tue, 27 Sep 2022 14:37:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 05/15] arm64: dts: qcom: sc7280-herobrine: correct number
 of gpio-line-names
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
 <20220925110608.145728-6-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925110608.145728-6-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 13:05, Krzysztof Kozlowski wrote:
> There are 175 GPIOs (gpio0-174).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts          | 1 +
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts    | 1 -
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 -
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi    | 1 -
>  4 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index f0f26af1e421..4e0b013e25f4 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -372,5 +372,6 @@ &tlmm {
>  			  "",				/* 170 */
>  			  "MOS_BLE_UART_TX",
>  			  "MOS_BLE_UART_RX",
> +			  "",
>  			  "";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> index ccbe50b6249a..739e81bd6d68 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker-r0.dts
> @@ -328,6 +328,5 @@ &tlmm {
>  			  "MOS_BLE_UART_TX",
>  			  "MOS_BLE_UART_RX",
>  			  "",
> -			  "",
>  			  "";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index c1a671968725..c8ff13db30b9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -358,6 +358,5 @@ &tlmm {
>  			  "MOS_BLE_UART_TX",
>  			  "MOS_BLE_UART_RX",
>  			  "",
> -			  "",
>  			  "";
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> index 4566722bf4dd..3dff610fb946 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> @@ -321,6 +321,5 @@ &tlmm {
>  			  "MOS_BLE_UART_TX",
>  			  "MOS_BLE_UART_RX",
>  			  "",
> -			  "",
>  			  "";
>  };
