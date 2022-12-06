Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8508644255
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiLFLoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiLFLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:44:11 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2092.outbound.protection.outlook.com [40.107.105.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E3D1A21E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:44:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8yM4xkxGHjXmyBp+S+li7VNFBQAvjRnCNr/crXERXJ4xZtVOY3wFeRLU2qqP8KFYuDcnJ8uWo+jV/L623FUiGJ5dCJFVeAZE7J7ZM6zaGuzY+Kaa6n2J9yPME10FCWXi2FEvb1fpsURlpgWI5p/n5Av0yOtM02BKKEyeDW9MH3LwslUqLvYQojIsMwNrSjvy16Lfn6nNWjNQD6IzbuV0kZclcpxD6eOB9TA4b1Y4ykcaeqi30HTDOjgTxNh22WzcWKn5jeeqqKRgGbUh8t8i+B81+Y7a8xRC77nI6p8iNp2cJ072E6K/CeUO1I+0tVLpnSEVbdu6/poDY4Zgb043g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mncZusRpJfjE8U6djG8LNTmCr+PIOBh48NUMisx/uJA=;
 b=XamC0obIEaUPxdz7yE9CO17GA6g6IUKJ1MyznH3bGxbhQ42pjgxvNak9vnIOy8NUVB9uiXn5yBz+efeT1Rxwo0AO5MCpyhJ72WmNVPMWwM4vO6old9A4/UsJu+6aIvwN+HWXL1VAzxU3jjXvGMK9uoIyjPGpC/G5STZO/y4zBCEbuejVHM136m/mVj8nRxgCj4YPrmCk6ovyR0Lk6HjNXb+K0q8/jsuVtAbRbKGquRwgTW7Kzc0EATe1VykjVmP0yxoevtPfGrZhALekYl21A6kEyGJB/9fkpIzkAA7TbWlb7ojHNwAXmw+3MlBA8QKhso605C9hPEwtbF8KeUrjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mncZusRpJfjE8U6djG8LNTmCr+PIOBh48NUMisx/uJA=;
 b=Y9Q8IcR91S/Syp0D4E4E5BJxHPli/EWJY3w099l4sg0t4BqTbxyLmWnColDb6iND6VVCGtaIdKXo6yM5+PqVXjNHRDHZ2l46Ode4a1pd9PaCnFS8LeZ07xbG9MM2zf0xCdjy6Qx6bLX1LNmGtp8ZuY0QJNoPj6SI60DwuMYQW9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PR3PR10MB3833.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:44:04 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%6]) with mapi id 15.20.5880.013; Tue, 6 Dec 2022
 11:44:04 +0000
Message-ID: <10714595-2edf-838a-886b-30feac07ea16@kontron.de>
Date:   Tue, 6 Dec 2022 12:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Linux: SPI: add Gigadevice part #
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vlim <vlim@gigadevice.com>
Cc:     Michael Walle <michael@walle.cc>,
        Victor Lim <victorswlim@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikhyat.goyal@amd.com" <vikhyat.goyal@amd.com>,
        "amit.kumar-mahapatra@amd.com" <amit.kumar-mahapatra@amd.com>,
        "alejandro.carmona@amd.com" <alejandro.carmona@amd.com>
References: <20221204080000.4100-1-vlim@gigadevice.com>
 <dee37d18f8de5af7d07388031fc08571@walle.cc>
 <TY0PR06MB5658B73E2F22472D0AF48BDBBB1B9@TY0PR06MB5658.apcprd06.prod.outlook.com>
 <20221206091846.02f6396f@xps-13>
 <208ffab6-a20b-c6f0-7ea7-cb258a7c894c@kontron.de>
In-Reply-To: <208ffab6-a20b-c6f0-7ea7-cb258a7c894c@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0018.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::23) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PR3PR10MB3833:EE_
X-MS-Office365-Filtering-Correlation-Id: a592da87-954c-40e8-911c-08dad77f2d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mgWNmi74VSMiF16Maw6uQqRacE49qfeodxDGbkwi9j9nMqQpSgyn311aXoZJZ0FYeXRfBbCtd/Aud1sdOoPvwaRwQrBVtTbsTYdUCvpc0X9IXFKtCMj2EJ4plTlogDUnnrCf4vonbOQSizYOVVyKDXuqmyTH8b2KRSAnUORrJ8j5cbnU5LAGqTYIABuhKIeDlIiCqIpn+WfQLrg9LservGwNG+ty5A5L5MnNH7NIL7+nzCE5UzVE0uzbQUMsI1dPnBtgTGPiC9VMKeeG5xrFHWq3R3pEDKAkydMPBWj6WvIopgSsW+7ADrb0EBN9Nbs2UbAEF0BLtJ0TgZJ/G6AqFXtyHgc6LbjtGkD/RKh6ohtbmdkVGQsv/SP8H1jryCSLqLzfcvfKMMXj2SY8mPvAaMRVpMLKMEFTY25BYiUjGutLrMwysgb90pJO1FD53Fhatz4BsLQ4VwIxXS5Un+JH2pad1w+S9dW8awZBiPF6uTk3KMn26is4SEKUDpnTGQWqiHjx9B/KhXbY9XuU6Rs81aIvOgLRv170rGXGN4jyr1SvczScMTuO2DfTR3H0CPiOzeetnGaAcuObezUlQuy7ctcsFFXjF3dpMhYBiwEuNefiTgt383qXPk8BSM59dlvaz3H8j8jht52ygIn7pCiUhtA9yi2nZU3pkUF58uffPyrk8AYovCwari+EOyDhpOKmM6kJqlXWBufV7mXpC6+uv8YlumB45vorEKQ/STfiX8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36756003)(38100700002)(31696002)(86362001)(8936002)(41300700001)(44832011)(2906002)(4326008)(7416002)(5660300002)(478600001)(316002)(66556008)(66946007)(66476007)(6486002)(110136005)(2616005)(31686004)(54906003)(8676002)(6506007)(186003)(26005)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1BTkZEcUpsRGVjcGlId2JIUURFMG5QKzR4QnhwMkxUemVlQ2VyVnhCeGZ0?=
 =?utf-8?B?RjBGcFJpTm5zZWVBaE50TG5XWnphRnBob3dlZGlMTkFsY0tlekpYWEtrL25R?=
 =?utf-8?B?VlczRmJvNTBaRjNyVlZiM1N5VkttZ01zQks3UzMrRmxCQkFuNk90RnFzWXFp?=
 =?utf-8?B?NXAxS3hVQ1BORFVJK1ZtQXN5bm9vN0NxeDBnbFVnTDVSQndFLzV5aERsYnVh?=
 =?utf-8?B?MFF3UHF4TENSOFRoNGVGM0xzQUlGZjFCdHR0K1FBbTRIRHhGMnppY08wZVVw?=
 =?utf-8?B?aFhtYnlkdWhmcCtLVTBzVEMxbm5scjlzQzRVeDVKc2F4aGZrTjJ1R3I0ZGxF?=
 =?utf-8?B?b0YwTVZCNkkvOE8vdEtWNkNRZ2hBOVo0dERVTVVsVXVjSUl1SVdudEZKZDJX?=
 =?utf-8?B?L3VXYld3amtWMmU0bjFtKzFodnhXMEJxb1BDRTV3QUVTQStYK0ZZeTAvTmRC?=
 =?utf-8?B?RDVwcDdnbGY2dlVEQ0Y0Q2ZjRFhWL3ByVE9EUTQvZkphK21nNWgwRDN2SlNE?=
 =?utf-8?B?VzRLYnpBZXdoNS95aWFLc0ZxR0dOV2NuZG1DVHNmNDdpTUgycytNd1hnb3NV?=
 =?utf-8?B?Mm9jY2dMeUNxQVNDVmxXZDFWSmE0UGtvY1dRSm13T1NUWTRldHVGWGUvY2pk?=
 =?utf-8?B?VlAvY213Rk9oUGxzbVczVnhuRXlUSzZ0SUJybCthRUx2N0doRytHeFRORUU5?=
 =?utf-8?B?U1c2N1g5S0U5WFl2ZnUvcDFNclk3RHdFL21jMjF2aVl1b1VsRjh1N0s0Ymhj?=
 =?utf-8?B?T1g1NGRyL1BUdHJMVlprbWRQSlVYSWc2b2FZU2VoWmYzeHJpZUkxZlE5ZnN3?=
 =?utf-8?B?RDRDa3E3V2J0WkFqZDM1WUoyRCtPOUY4WWhGa1VsQ0kxbWRnbGxaclNaOStp?=
 =?utf-8?B?UkpNd1BwUWs1MXhFK3UvMmRQNkswTUxjd2IwaTduSUFvZ04zbFhORTJNcDNs?=
 =?utf-8?B?ZGF5ZUovajM0ZEU2Z3Y1NHliK05obVAzM3FVcE9IempSbnFOajd6Ny9XdHZr?=
 =?utf-8?B?U1dBZ2IwYVQ3MGVDZDd3Sy9kcS9mZWM4cEk0TUpTZmFFYjcwMENiUDNqMzcr?=
 =?utf-8?B?L24vR3pQTndlalJFc3RCSWJvTjJPKzBzUUtxYTZvenVyaDJHSWdNNlhVb1pF?=
 =?utf-8?B?Nkh5NHl1aTVBSGtzTitMVTExQ1MxY0pieEFSN1R1TkJUaXExZGNUc3hscnFN?=
 =?utf-8?B?TlJBbnNOb2N1dUxxcmcyMWxOd3dKRXFtVDBNTGpNUkxMN2MwOWV3SVpmRjlT?=
 =?utf-8?B?U0JDdkdEdXRrZjNrdExWbWM3SEtxbm1IV0hzdHEzM1dvdEdmdmdPU091NW5T?=
 =?utf-8?B?OHVrTHY1eEJ6MUgvOTgxZjFpWmdTNTRheXNaZE9BZ25OeFE2SUhwLzNmWXlj?=
 =?utf-8?B?bjBOTG4vbngvWEgyZ2xQWXBPWi9xSlhIZlcvN2lSNWlsSmhEOVhDMEFXS3VG?=
 =?utf-8?B?VUpBS1FoV0R1M0RmUTJCdEVibTJqcU54V2RseXNibll6NVMxNEJEV080TThT?=
 =?utf-8?B?Q2JxRFRwd0owNGNieEo4NlZ2MEx5UzNINHJPQTZuZUVvWFZGVmVrbXU1V0ls?=
 =?utf-8?B?SG95Wm1TVXBNNWNOdGpOekxSZU5UaCtsMWx2YjdPaDhtclJGMVN5cERNQitM?=
 =?utf-8?B?TG8yMG5xZW9jbytDLzlEc1hFNW9YV3pGL0lNQUlMandZSjg3WHNxZm5xQXlI?=
 =?utf-8?B?QlBkaHFIa3RQWFhRQzE3L1J6R1BrWWhpVWNrQUE2WUNDNm1qNlJTYkYxU0Qx?=
 =?utf-8?B?eFlJd0JKZVJldXo4ZWdPUitLR25uQW5uZ1JZbHFIazVmekF3bCsvQzgyb2pZ?=
 =?utf-8?B?ZlE2TDJDUFV1ajE4OGpsTTAzOHpYMWRoWkc1M1E0MldUM2dIR1dIeGVJWmxo?=
 =?utf-8?B?VVBmQjNUY0NMcVZiNk5HT2VzbUZWR05WZjFBWVQwZUhha2pHMnhPQnBPUlU0?=
 =?utf-8?B?SEpwSEZwUWJOZmJ4aVBMVENYTklJcUtlQVZScWF1N1ZVVlRHMUMwTjFqbkhJ?=
 =?utf-8?B?ak9FOWpBWEVkUlpDVDN2T1J2UGVyaUY1dEZwejljSC8zSVZTcnhaekhveHlG?=
 =?utf-8?B?NFBDY3pkYjBrZ1p3Q1ZyYjJzSWZNVTBzQ1c5YlhSbG9WTHh6VDF4K2tqRFVt?=
 =?utf-8?B?U1hOczV4a1RBLzBtVHNhZTRyZ1cvKzhqdkozU0Q2QWxjanl0eXIzMlBWVUpl?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a592da87-954c-40e8-911c-08dad77f2d44
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 11:44:04.7571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8g/mIGDUckA083wln1iHttSiQtrsAFlQ+ddZVZA1WecnPgBjFB0vwCkoZ0cCz7IIIb3AyF4aBNJWBF+BMApzQgOFL2VAyPn/mpSbaJX8fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3833
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.12.22 12:37, Frieder Schrempf wrote:
> On 06.12.22 09:18, Miquel Raynal wrote:
>> Hi Vlim,
>>
>> vlim@gigadevice.com wrote on Tue, 6 Dec 2022 01:27:13 +0000:
>>
>>> Hi, Michael,
>>>
>>> I will redo the patch following this doc.
>>> At the meantime, can you point out a few mistakes that I am making so that I can correct it in the next submit.
>>
>> Here are a few:
>> - The title is wrong (git log --oneline <file> for hints)
>> - The commit log is useless
>> - Don't make unrelated changes in your commit, one change == one commit
>> - Don't change how the code looks like for no reason or justification
>>
>> And please avoid top posting when answering.
> 
> Here are some more:
> 
> * sending (almost) the same wrong patch again ignoring feedback from
> maintainers
> * not using version prefixes in your subject line (PATCH v2: ...)

The example should be like this of course: [PATCH v2] ...

> * not adding a changelog to your patch
> * keeping your replies off the mailing list (probably your @gigadevice
> address is not subscribed!?)
