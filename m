Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E1B6C8DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjCYMEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjCYMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:04:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CD3AB4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:04:26 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s20so4282045ljp.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679745865;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m9E6tVU0VFnT2Q7zgGzmwRXtASAyx/gtsF/EXn4Spns=;
        b=PCU2wD5Qd0/Lz4JuROKWh3SkZ/W8Jbil2Cn0BOi9eN5AvIGLwqgOOObHqaRuiKxNOC
         ug0Hm7+jBXcYSGSLm49BDOrcoCo5jB5M/RT2ZMAw9dPQbRBPi68jdJt0YJrJ5jhzIxjx
         Tyox5dHdPhYIDMvT9ggesAh5ECxeTXw2n4QGi70uwE9gJRVZgYC0GsK6l5SHz8i9mBoN
         EJOdhqrWB4nko8Z+hfOhQR4i6yfIP6FJ66cwHfrdDU6KeOeK52idC62cxUzFcW5dBsLl
         6iBbw8hoc5YuB7gqLJv3eI4bvNTg0XjJqi/G6lnw2krqUrgbjlJX1//JJImNBpdgzXta
         gOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679745865;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9E6tVU0VFnT2Q7zgGzmwRXtASAyx/gtsF/EXn4Spns=;
        b=kSMInEXra43wXyqOEx/AG+37ZPra6sf779bOSo7susY5qXlJAYSBjmPSuzsDRNZAX+
         phktlend4NHqz9K3ZEWtfzvYeBqXYFIvJu/qGzTqrzhD8Sn/+osXlc3SbxGI9qO88aKN
         Vdg90YkPO1NNz5K0k9gFOrbLWyzAsHBIU4+Po/nvMdHjFTBVvQbeDc+OaMLrhgo/6XDa
         3FSL3QqFO0pI1+0vnwDubIWUx/xfh3Osl00yH5PHlQuhWkDAEXMxMSqbYg5kce4gJGCS
         iQ1nrbSA8LrgInWQYnsAtGcaAoaCRw/yYmgSWz6ohAPQOY7uhq6f0AnGQkHCPJZSs/JX
         8Tkw==
X-Gm-Message-State: AAQBX9ftY1N00yogrsnXMqbGOUM6NZQqcHZVY6Mpd0dDdbFEjScVk8ak
        eLu0ympbgWGblQiUEuZKrAiKAQ==
X-Google-Smtp-Source: AKy350ZNMrjWswnFv1AE9CKsY5hB+YGL2fpCmQUHwtqIg/e0YKTyz85YJuwnBgvV4A7E0UM8d3k1hw==
X-Received: by 2002:a2e:a175:0:b0:299:acf2:efe9 with SMTP id u21-20020a2ea175000000b00299acf2efe9mr2121519ljl.0.1679745864888;
        Sat, 25 Mar 2023 05:04:24 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f15-20020a2e9e8f000000b0029c36ebf89asm2835131ljk.112.2023.03.25.05.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:04:24 -0700 (PDT)
Message-ID: <5cf37779-49fe-ad06-d357-582129995771@linaro.org>
Date:   Sat, 25 Mar 2023 13:04:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sdm630: move DSI opp-table into DSI
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
 <20230324202244.744271-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230324202244.744271-5-krzysztof.kozlowski@linaro.org>
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



On 24.03.2023 21:22, Krzysztof Kozlowski wrote:
> The soc node is supposed to have only device nodes with MMIO addresses,
> so move the DSI OPP into the DSI controller node to fix:
> 
>   sda660-inforce-ifc6560.dtb: soc: opp-table-dsi: {'compatible': ['operating-points-v2'], ... should not be valid under {'type': 'object'}
>     From schema: dtschema/schemas/simple-bus.yaml
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Nit: you also changed its node name and didn't mention that, but I
don't see that as anything major so it's gtg as-is

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 38 ++++++++++++++--------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index 5add1951d963..ef63aa86ad67 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1450,25 +1450,6 @@ mmcc: clock-controller@c8c0000 {
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
> @@ -1610,6 +1591,25 @@ dsi0: dsi@c994000 {
>  
>  				status = "disabled";
>  
> +				dsi_opp_table: opp-table {
> +					compatible = "operating-points-v2";
> +
> +					opp-131250000 {
> +						opp-hz = /bits/ 64 <131250000>;
> +						required-opps = <&rpmpd_opp_svs>;
> +					};
> +
> +					opp-210000000 {
> +						opp-hz = /bits/ 64 <210000000>;
> +						required-opps = <&rpmpd_opp_svs_plus>;
> +					};
> +
> +					opp-262500000 {
> +						opp-hz = /bits/ 64 <262500000>;
> +						required-opps = <&rpmpd_opp_nom>;
> +					};
> +				};
> +
>  				ports {
>  					#address-cells = <1>;
>  					#size-cells = <0>;
