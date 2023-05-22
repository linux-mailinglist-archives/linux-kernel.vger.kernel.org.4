Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7D070B332
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 04:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjEVC1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 22:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEVC1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 22:27:10 -0400
Received: from out0-215.mail.aliyun.com (out0-215.mail.aliyun.com [140.205.0.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332BDBB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 19:27:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047211;MF=yanyan.yan@antgroup.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---.T8YHYxc_1684722420;
Received: from 30.177.19.150(mailfrom:yanyan.yan@antgroup.com fp:SMTPD_---.T8YHYxc_1684722420)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 10:27:01 +0800
Message-ID: <512cf22a-1196-1191-cdbb-bda3a815999d@antgroup.com>
Date:   Mon, 22 May 2023 10:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] sched/headers: remove duplicate included header
From:   "=?UTF-8?B?WWFuIFlhbihjYWlsaW5nKQ==?=" <yanyan.yan@antgroup.com>
To:     linux-kernel@vger.kernel.org, mingo@redhat.com
Cc:     "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>
References: <20230506153924.7641-1-yanyan.yan@antgroup.com>
 <f6a4ae36-9976-6727-f462-259517c8d0cb@antgroup.com>
In-Reply-To: <f6a4ae36-9976-6727-f462-259517c8d0cb@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping, any comments?

thanks,

-Yan Yan

在 2023/5/16 00:00, Yan Yan 写道:
> Ping.
>
> It seems that removing the two same included lines is ok. Because the 
> following "sched.h" also includes psi.h.
>
> Any comments?
>
> Thanks,
>
> -Yan Yan
>
> 在 2023/5/6 23:39, 晏艳(采苓) 写道:
>> linux/psi.h is included more than once.
>>
>> Signed-off-by: Yan Yan <yanyan.yan@antgroup.com>
>> ---
>>   kernel/sched/build_utility.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
>> index 99bdd96f454f..80a3df49ab47 100644
>> --- a/kernel/sched/build_utility.c
>> +++ b/kernel/sched/build_utility.c
>> @@ -34,7 +34,6 @@
>>   #include <linux/nospec.h>
>>   #include <linux/proc_fs.h>
>>   #include <linux/psi.h>
>> -#include <linux/psi.h>
>>   #include <linux/ptrace_api.h>
>>   #include <linux/sched_clock.h>
>>   #include <linux/security.h>
