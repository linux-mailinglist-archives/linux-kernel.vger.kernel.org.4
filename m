Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2746863CDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiK3DkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiK3DkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:40:23 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99D21E31;
        Tue, 29 Nov 2022 19:40:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc+D28LzQg1bv3HEAB7n8ICemPapnZ+fvnSb+4F98PVhwmWxJ0Gyba/E4cFd0ja3faG1SS70UL5+j42/QPHVEirweM8RhATUqOioi9UdVJ415+Kmv2n67FvuxF/GvAqbY0b/K4G7mZtiOtftGqWNaSs+wRscOlkSYE62lIYxs9J1cE3qcI/9iVmt4jP0QIaMjtvPKWZHHG4SXyIuHSRyqkYw5OHPrOv+EpefBpBCE/HO+XaIwnbSza7yzzL9MwaR7Kmk7iKZguV+iDat9E4etX8piyC+uqZ3f7/v8czo4Z65/nVcD+rtkGqDSIT2UO9s0ieOZDmCRxMex0a0aH7JIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2vrM4deEfzzoocL24EZldFPUo9CgelADX8KrSwQtZ4=;
 b=RQKEr32VLT21gyR+1/u/m/8w0lMpA4F6nn2pL7GXZrKWRv2YK1NO9D25RkteDaEf9glsi9kj8Nndw0Y7YuRGz+vwMCx9cxL9nfccxtevXEjB95/5aXmAYGzDPD3Q3fi2HBByg8A85wItaISdx8+9Eq9UhDHmDVbqA+oiUe+TRqX232e3Q43dkSWlsXn5URniFlccO1gQ8c0McYx5HnLD0SbLcBZSuFhHdWDu6gl6GL6/gHDJKMQzh7J0qOtYasg0wJC3/qD85zQH530SPF0rrVFNn38LVyigbneXM6oxmm8L20EojMdJ6XQpXhTXV1/+3I6ftEm0kXkT5zX2CRMiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2vrM4deEfzzoocL24EZldFPUo9CgelADX8KrSwQtZ4=;
 b=L7q6StR0M5ZBbL/twHzR7pmQ+9Qnle+F2DBV/veq+r5LOJd1hWZq+AEKc8u7LI67ft8E6bVP08K7aPZWx2pzsTmAzBxqtp0oy0rNsOTCxfb3Z68/yQkQQt/1hYnsI1AFcBPIvZ6fVmuzNfvNeCSf6a/KQNHrzx45kyBewp9EleQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Wed, 30 Nov
 2022 03:40:19 +0000
Received: from AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee]) by AM6PR04MB6407.eurprd04.prod.outlook.com
 ([fe80::3222:ed58:9b36:beee%4]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 03:40:18 +0000
Message-ID: <5d1485d4-08d4-1e26-f597-b5fa6cc65ce6@nxp.com>
Date:   Wed, 30 Nov 2022 09:10:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [EXT] Re: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for
 sr1xx series chip
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org, axboe@kernel.dk,
        robh+dt@kernel.org, mb@lightnvm.io, ckeepax@opensource.cirrus.com,
        arnd@arndb.d, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
 <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
 <YyHq9OOKBLP2GEcc@kroah.com>
Content-Language: en-US
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
In-Reply-To: <YyHq9OOKBLP2GEcc@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6407.eurprd04.prod.outlook.com (2603:10a6:20b:d9::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6407:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: f3808c0d-91fa-47bb-b306-08dad28499e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cedyKJVmI01XwpakU8sp/vVLW3uwE9DwDL+JqTxoCt4oynMlB1phzWlnWcWSuPJjtKp5Yu1kgFMUX0xMnpnVtAY6S0lbKjXvmMsvl9LirpoxtWDXvBlaFspyyMrVEUS9LZ2qQ5POj5eaNyZLhUAlHRF2ut8l2BHTrf86/KW89uBA3S95k0kM63TUFrZ8WzXzMuCeBdRWe07afZ50f8sMv4fCbAO9pPgqcgCWzzB/EfF1D/4iDa0jrvXDdik6q4H/nhYQ/8D3LOXac1LDACWghZEQ/qMm3YaQfNDjWmrX5om3ECXDmyYZ7W14kuBQaA1WTo7Y3FCahmNyCB4XvmsjSg7F4h80tOCgehitd/weDIL8dX5ed+cNtMlxualOykL7Fpwax3P0GHKW+rYD+x3Bg9jOiND9VCV3VIzLVQo5roRWkk+SiwM2M9B/0wj3L3dE1Tfg5IqqYDbvizhVcMbzufEEzgn1+jsHtH/Ika4V1OyODmbVNBip2IDKreHMJe9BKddhMXUhe7d6XJjKpxPY8XRBugErVODjc8kapt8LK9IbIymiQs39GD2RnoaLayF1Ubw8e51fD8FEPncE/wxL1hbsLvud2TCEj0wJHjH2eJXZi2aCPZfr5Jew2YfjV6CX6W6NBnTrpttVTdeANyz1DgMyTlYthQCl0orROXERQb/j9SvGYrUr47+5+VFnBNmd9HZ00gpZyHKrliQDxjihQzw9aixUjVZOeDbox5YFXHl0SsaoViO3M9fwFDazOAH0dbH9KEprj07BVtikyFZSVfCzbaQZtsaeBOutaJdGqTbgPc1/cWVOh7cTIcvHx0jW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199015)(8936002)(5660300002)(36756003)(186003)(8676002)(66556008)(41300700001)(4326008)(66476007)(6506007)(6916009)(316002)(55236004)(38100700002)(83380400001)(2616005)(6666004)(6486002)(26005)(6512007)(86362001)(478600001)(7416002)(66946007)(53546011)(31696002)(52116002)(38350700002)(2906002)(31686004)(44832011)(32563001)(43740500002)(45980500001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmtaNXJadnMrRTduSTc3WmEwQW8vYmZQMFRVNEE0eDJ1Nm5sV1Q5dDJsL1Ru?=
 =?utf-8?B?SnBNTmlrVHFtcy9oVG8vVC9kMmdhdXYrbHNtWXFKTHdkeDdXY3d5MmppWmlM?=
 =?utf-8?B?bmh0Q3NpTnFTT2gzc0ZrTjVxWXhESy9UZE9VTXJEUmIrK3lULzNsa1dHVWpj?=
 =?utf-8?B?N29idUVnTFViNDIrRlFVSS9sTGhZZStwUXM4ZjRVN2x0L2ZRdFhsY1lpU215?=
 =?utf-8?B?MVNXclYrckErSTNndVU0MWZuTlBwM2NYUHVsdEZBeTF5NWc1Q1N0TXVMKyt3?=
 =?utf-8?B?MEREdFBIS2srOVFRKzcvdzNIWkpkbkFleUUzZFdHZVdPdmZjdG8veGFYNFRn?=
 =?utf-8?B?eVhlSW5KYTRrYmJtTnRDM2ZudkMvT1pvd2tqYnlpdFhVeVhESkw3ZlhHcGp1?=
 =?utf-8?B?UmN4MUlrZitJYWZGWGdNUU1SVTlieWx0aHhTMjcyNXhDcUN3Y3lMNGNkT1JX?=
 =?utf-8?B?SHcxSW5tZlZjdXVCYklxdzBYS3g3S0FlM0lwNHhJOUxUM2g3ZHBQb3BTdC9j?=
 =?utf-8?B?TmdqQTRBeWhWU2xQQmFxNTJKN05haCt6UXg2TVFqcFE4ZWphaVRmb1Erc3RY?=
 =?utf-8?B?TEo1NGptMm5oK2c3QWRib2ZlamRORkM2UDB6ckNWcWwySkFDcWRZNlVJUXpO?=
 =?utf-8?B?akh0ZzUyR2JrWldoUFFFcmN1aXpIMkhHY3pTTnoyd0xVcmJnT1hlVDNqMTE2?=
 =?utf-8?B?YmtwV3AwM0NScmovR1o4NEI0US9yeE8xNXdLcW9jbWFyS1BwODhsd3prWEJR?=
 =?utf-8?B?Vi93b0tybVVEdjFTV2o4NDduUU5nbmZDMEdmdFFGZCsvem1GK1Y1VmhuNTJW?=
 =?utf-8?B?T3dqRVJYYU1icmlDd2FsSDZWNHZKUEtvaEsydzBDRlk5aTN3T0tFSEp0N1hq?=
 =?utf-8?B?MnEzR1EwOTN1eU9KL2FZUzVpUjhHOXhJUS9NOC8rVGJDbmppSUZOeHFvS1ZB?=
 =?utf-8?B?VFJCa2ZMdUprUysrTWs0K294V1N6YkVTT3pkcWxQNkN3aDdXUE9LdHcvM01O?=
 =?utf-8?B?THZheG9waTdhUmFTQmg5cXBkSGVhMDVuSFBGMU8rRjZ0enZaeUlselhZRkov?=
 =?utf-8?B?NFAycm16MzNZOHFUbEVpNmZUbHZ1YkxXZ0Y4WG4yZmNvQVdqVTFOME10cXlS?=
 =?utf-8?B?US9pdHY5dVBOQ1lZTG5xNkdDcHZocURGU0hPcTROWERpaGNLK0FpWXQvYWd2?=
 =?utf-8?B?WjJrcFpyWnkzbzdtY3R5dnVNb0RuZW9kTHRyYkhMVVF1V1FzREtOOGhZTTht?=
 =?utf-8?B?dis5c2dLRFU2clZHZTFVUUZJVjNiaU9sNlR1TWVWTUtrYkU5eHMzWTh3MDNM?=
 =?utf-8?B?TXZFZjBNS094cXNkNk85UGM1WHhmVkJtTDU5NzVMRzFPT3EySkZDU24xV2pq?=
 =?utf-8?B?SURybVAvQ05YN0tEcVJ1TVFvb0Z3SVp4NTFrbUVBUE1RelE5UysxWTJCQXhl?=
 =?utf-8?B?eWljKzVDWmN6WEdwYjhUTVlMVDZRY01EcDdJeUI5TWtHbmRJWkY5clhJVDFx?=
 =?utf-8?B?SWRBYWJLMkhXUVUvUFc0dy9MQjNOTnJxdk5nSzZTZTk0UVJQbFBrSS96Vk9v?=
 =?utf-8?B?UVRiRHVjNGtYaUtQcHFjZjNXMmJaQlVuYnhqVlJyUElHTHBmbDhzaVBBajF3?=
 =?utf-8?B?SmVVMWs2a2ZGa0VRUkM0Qzlyd2ZzbHphNFRJazAvSk15KzBXVjAwYTFiSFVw?=
 =?utf-8?B?ckQ0YTZ5ek1qcGI3REY3UEpIY0R5NVg1S1Qyc1FUQUVRQ1pMU0M0SVdaWjZE?=
 =?utf-8?B?Y1dKRjNoNkVRSU5zeHJlT0xxaEhYTWZJeGovcGJoT2pWRGZ5YjRYR0FuMWdI?=
 =?utf-8?B?S0ozOWowSmNjSDZnZjdDZThuNFY4b25ZcWJURTduajhzQ3lQVDA5VkRwNW9Z?=
 =?utf-8?B?d0ZaazdPR1Q4TVRVdmRwNVZPZ3hIT3VlRG5tbG1LSlhXc243K00xdThWNWJq?=
 =?utf-8?B?VUhNaHM2R1FWZmRxa1JucENOR2FKM012RnRZUDFIdmZxUkNRQUZiamQvNU1W?=
 =?utf-8?B?ZTkySXZmZTJiYWEzS1NLdE9aS2NjRXBuT2JPbnlqQkp0emF0WGwxNG54Uitl?=
 =?utf-8?B?dzFPNDcraXFyYmNMemdDb0lYVkJMd3V0U3hGbjhTbkpLOU8wc3AxM3lZNHNW?=
 =?utf-8?B?R2l2TC9EZS9UY0pSSE1jUlhZNzVna1NCRlRaUTFTVTlkZGIvYmpwRGtYZGpC?=
 =?utf-8?B?UkE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3808c0d-91fa-47bb-b306-08dad28499e5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 03:40:18.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnjQ/E/yy+vtx6ZVOm7/Ik5tkqqtX2I10saObKd6xYLujI0EuQzC4LIlzzl1M3lp74Pvv1jNqLiIO8AMNACXFs2cRxMJKnacZkHt34hG6gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/14/2022 8:23 PM, Greg KH wrote:
> Caution: EXT Email
>
> On Wed, Sep 14, 2022 at 07:59:44PM +0530, Manjunatha Venkatesh wrote:
>> --- a/drivers/misc/Kconfig
>> +++ b/drivers/misc/Kconfig
>> @@ -471,6 +471,17 @@ config HISI_HIKEY_USB
>>          switching between the dual-role USB-C port and the USB-A host ports
>>          using only one USB controller.
>>
>> +config NXP_UWB
>> +    tristate "NXP UCI(Uwb Command Interface) protocol driver support"
>> +    depends on SPI
>> +    help
>> +      This option enables the UWB driver for NXP sr1xx device.
>> +      Such device supports UCI packet structure, FiRa compliant.
>> +
>> +      Say Y here to compile support for nxp-sr1xx into the kernel or
>> +      say M to compile it as a module. The module will be called
>> +      nxp-sr1xx.ko
> No tabs?
Will fix this in the next patch submission.
>> +
>>   config OPEN_DICE
>>        tristate "Open Profile for DICE driver"
>>        depends on OF_RESERVED_MEM
>> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
>> index 2be8542616dd..ee8ca32c66f6 100644
>> --- a/drivers/misc/Makefile
>> +++ b/drivers/misc/Makefile
>> @@ -60,4 +60,5 @@ obj-$(CONFIG_XILINX_SDFEC)  += xilinx_sdfec.o
>>   obj-$(CONFIG_HISI_HIKEY_USB) += hisi_hikey_usb.o
>>   obj-$(CONFIG_HI6421V600_IRQ) += hi6421v600-irq.o
>>   obj-$(CONFIG_OPEN_DICE)              += open-dice.o
>>   obj-$(CONFIG_VCPU_STALL_DETECTOR)    += vcpu_stall_detector.o
>> +obj-$(CONFIG_NXP_UWB)                += nxp-sr1xx.o
>> diff --git a/drivers/misc/nxp-sr1xx.c b/drivers/misc/nxp-sr1xx.c
>> new file mode 100644
>> index 000000000000..6ca9a2b54b86
>> --- /dev/null
>> +++ b/drivers/misc/nxp-sr1xx.c
>> @@ -0,0 +1,794 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> Please no.  If you really want to dual-license your Linux kernel code,
> that's fine, but I will insist that you get a signed-off-by from your
> corporate lawyer so that I know that they agree with this and are
> willing to handle all of the complex issues that this entails as it will
> require work on their side over time.
>
> If that's not worth bothering your lawyers over, please just stick with
> GPL as the only license.
Dual-license is signed-off by NXP corporate lawyer. Though, we would 
like to understand what complex issues which require work over the time?
>
>> +/*
>> + * Copyright 2018-2022 NXP.
>> + *
>> + * SPI driver for UWB SR1xx
>> + * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
>> + */
>> +
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/uaccess.h>
>> +
>> +#define SR1XX_MAGIC 0xEA
>> +#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
>> +#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
> You can't stick ioctl command definitions in a .c file that userspace
> never sees.  How are your userspace tools supposed to know what the
> ioctl is and how it is defined?
We will move ioctl command definitions into user space header file as 
part of our next patch submission.
> How was this ever tested and where is your userspace code that interacts
> with this code?
We will share the corresponding user space code soon,meanwhile can you 
please suggest how to share this user space code?
> thanks,
>
> greg k-h
