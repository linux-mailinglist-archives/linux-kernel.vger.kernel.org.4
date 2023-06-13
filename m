Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0448E72EBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240662AbjFMTPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbjFMTPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:15:04 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A59122
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:15:02 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7328574e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686683700; x=1689275700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aa2mQQYrrElUf5XaPcGR3Zeoo8oJ8VByvFXaRPAmmGY=;
        b=RmEPFp3ISZCHwzHPR/zwQ6358If5C4zVKWcKOnTXwTasZFX0yhu9/RRltXGxduBmAw
         otqPWf3FHvEzibTQTvagItJrQb07yynMbTj9kZqnHWQAzWOUxalXj9cQzo40VigPZqQu
         pNhM+ZPuZGXfVbAynQGJHC3e7El7q7XNHoShXprDn+nAsAO+6IeZlEYji3xVUUcW8ujS
         mMBuyYnvtcncu7/HgACuyJBD7QTDau1SJrhJj5/Ig814dFbQGxYTqJL7wDu27reMTY05
         5ncssqOVSuNX6iUOKoX8StcKPFZbK8uy9mpIWr5Ht3UMTIjtWlRQysEKLBCNWWEBKCBB
         9m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686683700; x=1689275700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aa2mQQYrrElUf5XaPcGR3Zeoo8oJ8VByvFXaRPAmmGY=;
        b=iDwMEIxhePxxpJEjtqoio//JIcSnuoPgh6DLn3LGmx+HN2x4m1uY5Z9HmcFSfrPLKT
         jcpfzyHwGZSi7FRsdG8i/IVt5Yc3VUof0ssq0uVq14dR458PU21pOiX8yrV9IQBBDwEi
         CQncMk29Z78jYkzV5z3XzH0ouIAEYRnzwNAOs7xbPC1tbm7ODs4GVYP9QFciGT0dW64A
         MoXAiT8rFfNOsUS0Shm4zW/I3VOJqqRjIfXf5339gt08cbvqtl46igVXRM7u5hX0Ttcf
         zoUXyunW9PjlPvzjpPdU7h3twDHmf0zhxInnNSKhyrIo1got0coqoRvQE6nCbM6V0FYw
         OScQ==
X-Gm-Message-State: AC+VfDznsWG25OSyxyxjGXmAmr0QBcmlWTdowONXycTm/GhKDbsHRNi3
        HOLSpOF3scDt8Ueo9aW5KHcb6A==
X-Google-Smtp-Source: ACHHUZ5zMibbw3ZKq0jvWQ2xXL8k6Jbuzh5CmCarpsWw5z5YFHxLjiV5CTRs/tXld2xQs1SnABONTA==
X-Received: by 2002:a19:ca07:0:b0:4f5:1ca1:30d9 with SMTP id a7-20020a19ca07000000b004f51ca130d9mr6054640lfg.68.1686683700291;
        Tue, 13 Jun 2023 12:15:00 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id u1-20020ac248a1000000b004eaf41933a4sm1872207lfg.59.2023.06.13.12.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 12:14:59 -0700 (PDT)
Message-ID: <0331a3c0-e3ab-9d5e-9d9b-99db798b1c64@linaro.org>
Date:   Tue, 13 Jun 2023 21:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Fix up cluster idle states
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230613-topic-6115idlestates-v1-1-fa017052319d@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230613-topic-6115idlestates-v1-1-fa017052319d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.06.2023 21:13, Konrad Dybcio wrote:
> The lowest nibble of the PSCI suspend param denotes the CPU state.
> It was mistakenly set to mimic the cluster state, resulting in poking
> PSCI with undocumented 0x2 and 0x4 states (both of which seem to be
> implemented and undocumented). Also, GDHS cluster param was wrong for C1.
> 
> Fix that.
> 
> Fixes: b5de1a9ff1f2 ("arm64: dts: qcom: sm6115: Add CPU idle-states")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Of course I remember about the tags right after I hit send..

Reported-by: Stephan Gerhold <stephan@gerhold.net>

Konrad
>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> index 55118577bf92..07d8b842d7be 100644
> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> @@ -225,7 +225,7 @@ domain-idle-states {
>  			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
>  				/* GDHS */
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x40000022>;
> +				arm,psci-suspend-param = <0x40000023>;
>  				entry-latency-us = <360>;
>  				exit-latency-us = <421>;
>  				min-residency-us = <782>;
> @@ -234,7 +234,7 @@ CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
>  			CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
>  				/* Power Collapse */
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x41000044>;
> +				arm,psci-suspend-param = <0x41000043>;
>  				entry-latency-us = <800>;
>  				exit-latency-us = <2118>;
>  				min-residency-us = <7376>;
> @@ -243,7 +243,7 @@ CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
>  			CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
>  				/* GDHS */
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x40000042>;
> +				arm,psci-suspend-param = <0x40000023>;
>  				entry-latency-us = <314>;
>  				exit-latency-us = <345>;
>  				min-residency-us = <660>;
> @@ -252,7 +252,7 @@ CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
>  			CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
>  				/* Power Collapse */
>  				compatible = "domain-idle-state";
> -				arm,psci-suspend-param = <0x41000044>;
> +				arm,psci-suspend-param = <0x41000043>;
>  				entry-latency-us = <640>;
>  				exit-latency-us = <1654>;
>  				min-residency-us = <8094>;
> 
> ---
> base-commit: 1f6ce8392d6ff486af5ca96df9ded5882c4b6977
> change-id: 20230613-topic-6115idlestates-ba341792ebb2
> 
> Best regards,
