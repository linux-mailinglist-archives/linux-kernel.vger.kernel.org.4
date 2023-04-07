Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1DB6DAAC6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjDGJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:22:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164C8525D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:22:47 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3378NiL4028501;
        Fri, 7 Apr 2023 09:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=pWzqf0UkXNJqwwrQYydLFrs7uKCP1LbVMOsRDzVXnzU=;
 b=r/ZQ0IxDYO4G2llSLE1nSI3Xw8dHb2raFJ+a5T/u9jP4KKMcY6kVM13nI9R+rDK9m5sP
 Fbj1r9Zt0sFw7aXPTCvSpvifFBtJfCRNyKGur3mFzMYGMoc14fkicXq8Z9gvVnlrwdlc
 pMikOFZoLl93qzdpXu8MzmDz8uc1PI9Ro8pqXa1F2NA0DZyGvv01WMaVgbUpNImo5V15
 qNZrLK6l5YPhlAmvc8x0rsm1LzYieedS5G/EAscTqmGwCDETrTlP7cDoksQJsJIRYtU+
 1PRhS0KzqRxMl1lcpmMiLPZwkgW7zxoFgxIetY0WJ2/oS0XXaMlcu7PWvRU8jM/76Au9 xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptfmk92dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:22:41 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3379073N018757;
        Fri, 7 Apr 2023 09:22:41 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptfmk92cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:22:40 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3374DfdE004979;
        Fri, 7 Apr 2023 09:22:38 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3ppc86up5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:22:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379MZZG61997462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:22:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B95A420043;
        Fri,  7 Apr 2023 09:22:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B6F720040;
        Fri,  7 Apr 2023 09:22:34 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:22:34 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:22:32 +0300
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
Subject: Re: [PATCH 05/29] selftests/mm: Use TEST_GEN_PROGS where proper
Message-ID: <ZC/g2EJfkFgn8IZT@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160654.3106929-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160654.3106929-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C3cSGam_sDokfJnn7WwV_6MZX58Ef_MQ
X-Proofpoint-GUID: fBOhmb8rbmz_flQE1Uxu0cxPNn8lJsF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_04,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=576 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:06:54PM -0400, Peter Xu wrote:
> TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
> specify programs that need to build.  Logically all these binaries should
> all fall into TEST_GEN_PROGS.
> 
> Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
> all the tests easily later.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/Makefile | 63 +++++++++++++++--------------
>  1 file changed, 32 insertions(+), 31 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 4188435967ed..47516a78d447 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -31,34 +31,35 @@ MAKEFLAGS += --no-builtin-rules
> 
>  CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>  LDLIBS = -lrt -lpthread
> -TEST_GEN_FILES = cow
> -TEST_GEN_FILES += compaction_test
> -TEST_GEN_FILES += gup_test
> -TEST_GEN_FILES += hmm-tests
> -TEST_GEN_FILES += hugetlb-madvise
> -TEST_GEN_FILES += hugepage-mmap
> -TEST_GEN_FILES += hugepage-mremap
> -TEST_GEN_FILES += hugepage-shm
> -TEST_GEN_FILES += hugepage-vmemmap
> -TEST_GEN_FILES += khugepaged
> +
> +TEST_GEN_PROGS = cow
> +TEST_GEN_PROGS += compaction_test
> +TEST_GEN_PROGS += gup_test
> +TEST_GEN_PROGS += hmm-tests
> +TEST_GEN_PROGS += hugetlb-madvise
> +TEST_GEN_PROGS += hugepage-mmap
> +TEST_GEN_PROGS += hugepage-mremap
> +TEST_GEN_PROGS += hugepage-shm
> +TEST_GEN_PROGS += hugepage-vmemmap
> +TEST_GEN_PROGS += khugepaged
>  TEST_GEN_PROGS = madv_populate
> -TEST_GEN_FILES += map_fixed_noreplace
> -TEST_GEN_FILES += map_hugetlb
> -TEST_GEN_FILES += map_populate
> -TEST_GEN_FILES += memfd_secret
> -TEST_GEN_FILES += migration
> -TEST_GEN_FILES += mlock-random-test
> -TEST_GEN_FILES += mlock2-tests
> -TEST_GEN_FILES += mrelease_test
> -TEST_GEN_FILES += mremap_dontunmap
> -TEST_GEN_FILES += mremap_test
> -TEST_GEN_FILES += on-fault-limit
> -TEST_GEN_FILES += thuge-gen
> -TEST_GEN_FILES += transhuge-stress
> -TEST_GEN_FILES += userfaultfd
> +TEST_GEN_PROGS += map_fixed_noreplace
> +TEST_GEN_PROGS += map_hugetlb
> +TEST_GEN_PROGS += map_populate
> +TEST_GEN_PROGS += memfd_secret
> +TEST_GEN_PROGS += migration
> +TEST_GEN_PROGS += mlock-random-test
> +TEST_GEN_PROGS += mlock2-tests
> +TEST_GEN_PROGS += mrelease_test
> +TEST_GEN_PROGS += mremap_dontunmap
> +TEST_GEN_PROGS += mremap_test
> +TEST_GEN_PROGS += on-fault-limit
> +TEST_GEN_PROGS += thuge-gen
> +TEST_GEN_PROGS += transhuge-stress
> +TEST_GEN_PROGS += userfaultfd
>  TEST_GEN_PROGS += soft-dirty
>  TEST_GEN_PROGS += split_huge_page_test
> -TEST_GEN_FILES += ksm_tests
> +TEST_GEN_PROGS += ksm_tests
>  TEST_GEN_PROGS += ksm_functional_tests
>  TEST_GEN_PROGS += mdwe_test
> 
> @@ -76,24 +77,24 @@ CFLAGS += -no-pie
>  endif
> 
>  ifeq ($(CAN_BUILD_I386),1)
> -TEST_GEN_FILES += $(BINARIES_32)
> +TEST_GEN_PROGS += $(BINARIES_32)
>  endif
> 
>  ifeq ($(CAN_BUILD_X86_64),1)
> -TEST_GEN_FILES += $(BINARIES_64)
> +TEST_GEN_PROGS += $(BINARIES_64)
>  endif
>  else
> 
>  ifneq (,$(findstring $(MACHINE),ppc64))
> -TEST_GEN_FILES += protection_keys
> +TEST_GEN_PROGS += protection_keys
>  endif
> 
>  endif
> 
>  ifneq (,$(filter $(MACHINE),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
> -TEST_GEN_FILES += va_128TBswitch
> -TEST_GEN_FILES += virtual_address_range
> -TEST_GEN_FILES += write_to_hugetlbfs
> +TEST_GEN_PROGS += va_128TBswitch
> +TEST_GEN_PROGS += virtual_address_range
> +TEST_GEN_PROGS += write_to_hugetlbfs
>  endif
> 
>  TEST_PROGS := run_vmtests.sh
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
