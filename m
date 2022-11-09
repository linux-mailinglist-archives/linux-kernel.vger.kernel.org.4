Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E100622AD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKILoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiKILoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:44:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B222C13F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:43:49 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9Ahotp002726;
        Wed, 9 Nov 2022 11:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EofnKzaLM2ZriJlFgyL0U8/ws46EtCdD61zWpQvHXmw=;
 b=TOFQgKFS46OyHpV3GHPffIxYz53/WVEzbXS5SEjgJUTFWybdupZYswZdLZV/uLC8DRY0
 rRkgTVnvUqgQoxyRPi262ZDfpYr5yUpb+8/To40Mp8DiKeaARentrY/3pwUVr2eXZwex
 A4M6URP9XS1FU1XlPCbHON1iOYyeFx4eHOrUekYw9vBpGQhWzUXC6aOHI7VP/FoWZbNW
 hWz5lVAQS0hZhNqkOUD1Gv5VA2BtkmGZx/k58VjsiI0F6OdxoGEl+gEBeLvfs7XQYZkJ
 DiTiEPYyy9Txk5J0g4auxexmWAX/OHcz+/8bvSW65sAfEegNq6geJi5T60WxGK3BUf67 nA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr8wxme82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 11:42:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9BZm2F006904;
        Wed, 9 Nov 2022 11:42:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3kngq8m390-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 11:42:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9BafjH29229496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 11:36:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37BFB42045;
        Wed,  9 Nov 2022 11:42:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6FB342042;
        Wed,  9 Nov 2022 11:42:25 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.181.142])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Nov 2022 11:42:25 +0000 (GMT)
Date:   Wed, 9 Nov 2022 13:42:23 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     Sachin Sant <sachinp@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
Message-ID: <Y2uSH8jm1MzY9Rgf@linux.ibm.com>
References: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
 <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
 <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
 <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
 <6e32f14ae25909138e40b2cfd7448ed8@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e32f14ae25909138e40b2cfd7448ed8@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3p5HC0UcvjN0F4uHDdeyqnRh_gzSfBe2
X-Proofpoint-GUID: 3p5HC0UcvjN0F4uHDdeyqnRh_gzSfBe2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_05,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=840
 lowpriorityscore=0 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yajun,

On Wed, Nov 09, 2022 at 11:32:27AM +0000, Yajun Deng wrote:
> November 9, 2022 6:55 PM, "Sachin Sant" <sachinp@linux.ibm.com> wrote:
> 
> >> On 09-Nov-2022, at 3:55 PM, Yajun Deng <yajun.deng@linux.dev> wrote:
> >> 
> >> November 9, 2022 6:03 PM, "Yajun Deng" <yajun.deng@linux.dev> wrote:
> >> 
> >>> Hey Mike,
> >> 
> >> Sorry, this email should be sent to Sachin but not Mike.
> >> Please forgive my confusion. So:
> >> 
> >> Hey Sachin,
> >> Can you help me test the attached file?
> >> Please use this new patch instead of the one in memblock tree.
> > 
> > Thanks for the fix. With the updated patch kernel boots correctly.
> > 
> 
> Thanks for your test results.
> 
> Hi Mike,
> Do you have any other suggestions for this patch? If not, I'll send a v3 patch.

Unfortunately I don't think the new version has much value as it does not
really eliminate the second loop in case memory allocation is required.
I'd say the improvement is not worth the churn.
 
> > Tested-by: Sachin Sant <sachinp@linux.ibm.com <sachinp@linux.ibm.com>>
> > 
> > - Sachin

-- 
Sincerely yours,
Mike.
