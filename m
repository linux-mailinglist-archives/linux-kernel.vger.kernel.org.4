Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910F76DDB11
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDKMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjDKMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:41:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F7E6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 05:41:52 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BCM3mK024657;
        Tue, 11 Apr 2023 12:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Jdo/BdQrJRq2n43nEuW85fLGEa+1dtCzg6IF46szgCw=;
 b=I/Kc04uxqjB4//xb1W1Mdv54jd/LrSgOpdTKzOZN8ui5iDS1Z2SGizX7Q+KftrFR07f9
 GeOrc0/sWe3M9y7qPj1lWSJmc0wN1F9P57UtE+60aePvXULzyowoerTeiZesyEgURBNu
 f+KDYiYELrM+FK2a9LN3dRFoGsdBaXllg54dNSEmt6Ps5NUAHXRKqUtDVhj+uLt3s+13
 VOUqQzeI+/vKqXYRuf16QLL28XRzj5pokmfvFEhstKZ5ChEzFELHQClRq9GYoWn7v8c1
 NTeQO13IOKOVHUnwwvil36KCzcNpxBzeCFtCn0DwLGPGn0qosYPOP6ajrFEtASS5z+Yy MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg4epm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 12:41:46 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BBJjJv030635;
        Tue, 11 Apr 2023 12:41:45 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pw5xg4ens-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 12:41:45 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33B509oN008415;
        Tue, 11 Apr 2023 12:41:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pu0h5sf5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Apr 2023 12:41:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33BCffUZ41878260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 12:41:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EC682004B;
        Tue, 11 Apr 2023 12:41:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BCF220043;
        Tue, 11 Apr 2023 12:41:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.179.16.229])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 11 Apr 2023 12:41:39 +0000 (GMT)
Date:   Tue, 11 Apr 2023 15:41:38 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 22/29] selftests/mm: Move uffd pagemap test to unit test
Message-ID: <ZDVVguEBBMfg97cN@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160821.3107558-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160821.3107558-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zkFqe-VLpUA2k52P5k3JfopSU0HvPv2j
X-Proofpoint-ORIG-GUID: peNq_SQT-SpIsY0hRVVPJtBcHCz7600F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_08,2023-04-11_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110116
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:08:21PM -0400, Peter Xu wrote:
> Move it over and make it split into two tests, one for pagemap and one for
> the new WP_UNPOPULATED (to be a separate one).
> 
> The thp pagemap test wasn't really working (with MADV_HUGEPAGE).  Let's
> just drop it (since it never really worked anyway..) and leave that for
> later.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/uffd-stress.c     | 166 -------------------
>  tools/testing/selftests/mm/uffd-unit-tests.c | 145 ++++++++++++++++
>  2 files changed, 145 insertions(+), 166 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 70cb0619354e..50738a993afc 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -671,157 +671,6 @@ static int userfaultfd_minor_test(void)
>  	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
>  }
> 
> -static int pagemap_open(void)
> -{
> -	int fd = open("/proc/self/pagemap", O_RDONLY);
> -
> -	if (fd < 0)
> -		err("open pagemap");
> -
> -	return fd;
> -}
> -
> -/* This macro let __LINE__ works in err() */
> -#define  pagemap_check_wp(value, wp) do {				\
> -		if (!!(value & PM_UFFD_WP) != wp)			\
> -			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
> -	} while (0)
> -
> -static int pagemap_test_fork(bool present)
> -{
> -	pid_t child = fork();
> -	uint64_t value;
> -	int fd, result;
> -
> -	if (!child) {
> -		/* Open the pagemap fd of the child itself */
> -		fd = pagemap_open();
> -		value = pagemap_get_entry(fd, area_dst);
> -		/*
> -		 * After fork() uffd-wp bit should be gone as long as we're
> -		 * without UFFD_FEATURE_EVENT_FORK
> -		 */
> -		pagemap_check_wp(value, false);
> -		/* Succeed */
> -		exit(0);
> -	}
> -	waitpid(child, &result, 0);
> -	return result;
> -}
> -
> -static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
> -{
> -	uint64_t value;
> -
> -	/* Test applying pte marker to anon unpopulated */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, true);
> -
> -	/* Test unprotect on anon pte marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, false);
> -
> -	/* Test zap on anon marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> -		err("madvise(MADV_DONTNEED) failed");
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, false);
> -
> -	/* Test fault in after marker removed */
> -	*area_dst = 1;
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, false);
> -	/* Drop it to make pte none again */
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> -		err("madvise(MADV_DONTNEED) failed");
> -
> -	/* Test read-zero-page upon pte marker */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	*(volatile char *)area_dst;
> -	/* Drop it to make pte none again */
> -	if (madvise(area_dst, page_size, MADV_DONTNEED))
> -		err("madvise(MADV_DONTNEED) failed");
> -}
> -
> -static void userfaultfd_pagemap_test(unsigned int test_pgsize)
> -{
> -	int pagemap_fd;
> -	uint64_t value;
> -
> -	/* Pagemap tests uffd-wp only */
> -	if (!test_uffdio_wp)
> -		return;
> -
> -	/* Not enough memory to test this page size */
> -	if (test_pgsize > nr_pages * page_size)
> -		return;
> -
> -	printf("testing uffd-wp with pagemap (pgsize=%u): ", test_pgsize);
> -	/* Flush so it doesn't flush twice in parent/child later */
> -	fflush(stdout);
> -
> -	uffd_test_ctx_init(UFFD_FEATURE_WP_UNPOPULATED);
> -
> -	if (test_pgsize > page_size) {
> -		/* This is a thp test */
> -		if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
> -			err("madvise(MADV_HUGEPAGE) failed");
> -	} else if (test_pgsize == page_size) {
> -		/* This is normal page test; force no thp */
> -		if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
> -			err("madvise(MADV_NOHUGEPAGE) failed");
> -	}
> -
> -	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> -			  false, true, false))
> -		err("register failed");
> -
> -	pagemap_fd = pagemap_open();
> -
> -	/* Smoke test WP_UNPOPULATED first when it's still empty */
> -	if (test_pgsize == page_size)
> -		userfaultfd_wp_unpopulated_test(pagemap_fd);
> -
> -	/* Touch the page */
> -	*area_dst = 1;
> -	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, true);
> -	/* Make sure uffd-wp bit dropped when fork */
> -	if (pagemap_test_fork(true))
> -		err("Detected stall uffd-wp bit in child");
> -
> -	/* Exclusive required or PAGEOUT won't work */
> -	if (!(value & PM_MMAP_EXCLUSIVE))
> -		err("multiple mapping detected: 0x%"PRIx64, value);
> -
> -	if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
> -		err("madvise(MADV_PAGEOUT) failed");
> -
> -	/* Uffd-wp should persist even swapped out */
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, true);
> -	/* Make sure uffd-wp bit dropped when fork */
> -	if (pagemap_test_fork(false))
> -		err("Detected stall uffd-wp bit in child");
> -
> -	/* Unprotect; this tests swap pte modifications */
> -	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, false);
> -
> -	/* Fault in the page from disk */
> -	*area_dst = 2;
> -	value = pagemap_get_entry(pagemap_fd, area_dst);
> -	pagemap_check_wp(value, false);
> -
> -	close(pagemap_fd);
> -	printf("done\n");
> -}
> -
>  static int userfaultfd_stress(void)
>  {
>  	void *area;
> @@ -933,21 +782,6 @@ static int userfaultfd_stress(void)
>  		uffd_stats_report(uffd_stats, nr_cpus);
>  	}
> 
> -	if (test_type == TEST_ANON) {
> -		/*
> -		 * shmem/hugetlb won't be able to run since they have different
> -		 * behavior on fork() (file-backed memory normally drops ptes
> -		 * directly when fork), meanwhile the pagemap test will verify
> -		 * pgtable entry of fork()ed child.
> -		 */
> -		userfaultfd_pagemap_test(page_size);
> -		/*
> -		 * Hard-code for x86_64 for now for 2M THP, as x86_64 is
> -		 * currently the only one that supports uffd-wp
> -		 */
> -		userfaultfd_pagemap_test(page_size * 512);
> -	}
> -
>  	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
>  		|| userfaultfd_events_test() || userfaultfd_minor_test();
>  }
> diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
> index 007145063363..bcd67bd4ec90 100644
> --- a/tools/testing/selftests/mm/uffd-unit-tests.c
> +++ b/tools/testing/selftests/mm/uffd-unit-tests.c
> @@ -200,7 +200,152 @@ static bool uffd_feature_supported(uffd_test_case_t *test)
>  	    test->uffd_feature_required;
>  }
> 
> +static int pagemap_open(void)
> +{
> +	int fd = open("/proc/self/pagemap", O_RDONLY);
> +
> +	if (fd < 0)
> +		err("open pagemap");
> +
> +	return fd;
> +}
> +
> +/* This macro let __LINE__ works in err() */
> +#define  pagemap_check_wp(value, wp) do {				\
> +		if (!!(value & PM_UFFD_WP) != wp)			\
> +			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
> +	} while (0)
> +
> +static int pagemap_test_fork(bool present)
> +{
> +	pid_t child = fork();
> +	uint64_t value;
> +	int fd, result;
> +
> +	if (!child) {
> +		/* Open the pagemap fd of the child itself */
> +		fd = pagemap_open();
> +		value = pagemap_get_entry(fd, area_dst);
> +		/*
> +		 * After fork() uffd-wp bit should be gone as long as we're
> +		 * without UFFD_FEATURE_EVENT_FORK
> +		 */
> +		pagemap_check_wp(value, false);
> +		/* Succeed */
> +		exit(0);
> +	}
> +	waitpid(child, &result, 0);
> +	return result;
> +}
> +
> +static void uffd_wp_unpopulated_test(void)
> +{
> +	uint64_t value;
> +	int pagemap_fd;
> +
> +	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +			  false, true, false))
> +		err("register failed");
> +
> +	pagemap_fd = pagemap_open();
> +
> +	/* Test applying pte marker to anon unpopulated */
> +	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, true);
> +
> +	/* Test unprotect on anon pte marker */
> +	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, false);
> +
> +	/* Test zap on anon marker */
> +	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> +	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +		err("madvise(MADV_DONTNEED) failed");
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, false);
> +
> +	/* Test fault in after marker removed */
> +	*area_dst = 1;
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, false);
> +	/* Drop it to make pte none again */
> +	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +		err("madvise(MADV_DONTNEED) failed");
> +
> +	/* Test read-zero-page upon pte marker */
> +	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> +	*(volatile char *)area_dst;
> +	/* Drop it to make pte none again */
> +	if (madvise(area_dst, page_size, MADV_DONTNEED))
> +		err("madvise(MADV_DONTNEED) failed");
> +
> +	uffd_test_pass();
> +}
> +
> +static void uffd_pagemap_test(void)
> +{
> +	int pagemap_fd;
> +	uint64_t value;
> +
> +	if (uffd_register(uffd, area_dst, nr_pages * page_size,
> +			  false, true, false))
> +		err("register failed");
> +
> +	pagemap_fd = pagemap_open();
> +
> +	/* Touch the page */
> +	*area_dst = 1;
> +	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, true);
> +	/* Make sure uffd-wp bit dropped when fork */
> +	if (pagemap_test_fork(true))
> +		err("Detected stall uffd-wp bit in child");
> +
> +	/* Exclusive required or PAGEOUT won't work */
> +	if (!(value & PM_MMAP_EXCLUSIVE))
> +		err("multiple mapping detected: 0x%"PRIx64, value);
> +
> +	if (madvise(area_dst, page_size, MADV_PAGEOUT))
> +		err("madvise(MADV_PAGEOUT) failed");
> +
> +	/* Uffd-wp should persist even swapped out */
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, true);
> +	/* Make sure uffd-wp bit dropped when fork */
> +	if (pagemap_test_fork(false))
> +		err("Detected stall uffd-wp bit in child");
> +
> +	/* Unprotect; this tests swap pte modifications */
> +	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, false);
> +
> +	/* Fault in the page from disk */
> +	*area_dst = 2;
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
> +	pagemap_check_wp(value, false);
> +
> +	close(pagemap_fd);
> +	uffd_test_pass();
> +}
> +
>  uffd_test_case_t uffd_tests[] = {
> +	{
> +		.name = "pagemap",
> +		.uffd_fn = uffd_pagemap_test,
> +		.mem_targets = MEM_ANON,
> +		.uffd_feature_required = UFFD_FEATURE_PAGEFAULT_FLAG_WP,
> +	},
> +	{
> +		.name = "wp-unpopulated",
> +		.uffd_fn = uffd_wp_unpopulated_test,
> +		.mem_targets = MEM_ANON,
> +		.uffd_feature_required =
> +		UFFD_FEATURE_PAGEFAULT_FLAG_WP | UFFD_FEATURE_WP_UNPOPULATED,
> +	},
>  };
> 
>  int main(int argc, char *argv[])
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
