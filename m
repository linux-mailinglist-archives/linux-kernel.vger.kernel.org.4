Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5456DAAC7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjDGJXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjDGJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:23:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81429559F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:23:34 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3378EYLJ032187;
        Fri, 7 Apr 2023 09:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=J0NLgY2eKMMih3APjlZunVE93FXMckGfYTJYgjYSqqo=;
 b=KLyNja2ZlPUVljxHJYZyXdPAGPiUf2bmEzqcinI2aRH823qIzki9BoeXXxXYkyTaCowU
 y55+FjjxRp4xNOrMQKQxcC0hrIiiTSzaGLnQBCRSsV2ekGCSnUK9RAjEmi15GvdC/63n
 DsJb7DVu5o411Hgf4OtGEbAv4bUEdC7KHKiCvu7ts82Pj3CSS9adxbPO9pyuZRk9+X+w
 nyS6S9Ow9xKfCI6tZh++SI+Vc0byq4EQ0DebWzgnk5ElaiHiPNvNJSfrXiw7eR4jckhc
 zq0FKfZhAuHBsitCfhSe7RQ7Ovfz7N0jPrf0nqywdiz0gVs88lxUYOCqE+xyTgBk0kgl mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41dhbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:23:29 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3378r2Gl009695;
        Fri, 7 Apr 2023 09:23:28 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ptc41dhb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:23:28 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 336MP18a000624;
        Fri, 7 Apr 2023 09:23:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvfup74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Apr 2023 09:23:26 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3379NNWe19989206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Apr 2023 09:23:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEA0D20049;
        Fri,  7 Apr 2023 09:23:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5CBE20043;
        Fri,  7 Apr 2023 09:23:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.171.71.120])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  7 Apr 2023 09:23:22 +0000 (GMT)
Date:   Fri, 7 Apr 2023 12:23:20 +0300
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
Subject: Re: [PATCH 06/29] selftests/mm: Link vm_util.c always
Message-ID: <ZC/hCGCMslZWCjQa@linux.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160700.3106955-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330160700.3106955-1-peterx@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DDXyBlwNKZQlGv4wcbp0HrRO1mv885VO
X-Proofpoint-GUID: MguoooGxFqttbPmVH5r-cmW29DXPbeFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=635
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

On Thu, Mar 30, 2023 at 12:07:00PM -0400, Peter Xu wrote:
> We do have plenty of files that want to link against vm_util.c.  Just make
> it simple by linking it always.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/Makefile | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 47516a78d447..b35f3eafde3c 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -105,17 +105,7 @@ TEST_FILES += va_128TBswitch.sh
> 
>  include ../lib.mk
> 
> -$(OUTPUT)/cow: vm_util.c
> -$(OUTPUT)/khugepaged: vm_util.c
> -$(OUTPUT)/ksm_functional_tests: vm_util.c
> -$(OUTPUT)/madv_populate: vm_util.c
> -$(OUTPUT)/soft-dirty: vm_util.c
> -$(OUTPUT)/split_huge_page_test: vm_util.c
> -$(OUTPUT)/userfaultfd: vm_util.c
> -$(OUTPUT)/gup_test: vm_util.c
> -$(OUTPUT)/mrelease_test: vm_util.c
> -$(OUTPUT)/transhuge-stress: vm_util.c
> -$(OUTPUT)/ksm_tests: vm_util.c
> +$(TEST_GEN_PROGS): vm_util.c
> 
>  ifeq ($(MACHINE),x86_64)
>  BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> -- 
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
