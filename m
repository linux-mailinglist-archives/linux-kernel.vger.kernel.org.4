Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57D7370FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjFTPwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjFTPwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:52:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BFCF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:52:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f849a0e371so6387286e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687276324; x=1689868324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3kqQLayyp0ekBn2vte4HJlKBavPA41nDcbx1XhdpDCo=;
        b=Mdb6M6SDaBuaZMRf12wlCdjVJLNb2pdnwKwjQ5qDHEwGsoonQgaLpaArK260d1/UOr
         PK4Xcy9BjLUysjrgAjRbXaeMhzNBlVM5plfebvzjjX3dg60FcncLgSP4Ul1nWOtMQ5U/
         hIrtYtzcYwtoXJJopSSxEkTph0LduPn52h7ZWoBNsC1CRR6k9HTwT7N+5VTHt0yoKNgu
         XhLJfo1zUJDwVn9yyoSwnRtb80/Rzry7mvY8ZYJ6e2jvKFPxstohgv7PcVc8UU8GdDIM
         DkbGI6ypxzDi0KFzpJgstMEzgZVtqB4scMom1nYqgssKo67MNmktB5tk5sN7YU+ygucZ
         LGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687276324; x=1689868324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3kqQLayyp0ekBn2vte4HJlKBavPA41nDcbx1XhdpDCo=;
        b=GneyJQ4wlSVuSo2ALugDrE0jmZajWHn0hzY6wLKKzB3RqUyRJf4LpMgqhh6j5lwHwq
         7MgUt68aH4UZKU8syUhUBpSPVpgZx8KuF65egRBABOyih6dLVWTlIAQ/qPLVUmDPpuPV
         Eqg/kKvVfHiSOeK00vbAxA+S9UjMEPiS2K6rlxIy3ktCZE/REFvutREGoZyaE1a9Gqgo
         gnqVliiFhqy5p2smeNvQxjDQyzNthHXkBVfEdJ6NicmL0W2MyVGanEnx7c0rWgkUrjIh
         cq0AhRKdyB70iBm7YHWKyaVmmw/ABC2sctXjIQeOuqbhjUE8jBQk0ZKagzIZ1F306O+i
         2HXw==
X-Gm-Message-State: AC+VfDy67rTUlLvKOIBLmdSev78q41FF8oY9lH/pMlNfTa2r/IX/FPhO
        Wp4pOz4jSfh5u0U9MJniFlNsERam9wBFl5Idi8s=
X-Google-Smtp-Source: ACHHUZ647+DYGIPYNqAHZ20/rgSckz2mRZXNFu7jQytXmCGw3zadTvKk4Ts6M7/kYn2iP26edB7+4g==
X-Received: by 2002:a19:e003:0:b0:4f8:7325:bcd4 with SMTP id x3-20020a19e003000000b004f87325bcd4mr3491321lfg.0.1687276324026;
        Tue, 20 Jun 2023 08:52:04 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f6-20020ac251a6000000b004f768d70241sm407314lfk.233.2023.06.20.08.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 08:52:03 -0700 (PDT)
Message-ID: <c9ed9e06-3a94-e8ee-7fb6-8ff66c41a32e@linaro.org>
Date:   Tue, 20 Jun 2023 18:52:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm6115p-j606f: Hook up display
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
 <20230620-topic-gpu_tablet_disp-v1-2-7bb02bec8dc0@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230620-topic-gpu_tablet_disp-v1-2-7bb02bec8dc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 16:17, Konrad Dybcio wrote:
> Enable the required nodes, add the required pins and tweak a
> regulator to enable non-simplefb display on the Tab P11.
> 
> Do note that there exists a second SKU with a different panel+touch
> combo, but due to insufficient information, that will need to be
> handled separately.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 57 +++++++++++++++++++++--
>   1 file changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> index 81fdcaf48926..a10ce676bd44 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> @@ -65,9 +65,41 @@ ramoops@ffc00000 {
>   	};
>   };
>   
> -&dispcc {
> -	/* HACK: disable until a panel driver is ready to retain simplefb */
> -	status = "disabled";
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mdss_dsi0 {
> +	vdda-supply = <&pm6125_l18>;
> +	status = "okay";
> +
> +	panel: panel@0 {
> +		compatible = "lenovo,j606f-boe-nt36523w", "novatek,nt36523w";
> +		reg = <0>;
> +
> +		reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
> +		vddio-supply = <&pm6125_l9>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&te_active &sde_dsi_active>;
> +
> +		rotation = <180>; /* Yep, it's mounted upside down! */
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&mdss_dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&mdss_dsi0_out {
> +	data-lanes = <0 1 2 3>;
> +	remote-endpoint = <&panel_in>;
> +};
> +
> +&mdss_dsi0_phy {
> +	status = "okay";
>   };
>   
>   &pm6125_gpios {
> @@ -212,8 +244,9 @@ pm6125_l17: l17 {
>   		};
>   
>   		pm6125_l18: l18 {
> -			regulator-min-microvolt = <1104000>;
> -			regulator-max-microvolt = <1312000>;
> +			/* 1.104V-1.312V fixed @ 1.232V for DSIPHY */
> +			regulator-min-microvolt = <1232000>;
> +			regulator-max-microvolt = <1232000>;
>   		};
>   
>   		pm6125_l19: l19 {
> @@ -282,6 +315,20 @@ sdc2_gate_pin: sdc2-gate-state {
>   		bias-pull-up;
>   		output-high;
>   	};
> +
> +	te_active: te-active-state {
> +		pins = "gpio81";
> +		function = "mdp_vsync";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	sde_dsi_active: te-active-state {

mdss_dsi_active? Or just dsi_active?

> +		pins = "gpio82";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
>   };
>   
>   &ufs_mem_hc {
> 

-- 
With best wishes
Dmitry

