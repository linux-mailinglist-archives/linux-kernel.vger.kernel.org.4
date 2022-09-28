Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D015ED951
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiI1Jkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiI1Jk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:40:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6081F9DA;
        Wed, 28 Sep 2022 02:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDde0gzlZGFOFpERIZGNnzVV1hgiSY/p0QiN2VZJ57vqEG7uZQSve7HtxzsvX0DkVePJFzX0AMeDYfYLUzoe9KrfAlJGRfKKEyKCY1ju2Ea0VKMzOIYHGiCKEqDnwleIiozID8D3BPsMxct/DJn+GCnOuNwBvlVm2iQ4sMWFadZLZqt4JK4zw3kyGgxNtCBi7CQsPOHWQZO7pp6KQyKh+634P17y3RfCUWjtRgQwVJiulqzzKG84iTeUofq7Pi6BcOVqDwi8pWSWWPfwdZo2GrZ5H9Hm2v8uPFDS7z74M7Z53oO1H7Cdnw53VhQs8VVRjYJfIUFXseIsWZ909pBaxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEY9sbt6tylqzo7tr7sx7N7AQQ4XPwJ0HnIKcgW2DYI=;
 b=E/9Wns4reZtibbWnlzclFO/+kqzlaQwRQ9/i25YjLWePWUgL7DBlfCFhW6qWN1s6G0L7MBao8MIazOoJt4udv9vMYOGCq2FJ64fTRNlrN3PYQkeym/IlQCyDiekap40otNBlYhWEBtOj5v3ms2cC0XgZ9kfZeT4/jdTAKePVd0iggXrPjwc3bvp2UeJv9VwHZl9PnUW9f0SzBwLwcUDoujnzTHCSxmZ0wgGysE6CyKSqZ1IjoI2erNGtW7R7SCNhQ+Lp46rNh7G0k1kgxj8yDsI/VEOm78nMEWiDUT5ULG20gmBlh7+1QgiaFcwateEn9873rAbbMvIwIB4djRIZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEY9sbt6tylqzo7tr7sx7N7AQQ4XPwJ0HnIKcgW2DYI=;
 b=XBiyi5BK45sNcU354obCzBENHOdqobkQk/TNr7js+0E43RBNpB/T21q896iAojizZ6vfP1TxdvD2cIsZGSjR9gNd/cX/HudQkk1k3zXvqYBKoYbiRbdpWJPG2UY8klcrJJcRVUL9bNvJnxdNXeImYWZaAZUNQSKpiO6odFr9BNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Wed, 28 Sep
 2022 09:40:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 09:40:19 +0000
Message-ID: <d4f43e5f-367e-db52-96d4-286d7fa9d1c9@oss.nxp.com>
Date:   Wed, 28 Sep 2022 17:40:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH v3 04/11] remoteproc: mediatek: Remove redundant
 rproc_boot
Content-Language: en-US
To:     =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>
Cc:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-5-tinghan.shen@mediatek.com>
 <da5dcffc-746f-207f-eee7-f47e2550eab0@collabora.com>
 <71748c8dfe0fccee352d04323b40ff998031aeea.camel@mediatek.com>
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <71748c8dfe0fccee352d04323b40ff998031aeea.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:3:18::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e97335-ac6a-4027-5d39-08daa13574ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wS9jOAXEY8e/kQJ7ZXtw5m2eMeSwVg9QtQYg9s2YM3nqLapf4W8OsZcwOtJo2C/Hzu8vfZKJTmNNAI/dv+M805rvIKsCbP5W/dpWQVTO7yEI85WLjJCya9dbiFMpVuoajjM3ia+EBSybUZEr072r8wqLn+jxx7Ri7hmjD4AL54CbNVOA9UAvI/U8fvpYxw0A1ZAWkQR7xEakGIPGaPFkach73akzPUszw/8nSxKzKukXbyH/xDEqY9v1t3/AdQpr1Ta7GGG7VNph0dwSKGUs/5YtlrX7G92ZwU/UO6o9atv7t5dRRSlaI2eCulRvSB43TEFsqokSE5Unsa/J5AEbrG6o7WeYD7padpy+R3ri2cbif4/mV7L55QOBVGNrIUBH+tmnNk7J/JzM2YZW/oft5aqesj7t3u3on/IWW4Mn9hB6WEPWTlQO2GgKP1NOf1xvk/o5LlKlK6xwfofTKydida9hmAnlRBvbxXJaGrO1rguGqIw9noYqc2CN1P0sA6cnileziIvyH5U3bRUT8GAq94G0JNYEzVSMau7vXxCZEGDHNaP6b7Qay4JRR804dTTgwyaFY+TZZowFcxAMLZpzM9G0esKFiR2pavmLq04SCJYEZv7sh3P931LC01qyGEv+rL7snp661qYR4YZtLeDs5USrAU6/BPUVNWc1G4SXRLiUjfjCRsKO6FiXnuZ8bv3KnN8IV4BfDmt/8pvvoCaGjzcwEG6tTfwwNarxpIovu0eR+4Dcj5fxJ0qI3XC0c6YTJOiREEChmOU/vupB8biyIpDqRx3DtN13MCY/NcDWOvL0Ax9Epg8elOXTg7n4yGM6SsEIY5dBTjxEDiPFy4+TqakZe1umZcL5RuyqjendS/c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199015)(31686004)(478600001)(4744005)(44832011)(316002)(8936002)(6506007)(86362001)(110136005)(26005)(7416002)(186003)(66946007)(66476007)(4326008)(2616005)(31696002)(66556008)(38100700002)(53546011)(52116002)(5660300002)(8676002)(6512007)(54906003)(6666004)(2906002)(6486002)(41300700001)(921005)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhmUHlMT0lSTSt5Y3g1T0gza1FvOXh6MVdUNVE2dTBQVC9zR1p4VWtTSGsx?=
 =?utf-8?B?enRTVzcvODN0d3h6TXQrZU5ZTjE2bFNLS3Y4NjNQYkVyYlBNMytKaFBRclhP?=
 =?utf-8?B?UldxUTcxNTRYODgvdnZmbkp3T3pXN0h3bE1lQzlJcnduRlRXbHZodVBGTkxi?=
 =?utf-8?B?VUZ6ZmloOFZHeHlTTGJmQmkxUnByU2E4a09LVUZFMzdyaDZzVzZtM2NqdWhF?=
 =?utf-8?B?U1RlOVZDZ3lsNWJNZDcxQ25FM2FLSXFld1RUZ2gyRWphSTh3a2NiSkREMFoz?=
 =?utf-8?B?bWdOOTczeThmMDdMTk5sZ1B3ZjVMM1UzQk8rYWIrRFdhWjZBT3hZQXVvUTFR?=
 =?utf-8?B?OGwvRDZRQjI5cHFPS1gwV2NBZ0tlNUJlc1VUaUFCZWoySkpwODdvOVN3WE8v?=
 =?utf-8?B?THQ2eVZybmFyVU5CdHJZeWZmY0Y5WU5qYktrZWdKWWhuOVpwb0JoRjBHWmc0?=
 =?utf-8?B?S2ZJOFVsd0NGSkdBbHllNEpVUW9SV1V1RXk3YnRuOUxLMWJsZVZzRXFYcmVP?=
 =?utf-8?B?dWVoTzg3L2NTdFNndDNxNUZsb0lDYWZwZTc5cUUrWXVobzQwRy9yN25zY0s1?=
 =?utf-8?B?eExOdE9KYUhzTXc1MmtIeHBMRzM2S3RQMkk2REhFN1BzRXRGdFhyaUpLdW85?=
 =?utf-8?B?bm56aUsyUm5VWjJXb2R2Wk1ZR0hxdDl1NjJlanJqRzNFNDZhOTFvMUNIMjVF?=
 =?utf-8?B?WVBQWU9qalUyRVFSTDVLMlZBT2U4VUtnZ2lhU1BsRkVxbW9yc0xLbzd3bFNh?=
 =?utf-8?B?WnhHb2p4N0MyUnRYZVpYbHp3VTczZkVzbU1sRDMvaDNuUGpnak1ta2xrWHlF?=
 =?utf-8?B?RWtIaVpiM3dQOFRSeDlpSUVjRy9QWVhQQVlrTkk5OU84dnhZM3ZMN3ZDZTZW?=
 =?utf-8?B?b1dKOWU1bmtMREFpcDUrNVRhNDFaMmFOdUtBV0JWV283eEptc1BpL2x6WmlX?=
 =?utf-8?B?OHhPSkdRUlJVT0FuTTFERUF5OU1VMGI4SmJ2b1FhZ1JKZTBzcWllaGlkOEZ5?=
 =?utf-8?B?TU9uMCtoZjJaWWhKeXZvSnZ3Q1d6allaRVEvMVlyR2NBUmJJSkVlTllDZlJy?=
 =?utf-8?B?YW1ZaGMrQ0NzTzNPY2IwTnZjMDBLSi8zQVlVNHhYdHhrdG9KdE9TdXJxNCtu?=
 =?utf-8?B?NGJXMlBHMVZDcnpJTXJlRmZjRUtLMUVCbGZpUEl3QW5GNFZpN0pGN0VxQjhu?=
 =?utf-8?B?dWtUU0lYVHl1eEtRaWtvT1VZc25pWWNPeDlzdjRST2s5Mk9TbU5yWXF2d1Bz?=
 =?utf-8?B?RUtsYzZuSExLSktkdjZlSlRrdzZ5Rk1ROUhxQ0pOS244TGFLQ2h3VFFUZGFD?=
 =?utf-8?B?WEd1bjh3ci9qZTR4dlRDOUVuaWRRMHdmZzRNbmdnbDZuQWRnZkFjT2lZUGFo?=
 =?utf-8?B?eHBKcExJMnVNU3NBaGw2L0d1TGtnbnI1dzYzSENRYmRXYjNFalpRczg4c0Ra?=
 =?utf-8?B?UlJVN0lObUtYUld5WjZhWExKQ05ESmlVYUY5TDNOSEVHcndoU2ZqaWV2OTBG?=
 =?utf-8?B?Z2V3YmxKZ1VNT0ZVcWFwOEU3Vzd4NGtRT09vU3Fqa3lDeGFiNkxvWklGMWRy?=
 =?utf-8?B?dFBQdC9uNlZ2dDZqWEpYVnhvODZ5bjVVMlF0MWcvZkFJcWxTSDZWZys3bk1D?=
 =?utf-8?B?UWdyWldmY0k2TjVVcExscmJNeEZ6YjlweDRnb1FEZmxGdG9VTlROdC9ESkZE?=
 =?utf-8?B?alg5N1RVOGt0ZzVuN1gyTGhCK0NWVUJrRkpWcnRyb3gwbXdTM3lvYWVBR3ln?=
 =?utf-8?B?RWtOc1owMHF4QWt5TmZTdVBmcUJXcFlabTQ3Tm5MUzFRVXh3aW9lalVORktp?=
 =?utf-8?B?SkxiNkF6bmMzVmdOUjJPcGV1WVYvSXNpdFpTa0Fkekp5Y2RxbmtEdEtZdURn?=
 =?utf-8?B?RzV2TnRFSXZOM2NFdzRYNUU1TEFOeThIRUk0c1pOSnJlS2s2ZEJiRHJaMnJy?=
 =?utf-8?B?RVRSN0VhVjM4QzFGc3dkV2xKVDhPc0pmb3lieU1CaVRjYjNzQ1ZLRVhZK0pp?=
 =?utf-8?B?N3BlRWNZYytOYUk0Vyt0aEg3QW9QNGkwRWhrdUtlektpY1p0L0d4MkxyN3pW?=
 =?utf-8?B?NlU3cUxmL0xUYnM0L0xJV2NBcXJiUWtYNUI3bmsvMFBYMlJ0em1TcVM1VmNU?=
 =?utf-8?Q?/xY/NBHh4TOMHUBUg8ZRwrX30?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e97335-ac6a-4027-5d39-08daa13574ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 09:40:19.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7XObRJDX9aeIcZzmz+IJgwc2anpbFZx2wfXz97CK47+3ImDUn31tk6ySciJD+VaBAc0wfo0KYcpwI0qqjmGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2022 4:27 PM, TingHan Shen (沈廷翰) wrote:
> On Tue, 2022-09-27 at 13:03 +0200, AngeloGioacchino Del Regno wrote:
>> Il 27/09/22 04:55, Tinghan Shen ha scritto:
>>> The video codec doesn't need to explicitly boot SCP in its flow
>>> because the SCP remote processor enables auto boot.
>>>
>>> The redundant usage of rproc_boot increases the number of rproc.power
>>> over 1 and prevents successfully shutting down SCP by rproc_shutdown.
>>>
>>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>>
>> You should Cc stable on this commit, as it's a quite important fix.
>>
>> Regards,
>> Angelo
>>
> Hi Angelo,
> 
> Ok, I'll add it at next version.

If this patch is not relevant with the SCP 1 support in this patchset, 
better separate this patch out as a standalone fix.

Regards,
Peng.

> 
> Thanks,
> TingHan
