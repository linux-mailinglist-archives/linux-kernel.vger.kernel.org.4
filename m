Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C874629ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbiKONlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238442AbiKONk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:40:56 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439F186D4;
        Tue, 15 Nov 2022 05:40:53 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NBS406tV1zRpHQ;
        Tue, 15 Nov 2022 21:40:32 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:40:51 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 21:40:50 +0800
Subject: Re: [PATCH v3 0/2] arm64: kdump: Function supplement and performance
 optimization
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        "Dave Kleikamp" <dave.kleikamp@oracle.com>
References: <20220711090319.1604-1-thunder.leizhen@huawei.com>
 <20221115115837.GE32523@willie-the-truck>
 <6c1751be-9957-0765-5e68-2eb78adc9a94@huawei.com> <Y3OUc1N7Kif1pnZv@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <39839221-8567-39ad-dade-8d1500df2e8b@huawei.com>
Date:   Tue, 15 Nov 2022 21:40:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y3OUc1N7Kif1pnZv@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/11/15 21:30, Catalin Marinas wrote:
> On Tue, Nov 15, 2022 at 08:18:21PM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/11/15 19:58, Will Deacon wrote:
>>> On Mon, Jul 11, 2022 at 05:03:17PM +0800, Zhen Lei wrote:
>>>> v2 --> v3:
>>>> 1. Discard patch 3 in v2, a cleanup patch.
>>>
>>> Do you plan to respin this series, addressing the various comments on v3?
>>
>> Yes, I haven't figured out where to make DEFAULT_CRASH_KERNEL_LOW_SIZE generic.
> 
> Do we need to? I'd just go with something like 128MB, specific to arm64,
> and we can increase it later if anyone comes up with a good argument.

Okay, then v3's easy. I'll do it tomorrow. I've tried it before. 128M is enough.

> 

-- 
Regards,
  Zhen Lei
