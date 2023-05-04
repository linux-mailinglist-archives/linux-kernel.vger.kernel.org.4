Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFD6F6869
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjEDJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjEDJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:38:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2030.outbound.protection.outlook.com [40.92.52.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B64C3C;
        Thu,  4 May 2023 02:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8mdOEFR0/W6iQ5gPBK3MTNFf+SCXfTNccQQ/Y7WUr5Dk+x/xj0sQ+uG+0sj6xAKWW394lzqLkMrrmaFNCg3P6fRulwrPST42zUoPVi7vlTpTv8E+GI5mizDpCiNYhMNPCVSq4cYFv5z/9uHdw0NSBt15FibxIVh/qqXnb5dHg8za17GXm//1/G2UDMgZ0pzeNVyvi7L6qtbx4F9mHYvubp1JTuBEoKSQOjWvYK3QKJN3QpESfgOjZdLM6cvh9LYpxt9NFXTGZs9Zv9wDzvDfI5H1hylKPN2zDArIDeO+xTxcv42WUxnrq7Ztkec2D/YnGCPOkdT1kRGkLqqu7/Hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDu6/hvZ8EugZyWl47jJJCxRGxvz9+1ihkBniaNMi+I=;
 b=J9aoGb6Q7aNIwCWzNHINFlnkFoAYpBAj7vPXOprkvukiEMvGq/QvgBMLr3xhl71CMp6vUfw75G2fVUOAmqQOifiWVnz88WInTd2orDrH2ETZ+/Sk05rXlwqdMvBtWtUn1x+xJ/zNcZujFGAZyxtTZPIrPNGkZy+tzBPXo2PdpSGrj233Y0YKQqGam7AwwJ0CnK+8Vyhsm63VVO+Zl14XrXxjghH7lr6YPZidf1T835INMeKFMtD+RfcT2LWyBaxd2b7fNl9UV01zOO6jyQG4/d1H0FBpFD3yHphfKztbo/4vDpSbxOcpm7hoQUY3KY9waqG3oJjr7Sw2e4bwQhLpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDu6/hvZ8EugZyWl47jJJCxRGxvz9+1ihkBniaNMi+I=;
 b=fH39mC+qCs1ZljPVJ3zIUek33xmJw1mVjOHg7/oLWvblZ8OPSQizbI1qZL0ETrke1WilvEkNbcDIY+BcMEP7+BPO6sLdbYsyCVJ45VI6p4vRcezMc6FA2I64GH+gmL2Qg/0bOJBEycGjtDBxNavKp7D42fopzJWMCOlfDhQKNbhiEP1g7JIkdXulsN3opV45BHLR88bzmNYvbZ+VlFnAE3SAm5NIEMvq7t1+eMTnAQzldDr8Cu5JKfxUXvwiRN2Tdz42cgH5VYrRjPu/VyVZOZ2DZl0/DZihDySrq7/xfbLMzeUPbqApGoWbYem5v/EbWGKC4baUyprfMrTO5g3YZg==
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 (2603:1096:820:9a::12) by SG2PR01MB4146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1c5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Thu, 4 May
 2023 09:37:56 +0000
Received: from KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::1ff1:2f4e:bc0:1ba9]) by KL1PR01MB5448.apcprd01.prod.exchangelabs.com
 ([fe80::1ff1:2f4e:bc0:1ba9%3]) with mapi id 15.20.6363.021; Thu, 4 May 2023
 09:37:56 +0000
Message-ID: <KL1PR01MB544880BE86B3890E33609C5AE66D9@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
Date:   Thu, 4 May 2023 17:36:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Yan Wang <rk.code@outlook.com>
Subject: Re: [PATCH v2] gpio: gpiolib: clear the array_info's memory space
To:     andy.shevchenko@gmail.com
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <202304232146.7M89pwCz-lkp@intel.com>
 <KL1PR01MB5448327326B6EDA8001AF714E6669@KL1PR01MB5448.apcprd01.prod.exchangelabs.com>
 <ZEk4YNQeYohEwnSg@surfacebook>
In-Reply-To: <ZEk4YNQeYohEwnSg@surfacebook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [27K/tgPu9m/XB/OBeffOP7A8oZxuBelPiclkGQ+Vh0E=]
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To KL1PR01MB5448.apcprd01.prod.exchangelabs.com (2603:1096:820:9a::12)
X-Microsoft-Original-Message-ID: <66a2a310-2443-24d2-5701-4366cb909a1d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB5448:EE_|SG2PR01MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: e3321b63-e94d-4c8e-fe67-08db4c833cb8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0WwLG7F1U7gfoI6ws0PzNq+1mRXAHoJXe3ugsOn8WYJYQFFh0I8AiJfVR1WreLXeNtoL0TXjv1U10p1KfnT24+XH8a3BRH+k0m0n3R4pcUzh8zllte42g7UOtfAlhAdjOVCsC6El4Z+U6e6a18ulwkMf0A5HWYkow17M6NkPaKICMqLH/0BmUWYKaDEjHZY8P6KIHFa8Xf8w0dAH303zSwDXR4Cnxu+c+HZEZPI9L+XUew/mzeDMTe7ChYh+M0Mki65TDJ3T+mQBE8KrchZyUjMNkSBHHXvuE7o/F7aZQQNgnY9V7h0EOUoMNesI4WWMLxD6WfMGnAgc7H7ncTC3LtT0Vitfzyeqc7iOWQIFS5I120ZPr/h/EZ/lM+gr6fjhK7Uj4I9dxLhlTVYs4ju5Y0vX+oLJ97UCjgg5AkY+28gwLkhIKaNXVdPnQ4gF60o1/IcxaJtHRQhsMrZX0lIjyh/ohuMXwdPTQBDvp4/ukH/ic3fJ8FyrHzMs3lQCQ41FdPWkdtDXZ4y3eRKSMKDpgTHGngFUhop47VzbVkcP7KXleAfoyhuwdmmPd4NMrwnqpTjuRHMn0Q7k15tsel6oBIfWOuVQ9zXK2UxmpQM8itItYgEe4vpwGiq0djcJFPY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9ESTMyQlFGYVgwVmNNYUhKQ2VxWENIcVJ5eUZ3REphQ2tXRndjbFNtaFRT?=
 =?utf-8?B?KzFxem9qZEhWdWt3S3UwMWs0RnVFOVY4cWM0aDZWcEd3UkxNb2lKSVZKV2RR?=
 =?utf-8?B?OGF0VmFNMlpkbTBnSy9Kb1Y0eGFvRlRRenpoc0NIN0xlSDJpeTQxVC9ORDJP?=
 =?utf-8?B?TEVxcnlmYlgvYjUwdWZTalN3ZXR5OVhGOStvUjlQeSttY29IMEd2YTNkbkc4?=
 =?utf-8?B?WEYxamk1c3kyTEhRQ0N4ZE5DbnZ4MnphanFyZ2hodFJiM3UzRUtXRjQ4eTR6?=
 =?utf-8?B?SnRBdjBWaDk5MmthTU0weGZHLzlmUjNBSWpqaDhVYjFuYVl5UFZHNGdkd3R6?=
 =?utf-8?B?S0pvRzBMYVNRdXUvb29NUFNNZFl4ZlExVjhuZXFpYjNySU1KN2NjSndTMTg0?=
 =?utf-8?B?TlYwSHpTOGIxT2R0V3N3Q3BmTkZaWFN3OGIzOEN5ZlFlRytWRjVWNlZZTjRr?=
 =?utf-8?B?NHh5T21lRW9HejI0ZmM0SWo3SUhSd2FEUC9FYmpRYUU3a0RWc0NSZys0YVk4?=
 =?utf-8?B?WTVML0E5Q2VZbUdtMzB1Rnc4Qkw4enhROVhBc2pIZ3lCekVBb0oyOU8vL0tV?=
 =?utf-8?B?MS9TK2haTzNhbjFoS0R0ek5rbDJ2d3NkbVQ2aW0wYmkrZGNISm9XSVhCbkZ4?=
 =?utf-8?B?eUJUWjZSZkVUUGlzM1NyL2JGSG1wejBPeDJFN0VaRXUrd1c4UERybUwxeDkx?=
 =?utf-8?B?N0dOMExWblpyWUg0dzRscGdLSit4eUNyMjFKMGdGakZuVmtTdHJZNVZzMEll?=
 =?utf-8?B?S2p3OC9mRTZXRHp2anF3Z05BUGZoOXhMOTFRQnBYVVBlOUZ1YXV1ekQwSVlM?=
 =?utf-8?B?bHBsNDEvQXdtUHp5S0M4dUdtZ2VBNU8xa3NOUTk0L1RhakdybE1EV2g2QWlK?=
 =?utf-8?B?S3lYVjJCMGxpb1VYVzVpZms0M0dVRjVQUVpHMXBoUUozUEJGTTBGWGlGb1RB?=
 =?utf-8?B?VzhYWUkyWENjTFpiVlBRT0g5YVBwTHIvRnkrVjJTUjE3OHhKUnpHZHhvR25u?=
 =?utf-8?B?Qk02ZDYrYW9HaTBpdkd6NDI2alZjMHU1VlF3eU1GQmxDdkhZSG04MnFPbHdC?=
 =?utf-8?B?TVlRNlRYaEdQRXZNS25ybzFCdjl0K3M0NmxOU2p0MHBtdXc5cXREdkt4b2ZZ?=
 =?utf-8?B?RUt2Vy9jZ2hlUmtxYUtuQzlJcU9ySW5aM0xRV2pPTFBYRUNReWNnSzJFQ1RQ?=
 =?utf-8?B?QjNsZDV3VHR6WkFPQVQ3K0tiejljdzROUHRvSzhxYVEzeUYwN2RQVmtuVnFW?=
 =?utf-8?B?MnA2UkQ0WnRpZkYweTB2RFlLdXp6cmlGYUtIMmRia1lsOHg2WlBiQ1dzdzhN?=
 =?utf-8?B?RFZ4enUrOVhpNW9UT0tSU3lnSnBCUkx1cC8vdnhiNGZ1c20xNVZmNnNrM1Fu?=
 =?utf-8?B?SFNGRElzQlEwYzRXdzZRb2pZYTJFajdpNm0vWXNEbjF5dUdob0tlaldnSGUy?=
 =?utf-8?B?UnFOZnVQbVNVanRIVHh5anE4b2RpK0dxd2hLZjhPalM2c21GTWRPa0h3WFJw?=
 =?utf-8?B?cTVDbnRwbVpqTUJnaGMyQ1hBaWhSeWd4azF4YjRWSkZaK21LY0d0cHpxVFcr?=
 =?utf-8?B?amZsK0RBcEhMWnh2Wm00d0I1RTVyci9BRWF2SGlxMUtKc3NGSitqa0ZyMnQ1?=
 =?utf-8?B?MitaMlkva2VzOTF1UkFUU1pXM3hOVHc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3321b63-e94d-4c8e-fe67-08db4c833cb8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB5448.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 09:37:56.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB4146
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

First scan pin-0 of gpio1,its index and hardware number are 0,

if (descs->ndescs == 0 && gpio_chip_hwgpio(desc) == 0) {
     ...
     descs->info = array_info.
}

Then scan pin-10 , its index is 1 ,but hardware number is 10 .

if (gpio_chip_hwgpio(desc) != descs->ndescs) {
     array_info = NULL;
}
just set array_info = NULL, Should the array_info point to memory be 
cleared ?

if not cleared ,I use the gpiod_set_array_value_cansleep() to pull up or 
down pin-10 is invalid.

I found that the set_mask and get_mask vlaues of descs->info are seted 
0x03 in gpiod_get_array(),
I think 0x401 is their correct value.

Thank you for review.
>> if (bitmap_full(array_info->get_mask, descs->ndescs)) {
>> + /*clear descs->info*/
>> + memset(array_info, 0, sizeof(struct gpio_array));
>> array_info = NULL;
> ...
>
>> }


