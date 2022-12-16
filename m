Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A98264E60D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 03:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiLPC4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 21:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 21:56:06 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828992B18E;
        Thu, 15 Dec 2022 18:56:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZB7ngEkUuGHvc2ALqRgqrv/63W1Lc2sCtsR1CopPgaZdRsQk9yDXET5oI3H1JD4F49X6wmKNdaFvpiYDE2IaQ/j7lleXLFDrzHZBgg/VEGsnFJ/CnsxaZjYD1NIX77iG+doHc5E/a2WxRSss60RB6lFlJi1d8qKcbetgUeK3NDmgsLp036aP7FwawPrccGGzQ7ArhdR6eBz7zYD0koc/f+G1dRXYwB32XTds5qMvPV8ZVJFULJAIJWXiLrhJqY+J60G++uMJHHsN+4zNT+LT8OqfWEbY/+pV/8WzmMc99/6OHsFAagoTriiD7mrS33l8X2LC4UbMUo+diP/A+GZBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBVQtUoHDyOTKlkDuFbMC1GaoG9qEtr5iJwyQuFvSlo=;
 b=dSff+wdumAeeNOLYN/V2t+2zj3pNv+e028J+L1Lw1AWgm2m5dXel2h/yPybKvjp15fmGxzAHah3WG3Zcp+tCwB6AQZR+/GxW+rtpQVr9GTvGTJj/mz0OTpF3RkQdkbfCWnHrKAfd9g3i8/kb1c28RQKOK01AeNr3B6mLuk7xgdo6UEVCyZ6hOpQ372vOt72FqkvVGOH4jD5geolJn28al0OJ4V5rteF3B5Ml3wOVdVswxrESubXOcsjPCuJMoTGGcxdjaR+ck6m5oqIVhtpBibtGFXmUeTLuqEiyAVqBOyXCdewWtmKhZ6V+4OLZ+9y7C4BfNwMhzk9B+8bfRG+ukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBVQtUoHDyOTKlkDuFbMC1GaoG9qEtr5iJwyQuFvSlo=;
 b=RG0zPOA0CvVysgp1rR1L9/l80use6prWpCXHVN0yGXs4gR4seaDO6tffOtqePHGaHtJCkdOOxa+q2fbrzoAVbXfHv8UxjPynNOUzFd69pZsPFrraWUWmtoVUi1m48gnakHAeKEBpBLWgMPcGg2AH57mHxF7L5ca2bav8zorRsfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BL1PR03MB6134.namprd03.prod.outlook.com (2603:10b6:208:31c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 02:55:59 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6084:1e42:9136:4307]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6084:1e42:9136:4307%7]) with mapi id 15.20.5924.012; Fri, 16 Dec 2022
 02:55:58 +0000
Message-ID: <47fb8549-173e-f86a-7040-1f9d865c0724@synaptics.com>
Date:   Fri, 16 Dec 2022 10:55:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V2] [media] v4l2: Add AV1 pixel format
Content-Language: en-GB
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, hans.verkuil@cisco.com,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        sakari.ailus@linux.intel.com, ribalda@chromium.org,
        stanimir.varbanov@linaro.org, hui.zhang@amlogic.com,
        lele.xiang@amlogic.com, Shi Hao <hao.shi@amlogic.com>,
        laurent.pinchart@ideasonboard.com, nanxin.qin@amlogic.com
References: <20220830014032.1245359-1-hao.shi@amlogic.com>
 <b5f4e1cc04ba35d92839932d431726fd42f24320.camel@ndufresne.ca>
 <3c634dc4-1b37-1062-203d-f3466d106ad9@synaptics.com>
 <76febfd703c3eaf312f001a9e952d9cd89449fa7.camel@ndufresne.ca>
 <07385baa-9e82-9fc8-5cc1-cc1089e87fdb@synaptics.com>
 <a85a5c817cd2a29d6ba592fae75bf9e065d93124.camel@ndufresne.ca>
 <1480f5a3-700d-9c1a-7e05-b64abc94c9e1@synaptics.com>
 <943654c448f260e04aaf7157f4edae35ae86fff2.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <943654c448f260e04aaf7157f4edae35ae86fff2.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::41) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BL1PR03MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 4112516b-04df-4642-5fa4-08dadf110eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DIT67BssYjTdAS5JEcdfJAG5jiGiWqf+dIGSUyF3iiePrkCj6fakKVAPLdDktyfsRLzIFUoJNuv+m/nQxF9PKpF7PF2DkfIuHShVvykjNbIdBhHsPYOB6L9T+D+eSdWwm8mHpzvvWvZwrKbUkbCtBP43t8jvZHpcOLqBOo61r/vymcg51v24wgUrx9JphGB3dTKb6Xnq9WpzZx539JhyPTlmzwojgXkfaHWvKVUookXpvUU6nNsX3VcNm0bm1XN2gn8Bt3LVaenw5KUjSQ3ys+SAVFiOcWvazSE4NqrT0k2fNfFQn1CUaSMHrAuZUGwsgYczFnDo58aQ5azH3a7CNrZoi0DZq/cbT1hxam6MIGzjAfKCKFR/sGdKdSSbEXNc5QiPGgXf3U5cxoKvVr/BUneILJXOZcnlg6/VyCuqYGPnKV6e+XmAhoLgKJyo6Q0PlydKTn/GeLLBQME3n431bkaSyztvps1aBbsWbSYpaHsnO19/X2IPwgz4Cfuc4XlCtiagfLTuKpSnvzlR4NPSdUyfuqXzPL+FR6sflHuHpNJeMNsqw42qOS8SN4HPBBEPhtiFiGKV3vgHv2YwRlL4KbsADvIYqL4Pbwk9z7JiKpetQYbTcAeT75VCGCWSmZfi3XafcGJwaR2xVX5M18fSO+EDmRtg4a/zweqnQvdpFTKcs818weSgwWR8IxpbuR2quIgrDNg6C+/RJifdMRpohmn9h9qkux+dDX3EhRoRAVWYGzE9/F6dGKlPGBXDFGwZDYMR3a/5aiIoVlPLFEq4IEZMyRWU16kypkTYyk14FWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36756003)(2906002)(6666004)(41300700001)(478600001)(966005)(7416002)(6486002)(31696002)(5660300002)(38350700002)(86362001)(52116002)(38100700002)(30864003)(31686004)(66946007)(2616005)(8676002)(53546011)(66476007)(4326008)(66556008)(83380400001)(316002)(6512007)(26005)(6916009)(6506007)(8936002)(66574015)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE1IQ1doQlhoalVSeW1DYkNHektiNVJLQUs2S2lzbzhuT3cxS2N4YjgrNmV1?=
 =?utf-8?B?dkthUjBoSlQrK082djQxTFVRcWEwUlRGL1kzV2hYRSs4TVgvYjlETHlweTBr?=
 =?utf-8?B?QnVwV0NDelVUTGtOeW1laXFVRmFvTThDN2tRdlBQWUdzSERrcHVrUmF3L0ZB?=
 =?utf-8?B?YU0wZXRMbnZFUkpIUDMwVkNqc1JGOVVKekxUMXhhMTYyMmh0Y3BOSDRwVFA1?=
 =?utf-8?B?anBoRlZLQitnVFFFbXEwVXBXdDdXM1h1SkpYYUNWcHo3dlpOcCsxMGFENEZB?=
 =?utf-8?B?MC82cUFYL05pTGZEVmlNQUdXQ1Nvd09sMEVDVm96S0t3NlRpNTZycThES1dK?=
 =?utf-8?B?NWlrNUdaUHJmM1BoaVBkZmgrVUJxNG9BRzJjWER5T2pGWHFKdHpjTld0VGNS?=
 =?utf-8?B?b1p4ZDFpemVqSG5YL21PQjNPemZBRXUvQmprMUxYWEpVNTRkWW9GR3I0a1M5?=
 =?utf-8?B?RlRXVU95bEl5cS9iYUk2bVdWN3A1ZEM5V1hBaGt4SW9uQU82bFEwMGRYZU1W?=
 =?utf-8?B?N2lBeG9qZkF4QmtUSGtiZFgxNzNxLzRNV0tqaHQvVk9nZ2NjeWdGbGFVbUI3?=
 =?utf-8?B?bUZOT3I1WHdYQkEvQVdxVDMwczdFa1JabUxPWjJEV2xjbFU0TlIxRU1TaUZX?=
 =?utf-8?B?cU4yd253VmUvNXBlOC81NFVmd2wzbG9sWVRSYStSdzlHMjdEd0xQRGNmNDI3?=
 =?utf-8?B?QUgxUmQ0TTdnMVozWHl3NStUSEFubGRZb2RCbVFVZ0NIYXhkbkNYZ0tYdHMx?=
 =?utf-8?B?RGhVcDBJejhCWWlUTVVLNDhDQTRMOEwrNUh0ZWk5ckRsdUJvT1dIK3BqQVpT?=
 =?utf-8?B?cXBNMzRXOFVMRzdLdWhoT2p5dTZqcFNWSUVlV1pkZmRMSHhuOGc5eGF5ZWRY?=
 =?utf-8?B?UVpUdXg1NXhpbnZERG51cklCWmo1eG5iYm9FM0dxa1BUTUQwNFBoOHNDcjN6?=
 =?utf-8?B?bkZnVkVDMlFoaUVGZ09LOEx3Z1BQbTMxMnExMStZL2FFeXZVMTAvSjNtbXRK?=
 =?utf-8?B?TmkwTmdrMnJvN0xtNE1tekFMemtuNzN1bFN2anIvUm5OTjIwVEJUQ3hSL0ts?=
 =?utf-8?B?UkYyTnlHa2wxOGtPaHdUSVFDTzhzWFpGSkxHYjFoRXAzc1c4U0NMNWhoNGN3?=
 =?utf-8?B?cjdCREJoWHZHNVV4dVRtOTNiRFJnbHFmN3hRZUZtSms0Rk9LTVYxWlpCZkNM?=
 =?utf-8?B?blhZZEsrWko0MVJBVXNBd0UwQnM5ejhVMUU4RUdsdVJQY0NaWDRpcklNK2Uw?=
 =?utf-8?B?eVFhajYzbE43cSsrazEweWFLb1NlSmtkOFhiOXZtZDFWdFBoMWx0c0hLMjJj?=
 =?utf-8?B?TEcwazVJMzBFSTVyazd4VWFDSERGWk5zSkdoNzU2ekdCZWJCYW5BbEE1R2J4?=
 =?utf-8?B?d2owaWNvRmx6M3d3U2xwLzlVUE9PaldHdjBvbXJOYlhOc3BOdkgvQlRZQzk5?=
 =?utf-8?B?Rkw0VEdUVFZtNExVWWxpMm5lcGI2RmdLYlRZWUNlMzRaWXBRb3FIM1FhREhG?=
 =?utf-8?B?WHdPbUZEVURodTdmVUJrVWUvazBWanJNV1VEYm15UWZjVENWZW80WWR6VFMz?=
 =?utf-8?B?L3RQa3dYNXROb3JDNC9KQk82dEYzNE1NK2JicjFjbEZRMjVHU1dKQ1lhSVI2?=
 =?utf-8?B?cVRTUnRwM1RxeEZpQUhlTGx6SzAzSitMdjhSYTVBemdqQk1vbklHNGxidE92?=
 =?utf-8?B?eDAyWS85OGlnSFpHaTdpS0tudVBwbWtSajRHYkZCa21kc244MDdHMUtPWTVx?=
 =?utf-8?B?RjhxVjdZWWpPZmxadmFxamE5Qytxa3RnZTRubmx4d3BrL0RMMHpGQnNyay9W?=
 =?utf-8?B?V2RIRG5rN29tcHZVR0ZFSEhVK1Q5ZGsvQWlZT3V5YmFXTDJMcTcwbEpqU2pZ?=
 =?utf-8?B?ZGZFWWpCMjdtTmx1SXI2MDJ4aFhWTFgwWlRsMUZSY1VORi9QODgxS210TkRp?=
 =?utf-8?B?bFpJQnhYOHBiRnlybTFZMFc5WkRqc0JqdjdYMjNsYlFiaGR0di9ZdTNPOEI1?=
 =?utf-8?B?R1RSejdyOGlHazFyd0VzTlovSkk5NmZLNXdOalQxYVk3SlVlYXk1OEtITjVK?=
 =?utf-8?B?ajhVbTBobThOMmtCMXhLaysvN0pmQzFNVVRvbG1JM0k3N3hHMDBzYjd0ZFV1?=
 =?utf-8?Q?QynwEMxA4XE058Mhy6aTKtqYb?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4112516b-04df-4642-5fa4-08dadf110eda
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 02:55:58.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBTgGGoR1MZ3rsQBGdFPvSun7peqc+FTVfJ6MHr1GC0NN4OyxNqbTt4/qvIt5CA/JksUafXOz8qqWLfgaxIaAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB6134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/16/22 04:18, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le jeudi 08 décembre 2022 à 10:39 +0800, Hsia-Jun Li a écrit :
>>
>> On 12/8/22 01:16, Nicolas Dufresne wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Le mercredi 07 décembre 2022 à 15:18 +0800, Hsia-Jun Li a écrit :
>>>>
>>>> On 12/7/22 02:03, Nicolas Dufresne wrote:
>>>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>>
>>>>> Le mardi 29 novembre 2022 à 18:32 +0800, Hsia-Jun Li a écrit :
>>>>>> Hello
>>>>>>
>>>>>> I think we need to add an extra event for VP9 and AV1 which support
>>>>>> frame scaling, which means its frame width and height could be different
>>>>>> to the previous frame or reference frame.
>>>>>>
>>>>>> That would be more possible for the VP9 as there is not a sequence
>>>>>> header for VP9.
>>>>>
>>>>> The solution is unlikely in the form of an event, but yes, to complete VP9
>>>>> support (and improve AV1 support) a mechanism need to be designed and specified
>>>>> to handle inter-frame resolution changes.
>>>>>
>>>>> Why I say improve AV1, this is because VP9 bitstream does not signal SVC spatial
>>>>> streams (the most common use of inter-frame resolution changes). With SVC
>>>>> streams, the smaller images are alway decode-only (never displayed). This can be
>>
>> We expect to get all the result from different layers of a SVC stream.
>> Which layer would be displayed is a user's decision.
> 
> This is off reality. Its the conferencing server that measure each participant
> bandwidth and decide how many layers each one should get to avoid overloading
I think the major would prefer the P2P mode and forward way. Server 
negotiate and re-encoding were still in use but the lag is people don't 
want.
> the network. The selection happens in compressed domain. Perhaps someone could
> be creative and make-up a use case for what you describe, but this isn't used in
> practice. 
I know at least two commerical softwares support this.

Just consider this simple, not SVC anneb. Do VP9 and AV1 could support 
the current frame has less resolution and worst quaility than the 
reference frame? I think the answer would be certainly yes. That is the 
idea of golden frame.
So "the smaller images are alway decode-only (never displayed)" is not 
right.
Only the inverted case is a pratice of SVC.

Adding multi-resolution output requires a massive API additions in
> stateful decoders (which this hidden RFC does not cover).
yes, had better to start a new topic.
> 
>>
>> 1. golden frame usually would be higher resolution or better quality.
>> But we would only display frames which are lower resolution.
>>
>> 2. Higher resolution or quality layer would have longer interval, user
>> may just display a lower layer in real time case (like video conference).
>>
>>>>> at least partially supported as long as the maximum image dimension is signalled
>>>>> by the bitstream. This is the case for AV1, but not VP9.
>>>>>
>>>>> Stateless decoders are not affected, because userspace is aware of frames being
>>>>> decoded, but not displayed. It is also aware that these frames are reference
>>>>> frames. While on stateless decoder, userspace usually does not have this
>>>>> knowledge. I think one way to solve this, would be for drivers to be able to
>>>>> mark a buffer done, with a flag telling userspace that its not to be displayed.
>>>>> For the SVC case, the dimensions and stride are irrelevant.
>>>>>
>>>>> For true inter-resolution changes, like VP9 supports (though rarely used), this
>>>>> needs more APIs. It was suggested to extend CREATE_BUFS, which allow allocation
>>>>> with different FMT, with a DELETE_BUFS ioctl, so that userspace can smoothly
>>>>> handle the allocation transition.
>>>> This could only solve the problem of never display graphics buffers
>>>> likes golden frame or alternative reference frame.
>>>>
>>>> About the topic timestamp tracking problem in v4l2, maybe we could start
>>>> a new thread or move them to Gstreamer.
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.freedesktop.org_gstreamer_gstreamer_-2D_issues_1619&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=GL3Q2_6ERpT94we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=KbTA0L42trYmxvVphaiUeDsgUS4e-vm64epfaSgAYH8&e=
>>>>
>>>> My idea here is event attached to buffer or just using the new request
>>>> supported in CAPTURE side. I know you worry about the v4l2 event, it is
>>>> out of band, more event could lead to the problem we suffer from
>>>> OpenMAX. If we could have an order between event and buffer, it won't be
>>>> a problem.
>>>> For VP9 also, it might be required to support
>>>>> super-frame, VP9 supper frames are the ancestor of AV1 TU, and only the last
>>>>> frame of a super-frame is every to be displayed. A newly introduced AV1 format
>>>>> might also requires complete TU, rather then frames, this needs strict
>>>>> documentation.
>>>> I don't think the temporal unit is a good idea here.
>>>> Most of hardware could only decode a frame once or less likes a
>>>> tile(likes slice in ITU codecs).
>>>>
>>>> Considering the MPEG-TS case,
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__aomediacodec.github.io_av1-2Dmpeg2-2Dts_&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=GL3Q2_6ERpT94we1vI-sUNajRV_t3-lcd8F6DAbXt5EimufjPEa-yTi1-p3EhsCM&s=f7qIYhe94ooCIv1awccCfSmI-Gq0raAXHRogkCBTB4M&e=
>>>> Decodable Frame Group could be more a better idea.
>>>> Temporal Unit would lead to larger delay.
>>>
>>> This is off topic for the tread, but this one could be fixed by setting a flag
>>> on the capture buffer, something like:
>>>
>>>     V4L2_BUF_FLAG_DECODE_ONLY
>>>
>>> That's similar to how it works with other CODEC API. The down side is that the
>>> driver needs to remember if this is a reference frame when userspace queue back
>>> that decode-only frame, so its not overwritten. Userspace is not aware of the
>>> reference state, hence can't be made responsible. I suspect a lot of the drivers
>>> out there uses secondary buffer, meaning the reference are not the CAPTURE
>>> buffer.
>> Drivers certainly could allocate its internal buffers. But I believe
>> Android won't like this idea. They would like you allocate it from
>> somewhere then import into driver.
>>
>> Besides, when you decode a secure(DRM) stream, you won't want to leak
>> any data from it. While for those normal stream, you don't want occupt
>> that limitted amount secure memory zone. I would like to let the
>> userspace control the allocation of those internal buffers.
>>
>> This use case needs to be thought thought too. Perhaps other driver uses
>>> internally allocated memory whenever its about to produce a decode only, but
>>> that seems to require some firmware feature that is likely uncommon. Please,
>>> make your research, compare various drivers, and propose an API in the form of
>>> an RFC so we can discuss that independently from this AV1 pixel format thread.
>> My proposal for solving tracking the timestamp issue is making v4l2
>> event have order relevant to buffer.
>>
>> It would come after I refresh the v4l2 pix format extend API.
>>>
>>>>
>>>>     Decoding frames would mean that un-display and frame of different
>>>>> sizes get delivered, and we don't have a method to communicate these frame
>>>>> dimension and strides at the moment.
>>>>>
>>>>> Nicolas
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> On 9/12/22 23:45, Nicolas Dufresne wrote:
>>>>>>> Hi Shi,
>>>>>>>
>>>>>>> thanks for the patches, check inline for some comments. Generally speaking, we
>>>>>>> don't usually add formats ahead of time unless we have a good rationale to do
>>>>>>> so. Should be expect a companion series against the amlogic decoder driver that
>>>>>>> enables this ?
>>>>>>>
>>>>>>> Le mardi 30 août 2022 à 09:40 +0800, Shi Hao a écrit :
>>>>>>>> From: "hao.shi" <hao.shi@amlogic.com>
>>>>>>>>
>>>>>>>> Add AV1 compressed pixel format. It is the more common format.
>>>>>>>>
>>>>>>>> Signed-off-by: Hao Shi <hao.shi@amlogic.com>
>>>>>>>> ---
>>>>>>>>      .../userspace-api/media/v4l/pixfmt-compressed.rst        | 9 +++++++++
>>>>>>>>      drivers/media/v4l2-core/v4l2-ioctl.c                     | 1 +
>>>>>>>>      include/uapi/linux/videodev2.h                           | 1 +
>>>>>>>>      3 files changed, 11 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>>>> index 506dd3c98884..5bdeeebdf9f5 100644
>>>>>>>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>>>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>>>>>>>> @@ -232,6 +232,15 @@ Compressed Formats
>>>>>>>>              Metadata associated with the frame to decode is required to be passed
>>>>>>>>              through the ``V4L2_CID_STATELESS_FWHT_PARAMS`` control.
>>>>>>>>              See the :ref:`associated Codec Control ID <codec-stateless-fwht>`.
>>>>>>>> +    * .. _V4L2-PIX-FMT-AV1:
>>>>>>>> +
>>>>>>>> +      - ``V4L2_PIX_FMT_AV1``
>>>>>>>> +      - 'AV1'
>>>>>>>> +      - AV1 Access Unit. The decoder expects one Access Unit per buffer.
>>>>>>>
>>>>>>> I believe this is using a MPEG LA terminology. Did you mean a Temporal Unit (TU)
>>>>>>> ? In AV1 a TU represent 1 displayable picture, just like AU in H.264 (if you
>>>>>>> ignore interlaced video).
>>>>>> I think it should be a complete tile group obu. From the spec, we have
>>>>>> the term 'frame'.
>>>>>>
>>>>>> Currently, AV1 doesn't support interlace.
>>>>>>>
>>>>>>>> +        The encoder generates one Access Unit per buffer. This format is
>>>>>>>> +        adapted for stateful video decoders. AV1 (AOMedia Video 1) is an
>>>>>>>> +        open video coding format. It was developed as a successor to VP9
>>>>>>>> +        by the Alliance for Open Media (AOMedia).
>>>>>>>>
>>>>>>>>      .. raw:: latex
>>>>>>>>
>>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> index c314025d977e..fc0f43228546 100644
>>>>>>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>>>>>>> @@ -1497,6 +1497,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>>>>>>>                      case V4L2_PIX_FMT_MT21C:        descr = "Mediatek Compressed Format"; break;
>>>>>>>>                      case V4L2_PIX_FMT_QC08C:        descr = "QCOM Compressed 8-bit Format"; break;
>>>>>>>>                      case V4L2_PIX_FMT_QC10C:        descr = "QCOM Compressed 10-bit Format"; break;
>>>>>>>> +         case V4L2_PIX_FMT_AV1:          descr = "AV1"; break;
>>>>>>>>                      default:
>>>>>>>>                              if (fmt->description[0])
>>>>>>>>                                      return;
>>>>>>>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>>>>>>>> index 01e630f2ec78..c5ea9f38d807 100644
>>>>>>>> --- a/include/uapi/linux/videodev2.h
>>>>>>>> +++ b/include/uapi/linux/videodev2.h
>>>>>>>> @@ -738,6 +738,7 @@ struct v4l2_pix_format {
>>>>>>>>      #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
>>>>>>>>      #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>>>>>>>      #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>>>>>>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
>>>>>>>>
>>>>>>>>      /*  Vendor-specific formats   */
>>>>>>>>      #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
>>>>>>>>
>>>>>>>> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Hsia-Jun(Randy) Li
