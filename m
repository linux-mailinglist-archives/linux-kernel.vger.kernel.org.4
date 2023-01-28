Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1EF67F445
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1DPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjA1DPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:15:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D58B7BD;
        Fri, 27 Jan 2023 19:14:30 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so6478974pjl.0;
        Fri, 27 Jan 2023 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8u8BLsAC7MJfW/eOLyTdr8KOt7Z/0K6Jjodb+6UVQ/A=;
        b=XtIqWw+07w5XbTt07BtNRBl4gmsunl3w00OhRpcZQnYnSlbB+k3Z6wRvPZ9BRIbnNP
         G4Millumt7OWvjiPpHBTyB183m3QiP6jNQCTbILBrD47SATj41fdPtuHGtkB0I9+jCdm
         yOXxblmrZHQDTgldSeJfT92PJKJQfipgMHjPHXHK+jZHLDL7jtAtl4+0pn6s5egUKx5j
         EO0j9zGBTOVk9eAurKO6H5usKL7oENkspgjyj09aLhnwMUtRobPGC1oK3xIxeaDRTPPV
         QuFDGBHXwIuJajLJAu60Kgnz6ROWaUU1EftQt9sGbURGnHTgZPd0sHqiXDHOhsgUaTTb
         S8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u8BLsAC7MJfW/eOLyTdr8KOt7Z/0K6Jjodb+6UVQ/A=;
        b=oqIWZp4HpIyM9xJ73aV5Kb0sAyszk+4jOAz3REz+opDFHdICT3reb3ow6iVi/7ybBy
         iJuDbEVxaCfLYRa9/AmjPNv/Ppjmt+VIsqzseJrOg1E4APXvQQBhd1YwGH+nhv3Yz5xB
         L7FBdHBC6gKANvJR9DzgyUUuVQL4CW2sl9y41J+WILArvPS7frZ4oYLd+vonmQO1nRyN
         n7/qfh2+/y5OShbrKnEMa3iu0upm2+hAYTJuqnAT6cDjOhpt1a39y1nv8RrQo7ocX6Zv
         h5MZ/Xt9UeHFP/gR6VxiGZTrQ7EhoZFOJkz19wy6DThm4pn9rzJuPWxmVO02kiYsuD21
         m4Tw==
X-Gm-Message-State: AO0yUKUZK6m+kM/ZfV/sANODmabAFx3j78xxdscRrk1mgbDVZvQxTaBF
        mOXVt+l3wwKA8xZafYQUOOY=
X-Google-Smtp-Source: AK7set8udeHMPFfFdXDSq1UbXc0PGw6iacAtrFFlHgvlvyB2jYevrH82Oqik6UFSx5oqjIdoCOygyQ==
X-Received: by 2002:a17:903:484:b0:196:2295:8cde with SMTP id jj4-20020a170903048400b0019622958cdemr11634770plb.56.1674875662356;
        Fri, 27 Jan 2023 19:14:22 -0800 (PST)
Received: from debian.me (subs02-180-214-232-16.three.co.id. [180.214.232.16])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902690300b001948af092d0sm3550238plk.152.2023.01.27.19.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 19:14:21 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 3F3AB1055A0; Sat, 28 Jan 2023 10:14:19 +0700 (WIB)
Date:   Sat, 28 Jan 2023 10:14:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: add workload-tracing document to admin-guide
Message-ID: <Y9STCwt2FnYf4/X4@debian.me>
References: <20230127234616.55137-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2GGYwLuvcBLp9AwQ"
Content-Disposition: inline
In-Reply-To: <20230127234616.55137-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2GGYwLuvcBLp9AwQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 04:46:16PM -0700, Shuah Khan wrote:
> +strace tool can be used to trace system calls made by a process and sign=
als
> +it receives. a process to the perf, stress-ng, paxtest workloads. System

"... to trace system calls made by a process (which can be perf, stress-ng,
paxtest workloads, or neither)."

> +Before we can get started we will have to get our system ready. We assume

"Before we can get started the system must be prepared first."

> +Browsing kernel sources ::

"To browse kernel sources, you will need:"

> +Workload overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +We used strace to trace perf bench, stress-ng and paxtest workloads to

"In this section, we use strace to trace ..."

> +show how to analyze a workload and identify Linux subsystems used by
> +these workloads. We hope this process can be applied to trace workload(s=
).
> +We will go over the workloads first.

"This process can also be applied to trace other workloads."

> +
> +perf bench (all) workload:
> +--------------------------
> +
> <snipped>
> +
> +Stress-ng netdev stressor workload:
> +-----------------------------------
> +
> <snipped>
> +
> +paxtest kiddie workload:
> +------------------------
> +
> <snipped>

Drop trailing colon from these subsection texts.

> +We used the =E2=80=9C-c=E2=80=9D option to gather fine grained informati=
on.

```
The basic usage is strace <command>. To run verbose tracing, specify -v
to strace. To generate the report, specify -c option.
```

> +Now let=E2=80=99s look at `cscope <https://cscope.sourceforge.net/>`_, a=
 command
> +line tool for browsing C, C++ or Java code-bases. We can use it to find
> +all the references to a symbol, global definitions, functions called by a
> +function, functions calling a function, text strings, regular expression
> +patterns, files including a file.
> +
> +We can use cscope to find which system call belongs to which subsystem.
> +This way we can find the kernel subsystems used by a process when it is
> +executed. To use it navigate to the source code directory. Here we are
> +analyzing the kernel source tree.

I guess "you" is better fit for the wording above?

> +We used perf stat and perf bench options. For a detailed information on =
the
> +perf tool, run perf -h.

"In this section, we highlight stat and bench options. For help on other
options, see perf -h."

> +**perf bench all** command runs the following benchmarks: ::

Either don't markup that command or inline it (``perf bench all``).
Also, use bullet list for benchmarking list below.

> +
> +  sched/messaging
> +  sched/pipe
> +  syscall/basic
> +  mem/memcpy
> +  mem/memset
> +

> +The netdev stressor starts N workers that exercise various netdevice ioc=
tl
> +commands across all the available network devices. The following ioctls =
are
> +exercised: ::
> +
> +  SIOCGIFCONF, SIOCGIFINDEX, SIOCGIFNAME, SIOCGIFFLAGS
> +  SIOCGIFADDR, SIOCGIFNETMASK, SIOCGIFMETRIC, SIOCGIFMTU
> +  SIOCGIFHWADDR, SIOCGIFMAP, SIOCGIFTXQLEN

Again, use bullet list instead.

> +
> +The following command runs the stressor: ::
> +
> +  stress-ng --netdev 1 -t 60 --metrics command.

Simply end the sentence with double colon to make the code block above.

> +
> +We can use the perf record command to record the events and information
> +associated with a process. This command records the profiling data in the
> +perf.data file in the same directory.
> +
> +Using the following commands you can record the events associated with t=
he
> +netdev stressor, view the generated report perf.data and annotate the to
> +see the statistics of each instruction of the program. ::

"... view the generated report and statistics::"

> +
> +  perf record stress-ng --netdev 1 -t 60 --metrics command.
> +  perf report
> +  perf annotate
> +
> +What is paxtest and how do we use it?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +paxtest is a program that tests buffer overflows in the kernel. It tests
> +kernel enforcements over memory usage. Generally, execution in some memo=
ry
> +segments makes buffer overflows possible. It runs a set of programs that
> +attempt to subvert memory usage. It is used as a regression test suite f=
or
> +PaX, and will be useful to test other memory protection patches for the
> +kernel.
> +
> +paxtest provides kiddie and blackhat modes. paxtest kiddie mode runs in
> +normal mode, whereas blackhat mode tries to get around the protection of
> +the kernel testing for vulnerabilities. We focus on the kiddie mode here
> +and combine "paxtest kiddie" run with "perf record" to collect CPU stack
> +traces for the paxtest kiddie run to see which function is calling other
> +functions in the performance profile. Then the "dwarf" (DWARF's CFI - Ca=
ll
> +Frame Information) mode can be used to unwind the stack. The resulting
> +report can be viewed in call-graph format as follows: ::
> +

"... The resulting reported can be viewed in dwarf call-graph format by::"

> +  perf record --call-graph dwarf paxtest kiddie
> +  perf report --stdio
> +
> +Tracing workloads
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Now that we understand the workloads, let's start tracing them.

What are the workloads? I don't see any definition here.

> +
> +Tracing perf bench all workload
> +-------------------------------
> +
> +Run the following command to trace perf bench all workload: ::
> +
> + strace -c perf bench all
> +
> +**System Calls made by the workload:**

What about third level heading (with tilde underline)?

> +
> +The following table shows you the system calls, number of times the syst=
em
> +call was invoked, and the Linux subsystem they fall under.

"Below table is the list of syscalls, with number of times each is invoked,
and the corresponding subsystem:"

> +**System Calls made by the workload:**
> +
> +The following table shows you the system calls, number of times the syst=
em
> +call was invoked, and the Linux subsystem they fall under.

Same here.

> +**System Calls made by the workload:**
> +
> +The following table shows you the system calls, number of times the syst=
em
> +call was invoked, and the Linux subsystem they fall under.

Again, same here.

But I guess the syscall tables are from the example workload (YMMV)?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--2GGYwLuvcBLp9AwQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9STBwAKCRD2uYlJVVFO
o6B8AP4mAhhKYriVYwPkOMh5/IteqZY9IaNF466YzL6rAzlFlwD/UU6/B3UycHpi
yJHCpeWI1ZTkyyE+niAJeyocQfQgTQY=
=+7Hg
-----END PGP SIGNATURE-----

--2GGYwLuvcBLp9AwQ--
