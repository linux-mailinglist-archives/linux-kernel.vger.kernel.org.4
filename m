Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F186E6B0513
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjCHKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjCHKyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:54:35 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6F5C12F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:54:34 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id b10so16198110ljr.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678272872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulcfRdGDkA4PGVI7F005n8t79TKT1sH+rDzuXNyANCo=;
        b=nRelbRcs5mO/hTKIV8xJOHal8a2SA90PuH1Sf1chNT6ZowyNVcxyjiS5s2NJ5PgIFk
         mhvISzDLAESQshbdYNX9aHyZeGCqxd3qSOXvVAIZJB77ZUVGZ9VlXei5+5d9aoCJc+q1
         TMd+2gFOre5nLCEvDnYjONi3pKRwFFBPs/+eR1lIUT5a8ngn8QK+cCuQowzZvGfpr8+4
         kLtL2Jbwk95OOCtV3MCbVcUF/QJniEoQOJHKQlBoJTmYrPNAV7YmDLTCZBCs1zhU5zbQ
         C26+AmcHa0G5Zj9vGSZTkgHOcFmh2smlUFIJ5Pz/59Yo2xOBKsJbLRzhSNMnpOIVzlAc
         bdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulcfRdGDkA4PGVI7F005n8t79TKT1sH+rDzuXNyANCo=;
        b=UmuRTJfnPNfYhAqblgvspFgkahceRrk4eN4JPAf2kOsug85bs02ZeBxf4ErYJararR
         I4Cii17TOTZamECgai9NbjwRDJ8tMqpLYY7GoIOogGqSS8K7gFltv42NP/211zrjSatt
         DZvUGKYZEXMKoFOczHfi7XUqhQPRvmI/Z+vqDb28ByBvN5Dtn3lIY98wSchU+EM5Gj3a
         oHjvKMp1YVYfodjKZBNB2/Gjyrzv1yHnX/TLXOJ8quw5iBdl2vjqo8wm9rbMdUbCz39k
         zoz/D/S+VacyYKG7OVJUEeAAE00zBvY7SxKLuWuIVwIE4W6r2G9qYyhs/L4xb2UNY56d
         D8hQ==
X-Gm-Message-State: AO0yUKVoiVMR8zwKMRa3lmniWfLJgWLkJ2aBpOwMyc0UDV8w/8zWhdcq
        imhcr+ajMZzntmAzX+vl4MpX2g==
X-Google-Smtp-Source: AK7set8bgc0Yyag2pbnen7tmh8jLQFIHxCVFAN0d7VzkEYQ1OK8lb5vA7VG4llkSuRtCrCpFcTSOnA==
X-Received: by 2002:a2e:be03:0:b0:298:68d0:e105 with SMTP id z3-20020a2ebe03000000b0029868d0e105mr994420ljq.46.1678272872380;
        Wed, 08 Mar 2023 02:54:32 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x14-20020a19f60e000000b004d5a720e689sm2294848lfe.126.2023.03.08.02.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:54:32 -0800 (PST)
Message-ID: <2a4cc12e-6175-4892-cb78-27234eee3948@linaro.org>
Date:   Wed, 8 Mar 2023 11:54:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 9/9] arm64: dts: qcom: sa8775p-ride: enable the BT UART
 port
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
 <20230308104009.260451-10-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308104009.260451-10-brgl@bgdev.pl>
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
> Enable the high-speed UART port connected to the Bluetooth controller on
> the sa8775p-adp development board.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 33 +++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index cba7c8116141..1020dfd21da2 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -14,6 +14,7 @@ / {
>  	aliases {
>  		serial0 = &uart10;
>  		serial1 = &uart12;
> +		serial2 = &uart17;
>  		i2c18 = &i2c18;
>  		spi16 = &spi16;
>  	};
> @@ -93,6 +94,32 @@ qup_uart12_rx: qup-uart12-rx-pins {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	qup_uart17_default: qup-uart17-state {
> +		qup_uart17_cts: qup-uart17-cts-pins {
> +			pins = "gpio91";
> +			function = "qup2_se3";
> +			bias-disable;
> +		};
> +
> +		qup_uart17_rts: qup0-uart17-rts-pins {
> +			pins = "gpio92";
> +			function = "qup2_se3";
> +			bias-pull-down;
> +		};
> +
> +		qup_uart17_tx: qup0-uart17-tx-pins {
> +			pins = "gpio93";
> +			function = "qup2_se3";
> +			bias-pull-up;
> +		};
> +
> +		qup_uart17_rx: qup0-uart17-rx-pins {
> +			pins = "gpio94";
> +			function = "qup2_se3";
> +			bias-pull-down;
> +		};
> +	};
>  };
>  
>  &uart10 {
> @@ -108,6 +135,12 @@ &uart12 {
>  	status = "okay";
>  };
>  
> +&uart17 {
> +	pinctrl-0 = <&qup_uart17_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
>  &xo_board_clk {
>  	clock-frequency = <38400000>;
>  };
