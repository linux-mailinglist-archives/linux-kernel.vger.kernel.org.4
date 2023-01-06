Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E734566042C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjAFQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbjAFQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:23:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5D76232;
        Fri,  6 Jan 2023 08:23:28 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306FYwOG025876;
        Fri, 6 Jan 2023 16:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ql3Dq3OKrULgExddm/HAzePJFPLsh7OxUl95tMTnSA8=;
 b=CPxeO0tlqe19XC64dQ28z3taOCZvjZEXwUQvk644JHCU+J9VYP7Rjn3M5AZuH7sRa7Lo
 3PS1ihZ3OXNHJvdP0BGRFXFLGFlOcYND/h1hdwjynnCVKQ6WGbJVwIbNbfs+lCjIx4fq
 u1uxDh12nxk9RuH4QLDwn4wuD5hGE/Wh49OwXEnkEA/gOKW3lPEIDj+9FVeo6TwLI6LY
 dAmhgO3/lwtU7HVWzvO43h8xhfebalKHkROjDfuyKE6lJRnVgDBH2a1uU2Ks+tIS4Nil
 nXoBcGWkz/szCIRuSziD25w/oB2zz6cqJhwhsViVgjpKlN7m2G02EOmqlavjVTpFSAGx 9w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mxdk8ufh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 16:23:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3068A9eh020202;
        Fri, 6 Jan 2023 16:23:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6ggg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 16:23:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 306GNE4833358086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Jan 2023 16:23:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3573420040;
        Fri,  6 Jan 2023 16:23:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C373220043;
        Fri,  6 Jan 2023 16:23:13 +0000 (GMT)
Received: from osiris (unknown [9.171.33.195])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  6 Jan 2023 16:23:13 +0000 (GMT)
Date:   Fri, 6 Jan 2023 17:23:12 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: fix -Wundef warning for CONFIG_KERNEL_ZSTD
Message-ID: <Y7hK8HIULQ8zeiZ3@osiris>
References: <20230106161024.2373602-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106161024.2373602-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NKXI0N8StoQ8pzyf3NHy8G07BDikxJNc
X-Proofpoint-ORIG-GUID: NKXI0N8StoQ8pzyf3NHy8G07BDikxJNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_10,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0 suspectscore=0
 mlxlogscore=657 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301060124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 01:10:23AM +0900, Masahiro Yamada wrote:
> Since commit 80b6093b55e3 ("kbuild: add -Wundef to KBUILD_CPPFLAGS
> for W=1 builds"), building with W=1 detects misuse of #(el)if.
> 
>   $ make W=1 ARCH=s390 CROSS_COMPILE=s390x-linux-gnu-
>     [snip]
>   arch/s390/boot/decompressor.c:28:7: warning: "CONFIG_KERNEL_ZSTD" is not defined, evaluates to 0 [-Wundef]
>      28 | #elif CONFIG_KERNEL_ZSTD
>         |       ^~~~~~~~~~~~~~~~~~
> 
> This issue has been hidden because arch/s390/boot/Makefile overwrites
> KBUILD_CFLAGS, dropping -Wundef.
> 
> CONFIG_KERNEL_ZSTD is a bool option. #elif defined() should be used.
> 
> The line #ifdef CONFIG_KERNEL_BZIP2 is fine, but I changed it for
> consistency.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/boot/decompressor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
