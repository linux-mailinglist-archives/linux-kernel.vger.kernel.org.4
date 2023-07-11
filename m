Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CBA74F831
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGKS5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGKS5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:57:11 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC83E4D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:57:07 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7835971026fso206147439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689101827; x=1691693827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4g7wmRPCS24sQKjKjx9Grhgdi4yEVCkNGs4KXP0yN0=;
        b=iN/yTwvk5Q4zCG6J3etEclLIcohE/1Uy6PhgIWKHFr+y350q6hCXtY/i8QaSpu25wO
         Me4SMQxhIN6HkhoiQgJjF/uUivQYmfHw3aeCqtx4oWWbmzPNE5A7T8aqf6//sTy5hZdZ
         IlVU9MJwQvq2WL5F8dB3DT+RMnn3kpHrmRbvPDCmJte2xQmVbok9smbLjVWwk+nwX6Cx
         5QiAnA/YNsClKzyDvy/AQlsxhX1QY8vjbBqeYGPmqEkWbtKwNtmecIUY80JHW54VV2nl
         GoJUcgbAhooDbOnkdVO/5HWAhti6rYwAKIZPBXKO/9NrNi7PC67OCzJRz/1SE+Gg7gBL
         gDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689101827; x=1691693827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4g7wmRPCS24sQKjKjx9Grhgdi4yEVCkNGs4KXP0yN0=;
        b=ke0b60+P3FNvFdfvqRvPaO8EiojKPpjyi7gIu7UAHl6dY0nUhXwc8D7SdztjyRnKIU
         4AX00LVZppUH6gFirGZ2m3ddmUwYFtdTiA97jyX4NdajJcHvqgKImlVW+HQWTairj8W2
         6GegmbP0x5+gBRJLop+3JHpQyx95URoHm3Q0BWdLXsR9eaNSuuEYGz+6SZ/kw7XKaa3s
         aVgT/Rs3U8u9rA6atNQwDYUYveZsEMXjiT4+qhah6bT4LYxGF/+a3lWWQ6BW06wFgrXs
         kV/NcgCK/ofvP6EPmS0vL1dB9ykViupV6lVD8KpKUmMLmOhGsZd6pYMZHJYkejXo1vAo
         i0VQ==
X-Gm-Message-State: ABy/qLYbEOSaL+/BCePbsBQcldpzDjU2Oj9aWdKbEWs/Of/hNznGBvLT
        jglPCLd2VnTi9H77/4RcHm5ye1Ld3IJw/JaxwxE=
X-Google-Smtp-Source: APBJJlG+HuLr7lbXc0khc4MS14dZTsNhQIO3urdmVmHprpMs5r4ImRy6krCtQ07/qU5CROdWPhIym/9WcfaFXgQ7nlQ=
X-Received: by 2002:a05:6e02:549:b0:346:fe2:125a with SMTP id
 i9-20020a056e02054900b003460fe2125amr14768607ils.26.1689101826689; Tue, 11
 Jul 2023 11:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <ZK1pVBJpbjujJNJW@kernel.org>
In-Reply-To: <ZK1pVBJpbjujJNJW@kernel.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 11 Jul 2023 11:56:55 -0700
Message-ID: <CAKEwX=NcTYje4c44=2J+3GYg4SPa4FEm20QsWu+UA4qoWRYczA@mail.gmail.com>
Subject: Re: [PATCH 1/1 fyi] tools headers UAPI: Sync files changed by new
 cachestat syscall with the kernel sources
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:38=E2=80=AFAM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.
>
> - Arnaldo
>
> Full explanation:
>
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
>
> The way these headers are used in perf are not restricted to just
> including them to compile something.
>
> There are sometimes used in scripts that convert defines into string
> tables, etc, so some change may break one of these scripts, or new MSRs
> may use some different #define pattern, etc.
>
> E.g.:
>
>   $ ls -1 tools/perf/trace/beauty/*.sh | head -5
>   tools/perf/trace/beauty/arch_errno_names.sh
>   tools/perf/trace/beauty/drm_ioctl.sh
>   tools/perf/trace/beauty/fadvise.sh
>   tools/perf/trace/beauty/fsconfig.sh
>   tools/perf/trace/beauty/fsmount.sh
>   $
>   $ tools/perf/trace/beauty/fadvise.sh
>   static const char *fadvise_advices[] =3D {
>         [0] =3D "NORMAL",
>         [1] =3D "RANDOM",
>         [2] =3D "SEQUENTIAL",
>         [3] =3D "WILLNEED",
>         [4] =3D "DONTNEED",
>         [5] =3D "NOREUSE",
>   };
>   $
>
> The tools/perf/check-headers.sh script, part of the tools/ build
> process, points out changes in the original files.
>
> So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers.
>
> ---
>
> To pick the changes in these csets:
>
>   cf264e1329fb0307 ("cachestat: implement cachestat syscall")
>
> That add support for this new syscall in tools such as 'perf trace'.
>
> For instance, this is now possible:
>
>   # perf trace -e cachestat
>   ^C[root@five ~]#
>   # perf trace -v -e cachestat
>   Using CPUID AuthenticAMD-25-21-0
>   event qualifier tracepoint filter: (common_pid !=3D 3163687 && common_p=
id !=3D 3147) && (id =3D=3D 451)
>   mmap size 528384B
>   ^C[root@five ~]
>
>   # perf trace -v -e *stat* --max-events=3D10
>   Using CPUID AuthenticAMD-25-21-0
>   event qualifier tracepoint filter: (common_pid !=3D 3163713 && common_p=
id !=3D 3147) && (id =3D=3D 4 || id =3D=3D 5 || id =3D=3D 6 || id =3D=3D 13=
6 || id =3D=3D 137 || id =3D=3D 138 || id =3D=3D 262 || id =3D=3D 332 || id=
 =3D=3D 451)
>   mmap size 528384B
>        0.000 ( 0.009 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, bu=
f: 0x7f8745725b60)                     =3D 0
>        0.012 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: =
0x45635288, statbuf: 0x7f874569d250)   =3D 0
>        0.036 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: =
0x541b7093, statbuf: 0x7f87457256f0, flag: 4096) =3D 0
>        0.372 ( 0.006 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, bu=
f: 0x7f8745725b10)                     =3D 0
>        0.379 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: =
0x45635288, statbuf: 0x7f874569d250)   =3D 0
>        0.390 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: =
0x541b7093, statbuf: 0x7f87457256a0, flag: 4096) =3D 0
>        0.609 ( 0.005 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, bu=
f: 0x7f8745725b60)                     =3D 0
>        0.615 ( 0.003 ms): Cache2 I/O/4544 newfstatat(dfd: CWD, filename: =
0x45635288, statbuf: 0x7f874569d250)   =3D 0
>        0.625 ( 0.002 ms): Cache2 I/O/4544 newfstatat(dfd: 138, filename: =
0x541b7093, statbuf: 0x7f87457256f0, flag: 4096) =3D 0
>        0.826 ( 0.005 ms): Cache2 I/O/4544 statfs(pathname: 0x45635288, bu=
f: 0x7f8745725b10)                     =3D 0
>   #
>
> That is the filter expression attached to the raw_syscalls:sys_{enter,exi=
t}
> tracepoints.
>
>   $ find tools/perf/arch/ -name "syscall*tbl" | xargs grep -w sys_cachest=
at
>   tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl:451       n64     c=
achestat                       sys_cachestat
>   tools/perf/arch/powerpc/entry/syscalls/syscall.tbl:451        common  c=
achestat                       sys_cachestat
>   tools/perf/arch/s390/entry/syscalls/syscall.tbl:451  common   cachestat=
               sys_cachestat                   sys_cachestat
>   tools/perf/arch/x86/entry/syscalls/syscall_64.tbl:451 common  cachestat=
               sys_cachestat
>   $
>
>   $ grep -w cachestat /tmp/build/perf-tools/arch/x86/include/generated/as=
m/syscalls_64.c
>         [451] =3D "cachestat",
>   $
>
> This addresses these perf build warnings:
>
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generi=
c/unistd.h
>   diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
>   diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entr=
y/syscalls/syscall_64.tbl
>   diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc=
/kernel/syscalls/syscall.tbl
>   diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kerne=
l/syscalls/syscall.tbl
>   diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/k=
ernel/syscalls/syscall_n64.tbl
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/include/uapi/asm-generic/unistd.h            |  5 ++++-
>  tools/include/uapi/linux/mman.h                    | 14 ++++++++++++++
>  .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
>  tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |  1 +
>  6 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi=
/asm-generic/unistd.h
> index dd7d8e10f16d83a1..fd6c1cb585db43c4 100644
> --- a/tools/include/uapi/asm-generic/unistd.h
> +++ b/tools/include/uapi/asm-generic/unistd.h
> @@ -817,8 +817,11 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
>  #define __NR_set_mempolicy_home_node 450
>  __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>
> +#define __NR_cachestat 451
> +__SYSCALL(__NR_cachestat, sys_cachestat)
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 451
> +#define __NR_syscalls 452
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/tools/include/uapi/linux/mman.h b/tools/include/uapi/linux/m=
man.h
> index f55bc680b5b0a45e..a246e11988d5e0e2 100644
> --- a/tools/include/uapi/linux/mman.h
> +++ b/tools/include/uapi/linux/mman.h
> @@ -4,6 +4,7 @@
>
>  #include <asm/mman.h>
>  #include <asm-generic/hugetlb_encode.h>
> +#include <linux/types.h>
>
>  #define MREMAP_MAYMOVE         1
>  #define MREMAP_FIXED           2
> @@ -41,4 +42,17 @@
>  #define MAP_HUGE_2GB   HUGETLB_FLAG_ENCODE_2GB
>  #define MAP_HUGE_16GB  HUGETLB_FLAG_ENCODE_16GB
>
> +struct cachestat_range {
> +       __u64 off;
> +       __u64 len;
> +};
> +
> +struct cachestat {
> +       __u64 nr_cache;
> +       __u64 nr_dirty;
> +       __u64 nr_writeback;
> +       __u64 nr_evicted;
> +       __u64 nr_recently_evicted;
> +};
> +
>  #endif /* _UAPI_LINUX_MMAN_H */
> diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/=
perf/arch/mips/entry/syscalls/syscall_n64.tbl
> index 3f1886ad9d8060b4..cfda2511badf3ad0 100644
> --- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> +++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
> @@ -365,3 +365,4 @@
>  448    n64     process_mrelease                sys_process_mrelease
>  449    n64     futex_waitv                     sys_futex_waitv
>  450    common  set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
> +451    n64     cachestat                       sys_cachestat
> diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/p=
erf/arch/powerpc/entry/syscalls/syscall.tbl
> index a0be127475b1f761..8c0b08b7a80ec4b7 100644
> --- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
> @@ -537,3 +537,4 @@
>  448    common  process_mrelease                sys_process_mrelease
>  449    common  futex_waitv                     sys_futex_waitv
>  450    nospu   set_mempolicy_home_node         sys_set_mempolicy_home_no=
de
> +451    common  cachestat                       sys_cachestat
> diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf=
/arch/s390/entry/syscalls/syscall.tbl
> index b68f47541169f9af..a6935af2235cab6c 100644
> --- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> +++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
> @@ -453,3 +453,4 @@
>  448  common    process_mrelease        sys_process_mrelease            s=
ys_process_mrelease
>  449  common    futex_waitv             sys_futex_waitv                 s=
ys_futex_waitv
>  450  common    set_mempolicy_home_node sys_set_mempolicy_home_node     s=
ys_set_mempolicy_home_node
> +451  common    cachestat               sys_cachestat                   s=
ys_cachestat
> diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/pe=
rf/arch/x86/entry/syscalls/syscall_64.tbl
> index c84d12608cd2de9e..227538b0ce801eeb 100644
> --- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -372,6 +372,7 @@
>  448    common  process_mrelease        sys_process_mrelease
>  449    common  futex_waitv             sys_futex_waitv
>  450    common  set_mempolicy_home_node sys_set_mempolicy_home_node
> +451    common  cachestat               sys_cachestat
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> --
> 2.37.1
>

LGTM.
Acked-by: Nhat Pham <nphamcs@gmail.com>
