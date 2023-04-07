Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D816DAAE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbjDGJdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjDGJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:33:01 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D346B4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:32:59 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3378FBmk000351;
        Fri, 7 Apr 2023 09:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JMskfpgSNxhFM88ByW1D/aC4AKoFFyWINNCHKHhAu+w=;
 b=ro/qxl/uN9w7s494364wdq/tk8wULCJFmdH90OjRzPmzisjWnpHG5sSf3xDInv2TF3E6
 /W9xXUvKWdx71a9KPe6WCWrvVf6akzM8qNcBUomSlKaZXgRWj0NSEeS9z4p5mREdGJwp
 H81Dcwm6eiFSK0l79SLY7WUMbdv0ckxLVx+hqO8iXlR5+LLaDQVajRxBSgGhef/YsUKR
 NwPgmqYY2p0RzwEFwCJutmM/BLgreVTKI3TOmznMnyxfjJZFkAcZe7spJ0Zy3nQ0dwvJ
 oXvs94gTWFVxJH8c5ZoYM/e8Q/hF8LR35wHZrxqI9GUNHMzsuAWpa6GztHTdYtXL8yQH WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41dph2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:32:54 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3378sKxS012858;
        Fri, 7 Apr 2023 09:32:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41dpgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:32:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33706g8l028613;
        Fri, 7 Apr 2023 09:32:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3ppbvg4v37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:32:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379WnMk13173306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:32:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A68B620043;
        Fri,  7 Apr 2023 09:32:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E0D420040;
        Fri,  7 Apr 2023 09:32:48 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:32:48 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:32:46 +0300
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
Subject: Re: [PATCH 09/29] selftests/mm: Reuse pagemap_get_entry() in
 vm_util.h
Message-ID: <ZC/jPr6BXsZR5F4b@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160711.3106988-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160711.3106988-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -gTDymuNKYVWuKToG9sVUASKA2dnCsaQ
X-Proofpoint-GUID: 5xRx1OLWsQfKdcxYKAAR3FJwvUQxqgfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
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

On Thu, Mar 30, 2023 at 12:07:11PM -0400, Peter Xu wrote:
> Subject: selftests/mm: Reuse pagemap_get_entry() in vm_util.h

Nit: selftests/mm/uffd:

> Meanwhile drop pagemap_read_vaddr().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/userfaultfd.c | 31 +++++++-----------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> index 7e841f7e2884..795fbc4d84f8 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1399,19 +1399,6 @@ static int pagemap_open(void)
>  	return fd;
>  }
> 
> -static uint64_t pagemap_read_vaddr(int fd, void *vaddr)
> -{
> -	uint64_t value;
> -	int ret;
> -
> -	ret = pread(fd, &value, sizeof(uint64_t),
> -		    ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
> -	if (ret != sizeof(uint64_t))
> -		err("pread() on pagemap failed");
> -
> -	return value;
> -}
> -
>  /* This macro let __LINE__ works in err() */
>  #define  pagemap_check_wp(value, wp) do {				\
>  		if (!!(value & PM_UFFD_WP) != wp)			\
> @@ -1427,7 +1414,7 @@ static int pagemap_test_fork(bool present)
>  	if (!child) {
>  		/* Open the pagemap fd of the child itself */
>  		fd = pagemap_open();
> -		value = pagemap_read_vaddr(fd, area_dst);
> +		value = pagemap_get_entry(fd, area_dst);
>  		/*
>  		 * After fork() uffd-wp bit should be gone as long as we're
>  		 * without UFFD_FEATURE_EVENT_FORK
> @@ -1446,24 +1433,24 @@ static void userfaultfd_wp_unpopulated_test(int pagemap_fd)
> 
>  	/* Test applying pte marker to anon unpopulated */
>  	wp_range(uffd, (uint64_t)area_dst, page_size, true);
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, true);
> 
>  	/* Test unprotect on anon pte marker */
>  	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, false);
> 
>  	/* Test zap on anon marker */
>  	wp_range(uffd, (uint64_t)area_dst, page_size, true);
>  	if (madvise(area_dst, page_size, MADV_DONTNEED))
>  		err("madvise(MADV_DONTNEED) failed");
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, false);
> 
>  	/* Test fault in after marker removed */
>  	*area_dst = 1;
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, false);
>  	/* Drop it to make pte none again */
>  	if (madvise(area_dst, page_size, MADV_DONTNEED))
> @@ -1522,7 +1509,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>  	/* Touch the page */
>  	*area_dst = 1;
>  	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, true);
>  	/* Make sure uffd-wp bit dropped when fork */
>  	if (pagemap_test_fork(true))
> @@ -1536,7 +1523,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
>  		err("madvise(MADV_PAGEOUT) failed");
> 
>  	/* Uffd-wp should persist even swapped out */
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, true);
>  	/* Make sure uffd-wp bit dropped when fork */
>  	if (pagemap_test_fork(false))
> @@ -1544,12 +1531,12 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
> 
>  	/* Unprotect; this tests swap pte modifications */
>  	wp_range(uffd, (uint64_t)area_dst, page_size, false);
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, false);
> 
>  	/* Fault in the page from disk */
>  	*area_dst = 2;
> -	value = pagemap_read_vaddr(pagemap_fd, area_dst);
> +	value = pagemap_get_entry(pagemap_fd, area_dst);
>  	pagemap_check_wp(value, false);
> 
>  	close(pagemap_fd);
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
