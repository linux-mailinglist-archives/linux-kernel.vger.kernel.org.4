Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3864DD2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 15:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLOOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiLOOwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 09:52:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0739E2F03A;
        Thu, 15 Dec 2022 06:52:32 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEfuMo020469;
        Thu, 15 Dec 2022 14:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=r+X72MD81XNUgAPaVDg/P7jJrUiBIuV0IsuJB8WYRYs=;
 b=Oay979FmnYk1l5v2Z/P7W4jzlFYPHvb7fG7HQeucGurpbtgofPQFp/p2kT/KVheDwRgy
 C3udsnA0po8omwtkbZR7mzlwic+NEEJXE1G2CDJbhRCZvgvrV1yz5YOVD5w9PpkNcqGz
 xrk30LwZDwyxfGECpGv9dA5tjhXmt3I+Ejbx/As66soFBcjk1x4oDbMyDrSOYFZY9Shm
 EZ7+xcZbWqNHS8cFkC3SGclROZxs9HBYTWQNYNs/CzAH4o/y/jAR4lGOMKkga4E67Ljz
 v62KzVzXhP2TachkOBILacvmVuOrf7cutAGjyNeetntZjYMemRdL7TRcnwSQcWOOyWsz 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg5jr896y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 14:52:30 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BFEo6CG022151;
        Thu, 15 Dec 2022 14:52:30 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mg5jr896a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 14:52:30 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFDmBac017104;
        Thu, 15 Dec 2022 14:52:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3mf07gpdk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Dec 2022 14:52:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BFEqRCN7996126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 14:52:27 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C63745803F;
        Thu, 15 Dec 2022 14:52:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA05758056;
        Thu, 15 Dec 2022 14:52:26 +0000 (GMT)
Received: from [9.160.108.96] (unknown [9.160.108.96])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 15 Dec 2022 14:52:26 +0000 (GMT)
Message-ID: <8b86ec00-2112-0c00-993e-dad2c816833b@linux.ibm.com>
Date:   Thu, 15 Dec 2022 08:52:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Input: ibm-panel - fix typo in comment
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        =?UTF-8?B?QWxkYXMgVGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20221213194855.260-1-aldas60@gmail.com>
 <87wn6sixd0.fsf@baylibre.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <87wn6sixd0.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3R9LAlX9s6FzcI8tQutxQKq7a6QN6mRk
X-Proofpoint-ORIG-GUID: bO0dCly1KWyen7Mke5Z7wOJCRqOOoHml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_08,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/22 07:56, Mattijs Korpershoek wrote:
> On Tue, Dec 13, 2022 at 21:48, Aldas Taraškevičius <aldas60@gmail.com> wrote:
>
>> "set the index to it's largest possible value" -> "set the index to its
>> largest possible value"


Thanks!

Reviewed-by: Eddie James <eajames@linux.ibm.com>


>>
>> Signed-off-by: Aldas Taraškevičius <aldas60@gmail.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
>> ---
>>   drivers/input/misc/ibm-panel.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/misc/ibm-panel.c b/drivers/input/misc/ibm-panel.c
>> index a8fba0054..6be60bc8d 100644
>> --- a/drivers/input/misc/ibm-panel.c
>> +++ b/drivers/input/misc/ibm-panel.c
>> @@ -101,7 +101,7 @@ static int ibm_panel_i2c_slave_cb(struct i2c_client *client,
>>   		else
>>   			/*
>>   			 * The command is too long and therefore invalid, so set the index
>> -			 * to it's largest possible value. When a STOP is finally received,
>> +			 * to its largest possible value. When a STOP is finally received,
>>   			 * the command will be rejected upon processing.
>>   			 */
>>   			panel->idx = U8_MAX;
>> -- 
>> 2.37.2
