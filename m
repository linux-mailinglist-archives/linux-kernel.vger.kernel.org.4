Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DEE6E66CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjDROMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjDROMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:12:03 -0400
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E414447
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1681827117;
        bh=+208pgXfl4w8GOcDOeVQ9M2aIjRfEpbYKOHFbFJRhO4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Rh6jGuy//oolevABIxcGRlZMpxN+JO2eqp7BYjKvgTMx8izzUdjqhiixacLfMoYr2
         q9WxTbozhG7nPKcpNMWV3zNHNdsZKWfr1s2FForvrHr6vChhT3YrESahl33CrLkZNA
         ZX+D1Oe3W2P2DT2Lxzvq91aVKETK5tXtsiI+/fVA=
Received: from [192.168.31.3] ([106.92.97.36])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 2A090E66; Tue, 18 Apr 2023 22:10:32 +0800
X-QQ-mid: xmsmtpt1681827032tzluka1q7
Message-ID: <tencent_4E7390EC244A3A073385DFC6F353D50CB506@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJW0I7YIT1QWmGbIHitXLf1BNV7RnICqPq9/9qXWT8Dipf0hkokx
         mPzeFrGAP9vvsDkDwRzBUOrL7uFShkijoT1EzuC8tSSZwdT/Ncga38UbXHfAM86Snu8owSykTXfw
         oSZjzAkJQF1gqx8AUz09TC9wImHuixnBRTOTPIZd9vUFUleYqFgWxujEVjOUXvlaeKWyeQ/Jw9ys
         nSTEE6sVxMWF9VXG+n3sf/+ZiZJy0aR1Q0MKk19jdlM2UUuUdoYWhwiBy+ioxsEju5oo8BJUOc/U
         DLXTN91/hRE/iOMTfdPYnyywL4ZKom87Pp+7IDfF2p142lGkj8jsCuhdMH7s3qJNL1pMFtnZFpwR
         8ungHQqJ8TMMNT2rFOG+2m0LoYgZUD1sZrMCPs6M05MB5SJNWsP80bUT0Z578P1fZZdlTWDa6LSE
         ejzGmTxdbpZUyqHFx2XQ9Ovsv1qoXt8OzfnevnBB4NuEIYPwePsWFOSJHZfpeo7w9POgBwUhit2Y
         xCeBAk6t4lu8FCWa4sja219vLqwyMS0RQuKflM8an8178VyVuq9nHpCsPIhXyj590oQuj8wF/izB
         Jbfe5LWJ/cv6O/CKAs5XrqSUS8klA0BmqhqPOTPKAZURvAZafXlIcBgYCWigoAZP+1mnui/HGRrG
         ZBpMGkMwOWO4vREb7MI3oO5M4+nVuQrrIaR56Zut6/jFaw4yUk9PnG0v4tYPXwA58hkuUO1VEwxy
         PDPns5mHjhIZF9EEn+Q46EBxMsX/OPqF4LJR37/+ANW9TeLt5HC8kR61s8NkJq1cKmZgb3Phewrc
         4pIjA36dpFwN2Viy1sXREcz6gsw527xpnjMmtO9enpMpVDAdb0R/8Sdvncj7SBny9aeYngA2GJhj
         s5vtDThLfgDItep97+i57ZZEzD1oPC6YgwwTXQEpfSA3xuhXEsQg/BbisKAiQu6Hi4Eo47jVDMH6
         89soZiI6vBQQjBcBqC7w5m/iNFYOxtcyZbdC75/t53tfVdQiYaNUv28sfT+E/s+ZmkSdtLh8Y=
X-OQ-MSGID: <3a718c6a-328d-5da2-5843-7d552d34c111@foxmail.com>
Date:   Tue, 18 Apr 2023 22:10:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: compaction: optimize compact_memory to comply with
 the admin-guide
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        William Lam <william.lam@bytedance.com>,
        Fu Wei <wefu@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <tencent_FD958236269FD3A7996FFCF29E9BAA4EA809@qq.com>
 <20230411134801.a4aadef5aba0f51e0d44bb7a@linux-foundation.org>
 <tencent_C3E900CCD37EF2CF49553BD4AC4120932B08@qq.com>
 <tencent_100BD2639951FD669FA1AA40A89983202709@qq.com>
 <20230417111352.v26slrcmz4qo3tnn@techsingularity.net>
From:   Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20230417111352.v26slrcmz4qo3tnn@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/4/17 19:13, Mel Gorman 写道:
> On Sun, Apr 16, 2023 at 01:42:44AM +0800, Wen Yang wrote:
>> ??? 2023/4/13 00:54, Wen Yang ??????:
>>> ??? 2023/4/12 04:48, Andrew Morton ??????:
>>>> On Wed, 12 Apr 2023 02:24:26 +0800 wenyang.linux@foxmail.com wrote:
>>>>
>>>>> For the /proc/sys/vm/compact_memory file, the admin-guide states:
>>>>> When 1 is written to the file, all zones are compacted such that free
>>>>> memory is available in contiguous blocks where possible. This can be
>>>>> important for example in the allocation of huge pages although
>>>>> processes
>>>>> will also directly compact memory as required
>>>>>
>>>>> But it was not strictly followed, writing any value would cause all
>>>>> zones to be compacted. In some critical scenarios, some applications
>>>>> operating it, such as echo 0, have caused serious problems.
>>>> Really?  You mean someone actually did this and didn't observe the
>>>> effect during their testing?
>>> Thanks for your reply.
>>>
>>> Since /proc/sys/vm/compact_memory has been well documented for over a
>>> decade:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/sysctl/vm.rst#n109
>>>
>>>
>>> it is believed that only writing 1 will trigger trigger all zones to be
>>> compacted.
>>>
>>> Especially for those who write applications, they may only focus on
>>> documentation and generally do not read kernel code.  Moreover, such
>>> problems are not easily detected through testing on low pressure
>>> machines.
>>>
>>> Writing any meaningful or meaningless values will trigger it and affect
>>> the entire server:
>>>
>>> # echo 1 > /proc/sys/vm/compact_memory
>>> # echo 0 > /proc/sys/vm/compact_memory
>>> # echo dead > /proc/sys/vm/compact_memory
>>> # echo "hello world" > /proc/sys/vm/compact_memory
>>>
>>> The implementation of this high-risk operation may require following the
>>> admin-guides.
>>>
>>> -- 
>>>
>>> Best wishes,
>>>
>>> Wen
>>>
>>>
>> Hello, do you think it's better to optimize the sysctl_compaction_handler
>> code or update the admin-guide document?
>>
> Enforce the 1 on the unlikely chance that the sysctl handler is ever
> extended to do something different and expects a bitmask. The original
> intent intent of the sysctl was debugging -- demonstrating a contiguous
> allocation failure when aggressive compaction should have succeeded. Later
> some machines dedicated to batch jobs used the compaction sysctl to compact
> memory before a new job started to reduce startup latencies.
>
> Drop the justification "In some critical scenarios, some applications
> operating it, such as echo 0, have caused serious problems." from the
> changelog. I cannot imagine a sane "critical scenario" where an application
> running as root is writing expected garbage to proc or sysfs files and
> then surprised when something unexpected happens.
>
Thanks for your comments.

We will modify it according to your suggestion and then send v2.


--

Best wishes,

Wen




