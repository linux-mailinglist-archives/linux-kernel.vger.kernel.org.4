Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADCB652107
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiLTMwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiLTMws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:52:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAA83626D;
        Tue, 20 Dec 2022 04:52:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 471EB2F4;
        Tue, 20 Dec 2022 04:53:28 -0800 (PST)
Received: from [10.57.12.116] (unknown [10.57.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AAE73F703;
        Tue, 20 Dec 2022 04:52:44 -0800 (PST)
Message-ID: <b3d98e95-8ce6-dc3b-25dd-3d23af86c7c3@arm.com>
Date:   Tue, 20 Dec 2022 12:52:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
References: <20221127141742.1644023-4-qyousef@layalina.io>
 <CAKfTPtCawKvhMwJYVUskYcX7eR2K7SziWVzvjGh6JCVB+WT5tQ@mail.gmail.com>
 <20221203143323.w32boxa6asqvvdnp@airbuntu>
 <CAKfTPtCZYGEvDBe5X1v7TiNZag0atUozGKip6EAgvZDWyo8e-g@mail.gmail.com>
 <20221205110159.nd5igwvsaj55jar7@airbuntu>
 <CAKfTPtAOhQyfyH_qRArC2SZ1sQOBnRZ4CXARiWu2fvb+KPGsXw@mail.gmail.com>
 <20221208140526.vvmjxlz6akgqyoma@airbuntu>
 <20221209164739.GA24368@vingu-book>
 <20221212184317.sntxy3h6k44oz4mo@airbuntu>
 <19bd3f60-63ea-4ccc-b5a2-6507276c8f0d@arm.com>
 <20221220115130.lhhakj36kn3opqtz@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20221220115130.lhhakj36kn3opqtz@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/22 11:51, Qais Yousef wrote:
> On 12/13/22 17:42, Lukasz Luba wrote:
>> Hi Qais,
>>
>> I thought I could help with this issue.
> 
> Thanks Lukasz!
> 
>>
>> On 12/12/22 18:43, Qais Yousef wrote:
>>> On 12/09/22 17:47, Vincent Guittot wrote:
>>>
>>> [...]
>>>

[snip]

>>
>> If you like I can develop and test such code in the arch_topology.c
> 
> As we discussed offline, Vincent is keen on decoupling the util_fits_cpu()
> logic from HMP - which means I need to reword this differently.

Fingers crossed!

> 
> Let's keep this in the back burner in case we need to revisit it again.
> 
> Appreciate the proposal!!

No worries!

Cheers,
Lukasz

> 
> 
> Many thanks
> 
> --
> Qais Yousef
