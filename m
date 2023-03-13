Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB776B8282
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCMUPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCMUP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:15:29 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41D713DF0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:15:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id bf15so5515674iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678738502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hgKQ7KfFX5TnUgqB1mXKhvwGGdwNEUMUIKTxUeLuZk=;
        b=rXJlC7jayMk4LTP+rXMGPzDpUX393wSNxmjsn/qB//bBv4Fki+ieG+oHj3Ii2tCvak
         Nr5fbh8jMP4YVVW19JunJHNPXiuJU5fuR/mMhXF4ICu3OELBX8v/3JQDIuFrjCODT9b2
         +iuDm38HevTklfuseAYuOjM1YLpMZIPU0iYjih0X+zwu4ac7ZXt+Ed5HOoYHQUEZbJ9n
         BT3k+QbnXqk4SHLoiv4crKBRCBHQBtp4B71XV4NjlgeW58XyyjuyOprSa0AS7xpcj5ZT
         ZLrqW+v051suG6AzbOtPw337vtaZ4MkE+dnZtmAjQxXXJutaMvh3q2D363TJmx9KAFv8
         z+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678738502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hgKQ7KfFX5TnUgqB1mXKhvwGGdwNEUMUIKTxUeLuZk=;
        b=c5y5mkw97zH03HnvRryty9vv1BDBYkWkAHjNZfFRx/bwduCz+3DdnUmpx+c9AxJ/U7
         C2SFl9qh+zzmPqrSwIh4MHFCjRvn1Kb7TgucnKSeeb26jDn/8IulDddPXNcjJpKlU7nn
         LnttE9mjbbwnIUB0xQ3S4nBkMz0eAW8G41TlHv/BeAAGufnmM2dGS3MC+yDH7Ngm1CeU
         83ZhZM9rgIbnl2kBrAzTLwugz/mvx5OAL9fh8Y7BCIx/WNVK2R8mzfkWU30hySdYKyu+
         jRTa5cfNJ+917ohWp8O/FCeeXjkureeDxc7vVElT9MzjIQkI4sLP6A1kHDYlgxS8IvIv
         Pbcw==
X-Gm-Message-State: AO0yUKV7n6KF5E4rGruuVW++bR6dLyhL+oQ1LZGADp8HTH48PegTTE8i
        Nl2LbYTeSyIjwiF01mmb/9EAhUYBXLZlczRX1y1T4Q==
X-Google-Smtp-Source: AK7set/JrvbGvqZL3LyyFN/3fun9IqZbunLli28q/cqaTl/JIXeDM0TG8ysHFRckG057b5Y8ivGtzS/o1nsBxHPL5cU=
X-Received: by 2002:a6b:dc03:0:b0:74c:7eac:a064 with SMTP id
 s3-20020a6bdc03000000b0074c7eaca064mr16363731ioc.2.1678738501583; Mon, 13 Mar
 2023 13:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com> <20230311065753.3012826-13-irogers@google.com>
 <ZA97DiLTzFyFpKVE@kernel.org>
In-Reply-To: <ZA97DiLTzFyFpKVE@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 13:14:50 -0700
Message-ID: <CAP-5=fUZ0yLreTuB+G+f6cM=K5fb+AKyq3WLHa+B=O7_FZQfPw@mail.gmail.com>
Subject: Re: [PATCH v1 12/13] tools headers: Make the difference output easier
 to read
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 12:35=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Mar 10, 2023 at 10:57:52PM -0800, Ian Rogers escreveu:
> > Add failures to an array and display it before exiting. Before:
> >
> > ```
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/fcntl.h' differ=
s from latest version at 'include/uapi/linux/fcntl.h'
> > diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> > Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs =
from latest version at 'include/uapi/linux/kvm.h'
> > diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
> > ...
> > ```
> >
> > After:
> > ```
> > Warning: Kernel ABI header differences:
> >   tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
> >   tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>
> I use that diff line to cut and paste, check the errors, etc.
>
> - Arnaldo

Sure, you can do something similar here but you need to add "diff -u"
at the beginning of the line. We could add a flag to the tool to do
the diff for you. The current 1st warning line is ~120characters long
and wraps onto 2 lines for me, the diff makes this 3 lines. Overall I
struggle to see the Makefile.config warnings because of all the
check-headers.sh warnings and the indent makes the grouping,
check-headers.sh vs other warnings/error, easier to see.

Compare the new output:
```
Warning: Kernel ABI header differences:
 tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h
 tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
 tools/include/uapi/linux/in.h include/uapi/linux/in.h
 tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
 tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
 tools/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
 tools/include/linux/bits.h include/linux/bits.h
 tools/include/vdso/bits.h include/vdso/bits.h
 tools/arch/x86/include/asm/disabled-features.h
arch/x86/include/asm/disabled-features.h
 tools/arch/x86/include/asm/required-features.h
arch/x86/include/asm/required-features.h
 tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.=
h
 tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
 tools/arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/perf_regs.h
 tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
 tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
 tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
 tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
 tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
 tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
Makefile.config:587: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-dev
el or systemtap-sdt-dev
Makefile.config:635: No libunwind found. Please install
libunwind-dev[el] >=3D 1.1 and/or set LIBUNWIN
D_DIR
Makefile.config:805: Missing perl devel files. Disabling perl
scripting support, please install perl
-ExtUtils-Embed/libperl-dev
Makefile.config:963: No libzstd found, disables trace compression,
please install libzstd-dev[el] an
d/or set LIBZSTD_DIR
Makefile.config:974: No libcap found, disables capability support,
please install libcap-devel/libca
p-dev
Makefile.config:987: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numac
tl-devel/libnuma-devel/libnuma-dev
Makefile.config:1046: No libbabeltrace found, disables 'perf data' CTF
format support, please instal
l libbabeltrace-dev[el]/libbabeltrace-ctf-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...
```

with

```
Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs
from latest version at 'includ
e/uapi/linux/in.h'
diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
Warning: Kernel ABI header at
'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version
at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h
arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at
'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest ve
rsion at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h
arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h'
differs from latest version at '
include/linux/coresight-pmu.h'
diff -u tools/include/linux/coresight-pmu.h include/linux/coresight-pmu.h
Makefile.config:587: No sys/sdt.h found, no SDT events are defined,
please install systemtap-sdt-dev
el or systemtap-sdt-dev
Makefile.config:635: No libunwind found. Please install
libunwind-dev[el] >=3D 1.1 and/or set LIBUNWIN
D_DIR
Makefile.config:809: Missing perl devel files. Disabling perl
scripting support, please install perl
-ExtUtils-Embed/libperl-dev
Makefile.config:967: No libzstd found, disables trace compression,
please install libzstd-dev[el] an
d/or set LIBZSTD_DIR
Makefile.config:978: No libcap found, disables capability support,
please install libcap-devel/libca
p-dev
Makefile.config:991: No numa.h found, disables 'perf bench numa mem'
benchmark, please install numac
tl-devel/libnuma-devel/libnuma-dev
Makefile.config:1050: No libbabeltrace found, disables 'perf data' CTF
format support, please instal
l libbabeltrace-dev[el]/libbabeltrace-ctf-dev

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...
```

That said there are more warnings with the new code, which looks like
some of the filters have kept working as they should :-)

Thanks,
Ian

> > ...
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/check-headers.sh | 229 ++++++++++++++++++++----------------
> >  1 file changed, 125 insertions(+), 104 deletions(-)
> >
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index eacca9a874e2..f848b425d936 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -1,113 +1,121 @@
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
> > -arch/s390/include/uapi/asm/ptrace.h
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
> > +  "arch/s390/include/uapi/asm/ptrace.h"
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
> > +    FAILURES+=3D(
> > +      "$tools_file $orig_file"
> > +    )
> > +  fi
> >  }
> >
> >  check () {
> > @@ -115,7 +123,7 @@ check () {
> >
> >    shift
> >
> > -  check_2 tools/$file $file $*
> > +  check_2 "tools/$file" "$file" $*
> >  }
> >
> >  beauty_check () {
> > @@ -123,23 +131,29 @@ beauty_check () {
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
> > @@ -160,8 +174,9 @@ check_2 tools/perf/arch/powerpc/entry/syscalls/sysc=
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
> > @@ -169,3 +184,9 @@ check_2 tools/perf/util/hashmap.h tools/lib/bpf/has=
hmap.h
> >  check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
> >
> >  cd tools/perf
> > +
> > +echo -e "${YELLOW}Warning${NC}: Kernel ABI header differences:"
> > +for i in "${FAILURES[@]}"
> > +do
> > +  echo "  $i"
> > +done
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
>
> --
>
> - Arnaldo
