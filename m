Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7330F6A1CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjBXNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBXNEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:04:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E876AF979
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:04:03 -0800 (PST)
Received: from loongson.cn (unknown [118.116.19.77])
        by gateway (Coremail) with SMTP id _____8Axkk7CtfhjrLoEAA--.3803S3;
        Fri, 24 Feb 2023 21:04:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [118.116.19.77])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+TBtfhjn6o6AA--.5563S3;
        Fri, 24 Feb 2023 21:04:02 +0800 (CST)
Message-ID: <d5e96b4f-ac51-9d56-fcf3-b4f18779b76e@loongson.cn>
Date:   Fri, 24 Feb 2023 21:04:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 6/6] LoongArch: Clean up la_abs macro
To:     Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Youling Tang <tangyouling@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230224101013.26971-1-hejinyang@loongson.cn>
 <20230224101013.26971-7-hejinyang@loongson.cn>
 <cc9fe98d7e157c3e4bdf82d92e9ea368b894ce00.camel@xry111.site>
From:   Jinyang He <hejinyang@loongson.cn>
In-Reply-To: <cc9fe98d7e157c3e4bdf82d92e9ea368b894ce00.camel@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxb+TBtfhjn6o6AA--.5563S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAFyfArWrJF4xXw48KF15Arb_yoWrWr1rpr
        1kJr1DJrW5Gr1kJr1UJr1DXry5Jr1DJ3WUGr1UJFyUGr47Jr1jgr1UXryqgr17Jr48Jr48
        Xr1UXr17Zr1UJw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
        xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
        GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI4
        8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I
        8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/2/24 18:43, Xi Ruoyao 写道:

> On Fri, 2023-02-24 at 18:10 +0800, Jinyang He wrote:
>
> /* snip */
>
>> diff --git a/arch/loongarch/kernel/entry.S
>> b/arch/loongarch/kernel/entry.S
>> index ca4651f91e73..4de6b31dc3bf 100644
>> --- a/arch/loongarch/kernel/entry.S
>> +++ b/arch/loongarch/kernel/entry.S
> /* snip */
>
>> @@ -65,7 +65,7 @@ SYM_FUNC_START(handle_sys)
>>          and             tp, tp, sp
>>   
>>          move    a0, sp
>> -       la_abs  ra, do_syscall
>> +       la.pcrel        ra, do_syscall
>>          jirl    ra, ra, 0
> bl	do_syscall
>
>>   
>>          RESTORE_ALL_AND_RET
>> diff --git a/arch/loongarch/kernel/genex.S
>> b/arch/loongarch/kernel/genex.S
>> index 8705a7661ce9..b6a74246d1c4 100644
>> --- a/arch/loongarch/kernel/genex.S
>> +++ b/arch/loongarch/kernel/genex.S
> /* snip */
>
>> @@ -45,7 +45,7 @@ SYM_FUNC_START(handle_vint\idx)
>>          LONG_S  t0, sp, PT_ERA
>>   1:     move    a0, sp
>>          move    a1, sp
>> -       la_abs  t0, do_vint
>> +       la.pcrel        t0, do_vint
>>          jirl    ra, t0, 0
> bl	do_vint
>
>>          RESTORE_ALL_AND_RET
>>   SYM_FUNC_END(handle_vint\idx)
>> @@ -76,7 +76,7 @@ SYM_FUNC_START(handle_\exception)
>>          SAVE_ALL
>>          build_prep_\prep
>>          move    a0, sp
>> -       la_abs  t0, do_\handler
>> +       la.pcrel        t0, do_\handler
>>          jirl    ra, t0, 0
> bl	do_\handler
>
> /* snip */
>
>> diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
>> index 53321d3447a2..196d9bc870c5 100644
>> --- a/arch/loongarch/mm/tlbex.S
>> +++ b/arch/loongarch/mm/tlbex.S
>> @@ -41,7 +41,7 @@ SYM_FUNC_START(handle_tlb_protect\idx)
>>          move            a1, zero
>>          csrrd           a2, LOONGARCH_CSR_BADV
>>          REG_S           a2, sp, PT_BVADDR
>> -       la_abs          t0, do_page_fault
>> +       la.pcrel        t0, do_page_fault
>>          jirl            ra, t0, 0
> bl	do_page_fault
>
> /* snip */
>
>> @@ -190,7 +190,7 @@ SYM_FUNC_START(handle_tlb_load\idx)
>>   5: /* nopage_tlb_load: */
>>          dbar            0
>>          csrrd           ra, EXCEPTION_KS2
>> -       la_abs          t0, tlb_do_page_fault_0
>> +       la.pcrel        t0, tlb_do_page_fault_0
>>          jr              t0
> b	tlb_do_page_fault_0
>
> /* snip */
>
>> @@ -341,7 +341,7 @@ tlb_huge_update_store:
>>   nopage_tlb_store:
>>          dbar            0
>>          csrrd           ra, EXCEPTION_KS2
>> -       la_abs          t0, tlb_do_page_fault_1
>> +       la.pcrel        t0, tlb_do_page_fault_1
>>          jr              t0
> b	tlb_do_page_fault_1
>
> /* snip */
>
>> @@ -490,7 +490,7 @@ tlb_huge_update_modify:
>>   nopage_tlb_modify:
>>          dbar            0
>>          csrrd           ra, EXCEPTION_KS2
>> -       la_abs          t0, tlb_do_page_fault_1
>> +       la.pcrel        t0, tlb_do_page_fault_1
>>          jr              t0
> b	tlb_do_page_fault_1
>
>>   SYM_FUNC_END(handle_tlb_modify)
>>          .endm

Thanks, I'll check other places, too.


Jinyang

