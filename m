Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6AF6B7A00
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjCMOLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjCMOLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:11:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893876C88A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 07:10:30 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DDfRtM003549;
        Mon, 13 Mar 2023 14:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jV6w5o+g9Zg6pNY2GerBin6AWWVs5FUi64qFIY/KAYM=;
 b=dmbg7YzsMXn/1MsgVDEQGxJzdPxyeF0p7ycC828pWiJVuLQVHgFbmhubx/fQ/Az5ui1I
 dsWtysLvp1qILwC5flB9jTNjSS1Fj+7zV7KZ0EYjHA6Cyn5OEP1YvMh0ri9tERdf/DSb
 4voWnIGwbZ7UXhiVnt9j6hViVnrsitrfk2Py1n4yZek3duTpn0z2n7ReDhPxhwY6r701
 rNIiVipCUBNKC8TI8MXqcojGtbkG2WrtcaRlLdryA13L8nFVMPCvwJiNxUTgWDHnA/eU
 WzNrQu0VbzSLTG4juwsv8oGG+Q8gm1p0FU1CaVNE3JKDvca1EY6EwNLwEGtHFiX8bHVB DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3dkv0u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:10:22 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32DCQt0m026782;
        Mon, 13 Mar 2023 14:10:22 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3dkv0t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:10:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32D23MwT028663;
        Mon, 13 Mar 2023 14:10:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p8h96kfdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 14:10:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DEAGWL35127802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 14:10:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E402120043;
        Mon, 13 Mar 2023 14:10:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6EF020040;
        Mon, 13 Mar 2023 14:10:16 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.56])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 14:10:16 +0000 (GMT)
Date:   Mon, 13 Mar 2023 15:10:14 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     yang.yang29@zte.com.cn, akpm@linux-foundation.org,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v6 0/6] ksm: support tracking KSM-placed zero-pages
Message-ID: <20230313151014.5e17fc19@p-imbrenda>
In-Reply-To: <9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com>
References: <202302100915227721315@zte.com.cn>
        <9d7a8be3-ee9e-3492-841b-a0af9952ef36@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3M3Wmu_ynbX26bS7ncbujnl5i23aFBXh
X-Proofpoint-GUID: rttlbGPjc26P2nkCxkdZdc1Tl124ODlP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_07,2023-03-13_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=401 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 14:03:33 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 10.02.23 02:15, yang.yang29@zte.com.cn wrote:
> > From: xu xin <xu.xin16@zte.com.cn>
> >   
> 
> Hi,
> 
> sorry for the late follow-up. Still wrapping my head around this and 
> possible alternatives. I hope we'll get some comments from others as 
> well about the basic approach.
> 
> > The core idea of this patch set is to enable users to perceive the number of any
> > pages merged by KSM, regardless of whether use_zero_page switch has been turned
> > on, so that users can know how much free memory increase is really due to their
> > madvise(MERGEABLE) actions. But the problem is, when enabling use_zero_pages,
> > all empty pages will be merged with kernel zero pages instead of with each
> > other as use_zero_pages is disabled, and then these zero-pages are no longer
> > monitored by KSM.
> > 
> > The motivations for me to do this contains three points:
> > 
> > 1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
> >     unshare the shared zeropage as placed by KSM (which is against the
> >     MADV_UNMERGEABLE documentation at least); see the link:
> >     https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/
> > 
> > 2) We cannot know how many pages are zero pages placed by KSM when
> >     enabling use_zero_pages, which hides the critical information about
> >     how much actual memory are really saved by KSM. Knowing how many
> >     ksm-placed zero pages are helpful for user to use the policy of madvise
> >     (MERGEABLE) better because they can see the actual profit brought by KSM.
> > 
> > 3) The zero pages placed-by KSM are different from those initial empty page
> >     (filled with zeros) which are never touched by applications. The former
> >     is active-merged by KSM while the later have never consume actual memory.
> >   
> 
> I agree with all of the above, but it's still unclear to me if there is 
> a real downside to a simpler approach:
> 
> (1) Tracking the shared zeropages. That would be fairly easy: whenever
>      we map/unmap a shared zeropage, we simply update the counter.
> 
> (2) Unmerging all shared zeropages inside the VMAs during
>      MADV_UNMERGEABLE.
> 
> (3) Documenting that MADV_UNMERGEABLE will also unmerge the shared
>      zeropage when toggle xy is flipped.
> 
> It's certainly simpler and doesn't rely on the rmap item. See below.

I would surely prefer a simpler approach

> 
> > use_zero_pages is useful, not only because of cache colouring as described
> > in doc, but also because use_zero_pages can accelerate merging empty pages
> > when there are plenty of empty pages (full of zeros) as the time of
> > page-by-page comparisons (unstable_tree_search_insert) is saved. So we hope to
> > implement the support for ksm zero page tracking without affecting the feature
> > of use_zero_pages.
> > 
> > Zero pages may be the most common merged pages in actual environment(not only VM but
> > also including other application like containers). Enabling use_zero_pages in the
> > environment with plenty of empty pages(full of zeros) will be very useful. Users and
> > app developer can also benefit from knowing the proportion of zero pages in all
> > merged pages to optimize applications.
> >   
> 
> I agree with that point, especially after I read in a paper that KSM 
> applied to some applications mainly deduplicates pages filled with 0s. 
> So it seems like a reasonable thing to optimize for.
> 
> > With the patch series, we can both unshare zero-pages(KSM-placed) accurately
> > and count ksm zero pages with enabling use_zero_pages.  
> 
> The problem with this approach I see is that it fundamentally relies on 
> the rmap/stable-tree to detect whether a zeropage was placed or not.
> 
> I was wondering, why we even need an rmap item *at all* anymore. Why 
> can't we place the shared zeropage an call it a day (remove the rmap 
> item)? Once we placed a shared zeropage, the next KSM scan should better 
> just ignore it, it's already deduplicated.
> 
> So if most pages we deduplicate are shared zeropages, it would be quite 
> interesting to reduce the memory overhead and avoid rmap items, instead 
> of building new functionality on top of it?
> 
> 
> 
> If we'd really want to identify whether a zeropage was deduplciated by 
> KSM, we could try storing that information inside the PTE instead of 

this is interesting, but needs caution, for the reason you mention below

> inside the RMAP. Then, we could directly adjust the counter when zapping 
> the shared zeropage or during MADV_DONTNEED/when unmerging.
> 
> Eventually, we could simply say that
> * !pte_dirty(): zeropage placed during fault
> * pte_dirty(): zeropage placed by KSM
> 
> Then it would also be easy to adjust counters and unmerge. We'd limit 
> this handling to known-working architectures initially (spec64 still has 
> the issue that pte_mkdirty() will set a pte writable ... and my patch to 
> fix that was not merged yet). We'd have to double-check all 
> pte_mkdirty/pte_mkclean() callsites.

this will be... interesting

> 

