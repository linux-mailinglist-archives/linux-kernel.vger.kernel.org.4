Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ECE688F38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCF7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCF7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:59:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7358A7FB;
        Thu,  2 Feb 2023 21:58:50 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3134g8FQ019429;
        Fri, 3 Feb 2023 05:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=VlUMpGWUpsArUDVsPkw8jrkXKuTWbgln56ickuMF/Ws=;
 b=YjS+zCTG2bUoUUn9u07f4yqM4nPEOPC9iIC+g5nNOz3e25I8Tjp5ezFIGh6uMKZGuWxW
 8QrStnKgdBE1igkziQ/IeuJQQrf06n6Ipdv0uwJUJtk0/LHhsOHmFRuRMREgaVScgefr
 8oPUhRnZSHH/tx2qLg+le4hkHx8H8jG9toICAUQ18GBNOx2Bmslie5dNdQmkz3TIevI/
 KxSrbTiamQA/9AJFgGKzIwelCDWtLFICI457tlWsKl/ajoq28k9wYTHaWx1/Fu1Dor4x
 X3yBmSfWbPEoSj2rTDQhXYVi8fok36fXIbvbVXBmrJlZdRn67q4Vh64d4B/zfvdCzB7Z oQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngstgjyh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 05:58:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312DlmiS026916;
        Fri, 3 Feb 2023 05:58:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7q132-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 05:58:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3135wUaf24576416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 05:58:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C43720043;
        Fri,  3 Feb 2023 05:58:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB91420040;
        Fri,  3 Feb 2023 05:58:29 +0000 (GMT)
Received: from osiris (unknown [9.179.2.68])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Feb 2023 05:58:29 +0000 (GMT)
Date:   Fri, 3 Feb 2023 06:58:28 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [GIT PULL] s390 fixes for 6.2-rc7
Message-ID: <Y9yihJvj4fAC4KoZ@osiris>
References: <Y9wYTnwXVwg/3Dv3@osiris>
 <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3u9fG-Oy_NV+w2H7pFUWmfyX5JXHGvxynxA9b1sNZGw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u9O7LUwJ1dFpAKUxmNSC4h2WyVr2AQnn
X-Proofpoint-GUID: u9O7LUwJ1dFpAKUxmNSC4h2WyVr2AQnn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 mlxlogscore=835 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302030050
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 01:01:21PM -0800, Linus Torvalds wrote:
> On Thu, Feb 2, 2023 at 12:08 PM Heiko Carstens <hca@linux.ibm.com> wrote:
> >
> > - With CONFIG_VMAP_STACK enabled it is not possible to load the s390
> >   specific diag288_wdt watchdog module. Reason is that a pointer to a
> >   string is passed to an inline assembly; this string however is located on
> >   the stack, while the instruction within the inline assembly expects a
> >   physicial address. Fix this by copying the string to a kmalloc'ed buffer.
> 
> Ugh. I have pulled this, but I think that fix is disgusting.
> 
> I think the kmalloc/kfree should have been done inside __diag288_vm()
> itself, where it actually does that whole "virt_to_phys()" too.
> 
> Now there are three callers of __diag288_vm(), and they all do that
> ugly kmalloc game with no comment about why it's needed.
> 
> If __diag288_vm() just did it itself, and had a comment right next to
> the virt_to_phys() about why, that would look a lot better, I think.
> 
> That said, I don't know the code, and maybe there was some reason to
> do it this way. As mentioned, I've pulled it, I just don't
> particularly love the patch.

I really should have mentioned that this is just the minimal fix so it can
be easily backported. We have five patches pending which will cleanup the
whole driver, and which will also address what you complain about.

Patches will be sent out later today to Wim, Guenter, and the watchdog
mailing list, since Guenter already rightfully complained that I bypassed
them.
