Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81BE64D330
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLNXUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiLNXUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:20:16 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350F49B69
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:20:15 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j16so3852585qtv.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YkM/Iff/QbQ/InXq7hZ2Efj08BplZeo5uzvhcT7KPiI=;
        b=G32bFLIB4BgNoP3Ez7x37bgZSilfMXRIulPy5+BBcYVOk74wKiG4U4wzU0mXbPRJQ0
         kty/1/8oWm8FryQ7uCkIJV5fo9SENf4EiAXZbxMyFwGf0QkoRElnjf0w981LsSYQQc8T
         oi4PkSDFk8jW5vur26Hle0xrzaiG2pxDTVTKz9jDtYcWZ4IJRtpLXW3jNJMl0Bq6L5l5
         XW74qw5BCqFvqL8OgAvvQtjUA//dBHIWMIBbJTOaO4SXc/M37srrbbpfhQhEuGTvHA12
         37y1wu1Z7AfOdx2gpQ4xO2X9v/kJFbpORI7bDkCWQFEoVV9N1osP/9Bbu903De89EUU7
         zhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkM/Iff/QbQ/InXq7hZ2Efj08BplZeo5uzvhcT7KPiI=;
        b=5XQtle+mOfAKr69efjCTBn1NdsNZpJPryzBoJLyhYFY0i0wK6S5gslFpO8KGrFq8Kt
         3j8WyUyeeySHofyr+Nv4eK7Wth4YEtjPqPkpYsU/HpAwSxgq0VBZrPCz/MxdhYy95Buj
         EVTl14p7F4QzFgkOPswTCErI5Kf4rWh9EsTQUdFGPGBfpQ4YyqglHjfaCxUEk144uo9T
         33Y50Iw+W7Dvp/WiDHH+xl6UF4vRQOVZuYEKCabCeIXBaWZ1Wo2uCtCAunDWrQ/2ORaq
         dS5+A8sbZsLh0z2uJGX7kiKEQXzz1kBkPeBdFggkzd40NbmHR5pRBA1fNk7EzFKKbapG
         Lz6A==
X-Gm-Message-State: ANoB5pnKdd/DI5YRq6RQHvI+X9S4bRJkCRt/ckvG7WuDArWcy/aVk4br
        fiCZyg2+LxRf4Ozsb+ive0oruA==
X-Google-Smtp-Source: AA0mqf7csRfyj6YQsK617BhRyMQfIlB5T5cldKuKLzhcjEgHl3rlVHSyZlcDwlHjSjyEf8129VgaVQ==
X-Received: by 2002:a05:622a:1e8e:b0:39c:da21:6b7c with SMTP id bz14-20020a05622a1e8e00b0039cda216b7cmr40047063qtb.1.1671060014498;
        Wed, 14 Dec 2022 15:20:14 -0800 (PST)
Received: from [192.168.1.31] (d-216-10-177-134.nh.cpe.atlanticbb.net. [216.10.177.134])
        by smtp.gmail.com with ESMTPSA id b15-20020ac8678f000000b003a50b9f099esm2448961qtp.12.2022.12.14.15.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 15:20:13 -0800 (PST)
Message-ID: <4984b4f5-7bc5-6109-2523-77265141b3d2@google.com>
Date:   Wed, 14 Dec 2022 18:20:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCHSET RFC] sched: Implement BPF extensible scheduler class
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Don <joshdon@google.com>, torvalds@linux-foundation.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
        riel@surriel.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@meta.com
References: <20221130082313.3241517-1-tj@kernel.org>
 <Y5b++AttvjzyTTJV@hirez.programming.kicks-ass.net>
 <CABk29Ntf1ZMAmvkVTzj6=HjanHgn6Qu3-J8gHHyMM30yiHM3_w@mail.gmail.com>
 <Y5mPigH1bPatXNeB@hirez.programming.kicks-ass.net>
 <Y5pM0ralEr6coT25@slm.duckdns.org>
From:   Barret Rhoden <brho@google.com>
In-Reply-To: <Y5pM0ralEr6coT25@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/22 17:23, Tejun Heo wrote:
> Google guys probably have a lot to say here too and there may be many
> commonalties, but here's how things are on our end.

your email pretty much captures my experiences from the google side.  in 
fact, i think i'll save it for the next time someone asks me to 
summarize the challenges with both kernel rollouts and testing changes 
on workloads.  =)

>> I was given to believe this was a fairly rapid process.
> 
> Going back to the first phase where we're experimenting in a more controlled
> environment. Yes, that is a faster process but only in comparison to the
> second phase. Some controlled experiments, the faster ones, usually take
> several hours to obtain a meaningful result. It just takes a while for
> production workloads to start, jit-compile all the hot code paths, warm up
> caches and so on. Others, unfortunately, take a lot longer to ramp up to the
> degree whether it can be compared against production numbers. Some of the
> benchmarks stretch multiple days.
> 
> With SCX, we can keep just keep hotswapping and tuning the scheduler
> behavior getting results in tens of minutes instead of multiple hours and
> without worrying about crashing the test machines

for testing sched policies on one of our bigger apps, the O(hours) 
kernel reboot vs O(minutes) reload of a BPF scheduler is a pain.  but 
that's only for a single machine; it can be much worse on a full cluster.

full-cluster tests are a different beast.  we are one of many groups 
that want to do testing, and we have to reserve a time on their cluster. 
  but to change the kernel, it actually took us weeks to coordinate an 
kernel change on the app's large testing cluster - essentially since we 
were using an unqualified kernel, we 'blocked' all of the other testing.

> it's way easier and faster to have a running test environment setup and
> iterate through scheduling behavior changes without worrying about crashing
> the machine than having to cycle and re-setup test setup for each iteration.

i'm a newcomer to BPF, but for me the "interaction with live machine" is 
a major BPF feature, both in SCX and also more broadly with the various 
tracing tools and other BPF uses.  (not to mention the per-workload or 
per-machine customization that BPF enables, but that's a separate 
discussion).

thanks,

barret


