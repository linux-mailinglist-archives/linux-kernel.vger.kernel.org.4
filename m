Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37F4685E23
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 05:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjBAEEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 23:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjBAEEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 23:04:02 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4264D7D87;
        Tue, 31 Jan 2023 20:04:00 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id z1so8716090pfg.12;
        Tue, 31 Jan 2023 20:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lHDN7nfelsTZHJLDkHBVVsX0P+0tHjjZNqsTfz+y+bI=;
        b=LYFOT7mfrN/tdV+6nR0jxPXJOIqaZOb2QvMvPiDV2WRn2TEtd3cs2zd9rxT4bTPy/7
         ppAzg5lbnQT4VWS2S8qxn+uspJ8K5wy3A+TCGtG+aJuMIWzSkdpI9OwhosTl8KhPW+ko
         1VtInPbFSunSVsZIb6xy8lJWPrfbozE93u70LBZCZ84xyrUfAdfvfezlHpdtfVwjr4Dd
         GOJv6MAsjL/kxBnhYVZXkFLK7g9OYCfD5J41X16ryuuaX+ZaoauWALGkLJOMSLhon82t
         8xPFuW7iyvPiHa4iUO3XvXFszYbpeOas+PJR+e0IgF2gRSTApTJX7kF2L+ANKS7/x29S
         si6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHDN7nfelsTZHJLDkHBVVsX0P+0tHjjZNqsTfz+y+bI=;
        b=p4u7DMABTq25OtQ+Net26Ou4j56ALUBkOl6ib4GfoC4agZAtSEikBUNGv9gx7e0NDR
         Wmpd8V99gUljOeSocVeF2aeOsRMazByAOm5ssEsSv9JEm5jJkck5KCg8ibnnqvB/yHaV
         bhAELdpThQk+QG2wQ+kmoshatUPan7023VW/RXofvw12RdkVsI/Ntghz7K++nLVGB9al
         2WLfn+6n6EttIsrgRIT2eoPbVClQfMwAho/5GKREj+c9h8+drqlttXHyBiZJKCSbt8NN
         DOG+na9X6aK7km/FernAEpBNDOoXSaXXaSKB+a+YsiXDqXw9InYCYy399ckyj3a9oPa+
         YFIg==
X-Gm-Message-State: AO0yUKW4gXwS0ZJoTzM2OxqCg3o1U/uuLNRW7GXpvqVXF7Ild1fUZ9ur
        vyY+TQNCxGe41YtZ6/E/U5I=
X-Google-Smtp-Source: AK7set8g0ILoB8AnLrZKvQDcGmvRnqcBcLfKPfCjj83Wl2ZgExPHaPsj6Omdv8zdJ/FoxrIyIfdHgw==
X-Received: by 2002:a05:6a00:1392:b0:592:5e1d:c7d2 with SMTP id t18-20020a056a00139200b005925e1dc7d2mr1282872pfg.23.1675224239450;
        Tue, 31 Jan 2023 20:03:59 -0800 (PST)
Received: from debian.me (subs32-116-206-28-25.three.co.id. [116.206.28.25])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79483000000b0059250c374cesm9875341pfk.115.2023.01.31.20.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 20:03:58 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 31D6610612E; Wed,  1 Feb 2023 11:03:54 +0700 (WIB)
Date:   Wed, 1 Feb 2023 11:03:54 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     sshefali021@gmail.com, kstewart@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: add workload-tracing document to admin-guide
Message-ID: <Y9nkqhAS6EW2Lu8Z@debian.me>
References: <20230131221105.39216-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D4aY0NVIhLZOPm37"
Content-Disposition: inline
In-Reply-To: <20230131221105.39216-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D4aY0NVIhLZOPm37
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2023 at 03:11:05PM -0700, Shuah Khan wrote:
> Add a new section to the admin-guide with information of interest to
> application developers and system integrators doing analysis of the
> Linux kernel for safety critical applications.
>=20
> This section will contain documents supporting analysis of kernel
> interactions with applications, and key kernel subsystems expectations.
>=20
> Add a new workload-tracing document to this new section.
>=20
> Signed-off-by: Shefali Sharma <sshefali021@gmail.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v2: Addressed review comments on v2

I think you haven't addressed my comments there [1], so I have to
write the improv:

---- >8 ----

diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation=
/admin-guide/workload-tracing.rst
index 5fad64b4ebd66f..ac60ff9dec8f0e 100644
--- a/Documentation/admin-guide/workload-tracing.rst
+++ b/Documentation/admin-guide/workload-tracing.rst
@@ -27,10 +27,10 @@ Methodology
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 `strace <https://man7.org/linux/man-pages/man1/strace.1.html>`_ is a
-diagnostic, instructional, and debugging tool and can be used to discover
-the system resources in use by a workload. Once we discover and understand
-the workload needs, we can focus on them to avoid regressions and use it
-to evaluate safety considerations. We use strace tool to trace workloads.
+diagnostic, instructional, and debugging tool and can be used to
+discover the system resources in use by a workload by tracing it. Once
+we discover and understand the workload needs, we can focus on them to
+avoid regressions and use it to evaluate safety considerations.
=20
 This method of tracing using strace tells us the system calls invoked by
 the workload and doesn't include all the system calls that can be invoked
@@ -43,7 +43,7 @@ outlined here will trace and find all possible code paths=
=2E The completeness
 of the system usage information depends on the completeness of coverage of=
 a
 workload.
=20
-The goal is tracing a workload on a system running a default kernel without
+The goal is to trace workloads on a system running a default kernel without
 requiring custom kernel installs.
=20
 How do we gather fine-grained system information?
@@ -63,9 +63,9 @@ insight into the process. "perf annotate" tool generates =
the statistics of
 each instruction of the program. This document goes over the details of how
 to gather fine-grained information on a workload's usage of system resourc=
es.
=20
-We used strace to trace the perf, stress-ng, paxtest workloads to illustra=
te
-our methodology to discover resources used by a workload. This process can
-be applied to trace other workloads.
+In this document, we use strace to trace the perf, stress-ng, paxtest
+workloads to illustrate our methodology to discover resources used by a
+workload. This process can be applied to trace other workloads.
=20
 Getting the system ready for tracing
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -73,34 +73,38 @@ Getting the system ready for tracing
 Before we can get started we will show you how to get your system ready.
 We assume that you have a Linux distribution running on a physical system
 or a virtual machine. Most distributions will include strace command. Let=
=E2=80=99s
-install other tools that aren=E2=80=99t usually included to build Linux ke=
rnel.
+install other tools that aren=E2=80=99t usually pre-installed to build Lin=
ux kernel.
 Please note that the following works on Debian based distributions. You
 might have to find equivalent packages on other Linux distributions.
=20
 Install tools to build Linux kernel and tools in kernel repository.
 scripts/ver_linux is a good way to check if your system already has
-the necessary tools: ::
+the necessary tools::
=20
   sudo apt-get build-essentials flex bison yacc
   sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev=
 libperl-dev libdw-dev
=20
-cscope is a good tool to browse kernel sources. Let's install it now: ::
+cscope is a good tool to browse kernel sources. Let's install it now::
=20
   sudo apt-get install cscope
=20
-Install stress-ng and paxtest: ::
+Install stress-ng and paxtest::
=20
   apt-get install stress-ng
   apt-get install paxtest
=20
+You will also need to clone Linus's mainline tree, which can be grabbed
+by::
+ =20
+  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it linux
+
 Workload overview
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-As mentioned earlier, we used strace to trace perf bench, stress-ng and
-paxtest workloads to show how to analyze a workload and identify Linux
-subsystems used by these workloads. Let's start with an overview of these
-three workloads to get a better understanding of what they do and how to
-use them.
+As mentioned earlier, the workloads to be analyzed here are perf,
+stress-ng, and paxtest. Let's start with an overview of these three
+workloads to get a better understanding of what they do and how to use
+them.
=20
 perf bench (all) workload
 -------------------------
@@ -108,32 +112,34 @@ perf bench (all) workload
 The perf bench command contains multiple multi-threaded microkernel
 benchmarks for executing different subsystems in the Linux kernel and
 system calls. This allows us to easily measure the impact of changes,
-which can help mitigate performance regressions. It also acts as a common
-benchmarking framework, enabling developers to easily create test cases,
-integrate transparently, and use performance-rich tooling subsystems.
+which can help to mitigate performance regressions. It also acts as a
+common benchmarking framework, enabling developers to easily create test
+cases, integrate transparently, and use performance-rich tooling
+subsystems.
=20
 Stress-ng netdev stressor workload
 ----------------------------------
=20
 stress-ng is used for performing stress testing on the kernel. It allows
 you to exercise various physical subsystems of the computer, as well as
-interfaces of the OS kernel, using "stressor-s". They are available for
+interfaces of the OS kernel, using stressors. They are available for
 CPU, CPU cache, devices, I/O, interrupts, file system, memory, network,
-operating system, pipelines, schedulers, and virtual machines. Please refer
-to the `stress-ng man-page <https://www.mankier.com/1/stress-ng>`_ to
-find the description of all the available stressor-s. The netdev stressor
-starts specified number (N) of workers that exercise various netdevice
-ioctl commands across all the available network devices.
+operating system, pipelines, schedulers, and virtual machines. Please
+refer to the `stress-ng man-page <https://www.mankier.com/1/stress-ng>`_
+for the details of all available stressors. The netdev stressor starts
+specified number (N) of workers that exercise various netdevice ioctl
+commands across all the available network devices.
=20
 paxtest kiddie workload
 -----------------------
=20
 paxtest is a program that tests buffer overflows in the kernel. It tests
-kernel enforcements over memory usage. Generally, execution in some memory
-segments makes buffer overflows possible. It runs a set of programs that
-attempt to subvert memory usage. It is used as a regression test suite for
-PaX, but might be useful to test other memory protection patches for the
-kernel. We used paxtest kiddie mode which looks for simple vulnerabilities.
+kernel enforcements over memory usage. Generally, execution in some
+memory segments makes buffer overflows possible. It runs a set of
+programs that attempt to subvert memory usage. It is originally intended
+as a regression test suite for PaX, but can also useful to test other
+memory protection patches for the kernel. Here, we use paxtest kiddie
+mode which looks for simple vulnerabilities.
=20
 What is strace and how do we use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -155,51 +161,40 @@ suppressing the regular output. This attempts to show=
 system time (CPU time
 spent running in the kernel) independent of wall clock time. We plan to use
 these features to get information on workload system usage.
=20
-strace command supports basic, verbose, and stats modes. strace command wh=
en
-run in verbose mode gives more detailed information about the system calls
-invoked by a process.
+strace command supports basic ("strace <process>", verbose ("strace -v
+<process>"), and stats ("strace -v") modes. In verbose mode, strace
+gives more detailed information about syscalls invoked by a process.
=20
-Running strace -c generates a report of the percentage of time spent in ea=
ch
-system call, the total time in seconds, the microseconds per call, the tot=
al
-number of calls, the count of each system call that has failed with an err=
or
-and the type of system call made.
-
- * Usage: strace <command we want to trace>
- * Verbose mode usage: strace -v <command>
- * Gather statistics: strace -c <command>
-
-We used the =E2=80=9C-c=E2=80=9D option to gather fine-grained run-time st=
atistics in use
-by three workloads we have chose for this analysis.
-
- * perf
- * stress-ng
- * paxtest
+In stats mode, strace generates fine-grained run-time statistics report
+which consisted of: percentage of time spent in each system call; the
+total time in seconds; the microseconds per call; the total number of
+calls, the count of each system call that has failed with an error and
+the type of system call made.
=20
 What is cscope and how do we use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Now let=E2=80=99s look at `cscope <https://cscope.sourceforge.net/>`_, a c=
ommand
-line tool for browsing C, C++ or Java code-bases. We can use it to find
+line tool for browsing C, C++ or Java code-bases. You can use it to find
 all the references to a symbol, global definitions, functions called by a
 function, functions calling a function, text strings, regular expression
 patterns, files including a file.
=20
-We can use cscope to find which system call belongs to which subsystem.
-This way we can find the kernel subsystems used by a process when it is
-executed.
+In context of this document, you can use cscope to find which system
+call belongs to which subsystem. This way you can find the kernel
+subsystems used by a process when it is executed.
=20
-Let=E2=80=99s checkout the latest Linux repository and build cscope databa=
se: ::
+To begin using cscope, cd to the kernel sources directory and build the
+database::
=20
-  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it linux
   cd linux
   cscope -R -p10  # builds cscope.out database before starting browse sess=
ion
   cscope -d -p10  # starts browse session on cscope.out database
=20
-Note: Run "cscope -R -p10" to build the database and c"scope -d -p10" to
-enter into the browsing session. cscope by default cscope.out database.
-To get out of this mode press ctrl+d. -p option is used to specify the
-number of file path components to display. -p10 is optimal for browsing
-kernel sources.
+Here, "cscope -R -p10" builds the database and "cscope -d -p10" to
+browses the resulting database, which is by default in cscope.out. To
+quit browsing, type ctrl+d. -p option is used to specify the directory
+depth. The 10-level depth is sufficient for browsing kernel sources.
=20
 What is perf and how do we use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -210,21 +205,20 @@ a simple command line interface. Perf is based on the=
 perf_events interface
 exported by the kernel. It is very useful for profiling the system and
 finding performance bottlenecks in an application.
=20
-If you haven't already checked out the Linux mainline repository, you can =
do
-so and then build kernel and perf tool: ::
+Change to the kernel sources directory and build both kernel and perf tool=
::
=20
-  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it linux
   cd linux
   make -j3 all
   cd tools/perf
   make
=20
-Note: The perf command can be built without building the kernel in the
-repository and can be run on older kernels. However matching the kernel
-and perf revisions gives more accurate information on the subsystem usage.
+.. note::
+   The perf command can be built without building the kernel in the
+   repository and can be run on any kernels. However matching the kernel
+   and perf revisions gives more accurate information on the subsystem usa=
ge.
=20
-We used "perf stat" and "perf bench" options. For a detailed information on
-the perf tool, run "perf -h".
+Below, we will describe "perf stat" and "perf bench" options. For
+detailed help on perf tool, see "perf -h".
=20
 perf stat
 ---------
@@ -268,17 +262,17 @@ exercised:
  * SIOCGIFADDR, SIOCGIFNETMASK, SIOCGIFMETRIC, SIOCGIFMTU
  * SIOCGIFHWADDR, SIOCGIFMAP, SIOCGIFTXQLEN
=20
-The following command runs the stressor: ::
+To run the netdev stressor::
=20
   stress-ng --netdev 1 -t 60 --metrics command.
=20
-We can use the perf record command to record the events and information
-associated with a process. This command records the profiling data in the
-perf.data file in the same directory.
+Then you can use "perf record" command to record the events and
+information associated with a process. This command records the
+profiling data in the perf.data file in the same directory.
=20
-Using the following commands you can record the events associated with the
-netdev stressor, view the generated report perf.data and annotate the to
-view the statistics of each instruction of the program: ::
+For example, to record stress-ng stressor above, view the generated
+report and annotate it to gather statistics of each instruction of the
+program::
=20
   perf record stress-ng --netdev 1 -t 60 --metrics command.
   perf report
@@ -288,22 +282,21 @@ What is paxtest and how do we use it?
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 paxtest is a program that tests buffer overflows in the kernel. It tests
-kernel enforcements over memory usage. Generally, execution in some memory
-segments makes buffer overflows possible. It runs a set of programs that
-attempt to subvert memory usage. It is used as a regression test suite for
-PaX, and will be useful to test other memory protection patches for the
-kernel.
+kernel enforcements over memory usage. Generally, execution in some
+memory segments makes buffer overflows possible. It runs a set of
+programs that attempt to subvert memory usage. It is originally intend
+as a regression test suite for PaX, but it can also be useful to test
+other memory protection patches for the kernel.
=20
-paxtest provides kiddie and blackhat modes. The paxtest kiddie mode runs
-in normal mode, whereas the blackhat mode tries to get around the protecti=
on
+paxtest provides kiddie and blackhat modes. The former runs
+in normal mode, whereas the latter tries to get around the protection
 of the kernel testing for vulnerabilities. We focus on the kiddie mode here
-and combine "paxtest kiddie" run with "perf record" to collect CPU stack
-traces for the paxtest kiddie run to see which function is calling other
-functions in the performance profile. Then the "dwarf" (DWARF's Call Frame
-Information) mode can be used to unwind the stack.
+and combine it with perf to collect CPU stack
+traces for the paxtest run to see which function is calling other
+functions in the performance profile. Then stack unwinding can be done
+by specifying "--call-graph dwarf" option to perf.
=20
-The following command can be used to view resulting report in call-graph
-format: ::
+Thus, the combined commands are::
=20
   perf record --call-graph dwarf paxtest kiddie
   perf report --stdio
@@ -316,14 +309,17 @@ Now that we understand the workloads, let's start tra=
cing them.
 Tracing perf bench all workload
 -------------------------------
=20
-Run the following command to trace perf bench all workload: ::
+To trace all workloads under perf benchmark::
=20
- strace -c perf bench all
+  strace -c perf bench all
=20
-**System Calls made by the workload**
+The below table is the list of invoked syscalls, with number of
+times each is invoked, and the corresponding Linux subsystem.
=20
-The below table shows the system calls invoked by the workload, number of
-times each system call is invoked, and the corresponding Linux subsystem.
+.. note::
+
+   The syscall tables below are generated from example workloads. The actu=
al
+   figures may differ depending on workload being traced.
=20
 +-------------------+-----------+-----------------+-----------------------=
--+
 | System Call       | # calls   | Linux Subsystem | System Call (API)     =
  |
@@ -426,14 +422,11 @@ times each system call is invoked, and the correspond=
ing Linux subsystem.
 Tracing stress-ng netdev stressor workload
 ------------------------------------------
=20
-Run the following command to trace stress-ng netdev stressor workload: ::
+To trace netdev stress-ng workload::
=20
   strace -c  stress-ng --netdev 1 -t 60 --metrics
=20
-**System Calls made by the workload**
-
-The below table shows the system calls invoked by the workload, number of
-times each system call is invoked, and the corresponding Linux subsystem.
+The corresponding syscall table is:
=20
 +-------------------+-----------+-----------------+-----------------------=
--+
 | System Call       | # calls   | Linux Subsystem | System Call (API)     =
  |
@@ -520,14 +513,11 @@ times each system call is invoked, and the correspond=
ing Linux subsystem.
 Tracing paxtest kiddie workload
 -------------------------------
=20
-Run the following command to trace paxtest kiddie workload: ::
+To trace paxtest (kiddie mode) workload::
=20
- strace -c paxtest kiddie
+  strace -c paxtest kiddie
=20
-**System Calls made by the workload**
-
-The below table shows the system calls invoked by the workload, number of
-times each system call is invoked, and the corresponding Linux subsystem.
+The corresponding syscall table is:
=20
 +-------------------+-----------+-----------------+----------------------+
 | System Call       | # calls   | Linux Subsystem | System Call (API)    |
@@ -590,8 +580,10 @@ times each system call is invoked, and the correspondi=
ng Linux subsystem.
 Conclusion
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-This document is intended to be used as a guide on how to gather fine-grai=
ned
-information on the resources in use by workloads using strace.
+This document is intended to be used as a guide on how to gather
+fine-grained information on the resources in use by workloads using
+strace. You may want to consult references below in case you want to run
+strace for your workload needs.
=20
 References
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Thanks.

[1]: https://lore.kernel.org/linux-doc/Y9STCwt2FnYf4%2FX4@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--D4aY0NVIhLZOPm37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY9nkpgAKCRD2uYlJVVFO
o6TdAQDQk9+khkkcYA/f5UlDG8O2WFHmy6IkTe33UD2qUwzJAgD9HmLX6XjNVzhG
qcvSqijRfE9jJhDgKjFiOV/vfL7qbQc=
=RaSQ
-----END PGP SIGNATURE-----

--D4aY0NVIhLZOPm37--
