Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17926C8A29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 03:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjCYCOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 22:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCYCOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 22:14:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96CB166ED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 19:14:30 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pk2cM4kqpzSp0c;
        Sat, 25 Mar 2023 10:10:59 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 25 Mar 2023 10:14:28 +0800
Subject: Re: [PATCH 0/3] arm64: kdump : take off the protection on crashkernel
 memory region
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <John.p.donnelly@oracle.com>, <will@kernel.org>,
        <kexec@lists.infradead.org>, <ardb@kernel.org>, <rppt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230324131838.409996-1-bhe@redhat.com>
 <ZB3Zx85Ajnhzq3Pt@arm.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9ca6f729-989d-654a-83e6-c89d8f65c69d@huawei.com>
Date:   Sat, 25 Mar 2023 10:14:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ZB3Zx85Ajnhzq3Pt@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/25 1:11, Catalin Marinas wrote:
> On Fri, Mar 24, 2023 at 09:18:35PM +0800, Baoquan He wrote:
>> Baoquan He (3):
>>   arm64: kdump : take off the protection on crashkernel memory region
>>   arm64: kdump: do not map crashkernel region specifically
>>   arm64: kdump: defer the crashkernel reservation for platforms with no
>>     DMA memory zones
>>
>>  arch/arm64/include/asm/kexec.h    |  6 -----
>>  arch/arm64/include/asm/memory.h   |  5 ----
>>  arch/arm64/kernel/machine_kexec.c | 20 --------------
>>  arch/arm64/mm/init.c              |  6 +----
>>  arch/arm64/mm/mmu.c               | 43 -------------------------------
>>  5 files changed, 1 insertion(+), 79 deletions(-)
> 
> This series works for me and it has a negative diffstat as well (though
> I'm sure people will try to bring it back ;)).

After the write protection is removed, it is recommended that crc32 check
be added. However, it can be added later.

> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> .
> 

-- 
Regards,
  Zhen Lei
