Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DBC6625AA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjAIMc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbjAIMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:32:33 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757E61CB30;
        Mon,  9 Jan 2023 04:32:12 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NrCwF6rcqzJrM7;
        Mon,  9 Jan 2023 20:30:53 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 20:32:09 +0800
Subject: Re: [BUG Report] undefined reference to `convert_to_fxsr'
To:     Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>,
        Michael Matz <matz@suse.de>
References: <Y6w49Y1d3lpv3KFn@zn.tnic>
 <23e2907c-5188-5ac6-3db8-1c5a12120bf2@huawei.com> <Y62vbjBzHF4rmh1V@zn.tnic>
 <e041533c-4005-b9bc-3985-02224985aa28@huawei.com> <Y67IlthBqaX69RwN@zn.tnic>
 <64fe1be4-954f-fe6f-44f0-59b572548663@huawei.com> <Y7dZwWsiUfHKxN3S@zn.tnic>
 <d312c572-f232-a4e9-2ecc-023050528a29@huawei.com> <Y7lSZerjPghqllWp@zn.tnic>
 <08115444-73a3-b9b0-dbeb-2a0cf374290e@huawei.com> <Y7v/ZVTeQCw7Hv8g@zn.tnic>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <88dbc59d-1a33-26be-7fd3-0fcdfef33b3a@huawei.com>
Date:   Mon, 9 Jan 2023 20:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y7v/ZVTeQCw7Hv8g@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2023/1/9 19:49, Borislav Petkov wrote:
> On Mon, Jan 09, 2023 at 09:48:50AM +0800, Miaohe Lin wrote:
>> Oh, sorry, I miss-read that. My compiler is gcc-7.3.0 which contains many
>> in-house codes from our company in it. That might matters. Thanks a lot for
>> your guidance. :)
> 
> Yah, next time, before you report something like that, try to reproduce it with
> an official compiler (gcc from the upstream repo, SUSE, Debian, RH-built etc).
> 
> If it doesn't reproduce, go complain to the folks who hack your in-house
> compiler.

Sorry, my bad! I thought my compiler is just as same as upstream one... Many thanks for your time.

Thanks,
Miaohe Lin
