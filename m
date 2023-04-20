Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575116E90BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjDTKqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjDTKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:45:50 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FB07297
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:45:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q21so2341550ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987507; x=1684579507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WanydDH+DUNdZ+ajUSrm6nqSv30NntmhEufY3oYv4QI=;
        b=vAuQDGuVUkXyWcadXibSo5MXWFZlw6tmeL5bqFqVONvzV152TnGynyRWQqtV0+S6+v
         lggtevKAY+OG0cFmJdESE4ZeyQcjhQRl0bFKb02l8jyvrGeNQKRLqwi1QsHMY6jiOqbP
         Z9mtTcJ1KcnNiuCN6j5MeRtMvZeG92lKYC4jzNMQvk6D+6rq61U+EIa1BJM3afuBcBGW
         L8yh/fyHAIx8NP0aAkG6k0Bs8bv/KMvMQLS6T2e50dqZwaiFnuH74IdtWF2D3tcb0sCH
         8sKxDJ9cCYKm3zlfw/uywn1OkZWwE7w695i9ARouqHf8G3QqB2Ra7pM9OvEujSugAb1K
         q7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987507; x=1684579507;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WanydDH+DUNdZ+ajUSrm6nqSv30NntmhEufY3oYv4QI=;
        b=kq8m3JXofgn1WWNxR2nL4BNwbgX8V+rwIt3zQuibNNM8kwO0OrpuMjL4oQQ5J+ZZUU
         LCLI5lakiQjj+rDFjnHE5GvFZsHHLeDQ+p5ULN7WPBHX8F4B7n4220I3APSokBYA+Ww+
         TXKO6m2/6xFuxNu9KKFeCduWfctYp4se/o0ULHhin+udKaSdgX0lp72KagmiTG9q1XsR
         WAr4lSnupuIFzgX2qmTMAdGJcCiioOLXrlr/5gY5vpiWBumswTXH7dKSbgrXQhN6pXBy
         3vKDX4bUBmC2trvGwQ4bag98T2qVij/EsQTvXkszqaXbQT2sn74d54GdGexGSZyPQlv0
         KFBQ==
X-Gm-Message-State: AAQBX9canKKaRzemczvobjDLlgEZ9y3uhrtcdEIZltIofNmfY0wetglj
        v8QL3P2jVR2lPUc7tz54q/OmzA==
X-Google-Smtp-Source: AKy350Y/MnVzrogXe61JD5piGhI0C0s+c4DKcth5haG6C6YouJq8M4agJnRMmj4KLb1mdt7R9UeTaw==
X-Received: by 2002:a2e:8917:0:b0:2a8:ccd3:4c40 with SMTP id d23-20020a2e8917000000b002a8ccd34c40mr445460lji.13.1681987506892;
        Thu, 20 Apr 2023 03:45:06 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q4-20020a2e84c4000000b002a9ee18e9c7sm41553ljh.69.2023.04.20.03.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:45:06 -0700 (PDT)
Message-ID: <29f018cd-8843-c85c-437e-c7ab422e1a0c@linaro.org>
Date:   Thu, 20 Apr 2023 12:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sm6125: add unit address to soc
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
 <20230420063610.11068-7-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420063610.11068-7-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.04.2023 08:36, Krzysztof Kozlowski wrote:
> "soc" node is supposed to have unit address:
> 
> Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 9484752fb850..745874a82a49 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -364,7 +364,7 @@ smem: smem {
>  		hwlocks = <&tcsr_mutex 3>;
>  	};
>  
> -	soc {
> +	soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x00 0x00 0x00 0xffffffff>;
