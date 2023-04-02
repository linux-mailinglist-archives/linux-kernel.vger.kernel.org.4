Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267C76D38C5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjDBPTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDBPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:19:27 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C3CD511
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:19:21 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C9BA41F4D9;
        Sun,  2 Apr 2023 17:19:17 +0200 (CEST)
Date:   Sun, 2 Apr 2023 17:19:15 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350-nagara: Unify status
 property placement
Message-ID: <i5tsdvn45peivo7tegmg3q4mhsz2ly2kfs64kezeykn2bbosd5@ugfqrjqumljd>
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
 <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21 23:12:31, Konrad Dybcio wrote:

When you get to resending this, change sm8350-nagara in the title to
sm8350-sagami :)

- Marijn

> As we're heading towards getting the status property last everywhere,
> take care of it for SM8350 SONY Sagami.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index b2baa81baf5e..95b1ba4ce470 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -189,8 +189,8 @@ vph_pwr: vph-pwr-regulator {
>  };
>  
>  &adsp {
> -	status = "okay";
>  	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
> +	status = "okay";
>  };
>  
>  &apps_rsc {
> @@ -542,27 +542,27 @@ pmr735a_l7: ldo7 {
>  };
>  
>  &cdsp {
> -	status = "okay";
>  	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
> +	status = "okay";
>  };
>  
>  &i2c1 {
> -	status = "okay";
>  	clock-frequency = <1000000>;
> +	status = "okay";
>  
>  	/* Some subset of SONY IMX663 camera sensor @ 38 */
>  };
>  
>  &i2c4 {
> -	status = "okay";
>  	clock-frequency = <400000>;
> +	status = "okay";
>  
>  	/* Samsung Touchscreen (needs I2C GPI DMA) @ 48 */
>  };
>  
>  &i2c11 {
> -	status = "okay";
>  	clock-frequency = <1000000>;
> +	status = "okay";
>  
>  	cs35l41_l: speaker-amp@40 {
>  		compatible = "cirrus,cs35l41";
> @@ -596,31 +596,31 @@ cs35l41_r: speaker-amp@41 {
>  };
>  
>  &i2c12 {
> -	status = "okay";
>  	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>  	clock-frequency = <100000>;
> +	status = "okay";
>  
>  	/* AMS TCS3490 RGB+IR color sensor @ 72 */
>  };
>  
>  &i2c13 {
> -	status = "okay";
>  	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>  	clock-frequency = <100000>;
> +	status = "okay";
>  
>  	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
>  };
>  
>  &i2c15 {
> -	status = "okay";
>  	clock-frequency = <400000>;
> +	status = "okay";
>  
>  	/* NXP SN1X0 NFC @ 28 */
>  };
>  
>  &i2c17 {
> -	status = "okay";
>  	clock-frequency = <1000000>;
> +	status = "okay";
>  
>  	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
>  };
> @@ -652,8 +652,8 @@ mdss_dp_altmode: endpoint {
>  };
>  
>  &mpss {
> -	status = "okay";
>  	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
> +	status = "okay";
>  };
>  
>  &pm8350_gpios {
> @@ -719,8 +719,8 @@ &pon_pwrkey {
>  };
>  
>  &pon_resin {
> -	status = "okay";
>  	linux,code = <KEY_VOLUMEUP>;
> +	status = "okay";
>  };
>  
>  &qupv3_id_0 {
> @@ -748,8 +748,8 @@ &sdhc_2 {
>  };
>  
>  &slpi {
> -	status = "okay";
>  	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
> +	status = "okay";
>  };
>  
>  &spi14 {
> @@ -1038,16 +1038,14 @@ usb_1_dwc3_ss: endpoint {
>  };
>  
>  &usb_1_hsphy {
> -	status = "okay";
> -
>  	vdda-pll-supply = <&pm8350_l5>;
>  	vdda18-supply = <&pm8350c_l1>;
>  	vdda33-supply = <&pm8350_l2>;
> +	status = "okay";
>  };
>  
>  &usb_1_qmpphy {
> -	status = "okay";
> -
>  	vdda-phy-supply = <&pm8350_l6>;
>  	vdda-pll-supply = <&pm8350_l1>;
> +	status = "okay";
>  };
> 
> -- 
> 2.40.0
> 
