Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2393373957A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjFVCTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:19:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2107.outbound.protection.outlook.com [40.92.91.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD551735;
        Wed, 21 Jun 2023 19:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAAaMDtPD3GZKwfZVy6gIU98zFoeZ6fdKGkjHt0cE352mengefriaaT7EIU38vg6NOGJTQSdwthTqsgQq9vJQw4e+KH9RtK6H/cmboHKPtScjOMtRw+427UDkv8VY9fg4cVBsrEvjUPDVhiFbvtmujNEPZP08TQN2ZNOVWwujQtwSOZIGmpeDiTv8kL9eZ8ZKVTE5wC38G0XwphY+Kh9UphVOOd482qqpQpkZck/BOlcnMHaW7qPzVl1lRIAXOLR8mIT+oJVRCrQFD4TxN+oIVsZ110orRppxQt7JKqoWLpke8GSmbHyNyRhQjcB0U+7BpZ+QjaAJf5702XWyrFbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJwgjNN8gLBRDa5VGY1LdjYDm8UYMWkx/BB2nY2jxWc=;
 b=TA8VzJvRxQl7c7UrJF9fQLj2HZ5TxGdc1yP8FJ+KVChn7EPKOxgi9Lm+JMtMGmt7rIFlGEkcOafUlEmrVb9i5mLE7sC1rWWXInaIQCq33XqGPG6s87Xqlb2b5B1HKqUETxFs3mg8DgPUktMPhqnhbhJ5V92qjG/h5SfSxjrFpF4+Vvdsq3OIKfDSrdwiTc7cSDRWIKgMEtqn1oklskeeqt4ROs/m0IVAB4jDDBXlE6OPmnm2F1+omeYIBuvNCE45/b/A1yVR0sHGrw1KQm8F6AKk4hVmW/tXWsWV77dzTSWv+Q9gO05eOcPEzZfqN8mrAEryHj4iIYk5Lxwk5HpXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJwgjNN8gLBRDa5VGY1LdjYDm8UYMWkx/BB2nY2jxWc=;
 b=n7MxLhJlmd9mcE7wEpm+lueQUWLdcUkcMJWKzzTfltk5CYBs8gZMOVIYe5Kfo732u8LNYW10ymr+VIFY9Ybu33ewH+Iyc3uPjm3bneVnD+iypVtdmBbLTTIKMhPzJAfPw/nGidARdstbK43G8ktlXZ3LMHTbpx/qHgAzWRu2x8hDexKasI7iBdN3UqmxI2hEP0zysuK08VrBx8mmic4Xm0RU3OKtzYHe9wZuCYXC09m1NynfanfcqBDhoZyOuH2WvVWyPaEQId02YLRPccEKw308Q5kiHFvXpEsqjVpINxGpU3JH/S4nY0E/j8Zp+vFm4UoV0aJAsRs2RWCE8z3iIA==
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21)
 by DB9PR10MB5379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:334::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 02:19:14 +0000
Received: from DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88]) by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::628a:d617:46f:2a88%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 02:19:14 +0000
Message-ID: <DB4PR10MB62611CF9D9D101B051EB839E9222A@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
Date:   Thu, 22 Jun 2023 10:19:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RFC PATCH 1/2] hwmon: (sht3x) convert some of sysfs interface to
 hwmon
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <DB4PR10MB6261A846EADE1C40A340E2C7925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
 <7ececfd7-efff-4fa4-b4b7-05acf4bc4b26@roeck-us.net>
From:   JuenKit Yip <JuenKit_Yip@hotmail.com>
In-Reply-To: <7ececfd7-efff-4fa4-b4b7-05acf4bc4b26@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [+mdqxpNz/Q7nJGtvW4KdYqwLWzDcg6iQpy6HQjBPGHN59eFQ7KDErjN6ZzGMWW4fOjYcZJDo0Gw=]
X-ClientProxiedBy: TYAPR01CA0186.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::30) To DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:383::21)
X-Microsoft-Original-Message-ID: <5d8d23dd-369e-fed1-59d0-10c04afaf7fe@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6261:EE_|DB9PR10MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: f48f7a86-c911-4054-09f0-08db72c712b9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BSaZxCsVE2qrBtMRXFhls59fQhCGbP+/PwemtaAJsievvuBRxmRjGjHT6hTtQzMhZUNjRrKMMUeICfyxxs2ZxNx/Y5PK9VZkCPhJ9V71/7zCw2Lz0vfGQeRtAEFhLQTwj3U+6f5QpZ4UPb0gq7dKpfAddTwr7vnqKpqL5VxxhFr8TItREgvl2zLWJpFOh4qUq1co9yBplau3j/sU8RdXvszi/g3JQ7RRi5lS0w1trf3as7y25pQn5U8nK5GpaSaB6WnuFSaQeCObzBemSXBZSfi8l6tp77K8cKUubuaYTJ9JkuQj2mSJnA9KA+ZMYMEIAFvSWSJTDND3l3x8gQvwd68N6NyLBUf3QEXpjommoiskAOjvW9nGxA3WEbOkGRVlmBIF3HrE6roSxyC7pjEtk0v7uzLNcVdQGvTSlCK9uKaDI67uZhdMZ7b8mSDd5LabRVyPxwB7FX60/8qMpI9n/CiKTukKJDQ5DMptc7uzXSRJL8YZVhbaIm7cANtPhj4/LM8wBuik3sHR2rSyPvztfz+bA953qinxL1laSxaDXRn2g0T9zzZy6LbOmU2W0+Ia
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJ3L0phQmxEQWh3VDUzTW9mVTUwTnBWenVhcGVGcnlDek1tVVZLWlhPWld0?=
 =?utf-8?B?TTh4ajkrbTlrY3RjN05JTTROYzlYTDVTdFMvaU40aElwN0JuNjluYVBFMCtr?=
 =?utf-8?B?dkFQYzhDUWd0b09DRGlGWk9OYjQ2d2lIZmx5R1FoUkNUU2JJQWZxQ1pSeUtD?=
 =?utf-8?B?Q3V4c2JTZHRrbzh4ZGJEQUFNOTV6d3JUelRwQy9lL3Fnbm5nYytRQVloNTFr?=
 =?utf-8?B?aEdZb1NEbjZ5ejVlVnZSYVVCUStRUzFtMWVzVmNBUmxaMTA2N01mM1NBWGdJ?=
 =?utf-8?B?ME8rcFhiQ1pOUWpGZ2JnREJpbUxQblRRdVdXYmJBaFFIWk9GLzFPRzhXWUNm?=
 =?utf-8?B?TDBoaEZhOGh5OFcycUhJNGp5NzFBc2R3d01PMkRyOFpQQ1hFei9EVUQ5VW5k?=
 =?utf-8?B?Wm80dWJtbHQ4WlhFaU1yMzFodDFMeFJ6VTJWWkFyRGJiWTRrTnJpQ1lKWTJx?=
 =?utf-8?B?SDE0RkdXTGF0S0xSeDBTUHlWRVkrNXZrdTVpUytBeUJRNFhxQ0U0aWllRy91?=
 =?utf-8?B?NHZoSFpLZW1ET2laeHJwQXpsZk9mZWRSSnlDcjNOWHFwenlYdUZBSmE3SVpU?=
 =?utf-8?B?Q0QvNXZyYWIvNjgvRXZLZ2g4SnBRUDhIY0F2UmNtbnErVTJDaEVWejVIMVlQ?=
 =?utf-8?B?VW1QWHZtbzFrM1RLQUdJZUszTm51WUQwcVpvUkFEMTBCNVVkVmtLVUlpQU1N?=
 =?utf-8?B?YmIrRlBvVC9IbERtSDZWMDZiQVJXekFUSEpVWHRtaitTOS9GU3hnREo2OWNS?=
 =?utf-8?B?S0hSSVp4TldoZnNtWjVmSE9hOUE5b1AyVnoyaitMVXFuWEdTWWpNV2x1Q0o2?=
 =?utf-8?B?MUtxVyt5ci9hb0lLc29lUnVZWjBFSUdtQVBHWWVTNC9mY1p2bHY1ZlpFQ0sr?=
 =?utf-8?B?UUM2VmdJdEVFM0pxajF3eklxTC8zNWpCaHYwRnV0UE1uSEtwSnRUNzB0WEp5?=
 =?utf-8?B?R2liakVRMDZsMmEvbzd5Zjh6ZmxSdUEvam5RWWVBNWdjUm1sOFc0OVZtYURX?=
 =?utf-8?B?b3MzeHlYcWFvQlBFUXVjd3lwcW10d0tkakROYnVuY3FwazZDRzJKa0lFN1Rj?=
 =?utf-8?B?NU1hT1czZE8zSmNqbkJlSml3eDdpb3dDWnF0OCtNK1ZFUXJnTStxc1djL1du?=
 =?utf-8?B?NllpNFIyMEZBa1RkbERKcU5mM3VxUjluWWl2dVFNcmZBSXRZQTlQQ3BqOUdP?=
 =?utf-8?B?MlJLMEtMb2ZqajFTOEZFOE96cVU5UDJTbnhqYlhKODI0YnBYdGdZdTJsN092?=
 =?utf-8?B?eXl3L2VkWVZ4dFVnQkpldXRZdjhFSTE1cllBUXFpZ0NnTldZVUloQTJJWndp?=
 =?utf-8?B?aEF4MDF3YlY5VHdPaUJ3dTQrYTZqU0ZWQy8wL1Q3ZUs0U0NqZFVTL0RTVTVp?=
 =?utf-8?B?U2RRVWNnL3MwaTI5emNqR1VEMjJBY1daajhvdndyQ3paRG02QkZYamRHMWlG?=
 =?utf-8?B?UmtnODBmS2RpamVPN0IzNFQ3dk9qbUF2R1FmaU41amVmcFdTVUM4NkFSenEx?=
 =?utf-8?B?a01VcGs2Sk42M0NmazhzbGwveHNEeHF4dGdtYkN3S2h6TVRGUWFkeUJWWWsv?=
 =?utf-8?B?YzBiVUovVENuNG11R2tTMWtTZldYcnpIVlJuTHM5a1F4VC9VMmYxQ0tDWGdD?=
 =?utf-8?B?bnNwd2V0L0QxbmtDV2RmM282QTFob3YxNUhxdDJNcDd2UE9ZdFc2aVVtb21E?=
 =?utf-8?B?RHo3MmFVRW82aFFHQXlLaWNCMEpBWUwyL3FRamFsTDBqUDR2MFBNNE5HM0tz?=
 =?utf-8?Q?mIyx9POJoJ+IkXNIhs=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f48f7a86-c911-4054-09f0-08db72c712b9
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 02:19:14.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5379
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/6/21 23:33, Guenter Roeck 写道:
> On Wed, Jun 21, 2023 at 11:59:36AM +0800, JuenKit Yip wrote:
>> update_interval, temperature/humidity max/min and hyst
>> were moved to new hwmon interface, and only heater and
>> repeatability were reserved as non-stardard sysfs interface.
>>
>> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
>> ---
>>   drivers/hwmon/sht3x.c | 351 ++++++++++++++++++++++++++++--------------
>>   1 file changed, 239 insertions(+), 112 deletions(-)
>>
>> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
>> index bf1863061..31013b5b6 100644
>> --- a/drivers/hwmon/sht3x.c
>> +++ b/drivers/hwmon/sht3x.c
>> @@ -147,6 +147,37 @@ static const u16 mode_to_update_interval[] = {
>>   	 100,
>>   };
>>   
>> +static const struct hwmon_channel_info * const sht3x_channel_info[] = {
>> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
>> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MIN |
>> +				HWMON_T_MIN_HYST | HWMON_T_MAX |
>> +				HWMON_T_MAX_HYST | HWMON_T_ALARM),
>> +	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT | HWMON_H_MIN |
>> +				HWMON_H_MIN_HYST | HWMON_H_MAX |
>> +				HWMON_H_MAX_HYST | HWMON_H_ALARM),
>> +	NULL,
>> +};
>> +
>> +static const struct i2c_device_id sht3x_ids[];
>> +
>> +static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
>> +				u32 attr, int channel);
>> +static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
>> +		      u32 attr, int channel, long *val);
>> +static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
>> +		       u32 attr, int channel, long val);
>> +
> No forward declarations, please.
>
>> +static const struct hwmon_ops sht3x_ops = {
>> +	.is_visible = sht3x_is_visible,
>> +	.read = sht3x_read,
>> +	.write = sht3x_write,
>> +};
>> +
>> +static const struct hwmon_chip_info sht3x_chip_info = {
>> +	.ops = &sht3x_ops,
>> +	.info = sht3x_channel_info,
>> +};
>> +
>>   struct sht3x_data {
>>   	struct i2c_client *client;
>>   	struct mutex i2c_lock; /* lock for sending i2c commands */
>> @@ -277,26 +308,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
>>   }
>>   
>>   /* sysfs attributes */
> Those are no longer sysfs attributes.
>
>> -static ssize_t temp1_input_show(struct device *dev,
>> -				struct device_attribute *attr, char *buf)
>> +static int temp1_input_show(struct device *dev)
> Drop _show from functions which no longer show anything.
>
>>   {
>>   	struct sht3x_data *data = sht3x_update_client(dev);
>>   
>>   	if (IS_ERR(data))
>>   		return PTR_ERR(data);
>>   
>> -	return sprintf(buf, "%d\n", data->temperature);
>> +	return data->temperature;
>>   }
>>   
>> -static ssize_t humidity1_input_show(struct device *dev,
>> -				    struct device_attribute *attr, char *buf)
>> +static int humidity1_input_show(struct device *dev)
>>   {
>>   	struct sht3x_data *data = sht3x_update_client(dev);
>>   
>>   	if (IS_ERR(data))
>>   		return PTR_ERR(data);
>>   
>> -	return sprintf(buf, "%u\n", data->humidity);
>> +	return data->humidity;
>>   }
>>   
>>   /*
>> @@ -332,33 +361,24 @@ static int limits_update(struct sht3x_data *data)
>>   	return ret;
>>   }
>>   
>> -static ssize_t temp1_limit_show(struct device *dev,
>> -				struct device_attribute *attr,
>> -				char *buf)
>> +static int temp1_limit_show(struct device *dev, int index)
>>   {
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>> -	u8 index = to_sensor_dev_attr(attr)->index;
>> -	int temperature_limit = data->temperature_limits[index];
>>   
>> -	return sysfs_emit(buf, "%d\n", temperature_limit);
>> +	return data->temperature_limits[index];
>>   }
>>   
>> -static ssize_t humidity1_limit_show(struct device *dev,
>> -				    struct device_attribute *attr,
>> -				    char *buf)
>> +static ssize_t humidity1_limit_show(struct device *dev, int index)
> Return value is int.
>
>>   {
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>> -	u8 index = to_sensor_dev_attr(attr)->index;
>> -	u32 humidity_limit = data->humidity_limits[index];
>>   
>> -	return sysfs_emit(buf, "%u\n", humidity_limit);
>> +	return data->humidity_limits[index];
>>   }
>>   
>>   /*
>>    * limit_store must only be called with data_lock held
>>    */
>>   static size_t limit_store(struct device *dev,
> Drop _store from functions which are no longer sysfs store functions.
> Also, again, return values are int. Note that "size_t" is wrong
> in the current code; it should have been ssize_t since it can
> return a negative value.
I will review them again. Thanks
>
>> -			  size_t count,
>>   			  u8 index,
>>   			  int temperature,
>>   			  u32 humidity)
>> @@ -400,50 +420,42 @@ static size_t limit_store(struct device *dev,
>>   
>>   	data->temperature_limits[index] = temperature;
>>   	data->humidity_limits[index] = humidity;
>> -	return count;
>> +	return 0;
>>   }
>>   
>> -static ssize_t temp1_limit_store(struct device *dev,
>> -				 struct device_attribute *attr,
>> -				 const char *buf,
>> -				 size_t count)
>> +static int temp1_limit_store(struct device *dev, int index, const char *val)
>>   {
>>   	int temperature;
>>   	int ret;
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>> -	u8 index = to_sensor_dev_attr(attr)->index;
>>   
>> -	ret = kstrtoint(buf, 0, &temperature);
>> +	ret = kstrtoint(val, 0, &temperature);
>>   	if (ret)
>>   		return ret;
>>   
>>   	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
>>   				SHT3X_MAX_TEMPERATURE);
>>   	mutex_lock(&data->data_lock);
>> -	ret = limit_store(dev, count, index, temperature,
>> +	ret = limit_store(dev, index, temperature,
>>   			  data->humidity_limits[index]);
>>   	mutex_unlock(&data->data_lock);
>>   
>> -	return ret;
>> +	return 0;
> Ignore errors from limit_store() ? why ?
>
>>   }
>>   
>> -static ssize_t humidity1_limit_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf,
>> -				     size_t count)
>> +static ssize_t humidity1_limit_store(struct device *dev, int index, const char *val)
>>   {
>>   	u32 humidity;
>>   	int ret;
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>> -	u8 index = to_sensor_dev_attr(attr)->index;
>>   
>> -	ret = kstrtou32(buf, 0, &humidity);
>> +	ret = kstrtou32(val, 0, &humidity);
>>   	if (ret)
>>   		return ret;
>>   
>>   	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
>>   	mutex_lock(&data->data_lock);
>> -	ret = limit_store(dev, count, index, data->temperature_limits[index],
>> +	ret = limit_store(dev, index, data->temperature_limits[index],
>>   			  humidity);
>>   	mutex_unlock(&data->data_lock);
>>   
>> @@ -474,7 +486,6 @@ static void sht3x_select_command(struct sht3x_data *data)
>>   }
>>   
>>   static int status_register_read(struct device *dev,
>> -				struct device_attribute *attr,
>>   				char *buffer, int length)
>>   {
>>   	int ret;
>> @@ -487,34 +498,30 @@ static int status_register_read(struct device *dev,
>>   	return ret;
>>   }
>>   
>> -static ssize_t temp1_alarm_show(struct device *dev,
>> -				struct device_attribute *attr,
>> -				char *buf)
>> +static int temp1_alarm_show(struct device *dev)
>>   {
>>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>>   	int ret;
>>   
>> -	ret = status_register_read(dev, attr, buffer,
>> +	ret = status_register_read(dev, buffer,
>>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>>   	if (ret)
>>   		return ret;
>>   
>> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
>> +	return !!(buffer[0] & 0x04);
>>   }
>>   
>> -static ssize_t humidity1_alarm_show(struct device *dev,
>> -				    struct device_attribute *attr,
>> -				    char *buf)
>> +static int humidity1_alarm_show(struct device *dev)
>>   {
>>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>>   	int ret;
>>   
>> -	ret = status_register_read(dev, attr, buffer,
>> +	ret = status_register_read(dev, buffer,
>>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>>   	if (ret)
>>   		return ret;
>>   
>> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
>> +	return !!(buffer[0] & 0x08);
>>   }
>>   
>>   static ssize_t heater_enable_show(struct device *dev,
>> @@ -524,7 +531,7 @@ static ssize_t heater_enable_show(struct device *dev,
>>   	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>>   	int ret;
>>   
>> -	ret = status_register_read(dev, attr, buffer,
>> +	ret = status_register_read(dev, buffer,
>>   				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>>   	if (ret)
>>   		return ret;
>> @@ -560,20 +567,14 @@ static ssize_t heater_enable_store(struct device *dev,
>>   	return ret;
>>   }
>>   
>> -static ssize_t update_interval_show(struct device *dev,
>> -				    struct device_attribute *attr,
>> -				    char *buf)
>> +static int update_interval_show(struct device *dev)
>>   {
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>>   
>> -	return sysfs_emit(buf, "%u\n",
>> -			 mode_to_update_interval[data->mode]);
>> +	return mode_to_update_interval[data->mode];
>>   }
>>   
>> -static ssize_t update_interval_store(struct device *dev,
>> -				     struct device_attribute *attr,
>> -				     const char *buf,
>> -				     size_t count)
>> +static int update_interval_store(struct device *dev, const char *val)
>>   {
>>   	u16 update_interval;
>>   	u8 mode;
>> @@ -582,7 +583,7 @@ static ssize_t update_interval_store(struct device *dev,
>>   	struct sht3x_data *data = dev_get_drvdata(dev);
>>   	struct i2c_client *client = data->client;
>>   
>> -	ret = kstrtou16(buf, 0, &update_interval);
>> +	ret = kstrtou16(val, 0, &update_interval);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -592,7 +593,7 @@ static ssize_t update_interval_store(struct device *dev,
>>   	/* mode did not change */
>>   	if (mode == data->mode) {
>>   		mutex_unlock(&data->data_lock);
>> -		return count;
>> +		return 0;
>>   	}
>>   
>>   	mutex_lock(&data->i2c_lock);
>> @@ -634,7 +635,7 @@ static ssize_t update_interval_store(struct device *dev,
>>   	if (ret != SHT3X_CMD_LENGTH)
>>   		return ret < 0 ? ret : -EIO;
>>   
>> -	return count;
>> +	return 0;
>>   }
>>   
>>   static ssize_t repeatability_show(struct device *dev,
>> @@ -668,60 +669,191 @@ static ssize_t repeatability_store(struct device *dev,
>>   	return count;
>>   }
>>   
>> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
>> -static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
>> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
>> -static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
>> -static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
>> -static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
>> -			     limit_max_hyst);
>> -static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
>> -static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
>> -static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
>> -static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
>> -			     limit_min_hyst);
>> -static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
>> -static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
>>   static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
>> -static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
>>   static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
>>   
>>   static struct attribute *sht3x_attrs[] = {
>> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_max.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_max_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_min.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_min_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
>>   	&sensor_dev_attr_heater_enable.dev_attr.attr,
>> -	&sensor_dev_attr_update_interval.dev_attr.attr,
>> -	&sensor_dev_attr_repeatability.dev_attr.attr,
>> -	NULL
>> -};
>> -
>> -static struct attribute *sts3x_attrs[] = {
>> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
>> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_heater_enable.dev_attr.attr,
>> -	&sensor_dev_attr_update_interval.dev_attr.attr,
>>   	&sensor_dev_attr_repeatability.dev_attr.attr,
>>   	NULL
>>   };
>>   
>>   ATTRIBUTE_GROUPS(sht3x);
>> -ATTRIBUTE_GROUPS(sts3x);
>>   
>> -static const struct i2c_device_id sht3x_ids[];
>> +static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
>> +				u32 attr, int channel)
>> +{
>> +	const struct sht3x_data *chip_data = data;
>> +	struct i2c_client *client = chip_data->client;
>> +
>> +	switch (type) {
>> +	case hwmon_chip:
>> +		switch (attr) {
>> +		case hwmon_chip_update_interval:
>> +			return 0644;
>> +		default:
>> +			return -EINVAL;
> 			return 0;
>
>> +		}
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +		case hwmon_temp_alarm:
>> +			return 0444;
>> +		case hwmon_temp_max:
>> +		case hwmon_temp_max_hyst:
>> +		case hwmon_temp_min:
>> +		case hwmon_temp_min_hyst:
>> +			return 0644;
>> +		default:
>> +			return -EINVAL;
> 			return 0;
>
>> +		}
>> +	case hwmon_humidity:
>> +		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
>> +			return 0;
>> +		switch (attr) {
>> +		case hwmon_humidity_input:
>> +		case hwmon_humidity_alarm:
>> +			return 0444;
>> +		case hwmon_humidity_max:
>> +		case hwmon_humidity_max_hyst:
>> +		case hwmon_humidity_min:
>> +		case hwmon_humidity_min_hyst:
>> +			return 0644;
>> +		default:
>> +			return -EINVAL;
> 			return 0;
>
>> +		}
>> +	default:
>> +		return -EINVAL;
> 			returen 0;
>> +	}
>> +
>> +	return -EINVAL;
> 	return 0;
>
> Never gets here. FWIW, you might use break; above
> instead of all those return 0; statements.
>
>> +}
>> +
>> +static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
>> +		      u32 attr, int channel, long *val)
>> +{
>> +	enum sht3x_limits index;
>> +
>> +	switch (type) {
>> +	case hwmon_chip:
>> +		switch (attr) {
>> +		case hwmon_chip_update_interval:
>> +			*val = update_interval_show(dev);
>> +			break;
>> +		default:
>> +			return -EINVAL;
> 				-EOPNOTSUPP
>> +		}
>> +		break;
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			*val = temp1_input_show(dev);
>> +			return 0;
>> +		case hwmon_temp_alarm:
>> +			*val = temp1_alarm_show(dev);
>> +			return 0;
>> +		case hwmon_temp_max:
>> +			index = limit_max;
>> +			break;
>> +		case hwmon_temp_max_hyst:
>> +			index = limit_max_hyst;
>> +			break;
>> +		case hwmon_temp_min:
>> +			index = limit_min;
>> +			break;
>> +		case hwmon_temp_min_hyst:
>> +			index = limit_min_hyst;
>> +			break;
>> +		default:
>> +			return -EINVAL;
> 			-EOPNOTSUPP
>> +		}
>> +		*val = temp1_limit_show(dev, index);
>> +		return 0;
> Please be consistent. Either always return 0 in case statements or use break,
> but do not mix the two.
fix it
>
>> +	case hwmon_humidity:
>> +		switch (attr) {
>> +		case hwmon_humidity_input:
>> +			*val = humidity1_input_show(dev);
>> +			return 0;
>> +		case hwmon_humidity_alarm:
>> +			*val = humidity1_alarm_show(dev);
>> +			return 0;
>> +		case hwmon_humidity_max:
>> +			index = limit_max;
>> +			break;
>> +		case hwmon_humidity_max_hyst:
>> +			index = limit_max_hyst;
>> +			break;
>> +		case hwmon_humidity_min:
>> +			index = limit_min;
>> +			break;
>> +		case hwmon_humidity_min_hyst:
>> +			index = limit_min_hyst;
>> +			break;
>> +		default:
>> +			return -EINVAL;
> 			-EOPNOTSUPP
>> +		}
>> +		*val = humidity1_limit_show(dev, index);
>> +		return 0;
>> +	default:
>> +		return -EINVAL;
> 		-EOPNOTSUPP
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
>> +		       u32 attr, int channel, long val)
>> +{
>> +	enum sht3x_limits index;
>> +
>> +	switch (type) {
>> +	case hwmon_chip:
>> +		switch (attr) {
>> +		case hwmon_chip_update_interval:
>> +			return update_interval_store(dev, (const char *)&val);
>> +		default:
>> +			return -EINVAL;
> 			-EOPNOTSUPP
>> +		}
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_max:
>> +			index = limit_max;
>> +			break;
>> +		case hwmon_temp_max_hyst:
>> +			index = limit_max_hyst;
>> +			break;
>> +		case hwmon_temp_min:
>> +			index = limit_min;
>> +			break;
>> +		case hwmon_temp_min_hyst:
>> +			index = limit_min_hyst;
>> +			break;
>> +		default:
>> +			return -EINVAL;
> 			-EOPNOTSUPP
>
>> +		}
>> +		return temp1_limit_store(dev, index, (const char *)&val);
>> +	case hwmon_humidity:
>> +		switch (attr) {
>> +		case hwmon_humidity_max:
>> +			index = limit_max;
>> +			break;
>> +		case hwmon_humidity_max_hyst:
>> +			index = limit_max_hyst;
>> +			break;
>> +		case hwmon_humidity_min:
>> +			index = limit_min;
>> +			break;
>> +		case hwmon_humidity_min_hyst:
>> +			index = limit_min_hyst;
>> +			break;
>> +		default:
>> +			return -EINVAL;
> 			-EOPNOTSUPP
>> +		}
>> +		return humidity1_limit_store(dev, index, (const char *)val);
>> +	default:
>> +		return -EINVAL;
> 			-EOPNOTSUPP
>> +	}
>> +}
>>   
>>   static int sht3x_probe(struct i2c_client *client)
>>   {
>> @@ -730,7 +862,6 @@ static int sht3x_probe(struct i2c_client *client)
>>   	struct device *hwmon_dev;
>>   	struct i2c_adapter *adap = client->adapter;
>>   	struct device *dev = &client->dev;
>> -	const struct attribute_group **attribute_groups;
>>   
>>   	/*
>>   	 * we require full i2c support since the sht3x uses multi-byte read and
>> @@ -771,15 +902,11 @@ static int sht3x_probe(struct i2c_client *client)
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
>> -		attribute_groups = sts3x_groups;
>> -	else
>> -		attribute_groups = sht3x_groups;
>> -
>> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
>> -							   client->name,
>> -							   data,
>> -							   attribute_groups);
>> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
>> +							 client->name,
>> +							 data,
>> +							 &sht3x_chip_info,
>> +							 sht3x_groups);
> Shouldn't sht3x_groups only be added if the chip is sts3x ?

all functionality are registered, but as for sts3x, humidity-related 
hwmon-interface

will be invisble.

The code listed below is defined in sht3x_is_visble, I also notice that 
if return value

is zero, the attribute will not be created.

case hwmon_humidity:
+		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
+			return 0;


>
>>   
>>   	if (IS_ERR(hwmon_dev))
>>   		dev_dbg(dev, "unable to register hwmon device\n");
>> -- 
>> 2.30.2
>>
