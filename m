Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9275F6193A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKDJfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKDJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:35:39 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9142A73F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 02:35:36 -0700 (PDT)
Received: from [192.168.31.208] (unknown [194.29.137.22])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 65CB1401C8;
        Fri,  4 Nov 2022 10:35:34 +0100 (CET)
Message-ID: <139c06eb-14b8-10b5-80b7-ba8ec8579846@somainline.org>
Date:   Fri, 4 Nov 2022 10:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v10 3/4] arm64: dts: qcom: sc7280: Add touchscreen and
 touchpad support for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221104061941.2739938-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221104141515.v10.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20221104141515.v10.3.I3ac715e729f6f9b5a3e3001b155df4f9d14e6186@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/11/2022 07:19, Sheng-Liang Pan wrote:
> Change touchpad and touchscreen node for evoker
> Touchpad: SA461D-1011
> Touchscreen: GT7986U

What's the reasoning? Were they changed post r0? Is r0 support 
effectively dropped?

The changes look ok, but I feel like this needs more of a comment in the 
commit msg.


Konrad

>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v8:
> - updated patch subjects
>
> Changes in v7:
> - add compiatable for gt7986
>
> Changes in v6:
> - add removed pinctrl and align touchscreen label with herobrine board
>
> Changes in v5:
> - new patch for Touchscreen/trackpad in v5
>
>   .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi    | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> index a6015491c6082..706dd82a70138 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> @@ -23,16 +23,15 @@ ap_tp_i2c: &i2c0 {
>   	status = "okay";
>   	clock-frequency = <400000>;
>   
> -	trackpad: trackpad@2c {
> -		compatible = "hid-over-i2c";
> -		reg = <0x2c>;
> +	trackpad: trackpad@15 {
> +		compatible = "elan,ekth3000";
> +		reg = <0x15>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&tp_int_odl>;
>   
>   		interrupt-parent = <&tlmm>;
>   		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>   
> -		hid-descr-addr = <0x20>;
>   		vcc-supply = <&pp3300_z1>;
>   
>   		wakeup-source;
> @@ -43,9 +42,9 @@ ts_i2c: &i2c13 {
>   	status = "okay";
>   	clock-frequency = <400000>;
>   
> -	ap_ts: touchscreen@10 {
> -		compatible = "elan,ekth6915";
> -		reg = <0x10>;
> +	ap_ts: touchscreen@5d {
> +		compatible = "goodix,gt7986u", "goodix,gt7375p";
> +		reg = <0x5d>;
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
>   
> @@ -54,7 +53,7 @@ ap_ts: touchscreen@10 {
>   
>   		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
>   
> -		vcc33-supply = <&ts_avdd>;
> +		vdd-supply = <&ts_avdd>;
>   	};
>   };
>   
