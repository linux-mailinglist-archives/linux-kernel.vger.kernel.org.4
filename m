Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAADB622959
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKIK55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiKIK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:57:40 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6113AD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:57:14 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A99MKB5002368;
        Wed, 9 Nov 2022 10:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type : subject :
 from : in-reply-to : date : cc : message-id : references : to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z7Wf8ct09eK4ViEpf0UW9mV2GGqYyKN0h7Q7fnU9dGE=;
 b=gMDBSra28bcQSjhQQDXY1vmIIUhCka/8xHoepmERMd5eZmus44RRWtsO4AbELOpJQIZ+
 T3m4gg/oQyoa/v320Noutcs3jfEFBuMEToHoxiqiO3Y9JIAW3eL5Faskl8qkyZjbjmUa
 DfSP1YOMG7w1UsYZFNJwT7rQlKooQtAXC/pNaboVYU7cHtolv02DtKrEb/96xN+iRdpy
 K3Iy9MHGFBnU0Sp+3LHjhpctuOb6yE6n2l8WSRQGeeznPu0EsyYQnLxU5GWVlghzVtYO
 ctzmhvjDuknvC2QZqZxH1u5kIjnCZ86dADUNb8+EOGSXBHp+foqkebnYg+qrkGVTbGLN YA== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kr7ns5my7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:55:55 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A9ApkVG001934;
        Wed, 9 Nov 2022 10:55:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kngpgm1gr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 10:55:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A9AuTrB43057444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Nov 2022 10:56:29 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4943E11C04C;
        Wed,  9 Nov 2022 10:55:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2620411C04A;
        Wed,  9 Nov 2022 10:55:50 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.28.188])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Nov 2022 10:55:49 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Subject: Re: [6.1.0-rc3-next-20221104] Boot failure - kernel BUG at
 mm/memblock.c:519
From:   Sachin Sant <sachinp@linux.ibm.com>
In-Reply-To: <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
Date:   Wed, 9 Nov 2022 16:25:39 +0530
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.ibm.com>
Message-Id: <74979021-D386-4402-BD70-167531C7405B@linux.ibm.com>
References: <e00989c4a69943cb4f60fc7ffaa06f8c@linux.dev>
 <Y2oLYB7Tu7J91tVm@linux.ibm.com>
 <E2499567-0D0F-44DA-AC68-1E279009A6DE@linux.ibm.com>
 <58779468e28e026a1aa30a42ca7e8aec@linux.dev>
 <4fee7f2b0e99e256465ef6e7656c6349@linux.dev>
To:     Yajun Deng <yajun.deng@linux.dev>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UP7PTNYWFa0FnyjErRmc0w-n1JP_k0J8
X-Proofpoint-GUID: UP7PTNYWFa0FnyjErRmc0w-n1JP_k0J8
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_04,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=979 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 09-Nov-2022, at 3:55 PM, Yajun Deng <yajun.deng@linux.dev> wrote:
> 
> November 9, 2022 6:03 PM, "Yajun Deng" <yajun.deng@linux.dev> wrote:
> 
>> Hey Mike,
>> 
> Sorry, this email should be sent to Sachin but not Mike. 
> Please forgive my confusion. So:
> 
> Hey Sachin,
> Can you help me test the attached file? 
> Please use this new patch instead of the one in memblock tree.

Thanks for the fix. With the updated patch kernel boots correctly.

Tested-by: Sachin Sant <sachinp@linux.ibm.com <mailto:sachinp@linux.ibm.com>>

- Sachin

