Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941D76970C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjBNW3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjBNW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:29:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E4526CCB;
        Tue, 14 Feb 2023 14:29:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id z13so12076366wmp.2;
        Tue, 14 Feb 2023 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3TsUS6WNi0Q9TNuSOGs7kk9bpZY+tI3UMbLas/YU60=;
        b=XP3xJQCvqGujRjTHeAxoDh6MHJVKQitCUXcC5PBQLuC+6o6U5tkSytUbfF+gvbK25x
         Ek6hYpK0ndyXqKBUiFZ4hVpU5tfKH3S6g500MeF8LeuVroP58dqcXF9NPiR3MC5hhKEb
         uCAvXCsyPbzLGM+UvUHhcdZbZCkONH2ZhAyldM7ML9tEVNJDknPYC8Wu/w03X87xFi+U
         kgO3NXt0RjBU/ee3U8zQ0maolyNS6fF0neKQXKMrfosTvkZpE7jX1nRlUXlqCrhSlOvV
         b9K1f6OgcJl8SPWMsYsCVISqbblNdl/UhymCymy9UDZpJ5arLc1+KW6qGpw3u9fPV4XB
         QOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q3TsUS6WNi0Q9TNuSOGs7kk9bpZY+tI3UMbLas/YU60=;
        b=7Cj4OmSGzRAoeS2SC6Twp9EqQExzQ/uKmQJrAjNz62qUnpnn2tfGlz8nml66BwQIwP
         JonAsAGdkwLnaIJ1DAcYJ8QD1K+Gjn0PC7NXIBN9jiKwHK8Y+fRM5V+x42msJMaLTnsF
         lGxhgJy48fpk6eTIkWtpHQVoKenMIAVlwNKOW2giln68FISd4lVv+8dX52roAmdqGYnh
         2APMc5hfedYgX9LfB06G3YiS7WlrqlFC6YJpnVxr9YHaAo35+Gtd+chovszRFXnCfT6V
         CQMMO0rNAPXQtRmse7jeVC2tqB6yZlEvLIphjq7mguW2bK3Qlp23XRNhgWrWtPdaMguq
         D0ag==
X-Gm-Message-State: AO0yUKV6HSKr0osg0UFFe6YrfmzYHtomVzyitC9U+eGsSKCKigePmYVw
        y0GmxCUwvtOa48Lmdn5enzw=
X-Google-Smtp-Source: AK7set/1yHWAlALUn/bmw7cKaKASJNEDjGIfWNRC7peYa3vcSHvVNEdPYwSNsyyHxzcgJYYrnnKmrA==
X-Received: by 2002:a05:600c:5409:b0:3df:f2a5:49fb with SMTP id he9-20020a05600c540900b003dff2a549fbmr364326wmb.7.1676413787375;
        Tue, 14 Feb 2023 14:29:47 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c445100b003dc1a525f22sm142435wmn.25.2023.02.14.14.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 14:29:46 -0800 (PST)
Message-ID: <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
Date:   Tue, 14 Feb 2023 23:29:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8WkFgBeLlvh8RkAuFLxSlLuZ"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8WkFgBeLlvh8RkAuFLxSlLuZ
Content-Type: multipart/mixed; boundary="------------YegK0pKgNRYQ4Ojx3TLkiOWK";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Andy Lutomirski <luto@amacapital.net>, Paul Turner <pjt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
 Ben Maurer <bmaurer@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>

--------------YegK0pKgNRYQ4Ojx3TLkiOWK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Mathieu and Branden,

On 2/14/23 20:54, Mathieu Desnoyers wrote:
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  man2/rseq.2 | 465 ++++++++++++++++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 465 insertions(+)
>  create mode 100644 man2/rseq.2
>=20
> diff --git a/man2/rseq.2 b/man2/rseq.2
> new file mode 100644
> index 000000000..ad3215d1c
> --- /dev/null
> +++ b/man2/rseq.2
> @@ -0,0 +1,465 @@
> +.\" Copyright 2015-2023 Mathieu Desnoyers <mathieu.desnoyers@efficios.=
com>
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH rseq 2 (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +rseq \- restartable sequences system call
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ", " \-lc )
> +.SH SYNOPSIS
> +.nf
> +.PP
> +.BR "#include <linux/rseq.h>" "       /* Definition of " RSEQ_* " cons=
tants */"
> +.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " const=
ants */"
> +.B #include <unistd.h>
> +.PP
> +.BI "int syscall(SYS_rseq, struct rseq *" rseq ", uint32_t " rseq_len =
,
> +.BI "            int " flags ", uint32_t " sig );
> +.fi
> +.PP
> +.IR Note :
> +glibc provides no wrapper for
> +.BR rseq (),
> +necessitating the use of
> +.BR syscall (2).
> +.SH DESCRIPTION
> +The
> +.BR rseq ()
> +ABI accelerates specific user-space operations by registering a
> +per-thread data structure shared between kernel and user-space.

This last 'user-space' is not adjectivated, so it should go without
a hyphen, according to common English rules.

> +This data structure can be read from or written to by user-space to sk=
ip

same here

> +otherwise expensive system calls.
> +.PP
> +A restartable sequence is a sequence of instructions
> +guaranteed to be executed atomically with respect to
> +other threads and signal handlers on the current CPU.
> +If its execution does not complete atomically,
> +the kernel changes the execution flow by jumping to an abort handler
> +defined by user-space for that restartable sequence.

same here

> +.PP
> +Using restartable sequences requires to register a
> +.BR rseq ()
> +ABI per-thread data structure
> +.RB ( "struct rseq" )

We format types in italics, so this should be '.RI'.

> +through the
> +.BR rseq ()
> +system call.
> +Only one
> +.BR rseq ()
> +ABI can be registered per thread, so user-space libraries and
> +applications must follow a user-space ABI defining how to share this
> +resource.

Please use semantic newlines.  See man-pages(7):

   Use semantic newlines
       In  the source of a manual page, new sentences should be started o=
n new
       lines, long sentences should be split into lines at clause breaks =
(com=E2=80=90
       mas, semicolons, colons, and so on), and long clauses should  be  =
split
       at  phrase  boundaries.   This convention, sometimes known as "sem=
antic
       newlines", makes it easier to see the effect of  patches,  which  =
often
       operate at the level of individual sentences, clauses, or phrases.=


In the above lines, that would mean breaking after the comma, and not lea=
ving resource in a line of its own.

> +The ABI defining how to share this resource between applications and
> +libraries is defined by the C library.
> +Allocation of the per-thread
> +.BR rseq ()
> +ABI and its registration to the kernel is handled by glibc since versi=
on
> +2.35.
> +.PP
> +The
> +.BR rseq ()
> +ABI per-thread data structure contains a
> +.I rseq_cs
> +field which points to the currently executing critical section.

currently-executing should probably use a hyphen
(if I understood the line correctly).
However, you might want to reorder the phrase to remove the need for that=
=2E

See an interesting discussion in the groff@ mailing list:
<https://lists.gnu.org/archive/html/groff/2022-10/msg00015.html>

> +For each thread, a single rseq critical section can run at any given
> +point.
> +Each critical section need to be implemented in assembly.

needs?

> +.PP
> +The
> +.BR rseq ()
> +ABI accelerates user-space operations on per-cpu data by defining a
> +shared data structure ABI between each user-space thread and the kerne=
l.
> +.PP
> +It allows user-space to perform update operations on per-cpu data
> +without requiring heavy-weight atomic operations.
> +.PP
> +The term CPU used in this documentation refers to a hardware execution=

> +context.
> +For instance, each CPU number returned by
> +.BR sched_getcpu ()
> +is a CPU.
> +The current CPU means to the CPU on which the registered thread is
> +running.
> +.PP
> +Restartable sequences are atomic with respect to preemption (making it=

> +atomic with respect to other threads running on the same CPU),
> +as well as signal delivery (user-space execution contexts nested over
> +the same thread).
> +They either complete atomically with respect to preemption on the
> +current CPU and signal delivery, or they are aborted.
> +.PP
> +Restartable sequences are suited for update operations on per-cpu data=
=2E
> +.PP
> +Restartable sequences can be used on data structures shared between th=
reads
> +within a process,
> +and on data structures shared between threads across different
> +processes.
> +.PP
> +Some examples of operations that can be accelerated or improved by thi=
s ABI:
> +.IP \(bu 3

Please use \[bu]

We changed that recently:
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3D=
36f73ba37945c7ff4aa2d8383f831519a38e3f27>

> +Memory allocator per-cpu free-lists,
> +.IP \(bu 3
> +Querying the current CPU number,
> +.IP \(bu 3
> +Incrementing per-CPU counters,
> +.IP \(bu 3
> +Modifying data protected by per-CPU spinlocks,
> +.IP \(bu 3
> +Inserting/removing elements in per-CPU linked-lists,
> +.IP \(bu 3
> +Writing/reading per-CPU ring buffers content.
> +.IP \(bu 3
> +Accurately reading performance monitoring unit counters with respect t=
o
> +thread migration.
> +.PP
> +Restartable sequences must not perform system calls.
> +Doing so may result in termination of the process by a segmentation
> +fault.
> +.PP
> +The
> +.I rseq
> +argument is a pointer to the thread-local
> +.B struct rseq
> +to be shared between kernel and user-space.
> +.PP
> +The structure
> +.B struct rseq
> +is an extensible structure.
> +Additional feature fields can be added in future kernel versions.
> +Its layout is as follows:
> +.TP
> +.B Structure alignment

Let's remove the bold here.  It's not necessary for marking a constant or=
 something that needs bold.  And the indentation is already making it sta=
nd out, so bold is a bit too much aggressive to the reader.

> +This structure is aligned on either 32-byte boundary,
> +or on the alignment value returned by
> +.IR getauxval ()
> +invoked with
> +.B AT_RSEQ_ALIGN
> +if the structure size differs from 32 bytes.
> +.TP
> +.B Structure size
> +This structure size needs to be at least 32 bytes.
> +It can be either 32 bytes,
> +or it needs to be large enough to hold the result of
> +.IR getauxval ()
> +invoked with
> +.BR AT_RSEQ_FEATURE_SIZE .

Maybe it's simpler to use getauxval(AT_RSEQ_FEATURE_SIZE) as an expressio=
n?

If you decide to do so, it should go in italics (see man-pages(7)).

       Complete commands should, if long, be written as an  indented  lin=
e  on
       their own, with a blank line before and after the command, for exa=
mple

           man 7 man-pages

       If the command is short, then it can be included inline in the tex=
t, in
       italic  format,  for example, man 7 man=E2=80=90pages.  In this ca=
se, it may be
       worth using nonbreaking spaces (\[ti]) at suitable places in  the =
 com=E2=80=90
       mand.  Command options should be written in italics (e.g., -l).

       Expressions,  if  not  written  on  a separate indented line, shou=
ld be
       specified in italics.  Again, the use of nonbreaking spaces may be=
  ap=E2=80=90
       propriate if the expression is inlined with normal text.


> +Its size is passed as parameter to the
> +.BR rseq ()
> +system call.
> +.in +4n
> +.IP
> +.EX
> +#include <linux/rseq.h>
> +
> +struct rseq {
> +    __u32 cpu_id_start;
> +    __u32 cpu_id;
> +    union {
> +        /* ... */
> +    } rseq_cs;
> +    __u32 flags;
> +    __u32 node_id;
> +    __u32 mm_cid;
> +} __attribute__((aligned(32)));
> +.EE
> +.in
> +.TP
> +.B Fields
> +.RS
> +.TP
> +.I cpu_id_start
> +Always-updated value of the CPU number on which the registered thread =
is
> +running.
> +Its value is guaranteed to always be a possible CPU number,
> +even when
> +.BR rseq ()
> +is not registered.
> +Its value should always be confirmed by reading the cpu_id field befor=
e

cpu_id should be formatted (.I).

> +user-space performs any side-effect
> +(e.g. storing to memory).
> +.IP
> +This field is always guaranteed to hold a valid CPU number in the rang=
e
> +[ 0 ..  nr_possible_cpus - 1 ].

Please use interval notation:
	[0, nr_possible_cpus)
or
	[0, nr_possible_cpus - 1]
whichever looks better to you.

We did some consistency fix recently:
<https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=3D=
147a60d792a5db8f3cb93ea16eefb73e16c1fb91>

Also, do we have a more standard way of saying nr_possible_cpus?
Should we say nproc?

> +It can therefore be loaded by user-space
> +and used as an offset in per-cpu data structures
> +without having to check whether its value is within the valid bounds
> +compared to the number of possible CPUs in the system.
> +.IP
> +Initialized by user-space to a possible CPU number (e.g., 0),
> +updated by the kernel for threads registered with
> +.BR rseq ().
> +.IP
> +For user-space applications executed on a kernel without
> +.BR rseq ()
> +support,
> +the cpu_id_start field stays initialized at 0,
> +which is indeed a valid CPU number.
> +It is therefore valid to use it as an offset in per-cpu data structure=
s,
> +and only validate whether it's actually the current CPU number by
> +comparing it with the cpu_id field within the rseq critical section.
> +If the kernel does not provide
> +.BR rseq ()
> +support, that cpu_id field stays initialized at -1,
> +so the comparison always fails, as intended.
> +.IP
> +This field should only be read by the thread which registered this dat=
a
> +structure.
> +Aligned on 32-bit.
> +.IP
> +It is up to user space to implement a fall-back mechanism for scenario=
s where
> +.BR rseq ()
> +is not available.
> +.TP
> +.I cpu_id
> +Always-updated value of the CPU number on which the registered thread =
is
> +running.
> +Initialized by user-space to -1,
> +updated by the kernel for threads registered with
> +.BR rseq ().
> +.IP
> +This field should only be read by the thread which registered this dat=
a
> +structure.
> +Aligned on 32-bit.
> +.TP
> +.I rseq_cs
> +The rseq_cs field is a pointer to a
> +.BR "struct rseq_cs" .
> +Is is NULL when no rseq assembly block critical section is active for

"It is"

> +the registered thread.
> +Setting it to point to a critical section descriptor
> +.RB ( "struct rseq_cs")
> +marks the beginning of the critical section.
> +.IP
> +Initialized by user-space to NULL.
> +.IP
> +Updated by user-space, which sets the address of the currently
> +active rseq_cs at the beginning of assembly instruction sequence
> +block,
> +and set to NULL by the kernel when it restarts an assembly instruction=

> +sequence block,
> +as well as when the kernel detects that it is preempting or delivering=
 a
> +signal outside of the range targeted by the rseq_cs.
> +Also needs to be set to NULL by user-space before reclaiming memory th=
at
> +contains the targeted
> +.BR "struct rseq_cs" .
> +.IP
> +Read and set by the kernel.
> +.IP
> +This field should only be updated by the thread which registered this
> +data structure.
> +Aligned on 64-bit.
> +.TP
> +.I flags
> +Flags indicating the restart behavior for the registered thread.
> +This is mainly used for debugging purposes.
> +Can be a combination of:
> +.RS
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> +Inhibit instruction sequence block restart on preemption for this
> +thread.
> +This flag is deprecated since Linux 6.1.
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> +Inhibit instruction sequence block restart on signal delivery for this=

> +thread.
> +This flag is deprecated since Linux 6.1.
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> +Inhibit instruction sequence block restart on migration for this threa=
d.
> +This flag is deprecated since Linux 6.1.
> +.RE
> +.IP
> +Initialized by user-space, used by the kernel.
> +.TP
> +.I node_id
> +Always-updated value of the current NUMA node ID.
> +.IP
> +Initialized by user-space to 0.
> +.IP
> +Updated by the kernel.
> +Read by user-space with single-copy atomicity semantics.
> +This field should only be read by the thread which registered
> +this data structure.
> +Aligned on 32-bit.
> +.TP
> +.I mm_cid
> +Contains the current thread's concurrency ID
> +(allocated uniquely within a memory map).
> +.IP
> +Updated by the kernel.
> +Read by user-space with single-copy atomicity semantics.
> +This field should only be read by the thread which registered this dat=
a
> +structure.
> +Aligned on 32-bit.
> +.IP
> +This concurrency ID is within the possible cpus range,
> +and is temporarily (and uniquely) assigned while threads are actively
> +running within a memory map.
> +If a memory map has fewer threads than cores,
> +or is limited to run on few cores concurrently through sched affinity =
or
> +cgroup cpusets,
> +the concurrency IDs will be values close to 0,
> +thus allowing efficient use of user-space memory for per-cpu data
> +structures.
> +.RE
> +.PP
> +The layout of
> +.B struct rseq_cs
> +version 0 is as follows:
> +.TP
> +.B Structure alignment
> +This structure is aligned on 32-byte boundary.
> +.TP
> +.B Structure size
> +This structure has a fixed size of 32 bytes.
> +.in +4n
> +.IP
> +.EX
> +#include <linux/rseq.h>
> +
> +struct rseq_cs {
> +    __u32   version;
> +    __u32   flags;
> +    __u64   start_ip;
> +    __u64   post_commit_offset;
> +    __u64   abort_ip;
> +} __attribute__((aligned(32)));
> +.EE
> +.in
> +.TP
> +.B Fields

Branden, IIRC, this seems to be the reason why I didn't want .RS for inde=
nting code examples.  It doesn't fit nicely right after TP.

Why is there a blank line?  I'm not even sure that's reasonable.  Is it a=
 (minor) bug in man(7)?  (FWIW, mandoc(1) is consistent with groff(1).)

> +.RS
> +.TP
> +.I version
> +Version of this structure.
> +Should be initialized to 0.
> +.TP
> +.I flags
> +.RS
> +Flags indicating the restart behavior of this structure.
> +Can be a combination of:
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
> +Inhibit instruction sequence block restart on preemption for this
> +critical section.
> +This flag is deprecated since Linux 6.1.
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL
> +Inhibit instruction sequence block restart on signal delivery for this=

> +critical section.
> +This flag is deprecated since Linux 6.1.
> +.TP
> +.B RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
> +Inhibit instruction sequence block restart on migration for this
> +critical section.
> +This flag is deprecated since Linux 6.1.
> +.RE
> +.TP
> +.I start_ip
> +Instruction pointer address of the first instruction of the sequence o=
f
> +consecutive assembly instructions.
> +.TP
> +.I post_commit_offset
> +Offset (from start_ip address) of the address after the last instructi=
on
> +of the sequence of consecutive assembly instructions.
> +.TP
> +.I abort_ip
> +Instruction pointer address where to move the execution flow in case o=
f
> +abort of the sequence of consecutive assembly instructions.
> +.RE
> +.PP
> +The
> +.I rseq_len
> +argument is the size of the
> +.B struct rseq
> +to register.
> +.PP
> +The
> +.I flags
> +argument is 0 for registration, and
> +.B RSEQ_FLAG_UNREGISTER
> +for unregistration.
> +.PP
> +The
> +.I sig
> +argument is the 32-bit signature to be expected before the abort
> +handler code.
> +.PP
> +A single library per process should keep the
> +.B struct rseq
> +in a per-thread data structure.
> +The
> +.I cpu_id
> +field should be initialized to -1, and the
> +.I cpu_id_start
> +field should be initialized to a possible CPU value (typically 0).
> +.PP
> +Each thread is responsible for registering and unregistering its
> +.BR "struct rseq" .
> +No more than one
> +.B struct rseq
> +address can be registered per thread at a given time.
> +.PP
> +Reclaim of
> +.B struct rseq
> +object's memory must only be done after either an explicit rseq
> +unregistration is performed or after the thread exits.
> +.PP
> +In a typical usage scenario, the thread registering the
> +.B struct rseq
> +will be performing loads and stores from/to that structure.
> +It is however also allowed to read that structure from other threads.
> +The
> +.B struct rseq
> +field updates performed by the kernel provide relaxed atomicity
> +semantics (atomic store, without memory ordering),
> +which guarantee that other threads performing relaxed atomic reads
> +(atomic load, without memory ordering) of the cpu number fields will
> +always observe a consistent value.
> +.SH RETURN VALUE
> +A return value of 0 indicates success.
> +On error, \-1 is returned, and
> +.I errno
> +is set appropriately.

Michael tried to add some consistency to the RETURN VALUE (and EXIT STATU=
S) sections.
Please have a look at `git show 30b0d8d97e5e^..31e9088393e4`.

> +.SH ERRORS
> +.TP
> +.B EINVAL
> +Either
> +.I flags
> +contains an invalid value, or
> +.I rseq
> +contains an address which is not appropriately aligned, or
> +.I rseq_len
> +contains an incorrect size.
> +.TP
> +.B ENOSYS
> +The
> +.BR rseq ()
> +system call is not implemented by this kernel.
> +.TP
> +.B EFAULT
> +.I rseq
> +is an invalid address.
> +.TP
> +.B EBUSY
> +Restartable sequence is already registered for this thread.
> +.TP
> +.B EPERM
> +The
> +.I sig
> +argument on unregistration does not match the signature received
> +on registration.
> +.SH VERSIONS
> +The
> +.BR rseq ()
> +system call was added in Linux 4.18.
> +.SH STANDARDS
> +.BR rseq ()
> +is Linux-specific.
> +.SH SEE ALSO
> +.BR sched_getcpu (3) ,
> +.BR membarrier (2) ,
> +.BR getauxval (3)

Cheers,

Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------YegK0pKgNRYQ4Ojx3TLkiOWK--

--------------8WkFgBeLlvh8RkAuFLxSlLuZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmPsC1EACgkQnowa+77/
2zJtzxAAq+2ZNZpaAy6wkuHpAlCYSGHZlqsXCTiNcPsNxgS2NOdFxMlLoOm64Lot
23uqr1C8Pybe42kDiz78OmyPNasF6f+jqE/70w24X2RyEPW2tywPd/3Am7rUR9qT
EQoPh1o9CGG3XA2oDkogpgUo2/tL49AC9WN+WFtSFMnRzt3Qap7Mqil+WiuEU4s7
T3Se3zRGR8lLGP8HDhKTLq31rV2/18S77vjBIvXAdii/oNROWD42twdU9P/cghnX
J/htZe17nPClf7x6MMH/EraFpy1tndi1680NbaUw4i3hUhIifZHvL5Av83iH62gI
TTX+BwkHkpIqDVAdL+akfIbStCx+QJ5oC7YRXcrmmLGOl/wRf2h4vwjbNicEa7et
rqtu71NoLV6ESBLNMcuH/wvAvKnUqNKYtW3UTe58NX01WTPTO+omeVDuIYGg5BGS
kYUpH0WDFV0mVMcBuVRn45vsUanqdooAnk1i9dEYH0lOZ8OoHc4QdV+3Nn80lXqe
Xp9Ke94U0ehrp+FJO1S6BOUL5P8b5U+gHCVzuxpl/3Qh0qEDQCfqG0XYbrC7TkUK
YTqnB4PNImMZ7RIR49hHzosFMHtuCI8sOvg4slC5bzRGBtxL+Wp+ElnEJoRFFX+N
06DPiedIy0MXlImvGmlCrvLS8shaMnGJvV1XsZnUUWJ9ymnqC4I=
=QFTS
-----END PGP SIGNATURE-----

--------------8WkFgBeLlvh8RkAuFLxSlLuZ--
