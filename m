Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4C06B8F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCNKJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCNKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:09:54 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E7F20072
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:09:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j11so19229036lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678788584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfP7OisdfBLXKLqUWZNkPQ3fDRBGJKSNwG4JFeeABvc=;
        b=k5MXVulEA3k+OwHJPPjL9ag/mbJTQznJMLJ4PsbuL2HZ+ty9iU+CgQ/7GH2jKnobkY
         6mPhvO+ZrrSnogUxkZrSlvos85iXIdoMybhMEpICMLHz62Epqc8bW35zFCKaoQp/F4VE
         rBGqrdmq/g6ABvhb7ZqGkefzX96O83ON8rUDmYX9QPt+6MIVwWAUPSN3YaKDzzKiargK
         b+cIjk20Q4xwTy5go6vu3EtKMqtR7aleqxukm5luYrZvRJp53joAZJB+R6AaR1PldyYb
         7rXDaXtIwl88l3whCVI8kzY/b4T6JnvuS/RPFLtl3biqH4+ynSbkOajE+uBf8Qkv3yrt
         fkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678788584;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfP7OisdfBLXKLqUWZNkPQ3fDRBGJKSNwG4JFeeABvc=;
        b=i+N1rP2M7MKi+0eXbO5jZwdMxz6mtyuwP1drt9BUD8Otst014e1X9EQjs/tID0AEv0
         ABhhnlnBRuQHvl55ym1nsOOij5vtusfa65+xgZMSGxZbJ9ZuFkKBd1he/Urw0bUwYGjb
         wefrJ0QD6cqcETEHLSht+OnDbiRJvSRiJV5p49ifEpgvya1SoVwOz4r8gbGAS6+KRqSS
         Dgwz/fF/AiCL08S1dR+eD70t60YMI+X/St9q1qHoNpk7vaHklwY3SRUU4L0wTH9YHd07
         MUqiwvDMj3rUwV9g8FgN8ZFV9ncE6YZ0ZfhI8LE3rFc0/lssusGyVLBTFyVgDkP9gBHr
         Mpug==
X-Gm-Message-State: AO0yUKVG22OUGemxBS6FVsv0Y/VtOeKtpDxilJYD8k6K+07ZnaRGOs8f
        4HV9AlHu2Aa3EtGr+oDGDrtIjw==
X-Google-Smtp-Source: AK7set+okIbof1RS3blXA94VZLZjC6cATnGSNNfyOzb9Em4KQWzJofbA8LFNppL6tyvYEUfDUaRiFw==
X-Received: by 2002:ac2:51dc:0:b0:4dd:ad88:ba65 with SMTP id u28-20020ac251dc000000b004ddad88ba65mr554446lfm.67.1678788583902;
        Tue, 14 Mar 2023 03:09:43 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f11-20020ac2508b000000b004db511ccae6sm335695lfm.294.2023.03.14.03.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:09:43 -0700 (PDT)
Message-ID: <426ca0fd-5119-7e3c-89ce-27590b11f63f@linaro.org>
Date:   Tue, 14 Mar 2023 11:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sm6115: Move SDHC node(s)'s
 'pinctrl' properties to dts
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314074001.1873781-1-bhupesh.sharma@linaro.org>
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



On 14.03.2023 08:40, Bhupesh Sharma wrote:
> Normally the 'pinctrl' properties of a SDHC controller and the
> chip detect pin settings are dependent on the type of the slots
> (for e.g uSD card slot), regulators and GPIO(s) available on the
> board(s).
> 
> So, move the same from the sm6115 dtsi file to the respective
> board file(s).
So, file or files? :D

> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
> Changes since v1:
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20221220113616.1556097-1-bhupesh.sharma@linaro.org/
> - Colleted the R-B from Marijn.
> - Rebased on linux-next/master
> 
>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 10 +++++++++
>  arch/arm64/boot/dts/qcom/sm6115.dtsi          | 22 -------------------
>  2 files changed, 10 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> index a3f1c7c41fd73..329eb496bbc5f 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
> @@ -202,12 +202,22 @@ &sdhc_2 {
>  	vqmmc-supply = <&vreg_l5a>;
>  
>  	cd-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_state_on &sdc2_card_det_n>;
> +	pinctrl-1 = <&sdc2_state_off &sdc2_card_det_n>;
This should have been

pinctrl-n
pinctrl-names

I made a mistake in my lenovo dts if that was your reference..

You should also mention that the implicit removal of sdhci1's
gpio properties from the lenovo j606f and oneplus billie2 is intentional
as they both use UFS instead of eMMC.

And one more thing, you missed bringing the CD pin back into pinctrl-0/1
in the tab dts. I'd really appreciate if you could fix up that ordering
mess I mentioned above while at it.

Konrad
>  
>  	status = "okay";
>  };
>  
>  &tlmm {
>  	gpio-reserved-ranges = <14 4>;
> +
> +	sdc2_card_det_n: sd-card-det-n-state {
> +		pins = "gpio88";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
>  };
>  
>  &ufs_mem_hc {
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index fbd67d2c8d781..e8e5f2cafebb9 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -595,13 +595,6 @@ data-pins {
>  					bias-pull-up;
>  					drive-strength = <10>;
>  				};
> -
> -				sd-cd-pins {
> -					pins = "gpio88";
> -					function = "gpio";
> -					bias-pull-up;
> -					drive-strength = <2>;
> -				};
>  			};
>  
>  			sdc2_state_off: sdc2-off-state {
> @@ -622,13 +615,6 @@ data-pins {
>  					bias-pull-up;
>  					drive-strength = <2>;
>  				};
> -
> -				sd-cd-pins {
> -					pins = "gpio88";
> -					function = "gpio";
> -					bias-disable;
> -					drive-strength = <2>;
> -				};
>  			};
>  		};
>  
> @@ -731,10 +717,6 @@ sdhc_1: mmc@4744000 {
>  				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
>  			clock-names = "iface", "core", "xo", "ice";
>  
> -			pinctrl-0 = <&sdc1_state_on>;
> -			pinctrl-1 = <&sdc1_state_off>;
> -			pinctrl-names = "default", "sleep";
> -
>  			bus-width = <8>;
>  			status = "disabled";
>  		};
> @@ -753,10 +735,6 @@ sdhc_2: mmc@4784000 {
>  				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  
> -			pinctrl-0 = <&sdc2_state_on>;
> -			pinctrl-1 = <&sdc2_state_off>;
> -			pinctrl-names = "default", "sleep";
> -
>  			power-domains = <&rpmpd SM6115_VDDCX>;
>  			operating-points-v2 = <&sdhc2_opp_table>;
>  			iommus = <&apps_smmu 0x00a0 0x0>;
