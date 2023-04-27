Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81286F00B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjD0GN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjD0GNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:13:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2051.outbound.protection.outlook.com [40.92.107.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1433585;
        Wed, 26 Apr 2023 23:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoWQhB8mouI/RDKrauxsXwrYeTDGKLrxo0G1CecZ96ZHTA5RWGF4VTDXV1jeP5c6J4gOhRr8vJhSZRA02zLT0LidQr+oiliSoUgLF8JXUBrHorz5LnL9wrpxZ/ClM5AJ92AvpBHaPrGFNC2x9Vblar+U46vL3657L0L9A7cBrXUVAJ8Jn4CCmKpAxmSvFEnGMCWsk6vHIB4WIE2k+aR5VO+Nei66Y38LHYzZKFOFPb4eZqr4ynWTTqhStRwCjCNEREm04y8FmS+ds1YFSVz18wzgFG6JdInkukcChm6/mwwibH9znkDDS11nZXNGPINfttY/GDHE+g/SRivDY+aFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eURFmcQgbrfJzsQ7Kq1vE5fT0S+1vvmOwgGYone7FGw=;
 b=U3QDrlBkRA9YczeNuQ5oDzeEe6mkYaEBNeNrk5LrL7ztOqqHktTFZCvXISJhpeFSk0uu1eHIt+3AMKjvbNnoCzBnjetxO9mC/5tFxMsC9nvzcP8y/WvYK1T1y/BORmIhkzQkaEyr1rlHKZxBTX//PW5km85UFEhf18B2EcUqBg/Bmux4nKrkdLVGeTuVWWeTvojyPva+R+kNMT+RGsixgxMBF/iqr2ABbbYe9rYXSV03gShubaZO5ANh56UgwqwfDJJrwXwpmhBaAL2vmeRMl1RnTiFWK33m6Oa401u69y9kjhMbHkBO2lE9zAzHTSBNKQQeN/F0/nG1LJs6W4vd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eURFmcQgbrfJzsQ7Kq1vE5fT0S+1vvmOwgGYone7FGw=;
 b=jlOre6GTgIBpZnormH1+bwNjy/w1C36/RBIYLvy7FQqx20lm/CG36MOKynCOJ84SnRQ+MqF6iNa9wRnP4c/VZLdYN8Z+K68hc7a4toEe0m12NhhD2tsgz9+tt9tEO1eanO/9pEm37f5C/pBOTJetR3GAWQj1iEpw5rWzV4O+b8wsCKGnI2I46235b++NycEKLmUjv1NWc1xetaM9Vixl2hjINDsqdhBqQwO6GkDK9nhHLtQneG9Er10YOtpzNKvTMbm5h0V4Ym6MK3z0rfPmMq+TDGhVVUIUH4IXTaZydsbbP5qZI23IPlxbhA6ge259UMDeFsC/FLt8GaX9BCxx5w==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by PUZPR01MB5377.apcprd01.prod.exchangelabs.com
 (2603:1096:301:119::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19; Thu, 27 Apr
 2023 06:13:50 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::1ff1:2f4e:bc0:1ba9]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::1ff1:2f4e:bc0:1ba9%3]) with mapi id 15.20.6340.021; Thu, 27 Apr 2023
 06:13:49 +0000
Message-ID: <KL1PR01MB5448B8F5A913595614039ABAE66A9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
Date:   Thu, 27 Apr 2023 14:13:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <202304232146.7M89pwCz-lkp@intel.com>
 <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEk4YNQeYohEwnSg@surfacebook>
From:   Yan Wang <rk.code@outlook.com>
In-Reply-To: <ZEk4YNQeYohEwnSg@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [7PooMc7JPa3dVUJGCWT7FOvOsR4DqX5FhtN6z5r0Mtg=]
X-ClientProxiedBy: TYCPR01CA0167.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::7) To KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <b38ff390-3353-aa9e-cd5a-a3f7db28d17f@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|PUZPR01MB5377:EE_
X-MS-Office365-Filtering-Correlation-Id: 71589894-4376-4e73-808b-08db46e6913d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aa6bbxZAgFVfGsymXrpsaGsgturlf21Z1tyypd999+XC9zf7Cs0pe4KXGXMRaL24llQ/PF4G6yShgs293+jKwXhrskljZPQpT1KJbP6fUuQTLW3ypccvq3aue1JLLk/CyFxfbjIHI/9O2URM01EJkuEBoNSm7lBgGrwqDlSw+qwSHhdh5noT4+6wxncptQwfGvwOY2gyI57jyAYj+9ADkwa8kc0nj2ckXqFkC6QRYB/5iijHjNDt0b4zvkxPAF3FTE+dGRRoUdS4FOt/W/TQU4rDwikaMV4G1/Sng+fZQF049tqLcjjXUYcBZIk71kuB/1kjRks5s88SLRv/a+k/Ois+lh0aoTgyeIF9wcgwXWquamoiP9c/BUCPmZnis4s0WAgMX0iUraMFK2uIDObr+YHBLRSkx9riHMi5NYx6l08dyLGyiosIKjx08rlXN5/SOQVdhlpMfHg9MTAEJicaFX/jbV+hTfG0OKoE9spd5WlccLOFWXApN7JfX3fGZPdWch1theKRKmwF3nvfxu7+Yi52QXqBEtH4D+patGHloj6p6MP5gyCsZZB2gu5VokytbjvHUCK9MLkY8ad2jwZyg7mqAmk1RBltOdEBas8q7kQKC4eUyE/1OyWHuup9Fgp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGE4eUdQcENFZDVTcEpiWUs3d20zZk5JQ0N5c2g2M2pKZUJKUUV3OUlraXRV?=
 =?utf-8?B?MWQxY1RMcWc4TEdnY3lDK3JoWldKTFhleFIvRWZuMUprQnhUZGQ3STBDaXZj?=
 =?utf-8?B?eUhWb20wa2FSYjZSQnMzVmRBNitham96UFc4OW1IbFE0VHpWUldYM08zSVVu?=
 =?utf-8?B?TlY4TWNoZW5aYzliLzNlSTB4MmZvMEhucGZ0WExZMFVwa3JzeERqeVNvYnRV?=
 =?utf-8?B?djFubkZtYlF5bitUWFBvU1Bndkp1K3pCL25tbnhOKzY0TGpnRTQwb1hiR1dB?=
 =?utf-8?B?MzAyR3E1V01mVFQ0V2tFaktMUWgwVE5FRnJETFpSYi9aVWh1NnYva3I2b3ZJ?=
 =?utf-8?B?OUxLSnU1Z1FzZjlwM3RiUENFUVNrbDNpaFpZemJZYnZmZ1cyYm42MjVnTDEz?=
 =?utf-8?B?bHdKMlk2bmFFQXhRZC9pc1QvQzJPd0dKY2lwSlZ6L2k4TkV3YXRaMmR5cFhl?=
 =?utf-8?B?VzhESm5FY0Fsc3U2cEY4bnFWUXIzczQ1ejRMT2Z4cWM0S2UrV3lIaC82MEdG?=
 =?utf-8?B?TFBaeDZJNGdJZll3bTl3YllhT3lzand2cDAyUk5oV2lHckpuWElLa2h3NW5z?=
 =?utf-8?B?bW04YUlKZ1lBQ2lsVlQ1SDZLSS9DTDRlNVFmV1QzZWlkbDRIV1RkcHNMdk5p?=
 =?utf-8?B?S0lZdllDMVVRbm1GVUo2aHpuZVViOTNxcEs1b1RmT3crRkwxdkhFZVdNd3FW?=
 =?utf-8?B?OXhkVDlnTm5KYkIrQjB3Z0hNRUpXVFh4VEVNNGVFTHQ2ZHljYVorODMySHVk?=
 =?utf-8?B?ZnR0WHVHUVFTVms3UWMvYjhEaFovc0Vna0FrV2IrODRXNzFCZHBhaFNWZFVp?=
 =?utf-8?B?Sm9pd0piUVowVFN2VFVtNTB5bVRhc0pWWTFwSTJVN0p0Z0xRNmZZQ2FGUXkv?=
 =?utf-8?B?MUZlU0VVbWJTRCtmNDN0d0Vvakw5c09CT1cyY2d1N0hESkd5VnNNRHVOcTFw?=
 =?utf-8?B?K0RuQVZmYlhQVjh5Y1hCcjl0cnN1RDNlYTVrR2wrS0UzVk4zekVTaWEzbFNK?=
 =?utf-8?B?aDJkTmlnRS9LZUc5Um9BZFlJbUhFS2NSeWpUbjdGNDYyMlFTQjV3N0hYYnBz?=
 =?utf-8?B?VkRNa3JGRVY5UjBYODZSN002dHo1WDlDVjZzRVlJb3lpMkV0OWdJMTY4V2dv?=
 =?utf-8?B?RkRUQ29KQ2F6VzJzRDNKb3d5WDZ0U1QrcTdqd3kwcGZoemVDVmw2NGl4QUJa?=
 =?utf-8?B?Zk1vUW1BT0VCamcxVGEvU1hLR1pJMkNCaEhxbFVOWHJ5UEJ2MlFIMkoxelVl?=
 =?utf-8?B?WWJIQVE2UEhoNUVTZkJjTHlKWnZRMTVDeXVxOFJ0a2phL01yRzU3enQ1VHV2?=
 =?utf-8?B?cDNPZVRUOUpFQ2RGZW8xazQ1UHB2cFBxT1FMUTZDTE5oNEZYd2lsdE1BVUov?=
 =?utf-8?B?UnIyLzhSRmdGS0llcldTY2NiUXBpRXdIdXZLRzRUa01UWDVXZzlhdTNBV2d0?=
 =?utf-8?B?T0svZE0zaXlRMWM3R3dSREtONk5tYUp2ZmFhMkc0ZUl3Tk1EVkh3dDhsaE5F?=
 =?utf-8?B?OHNOc0tzR2FaaGtYM3BEcWdNZHB2bUVoajNSelFtbFVjZlRwQi83R0QxOS9F?=
 =?utf-8?B?ME5BTHdubGZYYmZ1QlZQNnBtTC9jQVBoYUd3RlhHNXhtMks1dnhIYzhSV1Vv?=
 =?utf-8?B?VW85VGQwRlE0cmdVSU1DM2hNSERxQVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71589894-4376-4e73-808b-08db46e6913d
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:13:49.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5377
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2023 10:42 PM, andy.shevchenko@gmail.com wrote:
> Sun, Apr 23, 2023 at 09:59:43PM +0800, Yan Wang kirjoitti:
>> if hardware number different to array index,it needs to clear to points
>> memory space if the array_info have been assigned a value.
> Can you explain a bit more what's going on there?
>
> ...
Hi Andy,

I use gpiod_get_array() to get a gpio array form the node of DTS.

the node is as follows:
...
gpios = <&gpio1 0 0>, <&gpio1 10 0>;
...
first scan 0 pin of gpio1, its index and hardware number are 0,
the (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) is true and 
descs->info = array_info. then scan 10 pin , its index is 1 ,but 
hardware number is 10 , the  (gpio_chip_hwgpio(desc) != descs->ndescs) 
is true. array_info = NULL, Just make array_info point to NULL, Did't 
clean descs->info memory or point it to NULL. Should the array_info 
point to memory be cleared ? if not cleared ,I use 
gpiod_set_array_value_cansleep() setting pin 10 of gpio1 is invalid. I 
found that the set_mask and get_mask vlaues of descs->info are seted 
0x03 in gpiod_get_array(), I think 0x401 is their correct value. Thank 
you review
>>   			if (bitmap_full(array_info->get_mask, descs->ndescs)) {
>> +				/*clear descs->info*/
>> +				memset(array_info, 0, sizeof(struct gpio_array));
>>   				array_info = NULL;
> ...
>
>>   			}

