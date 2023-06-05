Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A697E722B19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjFEPbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjFEPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:31:19 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493A1AD;
        Mon,  5 Jun 2023 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685979072;
        bh=pJHnQbCI2ye8sUuCV4a+a0ry4+f3KZMKMeIqnLGZ0DY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jxyTj1NblqZ4q9+mnvzbYw1c0ndBrIB33qrbJ9rkuToGObrUIXFZ37lj5M40XzHYJ
         BueSIPuaz5BW0nifySvPGqHXl699eSnKUPVeOTggDsJnq9mLeqNJjR5J8pmrKIjTQI
         O43AtTA8dnvuggpAdascaQruZFPDRVr41tt6xjBSjMupzI/NvOyygoQuJ3QY5RLR3O
         teCBCOoSndUzhInV2XjukdJaAIUBFofhHg0LNnao4A/DdKCPNKsHtVo8ELMXZVRTaU
         MOIMu5U5e+i/2w1fH9cRG7dEONes2Qiiwng993xkuHVfv7dURLVfGf9Y5gRDtqpiEM
         8/2EEwa9PRd7Q==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QZcyS0cq0z16s2;
        Mon,  5 Jun 2023 11:31:12 -0400 (EDT)
Message-ID: <a6fc8ce8-4fe1-7bf6-c92d-b793d24e74a1@efficios.com>
Date:   Mon, 5 Jun 2023 11:31:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] Documentation: Document macro coding style
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org
References: <20230511152951.1970870-1-mathieu.desnoyers@efficios.com>
 <87y1lkmjjv.fsf@meer.lwn.net>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <87y1lkmjjv.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 11:23, Jonathan Corbet wrote:
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:
> 
>> Document the kernel coding style for macros with parameters.
>>
>> The purpose of this text is to be used as a reference to gradually
>> transition towards macros with a more consistent style, and eliminate
>> subtle bugs that can creep up due to missing parentheses, and generally
>> remove the need to think and argue about C operator precedence.
>>
>> This is based on a mailing list discussion with Linus.
>>
>> Link: https://lore.kernel.org/lkml/CAHk-=wjfgCa-u8h9z+8U7gaKK6PnRCpws1Md9wYSSXywUxoUSA@mail.gmail.com/
>> Link: https://lore.kernel.org/lkml/CAHk-=wjzpHjqhybyEhkTzGgTdBP3LZ1FmOw8=1MMXr=-j5OPxQ@mail.gmail.com/
>> Link: https://lore.kernel.org/lkml/CAHk-=wh-x1PL=UUGD__Dv6kd+kyCHjNF-TCHGG9ayLnysf-PdQ@mail.gmail.com/
>> Link: https://lore.kernel.org/lkml/CAHk-=wg27iiFZWYmjKmULxwkXisOHuAXq=vbiazBabgh9M1rqg@mail.gmail.com/
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>   Documentation/process/coding-style.rst | 152 ++++++++++++++++++++++++-
>>   1 file changed, 151 insertions(+), 1 deletion(-)
> 
> So this looks generally OK to me.  I really like to see some reviews /
> acks on coding-style patches, though; I don't feel like I should be the
> arbiter of kernel coding style.

Sure, I'll update the patch based on your comments and send without the RFC tag, we'll
see if we get reviews or ack.

Meanwhile there are two additional cases where I think we should mandate the parentheses
even though they are not strictly needed, because it eliminates corner-cases without
negatively impacting readability.

The first case is when an argument is used as declarator identifier, e.g.

         #define DECLARE_WAITQUEUE(name, tsk)    \
                 struct wait_queue_entry name = __WAITQUEUE_INITIALIZER(name, tsk)
                                         ^ here

Adding parentheses around "name" does not break anything, makes the code *more*
regular by following the general rule of adding parentheses around macro arguments
unless it is not possible for some reason.

I also think that we should mandate parentheses around initializers, even though
those are full expressions:

         #define foo(a)                                  \
                 do {                                    \
                         int __m_var = a;                \
                                       ^ here
                 } while (0)

Because requiring the (useless) parentheses here makes the code more consistent and
removes a corner-case to think about when writing code, without negatively impacting
readability.

This would basically leave only the following corner-cases. Please let me know if any
of them would be good candidates for requiring the extra parentheses nevertheless:

- For readability:

   - "a;"
   - "for (a; b; c)"
   - "if (a)"
   - "switch (a)"
   - "while (a)"
   - "do { ... } while (a)"
   - "return a;"
   - "array[a]",
   - "f(a)",
   - "f(a, b, c)",

Because it would not work otherwise:

- "(p)->a,
- "#a",
- "sym##a".

> 
> One little comment below
> 
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index 6db37a46d305..3cf62c91d91c 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -819,10 +819,160 @@ Macros with multiple statements should be enclosed in a do - while block:
>>   
>>   	#define macrofun(a, b, c)			\
>>   		do {					\
>> -			if (a == 5)			\
>> +			if ((a) == 5)			\
>>   				do_this(b, c);		\
>>   		} while (0)
>>   
>> +Always use parentheses around macro arguments, except for the situations listed
>> +below.
>> +
>> +Examples where parentheses are required around macro arguments:
>> +
>> +.. code-block:: c
>> +
>> +	#define foo(a, b)				\
>> +		do {					\
>> +			(a) = (b);			\
>> +		} while (0)
>> +
>> +.. code-block:: c
>> +
>> +	#define foo(a)					\
>> +		do {					\
>> +			(a)++;				\
>> +		} while (0)
>> +
>> +.. code-block:: c
>> +
>> +	#define cmp_gt(a, b)			((a) > (b))
>> +
>> +.. code-block:: c
>> +
>> +	#define foo(a)				do_this(!(a))
>> +
>> +.. code-block:: c
>> +
>> +	#define foo(a)				do_this(*(a))
>> +
>> +.. code-block:: c
>> +
>> +	#define foo(a)				do_this(&(a))
>> +
>> +.. code-block:: c
>> +
>> +	#define get_member(struct_var)		do_this((struct_var).member)
>> +
>> +.. code-block:: c
>> +
>> +	#define deref_member(struct_ptr)	do_this((struct_ptr)->member)
> 
> I wonder if we really need to give all of these examples?  We've already
> said "always put parentheses except in a few cases" - I would think that
> would be enough.

OK, let's remove those examples for now. If it proves that it causes confusion
we can always add them back.

> 
>> +Situations where parentheses should not be added around arguments, when:
> 
> For these, it would be nice to say *why* parentheses shouldn't be added;
> helping readers understand the reasoning might have more benefit than
> imparting a set of rules.

OK, those would look like:

Always use parentheses around macro arguments, except when:

* they are used as a full expression and negatively impact code readability
   (because the extra parentheses would not have any role in preserving operator
   precedence, making them redundant):

[...]

* they are used as expression within an array subscript operator "[]" (because brackets
   nest just like parentheses themselves do):

[...]

* they are used as arguments to functions or other macros (because the comma
   separator between arguments is not even an operator, so there is no operator
   precedence to preserve):

[...]

(note: the ones below include new additions)

* there is some syntax reason why adding the parentheses would not work, e.g.
   when using the parameter as member name, for string expansion, or token
   pasting:

   * the ``member`` argument:

     .. code-block:: c

         #define foo(struct_p, member)   do_this((struct_p)->member)

   * string expansion:

     .. code-block:: c

         #define __stringify_1(x...)     #x
         #define __stringify(x...)       __stringify_1(x)

   * token pasting:

     .. code-block:: c

         #define COMPAT_SYSCALL_DEFINE1(name, ...)       \
                 COMPAT_SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)

Thanks!

Mathieu


> 
> Thanks,
> 
> jon

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

