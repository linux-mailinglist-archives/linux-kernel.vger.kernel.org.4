Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1C6E90B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjDTKqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjDTKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:45:38 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44C6593
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:44:51 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z38so2200621ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987485; x=1684579485;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NDBPC0wFbIKsQZoWPfEGX6WRQ9xiDvkTL2ZeFIPvDFU=;
        b=yx5Px9buDqqDr8xmNx8GdBHiGDEU/l1BTjG92tiK7sqhS55CarAwXYM7qe7Lgs6WCD
         Y6bnL97yQejv5aU+ppQYqhfYUU5sAz8Soo2rZxleh4sz74IU6hbyY1ns14btT9Bq8Ubd
         kKNJWRp4/azZ/OVnU4J065sBnfvdjETg201seJJ0IxFwYZOFCCw2EBocrMa9xw28rOio
         8Ymh7taR/bm8SqRD2ZW8jAwce2YcGzJsVYkfeKwFCCfKHegeeh52pAWpEbZFu/4kqCOu
         HUg1Y98ImyD3FDQwA56OkQEkTCwtOtcCvxE3HXP8cQUJWWhRNyykHevafrqXbNK1WClB
         fHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987485; x=1684579485;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDBPC0wFbIKsQZoWPfEGX6WRQ9xiDvkTL2ZeFIPvDFU=;
        b=khVz8yS/e6/3Awml1jUjZWndP3l+QImUHEYuX6+CZ8e/lhtkNxU/Iu4eSoW4ieQHwz
         LGDpZr5Q0TYnwPlib8DMME09GqycrBiRhNc+BNgmUZ8EpksP7brltGHoFSzIGVxCQ75r
         23fXszuezrYYhGQheBwBNQ1OC+y/SsFxcjoKIpcCANNWiGpQiFABG2ahiIyJZxjRZfNn
         rKcFbdPvXzwx6jc6XPOctjAu2B45++NBNyr7NxCW6IeCnRO8oqi/2ghTpyWawEArzmLI
         sYiCEqPV3f9UjKQgEtzVmdHUkGr1MOvYwWJYwWDSjFg8/WycLJRaHYT0mlFi4nnsuG5C
         hWVQ==
X-Gm-Message-State: AAQBX9fUDmKBchzr5rzui/qBInQlmSxA7wWjHUZ4M/g3WothJaS+DNu6
        ArH5mIjo8/dkCITbfDSJ95klxQ==
X-Google-Smtp-Source: AKy350ZTq7qKInAOLfLcX8kHRmTOTrLc9qohA100GDKDhXYRx4ykIgV2vU4JhA69z+cJ1l+Dmcpz6g==
X-Received: by 2002:a2e:9c1a:0:b0:2a9:f1bd:5711 with SMTP id s26-20020a2e9c1a000000b002a9f1bd5711mr335955lji.27.1681987485523;
        Thu, 20 Apr 2023 03:44:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e7d14000000b002a9ed7f6f90sm194087ljc.73.2023.04.20.03.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:44:45 -0700 (PDT)
Message-ID: <aecfb100-9ed8-8d41-d6ec-dfe192fcb0a6@linaro.org>
Date:   Thu, 20 Apr 2023 12:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/7] arm64: dts: qcom: msm8996: add unit address to soc
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
 <20230420063610.11068-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420063610.11068-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 08:36, Krzysztof Kozlowski wrote:
> "soc" node is supposed to have unit address:
> 
>   Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index f0114e4fdd37..8a40c4b0f94c 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -604,7 +604,7 @@ slpi_smp2p_in: slave-kernel {
>  		};
>  	};
>  
> -	soc: soc {
> +	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
