Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7796AC42A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjCFO6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCFO60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:58:26 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969825975
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:58:06 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id t11so13130167lfr.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678114685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9dmdVfpPfuomtp8btAfPBTLpBjzL+Ybdk6lUZ9ubik=;
        b=TbwiJu/99Wd0ZAHaGNn+wTMxwSZhgCQ28AJLpz32sP77sEr1tiDh1Yw8ySltSrmY0Q
         vcWpH4fiBh/0mOVbsUSS8KQr9a+GU2/5wLR6DqMz0oLp/2p6mZX8MAai2j2X0r/FjpVt
         bq2hA42ILrpmqz8fn4TXcJldGFNMXYWdsaBZBMDut7Kc1whj4BtXRg0+yQmgRjaGzFCt
         aP4/0imZLOws+mMmhhuJPiyh/lqAWAlZSiaPOyfHfenypxJqrQBPBUOhklh00R7xGMtI
         9bjY25sWFliziN4Scgs0mRBXV0xxb22hGJ6A7G5t88yHjKpyNjFvEo4/F4XEpGIs9ghy
         Rwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678114685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9dmdVfpPfuomtp8btAfPBTLpBjzL+Ybdk6lUZ9ubik=;
        b=jauySrXeRBx3fQmIJqA1oLOddJw+dL73pMAvywIH4JT9C12cHwfZ6WYPMETK89ZNae
         mRl42unTB6TFcOOQEQvJ3cMTDYL2XIaqWcTijbL+g9MI9rRPVNe7ktCKMPcERIPHIWF8
         3uYRTBgztzqXpeeF+jtjgOOAEdnMoSkX7EDn01rz9KlMEGmfpwTY8krUClj/efYLQCAo
         WCJo1t2ZjmCpgXa/gHYF75fwn3w4IlCCUm1b8sFLrbsFpwYKRiTpYdc9NT2UTnCsHvhr
         HEhAClMrhv2WFWtk7GsGx1cVHfpu1vX3Qwt+JydbYO0FKGcWyhW67Bo+L5rQov2Ar6J5
         lKhQ==
X-Gm-Message-State: AO0yUKXUb2GZ/0vRFUPH8AbAa3mCAUFvyc69pgvwOvqgOprKMqxTaxHT
        t7YNE7LK5OWCIfiYGP3zXN/SvA==
X-Google-Smtp-Source: AK7set//EZ7rm1hSgud7TVG1me0HuI+lFUoVL+7oCXnbgFw948g8rsJyj285b09OpGG0SBEa0owk1A==
X-Received: by 2002:ac2:55b0:0:b0:4e0:a426:6ddc with SMTP id y16-20020ac255b0000000b004e0a4266ddcmr2627833lfg.0.1678114685164;
        Mon, 06 Mar 2023 06:58:05 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id v19-20020ac25933000000b004b58500383bsm1656898lfi.272.2023.03.06.06.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 06:58:04 -0800 (PST)
Message-ID: <3fd0d115-9530-50e2-992a-6bad4ca29d57@linaro.org>
Date:   Mon, 6 Mar 2023 15:58:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/9] arm64: dts: qcom: sa8775p: add high-speed UART
 nodes
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230216125257.112300-1-brgl@bgdev.pl>
 <20230216125257.112300-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230216125257.112300-8-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.02.2023 13:52, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add two UART nodes that are known to be used by existing development
> boards with this SoC.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index eda5d107961b..ce5976e36aee 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -489,6 +489,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
>  				operating-points-v2 = <&qup_opp_table_100mhz>;
>  				status = "disabled";
>  			};
> +
> +			uart12: serial@a94000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0xa94000 0x0 0x4000>;
The address part ought to be padded to 8 hex digits

> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 0
Please use the bindings constants as pointed out in the previous replies.


> +						 &clk_virt SLAVE_QUP_CORE_1 0>,
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_1 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		qupv3_id_2: geniqup@8c0000 {
> @@ -524,6 +539,22 @@ &config_noc SLAVE_QUP_2 0>,
>  				status = "disabled";
>  			};
>  
> +			uart17: serial@88c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x88c000 0x0 0x4000>;
Ditto

> +				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 0
> +						 &clk_virt SLAVE_QUP_CORE_2 0>,
Ditto

Konrad
> +						<&gem_noc MASTER_APPSS_PROC 0
> +						 &config_noc SLAVE_QUP_2 0>;
> +				interconnect-names = "qup-core", "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
> +
>  			i2c18: i2c@890000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0x0 0x890000 0x0 0x4000>;
