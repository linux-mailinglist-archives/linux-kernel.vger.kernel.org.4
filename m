Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD8A6C8DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCYMHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCYMG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:06:59 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780074200
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:06:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y20so5503907lfj.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679746017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ls/4dEoakJUBs+x1zYIr80eTAGOu/vGAzSdyVBHZXjw=;
        b=P8IVB+gG+8cib+FMsXedJyt2sNW8C1AKPLGccTyFjN4F9LyK5V1Jw1+aIZ1Pq41Xok
         MYbeZ3fxY0V6Zrz/okNYLRFoIAG81c83vqC17/jTjFzAjtR0VtBMZ0fRPJ/+wafYwPby
         yAz8tf2Gs1orx6xG0nVyZJVfpMG5cZkvWIcoxb/GOUZysBBiEBDvBFQE2Z7ENVmMnoHK
         zX0thQ37HfvPU48eyy23OIZsOdp8ZDGCtLG5hkEgS/E+4d6A09ae2QZzAEZNR4Ticlxs
         pSTABtiMCkMy0bQ0r5aUDFzPKweJGBmqdo4AxR7z52vMW4s0xQT5iQBwpDPtOz43dKIM
         drNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ls/4dEoakJUBs+x1zYIr80eTAGOu/vGAzSdyVBHZXjw=;
        b=juXLgD63FCu4Lk2gygWzhGHx6hopkZnDter+1PQut1bK1Y/8C/pvGYB7wtNhnRTkvb
         lWy1wHRLihHuiFM83JDvGBOIYzhSnxTbgq4wHwqsACv6jRNv2OniTjfOF4cpM1FXJbP4
         6kSiB8ilLQzWPuN479XwFsgFoI46IwskQwgpezjkH4azjIbNuuTd4mgidutrJFSQRwee
         sSaSQxnVIjroWJ4g8ctneAuZ4I5tW81OMra1ZQ6lX6Y4ZCR+465+0jm/7w55Grx4sxAo
         Fe3IhVM3jyMrlSlzhFSRgRGALibQaqF0W552ZAqFyZQvtx1+0laxBPnluR/o4OYHY7L+
         hL+Q==
X-Gm-Message-State: AAQBX9dej1DRbw8s948uBmVVsezjI6NDEZGUt0QStdmT/J6W2vOp3tZt
        DTwDK2o83tOVHYgMplai3C13EmKZKdpTVDCTaAU=
X-Google-Smtp-Source: AKy350afhm8uBg2hlEF+8YhlBzQ6WCCNnrgz7g5oXrEoj2rCOqWhoELroOmoSZ3MCmq0WqPocRAB8Q==
X-Received: by 2002:ac2:5dee:0:b0:4dc:790c:910b with SMTP id z14-20020ac25dee000000b004dc790c910bmr1782329lfq.20.1679746016756;
        Sat, 25 Mar 2023 05:06:56 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id d13-20020ac241cd000000b004b58500383bsm3752900lfi.272.2023.03.25.05.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:06:56 -0700 (PDT)
Message-ID: <6f1d4df2-2594-518d-6e46-667fb5a249ed@linaro.org>
Date:   Sat, 25 Mar 2023 13:06:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] arm64: dts: msm8953: Replace xo_board with rpmcc
 sourced xo
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230325112852.18841-1-a39.skl@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230325112852.18841-1-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.03.2023 12:28, Adam Skladowski wrote:
> Assign RPM_SMD_XO_CLK_SRC from rpmcc in place
> of fixed-clock where possible.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index da00c2f04cda..438a70eb6152 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
>  
>  #include <dt-bindings/clock/qcom,gcc-msm8953.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
> @@ -637,7 +638,7 @@ gcc: clock-controller@1800000 {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> -			clocks = <&xo_board>,
> +			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
>  				 <&sleep_clk>,
>  				 <0>,
>  				 <0>,
> @@ -801,7 +802,7 @@ dsi0_phy: phy@1a94400 {
>  				#clock-cells = <1>;
>  				#phy-cells = <0>;
>  
> -				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  				clock-names = "iface", "ref";
>  
>  				status = "disabled";
> @@ -868,7 +869,7 @@ dsi1_phy: phy@1a96400 {
>  				#clock-cells = <1>;
>  				#phy-cells = <0>;
>  
> -				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
> +				clocks = <&gcc GCC_MDSS_AHB_CLK>, <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  				clock-names = "iface", "ref";
>  
>  				status = "disabled";
> @@ -992,7 +993,7 @@ sdhc_1: mmc@7824900 {
>  
>  			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>  				 <&gcc GCC_SDCC1_APPS_CLK>,
> -				 <&xo_board>;
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  
>  			power-domains = <&rpmpd MSM8953_VDDCX>;
> @@ -1052,7 +1053,7 @@ sdhc_2: mmc@7864900 {
>  
>  			clocks = <&gcc GCC_SDCC2_AHB_CLK>,
>  				 <&gcc GCC_SDCC2_APPS_CLK>,
> -				 <&xo_board>;
> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>;
>  			clock-names = "iface", "core", "xo";
>  
>  			power-domains = <&rpmpd MSM8953_VDDCX>;
