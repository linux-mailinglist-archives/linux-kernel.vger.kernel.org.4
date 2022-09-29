Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7FE5EF4BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiI2LvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiI2LvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:51:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7664C115A45
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:51:10 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TAHABR010789;
        Thu, 29 Sep 2022 11:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=A4zCAojyhaX0zj1bMbcNKc6QlqyIXmr15eUuzkx5w0s=;
 b=kxZ6yFlBmtnv4l2VX5aWSJPkvB/hVcaxeIRtS0dtOrtbjMIEoAm3scJ6Q36KJO7aW0R7
 RwFzbLLqxFB6zX7vPf55Ougyuv8ZbszpPlYIWbMqBMDywFFhVwmwf6OcV9pNMnD4d4xu
 9fIqcwp+tr5CzwkZLWkdK1egl1qrE3tkXjy9UqpaLBfQZs8Elg9F743mX6UUP/jerj+i
 kmf2oViycp5A2ma8EKqrk53RB53VjPwAg5O2/PA/8O5RuLv+BhSHrJMd3Y8bnewaM3Gx
 EhvD59ZXekLpQDXfhBhwnbB1W/F1rnzjfYjr1OlM3JW0Qke7WtROpdc6XMPu/Od91Rm7 Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9fs2dmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 11:51:07 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28TBIEkT028956;
        Thu, 29 Sep 2022 11:51:07 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jw9fs2dkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 11:51:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28TBZmZd018885;
        Thu, 29 Sep 2022 11:51:05 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3jss5j6mur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 11:51:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28TBp2dY27001252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 11:51:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B16B11C058;
        Thu, 29 Sep 2022 11:51:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58ACC11C052;
        Thu, 29 Sep 2022 11:51:02 +0000 (GMT)
Received: from p-imbrenda (unknown [9.152.224.242])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Sep 2022 11:51:02 +0000 (GMT)
Date:   Thu, 29 Sep 2022 13:51:00 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     xu.xin.sc@gmail.com, akpm@linux-foundation.org,
        imbrenda@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH 0/3] ksm: fix incorrect count of merged pages when
 enabling use_zero_pages
Message-ID: <20220929135100.5efe6229@p-imbrenda>
In-Reply-To: <889909f6-f2db-f34a-0305-eb8500dd5453@redhat.com>
References: <20220929025206.280970-1-xu.xin16@zte.com.cn>
        <20220929124242.60ef57ee@p-imbrenda>
        <889909f6-f2db-f34a-0305-eb8500dd5453@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3t-joj1E5mP_f9Zr0iiO100prQXRdrQW
X-Proofpoint-ORIG-GUID: SpT5_yv5EgnrGPhGOJUdrKpT7JLPOAdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=642 spamscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2209290071
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 13:34:24 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 29.09.22 12:42, Claudio Imbrenda wrote:
> > On Thu, 29 Sep 2022 02:52:06 +0000
> > xu.xin.sc@gmail.com wrote:
> >   
> >> From: xu xin <xu.xin16@zte.com.cn>
> >>
> >> Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
> >> use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
> >> after enabling use_zero_pages, all empty pages that are merged with
> >> kernel zero page are not counted in pages_sharing or pages_shared.  
> > 
> > that's because those pages are not shared between different processes.  
> 
> They are probably the most shared pages between processes in the kernel. 

shared from the kernel, though, not from other processes (that's what I
meant)

> They are simply not KSM pages, that's what makes accounting tricky here.

exactly. and those pages get shared all the time even without KSM, so
why care about those now?

does it make a difference why a page is a zero page?

> 
> >   
> >> That is because the rmap_items of these ksm zero pages are not
> >> appended to The Stable Tree of KSM.
> >>
> >> We need to add the count of empty pages to let users know how many empty
> >> pages are merged with kernel zero page(s).  
> > 
> > why?
> > 
> > do you need to know how many untouched zero pages a process has?
> > 
> > does it make a difference if the zero page is really untouched or if it
> > was touched in the past but it is now zero?  
> 
> I'd also like to understand the rationale. Is it about estimating memory 
> demands when each and every shared page could get unshared?
> 

