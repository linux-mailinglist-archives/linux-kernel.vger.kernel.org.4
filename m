Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D60A6DAADB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbjDGJ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbjDGJ2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:28:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADEF7EC9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:28:47 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3377NITY023701;
        Fri, 7 Apr 2023 09:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=l6TIiiTzXpviYV8V+CDhVSL00O3KvbHlSgUHC+6wqNY=;
 b=H1nDARj1GmCap2MWOD3ohTUp2/ehGyJalkSBWVJku4jSTofhwP5mumr7g3UjKpP3aOLZ
 kLcElVezhPnK2eJEuPQrO2bhEZGgp5tI1PkYlrwCOug4eA8Rn0Ld4dWgKXuYcGALkId3
 HYT+3+k0sxS31rr/TGec1EdrlNL5pwljLtkPZM/NSAjE+1gXPA/bBDp83aw5YgHXA/Yf
 mS1f+BHxY8PhKaXJUnaLK9WDdJ2MeeQoi4JizfKtts7/DhOPnrmQ754PV0N9NqJmgRz+
 9UGtWZb3Ig/dxFRBCbpeDM0rgfYl1cUSRsIJv/txhcW/DnVpRNdPuR6azvk1cGBkCg+9 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pter82d95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:28:41 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379GsVo030964;
        Fri, 7 Apr 2023 09:28:41 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pter82d8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:28:40 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336Nw1CU018894;
        Fri, 7 Apr 2023 09:28:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc87cvq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:28:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379San534472318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:28:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 940DD20040;
        Fri,  7 Apr 2023 09:28:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77CFB2004B;
        Fri,  7 Apr 2023 09:28:35 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:28:35 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:28:33 +0300
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
Subject: Re: [PATCH 08/29] selftests/mm: Use PM_* macros in vm_utils.h
Message-ID: <ZC/iQWba+yqLr7EX@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160708.3106977-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160708.3106977-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gMHXTDyET44tT2n4F2pj9df3jHpYAbzA
X-Proofpoint-ORIG-GUID: cJ_Iww4BMDEX3_T5CR8wZviNCyKLmdfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=909 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:08PM -0400, Peter Xu wrote:
> We've got the macros in uffd-stress.c, move it over and use it in
> vm_util.h.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/userfaultfd.c |  8 --------
>  tools/testing/selftests/mm/vm_util.c     | 16 ++++------------
>  tools/testing/selftests/mm/vm_util.h     |  8 ++++++++
>  3 files changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/userfaultfd.c b/tools/testing/selftests/mm/userfaultfd.c
> index 4cc80a0e8955..7e841f7e2884 100644
> --- a/tools/testing/selftests/mm/userfaultfd.c
> +++ b/tools/testing/selftests/mm/userfaultfd.c
> @@ -1389,14 +1389,6 @@ static int userfaultfd_minor_test(void)
>  	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
>  }
> 
> -#define BIT_ULL(nr)                   (1ULL << (nr))
> -#define PM_SOFT_DIRTY                 BIT_ULL(55)
> -#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
> -#define PM_UFFD_WP                    BIT_ULL(57)
> -#define PM_FILE                       BIT_ULL(61)
> -#define PM_SWAP                       BIT_ULL(62)
> -#define PM_PRESENT                    BIT_ULL(63)
> -
>  static int pagemap_open(void)
>  {
>  	int fd = open("/proc/self/pagemap", O_RDONLY);
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 12dc654b5be3..8e9da621764a 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -25,25 +25,17 @@ uint64_t pagemap_get_entry(int fd, char *start)
> 
>  bool pagemap_is_softdirty(int fd, char *start)
>  {
> -	uint64_t entry = pagemap_get_entry(fd, start);
> -
> -	// Check if dirty bit (55th bit) is set
> -	return entry & 0x0080000000000000ull;
> +	return pagemap_get_entry(fd, start) & PM_SOFT_DIRTY;
>  }
> 
>  bool pagemap_is_swapped(int fd, char *start)
>  {
> -	uint64_t entry = pagemap_get_entry(fd, start);
> -
> -	return entry & 0x4000000000000000ull;
> +	return pagemap_get_entry(fd, start) & PM_SWAP;
>  }
> 
>  bool pagemap_is_populated(int fd, char *start)
>  {
> -	uint64_t entry = pagemap_get_entry(fd, start);
> -
> -	/* Present or swapped. */
> -	return entry & 0xc000000000000000ull;
> +	return pagemap_get_entry(fd, start) & (PM_PRESENT | PM_SWAP);
>  }
> 
>  unsigned long pagemap_get_pfn(int fd, char *start)
> @@ -51,7 +43,7 @@ unsigned long pagemap_get_pfn(int fd, char *start)
>  	uint64_t entry = pagemap_get_entry(fd, start);
> 
>  	/* If present (63th bit), PFN is at bit 0 -- 54. */
> -	if (entry & 0x8000000000000000ull)
> +	if (entry & PM_PRESENT)
>  		return entry & 0x007fffffffffffffull;
>  	return -1ul;
>  }
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index d7163fff8fb7..d9fadddb5c69 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -6,6 +6,14 @@
>  #include <string.h> /* ffsl() */
>  #include <unistd.h> /* _SC_PAGESIZE */
> 
> +#define BIT_ULL(nr)                   (1ULL << (nr))
> +#define PM_SOFT_DIRTY                 BIT_ULL(55)
> +#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
> +#define PM_UFFD_WP                    BIT_ULL(57)
> +#define PM_FILE                       BIT_ULL(61)
> +#define PM_SWAP                       BIT_ULL(62)
> +#define PM_PRESENT                    BIT_ULL(63)
> +
>  extern unsigned int __page_size;
>  extern unsigned int __page_shift;
> 
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
