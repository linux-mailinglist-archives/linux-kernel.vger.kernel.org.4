Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C52669EFE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBVIHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVIHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:07:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CA93668E;
        Wed, 22 Feb 2023 00:07:18 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M6nfaS020596;
        Wed, 22 Feb 2023 08:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EiKHzmG9pDf6EGIuIN6f/xMI/M9KT3Ua3MKIAQWZiKE=;
 b=SAWSGhJboWZMOttDJFBnnffOVbChyLNNTWICgf4mC1lR2nlXH5vpaI8Y+zIHg4njr9SQ
 KKGzY+p6zB8bCEczfkgimI4sUmJ0zJapwgToJY48I67BSWTpVz5jeW6wgfJ+q9JHsZqA
 gdd4FTjuL+KIqdNdjvhbiyH9KUWYBlmDY1RhV23HxSSR3PdURPmlbmOtW3mA8TURyv0/
 6zfKcirojS5pxPPKBFHDngwXp27Pbb/MiByzyRIoBThngV25bJfANOxafUbW7S/mjXju
 zxtyFaxFbkhxxSkL861MrORosyUi5BEi809YQAcdaA4upfm4bksjRZwHpoOfWCtg3S2s Cg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwe4f1naa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:07:17 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LCeHUR014629;
        Wed, 22 Feb 2023 08:07:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3ntpa63u09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:07:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M87BDN45220238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 08:07:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 436462004B;
        Wed, 22 Feb 2023 08:07:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D485120043;
        Wed, 22 Feb 2023 08:07:09 +0000 (GMT)
Received: from osiris (unknown [9.152.212.244])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Feb 2023 08:07:09 +0000 (GMT)
Date:   Wed, 22 Feb 2023 09:07:08 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.3 merge window
Message-ID: <Y/XNLAxrg9ZCxlsH@osiris>
References: <Y/NhOcWmhpYRPnK0@osiris>
 <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimQi=gL-Pd7kMd-ruwjLUCK82e3wJ7sisvT3cfHrx-JQ@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: awqQUFuuMx3IqttXTxY8tfq28Vm8EJKU
X-Proofpoint-GUID: awqQUFuuMx3IqttXTxY8tfq28Vm8EJKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=807
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 03:15:09PM -0800, Linus Torvalds wrote:
> On Mon, Feb 20, 2023 at 4:02 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > Also the shortstat when merging will look slightly different to the one
> > generated with 'git request-pull' below, since I merged our fixes branch
> > twice to avoid merge conflicts.
> 
> Please don't do that unless the merge conflicts are really nasty - and
> when you do, please *explain* it.
> 
> Looking at those two merges, I
> 
>  (a) see no sign of complex conflicts (the conflict diff is completely
> empty for both of them)
> 
>  (b) see zero explanation for why the merge exists at all
> 
> Please consider merges to be real commits (they are!) and needing all
> the same commit messages explaining them that normal commits have
> (they do!).

Ok. The fixes branch was merged since other commits which were applied
relied on commits in the fixes branch.

But as you yesterday already outlined as reply to the hardening pull
request this rather should have been a separate topic branch, which then
would also allow for a proper merge commit message.

We will do that from now on for the s390 tree.
