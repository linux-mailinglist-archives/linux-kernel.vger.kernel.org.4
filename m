Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4075E8B6C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiIXKS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiIXKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:18:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE86112655
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 03:18:23 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MZPxt2s1jzlXLM;
        Sat, 24 Sep 2022 18:14:10 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:18:21 +0800
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 18:18:20 +0800
Message-ID: <b02f72c5-636d-2d4f-98d7-bf3741e38e5d@huawei.com>
Date:   Sat, 24 Sep 2022 18:18:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH -next] x86/sev: Remove unused variable "err" in
 enforce_vmpl0()
To:     Borislav Petkov <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <brijesh.singh@amd.com>, <michael.roth@amd.com>,
        <venu.busireddy@oracle.com>, <linux-kernel@vger.kernel.org>
References: <20220923113209.3046960-1-lizetao1@huawei.com>
 <Yy2kU7lZuArVMC5p@zn.tnic>
From:   Li Zetao <lizetao1@huawei.com>
In-Reply-To: <Yy2kU7lZuArVMC5p@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.176]
X-ClientProxiedBy: dggpeml100009.china.huawei.com (7.185.36.95) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/23 20:19, Borislav Petkov wrote:

> On Fri, Sep 23, 2022 at 11:32:09AM +0000, Li Zetao wrote:
>> Gcc report warning as follows:
>>
>> arch/x86/boot/compressed/sev.c: In function ‘enforce_vmpl0’:
>> arch/x86/boot/compressed/sev.c:256:13: error: unused variable ‘err’
>>   [-Werror=unused-variable]
> How do you trigger this? Compiler version and .config?
>
> I haven't seen this one in any of my builds until now...
>
> Thx.

My Compiler version is 11.2.0. I used the default .config and compiled 
with flags "-Wall -Werror", just as follows:

     make allmodconfig

     make EXTRA_CFLAGS="-Wall -Werror"


Best regards

Li Zetao

