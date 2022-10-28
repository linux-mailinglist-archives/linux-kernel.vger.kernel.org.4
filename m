Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70725610FC6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJ1Ldn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ1Ldj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:33:39 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65901D1E21
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:33:38 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id r19so3248617qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nOb6ixaw3sC1bMe4Tc9zgjVX+jZykKmBqY5NKZFPo8=;
        b=H0KktTz/f82EeK7JVYK1NLX88O5AqXOjZNjj2Es89tkGQ4UJ3azJ+f9BwyQYZdvvMr
         LcQvmpLzj/k+IKxQpWUmWkOnrHONVv3PBJGfA22gVRwcjCg9QBRTmLCWmHVuP4aQnwcP
         jcEiBwhS2QJ8kQdTonWRujvTLyHypht7PzVhCbSS6U/dbxcdSOmdE4ByIXXkLjc/zHCs
         LHLw5GLowijW7mOswN66zzmiQvThEf7rKJV2t9VUqmx3mGwyYkfzXObI3IE0kNpb1t+u
         GeqHRAzVxB13q6uSuT78GXXyYkU90PKUYlhrlzPLmNp9uUNk7/IHbfFDmtoqTTbDnRlo
         srvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7nOb6ixaw3sC1bMe4Tc9zgjVX+jZykKmBqY5NKZFPo8=;
        b=n6mv8/Egjz/8iCshzS4c0X0R5pk0kAB2IH8wD4aELpWTPoBrgmqtLFI8sepamy2zbk
         ivo2HHICrTqD9O1cljJplzFJHCi9WNJ+X2rpOXHAz1id6c/jTYSORX4xqA3OSWL5g9ys
         XvdpoNolaRWlMbT1dYLNoziZu2LxYN1AmG8vjY4rZMQIDkptBZeAA7/3w7HK9FPfg4vC
         xF9qsVMFGn8mGMyLMP/sE/dPr1+JtO/QIeIp2NbVH4m2As2kvBf7N7wNI3YLeaDHPPAv
         vjxMN2+nb9GeJhTpxyPB1ju+6uc4mn2z3Aad+1WWxtJ+kDWrlSzQh4Ib70OnmdWWIJi+
         NrCg==
X-Gm-Message-State: ACrzQf1ku5s1bOfevMV+KyIIQ9rj7E0UsVO3Tm9MhST35GcepgM0deUJ
        iRLWEjnQ8WzowQg5mgDyXen3SA==
X-Google-Smtp-Source: AMsMyM6jgxTjcCSH7VPVjxxayzMiZuZ73epx1TsqH9CaxqnT/E6L32qExryH01IxuSSlluCwce0RWw==
X-Received: by 2002:ac8:5f52:0:b0:39c:cb1c:9310 with SMTP id y18-20020ac85f52000000b0039ccb1c9310mr45321044qta.177.1666956817995;
        Fri, 28 Oct 2022 04:33:37 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w7-20020ac84d07000000b0039d02911555sm2227867qtv.78.2022.10.28.04.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:33:37 -0700 (PDT)
Message-ID: <a79acba3-19ff-6da4-4bbe-d5c5e455594a@linaro.org>
Date:   Fri, 28 Oct 2022 07:33:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/2] clocksource: loongson2_hpet: add hpet driver
 support
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yun Liu <liuyun@loongson.cn>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev
References: <20221026035752.32681-1-zhuyinbo@loongson.cn>
 <438f5df4-b076-4920-7bb3-095041c27eef@linaro.org>
 <9b4c904a-9277-504e-3bec-0b11331bbea4@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9b4c904a-9277-504e-3bec-0b11331bbea4@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 23:54, Yinbo Zhu wrote:
> 
> 
> 在 2022/10/26 下午10:20, Krzysztof Kozlowski 写道:
>> On 25/10/2022 23:57, Yinbo Zhu wrote:
>>> HPET (High Precision Event Timer) defines a new set of timers, which
>>> are used by the operating system to schedule threads, interrupt the
>>> kernel and interrupt the multimedia timer server. The operating
>>> system can assign different timers to different applications. By
>>> configuration, each timer can generate interrupt independently.
>>>
>>> The loongson2 HPET module includes a main count and three comparators
>>> , all of which are 32 bits wide. Among the three comparators, only
>>
>> No blank line before coma.
> You said that need blank line is need a blank space before comma?

No, I did not say that.

Best regards,
Krzysztof

