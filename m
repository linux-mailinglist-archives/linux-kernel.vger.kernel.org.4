Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99826B0524
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCHK5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjCHK5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:57:09 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F832A0B05
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:57:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g17so20806878lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jjrvifk3hoLu+5A7NzoK71qTT7T1RL2golQG0+F871E=;
        b=lnPsrGa+Rim39l1kDJTZU14avWSF6O9tpV3+ZkOS7ewyx9eXEgKVMByDlfAPPs+j3n
         844XI4s4b510R8B4VfJIKQIsPSKKNOl0/NJdZQHbMwt4/dW6sVjcPmSYDk1Osn8AkKTj
         0IGa3uzTQOKAmItuUH2YoEwJkDbKXffVf0KHJdcpBgbLgzs5/9J64O78XomnugB3Gnf1
         c2HfxCBGIsAmtltHSV9jSm3uZhA4Zd/HAKj/uVFVLgNBFdoyv93jFu0zc0PznKsw6WZV
         WT1k47Gv/f4nw6C2VSVLaWJkjq10kBj7UpMCflz8R+MncDcmcOqhgPvxwiwXbUdDX7ve
         CM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jjrvifk3hoLu+5A7NzoK71qTT7T1RL2golQG0+F871E=;
        b=aDl+5ibNmQmowIkl41jhNxHnkroqesPx0Azaz5iXTD+90B3X1A8pqr4iS2j10NPDu+
         3RJBB2Fo0vGfe0ntNOljnOgJfJbVAftz+Iu96I1OnN/30XUCjH+48qSAdjVgYNjgdkn7
         lr2LVMN3y05/6LrHt25Cz2aB5bYSvhf+3aTEwWzFuNqV4v5C+PxipLCrzhTXPQf6GqQR
         nuyi4HuG9hLJb0LXw6XFpFdrG7yDqQqCDd4DBm7aGDeWaEsZ0D2K1R1tXm6DnGlAsykr
         5pXlYuTvh/Ehe9d0lKSfyLlJpmp9GfGZFrEa708FJk9Bwzwzao7OqMi51iwn99RTgQOs
         SzCg==
X-Gm-Message-State: AO0yUKWQGJCRO7g3wzHuSaoY8ST7kyEXLyQwAuivyAh9RnoRjkqqaX5M
        kGw7VKBGPGQgDaDCFRVGqEdrOA==
X-Google-Smtp-Source: AK7set8IUiobytVzogXsg+T3ARfx0uDbLVnBQfqBlnGONNwk+E4xgjjZ/7jObj9J4UsG1Pk2KkGwIw==
X-Received: by 2002:ac2:5973:0:b0:4b6:e494:a98d with SMTP id h19-20020ac25973000000b004b6e494a98dmr4652502lfp.44.1678273023569;
        Wed, 08 Mar 2023 02:57:03 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id i25-20020ac25239000000b004e81fdac4a1sm200980lfl.278.2023.03.08.02.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:57:03 -0800 (PST)
Message-ID: <ca257415-afd4-155d-bbdb-822f6eedd554@linaro.org>
Date:   Wed, 8 Mar 2023 11:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/9] arm64: dts: qcom: sa8775p: add high-speed UART
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
References: <20230308104009.260451-1-brgl@bgdev.pl>
 <20230308104009.260451-8-brgl@bgdev.pl>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230308104009.260451-8-brgl@bgdev.pl>
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
> Add two UART nodes that are known to be used by existing development
> boards with this SoC.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 992864e3e0c8..5ebfe8c10eac 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -490,6 +490,21 @@ &clk_virt SLAVE_QUP_CORE_1 0>,
>  				operating-points-v2 = <&qup_opp_table_100mhz>;
>  				status = "disabled";
>  			};
> +
> +			uart12: serial@a94000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x00a94000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS
> +						 &clk_virt SLAVE_QUP_CORE_1 QCOM_ICC_TAG_ALWAYS>,
> +						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +						 &config_noc SLAVE_QUP_1 QCOM_ICC_TAG_ALWAYS>;
> +				interconnect-names = "qup-core", "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
>  		};
>  
>  		qupv3_id_2: geniqup@8c0000 {
> @@ -525,6 +540,22 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
>  				status = "disabled";
>  			};
>  
> +			uart17: serial@88c000 {
> +				compatible = "qcom,geni-uart";
> +				reg = <0x0 0x0088c000 0x0 0x4000>;
> +				interrupts-extended = <&intc GIC_SPI 585 IRQ_TYPE_LEVEL_HIGH>,
> +						      <&tlmm 94 IRQ_TYPE_LEVEL_HIGH>;
This hunk is board-specific and only makes sense if bluetooth
(or some other "important" peripheral) is connected to this
uart. Generally the uart interrupt is the one coming from the GIC
and the other one should probably go to the board dtsi.

Konrad
> +				clocks = <&gcc GCC_QUPV3_WRAP2_S3_CLK>;
> +				clock-names = "se";
> +				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
> +						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
> +						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
> +				interconnect-names = "qup-core", "qup-config";
> +				power-domains = <&rpmhpd SA8775P_CX>;
> +				status = "disabled";
> +			};
> +
>  			i2c18: i2c@890000 {
>  				compatible = "qcom,geni-i2c";
>  				reg = <0x0 0x00890000 0x0 0x4000>;
