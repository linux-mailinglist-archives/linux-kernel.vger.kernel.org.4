Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527C46B0519
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCHKzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCHKy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:54:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0DFB9BCF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:54:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id d36so17621009lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssSpXejupljBu7s+chVTmZj6gncLEO2kMpW23Kzh/hU=;
        b=oZ4aOoCs1oNBOVpBFiyPeBPXNfJtef+ibd21LX2yMhzaNPq6MSSCSpdN8eHbjQXAi8
         vLJRLZFZASKTbT+GJhUELwOHi+IJ4wBZ+uO9tPNqrhybcCWBneiLR//wA9ewGIcL/F39
         tY2WNzktnIcIDBby7kunpyoLNKE4pOh9C92w+4ttAvBepHnvfLJ91+wuniRkxlrEEY7X
         Izz2P3/dZEyL1Q1yE91xgiAV3QMZsoV3BT29uheKR/GyAE/ulCiUY7giKYgvrozO3DVO
         /w44mMtJiHYMyMXjhQBTIcUuY4rzVzP2BxTYNnhb1fopGIk6EMukp85bq341DzfUYcpx
         jMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssSpXejupljBu7s+chVTmZj6gncLEO2kMpW23Kzh/hU=;
        b=3Te/RA0n3Y59EbwzmiokaIjZ5S9A+HTlgjz964K829xY2gVatOaccuopVZ1TM1mKqS
         uUhqmlBdzCvRkaGPznlPWrX+LCL8+zCJWj9AsaMP2IY+x9XO6ncGCnNVY223yaVMjSBk
         xWgGP410o2ZlwkxgAuVcPHGoXUnxOZN/su9J5rrMHsUTU8r+ih35W3lha4Lk11NUbqQ+
         mqm6XXh4G6pEExux3VW/zOtdXS2Qc2h77ejmNjoItnEA8hLT6lMEkglyfvnHOEaHDCqj
         r81UyFLYHI1uVh0llplsW2DT9YfdgpHoKBapvh69v/Z110FG7aYtwyU5w1MnnRZi/YFU
         fXTg==
X-Gm-Message-State: AO0yUKWu0jpqSU9xdJq752v8NXEdVPSl2GeCdT/ViLaBwvTijvmciZDx
        AX4Uh1vtqdUI3FCCBd74RccgQA==
X-Google-Smtp-Source: AK7set/aECR0OOCdS+p35O/ccWJ++I68onOenGnO667xnuzCDZKrngIjumoLrkPhA1weiBstxFz0/A==
X-Received: by 2002:ac2:46f6:0:b0:4db:2ac7:d372 with SMTP id q22-20020ac246f6000000b004db2ac7d372mr5327084lfo.55.1678272891971;
        Wed, 08 Mar 2023 02:54:51 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id h26-20020a19701a000000b004b7033da2d7sm2291984lfc.128.2023.03.08.02.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:54:51 -0800 (PST)
Message-ID: <a0b7566f-c6e4-bcae-24e2-be5eb7efc58a@linaro.org>
Date:   Wed, 8 Mar 2023 11:54:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 8/9] arm64: dts: qcom: sa8775p-ride: enable the GNSS
 UART port
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230308104009.260451-1-brgl@bgdev.pl>
 <20230308104009.260451-9-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308104009.260451-9-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 11:40, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the high-speed UART port connected to the GNSS controller on the
> sa8775p-adp development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 33 +++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index d01ca3a9ee37..cba7c8116141 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -13,6 +13,7 @@ / {
>  
>  	aliases {
>  		serial0 = &uart10;
> +		serial1 = &uart12;
>  		i2c18 = &i2c18;
>  		spi16 = &spi16;
>  	};
> @@ -66,6 +67,32 @@ qup_i2c18_default: qup-i2c18-state {
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
> +
> +	qup_uart12_default: qup-uart12-state {
> +		qup_uart12_cts: qup-uart12-cts-pins {
> +			pins = "gpio52";
> +			function = "qup1_se5";
> +			bias-disable;
> +		};
> +
> +		qup_uart12_rts: qup-uart12-rts-pins {
> +			pins = "gpio53";
> +			function = "qup1_se5";
> +			bias-pull-down;
> +		};
> +
> +		qup_uart12_tx: qup-uart12-tx-pins {
> +			pins = "gpio54";
> +			function = "qup1_se5";
> +			bias-pull-up;
> +		};
> +
> +		qup_uart12_rx: qup-uart12-rx-pins {
> +			pins = "gpio55";
> +			function = "qup1_se5";
> +			bias-pull-down;
> +		};
> +	};
>  };
>  
>  &uart10 {
> @@ -75,6 +102,12 @@ &uart10 {
>  	status = "okay";
>  };
>  
> +&uart12 {
> +	pinctrl-0 = <&qup_uart12_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
