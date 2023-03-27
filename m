Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E4B6CAC28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjC0RsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjC0RsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:48:09 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382E30E7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:48:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id c9so2091894lfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679939284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv0wD40+aVa6VSlTrbt6mn44i+Oaj4TK6/Tv/6oXWIk=;
        b=YWIGTJBSRnezeA2k/P/AtWxO6tR3OwcaJ5+9PDZfzRYnMrVlA1//WKJjPricF6BncN
         zFU1EYQywnxn6YyhXj9nCF+HatG2ZhmCPVHNma6sWdTJ6bY4KfaCs1zN/HJoJ3xN43sl
         Wlq0B5Ug8sFJGq86QFHTP3oJbP2swXAZo4XXbrBPRELh3ulV1CNJFPXbGcr1Br7ET8nB
         tqI/QmYOyKhoM8suvw32Jvfh5skbNDbTkrVcERUxGStkHwVIitHB0PClg3/zQ0jAQNtF
         p4m6TVK4bJQq+baw6SjI8k2BT3IGlh833XMrRk3yGayTIWBUblP9y1TGcqx2yKtCqbwy
         R5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939284;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bv0wD40+aVa6VSlTrbt6mn44i+Oaj4TK6/Tv/6oXWIk=;
        b=neVLBC5SEuUQCvHyLsRXx4rP5pKfSPQ3YiH3q7kRNVdFIrZkVAUv26lS+sXj83DUep
         a6G1iD08TYUBaAfCf0aAMzEwekH0hPdzz2I24XHOrLFR6Z7vgBI47AUz+yeN5JIMSV/x
         4CpuR6bYO7pGYZ09bCNQYfxUsds3PwsepyEJ1Xmti9xSW2OshpulpfTSZuBVVFvsGwOw
         iyF84ZHPZteBf4LPsn1lqr3/6/CkJ1+c02e0HkshxwzJqbyP+1+8skvLQVsis2Gzl0f9
         XlWD8eZKbETHetztWLyB6q+wCelD99jjceoUgSB9WLdaRNeeoavj40Ocyn8A5/zeyPP4
         s5KQ==
X-Gm-Message-State: AAQBX9chdbO+9gkC1pN0l9tbOe3GShOcUb0Th38qmsMo+6bG+l0ssWyR
        5f68GUejCbPmOtYV9GRXiHETnQ==
X-Google-Smtp-Source: AKy350ZssKPDJuGQ85FB71rGe3YVHtaG6xa9NZLpivLD2gQJVBU8hIXcUk3XfsoaXzadIXkQUIvDFw==
X-Received: by 2002:ac2:5083:0:b0:4eb:7d1:862d with SMTP id f3-20020ac25083000000b004eb07d1862dmr2368123lfm.38.1679939283849;
        Mon, 27 Mar 2023 10:48:03 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id n7-20020ac242c7000000b004db2978e330sm4753264lfl.258.2023.03.27.10.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 10:48:03 -0700 (PDT)
Message-ID: <3e130983-62ab-10c1-4914-5f9e1edc4b8b@linaro.org>
Date:   Mon, 27 Mar 2023 19:48:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm630: move DSI opp-table out of
 soc node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230326091605.18908-1-krzysztof.kozlowski@linaro.org>
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



On 26.03.2023 11:16, Krzysztof Kozlowski wrote:
> The soc node is supposed to have only device nodes with MMIO addresses,
> so move the DSI OPP out of it (it is used also by second DSI1 on
> SDM660):
> 
>   sda660-inforce-ifc6560.dtb: soc: opp-table-dsi: {'compatible': ['operating-points-v2'], ... should not be valid under {'type': 'object'}
>     From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. Move the node out of soc. Don't add Konrad's review tag.
> ---
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 38 ++++++++++++++--------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 72d9a12b5e9c..b91e423a3cfc 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -328,6 +328,25 @@ memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
>  
> +	dsi_opp_table: opp-table-dsi {
> +		compatible = "operating-points-v2";
> +
> +		opp-131250000 {
> +			opp-hz = /bits/ 64 <131250000>;
> +			required-opps = <&rpmpd_opp_svs>;
> +		};
> +
> +		opp-210000000 {
> +			opp-hz = /bits/ 64 <210000000>;
> +			required-opps = <&rpmpd_opp_svs_plus>;
> +		};
> +
> +		opp-262500000 {
> +			opp-hz = /bits/ 64 <262500000>;
> +			required-opps = <&rpmpd_opp_nom>;
> +		};
> +	};
> +
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1450,25 +1469,6 @@ mmcc: clock-controller@c8c0000 {
>  					<0>;
>  		};
>  
> -		dsi_opp_table: opp-table-dsi {
> -			compatible = "operating-points-v2";
> -
> -			opp-131250000 {
> -				opp-hz = /bits/ 64 <131250000>;
> -				required-opps = <&rpmpd_opp_svs>;
> -			};
> -
> -			opp-210000000 {
> -				opp-hz = /bits/ 64 <210000000>;
> -				required-opps = <&rpmpd_opp_svs_plus>;
> -			};
> -
> -			opp-262500000 {
> -				opp-hz = /bits/ 64 <262500000>;
> -				required-opps = <&rpmpd_opp_nom>;
> -			};
> -		};
> -
>  		mdss: display-subsystem@c900000 {
>  			compatible = "qcom,mdss";
>  			reg = <0x0c900000 0x1000>,
