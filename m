Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD32618050
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKCPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKCPAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8167E5F76
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 08:00:04 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EnCEW031125;
        Thu, 3 Nov 2022 14:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xBOlVuow5ajDBMr6n7vyZ7vqz+V8N5yRxETjDklYWCw=;
 b=FrtsfWYWMA5+ckWvtWRFxEV84TGR6Nbkcv497zz4QuSVMc1W6K1Oe1tTjR2naixgA4/M
 M1CVy3f8Iz4yuDizkjnT1Kt04OI410s05jguTdXCgM7hjX9n9LSPL/uwdC5v+28EwMwT
 T9+sv4bKEjLxr3goGmIbs/1tmDmxkqCS0Pp/R8WhB2xqeqEMRIMUonHHdbCApKBZ8SF3
 36O2RrPhGojKrCakKHIrZ4bqgi0FlqGOw2sWDlLhyKXY4HSsj6KdotgD0Yb/79b9QnkX
 Y0OjkyY2upyGtbfmQcrJwdFM4Hu2NGbMYArUdyLPVY2UFuyqeYB87jtK603aRMZNAe7b sg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmdwrchv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:59:43 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3EonKB023962;
        Thu, 3 Nov 2022 14:59:42 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3kgutajba3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 14:59:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3ExfsR22545194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 14:59:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD81B58054;
        Thu,  3 Nov 2022 14:59:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A8F5804E;
        Thu,  3 Nov 2022 14:59:39 +0000 (GMT)
Received: from [9.160.58.236] (unknown [9.160.58.236])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 14:59:39 +0000 (GMT)
Message-ID: <814737a6-384b-23ec-1f5c-ddeb08f3758e@linux.ibm.com>
Date:   Thu, 3 Nov 2022 09:59:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/5] regmap: Add FSI bus support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au
References: <20221102205148.1334459-1-eajames@linux.ibm.com>
 <20221102205148.1334459-2-eajames@linux.ibm.com>
 <Y2PWNYfu9l5rRznX@sirena.org.uk>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Y2PWNYfu9l5rRznX@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aYqBjN6l4DZ8kXaDN2sUwjf5Qp0Z5t1c
X-Proofpoint-GUID: aYqBjN6l4DZ8kXaDN2sUwjf5Qp0Z5t1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 mlxlogscore=759 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211030098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/22 09:54, Mark Brown wrote:
> On Wed, Nov 02, 2022 at 03:51:44PM -0500, Eddie James wrote:
>> Add regmap support for the FSI bus.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/base/regmap/Kconfig      |   6 +-
>>   drivers/base/regmap/Makefile     |   1 +
>>   drivers/base/regmap/regmap-fsi.c | 231 +++++++++++++++++++++++++++++++
>>   include/linux/regmap.h           |  37 +++++
> I thought the plan was to put this in the MFD since that's the only
> user?


For the I2C responder regmap, yes, that's what I've done. The FSI regmap 
could be used anywhere in the future. We could switch a number of 
drivers to use the FSI regmap if desired, so I feel it's worth it to put 
it in the regmap properly.


Thanks,

Eddie


