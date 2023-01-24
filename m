Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724AC679C43
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjAXOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjAXOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:43:47 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAF230F0;
        Tue, 24 Jan 2023 06:43:45 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ODv064000553;
        Tue, 24 Jan 2023 14:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=jvxFBVLhUdxzD0KY+/g4A7pGQ7XFNoKf6nUsW/mm17M=;
 b=bKbG2rv2OEIFoWX7D4/PPVB4OztFZ5W3ytw+cOJiDO49+2NaDJIsm/tla2YsGGTDkl2U
 MzOHfvsBM6oPJchWyNXUSRgesXvxD3QfrvpSyorUEUcT7jaBvy5dIjNlO2CKAk4Pt/gw
 V4NZHasUqwT8jxwuCQt7GEp0eKh+DtDot1shmdC0sTgNO4z/uG+ZVhNIppO6Fpju8YeC
 imYmf5DDeWKGxWQWfv0A8x+Zc0pcBG9OIiDKrpLpjKdiFQ8l17MKxh8E75tPwpRCgQeK
 DjOCpNaoQDzdCzPAIhpxNxDazSB8LcEkdm5yrI6x5+IkRnvuxdQ9PVIfbyo0a1mDFg2k Fw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nac20062g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 14:43:35 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBx114003228;
        Tue, 24 Jan 2023 14:43:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3n87p72pr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 14:43:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OEhWko32113012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 14:43:32 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E33DA58066;
        Tue, 24 Jan 2023 14:43:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53D2B5805C;
        Tue, 24 Jan 2023 14:43:31 +0000 (GMT)
Received: from [9.160.36.55] (unknown [9.160.36.55])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 14:43:31 +0000 (GMT)
Message-ID: <63cf4e55-13cd-5037-8b07-674da55e04ed@linux.ibm.com>
Date:   Tue, 24 Jan 2023 09:43:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: linux-next: manual merge of the kvms390 tree with the s390 tree
Content-Language: en-US
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Janosch Frank <frankja@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230123121245.526d262b@canb.auug.org.au>
 <c988b032-d076-bda6-ee38-3c83e9cad711@linux.ibm.com>
 <0fae8ad5-8dcd-3864-a532-4760f3f2a95c@linux.ibm.com>
From:   Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <0fae8ad5-8dcd-3864-a532-4760f3f2a95c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R6bPp8SdkUibtavxwlthRKIzivBqeYAy
X-Proofpoint-ORIG-GUID: R6bPp8SdkUibtavxwlthRKIzivBqeYAy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240132
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/23 6:19 AM, Christian Borntraeger wrote:
> hAm 23.01.23 um 20:02 schrieb Anthony Krowiak:
>>
>> On 1/22/23 8:12 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Today's linux-next merge of the kvms390 tree got a conflict in:
>>>
>>>    drivers/s390/crypto/vfio_ap_ops.c
>>>
>>> between commit:
>>>
>>>    0daf9878a799 ("s390/vfio_ap: check TAPQ response code when 
>>> waiting for queue reset")
>>>
>>> from the s390 tree and commit:
>>>
>>>    bedac519eefa ("s390/vfio-ap: check TAPQ response code when 
>>> waiting for queue reset")
>>>
>>> from the kvms390 tree.
>>>
>>> They seem to do the same thing, so I used the version of this file from
>>> the s390 tree as it's commit is much newer and has other changes to 
>>> this
>>> file i.e. I effectively dropped the kvms390 tree commit.
>>
>>
>> That's odd, the patch series posted to the kernel mailing lists did 
>> not have both of those patches. I think the problem may have occurred 
>> because there was an earlier version of the patch in question that 
>> was used to debug a problem in our CI. That patch should have been 
>> reverted prior to installing the latest version.
>
>
> Yes, that patch was part of the kvms390 tree and it was old. I removed 
> it. Sorry for the left-over
> The one in the s390 tree is the correct one:
>
> https://lore.kernel.org/all/20230118203111.529766-3-akrowiak@linux.ibm.com/ 
>
> is now
> https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=for-next&id=0daf9878a7990058e74025493820bce0f67654c4 
>
>
> this should be ok now?


Yes, that is the correct one.


>
> Christian
