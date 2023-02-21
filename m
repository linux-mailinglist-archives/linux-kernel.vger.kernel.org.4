Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C9969E63E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbjBURr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjBURrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:47:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CA62F798
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:47:15 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id s20so6482970lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kk6hjQZz8Uy7y6FCGmQtmN0QqqwvaG8ovqwa+KbuB9M=;
        b=rJteYuJmxbm8wgLTmhQECO6DpNR4AcEXaVqveYiBOXmlm+xT7DSe+J00tgRJKya0AG
         y9FW8a1uhkAYLmFGiwjpkYlqGE4qfLmvS5ScfJGN11i7+rMOa1oZODYYvl+ipgzcBPTe
         uVIP9FPIEdDFIG/vJBTDgHjnUecfWyXlnf9bZ7kaWVJNB59GW6inB434C1HO8TNBNz45
         xYKxN2zcQYfOyLC+bohMaKBo5A1uMlC6Ywy5iAAzdnTZmbgpSieXLX/aoecwn12niDkI
         qKoHtPT3MlTSyXWX5frggBcyaozBBlHuHUMvBFJ49QQ2nobIXtE8pF9nevIz1p2HLm9B
         UYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kk6hjQZz8Uy7y6FCGmQtmN0QqqwvaG8ovqwa+KbuB9M=;
        b=KwAN3q4DfzwA42FTqBY6fp3YYg7FFstFyo4Gn+ZnlypPJu23SM7gdEdc3CCsx+AU8z
         E17Txk4CzT6AwFnIQdRRiAMgB+jKpwqC1s55Y6PzL9kgSm8VTaXB4HL5WpWbmN/l9BJZ
         qq/+GCaJJtB13Co87cG9ViN9tXhm+zqNHOeNJdFo5jQ6wjSI71So9WkqtIbM2YF8RFKc
         BbIA4ABySC09UtrknCGoKeJqzeA5JQsZpCHzIBb2S+D5u9qTrHWUfz9MIEoMg6wAuOHU
         /Vtc9BEqWn+0JBJQDX7/EQEAFyLNaypOSGtmQnPlzCvkkqv24gax5ij1wDeizPH3xIIq
         2Q3Q==
X-Gm-Message-State: AO0yUKVlTI3j08dH1xkebmNj1dbcMl4CRAgjMTxcX9ODbCuIvIKon8/Q
        nZaxymZnRW6WfNk8eXQ7iCFrcw==
X-Google-Smtp-Source: AK7set/OfDblZck8LghxLTQ1eT1C4BD3yjGqtD/TCSA4IxSrlDe69jjvyDAtWl0CXcRCOt7hYoTv+A==
X-Received: by 2002:ac2:5391:0:b0:4dd:995b:e5ef with SMTP id g17-20020ac25391000000b004dd995be5efmr26616lfh.47.1677001634013;
        Tue, 21 Feb 2023 09:47:14 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id c22-20020ac25316000000b004db3e445f1fsm611983lfh.97.2023.02.21.09.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 09:47:13 -0800 (PST)
Message-ID: <82f86391-15dc-3613-e4ce-cdeb1ee49fd8@linaro.org>
Date:   Tue, 21 Feb 2023 18:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sm8450: Add IMEM and PIL info
 region
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, elder@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1676986616-21378-1-git-send-email-quic_mojha@quicinc.com>
 <1676986616-21378-2-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1676986616-21378-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2023 14:36, Mukesh Ojha wrote:
> Add a simple-mfd representing IMEM on SM8450 and define the PIL
> relocation info region, so that post mortem tools will be able
> to locate the loaded remoteprocs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>  -  put ranges after regs and corrected the sram node position.
> 
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 1a744a3..2a4f4ac 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -3814,6 +3814,20 @@
>  			};
>  		};
>  
> +		sram@146aa000 {
Looks like it's not sorted properly? Should be between
TLMM and apss_smmu address-wise.

Konrad
> +			compatible = "qcom,sm8450-imem", "syscon", "simple-mfd";
> +			reg = <0 0x146aa000 0 0x1000>;
> +			ranges = <0 0 0x146aa000 0x1000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			pil-reloc@94c {
> +				compatible = "qcom,pil-reloc-info";
> +				reg = <0x94c 0xc8>;
> +			};
> +		};
> +
>  		timer@17420000 {
>  			compatible = "arm,armv7-timer-mem";
>  			#address-cells = <1>;
