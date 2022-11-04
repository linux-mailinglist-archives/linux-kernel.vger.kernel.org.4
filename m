Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1F4619962
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiKDOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiKDOUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:20:22 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6031357
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:19:37 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 861343F336;
        Fri,  4 Nov 2022 15:19:35 +0100 (CET)
Message-ID: <fdf459a5-a9bf-47f4-8bea-7556c5997d6a@somainline.org>
Date:   Fri, 4 Nov 2022 15:19:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: msm8916-alcatel-idol347: Add
 GPIOs -state suffix
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
 <20221104132400.1763218-2-vincent.knecht@mailoo.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104132400.1763218-2-vincent.knecht@mailoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 14:23, Vincent Knecht wrote:
> Add -state suffix to GPIOs states node names as required by dt-bindings.
>
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---

Reviewed-by Konrad Dybcio <konrad.dybcio@somainline.org>


Konrad

>   .../boot/dts/qcom/msm8916-alcatel-idol347.dts      | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> index 3dc9619fde6e..668f8ff53229 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
> @@ -260,7 +260,7 @@ l18 {
>   };
>   
>   &msmgpio {
> -	accel_int_default: accel-int-default {
> +	accel_int_default: accel-int-default-state {
>   		pins = "gpio31";
>   		function = "gpio";
>   
> @@ -268,7 +268,7 @@ accel_int_default: accel-int-default {
>   		bias-disable;
>   	};
>   
> -	gpio_keys_default: gpio-keys-default {
> +	gpio_keys_default: gpio-keys-default-state {
>   		pins = "gpio107";
>   		function = "gpio";
>   
> @@ -276,7 +276,7 @@ gpio_keys_default: gpio-keys-default {
>   		bias-pull-up;
>   	};
>   
> -	gyro_int_default: gyro-int-default {
> +	gyro_int_default: gyro-int-default-state {
>   		pins = "gpio97", "gpio98";
>   		function = "gpio";
>   
> @@ -284,7 +284,7 @@ gyro_int_default: gyro-int-default {
>   		bias-disable;
>   	};
>   
> -	mag_reset_default: mag-reset-default {
> +	mag_reset_default: mag-reset-default-state {
>   		pins = "gpio8";
>   		function = "gpio";
>   
> @@ -292,7 +292,7 @@ mag_reset_default: mag-reset-default {
>   		bias-disable;
>   	};
>   
> -	proximity_int_default: proximity-int-default {
> +	proximity_int_default: proximity-int-default-state {
>   		pins = "gpio12";
>   		function = "gpio";
>   
> @@ -300,7 +300,7 @@ proximity_int_default: proximity-int-default {
>   		bias-pull-up;
>   	};
>   
> -	ts_int_reset_default: ts-int-reset-default {
> +	ts_int_reset_default: ts-int-reset-default-state {
>   		pins = "gpio13", "gpio100";
>   		function = "gpio";
>   
> @@ -308,7 +308,7 @@ ts_int_reset_default: ts-int-reset-default {
>   		bias-disable;
>   	};
>   
> -	usb_id_default: usb-id-default {
> +	usb_id_default: usb-id-default-state {
>   		pins = "gpio69";
>   		function = "gpio";
>   
