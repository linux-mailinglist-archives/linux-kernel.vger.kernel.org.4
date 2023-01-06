Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7545066088B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjAFU46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjAFU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:56:54 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE727621D;
        Fri,  6 Jan 2023 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1673038610;
        bh=mIpPvSR0E3RBuJNwpf/LWHGKauuTSilo6mXWERzZ1fY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=RzQxeDJnFzqOYx4T2Lvb+QJPlSlox75gKnTKZpQVo12gIa7KhyOhxc9/0YbSjRl2n
         CqM+p8xJ4ZGcb9EAHN/8cuowuFhjBvACRFOPpJecf8GbXd+eEI5pSA7HhpZ1ZyRYrT
         gmcATczdslADDGedAN+/102hLDt+UB/+isPqEmGuXR4QwPnxHKhHUjH1yeBnR1xKyQ
         ciRRnR8RXEyNi/wRCtu44RdwF73U4Vri8ltV3Vm0vQt/tG8cnz+uVd0lglmQUh2duX
         RSoItBGTCh1lS6ZuAmiG5nrdCIgpgUbTTqmLONmg0d+muABsWA33HuiNOjhk48mGyh
         7alHGr43ZDV8A==
Received: from [172.16.0.101] (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NpbHQ1srjzdJ4;
        Fri,  6 Jan 2023 15:56:50 -0500 (EST)
Message-ID: <c8cb6136-6924-4fae-f4bb-981dec2e1952@efficios.com>
Date:   Fri, 6 Jan 2023 15:57:21 -0500
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <71b43f20-5d6d-f3f8-b3cd-786dfbc8d34d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-06 12:50, Alejandro Colomar wrote:
> Hi Mathieu,
> 
> See some comments below.
> 
> Cheers,
> 
> Alex

[...]

> 
> We now use SPDX-License-Identifier.

OK

> 
>> .\"
>> .TH RSEQ 2 2020-06-05 "Linux" "Linux Programmer's Manual"
> 
> We use lowercase for the function name (or to be more precise, the same 
> case that the function name uses.
> 
> The date is specified with a placeholder that is replaced at the time of 
> creation of the tarball.
> 
> The 5th argument is unspecified.
> 
> The 4th argument is now the project name and a placeholder for the version.
> 
> See an example:
> 
> $ cat man2/membarrier.2 | grep '^.TH'
> .TH membarrier 2 (date) "Linux man-pages (unreleased)"

OK

> 
> 
>> .SH NAME
>> rseq \- Restartable sequences system call
> 
> We use lowercase here, so s/Restartable/restartable/

OK

> 
>> .SH SYNOPSIS
>> .nf
>> .B #include <linux/rseq.h>
> 
> Is there a glibc wrapper for this syscall?  Do you expect that it will 
> be added relatively soon?  Or is it expected that this syscall will be 
> called through syscall(2) for many years?

The system call is only for registering/unregistering the per-thread 
area, so I expect it will only be used through syscall(2), and typically 
only from libc.

User applications/libraries are expected to use the per-thread area to 
communicate with the kernel, but that does not require use of rseq(2).

> 
> If so, it may be better to document it directly as such, like for 
> example membarrier:
> 
> SYNOPSIS
>         #include <linux/membarrier.h> /* Definition of MEMBARRIER_* 
> constants */
>         #include <sys/syscall.h>      /* Definition of SYS_* constants */
>         #include <unistd.h>
> 
>         int syscall(SYS_membarrier, int cmd, unsigned int flags, int 
> cpu_id);
> 
>         Note: glibc provides no wrapper for membarrier(), necessitating 
> the use
>         of syscall(2).
> 

OK

>> .sp
> 
> s/sp/PP/

OK

> 
>> .BI "int rseq(struct rseq * " rseq ", uint32_t " rseq_len ", int " 
>> flags ", 
> 
> Is it valid to pass NULL in 'rseq'?  If it is, we now document that 
> using _Nullable.  See for example recv(2):
> 
> SYNOPSIS
>         #include <sys/socket.h>
> 
>         ssize_t recv(int sockfd, void buf[.len], size_t len,
>                          int flags);
>         ssize_t recvfrom(int sockfd, void buf[restrict .len], size_t len,
>                          int flags,
>                          struct sockaddr *_Nullable restrict src_addr,
>                          socklen_t *_Nullable restrict addrlen);
>         ssize_t recvmsg(int sockfd, struct msghdr *msg, int flags);
> 

OK

> 
> 
> 
>> uint32_t " sig ");
>> .sp
> 
> .sp is unnecessary here.

OK

> 
> .fi is missing (it's the "closing" pair to .nf).

OK

> 
>> .SH DESCRIPTION
>>
> 
> Use .PP instead of blank lines.

OK

> 
>> The
>> .BR rseq ()
>> ABI accelerates specific user-space operations by registering a
>> per-thread data structure shared between kernel and user-space. This
> 
> Use semantic newlines.  See man-pages(7):
> 
>     Use semantic newlines
>         In  the source of a manual page, new sentences should be started 
> on new
>         lines, long sentences should be split into lines at clause 
> breaks (com‐
>         mas, semicolons, colons, and so on), and long clauses should  
> be  split
>         at  phrase  boundaries.   This convention, sometimes known as 
> "semantic
>         newlines", makes it easier to see the effect of  patches,  
> which  often
>         operate at the level of individual sentences, clauses, or phrases.
> 

OK, done across the entire the manual page source.

[...]

>> .PP
>> Some examples of operations that can be accelerated or improved
>> by this ABI:
>> .IP \[bu] 2
> 
> Use 3 instead of 2.  See man-pages:
> 
>     Lists
>         There are different kinds of lists:
> 
>         [...]
> 
>         Bullet lists
>                Elements  are  preceded by bullet symbols (\(bu).  
> Anything that
>                doesn’t fit elsewhere is usually covered by this type of 
> list.
> 
>         [...]
> 
>         There should always be exactly 2 spaces between the list symbol 
> and the
>         elements.  This doesn’t apply to "tagged paragraphs", which use 
> the de‐
>         fault indentation rules.
> 
> 
> The rationale for that was that if you use 1 space, then the list 
> introducer can be confused with the list contents.  Two spaces makes the 
> difference more clear.

OK

> 
> 
> Also, we use \(bu instead of \[bu].  I'm not particularly worried by 
> using it, but I prefer being consistent at which one we use.

OK

[...]

>>
>> .TP
>> .in +4n
> 
> I guess you're looking for .RS/.RE.  It would wrap all the indented 
> stuff, replacing .in.

OK.


> 
>> .I cpu_id_start
>> Always-updated value of the CPU number on which the registered thread is
>> running. Its value is guaranteed to always be a possible CPU number,
>> even when rseq is not registered. Its value should always be confirmed by
> 
> rseq (and maybe other cases around too) should be formatted in italics, 
> since it's a variable name (.I).

"rseq" here does not refer to a variable name, but rather to the system 
call. Should it be formatted in italics ? I format it as ".BR" elsewhere 
in the man page.

I'll push a first update without the italics changes, please let me know 
if there are still issues left.

[...]

>> .in +4n
>> .I flags
>> Flags indicating the restart behavior of this structure. Can be a 
>> combination
>> of:
>> .IP \[bu]
> 
> This list should be a tagged paragraph instead.  See man-pages(7):
> 
>     Lists
>         There are different kinds of lists:
> 
>         Tagged paragraphs
>                These  are used for a list of tags and their 
> descriptions.  When
>                the tags are constants (either macros or numbers)  they  
> are  in
>                bold.  Use the .TP macro.
> 
>                An example is this "Tagged paragraphs" subsection is itself.
> 
>         [...]
> 
>         Bullet lists
>                Elements  are  preceded by bullet symbols (\(bu).  
> Anything that
>                doesn’t fit elsewhere is usually covered by this type of 
> list.
> 
>         [...]

OK

[...]

>> .SH RETURN VALUE
>> A return value of 0 indicates success. On error, \-1 is returned, and
>> .I errno
>> is set appropriately.
>>
>> .SH ERRORS
>> .TP
>> .B EINVAL
>> Either
>> .I flags
>> contains an invalid value, or
>> .I rseq
>> contains an address which is not appropriately aligned, or
>> .I rseq_len
>> contains an incorrect size.
>> .TP
>> .B ENOSYS
>> The
>> .BR rseq ()
>> system call is not implemented by this kernel.
>> .TP
>> .B EFAULT
>> .I rseq
>> is an invalid address.
> 
> Doesn't this result in a SEGV?  It's trying to access invalid memory.  
> We had some discussion about this in other syscalls, and concluded that 
> that's undefined behavior, and a crash is valid behavior (and probably a 
> good thing to do), right?  I'm just curious about the view from the 
> kernel point of view.

If the registered rseq pointer / size points to invalid memory on rseq 
registration, the rseq registration system call will return -1, 
errno=EFAULT. If at some point _after_ registration the mapping becomes 
invalid (e.g. unmapped without prior unregistration), then a SIGSEGV can 
be triggered.

I was not aware of this discussion a regarding returning EFAULT errno vs 
SIGSEGV. If this is becoming a consensus across system calls to segfault 
  rather than return EFAULT errno, I'm open to improve sys_rseq accordingly.

> 
>> .TP
>> .B EBUSY
>> Restartable sequence is already registered for this thread.
>> .TP
>> .B EPERM
>> The
>> .I sig
>> argument on unregistration does not match the signature received
>> on registration.
>>
>> .SH VERSIONS
>> The
>> .BR rseq ()
>> system call was added in Linux 4.18.
>>
>> .SH CONFORMING TO
> 
> We call that section STANDARDS now.

OK

I've done a first pass applying all the relevant changes. I've pushed 
the changes into the librseq master branch. I may have omitted 
bold/italic for some identifiers. If it's the case, please let me know.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

