Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7816A148D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXBPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 20:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBXBPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:15:51 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BBBB77B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:15:48 -0800 (PST)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PNBhq4YzGzRsCc;
        Fri, 24 Feb 2023 09:12:59 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Feb 2023 09:15:45 +0800
Message-ID: <248aff47-f049-4f4f-a6ac-cf01c5d2ac61@huawei.com>
Date:   Fri, 24 Feb 2023 09:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
CC:     <mawupeng1@huawei.com>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@suse.de>,
        <toshi.kani@hp.com>, <suresh.b.siddha@intel.com>,
        <syzbot+5f488e922d047d8f00cc@syzkaller.appspotmail.com>
Subject: Re: [RFC PATCH 1/1] x86/mm/pat: Clear VM_PAT if copy_p4d_range failed
Content-Language: en-US
To:     <akpm@linux-foundation.org>
References: <20230217025615.1595558-1-mawupeng1@huawei.com>
 <20230223141412.cdf900eef1cd191895a650ed@linux-foundation.org>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20230223141412.cdf900eef1cd191895a650ed@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/24 6:14, Andrew Morton wrote:
> On Fri, 17 Feb 2023 10:56:15 +0800 Wupeng Ma <mawupeng1@huawei.com> wrote:
> 
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> x86/mm/pat: Clear VM_PAT if copy_p4d_range failed.
>>
>> Syzbot reports
> 
> Thanks.  It would be nice to have a Link: to this report - I cannot
> find that email anywhere :(

This WARN_ON_ONCE was originally reported by syz since v4.19[1] and we found that
this problem can be reproduced in v5.10 and the latest master.

[1]: https://syzkaller.appspot.com/bug?id=2ab293a84ed98e600f31dede8e082dc81be8a4fe

> 
> 
