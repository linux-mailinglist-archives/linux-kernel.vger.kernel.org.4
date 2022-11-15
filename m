Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004736297B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiKOLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKOLrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:47:32 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E6525EAD;
        Tue, 15 Nov 2022 03:47:31 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBPTx47QNzJnWW;
        Tue, 15 Nov 2022 19:44:21 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:47:29 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 19:47:28 +0800
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map symbols
 to built-in modules
To:     Nick Alcock <nick.alcock@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <masahiroy@kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <eugene.loh@oracle.com>,
        <kris.van.hees@oracle.com>, Steven Rostedt <rostedt@goodmis.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-5-nick.alcock@oracle.com>
 <Y3BhRvt53xO5A0iQ@bombadil.infradead.org> <87mt8tv554.fsf@esperi.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <76d7ba29-c7d2-d082-5928-599844112494@huawei.com>
Date:   Tue, 15 Nov 2022 19:47:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87mt8tv554.fsf@esperi.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/15 1:04, Nick Alcock wrote:
> On 13 Nov 2022, Luis Chamberlain outgrape:
> 
>> On Wed, Nov 09, 2022 at 01:41:28PM +0000, Nick Alcock wrote:
>>> The mapping consists of three new symbols
>>
>> The entire commit log does not describe *why*.
> 
> ... because it's in the other commit logs and the cover letter. I can
> repeat the motivation in this log too if you like.
> 
>> Can I also trouble you to rebase on top of modules-next [0]
> 
> Sure!
> 
>> Does the kallsyms loop more than 3 times now with Zhen Lei's work and
>> your new symbols on top on a allyesconfig build?
> 
> I don't understand the question, sorry. If this is about the number of
> KALLSYMS invocations in the kernel build, that should be unchanged by
> this patch. This was an explicit design goal because it's quite slow to
> run kallsyms more times and I was already feeling guilty about having to
> bring back the tristate recursion.
> 
> I haven't tried it with Zhen Lei's work: will try for the next
> iteration, as a matter of course after the rebase. (And, looking at the
> patch series at the top of modules-next, wow is that quite a hefty
> performance improvement. And a hefty memory usage increase :( I have a
> horrible feeling that one of my machines won't have enough memory to
> boot after this goes in, but it was terribly outdated anyway.)

It's only about 500K. It shouldn't be a problem. Your machine boot from flash?

> .
> 

-- 
Regards,
  Zhen Lei
