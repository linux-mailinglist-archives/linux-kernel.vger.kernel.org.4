Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF6D6D0B52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjC3QcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjC3QcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:32:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3F7D327
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:32:09 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i9so19718556wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680193927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5iqRDNOsfYjFAg7++f2WTswDCTx1cvQAgPwdrnyaM0=;
        b=pptlaseNEQzrBWz16Lz87z6I6YeTtAadmZrZvMD2RsPgoAU4pcITcbjV7LXcQmKKH7
         2a+sajzdUSMDJFBtDY3hkTb4nOUvTSINYca55xI5ECRv9AbLHEP6HIMQlo2vvPKXpfp5
         e589BpuiC1gHnyLQohuywxLiGzscwRAZGv4WpQItE2K6GQh7GBK4VC9Pwv+E0ls4Z1gA
         ESD0IX9+Pjrd23yjPeWAWgyNhcv5Q2z7JauQmQbnnlxbvgnYeu+e1WS/yTN7CvfW1ieq
         q+GgA2YFavr+WZ64VDwd23/40PjY4RcrgF+0KPB0SgJj3FC1ZIQzpjTQA9eoBt1qrSBH
         FFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680193927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5iqRDNOsfYjFAg7++f2WTswDCTx1cvQAgPwdrnyaM0=;
        b=NmFuR4xi8Oi4LWsWBgFNwQJsUE1TEsDzrSdc+fGUafFIVUgC7tzPFCs3vcgpvqdGRi
         g+W4zpttUJzM5FEOvk7rRXV0cWqZS4BtxdHhOitwyASnUxhVPwFvMibX5YBzF9oLFuma
         oTdJrw4kSS/SJVaQVSQ19THhODJ4qIeJ/v+OFQiGF5bsyLVO7Au9b1faIDeeOInBSt8O
         mbX27bbEAvBN00ZC1OGXBU8geN3jG8t9J6hOVAcbB9uBwMVtPqKtruI0BrpLvl/+OLIv
         9NVS0096IFpaRNG643qgYNU+2zDAeyODFb9fM/q+KZ3MJdrb1WXaueet30PbuGx+gRRd
         Wp2w==
X-Gm-Message-State: AAQBX9dXmkfDTRBL4axL4xkhhSAqEinkCKEYnil+rh2fgPdOV75fk0ew
        Cyd07wldF0CFq2qukRPm7cdQ+w==
X-Google-Smtp-Source: AKy350Z17UR+1JsQDt8ClL02GrGiOOfkHe+agCOzAElOLfdYL360rlfU3YMntQH5eQJlI5N/ETaI+w==
X-Received: by 2002:adf:f74d:0:b0:2c7:1e00:d514 with SMTP id z13-20020adff74d000000b002c71e00d514mr16994490wrp.38.1680193927453;
        Thu, 30 Mar 2023 09:32:07 -0700 (PDT)
Received: from [172.20.10.2] ([37.166.66.243])
        by smtp.gmail.com with ESMTPSA id r10-20020adfce8a000000b002cefcac0c62sm33595242wrn.9.2023.03.30.09.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:32:07 -0700 (PDT)
Message-ID: <be2c7c24-de19-d14a-639c-657a1ed32573@linaro.org>
Date:   Thu, 30 Mar 2023 18:32:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350-nagara: Unify status
 property placement
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
 <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
Content-Language: en-GB
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/03/2023 à 23:12, Konrad Dybcio a écrit :
> As we're heading towards getting the status property last everywhere,
> take care of it for SM8350 SONY Sagami.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> index b2baa81baf5e..95b1ba4ce470 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
> @@ -189,8 +189,8 @@ vph_pwr: vph-pwr-regulator {
>   };
>   
>   &adsp {
> -	status = "okay";
>   	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
> +	status = "okay";
>   };
>   
>   &apps_rsc {
> @@ -542,27 +542,27 @@ pmr735a_l7: ldo7 {
>   };
>   
>   &cdsp {
> -	status = "okay";
>   	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
> +	status = "okay";
>   };
>   
>   &i2c1 {
> -	status = "okay";
>   	clock-frequency = <1000000>;
> +	status = "okay";
>   
>   	/* Some subset of SONY IMX663 camera sensor @ 38 */
>   };
>   
>   &i2c4 {
> -	status = "okay";
>   	clock-frequency = <400000>;
> +	status = "okay";
>   
>   	/* Samsung Touchscreen (needs I2C GPI DMA) @ 48 */
>   };
>   
>   &i2c11 {
> -	status = "okay";
>   	clock-frequency = <1000000>;
> +	status = "okay";
>   
>   	cs35l41_l: speaker-amp@40 {
>   		compatible = "cirrus,cs35l41";
> @@ -596,31 +596,31 @@ cs35l41_r: speaker-amp@41 {
>   };
>   
>   &i2c12 {
> -	status = "okay";
>   	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>   	clock-frequency = <100000>;
> +	status = "okay";
>   
>   	/* AMS TCS3490 RGB+IR color sensor @ 72 */
>   };
>   
>   &i2c13 {
> -	status = "okay";
>   	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>   	clock-frequency = <100000>;
> +	status = "okay";
>   
>   	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
>   };
>   
>   &i2c15 {
> -	status = "okay";
>   	clock-frequency = <400000>;
> +	status = "okay";
>   
>   	/* NXP SN1X0 NFC @ 28 */
>   };
>   
>   &i2c17 {
> -	status = "okay";
>   	clock-frequency = <1000000>;
> +	status = "okay";
>   
>   	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
>   };
> @@ -652,8 +652,8 @@ mdss_dp_altmode: endpoint {
>   };
>   
>   &mpss {
> -	status = "okay";
>   	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
> +	status = "okay";
>   };
>   
>   &pm8350_gpios {
> @@ -719,8 +719,8 @@ &pon_pwrkey {
>   };
>   
>   &pon_resin {
> -	status = "okay";
>   	linux,code = <KEY_VOLUMEUP>;
> +	status = "okay";
>   };
>   
>   &qupv3_id_0 {
> @@ -748,8 +748,8 @@ &sdhc_2 {
>   };
>   
>   &slpi {
> -	status = "okay";
>   	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
> +	status = "okay";
>   };
>   
>   &spi14 {
> @@ -1038,16 +1038,14 @@ usb_1_dwc3_ss: endpoint {
>   };
>   
>   &usb_1_hsphy {
> -	status = "okay";
> -
>   	vdda-pll-supply = <&pm8350_l5>;
>   	vdda18-supply = <&pm8350c_l1>;
>   	vdda33-supply = <&pm8350_l2>;
> +	status = "okay";
>   };
>   
>   &usb_1_qmpphy {
> -	status = "okay";
> -
>   	vdda-phy-supply = <&pm8350_l6>;
>   	vdda-pll-supply = <&pm8350_l1>;
> +	status = "okay";
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
