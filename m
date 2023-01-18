Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC4671ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAROEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjARODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:03:51 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D566A49551
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:40:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 47CE81C3E3B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:40:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674049228;
        bh=wVUxhJVoV68waKeEkhzEL6KY6t3QAA6/TKJ0oALeiPc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=6NhlR0kH2OAdEGOrXcTYdvnLQapEiue00FjasOzHooMkl5n9ZTPvk0Pexc2IW2wEf
         oLBwg9aVvchmgroYTkQXLRNiDAJXa48yb9rBdvgX2Gwd7ACCB2rIdRvj1QVwbZunmK
         bMXqpZmYb7umLio9NKemyXhmLOE9dxnuzMizJtGo=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 1CDEF1C3E29E; Wed, 18 Jan 2023 14:40:28 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 4C76C1C3E272; Wed, 18 Jan
 2023 14:40:27 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 23A0F27E0431; Wed, 18 Jan 2023
 14:40:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 0842227E043E; Wed, 18 Jan 2023 14:40:27 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 MbMNEJPQrWTX; Wed, 18 Jan 2023 14:40:26 +0100 (CET)
Received: from [127.0.0.1] (unknown [192.168.37.161]) by zimbra2.kalray.eu
 (Postfix) with ESMTPSA id 6DB2D27E0431; Wed, 18 Jan 2023 14:40:26 +0100
 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <199b.63c7f6cb.4ac6c.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 0842227E043E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674049227;
 bh=58T3bVGsMNkDvPnQtkuPdqBFBPPv2eFSDsL5jLuYa4k=;
 h=Message-ID:Date:MIME-Version:To:From;
 b=km45DKDOC2u0nr2RV2H37ZDEYjR9PXAOeVDCTdIps52vx7n+8C39kutjfP/WdX8Er
 hObRI28opJsJclYo12d04yTCEBqG9ZREZpO0JJekeqlGta8MitngskxbEDkj7u/Zgy
 TaxbvIS46LRbVQ520+OPBLoNudc1C852szRn+fX8=
Message-ID: <752bdbe1-2ca5-2322-75fe-b4abd90e448c@kalray.eu>
Date:   Wed, 18 Jan 2023 14:40:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 05/25] kvx: Add atomic/locking headers
Content-Language: en-us
To:     Mark Rutland <mark.rutland@arm.com>,
        Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
 <20230103164359.24347-6-ysionneau@kalray.eu> <Y7VMlPKGEQwvTK4W@FVFF77S0Q05N>
 <20230106141158.GC7446@tellis.lin.mbt.kalray.eu>
 <Y71nDtFHgDJoWb6s@FVFF77S0Q05N>
From:   Yann Sionneau <ysionneau@kalray.eu>
In-Reply-To: <Y71nDtFHgDJoWb6s@FVFF77S0Q05N>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 10/01/2023 14:24, Mark Rutland wrote:
> On Fri, Jan 06, 2023 at 03:11:58PM +0100, Jules Maselbas wrote:
>> Hi Mark,
>>
>> On Wed, Jan 04, 2023 at 09:53:24AM +0000, Mark Rutland wrote:
>>> On Tue, Jan 03, 2023 at 05:43:39PM +0100, Yann Sionneau wrote:
>>>> Add common headers (atomic, bitops, barrier and locking) for basic
>>>> kvx support.
>>>>
>>>> CC: Will Deacon <will@kernel.org>
>>>> CC: Peter Zijlstra <peterz@infradead.org>
>>>> CC: Boqun Feng <boqun.feng@gmail.com>
>>>> CC: Mark Rutland <mark.rutland@arm.com>
>>>> CC: linux-kernel@vger.kernel.org
>>>> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
>>>> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
>>>> Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
>>>> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
>>>> Co-developed-by: Julian Vetter <jvetter@kalray.eu>
>>>> Signed-off-by: Julian Vetter <jvetter@kalray.eu>
>>>> Co-developed-by: Julien Villette <jvillette@kalray.eu>
>>>> Signed-off-by: Julien Villette <jvillette@kalray.eu>
>>>> Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
>>>> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
>>>> ---
>>>>   arch/kvx/include/asm/atomic.h  | 104 +++++++++++++++++
>>>>   arch/kvx/include/asm/barrier.h |  15 +++
>>>>   arch/kvx/include/asm/bitops.h  | 207 +++++++++++++++++++++++++++++++++
>>>>   arch/kvx/include/asm/bitrev.h  |  32 +++++
>>>>   arch/kvx/include/asm/cmpxchg.h | 185 +++++++++++++++++++++++++++++
>>>>   5 files changed, 543 insertions(+)
>>>>   create mode 100644 arch/kvx/include/asm/atomic.h
>>>>   create mode 100644 arch/kvx/include/asm/barrier.h
>>>>   create mode 100644 arch/kvx/include/asm/bitops.h
>>>>   create mode 100644 arch/kvx/include/asm/bitrev.h
>>>>   create mode 100644 arch/kvx/include/asm/cmpxchg.h
>>>>
>>>> diff --git a/arch/kvx/include/asm/atomic.h b/arch/kvx/include/asm/atomic.h
>>>> new file mode 100644
>>>> index 000000000000..eb8acbcbc70d
>>>> --- /dev/null
>>>> +++ b/arch/kvx/include/asm/atomic.h
>>>> @@ -0,0 +1,104 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2017-2023 Kalray Inc.
>>>> + * Author(s): Clement Leger
>>>> + */
>>>> +
>>>> +#ifndef _ASM_KVX_ATOMIC_H
>>>> +#define _ASM_KVX_ATOMIC_H
>>>> +
>>>> +#include <linux/types.h>
>>>> +
>>>> +#include <asm/cmpxchg.h>
>>>> +
>>>> +#define ATOMIC64_INIT(i)     { (i) }
>>>> +
>>>> +#define arch_atomic64_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
>>>> +#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
>>>> +
>>>> +static inline long arch_atomic64_read(const atomic64_t *v)
>>>> +{
>>>> +	return v->counter;
>>>> +}
>>> This is a plain read, and is *not* atomic.
>>>
>>> The compiler can replay a plain read an arbitrary number of times, and is
>>> permitted to split it into smaller accesses.
>>>
>>> At minimum this needs to be
>>>
>>>    READ_ONCE(v->counter)
>>>
>>> ... which will prevent replay. Whether or not that's actually atomic will
>>> depend on the instructions the compiler generates, and how those instructions
>>> are defines in your architecture.
>> Good point, we are going to use {READ,WRITE}_ONCE macros
Done for V2 (which we will send pretty soon).
>>
>>> Do you have a single instruction that can read a 64-bit memory location, and is
>>> it guaranteed to result in a single access that cannot be split?
>> We do have a single instruction that can read a 64-bit memory location
>> (supported sizes are 8, 16, 32, 64, 128, 256).
>> All accesses are guaranteed to not be split, unless they are misaligned.
>> Furthermore, misaligned write accesses crossing a 32-byte boundary may
>> complete in a non-atomic way.
> Perfect, thanks for confirming!
>
> [...]
>
>>>> +static inline void arch_atomic64_set(atomic64_t *v, long i)
>>>> +{
>>>> +	v->counter = i;
>>>> +}
>>> Same comments as for arch_atomic64_read(); at minimum this needs to be:
>>>
>>>    WRITE_ONCE(v->counter, i)
>>>
>>> ... but that may or may not actually be atomic on your architecture.
>>>
>>>> +#define ATOMIC64_RETURN_OP(op, c_op)					\
>>>> +static inline long arch_atomic64_##op##_return(long i, atomic64_t *v)	\
>>>> +{									\
>>>> +	long new, old, ret;						\
>>>> +									\
>>>> +	do {								\
>>>> +		old = v->counter;					\
>>>> +		new = old c_op i;					\
>>>> +		ret = arch_cmpxchg(&v->counter, old, new);		\
>>>> +	} while (ret != old);						\
>>>> +									\
>>>> +	return new;							\
>>>> +}
>>>> +
>>>> +#define ATOMIC64_OP(op, c_op)						\
>>>> +static inline void arch_atomic64_##op(long i, atomic64_t *v)		\
>>>> +{									\
>>>> +	long new, old, ret;						\
>>>> +									\
>>>> +	do {								\
>>>> +		old = v->counter;					\
>>>> +		new = old c_op i;					\
>>>> +		ret = arch_cmpxchg(&v->counter, old, new);		\
>>>> +	} while (ret != old);						\
>>>> +}
>>>> +
>>>> +#define ATOMIC64_FETCH_OP(op, c_op)					\
>>>> +static inline long arch_atomic64_fetch_##op(long i, atomic64_t *v)	\
>>>> +{									\
>>>> +	long new, old, ret;						\
>>>> +									\
>>>> +	do {								\
>>>> +		old = v->counter;					\
>>>> +		new = old c_op i;					\
>>>> +		ret = arch_cmpxchg(&v->counter, old, new);		\
>>>> +	} while (ret != old);						\
>>>> +									\
>>>> +	return old;							\
>>>> +}
>>> These look ok, but it'd be nicer if we could teach the generic atomic64 code to
>>> do this, like the generic atomic code does.
>>>
>>> We could rename the existing asm-generic/atomic64 code to atomic64-spinlock,
>>> and add a separate atomic64-cmpxchg (and likewise for the 32-bit code) to make
>>> that clearer and consistent.
>> I am not sure what this implies and how big this change might be,
>> but I'll take a look at this.
> Hmm... from a quick attempt just now it looks like that will be a bit more
> churny than I thought.
>
> We can always factor this out later, so feel free to leave it as-is, thgouh if
> we could make this genric (and have it look like asm-generic/atomic.h), it'd be
> nice for consistency and maintenance.
Ack for doing it later.
>
>>>> +
>>>> +#define ATOMIC64_OPS(op, c_op)						\
>>>> +	ATOMIC64_OP(op, c_op)						\
>>>> +	ATOMIC64_RETURN_OP(op, c_op)					\
>>>> +	ATOMIC64_FETCH_OP(op, c_op)
>>>> +
>>>> +ATOMIC64_OPS(and, &)
>>>> +ATOMIC64_OPS(or, |)
>>>> +ATOMIC64_OPS(xor, ^)
>>>> +ATOMIC64_OPS(add, +)
>>>> +ATOMIC64_OPS(sub, -)
>>>> +
>>>> +#undef ATOMIC64_OPS
>>>> +#undef ATOMIC64_FETCH_OP
>>>> +#undef ATOMIC64_OP
>>>> +
>>>> +static inline int arch_atomic_add_return(int i, atomic_t *v)
>>>> +{
>>>> +	int new, old, ret;
>>>> +
>>>> +	do {
>>>> +		old = v->counter;
>>>> +		new = old + i;
>>>> +		ret = arch_cmpxchg(&v->counter, old, new);
>>>> +	} while (ret != old);
>>>> +
>>>> +	return new;
>>>> +}
>>>> +
>>>> +static inline int arch_atomic_sub_return(int i, atomic_t *v)
>>>> +{
>>>> +	return arch_atomic_add_return(-i, v);
>>>> +}
>>> Likewise for these two.
> The 32-bit atomics should come from asm-generic/atomic.h and not be necesary,
> that has both arch_atomic_add_return() and arch_atomic_sub_return().
>
>>>> diff --git a/arch/kvx/include/asm/cmpxchg.h b/arch/kvx/include/asm/cmpxchg.h
>>>> new file mode 100644
>>>> index 000000000000..b1d128b060a2
>>>> --- /dev/null
>>>> +++ b/arch/kvx/include/asm/cmpxchg.h
>>>> @@ -0,0 +1,185 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Copyright (C) 2017-2023 Kalray Inc.
>>>> + * Author(s): Clement Leger
>>>> + *            Yann Sionneau
>>>> + */
>>>> +
>>>> +#ifndef _ASM_KVX_CMPXCHG_H
>>>> +#define _ASM_KVX_CMPXCHG_H
>>>> +
>>>> +#include <linux/bits.h>
>>>> +#include <linux/types.h>
>>>> +#include <linux/build_bug.h>
>>>> +
>>>> +/*
>>>> + * On kvx, we have a boolean compare and swap which means that the operation
>>>> + * returns only the success of operation.
>>>> + * If operation succeed, this is simple, we just need to return the provided
>>>> + * old value. However, if it fails, we need to load the value to return it for
>>>> + * the caller. If the loaded value is different from the "old" provided by the
>>>> + * caller, we can return it since it will means it failed.
>>>> + * However, if for some reason the value we read is equal to the old value
>>>> + * provided by the caller, we can't simply return it or the caller will think it
>>>> + * succeeded. So if the value we read is the same as the "old" provided by
>>>> + * the caller, we try again until either we succeed or we fail with a different
>>>> + * value than the provided one.
>>>> + */
>>>> +#define __cmpxchg(ptr, old, new, op_suffix, load_suffix)		\
>>>> +({									\
>>>> +	register unsigned long __rn asm("r62");				\
>>>> +	register unsigned long __ro asm("r63");				\
>>> Why do you need to specify the exact registers?
>> r62 and r63 are hardcoded in the inline assembly, they are caller saved.
>> I have a C implementation that uses builtins however this is not merged
>> in our tree yet (but I want to).
>>
>>> e.g. does some instruction use these implicitly, or do you need two adjacent
>>> register for encoding reasons?
>> The atomic compare and swap (acswap) instruction needs a register "pair"
>> which can only exists with "adjacent" registers:  $r0r1, $r2r3 ect.
> Ok; and you don't have a way to ask GCC for an arbitrary register pair, so you
> chose r62+r63 as they can be clobbered?
>
> It might be worth looking into using an __int128_t to give you a register pair,
> assuming your calling convention mandares adjacency of the two halves. That
> could give you the pair while giving the compiler freedom to chose any suitable
> pair (assuming you have a suitable operand modifier to extract the low/high
> registers from the asm operand.

In the V2 we replaced the assembly code with C code.

acswap{d,w} instruction is generated by the mean of a compiler builtin. 
This way

the code is much more readable and it allows to not hard code some

register pair, letting the compiler allocate them.

>
>>>> +	__asm__ __volatile__ (						\
>>>> +		/* Fence to guarantee previous store to be committed */	\
>>>> +		"fence\n"						\
>>> This implies you can implement the relaxed form of cmpxchg().
>>>
>>> What ordering do you get by default, and do you have any other barriers (e.g.
>>> for acquire/release semantics), or just "fence" ?
>> We have two barrier types:
>>   - fence: ensure that all uncached memory operations are committed to
>>     memory, typically used to ensure a write to memory is visible to
>>     other cores.
>>   - barrier: flush the core instruction pipeline and memory system
> Ok.
>
> In the absence of barriers do you have any ordering guarantee? e.g. weak like
> arm/power, TSO like x86, or something else entirely?

Our memory ordering model is weak.

```

store @data_addr = new_value

;;

store @data_is_valid_addr = 1

;;

```

By running the previous pseudo-code, there is no guarantee that another 
CPU would see the *data_addr == new_value just because it sees 
*data_is_valid_addr == 1

The correct code would need an extra bundle containing a `fence` 
instruction in-between the 2 other bundles.

> When you say "uncached memory operations", does that mean that you have cached
> memory operatins which are not affected by the barriers, or is "uncached memory
> operations" just meant to read as "oustanding/incomplete memory operations" ?

The fence instruction will force all outstanding memory write operations 
to finish and reach their target.

* For an uncached access it means that after the fence the DDR has been 
updated (or the target device register).

* For a cached access it means the L2 cache has been updated, and 
therefore all the corresponding L1D lines invalidated. (L1I is untouched!)

Bottom line is that after the fence, all other cores of the cluster 
running Linux will see the new value. Except of course if the write is 
through an uncached MMU mapping and the read is done through a cached 
MMU mapping, but this seems normal.

Thanks for the review, it's much appreciated!

-- 

Yann





