Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10942677563
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjAWHH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjAWHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:07:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831D15556;
        Sun, 22 Jan 2023 23:07:25 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N707RS001458;
        Mon, 23 Jan 2023 07:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TF/9E0z71Qex2UM7PPJli6O3piPLAXrpyLrlQWRRp7Y=;
 b=JGWrGkz3F7ExvRMMFPx6pk9aiidMDs+Y7RP9MaWIxQWtBx7ZsIo1lpXmRYx41YnxMtdD
 SJa4XRWV+7MHDXO9q/exWOBv7KPA8cYQHF10lYGr7PslPWrgSp4FTEy320MdZRah0cJU
 gwQ8E3B4FVuHlDHQAlj0lk4iK3wUsLUouAmMBSqjElhDjL74cti2aIXWLgPYAovAx9pa
 r7gdoo7Q/2J5I/9D+EqWIF6GGwfjBRdgL9la0/xoLfAbE4IsVdNU6GJUIMEHe4xXIf3o
 1uQ75sLIQ2TvG0oZUvYD2qsYPA8XYiRvQbrHWgGrhaM0gtxR6anBef8ojRco8jSToH1N 9g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n8sw5yprm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 07:07:11 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30MDflLs013701;
        Mon, 23 Jan 2023 07:07:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n87p69e86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 07:07:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30N775e244106082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 07:07:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0D4C20043;
        Mon, 23 Jan 2023 07:07:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69FB120040;
        Mon, 23 Jan 2023 07:07:05 +0000 (GMT)
Received: from [9.171.73.96] (unknown [9.171.73.96])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 07:07:05 +0000 (GMT)
Message-ID: <e6768d2d-d27a-09bd-8219-8af62e6fa3d6@de.ibm.com>
Date:   Mon, 23 Jan 2023 08:07:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the kvms390 tree with the s390 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>
References: <20230123121245.526d262b@canb.auug.org.au>
Content-Language: en-US
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20230123121245.526d262b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hBrT62jmwYIJo_j2p7R_EgSdFVB9I1q1
X-Proofpoint-ORIG-GUID: hBrT62jmwYIJo_j2p7R_EgSdFVB9I1q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_04,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230067
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.01.23 um 02:12 schrieb Stephen Rothwell:
> Hi all,
> 
> Today's linux-next merge of the kvms390 tree got a conflict in:
> 
>    drivers/s390/crypto/vfio_ap_ops.c
> 
> between commit:
> 
>    0daf9878a799 ("s390/vfio_ap: check TAPQ response code when waiting for queue reset")
> 
> from the s390 tree and commit:
> 
>    bedac519eefa ("s390/vfio-ap: check TAPQ response code when waiting for queue reset")
> 
> from the kvms390 tree.
> 
> They seem to do the same thing, so I used the version of this file from
> the s390 tree as it's commit is much newer and has other changes to this
> file i.e. I effectively dropped the kvms390 tree commit.
> 
> I fixed it up (see above) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Yes thanks, will drop from the kvms390 tree.
