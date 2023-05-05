Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6836F8224
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 13:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjEELhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 07:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEELhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 07:37:45 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D5C2694
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 04:37:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QCT87573TzTkF3;
        Fri,  5 May 2023 19:33:11 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 5 May 2023 19:37:41 +0800
Message-ID: <29864a44-c548-3de9-7053-25915e7e0702@huawei.com>
Date:   Fri, 5 May 2023 19:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [Question] softlockup in run_timer_softirq
To:     John Stultz <jstultz@google.com>
CC:     Frank Woo <frankwoo@google.com>, Rhine Wu <Rhinewuwu@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <fb8d80434b2148e78c0032c6c70a8b4d@huawei.com>
 <CANDhNCqfBdh8zUd+LseTTQKpmJ27Uid+ZV_+FNckZPNc2Oy3-w@mail.gmail.com>
 <f2b7fdba4ead429bb4dd38a9ccb3735a@huawei.com>
 <CANDhNCoaMPj-aa1VKJoVawBgZWOiZpvZ5cnvVJq4F_d-miTNcA@mail.gmail.com>
 <5a334292-3e2d-9926-57ec-d52f88e1e324@huawei.com>
 <CANDhNCroULekKiCyUYMPuUe+=XVJriiJvJmC3wrhkC10Bxtt3Q@mail.gmail.com>
From:   "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <CANDhNCroULekKiCyUYMPuUe+=XVJriiJvJmC3wrhkC10Bxtt3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/4 10:59, John Stultz wrote:
> On Wed, May 3, 2023 at 6:50 PM liujian (CE) <liujian56@huawei.com> wrote:
>> On 2023/5/2 11:06, John Stultz wrote:
>>> So I wanted to revive this old thread, as Frank Woo mentioned his team
>>> has seen a similar issue as well.
>>>
>>> Liujian: I'm curious if you've made any further progress with your
>>> adapted patch ontop of PeterZ's softirq_needs_break patch series?
>>>
>> Hi John,
>>     Only the commit ("softirq, timer: Use softirq_needs_break()") is
>> added to the patchset of Peter, and no other modification is made.
>>> Might it be worth re-submitting the whole series for consideration upstream?
>>>
>> I agree very much and expect, because we often encounter similar
>> problems when doing fuzzy tests (especially when the test machine is poor).
> 
> Ok. Will you submit the series + your patch to the list for review and
> consideration then?
> 
The patch[1] has been sent out. Please help review it. Thank you very much.
[1] 
https://lore.kernel.org/lkml/20230505113315.3307723-1-liujian56@huawei.com/

> Please include Frank and Rhine on CC so they can validate and provide
> Tested-by: tags if it works for them as well.
> 
> thanks
> -john
