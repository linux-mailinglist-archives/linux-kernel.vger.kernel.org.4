Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3297367E0D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjA0JzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjA0JzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:55:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2481A48F;
        Fri, 27 Jan 2023 01:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9295E61AB8;
        Fri, 27 Jan 2023 09:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AF0C4339B;
        Fri, 27 Jan 2023 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674813313;
        bh=5+bs5aiGTjY9WC1x5uledKU4mJCnDHuXC5DFVXe6lAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtRni5CDnfZswzaTTsnrQcnBvMwBcF6WAEshIJsnoyDw/tjbw9drJLNUSvrYkNFXi
         BS0xZjgibbv3Q2j2hhENXhn+MC1sY0biL2oMMjQfiwPSzBy3DhkmoCYH1ODGdqwubE
         fYIH411f+C7ZqWaz+MwQpsXewSfTMrDLWp+nSlF5uVPmOCw6Kkzyr2ySi+H5Wos8d0
         cNj0Gi3jYZFttwfeiPYLfnf7+fL3vXPLkd7DwScf8MePV28b2OOZI5KNLaWSbKUUqB
         xx/uX1UEcGhWpme6N37oeQfjCSNwMobv/NOYRmJXVI1doysddq5cie2g/SfFRvIyZ+
         byBxteYY7PyLw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLLS5-0005Tk-KY; Fri, 27 Jan 2023 10:55:21 +0100
Date:   Fri, 27 Jan 2023 10:55:21 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sa8295p-adp: Add max20411 on
 i2c12
Message-ID: <Y9OfiTDwFHN0RR5G@hovoldconsulting.com>
References: <20230124184440.1421074-1-quic_bjorande@quicinc.com>
 <20230124184440.1421074-4-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124184440.1421074-4-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:44:40AM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> The SA8295P ADP has a Maxim max20411 step-down converter on i2c12.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - i2c node had changed name
> 
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 41 ++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> index bb4270e8f551..642000d95812 100644
> --- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -266,6 +266,27 @@ &dispcc1 {
>  	status = "okay";
>  };
>  
> +&i2c12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c12_state>;
> +
> +	status = "okay";
> +
> +	vdd_gfx: regulator@39 {

Nit: Should the label be named 'vreg_gfx' (or 'vreg_vdd_gfx)') for
consistency with rest of the file?

> +		compatible = "maxim,max20411";
> +		reg = <0x39>;
> +
> +		regulator-name = "vdd_gfx";
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <968750>;
> +
> +		enable-gpios = <&pmm8540a_gpios 2 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_gfx_enable_state>;
> +	};
> +};
> +
>  &mdss0 {
>  	status = "okay";
>  };
> @@ -476,6 +497,10 @@ &pcie4_phy {
>  	status = "okay";
>  };
>  
> +&qup1 {
> +	status = "okay";
> +};
> +
>  &qup2 {
>  	status = "okay";
>  };
> @@ -636,7 +661,23 @@ &xo_board_clk {
>  
>  /* PINCTRL */
>  
> +&pmm8540a_gpios {
> +	vdd_gfx_enable_state: vdd-gfx-enable-state {

For consistency with the rest of sc8280xp, can you rename this

	vdd_gfx_en: vdd-gfx-en-state {

(i.e. drop the 'state' from the label and shorten 'enable')?

> +		pins = "gpio2";
> +		function = "normal";
> +		output-enable;
> +	};
> +};
> +
>  &tlmm {
> +	i2c12_state: i2c12-state {

Similar here, this should be

	i2c12_default: i2c12-default-state {

> +		pins = "gpio0", "gpio1";
> +		function = "qup12";
> +

And this newline can be removed.

> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
>  	pcie2a_default: pcie2a-default-state {
>  		clkreq-n-pins {
>  			pins = "gpio142";

Johan
