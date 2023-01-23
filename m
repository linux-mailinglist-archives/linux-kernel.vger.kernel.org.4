Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B686785B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjAWTCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjAWTCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:02:39 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3053C166F2;
        Mon, 23 Jan 2023 11:02:38 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NHSJPL007475;
        Mon, 23 Jan 2023 19:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZY0xpRJaWKFLpnnJgp+bGJO/WmfFGXwo7nAzo2SfNzE=;
 b=FFh5XNk7B8Ilse9g9ouGtdNrubjvCmCMf/XAEgSu+Cu6qwq1o7BVtCaRVwYgZMOGgx1i
 SNwZUqQq+ICd6TLjwnJ2yw0VBKGjH+sWkKeepla/e/DIEZ/DIk0JGfBUKWvmZGcxatVu
 Fx/0wY5AuJo0xwcpW2yzEzvrnNd3crGOWi5uKLy0xaFlmAJIZRBs0qbvygNEu3xNuGJB
 L6aXQPhPKxWSfoVw8o4NNvB8JXqUJNiVT/8sCJplA6KTuHBazlORsej12BwnB1LszIFu
 VMn/De6nHUT6wjl5XQcsmKClmxW5wkiLBgCFkCv3Zw4HV4d6EIkdIdOV2Zb2FTb+I85A iw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n9t3djs3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 19:02:31 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NHxPYK004808;
        Mon, 23 Jan 2023 19:02:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3n87p7sdwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 19:02:30 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30NJ2Snv7602826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 19:02:29 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBA735805A;
        Mon, 23 Jan 2023 19:02:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29FE958062;
        Mon, 23 Jan 2023 19:02:28 +0000 (GMT)
Received: from [9.160.36.55] (unknown [9.160.36.55])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 23 Jan 2023 19:02:28 +0000 (GMT)
Message-ID: <c988b032-d076-bda6-ee38-3c83e9cad711@linux.ibm.com>
Date:   Mon, 23 Jan 2023 14:02:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: linux-next: manual merge of the kvms390 tree with the s390 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123121245.526d262b@canb.auug.org.au>
From:   Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20230123121245.526d262b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 35m911hxxgigjn5pZCaXtfl3BaGm9dox
X-Proofpoint-ORIG-GUID: 35m911hxxgigjn5pZCaXtfl3BaGm9dox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230178
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/22/23 8:12 PM, Stephen Rothwell wrote:
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


That's odd, the patch series posted to the kernel mailing lists did not 
have both of those patches. I think the problem may have occurred 
because there was an earlier version of the patch in question that was 
used to debug a problem in our CI. That patch should have been reverted 
prior to installing the latest version.


>
> I fixed it up (see above) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
