Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F015A741443
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjF1Ovx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:51:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1854 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231928AbjF1OvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:51:11 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SElKev000402;
        Wed, 28 Jun 2023 14:50:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lz8phgxwdI4fLjtVt3p9EZadjcu5lnjjzRctATPqjes=;
 b=QW0xyFVpR7B+khwUayz2IGt+pZKii4N7nzgOKRkQ323kTyhRFQkY8JMjn+vIJ4EKykUi
 TT9pwNwcHu1Jpse0MOv45K7v57wWdYMctoQw4GvdhdfVeXDcp5xVsS2MmbMyBwjRlT1i
 Rxu6xZ/8sbsEmw7HWcyhAMcQPZDy+gCNxNYmnRPa7CuaCWS+XEi1J535wUDfIEfno+h+
 t2Ooj783mvTyEknJ1TBLsOptkOh/4F+fFlF8sqEQJnG/D2TZTpGWqJFLBWCo9VlNcMgp
 ZTDIBlXw2RzekaNJAyX+uXbsrwbKc1rJciXRX/QGNZtG2trV33Q00lm9Ei/YjLdV3zvo IA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rgpxd82av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:50:56 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35SCgURQ020446;
        Wed, 28 Jun 2023 14:50:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3rdr46ahk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 14:50:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35SEosFf18153868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:50:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBBEF58050;
        Wed, 28 Jun 2023 14:50:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7610E58052;
        Wed, 28 Jun 2023 14:50:54 +0000 (GMT)
Received: from [9.61.85.197] (unknown [9.61.85.197])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jun 2023 14:50:54 +0000 (GMT)
Message-ID: <b3a5036e-83b2-a8be-cc9e-fafb161047ec@linux.ibm.com>
Date:   Wed, 28 Jun 2023 09:50:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (pmbus/acbel-fsg032) Add firmware version debugfs
 attribute
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        lakshmiy@us.ibm.com
References: <20230627184027.16343-1-eajames@linux.ibm.com>
 <460709cb-3c5f-436a-e9e7-2562ab079677@roeck-us.net>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <460709cb-3c5f-436a-e9e7-2562ab079677@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5luhO2kfIjcpt4v1lgfp4hyUMv_VEVIx
X-Proofpoint-ORIG-GUID: 5luhO2kfIjcpt4v1lgfp4hyUMv_VEVIx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/23 17:19, Guenter Roeck wrote:
> On 6/27/23 11:40, Eddie James wrote:
>> Like the IBM CFFPS driver, export the PSU's firmware version to a
>> debugfs attribute as reported in the manufacturer register.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/hwmon/pmbus/acbel-fsg032.c | 48 ++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/hwmon/pmbus/acbel-fsg032.c 
>> b/drivers/hwmon/pmbus/acbel-fsg032.c
>> index 0a0ef4ce3493..4b97f108cfe3 100644
>> --- a/drivers/hwmon/pmbus/acbel-fsg032.c
>> +++ b/drivers/hwmon/pmbus/acbel-fsg032.c
>> @@ -3,6 +3,7 @@
>>    * Copyright 2023 IBM Corp.
>>    */
>>   +#include <linux/debugfs.h>
>>   #include <linux/device.h>
>>   #include <linux/fs.h>
>>   #include <linux/i2c.h>
>> @@ -11,6 +12,52 @@
>>   #include <linux/hwmon-sysfs.h>
>>   #include "pmbus.h"
>>   +#define ACBEL_MFR_FW_REVISION    0xd9
>> +
>> +static ssize_t acbel_fsg032_debugfs_read(struct file *file, char 
>> __user *buf, size_t count,
>> +                     loff_t *ppos)
>> +{
>> +    struct i2c_client *client = file->private_data;
>> +    char data[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
>> +    char out[8];
>> +    int rc;
>> +    int i;
>> +
>> +    rc = pmbus_lock_interruptible(client);
>
> Is that needed here ?


Good point, it's not.


>
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = i2c_smbus_read_block_data(client, ACBEL_MFR_FW_REVISION, 
>> data);
>> +    pmbus_unlock(client);
>> +    if (rc < 0)
>> +        return rc;
>> +
>> +    for (i = 0; i < rc && i < 3; ++i)
>> +        snprintf(&out[i * 2], 3, "%02X", data[i]);
>> +
>> +    rc = i * 2;
>> +    out[rc++] = '\n';
>> +    out[rc++] = 0;
>
> Any reason for not using one of the %*ph variants ?


Nope, that will work great, thanks.

Eddie


>
> Thanks,
> Guenter
>
>> +    return simple_read_from_buffer(buf, count, ppos, out, rc);
>> +}
>> +
>> +static const struct file_operations acbel_debugfs_ops = {
>> +    .llseek = noop_llseek,
>> +    .read = acbel_fsg032_debugfs_read,
>> +    .write = NULL,
>> +    .open = simple_open,
>> +};
>> +
>> +static void acbel_fsg032_init_debugfs(struct i2c_client *client)
>> +{
>> +    struct dentry *debugfs = pmbus_get_debugfs_dir(client);
>> +
>> +    if (!debugfs)
>> +        return;
>> +
>> +    debugfs_create_file("fw_version", 0444, debugfs, client, 
>> &acbel_debugfs_ops);
>> +}
>> +
>>   static const struct i2c_device_id acbel_fsg032_id[] = {
>>       { "acbel_fsg032" },
>>       {}
>> @@ -59,6 +106,7 @@ static int acbel_fsg032_probe(struct i2c_client 
>> *client)
>>       if (rc)
>>           return rc;
>>   +    acbel_fsg032_init_debugfs(client);
>>       return 0;
>>   }
>
