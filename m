Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75A36DAAC2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbjDGJTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:19:13 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A65525D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:19:12 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377xeUB032251;
        Fri, 7 Apr 2023 09:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=nPnxbyO5OCttotMMiN/V4y1kWs7JN2nZvdyi2r7HpSY=;
 b=Q7UAJ6mi4vK01rf2dG5wxN2UNd0pxg2TGJ+k8ksr4POH5sPUtIc+BqeG1Lj76MudTsQx
 FeFq4r+c1GT/EapKFPHQqYTSjfciTd+aYRbL2CmcpH+n4cb894tkhAwp37lNndrqDvRG
 1vVUS5dfg16bBgwv627jPplZbsK0YwSZvd+r4/m2vWu3hunTJMcxdOrLyKMSuNvjZ+Kc
 4bFwT+hOJXYiOnGzL17a1dRp79pEbf93uJMXJKbKrKbqRwAdHBpQUoRmFaobrxTkU0eb
 /bBV8oruAs2oB38+3mQvnk85380bLEZc5ZHLvBye/azdSwSaNxppBv13jbIbUbBmJ2zv 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41desq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:19:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379Fib5031977;
        Fri, 7 Apr 2023 09:19:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41des0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:19:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33706g8J028613;
        Fri, 7 Apr 2023 09:19:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg4ux3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:19:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379J2oX25297500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:19:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07E8B20049;
        Fri,  7 Apr 2023 09:19:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B463120040;
        Fri,  7 Apr 2023 09:19:00 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:19:00 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:18:58 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 04/29] selftests/mm: Merge util.h into vm_util.h
Message-ID: <ZC/gAuynBhAdLxKz@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160649.3106916-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160649.3106916-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j-scDDnvl5BrJJStxK8zV53pI7Rj6xTc
X-Proofpoint-GUID: dutrzAnxJMpGnQDcxdo_X8BxdB9yITHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=916
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:06:49PM -0400, Peter Xu wrote:
> There're two util headers under mm/ kselftest.  Merge one with another.  It
> turns out util.h is the easy one to move.
> 
> When merging, drop PAGE_SIZE / PAGE_SHIFT because they're unnecessary
> wrappers to page_size() / page_shift(), meanwhile rename them to psize()
> and pshift() so as to not conflict with some existing definitions in some
> test files that includes vm_util.h.

For me this sounds like two patches, but it's not really important with
diffstat that small.
 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
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
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
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
>  	if (touch) {
>  		gup.gup_flags |= FOLL_TOUCH;
>  	} else {
> -		for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
> +		for (; (unsigned long)p < gup.addr + size; p += psize())
>  			p[0] = 0;
>  	}
> 
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
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
> diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
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
> @@ -32,7 +31,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
>  	unsigned long i;
>  	char *buf;
> 
> -	buf = (char *)mmap(NULL, nr_pages * PAGE_SIZE, PROT_READ | PROT_WRITE,
> +	buf = (char *)mmap(NULL, nr_pages * psize(), PROT_READ | PROT_WRITE,
>  			   MAP_PRIVATE | MAP_ANON, 0, 0);
>  	if (buf == MAP_FAILED) {
>  		perror("mmap failed, halting the test");
> @@ -40,7 +39,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
>  	}
> 
>  	for (i = 0; i < nr_pages; i++)
> -		*((unsigned long *)(buf + (i * PAGE_SIZE))) = i;
> +		*((unsigned long *)(buf + (i * psize()))) = i;
> 
>  	/* Signal the parent that the child is ready */
>  	if (write(pipefd, "", 1) < 0) {
> @@ -54,7 +53,7 @@ static int alloc_noexit(unsigned long nr_pages, int pipefd)
>  		timeout--;
>  	}
> 
> -	munmap(buf, nr_pages * PAGE_SIZE);
> +	munmap(buf, nr_pages * psize());
> 
>  	return (timeout > 0) ? KSFT_PASS : KSFT_FAIL;
>  }
> @@ -87,7 +86,7 @@ static int child_main(int pipefd[], size_t size)
> 
>  	/* Allocate and fault-in memory and wait to be killed */
>  	close(pipefd[0]);
> -	res = alloc_noexit(MB(size) / PAGE_SIZE, pipefd[1]);
> +	res = alloc_noexit(MB(size) / psize(), pipefd[1]);
>  	close(pipefd[1]);
>  	return res;
>  }
> diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
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
>  int backing_fd = -1;
>  int mmap_flags = MAP_ANONYMOUS | MAP_NORESERVE | MAP_PRIVATE;
> @@ -34,10 +34,10 @@ int main(int argc, char **argv)
>  	int pagemap_fd;
> 
>  	ram = sysconf(_SC_PHYS_PAGES);
> -	if (ram > SIZE_MAX / sysconf(_SC_PAGESIZE) / 4)
> +	if (ram > SIZE_MAX / psize() / 4)
>  		ram = SIZE_MAX / 4;
>  	else
> -		ram *= sysconf(_SC_PAGESIZE);
> +		ram *= psize();
>  	len = ram;
> 
>  	while (++i < argc) {
> @@ -58,7 +58,7 @@ int main(int argc, char **argv)
> 
>  	warnx("allocate %zd transhuge pages, using %zd MiB virtual memory"
>  	      " and %zd MiB of ram", len >> HPAGE_SHIFT, len >> 20,
> -	      ram >> (20 + HPAGE_SHIFT - PAGE_SHIFT - 1));
> +	      ram >> (20 + HPAGE_SHIFT - pshift() - 1));
> 
>  	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
>  	if (pagemap_fd < 0)
> @@ -92,7 +92,7 @@ int main(int argc, char **argv)
>  			if (pfn < 0) {
>  				nr_failed++;
>  			} else {
> -				size_t idx = pfn >> (HPAGE_SHIFT - PAGE_SHIFT);
> +				size_t idx = pfn >> (HPAGE_SHIFT - pshift());
> 
>  				nr_succeed++;
>  				if (idx >= map_len) {
> @@ -108,7 +108,7 @@ int main(int argc, char **argv)
>  			}
> 
>  			/* split transhuge page, keep last page */
> -			if (madvise(p, HPAGE_SIZE - PAGE_SIZE, MADV_DONTNEED))
> +			if (madvise(p, HPAGE_SIZE - psize(), MADV_DONTNEED))
>  				err(2, "MADV_DONTNEED");
>  		}
>  		clock_gettime(CLOCK_MONOTONIC, &b);
> diff --git a/tools/testing/selftests/mm/util.h b/tools/testing/selftests/mm/util.h
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
> -	if (!__page_size)
> -		__page_size = sysconf(_SC_PAGESIZE);
> -	return __page_size;
> -}
> -
> -static inline unsigned int page_shift(void)
> -{
> -	if (!__page_shift)
> -		__page_shift = (ffsl(page_size()) - 1);
> -	return __page_shift;
> -}
> -
> -#define PAGE_SHIFT	(page_shift())
> -#define PAGE_SIZE	(page_size())
> -/*
> - * On ppc64 this will only work with radix 2M hugepage size
> - */
> -#define HPAGE_SHIFT 21
> -#define HPAGE_SIZE (1 << HPAGE_SHIFT)
> -
> -#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
> -#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> -
> -
> -static inline int64_t allocate_transhuge(void *ptr, int pagemap_fd)
> -{
> -	uint64_t ent[2];
> -
> -	/* drop pmd */
> -	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
> -		 MAP_FIXED | MAP_ANONYMOUS |
> -		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
> -		errx(2, "mmap transhuge");
> -
> -	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
> -		err(2, "MADV_HUGEPAGE");
> -
> -	/* allocate transparent huge page */
> -	*(volatile void **)ptr = ptr;
> -
> -	if (pread(pagemap_fd, ent, sizeof(ent),
> -		  (uintptr_t)ptr >> (PAGE_SHIFT - 3)) != sizeof(ent))
> -		err(2, "read pagemap");
> -
> -	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
> -	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
> -	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - PAGE_SHIFT)) - 1)))
> -		return PAGEMAP_PFN(ent[0]);
> -
> -	return -1;
> -}
> -
> -#endif
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
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
>  	const unsigned long pfn = (unsigned long)start / getpagesize();
> @@ -149,3 +152,31 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
>  {
>  	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
>  }
> +
> +int64_t allocate_transhuge(void *ptr, int pagemap_fd)
> +{
> +	uint64_t ent[2];
> +
> +	/* drop pmd */
> +	if (mmap(ptr, HPAGE_SIZE, PROT_READ | PROT_WRITE,
> +		 MAP_FIXED | MAP_ANONYMOUS |
> +		 MAP_NORESERVE | MAP_PRIVATE, -1, 0) != ptr)
> +		errx(2, "mmap transhuge");
> +
> +	if (madvise(ptr, HPAGE_SIZE, MADV_HUGEPAGE))
> +		err(2, "MADV_HUGEPAGE");
> +
> +	/* allocate transparent huge page */
> +	*(volatile void **)ptr = ptr;
> +
> +	if (pread(pagemap_fd, ent, sizeof(ent),
> +		  (uintptr_t)ptr >> (pshift() - 3)) != sizeof(ent))
> +		err(2, "read pagemap");
> +
> +	if (PAGEMAP_PRESENT(ent[0]) && PAGEMAP_PRESENT(ent[1]) &&
> +	    PAGEMAP_PFN(ent[0]) + 1 == PAGEMAP_PFN(ent[1]) &&
> +	    !(PAGEMAP_PFN(ent[0]) & ((1 << (HPAGE_SHIFT - pshift())) - 1)))
> +		return PAGEMAP_PFN(ent[0]);
> +
> +	return -1;
> +}
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
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
> +	if (!__page_size)
> +		__page_size = sysconf(_SC_PAGESIZE);
> +	return __page_size;
> +}
> +
> +static inline unsigned int pshift(void)
> +{
> +	if (!__page_shift)
> +		__page_shift = (ffsl(psize()) - 1);
> +	return __page_shift;
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
> +#define PAGEMAP_PRESENT(ent)	(((ent) & (1ull << 63)) != 0)
> +#define PAGEMAP_PFN(ent)	((ent) & ((1ull << 55) - 1))
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
