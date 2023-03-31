Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A56D1440
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjCaAnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCaAnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:43:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4A8A5E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:43:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x17so26889990lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680223397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EdNKd/5MilWhcWrQcl7LfVYBRkltR5mgQKsK73gCn9w=;
        b=f7IhSXzG2la4GnyESSieHCAL6H5xzP8OBgrxswjRgKsSytJUo56gSw7dQQix1NanC+
         vwXeSdpzOn9QA1uVGhONEYPGVpfDi4IVfPCo33OHQ1BvvemmO6NYp0oIzq0hXP5S4hnJ
         +o29cmpupI8JLFaISchPcolciyLTORNsq+hBfOr9f85KMyDhp/Jr3UjnFJuF1WX8vakK
         rUhXi8k2ZaJTvzN6pfCwO0WXBAaSld0Md58I+YBRnSfDYCbf1meX7ksxz6MpeR1Iu6/9
         T45LC/UWxKoAd3mQBSbE8O1kys43ijmtDcjwVpoU7guIdO695xo8GTKSg6CZHvQQ83y2
         E7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EdNKd/5MilWhcWrQcl7LfVYBRkltR5mgQKsK73gCn9w=;
        b=bdkEeilYbzdMiAl5a+nlB40L1QttjtYhzay2gUmzJ5RKnMTmG6a8pOw4UiOr3DzEfS
         grR/5ol0OS0VL4g4Xo8o5oAvQHG+JMb6s+DWDNXGiBr5M1+45oWOdGIBkVa9lYj57yQU
         oGYtlPMW/FtoBBEY4JvickeeaqG7Blv5IqVStmuEXp+0LuDdAYorrhsa8NMWZyZf/vW7
         MIZnLSb0JbI9QE227h1uZLzJRY96TcDoCV9esuSj3WqYavxBa1iq2XCUJM8L0zZygA4i
         jMwBrkbvpgl6FlqwMB17N6o6BXLeZ5/HijGeL2XZ0M1w5xQEuEGK3eQ9lkE8lnqFU9zH
         fdsw==
X-Gm-Message-State: AAQBX9cePHE5MIqdTyT2uBWwGzqXQCCw3oU6Wp8aiOfnA3EWpFEZZ4O4
        DcaKDJ3oAkx9O3dW/QKQzPUemg==
X-Google-Smtp-Source: AKy350YRAZHIs02zJdJuKyBOpAU4E+YEssGtc50ExOFKIzcnRzazeSFbeqTrPGCAxT7laAEv1fmpdA==
X-Received: by 2002:a19:ca4a:0:b0:4d8:86c1:4771 with SMTP id h10-20020a19ca4a000000b004d886c14771mr2062855lfj.6.1680223397584;
        Thu, 30 Mar 2023 17:43:17 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id i27-20020ac2523b000000b004e9b4a8f738sm147274lfl.152.2023.03.30.17.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 17:43:17 -0700 (PDT)
Message-ID: <df57f5c1-13aa-c328-57ac-de486d29e549@linaro.org>
Date:   Fri, 31 Mar 2023 03:43:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sm8250: Add GPU speedbin support
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120172233.1905761-1-konrad.dybcio@linaro.org>
 <20230120172233.1905761-6-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230120172233.1905761-6-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 20/01/2023 19:22, Konrad Dybcio wrote:
> SM8250 has (at least) four GPU speed bins. With the support added on the
> driver side, wire up bin detection in the DTS to restrict lower-quality
> SKUs from running at frequencies they were not validated at.
> 
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Sony Xperia 5 II (speed bin 0x7)
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 059c83003fb6..95f1a6afcd43 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -981,6 +981,18 @@ ipcc: mailbox@408000 {
>   			#mbox-cells = <2>;
>   		};
>   
> +		qfprom: efuse@784000 {
> +			compatible = "qcom,sm8250-qfprom", "qcom,qfprom";
> +			reg = <0 0x00784000 0 0x8ff>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			gpu_speed_bin: gpu_speed_bin@19b {
> +				reg = <0x19b 0x1>;
> +				bits = <5 3>;
> +			};
> +		};
> +
>   		rng: rng@793000 {
>   			compatible = "qcom,prng-ee";
>   			reg = <0 0x00793000 0 0x1000>;
> @@ -2576,49 +2588,58 @@ gpu: gpu@3d00000 {
>   
>   			qcom,gmu = <&gmu>;
>   
> +			nvmem-cells = <&gpu_speed_bin>;
> +			nvmem-cell-names = "speed_bin";
> +
>   			status = "disabled";
>   
>   			zap-shader {
>   				memory-region = <&gpu_mem>;
>   			};
>   
> -			/* note: downstream checks gpu binning for 670 Mhz */
>   			gpu_opp_table: opp-table {
>   				compatible = "operating-points-v2";
>   
>   				opp-670000000 {
>   					opp-hz = /bits/ 64 <670000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
> +					opp-supported-hw = <0x6>;

opp-supported-hw = <0xa>; /* 3 & 1 */

>   				};
>   
>   				opp-587000000 {
>   					opp-hz = /bits/ 64 <587000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
> +					opp-supported-hw = <0x7>;

opp-supported-hw = <0xb>; /* 3, 1, 0 */


>   				};
>   
>   				opp-525000000 {
>   					opp-hz = /bits/ 64 <525000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
> +					opp-supported-hw = <0xf>;
>   				};
>   
>   				opp-490000000 {
>   					opp-hz = /bits/ 64 <490000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
> +					opp-supported-hw = <0xf>;
>   				};
>   
>   				opp-441600000 {
>   					opp-hz = /bits/ 64 <441600000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
> +					opp-supported-hw = <0xf>;
>   				};
>   
>   				opp-400000000 {
>   					opp-hz = /bits/ 64 <400000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
> +					opp-supported-hw = <0xf>;
>   				};
>   
>   				opp-305000000 {
>   					opp-hz = /bits/ 64 <305000000>;
>   					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
> +					opp-supported-hw = <0xf>;
>   				};
>   			};
>   		};

-- 
With best wishes
Dmitry

