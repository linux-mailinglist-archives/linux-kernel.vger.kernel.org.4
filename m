Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2369442E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjBMLPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjBMLPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:15:06 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB7B7ECF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:14:42 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id n10so3999550ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vBjWV5wHQLJ1DKeeU1tz43vb34LnV0+Y/BNXoGO7xqk=;
        b=RM1SYQh8+CbCaTXZh7eiO7IHW8+5NMVH8sqqgsHkXT3lHOtQxlIAZrDOV7/Io1KtC9
         vzUzg4ef7Ue2cpItxn0v9A7TBAlHJYhaqMHPfLNCLHX+/2knUicInMwvTeoKpKjZ40s/
         OZiiJu5SgKp9bmL0uomwY00K1fF4tTp/zn1OiG8EiJ4KsAjXsYl9SxdmcDQe/6QZxE8D
         7xUOH6z/qWssYxhNs4x8oXkBUifynKUPVDIfGFqqzVgkEThHGZu3IZx3VnHzRYW6+3cW
         JwFsMKg6UkFFYlE6t6goHFOuwMECuVv8nEVK88IMQXNv/hA9lvqONEpfGQwUN0laYBNw
         VmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vBjWV5wHQLJ1DKeeU1tz43vb34LnV0+Y/BNXoGO7xqk=;
        b=s5h3Sa0U565S0CPin7SgKLODQGPRMTvu8q3eE6wtlHS+rG0bWaVoszOa5no8CJg0j+
         7Y2iC7+B8BAFcm9bZYNiWIpvAq0gLX6YY+YBQA2S+j/85O+XVNhwveLjRbJGVq/4PrVU
         dU6xcSGcJf3aZrz+xTJRU56WJ97y/4M32HK/aAsLLSxoqLxOv4V9r3yYGkoqz17aXu+Y
         kj08kbuxDnb5iuImo/W6O+NkqgYiNT4f4hiqOXeHKP1V1QO/xNUqEYXdjMx0qFBNxJDG
         7iBYMUBTPuCpQfED+EesEyPzENIofVZsUgFArFbcGO4HxvFgEg42/grjBFZ8p3wcVNzr
         nwvQ==
X-Gm-Message-State: AO0yUKV7KHaa21D5GmvgduboxA7bgdRLakTcUheALqX7NNQprrmTQp3c
        j+PkzgyY+AI9cpRQ4W13lCNQmQ==
X-Google-Smtp-Source: AK7set9A/Rw+vzErcpLmc15Wy1Ka66Tds4aaz4wxAHq1zASTbO+mTQYGFyf2OHZjtxLlo0azLv/pkQ==
X-Received: by 2002:a17:906:5202:b0:878:7530:5303 with SMTP id g2-20020a170906520200b0087875305303mr27822175ejm.5.1676286879604;
        Mon, 13 Feb 2023 03:14:39 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id q7-20020a170906770700b008af42f87da2sm6207416ejm.79.2023.02.13.03.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:14:39 -0800 (PST)
Message-ID: <69bbabd1-2248-000d-f0ac-ba9bb4b14665@linaro.org>
Date:   Mon, 13 Feb 2023 12:14:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550-qrd: add QRD8550
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
 <20230210163844.765074-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230210163844.765074-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 17:38, Krzysztof Kozlowski wrote:
> Add a minimal DTS for the new QRD8550 board - a mobile-like development
> board with SM8550.  Serial, UFS and USB should be working.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
[...]
> +
> +		vreg_l17b_2p5: ldo17 {
> +			regulator-name = "vreg_l17b_2p5";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};

[...]

> +		};
> +
> +		vreg_l1g_1p2: ldo1 {
> +			regulator-name = "vreg_l1g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3g_1p2: ldo3 {
> +			regulator-name = "vreg_l3g_1p2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};

[...]

> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
> +	vcc-supply = <&vreg_l17b_2p5>;
> +	vcc-max-microamp = <1300000>;
> +	vccq-supply = <&vreg_l1g_1p2>;
> +	vccq-max-microamp = <1200000>;
> +	vccq2-supply = <&vreg_l3g_1p2>;
None of these regulators have allowed-modes + allow-set-load,
I think you may want that.

With or without that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> +	vccq2-max-microamp = <100>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l1d_0p88>;
> +	vdda-pll-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	vdd-supply = <&vreg_l1e_0p88>;
> +	vdda12-supply = <&vreg_l3e_1p2>;
> +
> +	status = "okay";
> +};
> +
> +&usb_dp_qmpphy {
> +	vdda-phy-supply = <&vreg_l3e_1p2>;
> +	vdda-pll-supply = <&vreg_l3f_0p88>;
> +
> +	status = "okay";
> +};
> +
> +&xo_board {
> +	clock-frequency = <76800000>;
> +};
