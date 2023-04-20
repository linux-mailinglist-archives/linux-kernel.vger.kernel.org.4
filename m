Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65F16E87DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjDTCOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDTCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:14:21 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDD26448A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:14:18 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxTNr5n0BkZDwfAA--.37419S3;
        Thu, 20 Apr 2023 10:14:17 +0800 (CST)
Received: from [10.130.0.102] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxjrP4n0Bk8mIwAA--.9S3;
        Thu, 20 Apr 2023 10:14:17 +0800 (CST)
Subject: Re: [PATCH 1/2] LoongArch: Add pad structure members for explicit
 alignment
To:     WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230418091348.9239-1-zhangqing@loongson.cn>
 <a7fa32c3af68083855e7690f67824d060d5c6135.camel@xry111.site>
 <899085c1-7a74-8bab-1429-1b6e9e4c2c30@xen0n.name>
 <48bc7236-638d-9086-daaf-62eacea80dd2@xen0n.name>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <111c1e81-dfae-4388-9fc6-a3f247641398@loongson.cn>
Date:   Thu, 20 Apr 2023 10:14:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <48bc7236-638d-9086-daaf-62eacea80dd2@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjrP4n0Bk8mIwAA--.9S3
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XryfGr1fKryxWw4DGrW8Xrb_yoWxXr1kpr
        n7JFyUJrW5Jr1kJr1jqr1UXryDtryUJw1UJr1UJa48Jr43Xr1Ygr1UWr1qgr1UJr48Jr1U
        Jr15Jr17uF1UJr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8w
        CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
        6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
        vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_
        Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
        vEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UUUUU==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui and Ruoyao

On 2023/4/20 上午1:24, WANG Xuerui wrote:
> On 4/19/23 19:00, WANG Xuerui wrote:
>> On 2023/4/19 18:42, Xi Ruoyao wrote:
>>> On Tue, 2023-04-18 at 17:13 +0800, Qing Zhang wrote:
>>>> This is done in order to easily calculate the number of breakpoints
>>>> in hw_break_get.
>>>>
>>>> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
>>>> ---
>>>>   arch/loongarch/include/uapi/asm/ptrace.h |  3 ++-
>>>>   arch/loongarch/kernel/ptrace.c           | 13 +++++++++----
>>>>   2 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/loongarch/include/uapi/asm/ptrace.h
>>>> b/arch/loongarch/include/uapi/asm/ptrace.h
>>>> index 2282ae1fd3b6..06e3be52cb04 100644
>>>> --- a/arch/loongarch/include/uapi/asm/ptrace.h
>>>> +++ b/arch/loongarch/include/uapi/asm/ptrace.h
>>>> @@ -57,11 +57,12 @@ struct user_lasx_state {
>>
>> Drive-by comment to the patch author: there is no "user_lasx_state" 
>> yet. Please always state your base commit if not obvious, or you 
>> should start from some well-known upstream HEAD (e.g. Linus' rc tags, 
>> loongarch-fixes, or loongarch-next).
>>
>>>>   };
>>>>     struct user_watch_state {
>>>> -       uint16_t dbg_info;
>>>> +       uint64_t dbg_info;
>>>
>>> Ouch.  This is a breaking change when we consider user code like
>>> `printf(PRIu16 "\n", ptr->dbg_info);`.  Is it really necessary?
>>
>> Ah right. This is UAPI so without *very* concrete and convicing reason 
>> why the change is not going to impact any potential users, it's gonna 
>> be a presumed NAK. In other words you must demonstrate (1) why it's 
>> absolutely necessary to make the change and (2) that it's impossible 
>> to impact anyone, before any such changes can even be considered.
> Please ignore all of this. The memory layout is actually the same after 
> the change due to the padding, I was somehow thinking in big-endian a 
> few hours ago. (The commit message didn't help either, I think both 
> Ruoyao and me got into the habitual thinking that changes like this are 
> most likely just churn without real benefits, after *not* seeing the 
> rationale in the commit message which was kinda expected.)
>>

This patch does not change the size of the structure. The structure
itself is implicitly aligned. We changed it to explicit alignment for
the convenience of hw_break_get/set (using membuf.left) to calculate the
offset and prevent breaks. Count overflow.

With pad explicit alignment, after membuf_write(&to, &info, 
sizeof(info)); to.left=200-8 bytes,
Thus,
membuf_store(&to, addr);
membuf_store(&to, mask);
membuf_store(&to, ctrl);
membuf_zero(&to, sizeof(u32));
After that, to.left is decremented by 24 bytes each time,
so the number of breakpoints will not overflow.

The user support code has not been submitted to the upstream, so
the current uapi change has no effect.

Thanks,
-Qing
>>>
>>>>          struct {
>>>>                  uint64_t    addr;
>>>>                  uint64_t    mask;
>>>>                  uint32_t    ctrl;
>>>> +               uint32_t    pad;
>>>>          } dbg_regs[8];
>>>>   };
>>>>   diff --git a/arch/loongarch/kernel/ptrace.c
>>>> b/arch/loongarch/kernel/ptrace.c
>>>> index 0c7c41e41cad..9c3bc1bbf2ff 100644
>>>> --- a/arch/loongarch/kernel/ptrace.c
>>>> +++ b/arch/loongarch/kernel/ptrace.c
>>>> @@ -475,10 +475,10 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned
>>>> int note_type,
>>>>          return 0;
>>>>   }
>>>>   -static int ptrace_hbp_get_resource_info(unsigned int note_type, u16
>>>> *info)
>>>> +static int ptrace_hbp_get_resource_info(unsigned int note_type, u64
>>>> *info)
>>>>   {
>>>>          u8 num;
>>>> -       u16 reg = 0;
>>>> +       u64 reg = 0;
>>>>            switch (note_type) {
>>>>          case NT_LOONGARCH_HW_BREAK:
>>>> @@ -616,7 +616,7 @@ static int hw_break_get(struct task_struct
>>>> *target,
>>>>                          const struct user_regset *regset,
>>>>                          struct membuf to)
>>>>   {
>>>> -       u16 info;
>>>> +       u64 info;
>>>>          u32 ctrl;
>>>>          u64 addr, mask;
>>>>          int ret, idx = 0;
>>>> @@ -646,6 +646,7 @@ static int hw_break_get(struct task_struct
>>>> *target,
>>>>                  membuf_store(&to, addr);
>>>>                  membuf_store(&to, mask);
>>>>                  membuf_store(&to, ctrl);
>>>> +               membuf_zero(&to, sizeof(u32));
>>>>                  idx++;
>>>>          }
>>>>   @@ -662,7 +663,7 @@ static int hw_break_set(struct task_struct
>>>> *target,
>>>>          int ret, idx = 0, offset, limit;
>>>>          unsigned int note_type = regset->core_note_type;
>>>>   -       /* Resource info */
>>>> +       /* Resource info and pad */
>>>>          offset = offsetof(struct user_watch_state, dbg_regs);
>>>>          user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf, 0,
>>>> offset);
>>>>   @@ -704,6 +705,10 @@ static int hw_break_set(struct task_struct
>>>> *target,
>>>>                  if (ret)
>>>>                          return ret;
>>>>                  offset += PTRACE_HBP_CTRL_SZ;
>>>> +
>>>> +               user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
>>>> +                                         offset, offset +
>>>> PTRACE_HBP_PAD_SZ);
>>>> +               offset += PTRACE_HBP_PAD_SZ;
>>>>                  idx++;
>>>>          }
>>>
>>

