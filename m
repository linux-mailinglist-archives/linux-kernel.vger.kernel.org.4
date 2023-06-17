Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDFC733D8A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 04:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjFQCCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 22:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFQCCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 22:02:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B36C10E
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 19:02:00 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QjfR75SydzqTbN;
        Sat, 17 Jun 2023 10:01:55 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 17 Jun 2023 10:01:57 +0800
Subject: Re: [PATCH] sched/psi: make psi_cgroups_enabled static
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <surenb@google.com>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        Tom Rix <trix@redhat.com>
References: <20230525103428.49712-1-linmiaohe@huawei.com>
 <20230525174937.GA34467@cmpxchg.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dd325d12-3d80-9b02-a8ed-3dc2606f6a0c@huawei.com>
Date:   Sat, 17 Jun 2023 10:01:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230525174937.GA34467@cmpxchg.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/26 1:49, Johannes Weiner wrote:
> On Thu, May 25, 2023 at 06:34:28PM +0800, Miaohe Lin wrote:
>> The static key psi_cgroups_enabled is only used inside file psi.c.
>> Make it static.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> This was previously submitted by Tom:
> https://lore.kernel.org/lkml/20230405163602.1939400-1-trix@redhat.com/
> 
> Peter, could you please pick this up?
> 

friendly ping.. :)

> Thanks!
> .
> 

