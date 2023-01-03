Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2196965BD7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbjACJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjACJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:51:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C6B97;
        Tue,  3 Jan 2023 01:51:30 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3039OnTW036938;
        Tue, 3 Jan 2023 09:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fU0JTaoEiTdRNaQ8jExGYxgB+u4m51BPumjrmZSQbqk=;
 b=Acot2lL/LUf3DzhSE3SByX+zHcDBHVfTyNIkpeDH2WWIrOqLnGGykySey71ukpXGIY0J
 1J16aRuefPk+DHzyHlKO3DNGm6/9/XWoiI9Os01lNKepZldWo8+rbdbYBe9UIqgoE4cM
 BLz6+j04aO2Fo7Z6gXbsxtISknsAWQLQWyDBlAzc9CAxRubh82Z77AjJ+iPJumPwFwqI
 VkNyhmUH38oiLi2AmHsujoHLInn8mopvpOlu6NlNopCVdPSSG78FRhG/KDt9JnSUPFyb
 gEqPo1XVb9OacyjWcOrnlDyXRmWnGFzGrYLkMONI2bH2BzIqsDZubhFCuQKU4Awpzbm/ dg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvhq7re24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:51:30 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 302CWnbY017629;
        Tue, 3 Jan 2023 09:51:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3mtcq6tmgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 09:51:27 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3039pN7j41746734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 09:51:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6BE920049;
        Tue,  3 Jan 2023 09:51:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B3CC20043;
        Tue,  3 Jan 2023 09:51:23 +0000 (GMT)
Received: from osiris (unknown [9.171.83.23])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 09:51:23 +0000 (GMT)
Date:   Tue, 3 Jan 2023 10:51:21 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     yang.yang29@zte.com.cn
Cc:     freude@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next v2] s390/zcrypt: use strscpy() to instead of
 strncpy()
Message-ID: <Y7P6mSuYkmP8g8Ot@osiris>
References: <202301031002076571212@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301031002076571212@zte.com.cn>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TBjzQJ2K8tWlgHPY3A-0D4QlzogQqM3w
X-Proofpoint-GUID: TBjzQJ2K8tWlgHPY3A-0D4QlzogQqM3w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2023-01-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=271 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:02:07AM +0800, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL-terminated strings.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---
> chang for v2
>  - match the FROM with the Email

You sent this from yang.yang29@zte.com.cn, but the sign-off is without the
".cn" suffix. Can you please make sure that your sign-off chain actually
follows the rules as outlined in Documentation/process/submitting-patches.rst?

If you read that then the sign-off line from Xu Panda shouldn't be there,
since the patch was not authored or routed via Xu Panda.
