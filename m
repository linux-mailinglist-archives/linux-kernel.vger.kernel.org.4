Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CC4631AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKUIDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUIDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:03:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E77713F85;
        Mon, 21 Nov 2022 00:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAA49B80D3B;
        Mon, 21 Nov 2022 08:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73340C433D7;
        Mon, 21 Nov 2022 08:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669017776;
        bh=rJDFKSgtFpseJQA/59FVR4oauwkHIQq4kXze0Mr9n8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J19qVXGOOMSWolIgOh3avBgI7O+jrt8dVrfwRFjO5UptlGQyyMNkUWVsgjsdPIxiH
         RWVQqfym8HR2gC9s0+1yLQ8Ycb/540j4RpK5ZFP41rNjepIx3Qa5AkbHXR9Pkj8RQW
         9KpUYya5W6zd6dlRTCafDSJH9TK4US6IjvRdRpVf9ZRJQG0UaKlZ1Y0u3PHtbGJikc
         H8ZSoGw5e0NHO43c0Boe14RjsFqpjnBuShgA/+3CD7s52aLXcqgrE5SVLMZ+TDsvs2
         wvL7ih842rC4EcqAnlrZ9R0iptUP30TotQBONiKr/hkI5uKk1pm0BsQq9DGYDl8flM
         uGBLUGI4W953Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox1l4-0006Kw-Fk; Mon, 21 Nov 2022 09:02:26 +0100
Date:   Mon, 21 Nov 2022 09:02:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Message-ID: <Y3swkpNTE2EaNqDq@hovoldconsulting.com>
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
 <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 04:44:25PM +0000, Srinivas Kandagatla wrote:
> Add support for SoundCard on X13s. This patch adds support for Headset
> Playback, record and 2 DMICs on the Panel along with the regulators
> required for powering up the LPASS codecs.

Subject prefix should include "x13s":

	arm64: dts: qcom: sc8280xp-x13s: ...

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index b2b744bb8a53..f1f93fc4fa2d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts

> @@ -346,6 +378,163 @@ edp_bl_pwm: edp-bl-pwm-state {
>  	};
>  };
>  
> +&soc {
> +	wcd938x: codec {
> +		compatible = "qcom,wcd9380-codec";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wcd_default>;
> +		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
> +		#sound-dai-cells = <1>;
> +
> +		vdd-buck-supply = <&vreg_s10b>;
> +		vdd-rxtx-supply = <&vreg_s10b>;
> +		vdd-io-supply = <&vreg_s10b>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +	};
> +};

Please move all the sound nodes above the "/* PINCTRL */" marker and try
to maintain the sort order (by node name).

> +
> +&sound {

...

> +};
> +
> +&swr0 {
> +	left_spkr: wsa8830-left@0,1 {
> +		compatible = "sdw10217020200";
> +		reg = <0 1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_1_sd_n_default>;
> +		powerdown-gpios = <&tlmm 178 GPIO_ACTIVE_LOW>;
> +		#thermal-sensor-cells = <0>;
> +		sound-name-prefix = "SpkrLeft";
> +		#sound-dai-cells = <0>;
> +		vdd-supply = <&vreg_s10b>;
> +	};
> +
> +	right_spkr: wsa8830-right@0,2{
> +		compatible = "sdw10217020200";
> +		reg = <0 2>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&spkr_2_sd_n_default>;
> +		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_LOW>;
> +		#thermal-sensor-cells = <0>;
> +		sound-name-prefix = "SpkrRight";
> +		#sound-dai-cells = <0>;
> +		vdd-supply = <&vreg_s10b>;
> +	};
> +};
> +
> +

Stray newline.

> +&swr1 {
> +	status = "okay";
> +
> +	wcd_rx: wcd9380-rx@0,4 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 4>;
> +		qcom,rx-port-mapping = <1 2 3 4 5 6>;
> +

Stray newline.

> +	};
> +};
> +
> +&swr2 {
> +	status = "okay";
> +
> +	wcd_tx: wcd9380-tx@0,3 {
> +		compatible = "sdw20217010d00";
> +		reg = <0 3>;
> +		qcom,tx-port-mapping = <1 1 2 3>;
> +	};
> +};
> +
> +&vamacro {
> +	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
> +	pinctrl-names = "default";
> +	vdd-micb-supply = <&vreg_s10b>;
> +	qcom,dmic-sample-rate = <600000>;
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>  
> @@ -369,6 +558,14 @@ reset {
>  		};
>  	};
>  
> +	wcd_default: wcd-default-state {
> +		reset-pins {
> +			pins = "gpio106";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +

Please try to keep the nodes sorted by name (i.e. move it last).

>  	qup0_i2c4_default: qup0-i2c4-default-state {
>  		pins = "gpio171", "gpio172";
>  		function = "qup4";
> @@ -383,6 +580,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>  		drive-strength = <16>;
>  	};
>  
> +	spkr_1_sd_n_default: spkr-1-sd-n-default-state {
> +		perst-n-pins {
> +			pins = "gpio178";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
> +	spkr_2_sd_n_default: spkr-2-sd-n-default-state {
> +		perst-n-pins {
> +			pins = "gpio179";
> +			function = "gpio";
> +			drive-strength = <16>;
> +			bias-disable;
> +			output-high;
> +		};
> +	};
> +
>  	tpad_default: tpad-default-state {
>  		int-n {
>  			pins = "gpio182";

Johan
