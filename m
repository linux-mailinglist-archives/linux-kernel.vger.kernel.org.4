Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623916A6577
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjCAC2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjCAC2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:28:05 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90593126FC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:39 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id oj5so7884280pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677637659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzIt3wbTz/9XBtHLwWWHYK9CTgAkORyLaB0KGnGNiLc=;
        b=EjIUwDRnA1a6932r6aOKMf7n6h4oJlYqg6SATYTTLSyWQX29LS05ngA8MFw95oEMn1
         mDReupClAyiUU8Rcog+A3a+0cRPMFEnV3Kf0UvixMqvKXq7QOxyYXA6oaClt8MGtoVhy
         II5TJ9k/oiXO7Cbkim+7lX5k6ISVoyTuFo8ccnYT1ovIzXriX2D+PeiyffmSjKZm8qk2
         LsA3NDDxfCV+vlE/Lszip9dsnp3gTeiN2dcTu7uCHewodJqMJ8Ujyy/NjM1ZS16zMLsW
         9lSFCxUEY/ON2VLYbmFMeq1e2N/V8/Ooufdc8WdlZtUv6JSw8JbxlQJWBqcfylrrtoQV
         +Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677637659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzIt3wbTz/9XBtHLwWWHYK9CTgAkORyLaB0KGnGNiLc=;
        b=heI2YFLZHvmPkrKA4+3ILCBU9/etFIx1nKUvX5wAlxZc+pqqmIdh35fdlTCWfORvjc
         byg8za+S52GUh2T13DEWtKm7aQ0Zz6kDlGsW/bWZ888yS39F8wUF/Auy//4+nBq72UcL
         ZwodcQ8QfuAEWFz26VM/c8YWLJWDCic5y7o2FjjSUw9TreP+y2z8V+Q7S5VTEzeTKJyd
         rQkPXdi+EiMP6HJ3lFfwpCIR8tVUNMB9lbEliCP6RR6KTSjTksZCPUgpgeuE/Xaj4s3g
         EWwZtiAQ9wMkvNYIQldgP84XqXeiZbwEpQU08NKixeuvuQ+TLzv2adHX0f6LtExQbN6c
         M2Vg==
X-Gm-Message-State: AO0yUKWm3aRaHk2sSr+5kEsSuiCjBwSLRTvAUw/hiEUZdc8dzTPqldHc
        PxAS4zM07XBCdqtI85vmp4DzoA==
X-Google-Smtp-Source: AK7set9Cbzz+s6yJ6WnbWOr/SHNfbMBkoysuOLyqYPr/tbC9jDxMyExGkJilBWD0WVofTCJ+qif8FQ==
X-Received: by 2002:a05:6a21:32a5:b0:cc:e439:bdad with SMTP id yt37-20020a056a2132a500b000cce439bdadmr5506262pzb.1.1677637658762;
        Tue, 28 Feb 2023 18:27:38 -0800 (PST)
Received: from [10.200.10.215] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id i194-20020a636dcb000000b004f1e73b073bsm6246368pgc.26.2023.02.28.18.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:27:38 -0800 (PST)
Message-ID: <04953598-accc-7eac-1960-94a4fed580fd@bytedance.com>
Date:   Wed, 1 Mar 2023 10:27:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v3 0/8] make slab shrink lockless
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tkhai@ya.ru,
        hannes@cmpxchg.org, shakeelb@google.com, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com,
        sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@i-love.sakura.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
 <20230226115100.7e12bda7931dd65dbabcebe3@linux-foundation.org>
 <b7e8929c-8fd5-a248-f8a8-d9177fc01b4b@bytedance.com>
 <Y/zHbhxnQ2YsP+wX@kernel.org> <Y/5KuUymvxn+QhIz@dhcp22.suse.cz>
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y/5KuUymvxn+QhIz@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/1 02:40, Michal Hocko wrote:
> On Mon 27-02-23 17:08:30, Mike Rapoport wrote:
> [...]
>> The results you present do show improvement in IPC for an artificial test
>> script. But more interesting would be to see how a real world workloads
>> benefit from your changes.
> 
> It's been quite some time ago (2018ish) when we have seen bug report
> where mount got stalled when racing with memory reclaim. This was
> nasty because the said mount was a part of login chain and users simply
> had to wait for a long time to get loged in in that particular
> deployment.
> 
> The mount was blocked on a shrinker registration and the reclaim was
> stalled in a slab shrinker IIRC. I do not remember all the details but
> the underlying problem was that a shrinker callback took a long time
> because there were too many objects to scan or it had to sync with other
> fs operation. I believe we ended up using Minchan's break out from slab
> shrinking if the shrinker semaphore was contended and that helped to
> some degree but there were still some corner cases where a single slab
> shrinker could take a noticeable amount of time.
> 
> In general using a "big" lock like shrinker_rwsem from the reclaim and
> potentially block many unrelated subsystems that just want to register
> or unregister shrinkers is a potential source of hard to predict
> problems. So this is a very welcome change.

Totally agree. :)

Thanks,
Qi
