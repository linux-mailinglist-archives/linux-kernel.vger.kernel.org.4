Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3443B65B20F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjABM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABM3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:29:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443F21BC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:29:42 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp15so41367800lfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UrmyD+yeEypXFGliWFBiobSabgzh0OfQJe501KhQ4mI=;
        b=B5e6QzsFoEjobWW8AR0ZUHzPGVwg5XYmx7gsJ+uhZqvwHlAyHoCuxJiR3piBH9tjc6
         z/pzMmVvpyzxKSU0ja/VAIGd5F80vKJFhkSzhQlANp7k8Fsz/NvhhssgHbi8xO/EPxBJ
         xNKJMkM0Etz+7uONqk5OeuVwpu3+k8XYU89hgViUKWvAfLbJsK72WSx+ZKIHXO2jVqkP
         5GfWy2R+U9RO0LhkzPLQ2hvuz2N8+gjNEPHd1SM4DV6wwx2uCzVcMvOG4C1qComX2AoN
         +hxPpayHM68FqahH9iCoru/99jnqvAC6yvN6Dq3gYTBOevpCjJE5x6hfHw4677KRF7qY
         1glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrmyD+yeEypXFGliWFBiobSabgzh0OfQJe501KhQ4mI=;
        b=FB3uPSG9+DeZ17OXdWZ+gVvsHb22w8Y0bhzkX7B+rsgG6OCKzOWiWvT57j3ZiV0Xa6
         u9/TsM6oZ4hr6vK/4bdl7kSmN7hyDSILvkNuxfIHAs9W7npguXOBnBZK1Fj9UVQwxOJ4
         FzQHjBqqQe3ZVcDORAuJYQP5uwiLMCoo10NS+TSev2FGjEaq3mqBYASOx3t4KDGTeiNK
         b5+OPOTPoHx6mgP/71wrFTBFWiD82ZZIrkq4+YV8y/uvT427Ugz2piBmJXxN/sVPsDjO
         xLH7RcLEQyJhnLGz5azi1dhsVMgaO2zaIlphC/SCiBttsJ4pa4Zj+we+3xiezEEwLJ9+
         5n3A==
X-Gm-Message-State: AFqh2krWNfA+lJoJdR1FYyXEWUE7kcT2wl7Lp/9pN5Q3d+77/n3hP49i
        hfEQi1hcl82e8AjxTg06RYfX3w==
X-Google-Smtp-Source: AMrXdXsx5mCGN8UMr3Ql3HUAIKU4KIpnHdu3wa79g+pHAORTCKkwcePmenuwD7asNpWn8+ARUxxW+A==
X-Received: by 2002:a05:6512:202c:b0:4a4:68b9:19f1 with SMTP id s12-20020a056512202c00b004a468b919f1mr10750929lfs.25.1672662580655;
        Mon, 02 Jan 2023 04:29:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i40-20020a0565123e2800b004b0b131453csm4483320lfv.49.2023.01.02.04.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 04:29:40 -0800 (PST)
Message-ID: <82ac16e1-6c8a-b050-d627-535b4562a422@linaro.org>
Date:   Mon, 2 Jan 2023 13:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sc8280xp: disable sound nodes
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-3-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102105038.8074-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 11:50, Johan Hovold wrote:
> The sound nodes in the SoC dtsi should be disabled by default.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index ed1e2bee86ee..c1ce2d7b3675 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1733,6 +1733,8 @@ rxmacro: rxmacro@3200000 {
>  
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&rx_swr_default>;
> +
> +			status = "disabled";

There is no reason this should be disabled by default. No external (per
board) configuration is needed and by default SoC components should be
enabled if they do not need anything from the board.

>  		};
>  
>  		/* RX */
> @@ -1760,6 +1762,8 @@ swr1: soundwire-controller@3210000 {
>  			#sound-dai-cells = <1>;
>  			#address-cells = <2>;
>  			#size-cells = <0>;
> +
> +			status = "disabled";

For soundwires disabling makes sense - these are busses so they need to
be explicitly enabled and populated with children.

>  		};
>  
>  		txmacro: txmacro@3220000 {
> @@ -1783,6 +1787,8 @@ txmacro: txmacro@3220000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			#sound-dai-cells = <1>;
> +
> +			status = "disabled";
>  		};
>  
>  		wsamacro: codec@3240000 {
> @@ -1804,6 +1810,8 @@ wsamacro: codec@3240000 {
>  
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&wsa_swr_default>;
> +
> +			status = "disabled";
>  		};
>  
>  		/* WSA */
> @@ -1830,6 +1838,8 @@ swr0: soundwire-controller@3250000 {
>  			#sound-dai-cells = <1>;
>  			#address-cells = <2>;
>  			#size-cells = <0>;
> +
> +			status = "disabled";
>  		};
>  
>  		/* TX */
> @@ -1858,6 +1868,8 @@ swr2: soundwire-controller@3330000 {
>  			qcom,ports-word-length =	/bits/ 8 <0xff 0x00 0xff 0xff>;
>  			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff>;
>  			qcom,ports-lane-control =	/bits/ 8 <0x00 0x01 0x00 0x00>;
> +
> +			status = "disabled";
>  		};
>  
>  		vamacro: codec@3370000 {
> @@ -1874,6 +1886,8 @@ vamacro: codec@3370000 {
>  			#clock-cells = <0>;
>  			clock-output-names = "fsgen";
>  			#sound-dai-cells = <1>;
> +
> +			status = "disabled";

vamacro needs supply from the board so this one also makes sense.

Best regards,
Krzysztof

