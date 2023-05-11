Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816796FF543
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbjEKO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbjEKO5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:57:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494C5DC7E
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 07:56:51 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34BEnRla011366;
        Thu, 11 May 2023 14:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k+HAyR82gDN6GXu6hMcaiEPBrpTb/v8Qlx2V5ldkMGo=;
 b=tnW9viWP+rBo+hqZ+9L4gC1O9qLCkq7gYVF2t5orVJxfIagyJMRXa1lEM13qVtkcqksP
 Jumif8ptg02Ll8LbRCyRABIDbY3LRnAoAnik6JT73qHunlSfY63Y1TRw6InFl3H8fj32
 eAj4si7CwB9S90w9UYSRrlijI7NSYd7FJqGsmEcmvO67V9+ZuazB7NXceA2E0QNTMgFb
 hme94AtmxGEz+E3ClPYbL5Svf6hRlmWGLHDan5XL/WFzzDgE33v7mLqbkOsr0LGuHZFW
 CK1usmYu1DRARH81P3cxURpoU7Im0kiphL8lof91tUaF91jTSqi7woEJilwzRYB2T+OD UQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qh241s09f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 14:56:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34BDeQDJ000768;
        Thu, 11 May 2023 14:35:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qf7e0seu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 14:35:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34BEZH0x29229658
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 May 2023 14:35:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 153B420040;
        Thu, 11 May 2023 14:35:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A64F32004F;
        Thu, 11 May 2023 14:35:16 +0000 (GMT)
Received: from osiris (unknown [9.171.73.17])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 11 May 2023 14:35:16 +0000 (GMT)
Date:   Thu, 11 May 2023 16:35:15 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 0/2] statfs: Enforce statfs[64] structure intialization
Message-ID: <ZFz9I5bhRh2wH14i@osiris>
References: <20230504144021.808932-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504144021.808932-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 87iianYofty_ICk42cQp_1CyUf26Ah3t
X-Proofpoint-ORIG-GUID: 87iianYofty_ICk42cQp_1CyUf26Ah3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=510 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305110125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:40:19PM +0200, Ilya Leoshkevich wrote:
> This series fixes copying of uninitialized memory to userspace by
> do_statfs_native() and do_statfs64() on s390.
> 
> Patch 1 fixes the problem by making the code similar to
> put_compat_statfs() and put_compat_statfs64().
> 
> Patch 2 gets rid of the padding which caused the issue; even though it
> may be considered redundant, it documents that s390 de-facto has an
> extra f_spare array element.
> 
> Ilya Leoshkevich (2):
>   statfs: Enforce statfs[64] structure intialization
>   s390/uapi: Cover statfs padding by growing f_spare
> 
>  arch/s390/include/asm/compat.h      | 2 +-
>  arch/s390/include/uapi/asm/statfs.h | 4 ++--
>  fs/statfs.c                         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)

Al, Andrew, should this go via the s390 tree?
