Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74755BDEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiITHod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiITHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:44:07 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA0F5A16B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:42:58 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1617401pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=a3Y721ka0hYVd7uM51DN9Crk86NDtIGMZa1T45Ue6uQ=;
        b=vlVBLCSZCgCS15hXuPulXa9QYEcYwwQU9SmMrDSiiHScozSnrlb4wg32rzOoB/viTN
         Gk0+lJZ7eq/ZKCKy9J1T+yoImk2/ujyvgwtFnWaPHAcQxXN6ZI4cJaa7hXwZcEh58yGz
         zAShhEbUisBTc4yj2hguA5wHUDdhYuq0+n16918vYGSB0KiM9jLOiAjj9NMogniA5pCK
         9fbS0W4s0KKXSSxNdPW9NPj8JEukUlhjF/BUcVAnlga2/+XO9vQsdmLi4ZRQu4uF/r/h
         /oE80Fme7LeWostfnDva4uKf1XqmUAdzfwj4sv1i1onsdDw95E6E15FCKIqJq6AGPRri
         PfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=a3Y721ka0hYVd7uM51DN9Crk86NDtIGMZa1T45Ue6uQ=;
        b=Wbrq4r/DoLGbts421VVR04I+1/Yqmufay6n3vsdVlFk3uJ24AGX8JjjDa3Zgymcmbt
         twCDdYKX5aWVLlG7s0FZ1gFCHD50oY744G8ys9+PXKRyiLjO+dJ23J+Z5CfZuHbL+WtR
         SS7MqKRehec7vHZ2xqVimdy1YvOFXZh+nPRYfg4RT1i9eQGyadGBkc6JcrBKICgFyslq
         3sLfha1N+M/lIXi+M40mCv3joPINzXBfQGr5ACjMiNMl/e9oD3zbCQ5oxgltGVb5rLG1
         P3MeQZ4GiMQ4+VQol5Y4DneuMukrsitZ5YwQmzYuo6uCUkEfEMxO8JtBvvzWmm7Png3w
         fHUQ==
X-Gm-Message-State: ACrzQf16se7dOkcD5llI8kBcbV+9nz8fiKHOLDCymtcpC2pr3rHgEG3V
        wpHYH9ItgcQbLQQB3MhUv3x+C9fSCQ/xQw==
X-Google-Smtp-Source: AMsMyM6YnJmxOK0vTXnzgsxagh5YtOu227mpciepcM4Q1DmunxIVq/mQH6HUpEY/U3bGdd8MbTSzZA==
X-Received: by 2002:a17:90b:4b03:b0:202:a7e1:2c9a with SMTP id lx3-20020a17090b4b0300b00202a7e12c9amr2408397pjb.195.1663659775514;
        Tue, 20 Sep 2022 00:42:55 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e5ca00b00174ce512262sm709654plf.182.2022.09.20.00.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 00:42:55 -0700 (PDT)
Message-ID: <6bbd4f4d-d64c-0c9d-90d5-9122e6b21835@bytedance.com>
Date:   Tue, 20 Sep 2022 15:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH] sched/fair: Fix misuse of available_idle_cpu()
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
References: <20220908080702.58938-1-wuyun.abel@bytedance.com>
 <20220908103632.yzm5boxrr3nmvhpm@suse.de>
 <YxnrTdwA493gIHS8@hirez.programming.kicks-ass.net>
 <b3d2c694-e2a2-63ea-817f-113b5445dfda@bytedance.com>
Content-Language: en-US
In-Reply-To: <b3d2c694-e2a2-63ea-817f-113b5445dfda@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping :)

On 9/8/22 9:49 PM, Abel Wu wrote:
> On 9/8/22 9:17 PM, Peter Zijlstra wrote:
>> On Thu, Sep 08, 2022 at 11:36:32AM +0100, Mel Gorman wrote:
>>> On Thu, Sep 08, 2022 at 04:07:02PM +0800, Abel Wu wrote:
>>>> The function available_idle_cpu() was introduced to distinguish
>>>> between the code paths that cares if the vCPU is preempted and
>>>> the ones don't care. In general, available_idle_cpu() is used in
>>>> selecting cpus for immediate use, e.g. ttwu. While idle_cpu() is
>>>> used in the paths that only cares about the cpu is idle or not,
>>>> and __update_idle_core() is one of them.
>>>>
>>>> Use idle_cpu() instead in the idle path to make has_idle_core
>>>> a better hint.
>>>>
>>>> Fixes: 943d355d7fee (sched/core: Distinguish between idle_cpu() 
>>>> calls based on desired effect, introduce available_idle_cpu())
>>>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>>>
>>> Seems fair. As vCPU preemption is specific to virtualisation, it is very
>>> unlikely that SMT is exposed to the guest so the impact of the patch is
>>
>> Right; only pinned guests typically expose such topology information
>> (anything else would be quite broken).

Yes, and it is common in our ECS servers to use pinned guests.

>>
>>> minimal but I still think it's right so;
>>
>> I'm not convinced; all of select_idle_sibling() seems to use
>> available_idle_cpu(), and that's the only consumer of
>> __update_idle_core(), so in that respect the current state makes sense.
> 
> Hi Peter, Mel, thanks for your reviewing!
> 
> My thought was that the preempted core can become active again before
> select_idle_sibling() is called, so using available_idle_cpu() in
> __update_idle_core() can potentially lose the opportunity to kick an
> idle core running. While the downside of using idle_cpu() is that a
> full scan can be triggered irrespective of non-preempted cores exist,
> but even available_idle_cpu() can not make sure of that either.
> 
> BTW, I am also confused with select_idle_core() in which all the cpus
> of a core need to be non-preempted before the core can be taken as an
> idle core. IMHO, it might be enough that at least one cpu of an idle
> core is non-preempted and allowed by task's taskset.
