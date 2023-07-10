Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986674D46F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGJLVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGJLVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:21:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECB9DF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:21:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb8574a3a1so6379533e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688988062; x=1691580062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uSQwORdZ256hlM9anstUKFJSydzIfrrK8m4e8Jt1aQ=;
        b=q9f9vknAE9V1NfKXEx3P97oDvOyL2gsk2JICRloT8X7HprGOZ1rIqBmbxny6IdhLW9
         ETV9D/QrgfirpSB2Zer9jjwPCbwsvpvfT0ss6xSnUFtZK9gzdluaySRXPzXHhTLc8NSv
         7kFW8KSAikpoXB8HOPB+X41SRjinJTURz3ZFYx0IdlMlFBIg5Ov64J7YFhCFqXFWxnbz
         O++CY4x8a4hsg5dALdRa4yJNJkXhew9B201IHmhpCdfRPWBWpjxJqR3Duz1e2ROKBkq8
         zpIgwoXvyd4RGH630s/bYY0N6l77iQEdnEGVFw5ys2jEsJ9LIADmKE0+mZjBBdE98DD5
         3ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688988062; x=1691580062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uSQwORdZ256hlM9anstUKFJSydzIfrrK8m4e8Jt1aQ=;
        b=JIXYgDxE8Xy6N/oxyu3VRoQy01S93mAz/4Yn+6mMChwQOcyVWjqFifrr6+JHr5ob2J
         gGlAXuQp3X6bNB0xZNiNQlS9cwp/MrhZCsZhSPFcp+yO6nz3GnbgS7xqiWtKUNIgNSNQ
         CkzI/iJxT2GMCzs/rkdTCB7gKxAGQ0/s8B+FmVFjx++t98CVCoqMaKFTuNKL3og7boQV
         aATgxftQNV7QU1ZvFU5S091yu6KXm+IGmsZ9aza9KtlwZPcEfJ4mQWQIoVtRrR1GTHs7
         XqvGQCBqX3HLDNElUKTgqvL+QCaoUvYWDL2hH2pzMu94G/YhNT2osAUDgKB9dupiA506
         tcvA==
X-Gm-Message-State: ABy/qLbN2zeqLGh1WvbP8A+Y3I//DaCo8IF+iGcrtePwRhYkeoKY5GHV
        Jj62Eov7+m1SfT4Yrfmh9/EL7A==
X-Google-Smtp-Source: APBJJlGIMM8uWjWOE6Nwqoqu1g+yFtt3POqvMLGyMrr6yani4FCbTVo9/tVe7d1pWgehzfP03/ag/g==
X-Received: by 2002:a19:5f52:0:b0:4fb:957b:4b20 with SMTP id a18-20020a195f52000000b004fb957b4b20mr8503823lfj.59.1688988062246;
        Mon, 10 Jul 2023 04:21:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s7-20020ac25fe7000000b004fb9b895120sm1671030lfg.16.2023.07.10.04.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:21:01 -0700 (PDT)
Message-ID: <72f053a5-2754-409a-d174-d05bba3a3f39@linaro.org>
Date:   Mon, 10 Jul 2023 14:21:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] arm64: dts: qcom: ipq5332: Add tsens node
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230710103735.1375847-5-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 13:37, Praveenkumar I wrote:
> IPQ5332 has tsens v2.3.3 peripheral. This patch adds the tsense
> node with nvmem cells for calibration data.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5332.dtsi | 113 ++++++++++++++++++++++++++
>   1 file changed, 113 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 8bfc2db44624..a1e3527178c0 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -150,6 +150,91 @@ qfprom: efuse@a4000 {
>   			reg = <0x000a4000 0x721>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> +
> +			tsens_mode: mode@3e1 {
> +				reg = <0x3e1 0x1>;
> +				bits = <0 3>;
> +			};
> +
> +			tsens_base0: base0@3e1 {
> +				reg = <0x3e1 0x2>;
> +				bits = <3 10>;
> +			};
> +
> +			tsens_base1: base1@3e2 {
> +				reg = <0x3e2 0x2>;
> +				bits = <5 10>;
> +			};
> +
> +			s0_offset: s0_offset@3e4 {
> +				reg = <0x3e4 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s3_offset: s3_offset@3e5 {
> +				reg = <0x3e5 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s4_offset: s4_offset@3e6 {
> +				reg = <0x3e6 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s5_offset: s5_offset@3e6 {
> +				reg = <0x3e6 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s6_offset: s6_offset@3e8 {
> +				reg = <0x3e8 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s7_offset: s7_offset@3e8 {
> +				reg = <0x3e8 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s8_offset: s8_offset@3a4 {
> +				reg = <0x3a4 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s9_offset: s9_offset@3a4 {
> +				reg = <0x3a4 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s10_offset: s10_offset@3a5 {
> +				reg = <0x3a5 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s11_offset: s11_offset@3a5 {
> +				reg = <0x3a5 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s12_offset: s12_offset@3a6 {
> +				reg = <0x3a6 0x1>;
> +				bits = <0 4>;
> +			};
> +
> +			s13_offset: s13_offset@3a6 {
> +				reg = <0x3a6 0x1>;
> +				bits = <4 4>;
> +			};
> +
> +			s14_offset: s14_offset@3ad {
> +				reg = <0x3ad 0x2>;
> +				bits = <7 4>;
> +			};
> +
> +			s15_offset: s0_offset@3ae {
> +				reg = <0x3ae 0x1>;
> +				bits = <3 4>;
> +			};
>   		};
>   
>   		rng: rng@e3000 {
> @@ -159,6 +244,34 @@ rng: rng@e3000 {
>   			clock-names = "core";
>   		};
>   
> +		tsens: thermal-sensor@4a9000 {
> +			compatible = "qcom,ipq5332-tsens";
> +			reg = <0x4a9000 0x1000>,
> +			      <0x4a8000 0x1000>;
> +			nvmem-cells = <&tsens_mode>, <&tsens_base0>,
> +					<&tsens_base1>, <&s0_offset>,

Please align vertically.

> +					<&s3_offset>, <&s4_offset>,
> +					<&s5_offset>, <&s6_offset>,
> +					<&s7_offset>, <&s8_offset>,
> +					<&s9_offset>, <&s10_offset>,
> +					<&s11_offset>, <&s12_offset>,
> +					<&s13_offset>, <&s14_offset>,
> +					<&s15_offset>;
> +			nvmem-cell-names = "mode", "base0",
> +						"base1", "s0_offset",

And here.

> +						"s3_offset", "s4_offset",
> +						"s5_offset", "s6_offset",
> +						"s7_offset", "s8_offset",
> +						"s9_offset", "s10_offset",
> +						"s11_offset", "s12_offset",
> +						"s13_offset", "s14_offset",
> +						"s15_offset";
> +			interrupts = <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "combined";
> +			#qcom,sensors = <16>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>   		tlmm: pinctrl@1000000 {
>   			compatible = "qcom,ipq5332-tlmm";
>   			reg = <0x01000000 0x300000>;

-- 
With best wishes
Dmitry

