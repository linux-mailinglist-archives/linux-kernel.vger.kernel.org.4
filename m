Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4D663693
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjAJBOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjAJBN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:13:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FD934764;
        Mon,  9 Jan 2023 17:13:57 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NrXpr5JsTznTWs;
        Tue, 10 Jan 2023 09:12:20 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 10 Jan 2023 09:13:53 +0800
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
To:     Nathan Chancellor <nathan@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>,
        Michael Matz <matz@suse.de>
References: <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com> <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com> <Y7dZwWsiUfHKxN3S@zn.tnic>
 <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com> <Y7lSZerjPghqllWp@zn.tnic>
 <08115444-73a3-b9b0-dbeb-2a0cf374290e@huawei.com> <Y7v/ZVTeQCw7Hv8g@zn.tnic>
 <88dbc59d-1a33-26be-7fd3-0fcdfef33b3a@huawei.com>
 <Y7xKO8IYINf9CcNI@dev-arch.thelio-3990X>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f2b54d81-f950-0e6f-5772-dcbdffa6974e@huawei.com>
Date:   Tue, 10 Jan 2023 09:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y7xKO8IYINf9CcNI@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/10 1:09, Nathan Chancellor wrote:
> On Mon, Jan 09, 2023 at 08:32:09PM +0800, Miaohe Lin wrote:
>> On 2023/1/9 19:49, Borislav Petkov wrote:
>>> On Mon, Jan 09, 2023 at 09:48:50AM +0800, Miaohe Lin wrote:
>>>> Oh, sorry, I miss-read that. My compiler is gcc-7.3.0 which contains many
>>>> in-house codes from our company in it. That might matters. Thanks a lot for
>>>> your guidance. :)
>>>
>>> Yah, next time, before you report something like that, try to reproduce it with
>>> an official compiler (gcc from the upstream repo, SUSE, Debian, RH-built etc).
>>>
>>> If it doesn't reproduce, go complain to the folks who hack your in-house
>>> compiler.
>>
>> Sorry, my bad! I thought my compiler is just as same as upstream one... Many thanks for your time.
> 
> Just for the future, in case you were not aware of it, Arnd provides
> vanilla GCC toolchains, which can be really helpful for ruling out
> (or blaming) downstream compiler patches as the cause of problems:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> You might not run into this problem again but if you do, it might save
> some time :)

That's really helpful! Many thanks for your offer. :)

Thanks,
Miaohe Lin
