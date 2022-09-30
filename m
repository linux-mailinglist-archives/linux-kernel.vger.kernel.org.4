Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7505F1360
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiI3UNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiI3UN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:13:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A821E174BCA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:12:38 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id d42so8535413lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=EJOhSGJjrpljtTJD+cdo2MF5s7DAUoPclM+mAVRcwSI=;
        b=Gwt8rSCqkXjawq19zMw41Aqoa9NPrDa1nqrkM0e4kZ11V+minBcB6nx/1jmQJsOd1d
         gEVLaeQZW93rQSWRz0qi/YpREceuecFqI3p963iTRtAWEkKVZQnF4coeRwwHo6xJYd44
         nzpBcPNeLigiTKQUuYe7kMJt9fWAAq83IflZvlSUJ41oqO0WIjHlDNtzyncgUEkbzuMG
         XsqMhhkOvsO4sE3+NF2wkZ/XVL8BQH+Ny0/sSH/9OaCPy1L+jjQQjnYQucPvBtnU0JYh
         3mIscCcJTkluhjHkDWe12Ukkdvsq5/WBbDWI7rJr6HK/ehE80kXv2wa5OxBCrAjkslPu
         +1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EJOhSGJjrpljtTJD+cdo2MF5s7DAUoPclM+mAVRcwSI=;
        b=RryIuRe5fgluWkPhw7aAbcwd2epNUbmcbrKvYgm7gagWfSAM9IlaV/8fsDVBEVQ0LS
         zU88dTxoDxO5QE88XEziraffOQJssUaeYr1R0NaAZtQdGxYKI4a+MZheJVUOzwZvkbUP
         R3hO7IuKnZwK+4ICjSq5k4kyHEtjaIaV8Sj/4eAVfZ5cPyn1ukeUhp4SaVQX9N3D5kpd
         xsZXrfCVl2FcFg7Q+dm9U/m2gNdfpxZkwB+AWfepg8rPU9Ugq+gi/HF57Gr/Y2kGVZkp
         qldAMYQE0bQNEW4UEVmn2pf1LhW7F5uzdSvQIjxdwlzLXNbx8RItL5QTneQ/b0S5P/gA
         yW7w==
X-Gm-Message-State: ACrzQf2eAoZKmg6rhE+olyqNIh/1VQF5A0gQy2s9xnRlhafza9hi4aKr
        7u8+4ezF4HIvZKT2w4kLsRgBCQ==
X-Google-Smtp-Source: AMsMyM6r5A8yac3lrfx7ycHOLfSTT2DbJUyqRxZTFqlAwnnT6h9oPxlwoOJl1DYK+BEvINi0y9+UMw==
X-Received: by 2002:a19:ee0a:0:b0:497:a2e3:a9dc with SMTP id g10-20020a19ee0a000000b00497a2e3a9dcmr3676553lfb.96.1664568741745;
        Fri, 30 Sep 2022 13:12:21 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e9996000000b0026dcd222617sm5971lji.66.2022.09.30.13.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 13:12:21 -0700 (PDT)
Message-ID: <865aa172-72b8-68c0-ee15-e0e638493e33@linaro.org>
Date:   Fri, 30 Sep 2022 22:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sdm845-tama: Add Synaptics
 Touchscreen
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220930191049.123256-1-konrad.dybcio@somainline.org>
 <20220930191049.123256-3-konrad.dybcio@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930191049.123256-3-konrad.dybcio@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 21:10, Konrad Dybcio wrote:
> Add required pins and RMI4 node to the common DT and remove it
> from Akatsuki, as it uses a different touch.
> 
> Since the panels are super high tech proprietary incell, they
> need to be handled with very precise timings. As such the panel
> driver sets up the power rails and GPIOs and the touchscreen
> driver *has to* probe afterwards.
> 

Thank you for your patch. There is something to discuss/improve.

> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  .../qcom/sdm845-sony-xperia-tama-akatsuki.dts |  3 +
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 69 ++++++++++++++++++-
>  2 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> index 2a16305ac5da..5c5949a51184 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dts
> @@ -7,6 +7,9 @@
>  
>  #include "sdm845-sony-xperia-tama.dtsi"
>  
> +/* XZ3 uses an Atmel touchscreen instead. */
> +/delete-node/ &touchscreen;
> +
>  / {
>  	model = "Sony Xperia XZ3";
>  	compatible = "sony,akatsuki-row", "qcom,sdm845";
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index ac8eb59ed010..809a6d7e739b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -375,10 +375,43 @@ &gcc {
>  };
>  
>  &i2c5 {
> -	status = "okay";
>  	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	touchscreen: touchscreen@2c {
> +		compatible = "syna,rmi4-i2c";
> +		reg = <0x2c>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
> +		vdd-supply = <&vreg_l14a_1p8>;
> +		/*
> +		 * This is a blatant abuse of OF, but the panel driver *needs*
> +		 * to probe first, as the power/gpio switching needs to be precisely
> +		 * timed in order for both the display and touch panel to function properly.
> +		 */
> +		incell-supply = <&panel>;
> +
> +		syna,reset-delay-ms = <220>;
> +		syna,startup-delay-ms = <1000>;
> +
> +		pinctrl-names = "default", "sleep";
> +		pinctrl-0 = <&ts_default>;
> +		pinctrl-1 = <&ts_sleep>;
>  
> -	/* Synaptics touchscreen @ 2c, 3c */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		rmi4-f01@1 {
> +			reg = <0x01>;
> +			syna,nosleep-mode = <1>;
> +		};
> +
> +		rmi4-f12@12 {
> +			reg = <0x12>;
> +			syna,sensor-type = <1>;
> +		};
> +	};
>  };
>  
>  &i2c10 {
> @@ -497,6 +530,38 @@ sde_te_active_sleep: sde-te-active-sleep-state {
>  		drive-strength = <2>;
>  		bias-pull-down;
>  	};
> +
> +	ts_default: ts-default-state {
> +		reset-pin {

"-pins" suffix, so "reset-pins" here and further.


Best regards,
Krzysztof

