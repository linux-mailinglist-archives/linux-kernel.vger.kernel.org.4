Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53D64C947
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbiLNMvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiLNMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:51:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C0334
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:51:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so10224174lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OVScZoGYXPRG6pr8K0FDRs95YCKdU6JOC0cKjJMDlpY=;
        b=H9/BhWDfDTgnDfIpQdcDw8Z7WHmTQimH3hZ2RcdHCffmFofT9vJl55kjNxUg8Av+U4
         oGN873S+/7Ey3euYNeutwigec44YkgWMr4b6BhSzkz2g0C1/jkzhXImCtzycf78XT/Ds
         6zdwr86Q0F7COSlbu0KP1jj1QQC/9yrlgVIe8i3oqzAKcWgNyKuTgtnWRnjxSXEL7MJ7
         YXh9vvlm79NRioMoKalqTQMGhEgnv/URI0yQ5tjEvYLCEp7JatH8Prm2UZU06nQxdQMl
         IYj8BhB8HHxrvaJSwH2q0f9Zo7dCmbuP15lMRvZ2G8uLYG74ZCO+yh5jZKEAJ+Q+wTi7
         2tHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVScZoGYXPRG6pr8K0FDRs95YCKdU6JOC0cKjJMDlpY=;
        b=ca47O2u1cJtX0zVHbbtQEOzjQ7gABV8bSCDBTBzE/AY4vx/dASL2AYOVeDNo2KR0pv
         Qcq7vV1vr35Tpk7hRoHebir0tOYTWh4CKFujFIhdwJ3/TU6tiOdAxlCcFKBHYQMxY3r6
         7lPMMmXWsdAv8i6WdPHX2mfTmfMQ/LUkdKYTNP3tNwdCJcPlEgL4OLvJnvxoMWygC3HP
         8FI9WhwXrvpFNVkWVWSBGyH47pjBswclA9Qf64E/hVAp1TTL7jthoFz/irD8hC4eqE7k
         urC4WdMIdtQ/VwgDkkTkOElCDWihtJl4/cEiOy8T2kpUA9cZRGPfk5IBHuXeNE9D6FDr
         BRIg==
X-Gm-Message-State: ANoB5pm4bWibW1yJ1cUS9OFcCEIFbYZQvTyg+K14VkkAQAyrGSMOgtEp
        yDsjk4B36CdcuTA6HOHimjQ3Qw==
X-Google-Smtp-Source: AA0mqf5M3wtgE78WiTNZSFw2dDZQwdxnhEmls6SUeeoYhbTWz91zBfC8Wh/xGMOzMoO8XImJ1EwC6w==
X-Received: by 2002:a19:e34e:0:b0:4b5:178f:a14c with SMTP id c14-20020a19e34e000000b004b5178fa14cmr6799888lfk.16.1671022292405;
        Wed, 14 Dec 2022 04:51:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s27-20020a056512203b00b004afac783b5esm790585lfs.238.2022.12.14.04.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 04:51:31 -0800 (PST)
Message-ID: <c7979199-3932-00dc-d349-c0aeb96f5c24@linaro.org>
Date:   Wed, 14 Dec 2022 13:51:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
To:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221212182314.1902632-4-bmasney@redhat.com>
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

On 12/12/2022 19:23, Brian Masney wrote:
> Add the necessary nodes in order to get qup1_i2c15 and qup2_i2c18
> functioning on the automotive board and exposed to userspace.
> 
> This work was derived from various patches that Qualcomm delivered
> to Red Hat in a downstream kernel. This change was validated by using
> i2c-tools 4.3.3 on CentOS Stream 9:
> 
> [root@localhost ~]# i2cdetect -l
> i2c-15  i2c             Geni-I2C                                I2C adapter
> i2c-18  i2c             Geni-I2C                                I2C adapter
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
> Bus 18 has the same output. I validated that we get the same output on
> the downstream kernel.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 46 +++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index d70859803fbd..6dc3f3ff8ece 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -17,6 +17,8 @@ / {
>  	compatible = "qcom,sa8540p-ride", "qcom,sa8540p";
>  
>  	aliases {
> +		i2c15 = &qup1_i2c15;
> +		i2c18 = &qup2_i2c18;
>  		serial0 = &qup2_uart17;
>  	};
>  
> @@ -188,10 +190,28 @@ &pcie3a_phy {
>  	status = "okay";
>  };
>  
> +&qup1 {
> +	status = "okay";
> +};
> +
> +&qup1_i2c15 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup1_i2c15_default>;
> +
> +	status = "okay";
> +};
> +
>  &qup2 {
>  	status = "okay";
>  };
>  
> +&qup2_i2c18 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup2_i2c18_default>;
> +
> +	status = "okay";
> +};
> +
>  &qup2_uart17 {
>  	compatible = "qcom,geni-debug-uart";
>  	status = "okay";
> @@ -313,4 +333,30 @@ wake-pins {
>  			bias-pull-up;
>  		};
>  	};
> +
> +	qup1_i2c15_default: qup1-i2c15-state {
> +		mux-pins {
> +			pins = "gpio36", "gpio37";
> +			function = "qup15";
> +		};
> +
> +		config-pins {
> +			pins = "gpio36", "gpio37";
> +			drive-strength = <0x02>;

Except the problem pointed out by Konrad (we do not have separate mux
and config pins anymore), this is not a hex, it's mA.




Best regards,
Krzysztof

