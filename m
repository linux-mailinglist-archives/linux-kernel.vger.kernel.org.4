Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0415637143
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiKXDuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiKXDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:50:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD20716E8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:50:22 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 130so551084pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3Onlv0MNZPE3hjfbG2klxF4G7Qt2hPBKoZUVUP0sR8=;
        b=AYxSNFh9I1HS5BbkgYpIhswQVFxLsKEAT1xqaIWGzHle5ajqgpUFzm6pydkKN1rg/0
         DZohE8tKymtMUFum31+ve1ZJ8YDWpPPFanUyJEPJYSJeLxVb09XkFtFVC+tSh3yGjm0M
         Dx52E7QK6N47XLBcSbRmIIKfs3jCTWdYiS5wP93vJDYjTYM63gGA7FxKaPwouS19NkoK
         zv4+x8yz3bk12aYraJmJelXkEpaXoaYcQO32Rw0RmOWFTCDAR1lh89r1brVEJSG18Ysr
         cMTFto8vVIBwYVOCBMrYAtt/ISErrvpMeZDl955LHyfnFfvh4b52eDSgBCxoFDow65o8
         SAvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3Onlv0MNZPE3hjfbG2klxF4G7Qt2hPBKoZUVUP0sR8=;
        b=RdgXZIg0O2Z0ycfWej4z6sGzN8puf9UZ261NwEinz90mHUhMzFV0TBc5+2N1Dm+dbX
         zTy3tzllQERGneGnRxR5idF2lL6Kv1AUDFPYDg3Tv5O8LoIOYSzIXNNHryDL4x/sgo73
         Nve4y0wCelhkv+Eby9WfhUCphfGeRE7EwJ2cv88/h6e8KGyOKDiqncIvhgXRQxiTII1Z
         LSj3GJBjdP7uf4E34anWGq/4e42Nm2k8TNh0gGy8lUsmkzwNFPucqOyH5jt/MlY/ibua
         2ORYMQ6Ky1kSQ8nG8kpXDi7+WgBfRve3d57lQArToKgEA/r4kcoNwwhQJ+P2o3d1RfTW
         AY3Q==
X-Gm-Message-State: ANoB5pkpM8v3rQb8iskqI69X/wj8n6jQcSie2HSzwuNJXOqpO/OdDDm9
        CGh6Ox27ocHtrJnIAb4dZdHZZA==
X-Google-Smtp-Source: AA0mqf6F64SLChnrUznIwXPN8B2ObUHHIs1mh5meDBJOIxhLsGW0tjZ2CLTOVGLZb7CU2tLEhqbjKg==
X-Received: by 2002:a63:1859:0:b0:476:c9bd:c0d9 with SMTP id 25-20020a631859000000b00476c9bdc0d9mr10153770pgy.415.1669261821766;
        Wed, 23 Nov 2022 19:50:21 -0800 (PST)
Received: from [10.255.21.168] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902bd8800b00174f7d10a03sm15108915pls.86.2022.11.23.19.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 19:50:21 -0800 (PST)
Message-ID: <02890ec6-b7dc-e0cd-4797-d5343d42361c@bytedance.com>
Date:   Thu, 24 Nov 2022 11:50:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v6 0/4] sched/fair: Improve scan efficiency of SIS
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <c7c5a654-8d26-28d9-7b33-e7b2b7bf2401@amd.com>
 <2a049755-57cb-4943-0850-cbbf2537c97e@bytedance.com>
 <906747ff-148c-f058-dc94-7a9225125f52@amd.com>
 <b8eb593a-cde9-bb23-2092-6b563ce814c8@amd.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <b8eb593a-cde9-bb23-2092-6b563ce814c8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek, thanks again for your detailed test!

On 11/22/22 7:28 PM, K Prateek Nayak wrote:
> Hello Abel,
> 
> Following are the results for hackbench with larger number of
> groups, ycsb-mongodb, Spec-JBB, and unixbench. Apart for
> a regression in unixbench spawn in NPS2 and NPS4 mode and
> unixbench syscall in NPs2 mode, everything looks good.
> 
> ...
> 
> -> unixbench-syscall
> 
> o NPS4
> 
> kernel:                             tip                  sis_core
> Min       unixbench-syscall-1    2971799.80 (   0.00%)  2979335.60 (  -0.25%)
> Min       unixbench-syscall-512  7824196.90 (   0.00%)  8155610.20 (  -4.24%)
> Amean     unixbench-syscall-1    2973045.43 (   0.00%)  2982036.13 *  -0.30%*
> Amean     unixbench-syscall-512  7826302.17 (   0.00%)  8173026.57 *  -4.43%*   <-- Regression in syscall for larger worker count
> CoeffVar  unixbench-syscall-1          0.04 (   0.00%)        0.09 (-139.63%)
> CoeffVar  unixbench-syscall-512        0.03 (   0.00%)        0.20 (-701.13%)
> 
> 
> -> unixbench-spawn
> 
> o NPS1
> 
> kernel:                             tip                  sis_core
> Min       unixbench-spawn-1       6536.50 (   0.00%)     6000.30 (  -8.20%)
> Min       unixbench-spawn-512    72571.40 (   0.00%)    70829.60 (  -2.40%)
> Hmean     unixbench-spawn-1       6811.16 (   0.00%)     7016.11 (   3.01%)
> Hmean     unixbench-spawn-512    72801.77 (   0.00%)    71012.03 *  -2.46%*
> CoeffVar  unixbench-spawn-1          3.69 (   0.00%)       13.52 (-266.69%)
> CoeffVar  unixbench-spawn-512        0.27 (   0.00%)        0.22 (  18.25%)
> 
> o NPS2
> 
> kernel:                             tip                  sis_core
> Min       unixbench-spawn-1       7042.20 (   0.00%)     7078.70 (   0.52%)
> Min       unixbench-spawn-512    85571.60 (   0.00%)    77362.60 (  -9.59%)
> Hmean     unixbench-spawn-1       7199.01 (   0.00%)     7276.55 (   1.08%)
> Hmean     unixbench-spawn-512    85717.77 (   0.00%)    77923.73 *  -9.09%*     <-- Regression in spawn test for larger worker count
> CoeffVar  unixbench-spawn-1          3.50 (   0.00%)        3.30 (   5.70%)
> CoeffVar  unixbench-spawn-512        0.20 (   0.00%)        0.82 (-304.88%)
> 
> o NPS4
> 
> kernel:                             tip                  sis_core
> Min       unixbench-spawn-1       7521.90 (   0.00%)     8102.80 (   7.72%)
> Min       unixbench-spawn-512    84245.70 (   0.00%)    73074.50 ( -13.26%)
> Hmean     unixbench-spawn-1       7659.12 (   0.00%)     8645.19 *  12.87%*
> Hmean     unixbench-spawn-512    84908.77 (   0.00%)    73409.49 * -13.54%*     <-- Regression in spawn test for larger worker count
> CoeffVar  unixbench-spawn-1          1.92 (   0.00%)        5.78 (-200.56%)
> CoeffVar  unixbench-spawn-512        0.76 (   0.00%)        0.41 (  46.58%)
> 
> ...
> 
> For unixbench regressions, I do not see anything obvious jump up
> in perf traces captureed with IBS. top shows over 99% utilization
> which would ideally mean there are not many updates to the mask.
> I'll take some more look at the spawn test case and get back to you.

These regressions seems to be common in full parallel tests. I
guess it might be due to over updating the idle cpumask when LLC
is overloaded which is not necessary if SIS_UTIL enabled, but I
need to dig it further. Maybe the rq avg_idle or nr_idle_scan need
to be taken into consideration as well. Thanks for providing these
important information.

> 
> ~~~~~~~~~~~~~
> ~ Hackbench ~
> ~~~~~~~~~~~~~
> 
> $ perf bench sched messaging -p -l 50000 -g <groups>
> 
> o NPS1
> 
> kernel:               tip                     sis_core
> 32-groups:         6.20 (0.00 pct)         5.86 (5.48 pct)
> 64-groups:        16.55 (0.00 pct)        15.21 (8.09 pct)
> 128-groups:       42.57 (0.00 pct)        34.63 (18.65 pct)
> 256-groups:       71.69 (0.00 pct)        67.11 (6.38 pct)
> 512-groups:      108.48 (0.00 pct)       110.23 (-1.61 pct)
> 
> o NPS2
> 
> kernel:                tip                     sis_core
> 32-groups:         6.56 (0.00 pct)         5.60 (14.63 pct)
> 64-groups:        15.74 (0.00 pct)        14.45 (8.19 pct)
> 128-groups:       39.93 (0.00 pct)        35.33 (11.52 pct)
> 256-groups:       74.49 (0.00 pct)        69.65 (6.49 pct)
> 512-groups:      112.22 (0.00 pct)       113.75 (-1.36 pct)
> 
> o NPS4:
> 
> kernel:               tip                     sis_core
> 32-groups:         9.48 (0.00 pct)         5.64 (40.50 pct)
> 64-groups:        15.38 (0.00 pct)        14.13 (8.12 pct)
> 128-groups:       39.93 (0.00 pct)        34.47 (13.67 pct)
> 256-groups:       75.31 (0.00 pct)        67.98 (9.73 pct)
> 512-groups:      115.37 (0.00 pct)       111.15 (3.65 pct)
> 
> Note: Hackbench with 32-groups show run to run variation
> on tip but is more stable with sis_core. Hackbench for
> 64-groups and beyond is stable on both kernels.
> 
The result is consistent with mine except 512-groups which I
didn't test. The 512-groups test may have the same problem
aforementioned.

Thanks & Regards,
	Abel
