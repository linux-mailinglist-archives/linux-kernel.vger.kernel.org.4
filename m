Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F156893C2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjBCJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBCJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:31:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5911F92C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:31:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r27so253191wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RsIvhlNhsuqxFf9ZP6UUldQV5rhEIuniVcY9EEdflHQ=;
        b=dS9U7K4hx5+UHNLv0nbXOEx175H0lar03m9RgJtrk67LYO8KhBbp6DLmDIht4HFRou
         i+HddtcrDo1LT2wjnJ8Az4t1RBPKk3f18ghM+k1jPJ5BHJ4Wlz56SufdXNRd/mSbDX3I
         WQrwRs67You+4kPoYchd4zUH59vbnYAjqBqoir45C+7D3cPpbNy+eEyH4s3URfxc5soX
         p3NlVS7Bnj40hO02bZzwvlc6DFF3vyywR/blHFdfKQxOdO4UrrUunYD8ozM2PB7mmyaZ
         tRQNH8hLYWc0M9r0VNcwmxF3q5D6CmmQRSALwuWVnidB1wEuvtQGQcvgBK38a67OR2C/
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RsIvhlNhsuqxFf9ZP6UUldQV5rhEIuniVcY9EEdflHQ=;
        b=jDjDwEuPtGsfXvqFNAgGQzMN2XygQ1XCoJaBnXsx5fLWdJJc9JTZWmFrjImCWE6TcG
         Pea8AYY8OlAL6PmVdQRUuVpoVyByAFw4Mp4MNL7aYb+aapZD4J1R8YaRDIdLFG9rCxVL
         VZtG4g9mZzQRvLHqsQon7gLNf3yjlX+36fnHOH/oIj9k+Fzm1v1io86exVXQELOzv1hw
         tibAJFVDOEj9kEV/e7Fghv+UuHXAjJywTbRfmiT2nf/WXA6vrEAO9etFz0BqW0n1N0z4
         A4jaNjjj0FPRCpww7N3NUZ+msHq9dOhqWjQxcsRmSVWtayR1eonT7sDHaGGg2gwXf8ne
         LWgg==
X-Gm-Message-State: AO0yUKUx5q5rJq/lbY8YVi7R18oUrYwdxi3EzJMDRjXXBkhyhiRhcdfD
        xJ2GaS0L10RLTRMogGPFwoF+sg==
X-Google-Smtp-Source: AK7set9mhThVU4ZMUNjEG8Lt9BDIM9Z02zk0GC4q6tDH4m3bgoRblmm6ZN9SDVH1XSK5Yz/djY/Wfw==
X-Received: by 2002:adf:f705:0:b0:2bf:bb0a:e486 with SMTP id r5-20020adff705000000b002bfbb0ae486mr8457821wrp.30.1675416659339;
        Fri, 03 Feb 2023 01:30:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d6b83000000b002366553eca7sm1508672wrx.83.2023.02.03.01.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 01:30:58 -0800 (PST)
Message-ID: <ab9a4a7f-a8fa-fa29-95e9-941096359de1@linaro.org>
Date:   Fri, 3 Feb 2023 10:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <20230203081913.81968-4-william.qiu@starfivetech.com>
 <3c5bda9f-08b9-f2ba-6951-9fc614d4debc@linaro.org>
 <afe28108-9b85-982c-90ee-8cd58c9b6fb2@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <afe28108-9b85-982c-90ee-8cd58c9b6fb2@starfivetech.com>
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

On 03/02/2023 10:23, William Qiu wrote:
> 
> 
> On 2023/2/3 17:02, Krzysztof Kozlowski wrote:
>> On 03/02/2023 09:19, William Qiu wrote:
>>> This adds the mmc node for the StarFive JH7110 SoC.
>>
>> Do not use "This xxx". Use imperative mode.
>> https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95
>>
>>> Set mmco node to emmc and set mmc1 node to sd.
>>>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>
>>
>>> +
>>>  &gmac0_rmii_refin {
>>>  	clock-frequency = <50000000>;
>>>  };
>>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> index 64d260ea1f29..ae1a664e7af5 100644
>>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>>> @@ -370,6 +370,11 @@ syscrg: clock-controller@13020000 {
>>>  			#reset-cells = <1>;
>>>  		};
>>>  
>>> +		sysreg: syscon@13030000 {
>>> +			compatible = "starfive,sysreg", "syscon";
>>
>> No:
>> 1. Undocumented.
>> 2. A bit too generic. You should have here SoC specific compatible as
>> well (either as second or third compatible, if all your SoCs share
>> register layout).
>>
> 
> Hi Krzysztof,
> 
> As for the compatible, I will change it to "starfive,jh7110-sysreg"
> in next version,but for undocumented, I don't get it, can you
> clarify that.
> Thank you anyway.

You need bindings for it. I don't see it in linux-next, cover letter
dependencies nor here.

Best regards,
Krzysztof

