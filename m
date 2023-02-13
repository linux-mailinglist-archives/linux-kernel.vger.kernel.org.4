Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88C769428C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjBMKSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBMKSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:18:03 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31219ED7;
        Mon, 13 Feb 2023 02:18:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWaYp8nqdCAd2fyRAnEiy0r0Y3T+3zzG2/JzFaT12wm17b0kN9Cx9KnUU10wkVPm4kOu+2xottXPZ0Jm/YOZ0WI72uYSk9pYv0DKms30bb5a0k0PK5PLFgNIEA1WeySY15B6zxypFuBZ7d4OwPjpiBfY3zfFSPJSFvnUsGISvRjRuqd5L6IQ5+gD7kO9M9RhcN3wOjpRa2Sv/tZO55/0rlYIOJ2Wf52reMQJcJ0GPKvIS5UkaqbkTDw0kJNg6kpCyW1yhA1oYriFoTsqgchEKfDz+gMwB+biVL5N1pVtmO8cw6QS7PhZ/v+JXQdqx9UJ0JZw9YQlqGqVCRegfuemNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNu824C9kFZw728WUxNbUFpmV8ojDy/aFCImQiRJY3o=;
 b=Q9FmUOFOtv6xZ6oHskxH1ICSurghkcqQMPeMaf+fJi6astB/Cz4KLC5869GpckRR3LGTXMksMdyG+amnWCrpOBYA3SFvM6MIYSplOeRCoFwOYByl0ApbL3/LcUaS9wSfeV9AroGHUI1G+VcTOLiXdp32ZIe83+1G1xx9+4XvtQc1wMd9ZvNTELux/EMS2aHhEaJeYxGHtWbiooaiBDjF3xjmiY01HcB47bN5KnZSgS+2yQ36k61d6TvjZbZyarevWCX7/Omie1y4kguIE7aqiIvFEWFeyfe7J9XqE1Tq5f6yNMl8TDIGIZ93Dr31cY/h/7+rlzM9+F4beq97OLOBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNu824C9kFZw728WUxNbUFpmV8ojDy/aFCImQiRJY3o=;
 b=TBA81AMh2yhnANeI9DJAFt8nEzQ4oX3eKpOLd0S1DF8wvtyJytoQAOi9GC51Z8H9gAhZ3gGPC9DzuRex1Dhz6IQJZLUPkJURspa+uB96DKIi1NVQkJtn24IMFBR7I2vRAVDwYkrs1gBPb6Pp+UBzEIVhV8mW/RoyC2etD9k1SV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DB8PR04MB6956.eurprd04.prod.outlook.com (2603:10a6:10:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 10:17:57 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6086.022; Mon, 13 Feb 2023
 10:17:57 +0000
Message-ID: <73d34c86-7c31-6530-0915-aa470af5d9ca@nxp.com>
Date:   Mon, 13 Feb 2023 12:15:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in DDR
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230209063816.2782206-1-peng.fan@oss.nxp.com>
 <2c4997fa-973c-dee4-9b26-6b38a1ca4540@nxp.com>
 <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <DU0PR04MB9417A9B81B86FAC0A477063D88DC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0055.eurprd07.prod.outlook.com
 (2603:10a6:207:4::13) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DB8PR04MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: f041c4c6-518c-4f57-e94a-08db0dab93ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k+z96sb5iOzyA7G+vuqfb4A2ZdWhAQNZdZTFARc0xNboZqoKR0tPkflbMZuHSehlHRiLTadGSplPPuWuc9Wo598qtufF6n8PimNP5gGePT9Z0exvJEZ1wV084bPU7JTuXg3HIAzNyVYq+V8P8j81wDLAXxwjsDqepAFUDk3pbXTuq4KyagGHE2gd3Fv/3THmdxz4dltX+I+PSOxR/7DV4hed7zspH9+BCnYPD8UjKJapFRug+/kltKuJ8jVPAz9NHAEAG5sebKAJL49xlbs7vKznDg1MyGa8PWGYdZDnYAwMGWMd5cQb5YY+H7KRy9/7MlBG+ShIYzejDX0eoX3dc1/0mWR2hsutypR1a7on6yOEkmH32CSBvVauBq4QKd5YTVvSV/updNeI45+hceN/XVJ7ZDxuqKWJ0GpMq6LqZjWLsgyy9baWFtkmGlWwQJpLCaYI13lXjN9p9pRxqqL2uWJRf6WXvpTMooma9AmyM2YPkoZr2zNbhiezibpd+CAKpl8txmDRfZUE2wBcWLHvp5UlWGHv4ePl4vG7rKoqcgDyAOp56Jzy1IgCTnsdjQT9N6UnUzTsQ2esyQGZQklt7i+JUKv12KfkyH5RjsbgEPtM7oU2IPUSkuZorn5T8ryH8pQxqD5NnCXsXhAhhSHCPk47KIW3opCaOQrGPHgbC8c/7z+R7+gDIpIH+5dFNQKK85Wkr6ol4THq2BcDLD0aMMbgD4u7cy7lMTtMDBISKVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199018)(31686004)(4326008)(316002)(66476007)(8676002)(66556008)(66946007)(5660300002)(7416002)(8936002)(44832011)(41300700001)(36756003)(31696002)(86362001)(38100700002)(55236004)(6506007)(478600001)(53546011)(186003)(26005)(6512007)(6636002)(2906002)(6486002)(83380400001)(54906003)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhrTGdhZm5vQWwzOHovc0xBaVdQTkhKOElHUDRpK1FSeG5OQVNRRHhxUDlR?=
 =?utf-8?B?cDMyNmZjRmJDK2NFU0ZMTFJpdk5hVDlzMnFtVDNhSXZldlNzR1pOK2ZXZ29F?=
 =?utf-8?B?aHlJMUNNZ3RTQXpkdTRQTkpaS3RQNzgvTzFiSS9jdXRxQXZRQ09TVExIdFZR?=
 =?utf-8?B?UjlnRCtadXQ0MFVOV0FlRTRKYmZ6T25GamNvczl3VXZaQ3U5VzZWVVowa3Ju?=
 =?utf-8?B?bCtPeWR2aHJvODJaM0tLaVlYVFd2OXhPdmtkdGZ4TjMzQkRvdHJoenFrY0Zn?=
 =?utf-8?B?b1ZkL3pHSUk0TWdiYkdrWVRFRHZWUm5zdU00MkQwTG93UkFZT3JwbWdjOEdv?=
 =?utf-8?B?UDlya0VaZ2g2R211Q1ZDejJ1eTZwaWJ1a1JLbjVwYW1VSloyRVZ3M09jTXk5?=
 =?utf-8?B?UG11WHB3czFYazFXdkREcW0xTlpZSWM3VWtQMEc5ejQ5MGdiZGYzU25pemE3?=
 =?utf-8?B?NE1hRkxxZGd0TmFKNTl5Uktqd1M2UjA3MkZWZHdTdS9tb25TMW9RN20xd2tJ?=
 =?utf-8?B?a2hzUnI1U1d2WkhQdmpWaFI0RTFiSEswYm5POGovTjVVWDVaaGVmQmdaNXJP?=
 =?utf-8?B?aGlodjhJUHFJclh1L0F6cTVOOXg5cFp0L2ZXUTkwcjZqTTNTWjhLb0RjbFNz?=
 =?utf-8?B?MDZaeEFjWGc3SHZNcmU3dHZzWml4SkwxUDB3YW1YQ0RkQ1ZHUzJCdWxrWnRl?=
 =?utf-8?B?SUxFcnlQdVp3SVVxVXBoMTJreHVqUGVSNkt0cmNrcXN5SGRPTHZ2SS9lZ3Nj?=
 =?utf-8?B?WXRNczF0dWl2c0Jjd3RVNmEwKzFFUkpxRy9PRk9TVDFQc2ZvRXlNY3dlbENw?=
 =?utf-8?B?N0ozT2FMRXk1U1JIMGNuejd6N29CVm9wdm84bzdDL3lKT01KREszM0dnTURu?=
 =?utf-8?B?a3NETVNrWjVVQTQ1RlcrSkFQRUtjeVNnTCtaYzBLU0d4STA2NTIvd040Uldq?=
 =?utf-8?B?OXFUVUtSUDU4amJGKzlIcmJwOGZwUVFCVEVRM0hPZGxlVGc0RStLN2hBUldD?=
 =?utf-8?B?YldBVUZ1KzRDdFQ4b01DNUc4ZHd4U2R5aWlEbW1XUmdwT1E1cGVRUk1JUUIv?=
 =?utf-8?B?ZDlDZEJxekhucVNHbElRaDV1VVlvL1ZCeWpNY1hoS1NHbTVudzhkbHdwaVpS?=
 =?utf-8?B?ZVAyQWxCa2VJTnhRWis3ckdSU1lnSm5tQUhONGY3NEIrSnBwWTE2Zk5laEFu?=
 =?utf-8?B?cWZvbGVHRnVpby9NMFBrelRRR1cySHhZaUI2bG5ldkdoTUo1NUp0YlZiUWtS?=
 =?utf-8?B?R2lXTUdhNGdoTWowdFdleEtiQnRDNUFDdEFEM0FFdnIwMkwrUFRJMWQ0bzlG?=
 =?utf-8?B?OXplbHJ5UGZBdDRncGF0UDF6S0tiM3JJeUk1alFFNTFubXJKUmVybkZxN0JN?=
 =?utf-8?B?MWt0WGkyQmdGemZDOFVLVnBTaCtXUU1ZY01TZmNxK29hR0huTnFaNlBFR2NI?=
 =?utf-8?B?dDFIVnZFUHE1azAzekFDczFZRzBNeGM3ZEdyU3R6UFE1Q3oyeHBMbWlVZ1lj?=
 =?utf-8?B?Nk92SnRESjNJL3lGMTI2TmZjT3YxckdTSHliaUcyV25xNm1yVVVEYmRTM3Fp?=
 =?utf-8?B?RzlxS2pRQWxDZnRPWjhPN2NWNUljWWVxQ2d6UXZDQThFU29mWndUMExXQzQx?=
 =?utf-8?B?VkJOdXlKWWk5U1Q1SVNLZ1EvaTNDaURzK1BPTWIyTzNQQ1FqaUtHdUJRak1x?=
 =?utf-8?B?dTFCaUtGdTVhRHFUc2x3L29ncnYzTkl6MnNmNjQ5TWdsR3FqK01QWi9Ya1Vh?=
 =?utf-8?B?STlaUXNCazlEVk5OcUZ0UHFSZ3d1eGNRbGlRY0tRR2JUREVwWEpQUGRVbW5q?=
 =?utf-8?B?ZXgzVmVPOE85bS9iaTU3QXRwYkRWK25leTJnd2g4K3NSNTNDTU9ZYkF3ZFdH?=
 =?utf-8?B?T1hDOCtjcGRrUzlidjJkdFVLdUNUMGFRT0lDYjliSURiaHpFT1hsVXlYUFp2?=
 =?utf-8?B?dnhpWkJEOEU4M2tiNzJQYU1LK0FJZ0NDU21kcFRPejNsMmhQRlo0R2NMN2tD?=
 =?utf-8?B?U1pHb3cyTndMREhLWCtaWVQ0eG42QmxxSWFJNllVYTI4eEF4bExNRTRiMGs5?=
 =?utf-8?B?RWZTa2dOSGJMOFJTaytzQlJGcE9udjIxbUJURGhOc2ZsUkF4WmQwTG9Qd050?=
 =?utf-8?B?WkhpeFhGeVlwZk9ob3lRenh6K0V5c2xRLzV1RmRUN1lYamhGMmsvcDVxdXRT?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f041c4c6-518c-4f57-e94a-08db0dab93ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 10:17:57.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xYLOZcGU76vgjbVMoIhPpBTIK9VqwX/HDJPDplKtoT4fik0ynt5NazxoyQkXlXdiyAxFa4PYaRllR3xFSgQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6956
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/2023 9:43 AM, Peng Fan wrote:
> Hi Iuliana,
>
>> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support firmware in
>> DDR
>>
>>
>> On 2/9/2023 8:38 AM, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> V3:
>>>
>>>    Daniel, Iuliana
>>>
>>>      Please help review this patchset per Mathieu's comments.
>>>
>>>    Thanks,
>>>    Peng.
>>>
>>>    Move patch 3 in v2 to 1st patch in v3 and add Fixes tag Per Daniel
>>>    IMX_RPROC_ANY in patch 3 Per Mathieu
>>>    Update comment and commit log in patch 5, 6.
>>>
>>>    NXP SDK provides ".interrupts" section, but I am not sure how others
>>>    build the firmware. So I still keep patch 6 as v2, return bootaddr
>>>    if there is no ".interrupts" section.
>>>
>>> V2:
>>>    patch 4 is introduced for sparse check warning fix
>>>
>>> This pachset is to support i.MX8M and i.MX93 Cortex-M core firmware
>>> could be in DDR, not just the default TCM.
>>>
>>> i.MX8M needs stack/pc value be stored in TCML entry address[0,4], the
>>> initial value could be got from firmware first section ".interrupts".
>>> i.MX93 is a bit different, it just needs the address of .interrupts
>>> section. NXP SDK always has .interrupts section.
>>>
>>> So first we need find the .interrupts section from firmware, so patch
>>> 1 is to reuse the code of find_table to introduce a new API
>>> rproc_elf_find_shdr to find shdr, the it could reused by i.MX driver.
>>>
>>> Patch 2 is introduce devtype for i.MX8M/93
>>>
>>> Although patch 3 is correct the mapping, but this area was never used
>>> by NXP SW team, we directly use the DDR region, not the alias region.
>>> Since this patchset is first to support firmware in DDR, mark this
>>> patch as a fix does not make much sense.
>>>
>>> patch 4 and 5 is support i.MX8M/93 firmware in DDR with parsing
>>> .interrupts section. Detailed information in each patch commit message.
>>>
>>> Patches were tested on i.MX8MQ-EVK i.MX8MP-EVK i.MX93-11x11-EVK
>> If one can build their firmware as they want, then the .interrupt section can
>> also be called differently.
>> I don't think is a good idea to base all your implementation on this
>> assumption.
>>
>> It's clear there's a limitation when linking firmware in DDR, so this should be
>> well documented so one can compile their firmware and put the needed
>> section (interrupt as we call it in NXP SDK) always in TCML - independently
>> where the other section go.
> Ok, so .interrupt section should be a must in elf file if I understand correctly.
>
> I could add a check in V4 that if .interrupt section is not there, driver will report
> failure.
>
> How do you think?

Peng, I stand by my opinion that the limitation of linking firmware in 
DDR should be documented in an Application Note, or maybe there are 
other documents where how to use imx_rproc is explained.

The implementation based on the .interrupt section is not robust.
Maybe a user linked his firmware correctly in TCML, but the section is 
not called .interrupt so the firmware loading will work.

So, instead of using the section name, you should use the address.

First, check whether there is a section linked to TCML.
If there is none, check for section name - as you did.
If there is no section called .interrupt, give an error message.

For all the above options please add comments in code, explaining each step.

