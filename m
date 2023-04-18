Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B342A6E6AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjDRRVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjDRRVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:21:49 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32492A5D3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 10:21:48 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33IGCkUM030572;
        Tue, 18 Apr 2023 17:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=P5eJGXNDSSW1CqQQMCT1w1ImPW6GH3tJawnmTIHG5AE=;
 b=bdE20NmK9dYFLxwWGndBL0NNgA40t9LlbjTGpPK/p/d3E7lFtDz9lCQjbByXpc4zbv6v
 xGdKosNn8uktSbcXwWswPM14zVYfRHTh6g0rcZkaN2VLFYlCxZfERBZRcslUZ147QRRA
 eorNaMyVbQr+244hN62YwixgeY0+chwvG54HvSTijNJJMPmDoaZFOqRv18H5n6s49mr+
 JkM5W/ze4iRbdUdfHdctgKHe71Rv35k8D+3jj1ttTcg84Rl8Q5ZNgunjFbZcGRPWpSOA
 aXMGQ656C8G5dXyZCl91nCqSegPHEgl4W3NgGaOZzYBknyRwx+//7mt3onCabyqBc0qi Ew== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q1q52ggmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:21:44 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33IEswAk015398;
        Tue, 18 Apr 2023 17:21:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pykj69tpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 17:21:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33IHLc2s12714716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Apr 2023 17:21:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1AE520043;
        Tue, 18 Apr 2023 17:21:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377AC20040;
        Tue, 18 Apr 2023 17:21:38 +0000 (GMT)
Received: from osiris (unknown [9.171.81.45])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Apr 2023 17:21:38 +0000 (GMT)
Date:   Tue, 18 Apr 2023 19:21:36 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Popov <alex.popov@linux.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] stackleak: allow to specify arch specific stackleak
 poison function
Message-ID: <ZD7RoD+l9mxqn4kK@osiris>
References: <20230405130841.1350565-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405130841.1350565-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rVBy6TR452womV1b3IJ2Bcd4hNyfTKO7
X-Proofpoint-ORIG-GUID: rVBy6TR452womV1b3IJ2Bcd4hNyfTKO7
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_12,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=555 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:08:39PM +0200, Heiko Carstens wrote:
> Factor out the code that fills the stack with the stackleak poison value in
> order to allow architectures to provide a faster implementation.
> 
> Use this to provide an s390 specific implementation which can fill the
> stack with the poison value much faster (factor of ~10 compared to the
> current version).
> 
> Note that the s390 stackleak support is currently only available via
> linux-next (as of today), and the s390 kernel tree at kernel.org[1].
> Therefore, if there are no objections, I'd like to add these two patches to
> the s390 tree, so they can go upstream via the next merge window together
> with the s390 support.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features&id=b94c0ebb1ec752016a3e41bfb66bb51ea905e533
> 
> Thanks,
> Heiko
> 
> Heiko Carstens (2):
>   stackleak: allow to specify arch specific stackleak poison function
>   s390/stackleak: provide fast __stackleak_poison() implementation
> 
>  arch/s390/include/asm/processor.h | 35 +++++++++++++++++++++++++++++++
>  kernel/stackleak.c                | 17 +++++++++++----
>  2 files changed, 48 insertions(+), 4 deletions(-)

Given that this series seems to be straight forward, and Mark already gave
his Ack we're going to put these two patches on the s390 git tree, even
though there was no response from Kees yet.

If there will be any complaints I'm sure we can easily solve that.
