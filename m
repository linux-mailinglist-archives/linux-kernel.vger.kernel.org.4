Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB215F07CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbiI3Jla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiI3JlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:41:22 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F20EDE8C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:41:21 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28U9eROW003704;
        Fri, 30 Sep 2022 09:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=c+rxLl79olbMnk9FiSEwd3pXvFcUqtfxTaBr1RL/CDc=;
 b=P154u7hq20mp/Hve3QxBH4GiBzrnV8fTDLfDfX91+5boSa75t3dqng0WS5S0Xa1SJHLh
 CRFEVb+TXrQMUhWamoFF+oXVx23NrhBwy4POIVE4OdGYWfYQdRBiFNq5FakhFnlFfbjE
 XfMY7jwl02nvYU6IKdY/KMybh4dztT0TRUXpUWFRZvw8sqFZ4DlHWTBviOdwQkHkWKft
 3L14ILzQb/otHKzhmkcHI62Zi0N8CCYght+Fl3FhByT7SbXL7jfmSUJD2xvFicYSy7i/
 avbZ3Ak1iTtokeX07AANVqDU1OCCL7oNxLF1Hw9t6jpYS1DRcw1l8ZKcjxM8rz5ejrun bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwwn2gj5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:41:19 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28U9fIBP006097;
        Fri, 30 Sep 2022 09:41:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jwwn2gj4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:41:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28U9ZqD8030335;
        Fri, 30 Sep 2022 09:41:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapunj9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 09:41:16 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28U9fEIq1835636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 09:41:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E9054C044;
        Fri, 30 Sep 2022 09:41:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59CFF4C040;
        Fri, 30 Sep 2022 09:41:14 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 09:41:14 +0000 (GMT)
Date:   Fri, 30 Sep 2022 11:41:12 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     david@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu.xin16@zte.com.cn
Subject: Re: Reply:[PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220930114112.4d212bfe@p-imbrenda>
In-Reply-To: <20220930020032.286941-1-xu.xin16@zte.com.cn>
References: <20220929135100.5efe6229@p-imbrenda>
        <20220930020032.286941-1-xu.xin16@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FjnHmKm1op7LxIeT82-60QYR8VYH52YJ
X-Proofpoint-ORIG-GUID: _vhx5UHejbyYD4VdZ9k-Ib2f5o7LWWed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=756 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 02:00:32 +0000
xu xin <xu.xin.sc@gmail.com> wrote:

> >> On 29.09.22 12:42, Claudio Imbrenda wrote:  
> >> > On Thu, 29 Sep 2022 02:52:06 +0000
> >> > xu.xin.sc@gmail.com wrote:
> >> >     
> >> >> From: xu xin <xu.xin16@zte.com.cn>
> >> >>
> >> >> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> >> >> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> >> >> after enabling use_zero_pages, all empty pages that are merged with
> >> >> kernel zero page are not counted in pages_sharing or pages_shared.    
> >> > 
> >> > that's because those pages are not shared between different processes.    
> >> 
> >> They are probably the most shared pages between processes in the kernel.   
> >
> >shared from the kernel, though, not from other processes (that's what I
> >meant)
> >  
> >> They are simply not KSM pages, that's what makes accounting tricky here.  
> >
> >exactly. and those pages get shared all the time even without KSM, so
> >why care about those now?
> >
> >does it make a difference why a page is a zero page?  
> 
> WI's necessary to show these sharing zeros pages. Because:
> 
> 1) Turning on/off use_zero_pages shouldn't make it so not transparent with the
>    sharing zero pages. When administrators enable KSM and turn on use_zero_pages,
>    if much memory increases due to zero pages sharing but they don't know the
>    reasons compared to turning off use_zero_pages, isn't it confusing?

I'm not sure I understand what you mean here

> 
> 2) If no need to let users know how many full-zero-filled pages are merged by KSM
>    due to use_zero_pages, then also no need to show pages_sharing and pages_shared

that's not true.

showing pages_sharing and pages_shared helps understand how much memory
would be needed for unsharing everything.

when pages filled with zeroes are replaced with zero-pages, those will
not get unshared. there is no way to know if those were actual
zero-pages from the beginning, or if they were pages full of zeroes
that have been replaced by KSM.

>    to users. Besides, the description of pages_sharing in Documentation is wrong and
>    MISLEADING when enabling use_zero_pages.

I guess I can fix the documentation

> 
> 3) As David supposes, it also help for estimating memory demands when each and every
>    shared page could get unshared.

the current statistics show exactly how much memory would be needed
if everything would get unshared. zero-pages would not get unshared.

> >  
> >>   
> >> >     
> >> >> That is because the rmap_items of these ksm zero pages are not
> >> >> appended to The Stable Tree of KSM.
> >> >>
> >> >> We need to add the count of empty pages to let users know how many empty
> >> >> pages are merged with kernel zero page(s).    
> >> > 
> >> > why?
> >> > 
> >> > do you need to know how many untouched zero pages a process has?
> >> > 
> >> > does it make a difference if the zero page is really untouched or if it
> >> > was touched in the past but it is now zero?    
> >> 
> >> I'd also like to understand the rationale. Is it about estimating memory 
> >> demands when each and every shared page could get unshared?
> >>   
> >  

