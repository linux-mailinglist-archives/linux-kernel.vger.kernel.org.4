Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979B679677
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjAXLTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXLTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:19:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC63A94;
        Tue, 24 Jan 2023 03:19:42 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OA2tQo006352;
        Tue, 24 Jan 2023 11:19:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8Ll9shPCzbAV7uqNWiIZwnqBMi5NAj5aLjDWPEt4hRs=;
 b=jqZm0S5Coj347wHXVzOE5ARgBrvEqgJUravw1/SFq97G83cIyhpb5Fw+hwUViOcfpxOZ
 QPHp1YuI2kUNGOPWo4gCS9mGRYY+7sIc/iOVJ/uDqF9Htt/RPCdEO8dCS3ui1uKYSpKc
 nYDIuHCSwqFza1s/GNclBRYF/owhThkLJqCVgGKWYCWVEPd+Dt6YAkxAa1RaCnSxVT8F
 R+AXDYvRGKxKRLSRw+RJQ0vB52mY5LH2gCSp/BhGF5gxmc1QsIM6FT/Jcg7cCa8DFzwi
 BJyLXDWizF3U7u2TmiK0CJkSWbXRtHbToS7p0cvbRCo3Rp946P0gTKaUNNlXEWgxBZPK gg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3naaknnev3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 11:19:29 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NKRjOD031150;
        Tue, 24 Jan 2023 11:19:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6anf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 11:19:27 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OBJOvG21561980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 11:19:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59C9A20043;
        Tue, 24 Jan 2023 11:19:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7954220040;
        Tue, 24 Jan 2023 11:19:23 +0000 (GMT)
Received: from [9.171.71.154] (unknown [9.171.71.154])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 11:19:23 +0000 (GMT)
Message-ID: <0fae8ad5-8dcd-3864-a532-4760f3f2a95c@linux.ibm.com>
Date:   Tue, 24 Jan 2023 12:19:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the kvms390 tree with the s390 tree
Content-Language: en-US
To:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123121245.526d262b@canb.auug.org.au>
 <c988b032-d076-bda6-ee38-3c83e9cad711@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <c988b032-d076-bda6-ee38-3c83e9cad711@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UKjX9A6s3yqam4giVaJKmsE8VOcNPU_6
X-Proofpoint-GUID: UKjX9A6s3yqam4giVaJKmsE8VOcNPU_6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240101
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hAm 23.01.23 um 20:02 schrieb Anthony Krowiak:
> 
> On 1/22/23 8:12 PM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the kvms390 tree got a conflict in:
>>
>>    drivers/s390/crypto/vfio_ap_ops.c
>>
>> between commit:
>>
>>    0daf9878a799 ("s390/vfio_ap: check TAPQ response code when waiting for queue reset")
>>
>> from the s390 tree and commit:
>>
>>    bedac519eefa ("s390/vfio-ap: check TAPQ response code when waiting for queue reset")
>>
>> from the kvms390 tree.
>>
>> They seem to do the same thing, so I used the version of this file from
>> the s390 tree as it's commit is much newer and has other changes to this
>> file i.e. I effectively dropped the kvms390 tree commit.
> 
> 
> That's odd, the patch series posted to the kernel mailing lists did not have both of those patches. I think the problem may have occurred because there was an earlier version of the patch in question that was used to debug a problem in our CI. That patch should have been reverted prior to installing the latest version.


Yes, that patch was part of the kvms390 tree and it was old. I removed it. Sorry for the left-over
The one in the s390 tree is the correct one:

https://lore.kernel.org/all/20230118203111.529766-3-akrowiak@linux.ibm.com/
is now
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-next&id=0daf9878a7990058e74025493820bce0f67654c4

this should be ok now?

Christian
