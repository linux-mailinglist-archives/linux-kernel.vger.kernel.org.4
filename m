Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68464DBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLOM5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiLOM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:57:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE841F019
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:57:19 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id n1so9831604ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XcQ2de193g9xXdCqrKcwvWzRCXrL5xNmRpxT+5GlZvM=;
        b=AylID3F/XfIZmSDwVfzELEs+vouj12dfB1Dp5+DTVCrGbY0ToI/rRTtML0QazOk6gG
         Mg1vlcfqdwBXMn9UQ3lZakcaxUa2a5yVI66V5YHfBiVJAZnFiBFQZc3/iPUrEn0/0rOL
         cMudKbg+JhdTjSy5ZKu54f3wIlFqztsjwAyOO0Krnd5aB1EZIKFSzUOGoyfxu81zu80x
         Rx7C6S5+BALTvJ31OR7qFXKd9Qu3ETBL/anPM1x21Zc5ewJ9xKyIps/Bo594vvwj8Glu
         Pdw0YwXWYSgdPoB6SXbMK1GtDGLB7LJXMj+ehi5LDBa9zXJvM6z2QKLd6cNv5vEShUuz
         3ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XcQ2de193g9xXdCqrKcwvWzRCXrL5xNmRpxT+5GlZvM=;
        b=JycanDIyTAPWTeef9TSni18ATBNryzxJQhST4kLW7/+gEV06m4HkqtSdatHAoKugPD
         4iGeCA/smWfq0nQWLoXSTquAjlWPaDmvHJ0qvUnV9L1fsBrr6hohSRNsg9g2340nL8ID
         u7TlLRwmHrLgQIGwgW5CsrWs3jeP/Dq8gza9fqKarzcon7Ix2FTwhAXUYO8ZCXGAJYSA
         Laqf5OnuFJidAWmV4kWY/5/Yx9tQs+Jw4TVmCgFXgPkgW/36q2dI0lty6RR1b5bs0Ity
         6yNHeh3xomWeBPDKbGCR2wpl4VpJ3EA2uEnU9QltbiHNJW4TTJPXXLcwv+UWbsWpstsQ
         odUQ==
X-Gm-Message-State: ANoB5pmggwPcsHiBY87nuuN6dhZOpJXt5mTzTFhRzY+wKYDZAyyer0gg
        OUGvfUXmzXSDLI4h6hSx/se/2A==
X-Google-Smtp-Source: AA0mqf55aO0/zf3k5ZxxSWTq1mL6XFDkNCbhkzvmh0muLGpY7xFoVix/0UFechV4Yu0+agA8K5rSiA==
X-Received: by 2002:a2e:a7c3:0:b0:27a:69f:62d3 with SMTP id x3-20020a2ea7c3000000b0027a069f62d3mr9124289ljp.51.1671109038107;
        Thu, 15 Dec 2022 04:57:18 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id y15-20020a2e95cf000000b0027741daec09sm805422ljh.107.2022.12.15.04.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:57:16 -0800 (PST)
Message-ID: <fe670133-f9e0-c653-8b13-8abc847b1fc6@linaro.org>
Date:   Thu, 15 Dec 2022 13:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: sa8540p-ride: add i2c nodes
Content-Language: en-US
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     quic_shazhuss@quicinc.com, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221214171145.2913557-1-bmasney@redhat.com>
 <20221214171145.2913557-7-bmasney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221214171145.2913557-7-bmasney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.2022 18:11, Brian Masney wrote:
> Add the necessary nodes in order to get i2c0, i2c1, i2c12, i2c15, and
> i2c18 functioning on the automotive board and exposed to userspace.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel. This change was validated by using
> i2c-tools 4.3.3 on CentOS Stream 9:
> 
> [root@localhost ~]# i2cdetect -l
> i2c-0  i2c             Geni-I2C                                I2C adapter
> i2c-1  i2c             Geni-I2C                                I2C adapter
> i2c-12 i2c             Geni-I2C                                I2C adapter
> i2c-15 i2c             Geni-I2C                                I2C adapter
> i2c-18 i2c             Geni-I2C                                I2C adapter
> 
> [root@localhost ~]# i2cdetect -a -y 15
> Warning: Can't use SMBus Quick Write command, will skip some addresses
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:
> 10:
> 20:
> 30: -- -- -- -- -- -- -- --
> 40:
> 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 60:
> 70:
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> Changes since v1:
> - Dropped qupX_ prefix from labels. (Johan)
> - Reordered nodes based on new name.
> - Added i2c buses 0, 1, and 12 (Shazad)
> - Drop mux/config-pins and have the pin properties live directly
>   under the i2cX-default-state node. (Konrad)
> - Use decimal notation for drive strength (Johan)
> 
> A few things to note with this series applied on top of linux-next:
> - Reading from i2c-0 using 'i2cdetect -y -a 0' gives the following error
>   when reading from the ranges 0x30-0x37 and 0x50-0x5F.
>       geni_i2c 980000.i2c: Timeout abort_m_cmd
> - i2c-1 and i2c-2 successfully read using i2cdetect, however it takes
>   several seconds.
> - i2cdetect runs fast within a small fraction of a second for i2c-15
>   and i2c18.
> - 'i2cdetect -y -a $BUSNUM' shows the same address ranges 0x30-0x37
>   and 0x50-0x5F in use on all 5 buses.
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 83 +++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index b6e0db5508c7..ccd2ea3c9d04 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -17,6 +17,11 @@ / {
>  	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
>  
>  	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c12 = &i2c12;
> +		i2c15 = &i2c15;
> +		i2c18 = &i2c18;
>  		serial0 = &uart17;
>  	};
>  
> @@ -146,6 +151,41 @@ vreg_l8g: ldo8 {
>  	};
>  };
>  
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c12 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c12_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c15 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c15_default>;
> +
> +	status = "okay";
> +};
> +
> +&i2c18 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c18_default>;
> +
> +	status = "okay";
> +};
> +
>  &pcie2a {
>  	ranges = <0x01000000 0x0 0x3c200000 0x0 0x3c200000 0x0 0x100000>,
>  		 <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>,
> @@ -188,6 +228,14 @@ &pcie3a_phy {
>  	status = "okay";
>  };
>  
> +&qup0 {
> +	status = "okay";
> +};
> +
> +&qup1 {
> +	status = "okay";
> +};
> +
>  &qup2 {
>  	status = "okay";
>  };
> @@ -268,6 +316,41 @@ &xo_board_clk {
>  /* PINCTRL */
>  
>  &tlmm {
> +	i2c0_default: i2c0-default-state {
> +		pins = "gpio135", "gpio136";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c1_default: i2c1-default-state {
> +		pins = "gpio158", "gpio159";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c12_default: i2c12-default-state {
> +		pins = "gpio0", "gpio1";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c15_default: i2c15-default-state {
> +		pins = "gpio36", "gpio37";
> +		function = "qup15";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	i2c18_default: i2c18-default-state {
> +		pins = "gpio66", "gpio67";
> +		function = "qup18";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
>  	pcie2a_default: pcie2a-default-state {
>  		perst-pins {
>  			pins = "gpio143";
