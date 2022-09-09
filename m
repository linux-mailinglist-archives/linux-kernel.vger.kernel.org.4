Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3285B3D31
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbiIIQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiIIQj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:39:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0673AB3B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:39:58 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z23so2540950ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 09:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=b8J4shTOmqLPuMlpjI5MHMpXbnGy1VN3lwK2r3/fCWg=;
        b=cgZ+zfdQnVuRSEXnVgynZG2z/35sBfEiO6VSkFZ4R8EzKB+Rhnw/YTmgg/DmiXIOov
         LFG/YxMMSvMn6zvbY6w6qTcQqkE0Pm65bYDOM2met78tvoWdTgLBmCsiNoMCoFZS1nJX
         nwOR2cf6HNi9fCgOG6iMhdjWpzLOosMK7M8Z6vUc9EFL9Lqe1jI1rREL9MhEG2+xg7G1
         mLgPSPjpovUlEcvMBob63hS+dGx1KMDNast9v/OF43FEjzdpykC4ciR3ThJ1q6TVdnoF
         sGxfDtZaaFnVxpYABV0SH6+DPIpMsrm/kGR+2uG3I8yPCywpA9tGtzhzBSg17QG5X6WF
         xnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b8J4shTOmqLPuMlpjI5MHMpXbnGy1VN3lwK2r3/fCWg=;
        b=rY8uG1jWyeqRHYVpv18jvN07gbTPZIm/PHMvL8GwuQKpjScptMoCuo3IkWimQqUJpB
         rQKo+kSQG1zkQKSj/VdrBBpKuy38OPaWXK7pCVf6NJ9CkhzP1CAiqaJU8yRIQ52oO+3T
         MiOgg7LBUuJHhq5/7adSg5qdswS2U7LzZk456l3qFlkYx6/vUEhA1ow4V26/s81ovk3F
         FEtEk6r9N+WlBXBzbCtMv5QJk5r8C7vT9ROLAPVlH2JMZBrU4RzYNYf9hzKWdAKhJzXb
         zlEVXwo02tQLE/3hp1tn9ouKACyREkkH8lRKkDb/ieYEYaJbeSa+1JyhWT11mQ5sjyKB
         XrdQ==
X-Gm-Message-State: ACgBeo0VKgfGvZ8EYr+Srt4pYC1KUeArkzfZMy2UDnlVlnEs4lgyi3Dy
        Bc+R3YyZi8hKmFvg9I+Dq1nqVw==
X-Google-Smtp-Source: AA6agR4ECH9oOvbRv+1hUCn81T4aJTMXl75LUW5azwm7hSatVTuDaZm8V/Dz7cl7mDb1v0kdqZRBjA==
X-Received: by 2002:a2e:940f:0:b0:261:b9ca:6207 with SMTP id i15-20020a2e940f000000b00261b9ca6207mr4408339ljh.192.1662741596747;
        Fri, 09 Sep 2022 09:39:56 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v9-20020a05651203a900b0049476261c30sm143591lfp.113.2022.09.09.09.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 09:39:56 -0700 (PDT)
Message-ID: <36649eca-d6f5-aa48-347c-ebd2bea5096e@linaro.org>
Date:   Fri, 9 Sep 2022 18:39:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] arm64: tegra: Add PWM controllers on Tegra234
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sandipan Patra <spatra@nvidia.com>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bbasu@nvidia.com, kyarlagadda@nvidia.com
References: <20220909155258.17908-1-spatra@nvidia.com>
 <20220909155258.17908-2-spatra@nvidia.com>
 <3882e496-3082-8db3-c730-1e14554bbcf8@linaro.org>
In-Reply-To: <3882e496-3082-8db3-c730-1e14554bbcf8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 18:39, Krzysztof Kozlowski wrote:
> On 09/09/2022 17:52, Sandipan Patra wrote:
>> Tegra234 has eight single-channel PWM controllers, one of them in the
>> AON block.
>>
>> Signed-off-by: Sandipan Patra <spatra@nvidia.com>
>> ---
>> V3: Update binding doc and fix compatible property.
>>
>>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 80 +++++++++++++++++++++++-
>>  1 file changed, 78 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index 81a0f599685f..d77ee9d81fb2 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -829,8 +829,7 @@
>>  		};
>>  
>>  		pwm1: pwm@3280000 {
>> -			compatible = "nvidia,tegra194-pwm",
>> -				     "nvidia,tegra186-pwm";
>> +			compatible = "nvidia,tegra194-pwm";
> 
> Where is the fallback?

Wait, other way around. Fallback is here, but where is the Tegra234
compatible?

Best regards,
Krzysztof
