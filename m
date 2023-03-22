Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8796C4760
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 11:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCVKTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjCVKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 06:18:53 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC355DCAB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:18:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id o7so16430086wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679480323;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=twYsvHvBcwCGaiyh4ywZfgnIdYqfOKcSYxo4b5/XpTE=;
        b=YIz7QstvZh+wYK3/FETPzkyCigsTCLiMS4ygjqCZWxOqK1IL/BtN/SNsRpGtqZg3Mm
         +pC3QxG4Cx7RabX7NOOVBeFK0gSqaB5oQdMyZShaSQyUEOEe5hFNWg50AB1OT15lEozs
         jd6SQLRKlkBjKyveRO8fxVgwvzelhfShw2ZxgnLCCUwYacD9p+6vH0IKDvV32/H3e46E
         tLqRXO61H2Zr8VJQUJY3cziwESHfreFMEUnWKv6sxRarlhPo8oKX7DNhdG6o9uAPBDQM
         Mz67w1mue+pDsdUxYRjwr695ppYcMJn7DCcZecZ2u747TcbXnSEwLo5S0b2/TJ4dOKV0
         Knkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679480323;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twYsvHvBcwCGaiyh4ywZfgnIdYqfOKcSYxo4b5/XpTE=;
        b=Wo+KsYTA4zegTDbsY0/vIz0gzz0xM1mFDq6UTEF/JPpqFEiKKqtirYyqPohQs5R51Z
         6PqCHRCcW8CROEo5AQpFx/bZOQYI4W+f5xHy6HzOODFnvZ6ndctP5QmUlSii0dA0i35n
         zec30IcywbU5T6wdIpwm/E9Tg7PZpEcidaF4MGFZd7OOI4I7ndFLrSz1IGGfOWZdX7eb
         6BaGv0xk5uGw1PKCO3aqzPPEl2k00r3cCk4TCSJ0AP3dV4xYh//eDbMXk/E7hKJ9Ocyi
         qRjnMmJgw7pszzs46DavtAremOoE+4A+1imFlSVCMYOJG/ZSl+ko8AZ1dmInapR9+lIU
         ZHaw==
X-Gm-Message-State: AO0yUKXLoTqVSpYkQ4c++wsuyuR9WsMYgrhJzjWJyyK+xf2uTqACUyLS
        F5JX3l4lsktGc795UNu+Dg9xiQ==
X-Google-Smtp-Source: AK7set8j5M25uQP+bYkbtVX8qL/F+gQt8LfAzEW0ABz1KjS58wM/c+Ojkn+ICTRmLflr4dZ2zpj61w==
X-Received: by 2002:adf:ce11:0:b0:2d7:998c:5ad9 with SMTP id p17-20020adfce11000000b002d7998c5ad9mr4919174wrn.8.1679480323627;
        Wed, 22 Mar 2023 03:18:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:3606:a601:f273:994a? ([2a01:e0a:982:cbb0:3606:a601:f273:994a])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm13447682wrz.34.2023.03.22.03.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:18:43 -0700 (PDT)
Message-ID: <1e03050c-38d1-f9a5-aaaf-0966b143147f@linaro.org>
Date:   Wed, 22 Mar 2023 11:18:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: add crypto nodes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230322-topic-sm8450-upstream-qce-v1-1-b76eaa1824ff@linaro.org>
 <CAH=2NtwoLbjNV88DHbS27CwYA_Y-uoKAamKorhaUnany9akNWw@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAH=2NtwoLbjNV88DHbS27CwYA_Y-uoKAamKorhaUnany9akNWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2023 11:15, Bhupesh Sharma wrote:
> On Wed, 22 Mar 2023 at 15:34, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Add crypto engine (CE) and CE BAM related nodes and definitions
>> for the SM8450 SoC.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> index 7c1d1464a1f8..d7e0a1993558 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -4084,6 +4084,34 @@ ufs_mem_phy_lanes: phy@1d87400 {
>>                          };
>>                  };
>>
>> +               cryptobam: dma-controller@1dc4000 {
>> +                       compatible = "qcom,bam-v1.7.0";
> 
> This should be "qcom,bam-v1.7.4" instead, as per the HW documentation.
> Please refer to my patch here:
> https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/
> 
> So, if you want I can modify this and fold it in my overall dts
> patchset, for which I am about to send a v2:
> https://lore.kernel.org/linux-arm-msm/20230321190118.3327360-1-bhupesh.sharma@linaro.org/

Sure take it in your v2 !

Neil

> 
> Thanks,
> Bhupesh
> 
>> +                       reg = <0 0x01dc4000 0 0x28000>;
>> +                       interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
>> +                       #dma-cells = <1>;
>> +                       qcom,ee = <0>;
>> +                       qcom,controlled-remotely;
>> +                       iommus = <&apps_smmu 0x584 0x11>,
>> +                                <&apps_smmu 0x588 0x0>,
>> +                                <&apps_smmu 0x598 0x5>,
>> +                                <&apps_smmu 0x59a 0x0>,
>> +                                <&apps_smmu 0x59f 0x0>;
>> +               };
>> +
>> +               crypto: crypto@1de0000 {
>> +                       compatible = "qcom,sm8450-qce", "qcom,sm8150-qce", "qcom,qce";
>> +                       reg = <0 0x01dfa000 0 0x6000>;
>> +                       dmas = <&cryptobam 4>, <&cryptobam 5>;
>> +                       dma-names = "rx", "tx";
>> +                       iommus = <&apps_smmu 0x584 0x11>,
>> +                                <&apps_smmu 0x588 0x0>,
>> +                                <&apps_smmu 0x598 0x5>,
>> +                                <&apps_smmu 0x59a 0x0>,
>> +                                <&apps_smmu 0x59f 0x0>;
>> +                       interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
>> +                       interconnect-names = "memory";
>> +               };
>> +
>>                  sdhc_2: mmc@8804000 {
>>                          compatible = "qcom,sm8450-sdhci", "qcom,sdhci-msm-v5";
>>                          reg = <0 0x08804000 0 0x1000>;
>>
>> ---
>> base-commit: b12b871ec9079b0baefa69f8a869712682d16020
>> change-id: 20230322-topic-sm8450-upstream-qce-04daf8d81bb1
>>
>> Best regards,
>> --
>> Neil Armstrong <neil.armstrong@linaro.org>
>>

