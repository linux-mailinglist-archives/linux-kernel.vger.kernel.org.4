Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F120D6646A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 17:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbjAJQyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 11:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbjAJQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 11:54:18 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E844392FC;
        Tue, 10 Jan 2023 08:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673369644;
        bh=QiidjUfkP5oNdny1iP2kwF+d3IAAvkuGTNnx9EysElE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=C9UOcKLvLQVMMn0G0FqQgz+sVZCHPjg5KOhPoU99zbmGgAq7/aohUwlA6pIlYKLrX
         oXnNfTLlZ+yLFeUl0IMyEhnkj0bTwsLusCt5TdidP83Ehh61L8d/ZE/xDHEoCjHym6
         gEAKR3tuPcT+4raG/PW0bVuDxI//IJ6guNHXdbuO8rRd1rZxpmWUjFYqStCfcRvndR
         y7Uv7dZj3Yq4ooimNStQW7lb/ASPVjopR+YNdeKyQe77chtiO1UKcrDTFQo1MhNqLx
         1UO9i4RJQJn6xbwZit7cjATj/x1b6y4hs0Uwb/AkRg34nMkov5Be3w8pYw9cgAQJNz
         0y7b2zuEUHFIQ==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NrxjS0rYSzfyL;
        Tue, 10 Jan 2023 11:54:04 -0500 (EST)
Message-ID: <c21ca3d7-9095-5613-5953-7870d9a6c23f@efficios.com>
Date:   Tue, 10 Jan 2023 11:54:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: rseq(2) man page
Content-Language: en-US
To:     Alejandro Colomar <alx.manpages@gmail.com>,
        linux-man@vger.kernel.org, Alejandro Colomar <alx@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, paulmck <paulmck@kernel.org>
References: <095c479b-baed-9d11-08a1-e698f59763d9@efficios.com>
 <425ddf00-24a1-bf02-29f1-937ba1545020@gmail.com>
 <71b43f20-5d6d-f3f8-b3cd-786dfbc8d34d@gmail.com>
 <c8cb6136-6924-4fae-f4bb-981dec2e1952@efficios.com>
 <71e6728d-c2a8-e646-5c6c-2de8dfa982cc@gmail.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <71e6728d-c2a8-e646-5c6c-2de8dfa982cc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 17:57, Alejandro Colomar wrote:
> Hi Mathieu,
> 
> On 1/6/23 21:57, Mathieu Desnoyers wrote:
>> On 2023-01-06 12:50, Alejandro Colomar wrote:
>>>> .I cpu_id_start
>>>> Always-updated value of the CPU number on which the registered 
>>>> thread is
>>>> running. Its value is guaranteed to always be a possible CPU number,
>>>> even when rseq is not registered. Its value should always be 
>>>> confirmed by
>>>
>>> rseq (and maybe other cases around too) should be formatted in 
>>> italics, since it's a variable name (.I).
>>
>> "rseq" here does not refer to a variable name, but rather to the 
>> system call. Should it be formatted in italics ? I format it as ".BR" 
>> elsewhere in the man page.
> 
> For referring to a function (or syscall), we use a bold name and 
> non-bold (roman) trailing parens; empty if it's defined in the same page.
> 
> So, it would be:
> 
> .BR rseq ()

OK

> 
>>>> .TP
>>>> .B EFAULT
>>>> .I rseq
>>>> is an invalid address.
>>>
>>> Doesn't this result in a SEGV?  It's trying to access invalid memory. 
>>> We had some discussion about this in other syscalls, and concluded 
>>> that that's undefined behavior, and a crash is valid behavior (and 
>>> probably a good thing to do), right?  I'm just curious about the view 
>>> from the kernel point of view.
>>
>> If the registered rseq pointer / size points to invalid memory on rseq 
>> registration, the rseq registration system call will return -1, 
>> errno=EFAULT. If at some point _after_ registration the mapping 
>> becomes invalid (e.g. unmapped without prior unregistration), then a 
>> SIGSEGV can be triggered.
>>
>> I was not aware of this discussion a regarding returning EFAULT errno 
>> vs SIGSEGV. If this is becoming a consensus across system calls to 
>> segfault  rather than return EFAULT errno, I'm open to improve 
>> sys_rseq accordingly.
> 
> The discussion was in libc-alpha:
> 
> <https://inbox.sourceware.org/libc-alpha/b55075c8-e55b-e492-7f4f-d6feb0ee2432@gmail.com/T/#u>
> 
> The reason is that, since holding a pointer to invalid memory is already 
> undefined behavior (the standard defines that as overflow[1]), passing 
> it to a syscall necessarily implies that you hold such a pointer, so UB 
> was invoked prior to the call, and thus the call is already within UB.
> 
> [1]:  <https://port70.net/%7Ensz/c/c11/n1570.html#6.5.6p8>
> 
> However, that discussion was in glibc; I don't know what kernel people 
> might think of that.  If you discuss that in the kernel, please link to 
> that glibc thread, and CC the people from that thread.

OK, let's keep this for a separate discussion.

> 
> 
> Now I'll add some comments for v2.
> 
> Cheers,
> 
> Alex
> 
> 
> --- v2:
> 
>> '\" t
> 
> This is a comment for pages that use tables (tbl(1)), so that man(1) 
> knows if it needs to run tbl(1) before roff(1).  It seems that your page 
> doesn't use tbl(1) features, so you should remove it.
> 
>> .\" Copyright 2015-2023 Mathieu Desnoyers 
>> <mathieu.desnoyers@efficios.com>
>> .\"
>> .\" SPDX-License-Identifier: Linux-man-pages-copyleft
>> .\"
>> .TH rseq 2 (date) "Linux man-pages (unreleased)"
>> .SH NAME
>> rseq \- restartable sequences system call
> 
> I forgot; there's a new section: LIBRARY.
> 
> It specifies the library in which the function is defined, or in the 
> case of syscalls, the wrapper (since we call it through syscall(2), it 
> would be libc).

OK. Similar to futex(2).

> 
> BTW, I wonder what librseq is.  Is librseq something that users should 
> care about?

Users are not required to use librseq to use the rseq system call,
but it's very convenient to use this C-level API rather than have
each user reimplement the per-architecture assembly code required to
create the RSEQ critical sections.

librseq did not have an official release yet, so that's mainly why I
think it too early to refer to it in manual pages.

> 
>> .SH SYNOPSIS
>> .nf
>> .PP
>> .BR "#include <linux/rseq.h>" \
>> " /* Definition of " RSEQ_* " constants and rseq types */"
> 
> The line above goes beyond column 80 in formatted output.  That's a hard 
> limit for manual pages.  If you add this page to the linux man-pages 
> repo, and run the linters, you'll see a warning about that.  In case 
> you're interested in linting manual pages in the future, you can do 
> something similar to what I do in the man-pages[2]

OK. I've used it, it's quite useful! I have fixed all warnings except for
"mandoc: man2/rseq.2:5:12: WARNING: cannot parse date, using it verbatim: (date)"
which I suspect is expected.

> 
> I decided to not include types in the comments.  The reason, apart from 
> having shorter comments, is that the man-pages now document types in 
> their own pages in subsection 3type.
> 
> Since I guess you don't want to go so far to write a new manual page for 
> the types (but if you want, feel free), since those types are specific 
> to this call, what you can do is specify the include that provides the 
> type, in the same piece of code where you document the type.
> 
>> .BR "#include #include <sys/syscall.h>" "    * Definition of " SYS_* " 
>> constants */"
> 
> The comment above seems broken.  See '/*'.

OK

> 
>> .B #include <unistd.h>
>> .PP
>> .BI "int syscall(SYS_rseq, struct rseq *_Nullable " rseq ", uint32_t " 
>> rseq_len \
> 
> What's the meaning for NULL?  Does it have a valid sentinel meaning, or 
> is it an invalid address?  If it's just interpreted as an invalid 
> address (for which from a user-space perspective a crash would be 
> legitimate), then I'd remove _Nullable.

With the flags that are currently implemented (0 or RSEQ_FLAG_UNREGISTER),
the rseq argument is not expected to be legitimately NULL (it would return
-1, errno=EFAULT on registration, or -1, errno=EINVAL on unregister attempt).

We may add new flags in the future which would not care about the rseq address
(it could very well be null then). Do you recommend that we only add the
_Nullable tag when this occurs ?

> 
>> ", int " flags ", uint32_t " sig ");
> 
> The last '"' is unmatched.
> 
> Also, this goes beyond 80-col.  Please cut after rseq_len (my mailer 
> will probably put the comma in a separate line; it should go at the end 
> of the line, preceeded by a space):
> 
> .BI "int syscall(SYS_rseq, struct rseq *_Nullable " rseq ", uint32_t " 
> rseq_len ,
> .BI "            int " flags ", uint32_t " sig );

OK

> 
> 
>> .fi
>> .PP
>> .IR Note :
>> glibc provides no wrapper for
>> .BR rseq (),
>> necessitating the use of
>> .BR syscall (2).
>> .SH DESCRIPTION
>> .PP
> 
> .PP after .SH or .SS is redundant, and should be removed.

OK

> 
>> The
>> .BR rseq ()
>> ABI accelerates specific user-space operations by registering a
>> per-thread data structure shared between kernel and user-space.
>> This data structure can be read from or written to by user-space to skip
>> otherwise expensive system calls.
>> .PP
>> A restartable sequence is a sequence of instructions guaranteed to be 
>> executed
>> atomically with respect to other threads and signal handlers on the 
>> current
>> CPU.
> 
> I'd break after "instructions", and after "respect to".

OK

> 
>> If its execution does not complete atomically, the kernel changes the
> 
> Breaking after commas is strongly preferred.

OK

> 
>> execution flow by jumping to an abort handler defined by user-space for
>> that restartable sequence.
>> .PP
>> Using restartable sequences requires to register a
>> rseq ABI per-thread data structure (
> 
> This produces a space after the '('.
> 
>> .B struct rseq
> 
> Instead, use:
> 
> .RB ( "struct rseq" )

OK

> 
>> ) through the
>> .BR rseq ()
>> system call.
>> Only one rseq ABI can be registered per thread, so user-space libraries
>> and applications must follow a user-space ABI defining how to share this
>> resource.
>> The ABI defining how to share this resource between applications and
>> libraries is defined by the C library.
>> Allocation of the per-thread rseq ABI and its registration to the kernel
>> is handled by glibc since version 2.35.
>> .PP
>> The rseq ABI per-thread data structure contains a
>> .I rseq_cs
>> field which points to the currently executing critical section.
>> For each thread, a single rseq critical section can run at any given
>> point.
>> Each critical section need to be implemented in assembly.
>> .PP
>> The
>> .BR rseq ()
>> ABI accelerates user-space operations on per-cpu data by defining a
>> shared data structure ABI between each user-space thread and the kernel.
>> .PP
>> It allows user-space to perform update operations on per-cpu data
>> without requiring heavy-weight atomic operations.
>> .PP
>> The term CPU used in this documentation refers to a hardware execution
>> context.
>> For instance, each CPU number returned by
>> .BR sched_getcpu ()
>> is a CPU.
>> The current CPU means to the CPU on which the registered thread is
>> running.
>> .PP
>> Restartable sequences are atomic with respect to preemption (making it
>> atomic with respect to other threads running on the same CPU),
>> as well as signal delivery (user-space execution contexts nested over
>> the same thread).
>> They either complete atomically with respect to preemption on the
>> current CPU and signal delivery, or they are aborted.
>> .PP
>> Restartable sequences are suited for update operations on per-cpu data.
>> .PP
>> Restartable sequences can be used on data structures shared between 
>> threads
>> within a process,
>> and on data structures shared between threads across different
>> processes.
>> .PP
>> Some examples of operations that can be accelerated or improved by 
>> this ABI:
>> .IP \(bu 3
>> Memory allocator per-cpu free-lists,
>> .IP \(bu 3
>> Querying the current CPU number,
>> .IP \(bu 3
>> Incrementing per-CPU counters,
>> .IP \(bu 3
>> Modifying data protected by per-CPU spinlocks,
>> .IP \(bu 3
>> Inserting/removing elements in per-CPU linked-lists,
>> .IP \(bu 3
>> Writing/reading per-CPU ring buffers content.
>> .IP \(bu 3
>> Accurately reading performance monitoring unit counters with respect to
>> thread migration.
>> .PP
>> Restartable sequences must not perform system calls.
>> Doing so may result in termination of the process by a segmentation
>> fault.
>> .PP
>> The
>> .I rseq
>> argument is a pointer to the thread-local rseq structure to be shared
>> between kernel and user-space.
>> .PP
>> The structure
>> .B struct rseq
>> is an extensible structure.
>> Additional feature fields can be added in future kernel versions.
>> Its layout is as follows:
>> .TP
>> .B Structure alignment
>> This structure is aligned on either 32-byte boundary,
>> or on the alignment value returned by
>> .I getauxval(
>> .B AT_RSEQ_ALIGN
>> )
>> if the structure size differs from 32 bytes.
>> .TP
>> .B Structure size
>> This structure size needs to be at least 32 bytes.
>> It can be either 32 bytes,
>> or it needs to be large enough to hold the result of
>> .I getauxval(
>> .B AT_RSEQ_FEATURE_SIZE
>> ) .
>> Its size is passed as parameter to the rseq system call.
>> .RS
> 
> For code examples we use .in +4n rather than .RS.  I don't remember the 
> exact reason, but it had some glitches in some cases.
OK

> 
>> .PP
> 
> This should be .IP, since it's a continuation of the tagged paragraph 
> (TP).  IP continues the indentation, while PP start a clean paragraph 
> that is not indented as the previous one.

OK

> 
>> .EX
> 
> You could add the #include <linux/rseq.h> here.

OK

> 
>> struct rseq {
>>     __u32 cpu_id_start;
>>     __u32 cpu_id;
>>     union {
>>         /* Edited out for conciseness. [...] */
> 
> You can simply say /* ... */
> 
> We use that in a few other places.

OK

> 
>>     } rseq_cs;
>>     __u32 flags;
>>     __u32 node_id;
>>     __u32 mm_cid;
>> } __attribute__((aligned(32)));
>> .EE
>> .RE
>> .TP
>> .B Fields
>> .RS
> 
> Here there should be another .TP
> 
>> .I cpu_id_start
>> .RS
> 
> And that TP would make this RS unnecessary, since it would indent the 
> paragraph.

OK

> 
>> Always-updated value of the CPU number on which the registered thread is
>> running.
>> Its value is guaranteed to always be a possible CPU number,
>> even when rseq is not registered.
>> Its value should always be confirmed by reading the cpu_id field before
>> user-space performs any side-effect
>> (e.g. storing to memory).
>> .PP
> 
> This should be a IP, to continue the indentation of the previous TP.

OK

> 
>> This field is always guaranteed to hold a valid CPU number in the range
>> [ 0 ..  nr_possible_cpus - 1 ].
>> It can therefore be loaded by user-space and used as an offset in
>> per-cpu data structures without having to check whether its value is
>> within the valid bounds compared to the number of possible CPUs in the
>> system.
> 
> Having a word alone in a line is usually a hint that there exists a 
> better point to break the sentence (except where .I or .B ask for it).

OK

> 
>> .PP
>> Initialized by user-space to a possible CPU number (e.g., 0),
>> updated by the kernel for threads registered with rseq.
> 
> rseq shoudl be formatted.

OK

> 
>> .PP
>> For user-space applications executed on a kernel without rseq support,
>> the cpu_id_start field stays initialized at 0, which is indeed a valid
>> CPU number.
>> It is therefore valid to use it as an offset in per-cpu data structures,
>> and only validate whether it's actually the current CPU number by
>> comparing it with the cpu_id field within the rseq critical section.
>> If the kernel does not provide rseq support, that cpu_id field stays
>> initialized at -1,
>> so the comparison always fails, as intended.
>> .PP
>> This field should only be read by the thread which registered this data
>> structure.
>> Aligned on 32-bit.
>> .PP
>> It is up to user-space to implement a fall-back mechanism for 
>> scenarios where
> 
> s/user-space/user space/

OK

> 
> The - is used as in natural English, for form an adjective.  Since here 
> it acts as a subject, it goes with a space.

Yes.

> 
>> rseq is not available.
>> .RE
>> .PP
>> .I cpu_id
>> .RS
>> Always-updated value of the CPU number on which the registered thread is
>> running.
>> Initialized by user-space to -1,
>> updated by the kernel for threads registered with rseq.
>> .PP
>> This field should only be read by the thread which registered this data
>> structure.
>> Aligned on 32-bit.
>> .RE
>> .PP
>> .I rseq_cs
>> .RS
>> The rseq_cs field is a pointer to a
>> .B struct rseq_cs .
>> Is is NULL when no rseq assembly block critical section is active for
>> the registered thread.
>> Setting it to point to a critical section descriptor (
>> .B struct rseq_cs
>> ) marks the beginning of the critical section.
>> .PP
>> Initialized by user-space to NULL.
>> .PP
>> Updated by user-space, which sets the address of the currently
>> active rseq_cs at the beginning of assembly instruction sequence
>> block,
>> and set to NULL by the kernel when it restarts an assembly instruction
>> sequence block,
>> as well as when the kernel detects that it is preempting or delivering a
>> signal outside of the range targeted by the rseq_cs.
>> Also needs to be set to NULL by user-space before reclaiming memory that
>> contains the targeted
>> .B struct rseq_cs .
>> .PP
>> Read and set by the kernel.
>> .PP
>> This field should only be updated by the thread which registered this
>> data structure.
>> Aligned on 64-bit.
>> .RE
>> .PP
>> .I flags
>> .RS
>> Flags indicating the restart behavior for the registered thread.
>> This is mainly used for debugging purposes.
>> Can be a combination of:
>> .TP
>> .B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
>> Inhibit instruction sequence block restart on preemption for this
>> thread.
>> This flag is deprecated since kernel 6.1.
> 
> I did some consistency fixes regarding linux versions.  Now we always 
> use "Linux x.y", rather than "Linux kernel x.y", or "kernel x.y".  That 
> helps grepping.

OK

[...]

Updated version based on your comments pushed into my repo, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

