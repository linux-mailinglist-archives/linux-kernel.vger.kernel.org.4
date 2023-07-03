Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F3745AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGCLFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 07:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:05:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CA5DC;
        Mon,  3 Jul 2023 04:05:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVk2AqW4Ok10zrDt5hSQcGQJoswKchICOHivEr7aEOOyth2xUg5K74dcXri/7+883V51KRVQ3fo1bYwZ0kyCnbZQYH3/5d61+KBWNGHv3P8yg6xxOS8xoDO1U7vclYzTo6JdCnpZnsicMW0sNcRqpl/lTh/Ew2UCk+aEkitrimUZm86qH2fKRa3Ih+i6epD1SB5bkZfvQrf3onsLsVuPNZA1HrkyLXm1LVrOXUuMgR11WlKG1V6b/xSuTt05yy+WUiFSHvD1qlZoDMENfzCUH2yhuQxy9U6Tgv0UtawDlfD2awt8K3zZKQLRr5rF0vWBukzbKE7q0bZzurFJnJT3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AJhDvEBJ1xcKzReoW9zWDCqOXCn+B9vIk0pqejzD7A=;
 b=V5mf3FVydHdM/BV/8+sVFrThMzGakmbK9DKpyfvJ60PYi2beOHe4rDnRMy2sE8BVwY5oP7ghnS+UdBS4Jg6emfLt0cXHb/g3cYGsSAZUBVBfm2Y2J3IJ8wfLdNuxDgUbwmWnkCQq9jN811mzxAPnNk01JM2eb1eyz70l97XcMh2tUDlyqMfkeFeIQX2Bqu/SndAZC18TSoKmCIh+OBz19RvvJ0Z7aDVypKPtKETlzWFLcrwq9ZqCLZ2y0hTXkXL6J5eD9I5vtFTwJzB5GRVYTgjC+0sxiNk5h9dz5/RcfBziGyYWEKh42/zxHYNCHQTet5CVxhF6PnmMs4kQr6MIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AJhDvEBJ1xcKzReoW9zWDCqOXCn+B9vIk0pqejzD7A=;
 b=etaDjQDJA3zQjd5fO4lQAYtnhjQ5+eZn5XDx2JFd2kT5YbOKVnoY6cwkk4Ua7t1i5xK8JuOf7dWqdcCwNlgt1aPFvM9erlZZeS7baf4mr98CoRgCFZVppbgbJFBVgDvmUsQh19fU0Expbqmrg/AFEsNGH9c9xglSOD7a1laawDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DS0PR03MB7277.namprd03.prod.outlook.com (2603:10b6:8:12d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Mon, 3 Jul
 2023 11:05:37 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 11:05:37 +0000
Message-ID: <afbcf2d7-e6eb-5b45-fdc6-39e1944e7d3b@synaptics.com>
Date:   Mon, 3 Jul 2023 19:05:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 04/11] media: videobuf2: Stop define VB2_MAX_FRAME as
 global
Content-Language: en-GB
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        hverkuil-cisco@xs4all.nl, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, linux-staging@lists.linux.dev,
        ming.qian@nxp.com, kernel@collabora.com,
        gregkh@linuxfoundation.org, tfiga@chromium.org,
        nicolas.dufresne@collabora.com
References: <20230622131349.144160-1-benjamin.gaignard@collabora.com>
 <20230622131349.144160-5-benjamin.gaignard@collabora.com>
 <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
 <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com>
 <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
 <a0d987e0-fcad-be76-a40d-2b5d43bd63b9@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <a0d987e0-fcad-be76-a40d-2b5d43bd63b9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0059.namprd02.prod.outlook.com
 (2603:10b6:a03:54::36) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|DS0PR03MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 737e99c1-2615-45bb-0dbb-08db7bb56e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/3Rjae+C56AGe+UBM8EHoa7qmHrA6ackHcXQP9Ysh5NvskDnj4LLQIhqMlKzyfZnKrfoGXdnLjMnMQb7cBuEcqotJjjBWUOjetgnB3xKd4WHuQhC1+x+6GyzNTVbDp0mCZ05hMLNoLcnmBPNdUOM2D/6Oem9fVDgJzi28jWxEk3KuV5oCmWCEAhq1j+F1CbmTHUKmxPlc6Lt4y7G5UQcvDyEOuGn197x5VMsE8GuF7N0bwPVpfhvDzea1xRi116bJuvD8vMz/YjPRcKwVp2qfLlM5KgQhxeSQsVCannwpkQCxz3QPkSnjnEB0GlWmQyHipmID/iRnZmjNuoANkl7y+ks2kRW91/juNGiF7m3gP2gluFlGP9SFRhkrOAjpsAJuFXpvkg5ZouMLQ75NJZNK5RXSd8EuUGjx41ZKWlCkcTLL1Q4ar23rBc7W2dRsaT5AvOW90/i3NHSCfba6D0QZFJRScc9AMiVJhH1U0PW3n1/GL6rfA4t/41xmrRfVbIEP5eFDvwtvI6bFTT/96UjmU9Jzg54mCLNgT5wuOoIatBLf2zysMndlffKfjgvOg3ByZWve3E3cVwDTcBAIexjkxoaZTOe4rxl4WDEMnpCH2Y+YTV1LKHUM4av5xzdZbCv13vExkaNTUVPTVnuLl/W4lRSKCscUE/NLaq1TbsQJ0bE4KRmtNCMawnMRHZ56q4FM/iozlEgSAuu2ksUx53pKNtCt3Q0eTHSSDhEvJKVpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(39860400002)(136003)(451199021)(36756003)(66476007)(316002)(66946007)(4326008)(38350700002)(8936002)(8676002)(38100700002)(186003)(41300700001)(6512007)(6506007)(26005)(53546011)(6486002)(6666004)(52116002)(478600001)(6916009)(86362001)(31696002)(66556008)(31686004)(5660300002)(2616005)(66574015)(83380400001)(2906002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?all1YkVXTGJpdzVRQTNUNm1QQkFoVEt4N0dJbkpSbmFNOHFBRjVOTW81bmdI?=
 =?utf-8?B?WFpobURZRm5mQTVLcW44NjN3TGJvVzAwT0F0TUVEOVJ2UWlaT3RMS1owYkdY?=
 =?utf-8?B?ZEJhcUxXUjBPdmxaV3NyYjVqSFVhY0krNDlQYldPdDZOSEppVlJUZUVxcERS?=
 =?utf-8?B?UlZtelRkVXNEb1RXU3lwRS9GdkEyNElHTzVRU2hpVzIrd2tpbDRrQ3JOdmo0?=
 =?utf-8?B?OHF2UTB2Z3VUR2E1djdzOUROaDJsdVM0Vndtd0FZUFVSY0Zjb1hYN0h4MC9w?=
 =?utf-8?B?aGpqYXUvMmlyWVk0bG9WQWZiUyt2RjVhZ0dIRGd1bGZJakJBN0g1dWZpQzB6?=
 =?utf-8?B?eDEraWhTWEJjb1BsS1A0UldsZExvVm5nQkl5TU9tZzVyZ0hKbzAzZ0lmTVp2?=
 =?utf-8?B?bHdWMFB1Nk5NWUx3amtNVVdKUnlMek9WZU5KckxTZXpWUlgveStnWHBBakdm?=
 =?utf-8?B?MXJRRldkQjFUN05lWmVBZ0ppQis5THJvMll5ZUNZRVF0TitNdXFFZVZTRXRK?=
 =?utf-8?B?TzdkQWNDQkVJU0pqeWJOclIyYnM1V3R1bm8zSGJUZWNXaWprWFlYdU1mRCsx?=
 =?utf-8?B?SmhlbXRwMnkwRG55Y0I5QzNwME14UW1POHVRam9rbWN2c0drdWZXMW9GVmtp?=
 =?utf-8?B?VzRCS2NGcUZibXhyUjJ0R3YxVHh0QXZUbCtqcTNDbWtVWHVCenNZWDh2dTRj?=
 =?utf-8?B?OEV3TVhPbVN4U0RHa0l5czZqeVpyc25DaUQ4aHN0cUtNeXM2RmplKzZSakxk?=
 =?utf-8?B?MnhOdVBubE02SFR3WVB3V2R2cCtEOERzTy9lRTF2UEZ1SDZoWTNnMHhZS1Zr?=
 =?utf-8?B?UHdSb2xnR2xyWlNCZFJkQUoxelVCd1dOZDUvRDVNOVMvNnFsNFRVdlRMcDZ4?=
 =?utf-8?B?ZXpmRHdKMHVIZkVkRm0xakNYNjVuTzNKQUVVZjg3SjM2eFREMERCZHJUemph?=
 =?utf-8?B?dThoeFRTZnFkWVFoQlQ0bjFxNmNZTG9EWVF3dXRpbG9lL0tFWCs0OE1ENjBy?=
 =?utf-8?B?SUZiaW1UZUtzOG81MjVzR2JzRHVSK3MvTTJ3dFp3RDdtS3hnOFRUK1ZqYWNt?=
 =?utf-8?B?dmVLQjJOdlRER3dNTy9YUWQweWtidVp6cmNDb09qOVQ4QUNWdWF4UFhTWTBF?=
 =?utf-8?B?RnFsaEdBTGNVSWJ0dGE4a0xJdnZiSHV2bjhBVkZ2dWxKdkUwbC9NWGxNa1l4?=
 =?utf-8?B?enh5b21Za1JQRitYcWpvbVF3NmlXNkZrajFYTEFkclpjdzZXSWhaNXdsMlJy?=
 =?utf-8?B?UVRyQVJTallaaWZ0MFc5RXAyRnR6SjlyWTBIY3RNTXRaN09hb01ET2VDY0ZE?=
 =?utf-8?B?d1p6Y2IwOExkRko2UjEvenZMcXRWS2lTVjZiMWRrbEFQU043M1FLZ2RId1pw?=
 =?utf-8?B?NFVjK29GNklDRVFrRnIxR0kxcWFodjcyUTZsVTJsNEh6N0t1ZW96RjFSaHlN?=
 =?utf-8?B?VnROdHlkdnNiVHlHeisvV2RMYzRWWVE2ZmVHeElNUVVaZ2N2NWNsb1puc2hW?=
 =?utf-8?B?bGV3MEtmV1NLYWM0cFhhT3RmemtMS1ZqM3U2cGpjczFNam9tTndOYnA1Mk5w?=
 =?utf-8?B?US9tN0dHbm9wdWdldXJJSDZrQlNZMDhsSFl4YndYQTQxMmNXeHJTOENRTnVq?=
 =?utf-8?B?WW14QTlXS0xaWlhFREIvZ040M0RTeU9tbEFZMytCRnljaXhHU3lLdGJzVlZm?=
 =?utf-8?B?MDFXenlMKytqTWw5bnZTZ2dlOFI0SUhPaUZpc05LVG92VFdCM01OUFk0Vnlx?=
 =?utf-8?B?RE82S29hWThyUmZNK3BVNGNQdFNmNDBsSzNPcjVUbVEzaEYvWTJnbDVSTXFI?=
 =?utf-8?B?NlNpU1BoNG8wV1B5dno2bDZ4dHJncWx2Ny9LZ0IzL1VwTmRsUFJpMzRhU244?=
 =?utf-8?B?YTNudzJablVMNDM2Z3RHVE9mYkFFRytkQzVMcnRXNTVrc01LeDlsSXFjWDA4?=
 =?utf-8?B?emtlN3pxT0hCT1YvZHhXV3BsdWpzY0hRdWc5NXNBcG9Nb0lTc1AzU1ZIb3lE?=
 =?utf-8?B?bTFiK25DZEdUbDZwdnhyYW1MUlM0eGpBOTg5T3pYbnpqc0syNDVpcURPRUNG?=
 =?utf-8?B?ZTdSN3BpLzlYaXc0U2pIaDIvSWMxNGVpOXFnSFFzRXFTOVVFd2t5bjIzalJw?=
 =?utf-8?Q?n/ALccstSmcIWwWDYGZ2Y7WXk?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737e99c1-2615-45bb-0dbb-08db7bb56e5a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 11:05:37.4734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvQdy/1wXUz0t6pA+4d6j5du57dfJtJq0qV9jH5jb7sQT0lnNenXQr0hQBrdx1/zY8pkJrq9eewRxaKX/5NU7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7277
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 18:53, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> Le 03/07/2023 à 10:35, Hsia-Jun Li a écrit :
>>
>> On 7/3/23 16:09, Benjamin Gaignard wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>>>
>>>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>>>> CAUTION: Email originated externally, do not click links or open
>>>>> attachments unless you recognize the sender and know the content is
>>>>> safe.
>>>>>
>>>>>
>>>>> After changing bufs arrays to a dynamic allocated array
>>>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>>>
>>>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>>>> more reasonable.
>>>>
>>>> It would be hard to iterate the whole array, it would go worse with a
>>>> filter. Such iterate may need to go twice because you mix
>>>> post-processing buffer and decoding buffer(with MV) in the same array.
>>>
>>> Here I don't want to change drivers behavior so I keep the same value.
>>> If it happens that they need more buffers, like for dynamic
>>> resolution change
>>> feature for Verisilicon VP9 decoder, case by case patches will be
>>> needed.
>>>
>> I just don't like the idea that using a variant length array here.
>
> As far I have understand Hans and/or Laurent were happy to use that 
> but I may have misunderstood them.
>
>>
>> And I could explain why you won't need so many buffers for the
>> performance of decoding.
>>
>> VP9 could support 10 reference frames in dpb.
>>
>> Even for those frequent resolution changing test set, it would only
>> happen to two resolutions,
>>
>> 32 would be enough for 20 buffers of two resolution plus golden
>> frames. It also leaves enough slots for re-order latency.
>>
>> If your case had more two resolutions, likes low->medium->high.
>
> VP9 header doesn't tell you that video resolution will change and in 
> which way.
> It cloud be from factor x1/2 to x16 and multiple time so you can use 
> lot of (too much) buffers.

I know VP9 doesn't have sequence header. I think you are talking about 
scaling frame, which should be allocated when it is requested.

And this can't break the max reference capability requirement of VP9.

>
>>
>> I would suggest just skip the medium resolutions, just allocate the
>> lower one first for fast playback then the highest for all the possible
>>
>> medium cases. Reallocation happens frequently would only cause memory
>> fragment, nothing benefits your performance.
>>
>>>
>>>>
>>>>> Remove it from the core definitions but keep it for drivers internal
>>>>> needs.
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>> ---
>>>>>   drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>>>   drivers/media/platform/amphion/vdec.c | 1 +
>>>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>>>   drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>>>   drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>>>   drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>>>   include/media/videobuf2-core.h | 1 -
>>>>>   include/media/videobuf2-v4l2.h | 4 ----
>>>>>   8 files changed, 11 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> index 86e1e926fa45..899783f67580 100644
>>>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>>>> @@ -31,6 +31,8 @@
>>>>>
>>>>>   #include <trace/events/vb2.h>
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>   static int debug;
>>>>>   module_param(debug, int, 0644);
>>>>>
>>>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>>>> b/drivers/media/platform/amphion/vdec.c
>>>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>>>> --- a/drivers/media/platform/amphion/vdec.c
>>>>> +++ b/drivers/media/platform/amphion/vdec.c
>>>>> @@ -28,6 +28,7 @@
>>>>>
>>>>>   #define VDEC_MIN_BUFFER_CAP            8
>>>>>   #define VDEC_MIN_BUFFER_OUT            8
>>>>> +#define VB2_MAX_FRAME                  32
>>>>>
>>>>>   struct vdec_fs_info {
>>>>>          char name[8];
>>>>> diff --git
>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>>>> ---
>>>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> +++
>>>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>>>> @@ -16,6 +16,8 @@
>>>>>   #include "../vdec_drv_if.h"
>>>>>   #include "../vdec_vpu_if.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>   /* reset_frame_context defined in VP9 spec */
>>>>>   #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>>>   #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>>>> b/drivers/media/platform/qcom/venus/hfi.h
>>>>> index f25d412d6553..bd5ca5a8b945 100644
>>>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>>>> @@ -10,6 +10,8 @@
>>>>>
>>>>>   #include "hfi_helper.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME                          32
>>>>> +
>>>>>   #define VIDC_SESSION_TYPE_VPE                  0
>>>>>   #define VIDC_SESSION_TYPE_ENC                  1
>>>>>   #define VIDC_SESSION_TYPE_DEC                  2
>>>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>>>> @@ -15,6 +15,8 @@
>>>>>   #include <media/v4l2-vp9.h>
>>>>>   #include <media/videobuf2-core.h>
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>   #define DEC_8190_ALIGN_MASK    0x07U
>>>>>
>>>>>   #define MB_DIM                 16
>>>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> index e530767e80a5..6627b5c2d4d6 100644
>>>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>>>> @@ -10,6 +10,8 @@
>>>>>   #include "ipu3.h"
>>>>>   #include "ipu3-dmamap.h"
>>>>>
>>>>> +#define VB2_MAX_FRAME  32
>>>>> +
>>>>>   /******************** v4l2_subdev_ops ********************/
>>>>>
>>>>>   #define IPU3_RUNNING_MODE_VIDEO                0
>>>>> diff --git a/include/media/videobuf2-core.h
>>>>> b/include/media/videobuf2-core.h
>>>>> index 77921cf894ef..080b783d608d 100644
>>>>> --- a/include/media/videobuf2-core.h
>>>>> +++ b/include/media/videobuf2-core.h
>>>>> @@ -20,7 +20,6 @@
>>>>>   #include <media/media-request.h>
>>>>>   #include <media/frame_vector.h>
>>>>>
>>>>> -#define VB2_MAX_FRAME  (32)
>>>>>   #define VB2_MAX_PLANES (8)
>>>>>
>>>>>   /**
>>>>> diff --git a/include/media/videobuf2-v4l2.h
>>>>> b/include/media/videobuf2-v4l2.h
>>>>> index 5a845887850b..88a7a565170e 100644
>>>>> --- a/include/media/videobuf2-v4l2.h
>>>>> +++ b/include/media/videobuf2-v4l2.h
>>>>> @@ -15,10 +15,6 @@
>>>>>   #include <linux/videodev2.h>
>>>>>   #include <media/videobuf2-core.h>
>>>>>
>>>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>>>> -#endif
>>>>> -
>>>>>   #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>   #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>>>   #endif
>>>>> -- 
>>>>> 2.39.2
>>>>>
-- 
Hsia-Jun(Randy) Li

