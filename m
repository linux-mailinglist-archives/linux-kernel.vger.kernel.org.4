Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBD738EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjFUSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUSkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA9185;
        Wed, 21 Jun 2023 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BWN+TwZc4cNQ2IEsLx0s0ZB9zBXyxf6RA90SzIb0olA=; b=u6m3glTqXGq+7mGlQAdlTPfboZ
        HE5+aJ65KJPNC5mQvvKJ2MeWqpQZWQMJHgohgC1jBPPTh0KiFbiZFxvuqrfxhPpp9F8FRKU6KvFE/
        n0ii3nmVLdIUNxd9h5jbrzxk0B3cFcQ+Ze552XVjN0R2ORxJIKVqIiJfg7X9AbcckiTN9s0IfAghv
        /Q8guZM0aZCSXQnAZ8dGPNiOyt/YKBLVBs5SxtktM+SoJTjRRBVxu/kSjFcRITZm0MUN0FrM1BzVZ
        0ErJYHt5wUTjToCX5oLc52SlKuvxNtPD6E2Ohej0tPLv0xuMVOy7Ueqs31du82C5EdaXDkVeW/rb2
        Juwez6rw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC2kq-00FQwn-2N;
        Wed, 21 Jun 2023 18:40:32 +0000
Message-ID: <ab38f6af-cb68-a918-1a63-2e7c927a8ffc@infradead.org>
Date:   Wed, 21 Jun 2023 11:40:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 21 (riscv/errata/thead)
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, wefu@redhat.com
References: <20230621145917.3635a2f1@canb.auug.org.au>
 <14aa23d6-b4c2-190f-0d6c-22a82befa04d@infradead.org>
 <20230621-playoff-wireless-0dcfce9711ff@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621-playoff-wireless-0dcfce9711ff@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/23 11:31, Conor Dooley wrote:
> On Wed, Jun 21, 2023 at 11:25:14AM -0700, Randy Dunlap wrote:
>>
>>
>> On 6/20/23 21:59, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20230620:
>>>
>>
>> on riscv 32-bit:
> 
> Is XIP_KERNEL enabled? And if so, does this fix it?

Yes. and Yes.
Thanks.

for your patch:
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index ce10a38dff37..6833d01e2e70 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -43,6 +43,7 @@ config ARCH_SUNXI
>  
>  config ARCH_THEAD
>         bool "T-HEAD RISC-V SoCs"
> +       depends on MMU && !XIP_KERNEL
>         select ERRATA_THEAD
>         help
>           This enables support for the RISC-V based T-HEAD SoCs.
> (whitespace damaged)
> 
> Cheers,
> Conor.
> 
>>
>>
>> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>>   Depends on [n]: RISCV_ALTERNATIVE [=n]
>>   Selected by [y]:
>>   - ARCH_THEAD [=y]
>>
>> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>>   Depends on [n]: RISCV_ALTERNATIVE [=n]
>>   Selected by [y]:
>>   - ARCH_THEAD [=y]
>>
>> WARNING: unmet direct dependencies detected for ERRATA_THEAD
>>   Depends on [n]: RISCV_ALTERNATIVE [=n]
>>   Selected by [y]:
>>   - ARCH_THEAD [=y]
>>
>> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pbmt':
>> ../arch/riscv/errata/thead/errata.c:29:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
>>    29 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
>>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c:29:22: note: each undeclared identifier is reported only once for each function it appears in
>> ../arch/riscv/errata/thead/errata.c:30:22: error: 'RISCV_ALTERNATIVES_MODULE' undeclared (first use in this function)
>>    30 |             stage == RISCV_ALTERNATIVES_MODULE)
>>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_cmo':
>> ../arch/riscv/errata/thead/errata.c:45:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
>>    45 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pmu':
>> ../arch/riscv/errata/thead/errata.c:63:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
>>    63 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c: At top level:
>> ../arch/riscv/errata/thead/errata.c:86:37: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
>>    86 | void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>>       |                                     ^~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c: In function 'thead_errata_patch_func':
>> ../arch/riscv/errata/thead/errata.c:95:41: error: increment of pointer to an incomplete type 'struct alt_entry'
>>    95 |         for (alt = begin; alt < end; alt++) {
>>       |                                         ^~
>> ../arch/riscv/errata/thead/errata.c:96:24: error: invalid use of undefined type 'struct alt_entry'
>>    96 |                 if (alt->vendor_id != THEAD_VENDOR_ID)
>>       |                        ^~
>> ../arch/riscv/errata/thead/errata.c:98:24: error: invalid use of undefined type 'struct alt_entry'
>>    98 |                 if (alt->patch_id >= ERRATA_THEAD_NUMBER)
>>       |                        ^~
>> ../arch/riscv/errata/thead/errata.c:101:33: error: invalid use of undefined type 'struct alt_entry'
>>   101 |                 tmp = (1U << alt->patch_id);
>>       |                                 ^~
>> ../arch/riscv/errata/thead/errata.c:103:34: error: implicit declaration of function 'ALT_OLD_PTR' [-Werror=implicit-function-declaration]
>>   103 |                         oldptr = ALT_OLD_PTR(alt);
>>       |                                  ^~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c:103:32: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>   103 |                         oldptr = ALT_OLD_PTR(alt);
>>       |                                ^
>> ../arch/riscv/errata/thead/errata.c:104:34: error: implicit declaration of function 'ALT_ALT_PTR' [-Werror=implicit-function-declaration]
>>   104 |                         altptr = ALT_ALT_PTR(alt);
>>       |                                  ^~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c:104:32: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>   104 |                         altptr = ALT_ALT_PTR(alt);
>>       |                                ^
>> ../arch/riscv/errata/thead/errata.c:107:38: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
>>   107 |                         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT) {
>>       |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../arch/riscv/errata/thead/errata.c:108:59: error: invalid use of undefined type 'struct alt_entry'
>>   108 |                                 memcpy(oldptr, altptr, alt->alt_len);
>>       |                                                           ^~
>> ../arch/riscv/errata/thead/errata.c:111:70: error: invalid use of undefined type 'struct alt_entry'
>>   111 |                                 patch_text_nosync(oldptr, altptr, alt->alt_len);
>>       |                                                                      ^~
>> cc1: some warnings being treated as errors
>>
>>
>> -- 
>> ~Randy

-- 
~Randy
