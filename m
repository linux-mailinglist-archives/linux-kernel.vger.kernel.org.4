Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279D86183AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbiKCQFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiKCQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:04:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30F41E72C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:02:26 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3FcXSI032562;
        Thu, 3 Nov 2022 16:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=RHGYzL6HBFwRpP58PRBhJnwTukk2/WWX9VndeIDpZVw=;
 b=LY9LENNnzi4xScCfX6Key+ykkH1uLDmNxacpvRr8VnwFktw4AgbU0RM9dVV2OTD1xI/Z
 DZmYi80tgllupU5nLzzGM3m5Rm8E+PwR+fxDSClcsaygDt8b32V/oV1OlarXLZyI2g5B
 yYJ5EGlFvwO3pre1FxfxC6zM+iBw9wPDrdrNtverQnc7MmYb31MbFpGPVUV2gNHSVXdJ
 M7N1xPmEG2KcoRhscPGM+eDzQY1lqr0OUiIPGA58ntxfB/t8uOglsfot5xAzNE8y1tQu
 lqw3IdMpn4YqhTdYZZt0+Urz3Em+NWx4C3oLiyes8ifsX9uCQ5tx7lafc2YMRV2u//PM kw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmf9r4h5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:02:10 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3F6dTJ022637;
        Thu, 3 Nov 2022 16:02:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut991j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 16:02:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3G2fkF51511786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 16:02:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F421AE04D;
        Thu,  3 Nov 2022 16:02:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB016AE045;
        Thu,  3 Nov 2022 16:02:03 +0000 (GMT)
Received: from localhost (unknown [9.171.56.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Nov 2022 16:02:03 +0000 (GMT)
Date:   Thu, 3 Nov 2022 17:02:02 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb_vmemmap: include missing linux/moduleparam.h
Message-ID: <your-ad-here.call-01667491322-ext-5168@work.hours>
References: <patch.git-296b83ca939b.your-ad-here.call-01667411912-ext-5073@work.hours>
 <71BFC75C-483D-42C0-8248-59FC8DBE148C@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71BFC75C-483D-42C0-8248-59FC8DBE148C@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k7APG_JBHhj9KPhONqzItEdIaQauVAIG
X-Proofpoint-ORIG-GUID: k7APG_JBHhj9KPhONqzItEdIaQauVAIG
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=803 suspectscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:51:59AM +0800, Muchun Song wrote:
> 
> 
> > On Nov 3, 2022, at 02:09, Vasily Gorbik <gor@linux.ibm.com> wrote:
> > 
> > The kernel test robot reported build failures with a 'randconfig' on s390:
> >>> mm/hugetlb_vmemmap.c:421:11: error: a function declaration without a
> > prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >   core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
> >             ^
> > 
> > Link: https://lore.kernel.org/linux-mm/202210300751.rG3UDsuc-lkp@intel.com/
> > Reported-by: kernel test robot <lkp@intel.com>
> > Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with core_param()")
> 
> Thanks for your fixing. However, the correct commit that should be fixed is
> 42deddf3ef5c ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP").
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Even on x86 the inclusion chain looks like:
  CC      mm/hugetlb_vmemmap.o
In file included from ./include/linux/module.h:22,
                 from ./include/linux/device/driver.h:21,
                 from ./include/linux/device.h:32,
                 from ./include/linux/blk_types.h:11,
                 from ./include/linux/writeback.h:13,
                 from ./include/linux/memcontrol.h:22,
                 from ./include/linux/swap.h:9,
                 from ./include/asm-generic/hugetlb.h:5,
                 from ./arch/x86/include/asm/hugetlb.h:6,
                 from ./include/linux/hugetlb.h:802,
                 from mm/hugetlb_vmemmap.h:11,
                 from mm/hugetlb_vmemmap.c:18:
./include/linux/moduleparam.h:2:2: warning: #warning included from here

With s390 defconfig:
  CC      mm/hugetlb_vmemmap.o
In file included from ./include/linux/module.h:22,
                 from ./include/linux/device/driver.h:21,
                 from ./include/linux/device.h:32,
                 from ./include/linux/blk_types.h:11,
                 from ./include/linux/writeback.h:13,
                 from ./include/linux/memcontrol.h:22,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/userfaultfd_k.h:18, <-- randconfig disabled this path (CONFIG_USERFAULTFD)
                 from ./include/linux/hugetlb.h:14,
                 from mm/hugetlb_vmemmap.h:11,
                 from mm/hugetlb_vmemmap.c:17:
./include/linux/moduleparam.h:2:2: warning: #warning included from here

42deddf3ef5c ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP") is
just a one liner activating this feature and only present in linux-next
and s390 features branch targeting v6.2. So, if you don't want to have

Fixes: 30152245c63b ("mm: hugetlb_vmemmap: replace early_param() with core_param()")

fine with me. But then just dropping Fixes tag is probably a better
option. I hope that won't prevent it from going into some v6.1-rcX.

@Andrew
should I resend? or would you be so kind to drop Fixes tag and add Reviewed-by
without it? Thank you
