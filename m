Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3115EF4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 14:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbiI2MGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 08:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiI2MF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 08:05:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDAEA74FD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 05:05:58 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TAHBlc010810;
        Thu, 29 Sep 2022 12:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=r/Ro9ce8vIg+npsX53hgzXtKESd0t1TG0Nb9p3RADdo=;
 b=rVCzHUtvgAyfwuOtupIQbjJvhDzvRzSpcwCteq2KqmPp9IybPWbT/WD6ePjVlbnkdt/W
 vPzbAsCt4DR2rFrcGf4czLn/cePqtf/ZRBjUWmKYRVq+ahEznSyTKS68SBYKto9wJTVx
 8pWr7oD0aaAd4flIFhOMnlscJ26fU+w8b8zp0EXd1zFrprxKXZ+36MBQwMEHbk8vsIDb
 jrmmST6TK2z45nFRWN7apnMHxZmydlvcr7xA/6VUkaKGugxKxBW8OPo6lPdJQYAO1jqT
 VGk9aI6wV3ye2A5LYyGKOhyQaM5op2YajSs53Sq67rfv9J7bH9cpH12Q9/gaxQSC4OEl bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9fs2ux1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 12:05:55 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TALpOT028257;
        Thu, 29 Sep 2022 12:05:55 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9fs2uvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 12:05:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TC5aFf009529;
        Thu, 29 Sep 2022 12:05:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j6nec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 12:05:52 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TC1X3k28115206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 12:01:33 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE085A405B;
        Thu, 29 Sep 2022 12:05:50 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70E8CA4054;
        Thu, 29 Sep 2022 12:05:50 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 12:05:50 +0000 (GMT)
Date:   Thu, 29 Sep 2022 14:05:48 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220929140548.1945dccf@p-imbrenda>
In-Reply-To: <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
        <4a3daba6-18f9-d252-697c-197f65578c44@redhat.com>
        <20220929123630.0951b199@p-imbrenda>
        <745f75a4-6a2a-630f-8228-0c5e081588e7@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NgOM233dIPbOfm_3ezskwJ5yKpCRk6It
X-Proofpoint-ORIG-GUID: UaFqKHZy8eJzcKFkOuRyF5jQ45OWd6rE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=959 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209290074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 13:12:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.09.22 12:36, Claudio Imbrenda wrote:
> > On Thu, 29 Sep 2022 11:21:44 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 29.09.22 04:52, xu.xin.sc@gmail.com wrote:  
> >>> From: xu xin <xu.xin16@zte.com.cn>
> >>>
> >>> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> >>> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> >>> after enabling use_zero_pages, all empty pages that are merged with
> >>> kernel zero page are not counted in pages_sharing or pages_shared.
> >>> That is because the rmap_items of these ksm zero pages are not
> >>> appended to The Stable Tree of KSM.
> >>>
> >>> We need to add the count of empty pages to let users know how many empty
> >>> pages are merged with kernel zero page(s).
> >>>
> >>> Please see the subsequent patches for details.  
> >>
> >> Just raising the topic here because it's related to the KSM usage of the
> >> shared zero-page:
> >>
> >> MADV_UNMERGEABLE and other ways to trigger unsharing will *not* unshare
> >> the shared zeropage as placed by KSM (which is against the
> >> MADV_UNMERGEABLE documentation at least). It will only unshare actual
> >> KSM pages. We might not want want to blindly unshare all shared
> >> zeropages in applicable VMAs ... using a dedicated shared zero (KSM)
> >> page -- instead of the generic zero page --  might be one way to handle
> >> this cleaner.  
> > 
> > I don't understand why do you need this.
> > 
> > first of all, one zero page would not be enough (depending on the
> > architecture, e.g. on s390x you need many). the whole point of zero
> > page merging is that one zero page is not enough.  
> 
> I don't follow. Having multiple ones is a pure optimization on s390x (I 
> recall something about cache coloring), no? So why should we blindly 
> care in the special KSM use case here?

because merging pages full of zeroes with only one page will have
negative performance on those architectures that need cache colouring
(and s390 is not even the only architecture that needs it)

the whole point of merging pages full of zeroes with zero pages is to
not lose the cache colouring.

otherwise you could just let KSM merge all pages full of zeroes with
one page (which is what happens without use_zero_pages), and all the
numbers are correct.

if you are not on s390 or MIPS, you have no use for use_zero_pages

> 
> > 
> > second, once a page is merged with a zero page, it's not really handled
> > by KSM anymore. if you have a big allocation, of which you only touch a
> > few pages, would the rest be considered "merged"? no, it's just zero
> > pages, right?  
> 
> If you haven't touched memory, there is nothing populated -- no shared 
> zeropage.
> 
> We only populate shared zeropages in private anonymous mappings on read 
> access without prior write.

that's what I meant. if you read without writing, you get zero pages.
you don't consider those to be "shared" from a KSM point of view

does it make a difference if some pages that have been written to but
now only contain zeroes are discarded and mapped back to the zero pages?

> 
> > this is the same, except that we take present pages with zeroes in it
> > and we discard them and map them to zero pages. it's kinda like if we
> > had never touched them.  
> 
> MADV_UNMERGEABLE
> 
> "Undo  the effect of an earlier MADV_MERGEABLE operation on the 
> specified address range; KSM unmerges whatever pages it had merged in 
> the address range specified  by  addr  and length."
> 
> Now please explain to me how not undoing a zeropage merging is correct 
> according to this documentation.
> 

because once it's discarded and replaced with a zero page, the page is
not handled by KSM anymore.

I understand what you mean, that KSM did an action that now cannot be
undone, but how would you differentiate between zero pages that were
never written to and pages that had been written to and then discarded
and mapped back to a zero page because they only contained zeroes?

