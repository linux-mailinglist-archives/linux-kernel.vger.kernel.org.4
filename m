Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE6627C97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiKNLoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKNLoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4ACFD2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:44:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA6F3B80E3E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7732C433D6;
        Mon, 14 Nov 2022 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668426238;
        bh=iD4SRt0ZX//1elKcCadrZysU+86x0awGGwlfpKQ4OmY=;
        h=From:To:Cc:Subject:Date:From;
        b=JdcQDNm0WuMwymkafzY3K6Cvb972fEIvDDKv33aUyHMFTHtmLvFpukUFOsF6eue3+
         k/nTaaDEvOjzwu0Cd7UCY+DboAueX3OQ9ZSJZbW/nW942gp3Uco5LgvJvyi1fSNIp8
         VqbeUjaKzIvH47tddROIAfcfyaOE3nOsuoWcBF7yJX1BEQ8zSrdyEoGdJ1+awBfRDt
         PO865dp0KPyysbBJDjWWoSUWAoa9OQ5qWxM2h9+p2C4vtBAOJKj5CRUZD7GSh4xlAd
         3XsgMOPWWQCQkt98IZVV/hFRZWdY4qV9TWa8DWVGarDg1jobjJKkHNKCJ+E5EaB/00
         IzKjxW4DdhtVQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Don Zickus <dzickus@redhat.com>, Hao Luo <haoluo@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Huang Rui <ray.huang@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Hubicka <jh@suse.de>,
        Jason Baron <jbaron@akamai.com>,
        Jiri Kosina <jikos@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Martin Liska <mliska@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mel Gorman <mgorman@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Miroslav Benes <mbenes@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Biener <RGuenther@suse.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 00/46] gcc-LTO support for the kernel
Date:   Mon, 14 Nov 2022 12:42:58 +0100
Message-Id: <20221114114344.18650-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the first call for comments (and kbuild complaints) for this
support of gcc (full) LTO in the kernel. Most of the patches come from
Andi. Me and Martin rebased them to new kernels and fixed the to-use
known issues. Also I updated most of the commit logs and reordered the
patches to groups of patches with similar intent.

The very first patch comes from Alexander and is pending on some x86
queue already (I believe). I am attaching it only for completeness.
Without that, the kernel does not boot (LTO reorders a lot).

In our measurements, the performance differences are negligible.

The kernel is bigger with gcc LTO due to more inlining. The next step
might be to play with non-static functions as we export everything, so
the compiler cannot actually drop anything (esp. inlined and no longer
needed functions).

Cc: Alexander Potapenko <glider@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Hao Luo <haoluo@google.com>
Cc: H.J. Lu <hjl.tools@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jan Hubicka <jh@suse.de>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Martin Liska <mliska@suse.cz>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Richard Biener <RGuenther@suse.com>
Cc: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Yonghong Song <yhs@fb.com>

Alexander Lobakin (1):
  x86/boot: robustify calling startup_{32,64}() from the decompressor
    code

Andi Kleen (36):
  Compiler Attributes, lto: introduce __noreorder
  tracepoint, lto: Mark static call functions as __visible
  static_call, lto: Mark static keys as __visible
  static_call, lto: Mark static_call_return0() as __visible
  static_call, lto: Mark func_a() as __visible_on_lto
  x86/alternative, lto: Mark int3_*() as global and __visible
  x86/paravirt, lto: Mark native_steal_clock() as __visible_on_lto
  x86/preempt, lto: Mark preempt_schedule_*thunk() as __visible
  x86/xen, lto: Mark xen_vcpu_stolen() as __visible
  x86, lto: Mark gdt_page and native_sched_clock() as __visible
  amd, lto: Mark amd pmu and pstate functions as __visible_on_lto
  entry, lto: Mark raw_irqentry_exit_cond_resched() as __visible
  export, lto: Mark __kstrtab* in EXPORT_SYMBOL() as global and
    __visible
  softirq, lto: Mark irq_enter/exit_rcu() as __visible
  btf, lto: Make all BTF IDs global on LTO
  init.h, lto: mark initcalls as __noreorder
  bpf, lto: mark interpreter jump table as __noreorder
  sched, lto: mark sched classes as __noreorder
  linkage, lto: use C version for SYSCALL_ALIAS() / cond_syscall()
  scripts, lto: re-add gcc-ld
  scripts, lto: use CONFIG_LTO for many LTO specific actions
  Kbuild, lto: Add Link Time Optimization support
  x86/purgatory, lto: Disable gcc LTO for purgatory
  x86/realmode, lto: Disable gcc LTO for real mode code
  x86/vdso, lto: Disable gcc LTO for the vdso
  scripts, lto: disable gcc LTO for some mod sources
  Kbuild, lto: disable gcc LTO for bounds+asm-offsets
  lib/string, lto: disable gcc LTO for string.o
  Compiler attributes, lto: disable __flatten with LTO
  Kbuild, lto: don't include weak source file symbols in System.map
  x86, lto: Disable relative init pointers with gcc LTO
  x86/livepatch, lto: Disable live patching with gcc LTO
  x86/lib, lto: Mark 32bit mem{cpy,move,set} as __used
  scripts, lto: check C symbols for modversions
  scripts/bloat-o-meter, lto: handle gcc LTO
  x86, lto: Finally enable gcc LTO for x86

Jiri Slaby (5):
  kbuild: pass jobserver to cmd_ld_vmlinux.o
  compiler.h: introduce __visible_on_lto
  compiler.h: introduce __global_on_lto
  btf, lto: pass scope as strings
  x86/apic, lto: Mark apic_driver*() as __noreorder

Martin Liska (4):
  kbuild: lto: preserve MAKEFLAGS for module linking
  x86/sev, lto: Mark cpuid_table_copy as __visible_on_lto
  mm/kasan, lto: Mark kasan mem{cpy,move,set} as __used
  kasan, lto: remove extra BUILD_BUG() in memory_is_poisoned

 Documentation/kbuild/index.rst      |  2 +
 Documentation/kbuild/lto-build.rst  | 76 +++++++++++++++++++++++++++++
 Kbuild                              |  3 ++
 Makefile                            |  6 ++-
 arch/Kconfig                        | 52 ++++++++++++++++++++
 arch/x86/Kconfig                    |  5 +-
 arch/x86/boot/compressed/head_32.S  |  2 +-
 arch/x86/boot/compressed/head_64.S  |  2 +-
 arch/x86/boot/compressed/misc.c     | 16 +++---
 arch/x86/entry/vdso/Makefile        |  2 +
 arch/x86/events/amd/core.c          |  2 +-
 arch/x86/include/asm/apic.h         |  4 +-
 arch/x86/include/asm/preempt.h      |  4 +-
 arch/x86/kernel/alternative.c       |  5 +-
 arch/x86/kernel/cpu/common.c        |  2 +-
 arch/x86/kernel/paravirt.c          |  2 +-
 arch/x86/kernel/sev-shared.c        |  2 +-
 arch/x86/kernel/tsc.c               |  2 +-
 arch/x86/lib/memcpy_32.c            |  6 +--
 arch/x86/purgatory/Makefile         |  2 +
 arch/x86/realmode/Makefile          |  1 +
 drivers/cpufreq/amd-pstate.c        | 15 +++---
 drivers/xen/time.c                  |  2 +-
 include/asm-generic/vmlinux.lds.h   |  2 +-
 include/linux/btf_ids.h             | 24 ++++-----
 include/linux/compiler.h            |  8 +++
 include/linux/compiler_attributes.h | 15 ++++++
 include/linux/export.h              |  6 ++-
 include/linux/init.h                |  2 +-
 include/linux/linkage.h             | 16 +++---
 include/linux/static_call.h         | 12 ++---
 include/linux/tracepoint.h          |  4 +-
 kernel/bpf/core.c                   |  2 +-
 kernel/entry/common.c               |  2 +-
 kernel/kallsyms.c                   |  2 +-
 kernel/livepatch/Kconfig            |  1 +
 kernel/sched/sched.h                |  1 +
 kernel/softirq.c                    |  4 +-
 kernel/static_call.c                |  2 +-
 kernel/static_call_inline.c         |  6 +--
 kernel/time/posix-stubs.c           | 19 +++++++-
 lib/Makefile                        |  2 +
 mm/kasan/generic.c                  |  2 +-
 mm/kasan/shadow.c                   |  6 +--
 scripts/Makefile.build              | 17 ++++---
 scripts/Makefile.lib                |  2 +-
 scripts/Makefile.lto                | 43 ++++++++++++++++
 scripts/Makefile.modfinal           |  2 +-
 scripts/Makefile.vmlinux            |  3 +-
 scripts/Makefile.vmlinux_o          |  6 +--
 scripts/bloat-o-meter               |  2 +-
 scripts/gcc-ld                      | 40 +++++++++++++++
 scripts/link-vmlinux.sh             |  9 ++--
 scripts/mksysmap                    |  2 +
 scripts/mod/Makefile                |  3 ++
 scripts/module.lds.S                |  2 +-
 56 files changed, 384 insertions(+), 100 deletions(-)
 create mode 100644 Documentation/kbuild/lto-build.rst
 create mode 100644 scripts/Makefile.lto
 create mode 100755 scripts/gcc-ld

-- 
2.38.1

