Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B677105E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbjEYHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEYHEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:04:48 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2127.outbound.protection.outlook.com [40.107.15.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAAD1BC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:04:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0n3nOsZydIN83EC8Ods4ZWea4vjWqR6tMxpQ6CcevZU29XugpGcROoGNq5NsoiUuGXE569KdfL4PyBRohzOV7MOaCZXjo7Vgsc67vZ4d5kxwcrzRboIYP4BX22rZ6hh9v5/BAAQTiUfMDjFjCbso4qaQvYuBIibLch63LPHzh6wWz+7o+5AJ+MsY7WSgmNQkIZMNPU//3QJSUpwXSPCpxsATNEJjSnkfwiV1w0JhvA/DRdnyDtT3INvrh0/hIe0zj/r9u7NyZ4g2tKNhoXRRLehSwJbHtMwBHE8KUu5FEtC6HXcuCCCXbKENGtNLUS53AI0ikzQocEXV9OhTKSM8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXTmQfbDdG/1Ha+XotD1dZyxHT/GRRBjv8hGy0ZHB1k=;
 b=LoTSTbcjqSD94vZz3zs7j+jutM2gQ3JDjmKnr+nmS5CbYW30Kaite91m+z4LJULRLKChdw97ZmHJ1Tv3+neUqErS2Y30NxCaM5Lfsu/TlSIFib7EoqP6WpLsvk5tkM9AHmDeAsyYYb2yvxPGoyIMsVLwEL6+JUXr1DTifZuxBAvt4+bWeD4x/ugOon5CcaznBojSYMIIV8M66z22jHEBa047/sE2N/PwJxFGQtJu2LpQXJPEQ1d5f9Nvqg2pFtbG6klcLxJPtI3GVa3zTkyHL+EUJcV+vCY/NXD92ZJnV1tGGQJy5u1iOBsueNKlsZ42IIyyb2tQLB37mQBBwWSFkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXTmQfbDdG/1Ha+XotD1dZyxHT/GRRBjv8hGy0ZHB1k=;
 b=CSz93PegEIt1iFlAPS31mQu9H76WNvXlwuYL4bejEEsMJjmk0nR33p8kwiotIg3WgD6FAQ0q8NrochmOl/INfu8TO1+tjDjz/hiMDbWcKQHB0bYb5UR1Gr06pFTRV4GbMLxF4bShh/J/7YyiU2a7Z2Fcajh91+zGZPNwz7qsYdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by DUZPR10MB8227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 07:04:43 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12%7]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 07:04:43 +0000
Message-ID: <fe5e2b36-6a8e-656c-a4a6-13a47f4871af@prevas.dk>
Date:   Thu, 25 May 2023 09:04:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
Content-Language: en-US, da
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
 <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
 <DU0PR04MB94170FE393AEE4A86ACE386588469@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <DU0PR04MB94170FE393AEE4A86ACE386588469@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|DUZPR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: c368c0df-0820-4148-dd6c-08db5cee50a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIT+pAFWqDKO1zld+OMt9qwjrMLqlQJpqcj7BQn28+X9PFaA0RNAZUgauHBQbdsT6Q5+3VswKaB0ie+dxjRXLnQUKgxHVGc9pUh/TqKoKWPpnTL2twoud9QKUU3BwRQr+HnOPuAA6l02LirlSaDE/3IK/BUKaP4hMDEjG7HJJWA0URyv6i1vsMpNsS2B7K/6eV7AbETNb2xkD4r9krN/e3PS4ta/Kero4N1kBktQQ7d4uzmKYhLU3lVSjDaHUlTva4VhHshOY9rgaxIyBMHFNyhdza9OZMB4Sj8ldNmU59er3Az0f5EdRAa3lLylsMloqaGsF2DKRtMPye0VXm3yCyMwtDHx/KeUt5Oo2/ZXVmOWJMuxBm5HGcaU+PQD/hWUWsoC4u6j7PFjUef+FhKuoAOL/hZu4NU0jUe8yzMtKVarsoE4eVmUU6Yszxb0opXfEKO0bBdp3B0bri2bfX8tY4xxzpcFnDXVS7Eli9E7jeOkn1GVe80Yt8PyGZnJS7p4MPnqJjKxsTrA2VDBEbsYOs5hJwi8/X+yjQh6yTsWR92Lq3oxFPUJNZDBhfW9Mq+krU4y2FuIbKrq2kDRrx/ny9UPz3kbxn+YvYu3VW3owH3DBvu29ZsPK391ElV/A4PcTjOg0MvFUtzxcn7FtsSfWVx0Ukd1mEPwhMSOXERdmP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39850400004)(451199021)(5660300002)(8676002)(8936002)(8976002)(186003)(86362001)(36756003)(2906002)(2616005)(83380400001)(31696002)(44832011)(38350700002)(38100700002)(6512007)(6506007)(26005)(4326008)(316002)(66476007)(6666004)(31686004)(54906003)(110136005)(66556008)(66946007)(478600001)(52116002)(41300700001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cW5EczhDbEtDSjVQSWlvZ2tLVFo2NGxXbHY4ZEg2WmR3aTl0YnpaN2dVVlpE?=
 =?utf-8?B?VmZKVzk4ZzFRcWdUT2o3Yzd2c2lGdzhDMEszNmZ2WGdwRkpacXBlKzRueHZ6?=
 =?utf-8?B?UmNISjRwN004dVdKeFdoOGNsc2RUU3VGbTc2bnBLSkgzSmJFKzRJQVBmOWla?=
 =?utf-8?B?VWprSG5xNTFKVWIreDZNemVUZlJ3cWFUTHRnK3MzeS9TMVJrZTVKVGJnN3dk?=
 =?utf-8?B?ekJkTTNoN2lWR0lJS09ZWnJBUjR6UkpWR1VOajB0cGRzSUV6VlNQejlYZUNH?=
 =?utf-8?B?cno0Y1o0c0c5dS9mNHhqOHlmbG94S2YyNE1UOVlhMytkUjhJUTV5TldVb1dn?=
 =?utf-8?B?ejFOdEVGUDF0aUUwTi9SOTN0K0pLZzZTRkg1UTFSU1BMTWtRZTAyNkhkMFRM?=
 =?utf-8?B?QmFHazRybkJRZExQOVkwei9KVWpKSnNqV2s2cFc4YXBEc25rTkZVTEV2SnNk?=
 =?utf-8?B?VlVLejI3UVhnQlpNTVdJOWhtVWJIWGZ2Qzl1dTRJK0ova2hXazhPQ011Ulds?=
 =?utf-8?B?SFRVM1JNRTJ6MDBFWXlhalBUZVBXa0lQbnhTbnNmUnUraUgrVFJHWEpWTThE?=
 =?utf-8?B?THhpdzN1Q3VBWHQ1Z2RkQ0Q3K1RZVXdTQ0ZFb1FvdmhsZkhGMHBiQkFMS0dJ?=
 =?utf-8?B?amhockR5VkcvYXFXWFRPOTZWM3BSc1IvbXh5WHl5VldMUHJrNUpLMnBQV2xx?=
 =?utf-8?B?TDZNbVdBcmduZ3lhY04wNENmTE0yVTBaNVEwRmVDQzBPRHFFOWUzS1A0dGNK?=
 =?utf-8?B?YTcvUFA3cEhpRVh6ZmtLcXJhOE5VVDRVVUllYXBOb08yVWJVazBVLzlGdDNT?=
 =?utf-8?B?cWtVVFdiMGpuMnBvSVArd09HR25xZjZmcWRLaSsrQU9HY2grMjZZN05HQW1J?=
 =?utf-8?B?Q0J1d2t5d1RwRitLVWs1aFNMaENsSHMxbEZlY2t4WVlIZXRpQWdLekhkemFW?=
 =?utf-8?B?WDMzcVp3UklPb0lkd1VXczhzZjFZanJxaHI3Y3JjUUNqMExZM243anhGU1pL?=
 =?utf-8?B?ZmRTdEVlUndCdmJmYmdZR3BsN0taVWx6U2tLZ2FnU282L1pPYWRpcGwwdGIy?=
 =?utf-8?B?RVQ0MUI4THVUcm5qTHZNcFR0MFljWkJTKzZWODRReTNXbW15NVZOZFFNMnpY?=
 =?utf-8?B?cVM0SXBiN3FJbjlzZEVXOCtrZVlObnR6TVpHbVNMZ3BldVdZYm1sS3BvcEZn?=
 =?utf-8?B?V016ZURBSmFEZ3l0WktHOUwvdnZQNzFJcFlRditBVk11Zm5NUlI4U1RPMFJS?=
 =?utf-8?B?WTZ4aWp1RU0xcUw2UFZwSmpiWHpNcWh4NHFaMGpraUhWNUJIdVNsdUFuLzcy?=
 =?utf-8?B?MjRUUWxySXRXWVNwdUNFbVViNXlaRUtwM1pYdVNQKzZBY0Rub2MvbGV4Vys1?=
 =?utf-8?B?T1JlLzk1dCt6Y0V3M0xhZkNuaXg2bEpYbUVUZDhrMjNOTjMxc210SXd6R0xn?=
 =?utf-8?B?UDZhY0pkNFRtRHRqSmFOOWphbHVCZkh0eTViT1BMSmNRWVFzYzRQNzNpRWFq?=
 =?utf-8?B?ZitBdlNaWkpGODhYaDE0YkJNaE0vM2hubEpyZDQvNno1VENWS1pPRmhRYUww?=
 =?utf-8?B?ZkRETHIvSzhJRVd3MGVIRHJ3OXNXSmJmMUZzY1VVa01VcGhVUk13N3NROWsw?=
 =?utf-8?B?YnI5c0RhMW9MSTYydnRKN1lTSFYvR3dkc0ZzU0U2K2ZwSGJ6VEdNa2FuWklt?=
 =?utf-8?B?MFhUbTFMbTZhR0FLaTU3T1hUQ3lxT1pIZXJxTWJGSDVYQzVyNGhHN0pQVFNM?=
 =?utf-8?B?eXdWYmRyOGR6RGU0WVpBdjM4bkFVUUNVZjd0VERlL2tzYkdlV2FDQnRpZkR5?=
 =?utf-8?B?ZnRVeE93c3VINFJUTG50MnNIajlDSHM3c1Nua05OOVJZbEJEZnB6SUNZRk1z?=
 =?utf-8?B?WG1MOStuTm50cEJISGNEc2FJOXlvV0xpT1hMUFgvQS9KMkJObGpsTkJDQXFj?=
 =?utf-8?B?TWUyc1NvWFpBMWRzdnZGU0FYRGRlTHFTWFY3ZlgyUHdtL2JpdlFNeWxNWkV2?=
 =?utf-8?B?cm0yQU9nYnJMTElTZHVUNFJoU3RPYTRkai9ZaWhENjNpN3ZMTW1ZUEUrN2t5?=
 =?utf-8?B?STNwWHNUQzhjOUkrL2FjZGk4MkpEcHlVdVNxa0JONi96UzNRM3FRSm5qSVZp?=
 =?utf-8?B?ckpiQWY4Y2QvWGM5SlNxemNOYktGazd6K2lxVWFjOFlSckRPWDU2QTFqbHZt?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c368c0df-0820-4148-dd6c-08db5cee50a6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 07:04:42.9788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXnXGhfp7uX/T/EXj8TqPrR1bBVRI6vJ9PJlTRtvAcXeinF36z0k3+uKmIYxrRGsFg/w+3a6k5FzsyNY1EaWHVRJGN000R8Kff8FmJnAL9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8227
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 02.01, Peng Fan wrote:
>> Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
>>
>> On 15/05/2023 08.37, Peng Fan (OSS) wrote:
>>> From: Peng Fan <peng.fan@nxp.com>
>>>
>>> i.MX93 Device Unique ID(UID) is in eFuse that could be read through
>>> OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
>>> soc_uid_high to indicate the higher 64bits.
>>
>> So apparently, the imx8mp also has 128 bits, at least according to the
> 
> It is 64bits. The RM maybe wrong.

OK. I assume you've raised a ticket internally with the documentation
team to get that fixed?

And while you're at it, could you draw their attention to the lower bits
as well:

0x420[10:0] UNIQUE_ID[42:0] 43
0x430[15:11] UNIQUE_ID[47:43] 5
0x430[23:16] UNIQUE_ID[55:48] 8
0x430[31:24] UNIQUE_ID[63:56] 8

I mean, it's a really amazing piece of hardware that manages to cram 43
bits of information into a 32 bit word.

>> reference manual, which mentions a "UNIQUE_ID[127:64]" at offset 0xe00 -
>> 0xe10 (i.e. bank 40, words 0 and 1).
> 
> Which chatper?
>>

In my copy, which identifies as "i.MX 8M Plus Applications Processor
Reference Manual, Rev. 1, 06/2021", it's in Table 6-35, page 823.


>> obvious follow-up question is: Are the currently exposed
>> (lower) 64 bits unique among all imx8mp SOCs, i.e. does those 64 bits by
>> themselves actually work as a uid?
>
> Just as what the driver indicates, UID is at register address 0x420
and 0x430.

So, for the record, for the iMX8MP, the SOC UID consists of precisely
those 64 bits found in those two words. And no two iMX8MPs ever produced
will have the same value. OK. Except:

> For bank 0x40, I could not reveal information if RM or Secure RM not say
> something.
>
> You could raise tickets in community.nxp.com to ask people follow up
> on RM issue or else.

Very interesting, though, that somebody else tried to do just that
(https://community.nxp.com/t5/i-MX-Processors/Question-about-UID-UNIQUE-ID-of-i-MX8MP/m-p/1582383#M200077)
and have unambiguously been told by "joanxie" from  NXP TechSupport

  refer to the reference manual, lower 64bits from
0x420[10:0]-0x430[11:31]and higher 64bits from 0xE00-0xE10

and later

  the higher 64 bits thus bank 40 word 0 and bank40 word1.

and again

  since this soc uses 128bits as UID, try to use 128bits

But you are clearly stating the opposite, that bank 40, words 0 and 1,
do not form part of the UID, a statement supported by the experimental
fact that those words are not locked down from the factory.

Apart from the still unanswered question about what those two words then
actually contain, represent and/or are used for, this leaves me with yet
another question:

- What's the value of asking questions at community.nxp.com if the
answers one can expect to get are not rooted in reality?

Rasmus

