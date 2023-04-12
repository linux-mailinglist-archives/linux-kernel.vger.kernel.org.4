Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB06DF9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDLPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjDLPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:24:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038D127;
        Wed, 12 Apr 2023 08:24:57 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CF8kR7031932;
        Wed, 12 Apr 2023 15:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=u/b5jkG8ErubPZ7jxSxX4nJ4W/dT3PW1Mo6wS1qer48=;
 b=rlYw2VqtZpWF99BOhZaswm4q/oO83v/AS9Q/qWefffrBD3KP2C/m78AwbYoV1gpEiAJ9
 C+DxQH7ZrhKnMJISo/5cH+4f0twfS8iSJGaStv3W33sMKsnbcq4Q/jliVho1v6ygJfON
 DcGwyW/brUEu3Q7FCJbU7OYfxikPx+f6Ihvpp6tTy+otAC0FczpgsTkJ+s9NvVr2SK0t
 yzngl5Q55eQyyKmATYl+ZPdpUMGKFI1bJaDKSHNb7ar7B06FAxLEpr+HqBFIPs776QD4
 07ZBXjARPMTNZuhxHuOF9qBDW447pmTHhKB/qxPM8EdSM+XAmH3Er22LLrETPjOd8KPj LA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pwx284bsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:24:43 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33CD55dA027912;
        Wed, 12 Apr 2023 15:24:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3pu0jjch2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 15:24:42 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33CFOfVK39453418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Apr 2023 15:24:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 450755805C;
        Wed, 12 Apr 2023 15:24:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 945B75805D;
        Wed, 12 Apr 2023 15:24:40 +0000 (GMT)
Received: from [9.160.16.129] (unknown [9.160.16.129])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 12 Apr 2023 15:24:40 +0000 (GMT)
Message-ID: <d13ba4a0-44d4-e8d3-fccd-0e44174a7359@linux.ibm.com>
Date:   Wed, 12 Apr 2023 10:24:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Use default debugfs
 attributes and lock function
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com
References: <20230405145230.68631-1-eajames@linux.ibm.com>
 <20230405145230.68631-3-eajames@linux.ibm.com>
 <9c3d277f-a23b-447f-8850-354f54deb07b@roeck-us.net>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <9c3d277f-a23b-447f-8850-354f54deb07b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hacvsgNZtQyWYLKlhFjevn7hClUquEBd
X-Proofpoint-ORIG-GUID: hacvsgNZtQyWYLKlhFjevn7hClUquEBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304120132
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/23 11:10, Guenter Roeck wrote:
> On Wed, Apr 05, 2023 at 09:52:30AM -0500, Eddie James wrote:
>> Switch the driver to use the default debugfs attributes instead of
>> ones that provide the same data under different names. Use the lock
>> functions for the debugfs and led attributes, and simplify the input
>> history operation by dropping the timer and lock.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/hwmon/pmbus/ibm-cffps.c | 273 ++++++++++++++------------------
>>   1 file changed, 118 insertions(+), 155 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
>> index e3294a1a54bb..2d7ec00e047b 100644
>> --- a/drivers/hwmon/pmbus/ibm-cffps.c
>> +++ b/drivers/hwmon/pmbus/ibm-cffps.c
>> @@ -18,12 +18,6 @@
>>   
> [ ... ]
>>   			}
>> @@ -225,29 +183,27 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
>>   			rc = i * 4;
>>   			break;
>>   		default:
>> -			return -EOPNOTSUPP;
>> +			rc = -EOPNOTSUPP;
>> +			break;
>>   		}
>> -		goto done;
>> +		break;
>>   	case CFFPS_DEBUGFS_ON_OFF_CONFIG:
>> -		rc = i2c_smbus_read_byte_data(psu->client,
>> -					      PMBUS_ON_OFF_CONFIG);
>> -		if (rc < 0)
>> -			return rc;
>> -
>> -		rc = snprintf(data, 3, "%02x", rc);
>> -		goto done;
>> +		rc = i2c_smbus_read_byte_data(psu->client, PMBUS_ON_OFF_CONFIG);
>> +		if (rc >= 0)
>> +			rc = snprintf(data, 3, "%02x", rc);
>> +		break;
>>   	default:
>> -		return -EINVAL;
>> +		rc = -EINVAL;
>> +		break;
>>   	}
>>   
>> -	rc = i2c_smbus_read_block_data(psu->client, cmd, data);
>> +unlock:
>> +	pmbus_unlock(psu->client);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> -done:
>>   	data[rc] = '\n';
>>   	rc += 2;
>> -
> I hate to say (repeat) that, but please refrain from whitespace changes.


Sure, sorry.

Thanks,

Eddie


>
> Guenter
>
>>   	return simple_read_from_buffer(buf, count, ppos, data, rc);
>>   }
