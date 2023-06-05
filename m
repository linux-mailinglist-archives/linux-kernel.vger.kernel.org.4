Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BFF723116
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjFEUUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjFEUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:20:34 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C4DC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 13:20:04 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so42215ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 13:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685996404; x=1688588404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uF1ataoELCPxK/RLFPfq/jRAixemBv/oBBhahbL9Gg=;
        b=czm7ZMqs5JQGq7FfPi36Kle2eIBOWz70bIEZBaIR915rz/F3EVf6iZcSWHC8R1SWmC
         lLAljSHciFr1UExso7TrykMYKsbriFi1h8W9Dt8LHThMpag+mcrizhf7Fp7U5eVyOuAb
         XNyzcILfv3YPn4s0oKiikKvyzK+3t3Vxm1bkhi6ncKDtimxt49bquDs6aqUnBP0xE7vq
         cIDPw/2jYoO441TpDceFiCHFTfOsxdTZo1dvdMg2N8q4rbe+4ERBtxgz8xBx/Q3u+QXB
         hCdrXWfLHeNEgKgd1+DWoul9FCL271Yg1bODq6DniH62sbe7UIapAf0ZWbCY3OmT52mA
         JS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685996404; x=1688588404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uF1ataoELCPxK/RLFPfq/jRAixemBv/oBBhahbL9Gg=;
        b=cYe9WByL48FkTpXoqHrHojoBmJXIese20JspSh2Y7ESG/GaY3zyAdzoKweJxF7iaG/
         daw7dzPZ3GrBc34m2P6eDj+mkX0vUmoAAdDpv2VPDZcnFD9BJ9NY0ZXLF/yUU7qj69vT
         M/6Tnq1P+bMzH6NwRxcvKFWt0gZksPgCMjgP0xNb++1m535f8HGjU6a0m/AbT4PDc4pO
         fn7+UZ2zOiLZtCmYBxYBjtn0GtBaCA/I3bpCs8///1koGD3T0+48dZNsf1t2oO66YyXG
         /I3+IUG/0Ll16KkIiAkR8GPRZw+JvrHjXUwSiNIzdj5sXJ1nFie1+SNv/5aTh1vgcl+4
         H/4A==
X-Gm-Message-State: AC+VfDwhutzC5x2L0ybmfk+Vz/9yYXvFLuMwd3fiDOGfYdonyIXY/xEP
        WxPvgPwJxSf+XoA4TID+ofAYl0aBXuwl2yy466qTRQ==
X-Google-Smtp-Source: ACHHUZ6Yu3KawSoR/1ciaVIxDoE0dHRVip7h/cD5sgOZSLnxoZ4YCRw61tYD7iCWIeJC2Qf3uBpR3ycqBIeJEwMyv0E=
X-Received: by 2002:a05:6e02:180e:b0:33d:8444:c071 with SMTP id
 a14-20020a056e02180e00b0033d8444c071mr30136ilv.5.1685996403561; Mon, 05 Jun
 2023 13:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230605191346.1600336-1-irogers@google.com> <ZH45XeYtvkc56WtV@kernel.org>
In-Reply-To: <ZH45XeYtvkc56WtV@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 5 Jun 2023 13:19:52 -0700
Message-ID: <CAP-5=fV2S1iyjVnwM9ivGjyfCxkb+YUY-4y__=OLNHZnMs=9Wg@mail.gmail.com>
Subject: Re: [PATCH v2] tools headers: Make the difference output easier to read
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 12:37=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Jun 05, 2023 at 12:13:46PM -0700, Ian Rogers escreveu:
> > Add failures to an array and display it before exiting.
> >
> > Before:
> > ```
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' d=
iffers from latest version at 'include/uapi/linux/perf_event.h'
> > diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_e=
vent.h
> > Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_r=
egs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_reg=
s.h'
> > diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/includ=
e/uapi/asm/perf_regs.h
> > Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' =
differs from latest version at 'arch/arm64/include/asm/cputype.h'
> > diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
> > ...
> > ```
> >
> > After:
> > ```
> > Warning: Kernel ABI header differences:
> >   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf=
_event.h
> >   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/incl=
ude/uapi/asm/perf_regs.h
> >   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm=
/cputype.h
> > ...
> > ```
>
> Here I'm seeing it twice, I was expecting what is in the cset log
> message, that looks perfect: shows what is different while keeping a
> line to cut'n'paste and indents the diff lines so that the warnings
> stand out in the output, can you please take a look?

Yep, sorry I left in a debug echo.

Ian

> =E2=AC=A2[acme@toolbox perf-tools-next]$ alias m
> alias m=3D'perf stat -e cycles:u,instructions:u make -k BUILD_BPF_SKEL=3D=
1 CORESIGHT=3D1 PYTHON=3Dpython3 O=3D/tmp/build/perf-tools-next -C tools/pe=
rf install-bin && git status && perf test python'
> =E2=AC=A2[acme@toolbox perf-tools-next]$ m
> make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
>   BUILD:   Doing 'make -j32' parallel build
> tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
> tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm=
/perf_regs.h
> tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_e=
vent.h
>   diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/includ=
e/uapi/asm/perf_regs.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
>
>   INSTALL libsubcmd_headers
>
>
> > The aim is to make the warnings easier to read and distinguish from
> > other Makefile warnings messages.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > v2. Is a rebase, avoids the warning message if there are no diffs,
> >     adds diff to the output for easier copy and paste.
> > ---
> >  tools/perf/check-headers.sh | 233 ++++++++++++++++++++----------------
> >  1 file changed, 129 insertions(+), 104 deletions(-)
> >
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index 6f831ee2f60f..bcad6a7d8e5d 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -1,113 +1,122 @@
> > -#!/bin/sh
> > +#!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -FILES=3D'
> > -include/uapi/linux/const.h
> > -include/uapi/drm/drm.h
> > -include/uapi/drm/i915_drm.h
> > -include/uapi/linux/fadvise.h
> > -include/uapi/linux/fcntl.h
> > -include/uapi/linux/fs.h
> > -include/uapi/linux/fscrypt.h
> > -include/uapi/linux/kcmp.h
> > -include/uapi/linux/kvm.h
> > -include/uapi/linux/in.h
> > -include/uapi/linux/mount.h
> > -include/uapi/linux/openat2.h
> > -include/uapi/linux/perf_event.h
> > -include/uapi/linux/prctl.h
> > -include/uapi/linux/sched.h
> > -include/uapi/linux/stat.h
> > -include/uapi/linux/usbdevice_fs.h
> > -include/uapi/linux/vhost.h
> > -include/uapi/sound/asound.h
> > -include/linux/bits.h
> > -include/vdso/bits.h
> > -include/linux/const.h
> > -include/vdso/const.h
> > -include/linux/hash.h
> > -include/linux/list-sort.h
> > -include/uapi/linux/hw_breakpoint.h
> > -arch/x86/include/asm/disabled-features.h
> > -arch/x86/include/asm/required-features.h
> > -arch/x86/include/asm/cpufeatures.h
> > -arch/x86/include/asm/inat_types.h
> > -arch/x86/include/asm/emulate_prefix.h
> > -arch/x86/include/asm/irq_vectors.h
> > -arch/x86/include/asm/msr-index.h
> > -arch/x86/include/uapi/asm/prctl.h
> > -arch/x86/lib/x86-opcode-map.txt
> > -arch/x86/tools/gen-insn-attr-x86.awk
> > -arch/arm/include/uapi/asm/perf_regs.h
> > -arch/arm64/include/uapi/asm/perf_regs.h
> > -arch/loongarch/include/uapi/asm/perf_regs.h
> > -arch/mips/include/uapi/asm/perf_regs.h
> > -arch/powerpc/include/uapi/asm/perf_regs.h
> > -arch/s390/include/uapi/asm/perf_regs.h
> > -arch/x86/include/uapi/asm/perf_regs.h
> > -arch/x86/include/uapi/asm/kvm.h
> > -arch/x86/include/uapi/asm/kvm_perf.h
> > -arch/x86/include/uapi/asm/svm.h
> > -arch/x86/include/uapi/asm/unistd.h
> > -arch/x86/include/uapi/asm/vmx.h
> > -arch/powerpc/include/uapi/asm/kvm.h
> > -arch/s390/include/uapi/asm/kvm.h
> > -arch/s390/include/uapi/asm/kvm_perf.h
> > -arch/s390/include/uapi/asm/sie.h
> > -arch/arm/include/uapi/asm/kvm.h
> > -arch/arm64/include/uapi/asm/kvm.h
> > -arch/arm64/include/uapi/asm/unistd.h
> > -arch/alpha/include/uapi/asm/errno.h
> > -arch/mips/include/asm/errno.h
> > -arch/mips/include/uapi/asm/errno.h
> > -arch/parisc/include/uapi/asm/errno.h
> > -arch/powerpc/include/uapi/asm/errno.h
> > -arch/sparc/include/uapi/asm/errno.h
> > -arch/x86/include/uapi/asm/errno.h
> > -include/asm-generic/bitops/arch_hweight.h
> > -include/asm-generic/bitops/const_hweight.h
> > -include/asm-generic/bitops/__fls.h
> > -include/asm-generic/bitops/fls.h
> > -include/asm-generic/bitops/fls64.h
> > -include/linux/coresight-pmu.h
> > -include/uapi/asm-generic/errno.h
> > -include/uapi/asm-generic/errno-base.h
> > -include/uapi/asm-generic/ioctls.h
> > -include/uapi/asm-generic/mman-common.h
> > -include/uapi/asm-generic/unistd.h
> > -'
> > -
> > -SYNC_CHECK_FILES=3D'
> > -arch/x86/include/asm/inat.h
> > -arch/x86/include/asm/insn.h
> > -arch/x86/lib/inat.c
> > -arch/x86/lib/insn.c
> > -'
> > +YELLOW=3D'\033[0;33m'
> > +NC=3D'\033[0m' # No Color
> > +
> > +declare -a FILES
> > +FILES=3D(
> > +  "include/uapi/linux/const.h"
> > +  "include/uapi/drm/drm.h"
> > +  "include/uapi/drm/i915_drm.h"
> > +  "include/uapi/linux/fadvise.h"
> > +  "include/uapi/linux/fcntl.h"
> > +  "include/uapi/linux/fs.h"
> > +  "include/uapi/linux/fscrypt.h"
> > +  "include/uapi/linux/kcmp.h"
> > +  "include/uapi/linux/kvm.h"
> > +  "include/uapi/linux/in.h"
> > +  "include/uapi/linux/mount.h"
> > +  "include/uapi/linux/openat2.h"
> > +  "include/uapi/linux/perf_event.h"
> > +  "include/uapi/linux/prctl.h"
> > +  "include/uapi/linux/sched.h"
> > +  "include/uapi/linux/stat.h"
> > +  "include/uapi/linux/usbdevice_fs.h"
> > +  "include/uapi/linux/vhost.h"
> > +  "include/uapi/sound/asound.h"
> > +  "include/linux/bits.h"
> > +  "include/vdso/bits.h"
> > +  "include/linux/const.h"
> > +  "include/vdso/const.h"
> > +  "include/linux/hash.h"
> > +  "include/linux/list-sort.h"
> > +  "include/uapi/linux/hw_breakpoint.h"
> > +  "arch/x86/include/asm/disabled-features.h"
> > +  "arch/x86/include/asm/required-features.h"
> > +  "arch/x86/include/asm/cpufeatures.h"
> > +  "arch/x86/include/asm/inat_types.h"
> > +  "arch/x86/include/asm/emulate_prefix.h"
> > +  "arch/x86/include/asm/irq_vectors.h"
> > +  "arch/x86/include/asm/msr-index.h"
> > +  "arch/x86/include/uapi/asm/prctl.h"
> > +  "arch/x86/lib/x86-opcode-map.txt"
> > +  "arch/x86/tools/gen-insn-attr-x86.awk"
> > +  "arch/arm/include/uapi/asm/perf_regs.h"
> > +  "arch/arm64/include/uapi/asm/perf_regs.h"
> > +  "arch/loongarch/include/uapi/asm/perf_regs.h"
> > +  "arch/mips/include/uapi/asm/perf_regs.h"
> > +  "arch/powerpc/include/uapi/asm/perf_regs.h"
> > +  "arch/s390/include/uapi/asm/perf_regs.h"
> > +  "arch/x86/include/uapi/asm/perf_regs.h"
> > +  "arch/x86/include/uapi/asm/kvm.h"
> > +  "arch/x86/include/uapi/asm/kvm_perf.h"
> > +  "arch/x86/include/uapi/asm/svm.h"
> > +  "arch/x86/include/uapi/asm/unistd.h"
> > +  "arch/x86/include/uapi/asm/vmx.h"
> > +  "arch/powerpc/include/uapi/asm/kvm.h"
> > +  "arch/s390/include/uapi/asm/kvm.h"
> > +  "arch/s390/include/uapi/asm/kvm_perf.h"
> > +  "arch/s390/include/uapi/asm/sie.h"
> > +  "arch/arm/include/uapi/asm/kvm.h"
> > +  "arch/arm64/include/uapi/asm/kvm.h"
> > +  "arch/arm64/include/uapi/asm/unistd.h"
> > +  "arch/alpha/include/uapi/asm/errno.h"
> > +  "arch/mips/include/asm/errno.h"
> > +  "arch/mips/include/uapi/asm/errno.h"
> > +  "arch/parisc/include/uapi/asm/errno.h"
> > +  "arch/powerpc/include/uapi/asm/errno.h"
> > +  "arch/sparc/include/uapi/asm/errno.h"
> > +  "arch/x86/include/uapi/asm/errno.h"
> > +  "include/asm-generic/bitops/arch_hweight.h"
> > +  "include/asm-generic/bitops/const_hweight.h"
> > +  "include/asm-generic/bitops/__fls.h"
> > +  "include/asm-generic/bitops/fls.h"
> > +  "include/asm-generic/bitops/fls64.h"
> > +  "include/linux/coresight-pmu.h"
> > +  "include/uapi/asm-generic/errno.h"
> > +  "include/uapi/asm-generic/errno-base.h"
> > +  "include/uapi/asm-generic/ioctls.h"
> > +  "include/uapi/asm-generic/mman-common.h"
> > +  "include/uapi/asm-generic/unistd.h"
> > +)
> > +
> > +declare -a SYNC_CHECK_FILES
> > +SYNC_CHECK_FILES=3D(
> > +  "arch/x86/include/asm/inat.h"
> > +  "arch/x86/include/asm/insn.h"
> > +  "arch/x86/lib/inat.c"
> > +  "arch/x86/lib/insn.c"
> > +)
> >
> >  # These copies are under tools/perf/trace/beauty/ as they are not used=
 to in
> >  # building object files only by scripts in tools/perf/trace/beauty/ to=
 generate
> >  # tables that then gets included in .c files for things like id->strin=
g syscall
> >  # tables (and the reverse lookup as well: string -> id)
> >
> > -BEAUTY_FILES=3D'
> > -include/linux/socket.h
> > -'
> > +declare -a BEAUTY_FILES
> > +BEAUTY_FILES=3D(
> > +  "include/linux/socket.h"
> > +)
> > +
> > +declare -a FAILURES
> >
> >  check_2 () {
> > -  file1=3D$1
> > -  file2=3D$2
> > +  tools_file=3D$1
> > +  orig_file=3D$2
> >
> >    shift
> >    shift
> >
> > -  cmd=3D"diff $* $file1 $file2 > /dev/null"
> > +  cmd=3D"diff $* $tools_file $orig_file > /dev/null"
> >
> > -  test -f $file2 && {
> > -    eval $cmd || {
> > -      echo "Warning: Kernel ABI header at '$file1' differs from latest=
 version at '$file2'" >&2
> > -      echo diff -u $file1 $file2
> > -    }
> > -  }
> > +  if [ -f "$orig_file" ] && ! eval "$cmd"
> > +  then
> > +    echo "$tools_file $orig_file"
> > +    FAILURES+=3D(
> > +      "$tools_file $orig_file"
> > +    )
> > +  fi
> >  }
> >
> >  check () {
> > @@ -115,7 +124,7 @@ check () {
> >
> >    shift
> >
> > -  check_2 tools/$file $file $*
> > +  check_2 "tools/$file" "$file" $*
> >  }
> >
> >  beauty_check () {
> > @@ -123,23 +132,29 @@ beauty_check () {
> >
> >    shift
> >
> > -  check_2 tools/perf/trace/beauty/$file $file $*
> > +  check_2 "tools/perf/trace/beauty/$file" "$file" $*
> >  }
> >
> >  # Check if we have the kernel headers (tools/perf/../../include), else
> >  # we're probably on a detached tarball, so no point in trying to check
> >  # differences.
> > -test -d ../../include || exit 0
> > +if ! [ -d ../../include ]
> > +then
> > +  echo -e "${YELLOW}Warning${NC}: Skipped check-headers due to missing=
 ../../include"
> > +  exit 0
> > +fi
> >
> >  cd ../..
> >
> >  # simple diff check
> > -for i in $FILES; do
> > -  check $i -B
> > +for i in "${FILES[@]}"
> > +do
> > +  check "$i" -B
> >  done
> >
> > -for i in $SYNC_CHECK_FILES; do
> > -  check $i '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
> > +for i in "${SYNC_CHECK_FILES[@]}"
> > +do
> > +  check "$i" '-I "^.*\/\*.*__ignore_sync_check__.*\*\/.*$"'
> >  done
> >
> >  # diff with extra ignore lines
> > @@ -160,8 +175,9 @@ check_2 tools/perf/arch/powerpc/entry/syscalls/sysc=
all.tbl arch/powerpc/kernel/s
> >  check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kern=
el/syscalls/syscall.tbl
> >  check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/=
kernel/syscalls/syscall_n64.tbl
> >
> > -for i in $BEAUTY_FILES; do
> > -  beauty_check $i -B
> > +for i in "${BEAUTY_FILES[@]}"
> > +do
> > +  beauty_check "$i" -B
> >  done
> >
> >  # check duplicated library files
> > @@ -169,3 +185,12 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/ha=
shmap.h
> >  check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> >
> >  cd tools/perf
> > +
> > +if [ ${#FAILURES[@]} -gt 0 ]
> > +then
> > +  echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
> > +  for i in "${FAILURES[@]}"
> > +  do
> > +    echo "  diff -u $i"
> > +  done
> > +fi
> > --
> > 2.41.0.rc0.172.g3f132b7071-goog
> >
>
> --
>
> - Arnaldo
