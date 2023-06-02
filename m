Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0D71FCCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbjFBI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjFBIzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:55:39 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B051722
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:54:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4f89f71b8so2402688e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696071; x=1688288071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/K5d07Ai5xBTSHj+4m9+Mu0PCCcMTAitKgXkZjqnoo=;
        b=v3Y9MWXvJoO2KFDBFAr9XfYehYzj+8qojfNEHgk7w4BJ2Ve0lPt7IcPZBstjJNmRGl
         oFSaSjRlnK1M3XkvgMrGRFJY5AqvSTOtPUQoJOjtq47vK7zBkxsGUEDklEU1DIvt8rTN
         99Y7DykZMADbznsAoOwdwZni6005w6Ej3dBigtfP9utbU4OqVm7BnRfSscGT7jEqPMmj
         jfvD5Ai6efUas/1aFSfHoagUT+BxUXOvbX/aHH9d3ZKWfPu4xwFxi8p0+gxtl+QWrn77
         nmuPO2ToL/CnCas5nna/L9VpcZBoR1TWjU2bpu9CBt8bsE1J53l4EO4ZrmNy7VbG05zo
         vf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696071; x=1688288071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/K5d07Ai5xBTSHj+4m9+Mu0PCCcMTAitKgXkZjqnoo=;
        b=CuSzm/mjhZ7iqwLZLEGk3RfhsEGAgyh6g/AapPxNPft+/tpnB+1gsalPeynZeJCYuV
         jWr5st7UPQd1vXMHU+B1iVX/SW58LC3qbKEBCd7pTO/qVFuXOkRHVJ2eqbVToIGJaGiJ
         FvIQ1tIlbVBg29jAZhKayb52o6j9Tk0cHl0ENSjfj0+8L1XziLtEHvOUxkBOe5Y6T53Y
         l5sJ49mYYkI313g1WxRru+vSDpJajdKVel0RdhnCB1YLM2R610w5Cw0b2IvqNGqT4YIn
         2l08NSLUPzMSOtyrLN+8lZm21c9fBhyvoJoCNmXC5P+yHd4sprLKA8/RINLRjd1i+lm5
         kllw==
X-Gm-Message-State: AC+VfDxUPxf2m0d0shmP8RtxjjIAG/KdBOuPU3DAiZAHkh6MOTsYP2YN
        pU/n1Su0PQ8o/LbPuRi0Jkia3w==
X-Google-Smtp-Source: ACHHUZ5FsE78Qq21/c3s1WU+/VE5y4o6fVrH9MjwLufB6XedwCo/HmrIrTOSLq7FTIVr5E3cg23C9Q==
X-Received: by 2002:ac2:518f:0:b0:4f3:aa73:562 with SMTP id u15-20020ac2518f000000b004f3aa730562mr1505757lfi.2.1685696071078;
        Fri, 02 Jun 2023 01:54:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c24-20020ac25318000000b004eefdd8b37fsm94626lfh.194.2023.06.02.01.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:54:30 -0700 (PDT)
Message-ID: <ab8d7a2d-e2db-39cd-dbac-bb5535cb8c19@linaro.org>
Date:   Fri, 2 Jun 2023 10:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     rafael@kernel.org, ilia.lin@kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ansuelsmth@gmail.com
References: <20230530165409.641661-1-robimarko@gmail.com>
 <20230602041327.klyjs4cevmzn6vs7@vireshk-i7>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230602041327.klyjs4cevmzn6vs7@vireshk-i7>
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



On 2.06.2023 06:13, Viresh Kumar wrote:
> On 30-05-23, 18:54, Robert Marko wrote:
>> IPQ8074 comes in 2 families:
>> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
>> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
>>
>> So, in order to be able to share one OPP table lets add support for IPQ8074
>> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
>>
>> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
>> will get created by NVMEM CPUFreq driver.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> 
> I am waiting for someone from Qcom to review this stuff.
We're on v2 and it looks like there will be a v3

https://lore.kernel.org/linux-arm-msm/20230530165807.642084-1-robimarko@gmail.com/

Konrad
> 
