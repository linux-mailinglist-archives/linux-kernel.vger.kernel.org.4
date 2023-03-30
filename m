Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0144C6D0E64
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjC3TOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC3TOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:14:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888BDBEC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:14:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h25so25846191lfv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203677; x=1682795677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrwN4efePkKeRyM2+aawRI+tArPJUoxqtKFQgzbgxUU=;
        b=UYScV26YJGQoWb9HGSa7/p3/fmX8ZaWR5zJVwjqKgXzmvX0nqyYJZmICaalhVkcYNY
         HqdojkDsIRirOUcE4YQ7t+JBwwGocPYerReQYNsHeLVeXarvUPStwtbJKhsK8uUg8AJf
         ZduSQNZg8xJnUU7Y/p88w1SYVyoofR3fuAdenAO68TUWz5Z6p1p60lVESPs3we2Wc4Jo
         JHS3XYzGRV9dcirpdWMLPiRgsyQUgI611m46qalA5kr6hsxMvdxNboqxxkHjI4SB1wkO
         6weMgQVUdMlwJ4LAj2WNsWdAKxLY8JMrgK1zVDuo13fWiBzI74VRUS/6YORyFokH6smK
         56kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203677; x=1682795677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrwN4efePkKeRyM2+aawRI+tArPJUoxqtKFQgzbgxUU=;
        b=Eizel7NWp2QNBs3kjKE3UVJ4R3rSd3eg8rH+2NsuYT3oceT+aWQDZnGlxrqcFuN+QF
         ciswuC1QAZplt5dKUKqWWO1Nfx9S3I4FggMSldUROaRe9/aqhSF3ifQ52/hHGBIcPIOS
         bm053VAWMIwp5Z2rmtpFMnFA3Jv3N32WadNf8nweNboeJdRuzqaIe7fYeFHrKnJRazNk
         NCoehJnkL5C7j/3Cr0aacXzMzKfbiUC6YGT9izSndFl1xrnYu2ScUBJ6IscHfBNttu7n
         Aoz+HJk2t+Mjzku6VuBjV9aBAHAHf3QFHVSjR37yXjNiUsE7fA02VocHRtPytIQ7R1gm
         RjyA==
X-Gm-Message-State: AAQBX9dBbMjWZGfbtJp+opWwQa3g+F3Map+6T0eEjimrdj1IOZX2piw9
        LLmsyk195NQUhxyZicCff4HZDAQt4Yiiv2r+JYCMlg==
X-Google-Smtp-Source: AKy350aqYn/6FigkFPPrTXm3pk9sS5jjaNdvjbJCpyHOgfjJb61pREurRr3NlNvG0jvh+DQZCOeK6HqwysQhgkp66EQ=
X-Received: by 2002:ac2:51de:0:b0:4ea:e5e3:7eb0 with SMTP id
 u30-20020ac251de000000b004eae5e37eb0mr7284796lfm.10.1680203677314; Thu, 30
 Mar 2023 12:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230330155707.3106228-1-peterx@redhat.com> <20230330160649.3106916-1-peterx@redhat.com>
In-Reply-To: <20230330160649.3106916-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 30 Mar 2023 12:14:00 -0700
Message-ID: <CAJHvVcg+HcFwO4OJ-B0NanOJ+C9Wni1Gm4p-Jex_jPYyKzuP8Q@mail.gmail.com>
Subject: Re: [PATCH 04/29] selftests/mm: Merge util.h into vm_util.h
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:07=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> There're two util headers under mm/ kselftest.  Merge one with another.  =
It
> turns out util.h is the easy one to move.
>
> When merging, drop PAGE_SIZE / PAGE_SHIFT because they're unnecessary
> wrappers to page_size() / page_shift(), meanwhile rename them to psize()
> and pshift() so as to not conflict with some existing definitions in some
> test files that includes vm_util.h.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

> ---
>  tools/testing/selftests/mm/Makefile           |  4 ++
>  tools/testing/selftests/mm/gup_test.c         |  5 +-
>  tools/testing/selftests/mm/ksm_tests.c        |  2 +-
>  tools/testing/selftests/mm/mrelease_test.c    | 11 ++-
>  tools/testing/selftests/mm/transhuge-stress.c | 12 ++--
>  tools/testing/selftests/mm/util.h             | 69 -------------------
>  tools/testing/selftests/mm/vm_util.c          | 31 +++++++++
>  tools/testing/selftests/mm/vm_util.h          | 31 +++++++++
>  8 files changed, 80 insertions(+), 85 deletions(-)
>  delete mode 100644 tools/testing/selftests/mm/util.h
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index fbf5646b1072..4188435967ed 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -111,6 +111,10 @@ $(OUTPUT)/madv_populate: vm_util.c
>  $(OUTPUT)/soft-dirty: vm_util.c
>  $(OUTPUT)/split_huge_page_test: vm_util.c
>  $(OUTPUT)/userfaultfd: vm_util.c
> +$(OUTPUT)/gup_test: vm_util.c
> +$(OUTPUT)/mrelease_test: vm_util.c
> +$(OUTPUT)/transhuge-stress: vm_util.c
> +$(OUTPUT)/ksm_tests: vm_util.c
>
>  ifeq ($(MACHINE),x86_64)
>  BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selfte=
sts/mm/gup_test.c
> index e43879291dac..ec2229136384 100644
> --- a/tools/testing/selftests/mm/gup_test.c
> +++ b/tools/testing/selftests/mm/gup_test.c
> @@ -12,8 +12,7 @@
>  #include <assert.h>
>  #include <mm/gup_test.h>
>  #include "../kselftest.h"
> -
> -#include "util.h"
> +#include "vm_util.h"
>
>  #define MB (1UL << 20)
>
> @@ -251,7 +250,7 @@ int main(int argc, char **argv)
>         if (touch) {
>                 gup.gup_flags |=3D FOLL_TOUCH;
>         } else {
> -               for (; (unsigned long)p < gup.addr + size; p +=3D PAGE_SI=
ZE)
> +               for (; (unsigned long)p < gup.addr + size; p +=3D psize()=
)
>                         p[0] =3D 0;
>         }
>
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selft=
ests/mm/ksm_tests.c
> index 9fb21b982dc9..85a49aea3ab8 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -14,7 +14,7 @@
>
>  #include "../kselftest.h"
>  #include <include/vdso/time64.h>
> -#include "util.h"
> +#include "vm_util.h"
>
>  #define KSM_SYSFS_PATH "/sys/kernel/mm/ksm/"
>  #define KSM_FP(s) (KSM_SYSFS_PATH s)
> diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/s=
elftests/mm/mrelease_test.c
> index 6c62966ab5db..37b6d33b9e84 100644
> --- a/tools/testing/selftests/mm/mrelease_test.c
> +++ b/tools/testing/selftests/mm/mrelease_test.c
> @@ -9,8 +9,7 @@
>  #include <stdlib.h>
>  #include <sys/wait.h>
>  #include <unistd.h>
> -
> -#include "util.h"
> +#include "vm_util.h"
>
>  #include "../kselftest.h"
>
> @@ -32,7 +31,7 @@ static int alloc_noexit(unsigned long nr_pages, int pip=
efd)
>         unsigned long i;
>         char *buf;
>
> -       buf =3D (char *)mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT=
_WRITE,
> +       buf =3D (char *)mmap(NULL, nr_pages * psize(), PROT_READ | PROT_W=
RITE,
>                            MAP_PRIVATE | MAP_ANON, 0, 0);
>         if (buf =3D=3D MAP_FAILED) {
>                 perror("mmap failed, halting the test");
> @@ -40,7 +39,7 @@ static int alloc_noexit(unsigned long nr_pages, int pip=
efd)
>         }
>
>         for (i =3D 0; i < nr_pages; i++)
> -               *((unsigned long *)(buf + (i * PAGE_SIZE))) =3D i;
> +               *((unsigned long *)(buf + (i * psize()))) =3D i;
>
>         /* Signal the parent that the child is ready */
>         if (write(pipefd, "", 1) < 0) {
> @@ -54,7 +53,7 @@ static int alloc_noexit(unsigned long nr_pages, int pip=
efd)
>                 timeout--;
>         }
>
> -       munmap(buf, nr_pages * PAGE_SIZE);
> +       munmap(buf, nr_pages * psize());
>
>         return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
>  }
> @@ -87,7 +86,7 @@ static int child_main(int pipefd[], size_t size)
>
>         /* Allocate and fault-in memory and wait to be killed */
>         close(pipefd[0]);
> -       res =3D alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> +       res =3D alloc_noexit(MB(size) / psize(), pipefd[1]);
>         close(pipefd[1]);
>         return res;
>  }
> diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testin=
g/selftests/mm/transhuge-stress.c
> index e3f00adb1b82..ba9d37ad3a89 100644
> --- a/tools/testing/selftests/mm/transhuge-stress.c
> +++ b/tools/testing/selftests/mm/transhuge-stress.c
> @@ -15,7 +15,7 @@
>  #include <fcntl.h>
>  #include <string.h>
>  #include <sys/mman.h>
> -#include "util.h"
> +#include "vm_util.h"
>
>  int backing_fd =3D -1;
>  int mmap_flags =3D MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
> @@ -34,10 +34,10 @@ int main(int argc, char **argv)
>         int pagemap_fd;
>
>         ram =3D sysconf(_SC_PHYS_PAGES);
> -       if (ram > SIZE_MAX / sysconf(_SC_PAGESIZE) / 4)
> +       if (ram > SIZE_MAX / psize() / 4)
>                 ram =3D SIZE_MAX / 4;
>         else
> -               ram *=3D sysconf(_SC_PAGESIZE);
> +               ram *=3D psize();
>         len =3D ram;
>
>         while (++i < argc) {
> @@ -58,7 +58,7 @@ int main(int argc, char **argv)
>
>         warnx("allocate %zd transhuge pages, using %zd MiB virtual memory=
"
>               " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
> -             ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> +             ram >> (20 + HPAGE_SHIFT - pshift() - 1));
>
>         pagemap_fd =3D open("/proc/self/pagemap", O_RDONLY);
>         if (pagemap_fd < 0)
> @@ -92,7 +92,7 @@ int main(int argc, char **argv)
>                         if (pfn < 0) {
>                                 nr_failed++;
>                         } else {
> -                               size_t idx =3D pfn >> (HPAGE_SHIFT - PAGE=
_SHIFT);
> +                               size_t idx =3D pfn >> (HPAGE_SHIFT - pshi=
ft());
>
>                                 nr_succeed++;
>                                 if (idx >=3D map_len) {
> @@ -108,7 +108,7 @@ int main(int argc, char **argv)
>                         }
>
>                         /* split transhuge page, keep last page */
> -                       if (madvise(p, HPAGE_SIZE - PAGE_SIZE, MADV_DONTN=
EED))
> +                       if (madvise(p, HPAGE_SIZE - psize(), MADV_DONTNEE=
D))
>                                 err(2, "MADV_DONTNEED");
>                 }
>                 clock_gettime(CLOCK_MONOTONIC, &b);
> diff --git a/tools/testing/selftests/mm/util.h b/tools/testing/selftests/=
mm/util.h
> deleted file mode 100644
> index b27d26199334..000000000000
> --- a/tools/testing/selftests/mm/util.h
> +++ /dev/null
> @@ -1,69 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -
> -#ifndef __KSELFTEST_VM_UTIL_H
> -#define __KSELFTEST_VM_UTIL_H
> -
> -#include <stdint.h>
> -#include <sys/mman.h>
> -#include <err.h>
> -#include <string.h> /* ffsl() */
> -#include <unistd.h> /* _SC_PAGESIZE */
> -
> -static unsigned int __page_size;
> -static unsigned int __page_shift;
> -
> -static inline unsigned int page_size(void)
> -{
> -       if (!__page_size)
> -               __page_size =3D sysconf(_SC_PAGESIZE);
> -       return __page_size;
> -}
> -
> -static inline unsigned int page_shift(void)
> -{
> -       if (!__page_shift)
> -               __page_shift =3D (ffsl(page_size()) - 1);
> -       return __page_shift;
> -}
> -
> -#define PAGE_SHIFT     (page_shift())
> -#define PAGE_SIZE      (page_size())
> -/*
> - * On ppc64 this will only work with radix 2M hugepage size
> - */
> -#define HPAGE_SHIFT 21
> -#define HPAGE_SIZE (1 << HPAGE_SHIFT)
> -
> -#define PAGEMAP_PRESENT(ent)   (((ent) & (1ull << 63)) !=3D 0)
> -#define PAGEMAP_PFN(ent)       ((ent) & ((1ull << 55) - 1))
> -
> -
> -static inline int64_t allocate_transhuge(void *ptr, int pagemap_fd)
> -{
> -       uint64_t ent[2];
> -
> -       /* drop pmd */
> -       if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
> -                MAP_FIXED | MAP_ANONYMOUS |
> -                MAP_NORESERVE | MAP_PRIVATE, -1, 0) !=3D ptr)
> -               errx(2, "mmap transhuge");
> -
> -       if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
> -               err(2, "MADV_HUGEPAGE");
> -
> -       /* allocate transparent huge page */
> -       *(volatile void **)ptr =3D ptr;
> -
> -       if (pread(pagemap_fd, ent, sizeof(ent),
> -                 (uintptr_t)ptr >> (PAGE_SHIFT - 3)) !=3D sizeof(ent))
> -               err(2, "read pagemap");
> -
> -       if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
> -           PAGEMAP_PFN(ent[0]) + 1 =3D=3D PAGEMAP_PFN(ent[1]) &&
> -           !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - =
1)))
> -               return PAGEMAP_PFN(ent[0]);
> -
> -       return -1;
> -}
> -
> -#endif
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftes=
ts/mm/vm_util.c
> index 40e795624ff3..0204c469be43 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -8,6 +8,9 @@
>  #define SMAP_FILE_PATH "/proc/self/smaps"
>  #define MAX_LINE_LENGTH 500
>
> +unsigned int __page_size;
> +unsigned int __page_shift;
> +
>  uint64_t pagemap_get_entry(int fd, char *start)
>  {
>         const unsigned long pfn =3D (unsigned long)start / getpagesize();
> @@ -149,3 +152,31 @@ bool check_huge_shmem(void *addr, int nr_hpages, uin=
t64_t hpage_size)
>  {
>         return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_siz=
e);
>  }
> +
> +int64_t allocate_transhuge(void *ptr, int pagemap_fd)
> +{
> +       uint64_t ent[2];
> +
> +       /* drop pmd */
> +       if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
> +                MAP_FIXED | MAP_ANONYMOUS |
> +                MAP_NORESERVE | MAP_PRIVATE, -1, 0) !=3D ptr)
> +               errx(2, "mmap transhuge");
> +
> +       if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
> +               err(2, "MADV_HUGEPAGE");
> +
> +       /* allocate transparent huge page */
> +       *(volatile void **)ptr =3D ptr;
> +
> +       if (pread(pagemap_fd, ent, sizeof(ent),
> +                 (uintptr_t)ptr >> (pshift() - 3)) !=3D sizeof(ent))
> +               err(2, "read pagemap");
> +
> +       if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
> +           PAGEMAP_PFN(ent[0]) + 1 =3D=3D PAGEMAP_PFN(ent[1]) &&
> +           !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - pshift())) - 1)=
))
> +               return PAGEMAP_PFN(ent[0]);
> +
> +       return -1;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftes=
ts/mm/vm_util.h
> index 1995ee911ef2..6edeb531afc6 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -1,6 +1,27 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #include <stdint.h>
>  #include <stdbool.h>
> +#include <sys/mman.h>
> +#include <err.h>
> +#include <string.h> /* ffsl() */
> +#include <unistd.h> /* _SC_PAGESIZE */
> +
> +extern unsigned int __page_size;
> +extern unsigned int __page_shift;
> +
> +static inline unsigned int psize(void)
> +{
> +       if (!__page_size)
> +               __page_size =3D sysconf(_SC_PAGESIZE);
> +       return __page_size;
> +}
> +
> +static inline unsigned int pshift(void)
> +{
> +       if (!__page_shift)
> +               __page_shift =3D (ffsl(psize()) - 1);
> +       return __page_shift;
> +}
>
>  uint64_t pagemap_get_entry(int fd, char *start);
>  bool pagemap_is_softdirty(int fd, char *start);
> @@ -13,3 +34,13 @@ uint64_t read_pmd_pagesize(void);
>  bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
> +int64_t allocate_transhuge(void *ptr, int pagemap_fd);
> +
> +/*
> + * On ppc64 this will only work with radix 2M hugepage size
> + */
> +#define HPAGE_SHIFT 21
> +#define HPAGE_SIZE (1 << HPAGE_SHIFT)
> +
> +#define PAGEMAP_PRESENT(ent)   (((ent) & (1ull << 63)) !=3D 0)
> +#define PAGEMAP_PFN(ent)       ((ent) & ((1ull << 55) - 1))
> --
> 2.39.1
>
