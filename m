Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260AC6DAC19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 13:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjDGLJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 07:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDGLJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:09:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8C19C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 04:09:09 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337AQ7A9012388;
        Fri, 7 Apr 2023 11:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=g/w4fxLy7hDKVGz/eqMEN9gznLfR6o3eaYfA4Q/dyU0=;
 b=pF3zy3QY1oUMxWv34ieVvUctpgbhkqGKcHF/JrRsf/jjI+m74WxNPVSBS+kBS8j0sZQl
 eAjOQgVlFzadlG5He4TP2k39IhrbsaBgQ2S/5o1BJJOhnXZryu5FjAvw3d03IpeMMxq8
 JHw1R2PI9Quz8HwLzGXvoB4DCo4GSHBdAXHlpSj5Pf9l8sw6V7dGr1xs2Wjb9eOlcDHB
 G+Zn4bfU1YD8T1+UlyEiSEPZ9NsASywAUbT2vUYGiuYJaOC0hZAlE3w/8ydfZqaPrvx0
 iW2kTwibPAJ2Cztk585MuaeqLDUcw3GGiRicLhSBdiNoedj3V/zTz7s3zRcDEdef3JV5 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pthdp0sxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:09:03 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337Ax5r9027579;
        Fri, 7 Apr 2023 11:09:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pthdp0swm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:09:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3374uLdG031743;
        Fri, 7 Apr 2023 11:09:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ppc87cx14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 11:09:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 337B8w9557672044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 11:08:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 178FD20043;
        Fri,  7 Apr 2023 11:08:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D457420040;
        Fri,  7 Apr 2023 11:08:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 11:08:56 +0000 (GMT)
Date:   Fri, 7 Apr 2023 14:08:54 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/29] selftests/mm: uffd_[un]register()
Message-ID: <ZC/5xstCOs8wp6nK@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160747.3107258-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160747.3107258-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HNi-KUOAMRK0qcaaCGkQybF7T9INWr-z
X-Proofpoint-ORIG-GUID: PCMIwhncLIeqnP0UjHaF_-w7_OKaSvmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_06,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070100
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 12:07:47PM -0400, Peter Xu wrote:
> Add two helpers to register/unregister to an uffd.  Use them to drop
> duplicate codes.
> 
> This patch also drops assert_expected_ioctls_present() and
> get_expected_ioctls().  Reasons:
> 
>   - It'll need a lot of effort to pass test_type==HUGETLB into it from the
>   upper, so it's the simplest way to get rid of another global var
> 
>   - The ioctls returned in UFFDIO_REGISTER is hardly useful at all, because
>   any app can already detect kernel support on any ioctl via its
>   corresponding UFFD_FEATURE_*.  The check here is for sanity mostly but
>   it's probably destined no user app will even use it.
> 
>   - It's not friendly to one future goal of uffd to run on old kernels, the
>   problem is get_expected_ioctls() compiles against UFFD_API_RANGE_IOCTLS,
>   which is a value that can change depending on where the test is compiled,
>   rather than reflecting what the kernel underneath has.  It means it'll
>   report false negatives on old kernels so it's against our will.
> 
> So let's make our live easier.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/hugepage-mremap.c  |  7 +-
>  .../selftests/mm/ksm_functional_tests.c       |  6 +-
>  tools/testing/selftests/mm/uffd-common.c      | 28 +------
>  tools/testing/selftests/mm/uffd-common.h      |  2 -
>  tools/testing/selftests/mm/uffd-stress.c      | 83 +++++--------------
>  tools/testing/selftests/mm/vm_util.c          | 37 +++++++++
>  tools/testing/selftests/mm/vm_util.h          |  7 ++
>  7 files changed, 66 insertions(+), 104 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
> index e53b5eaa8fce..2084692fe1c4 100644
> --- a/tools/testing/selftests/mm/hugepage-mremap.c
> +++ b/tools/testing/selftests/mm/hugepage-mremap.c
> @@ -60,7 +60,6 @@ static void register_region_with_uffd(char *addr, size_t len)
>  {
>  	long uffd; /* userfaultfd file descriptor */
>  	struct uffdio_api uffdio_api;
> -	struct uffdio_register uffdio_register;
> 
>  	/* Create and enable userfaultfd object. */
> 
> @@ -96,11 +95,7 @@ static void register_region_with_uffd(char *addr, size_t len)
>  	 * handling by the userfaultfd object. In mode, we request to track
>  	 * missing pages (i.e., pages that have not yet been faulted in).
>  	 */
> -
> -	uffdio_register.range.start = (unsigned long)addr;
> -	uffdio_register.range.len = len;
> -	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> -	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
> +	if (uffd_register(uffd, addr, len, true, false, false)) {

I'd replace booleans with a bit flags as it easier to read.
Other than that LGTM.

>  		perror("ioctl-UFFDIO_REGISTER");
>  		exit(1);
>  	}

-- 
Sincerely yours,
Mike.
