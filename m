Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB46745771
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 10:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGCIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCIfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:35:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB1E44;
        Mon,  3 Jul 2023 01:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvTMYrJzm+Ng+2FOJUcWNUT20fv8gwOMdGq4tdC4OkylhksyAoH3K3/ihcqFJGx6nnRPDCabxZwoGoJd0ASqglv4L3QDJuYRyiT9WU+McyxlFmsGr2wtVdbYCHwtF57/Ktz4/n5FTI/ZNHIksIjcIvqYLtYeQo2yXDLyquKqZqHsKpNbiFCvxcL05/O/Fed/gy7BLxdvOqCKRXyjCKnHB9whSyWmizz3GPa22mwiG+ujltSK3knfRgfCGsmjYx+A2fTstzY/XIugLA8N5cmUzMx8DOAuTLG49G1dE5WIfkxkKA0Ts+RCD3QBnIAbcsUdMm1TlkdHqL53eCaPxAh6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXYZmpJUpbSYTXnd2F4QLWkGX/o4clLvmyUwZJ1biY=;
 b=DLcZYQp3gsrHfjBDEq8Gl7VkGgjWv7O/8Zu/cK4tYr8Y7I1M2dcA9PMv2FVpIE5a72eNHDbS/i5eVOZHKapIqTYsoiruWV8YePtR07XVW0RCcBSPN0RfGGEEGh3oK4B8Q9lm4UC/9Mg5Yt7gsdK1pr2P1CHoL5c2LBctaN11g3Qq06ovMW2fmpeku9DrAeOuR84SxniMKWfqWH07nKsz1NlTTl10qtU5U/M725H9Oczmq4lRzvq4uO+hAFsVPcKAALIUhe81y9w5z7wYxqJLg4Es9SwgVWaxRyRFmtoyZfoSE/ctcGc2gSIxjIEoKHHboFYJXcGtQKKcQ59TSLNm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxXYZmpJUpbSYTXnd2F4QLWkGX/o4clLvmyUwZJ1biY=;
 b=mKpOUFcOWVrJzIbansEH3DSjUEQeFmQtZ7iUJJZeOHpZuglQGPjN3tkOT7dcYTZfQM5zC4sLu7zBRCBpvqbSrIFAnHFdqXBdV0nkGLQkWsvzkzpwbqRtW5bOMA2XXKMbB8vChJ748+FdvkT7f7usDrsE9r8pXcdNuUIllvRxvGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 08:35:39 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 08:35:38 +0000
Message-ID: <25b21252-0d3a-3e50-0012-57055f386fee@synaptics.com>
Date:   Mon, 3 Jul 2023 16:35:30 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <5cb3f216-5041-a155-5d2c-059dc1f15024@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::33) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BN9PR03MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d1422f-48e6-4956-650e-08db7ba07a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqAGwFESGZ3Xm6T0p87nvXx2CxRoxX/qhMtvqOpWgaX0a6Ma+QPfqFFLAKMCQtArQY/SUdbwbYLgz4+C2BSP7wQXt57qW1PEV6Ip00ZNfP5FvyhRmj4OkQWa1rfPdMelXyvVyPRSKatWBsch1LLWV1bAcys2r74gbe0P4l0oRqq7FAMHwIZtYNdbgugIryAL1V24mcHo7dTHlzBWIdGZ+16mUO47B+hP7l7q2bTEntWpIg2BJsnG+iLozbs91/n8DiEzodfgNX0M/kPDfq6gzjxnpJPnBhwZDCxbsKrilQHvNEGojsB+3AhXRVynWOQPo/6qkFFTxyCeV48LeVrhsK6SzPb6iFwujxV2LRvNbPqysdyci/lz7/YS+64uXCupeNYmPTM7JshK/FOJf13pI0PzoUllxhiXNkli2ky2ZQjpdSn/N9ZuzAOkQK41BbC8lWEaOJ8EvK1NW4jRUTy5zvxsYzj1AoCMdUfgpJwE0+CH4pfXHWo57CdFscrEgFen1k8FgKcyh9FAd0w88kIrueUYKgJLYshqVb2diQsWhEiKHBVE3bsgj167krNB8jTgW4ErJt6R8KhJ6Wa5pSbFJbQwXqzUXeguib3jW4TVBZK7X4bttrC4qDKr74mOGE5E9yqH272FSmqKqbiHcZyip++toy2YrYV+309kuRdf5ctES5mRG6k5ab9QaJrdfUVH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(26005)(31686004)(478600001)(6666004)(6512007)(6506007)(31696002)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(66574015)(52116002)(6486002)(53546011)(316002)(5660300002)(8676002)(8936002)(7416002)(41300700001)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BwUS9Gc1RraFhWWXluazNva3g0bUIxNVVtekluMjArZDRBNGxXb1d1N0li?=
 =?utf-8?B?V01IQXJmdTM3am1UYTFCdjhRTENMUFNOeVpoUEpMbGlUNkVnU0NYMFBiSG81?=
 =?utf-8?B?NUx1Q0d1TENPY1NTVS85Z2szWi9sVC82UGhWS2M1ZXZQS3dvVmdyRG9wek9h?=
 =?utf-8?B?ZmN4US9wcTU4Ykw5V2krVEtIZ2d6bTYwRFFGUmdPNTBUMTlzWGdqbzhjRFNk?=
 =?utf-8?B?Ujh1S00wQUtwUEt4L2lyWkl4R1l2OXNQaWpIaFM1QVYrUzV2ZHFCMFpqckt2?=
 =?utf-8?B?Zy9VVDhzOXNKenJVRWFJL0VwcDk4RXRYT0hCcUxZTkRrWHkyYXlSYUs3aVlx?=
 =?utf-8?B?WHd1em1kVy8rMnQ3dHZQbExMejdyWFBrR3BPRnJ0Y0Q4cllXbGFSSysveVhx?=
 =?utf-8?B?Y2ZURmRBcytaTDlkTXVEMkJVSTE5TnN5c2NiaHZUaUVWeHA0VHZBK2lHcGhn?=
 =?utf-8?B?U3pieXVCUjRKUHNYWkRlQ3d4ZVg4R0E3ZDZtU3Vmb29NSlgxVytYZGlUb2Rv?=
 =?utf-8?B?UWRZbUxYUmJaYWNacVFUNStVb0dMQmVkTmJ3UVp0VG9LdVRLQ09peUtaVUxO?=
 =?utf-8?B?dUtFSElxSlhiS2JybG95eXkrdDFHY05NUHBrV2wrcVRVK21MQUVWa0d2eElW?=
 =?utf-8?B?ajJKLzNCZjFrTFB0THJmYXNOYjRLM1pwamJFNUtyRE5lTFpFQXliVVlvcE9U?=
 =?utf-8?B?YkZJSElpdFRlOUFIeEpaUDhtYTd3YWZrekdWSjNvSWQwdENSM3BOMXo4bEdK?=
 =?utf-8?B?TkpUbWtoYmtvNTIwRW40d2pHVDJubndkVFBVRUtZbmcwMEFjY3REcW54NWEv?=
 =?utf-8?B?V1Eya1c2UnNSeDN6QlhUV2VJU1NYeTRGQUk0TzBQZnlSTXdzTFpXTHZLdFFY?=
 =?utf-8?B?Q3ljdkxSTnYrYzdmMjdUc2dpWUhWVXk2V1MwTDE3UW5lOFU5cGxCMStSZFIw?=
 =?utf-8?B?cGVoVWsrSnI5RUEzS0ZWa3IvRXVkMzBMM3pkVkUyWDBDcXZKNng4OTR5bFJK?=
 =?utf-8?B?aVVCUHJUK1k4bnE3OHErQjNSUXlVWjRFTE56VVRGeDMvVE1STXFOYW9GS3dq?=
 =?utf-8?B?bTZ2RkQ3a3RYTEtKVEg0cnp3NHRuOEFiSUFhZmVWVzE3NTZnRHZBRlNlMmJD?=
 =?utf-8?B?ZlE5Ukx3alo0SExaVmFGL25uZ3VoRG5SRmtOckZjOVNIRzNSbFFkQmxGaWxp?=
 =?utf-8?B?SE9EUm5Md0tpQkVTb0tWcU92UjZrNVBHU2Y0QkNTY0VWN3gweGdtY0doQjlh?=
 =?utf-8?B?b3piT045MHZEQmZjV29jTnVVZ2dyQjZ3YWxEUVJ2SmdIdXlqUGprVXZ0ZVMw?=
 =?utf-8?B?QzZpMWFkYVlCTVFuYUxIb3RPUnRFbjZBeU9jMVgyRnZ3bXc0eG93TW9UK3Z1?=
 =?utf-8?B?V1pocTRPcVJOVFVNUHcvRXVXN3lRT1dOaWc0VDBzdTMwQkdRRnN0ZXluMWxG?=
 =?utf-8?B?UGI4SnJOSWxTS3EvOGs4NzZrK0gzM3VnMVhwUFBJUm9DdGZjdFhoektqTk1R?=
 =?utf-8?B?SWNySXAxeHBmZHlOdlJUUmdTd2k2amZxekRGSDRNOEwrbnp0bjVXcjJoTGRZ?=
 =?utf-8?B?b01BTFphZXkvMU9KRUNCb3VlZ2p4aXF2THVjcjhLWHdRdERQTTVKbVdCam9T?=
 =?utf-8?B?Tjd4OElWcXNudVJTelB1eFp1OVZkczZCck1LK1hxdzRnSERLbHdkZnUwQkx1?=
 =?utf-8?B?Tll6bzdlVkdVU2VzbXpUcmFpM0NUWWJQcmFFWDdRTGNwZFFkSzJpSGZhWVlF?=
 =?utf-8?B?K3ZBUXRNSmNPVUI2NHNHektnWlU2TDJxd2h5N2FtdnlCQUI5UmNscE9rb1kr?=
 =?utf-8?B?aFU2WldxYTM0Q3ZwM1dLR3c3TzNMdnlMdE8vcWNvREJvSlNyOEMyQnZwbTVM?=
 =?utf-8?B?UDhQK29JNGZlYkRmMlQrNkUwdFM0SmM1c0NkcFhIQ0J5MUw5UDdRQnZDbFJz?=
 =?utf-8?B?L2IxQktoV0IzZXkrdlVDSGk2VkRlTWV2Qk1PTDdRRzJlUTZ1MlYycE9YK0NR?=
 =?utf-8?B?K0REeXIwVUtlbTA0YnNBdjFWcnQ2Um5WcWliV0xISkxjVUxGZFhXRnZnN29s?=
 =?utf-8?B?QnRCWjhuZWwza1FjQlR3akJoTmY3YlV0bWZPeGduSzlhbVdpL0E1UlJZQlAw?=
 =?utf-8?Q?oO1GVOzDZGRQzudi3GKReBEjj?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d1422f-48e6-4956-650e-08db7ba07a7f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 08:35:38.4169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyozrvIdu+LDsyKNsp1k7ugEG8veho+CT3ALItpQksLwEKf1OWHHkHFkFJhAUGkahRYN+tmKByQoa6PvJwwtCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 16:09, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open 
> attachments unless you recognize the sender and know the content is safe.
>
>
> Le 30/06/2023 à 11:51, Hsia-Jun Li a écrit :
>>
>> On 6/22/23 21:13, Benjamin Gaignard wrote:
>>> CAUTION: Email originated externally, do not click links or open
>>> attachments unless you recognize the sender and know the content is
>>> safe.
>>>
>>>
>>> After changing bufs arrays to a dynamic allocated array
>>> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.
>>
>> I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is
>> more reasonable.
>>
>> It would be hard to iterate the whole array, it would go worse with a
>> filter. Such iterate may need to go twice because you mix
>> post-processing buffer and decoding buffer(with MV) in the same array.
>
> Here I don't want to change drivers behavior so I keep the same value.
> If it happens that they need more buffers, like for dynamic resolution 
> change
> feature for Verisilicon VP9 decoder, case by case patches will be needed.
>
I just don't like the idea that using a variant length array here.

And I could explain why you won't need so many buffers for the 
performance of decoding.

VP9 could support 10 reference frames in dpb.

Even for those frequent resolution changing test set, it would only 
happen to two resolutions,

32 would be enough for 20 buffers of two resolution plus golden frames. 
It also leaves enough slots for re-order latency.

If your case had more two resolutions, likes low->medium->high.

I would suggest just skip the medium resolutions, just allocate the 
lower one first for fast playback then the highest for all the possible

medium cases. Reallocation happens frequently would only cause memory 
fragment, nothing benefits your performance.

>
>>
>>> Remove it from the core definitions but keep it for drivers internal
>>> needs.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   drivers/media/common/videobuf2/videobuf2-core.c | 2 ++
>>>   drivers/media/platform/amphion/vdec.c | 1 +
>>> .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>>>   drivers/media/platform/qcom/venus/hfi.h | 2 ++
>>>   drivers/media/platform/verisilicon/hantro_hw.h | 2 ++
>>>   drivers/staging/media/ipu3/ipu3-v4l2.c | 2 ++
>>>   include/media/videobuf2-core.h | 1 -
>>>   include/media/videobuf2-v4l2.h | 4 ----
>>>   8 files changed, 11 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c
>>> b/drivers/media/common/videobuf2/videobuf2-core.c
>>> index 86e1e926fa45..899783f67580 100644
>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
>>> @@ -31,6 +31,8 @@
>>>
>>>   #include <trace/events/vb2.h>
>>>
>>> +#define VB2_MAX_FRAME  32
>>> +
>>>   static int debug;
>>>   module_param(debug, int, 0644);
>>>
>>> diff --git a/drivers/media/platform/amphion/vdec.c
>>> b/drivers/media/platform/amphion/vdec.c
>>> index 3fa1a74a2e20..b3219f6d17fa 100644
>>> --- a/drivers/media/platform/amphion/vdec.c
>>> +++ b/drivers/media/platform/amphion/vdec.c
>>> @@ -28,6 +28,7 @@
>>>
>>>   #define VDEC_MIN_BUFFER_CAP            8
>>>   #define VDEC_MIN_BUFFER_OUT            8
>>> +#define VB2_MAX_FRAME                  32
>>>
>>>   struct vdec_fs_info {
>>>          char name[8];
>>> diff --git
>>> a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>> b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>> index 6532a69f1fa8..a1e0f24bb91c 100644
>>> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
>>> @@ -16,6 +16,8 @@
>>>   #include "../vdec_drv_if.h"
>>>   #include "../vdec_vpu_if.h"
>>>
>>> +#define VB2_MAX_FRAME  32
>>> +
>>>   /* reset_frame_context defined in VP9 spec */
>>>   #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>>>   #define VP9_RESET_FRAME_CONTEXT_NONE1 1
>>> diff --git a/drivers/media/platform/qcom/venus/hfi.h
>>> b/drivers/media/platform/qcom/venus/hfi.h
>>> index f25d412d6553..bd5ca5a8b945 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi.h
>>> +++ b/drivers/media/platform/qcom/venus/hfi.h
>>> @@ -10,6 +10,8 @@
>>>
>>>   #include "hfi_helper.h"
>>>
>>> +#define VB2_MAX_FRAME                          32
>>> +
>>>   #define VIDC_SESSION_TYPE_VPE                  0
>>>   #define VIDC_SESSION_TYPE_ENC                  1
>>>   #define VIDC_SESSION_TYPE_DEC                  2
>>> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h
>>> b/drivers/media/platform/verisilicon/hantro_hw.h
>>> index e83f0c523a30..9e8faf7ba6fb 100644
>>> --- a/drivers/media/platform/verisilicon/hantro_hw.h
>>> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
>>> @@ -15,6 +15,8 @@
>>>   #include <media/v4l2-vp9.h>
>>>   #include <media/videobuf2-core.h>
>>>
>>> +#define VB2_MAX_FRAME  32
>>> +
>>>   #define DEC_8190_ALIGN_MASK    0x07U
>>>
>>>   #define MB_DIM                 16
>>> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>> b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>> index e530767e80a5..6627b5c2d4d6 100644
>>> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
>>> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
>>> @@ -10,6 +10,8 @@
>>>   #include "ipu3.h"
>>>   #include "ipu3-dmamap.h"
>>>
>>> +#define VB2_MAX_FRAME  32
>>> +
>>>   /******************** v4l2_subdev_ops ********************/
>>>
>>>   #define IPU3_RUNNING_MODE_VIDEO                0
>>> diff --git a/include/media/videobuf2-core.h
>>> b/include/media/videobuf2-core.h
>>> index 77921cf894ef..080b783d608d 100644
>>> --- a/include/media/videobuf2-core.h
>>> +++ b/include/media/videobuf2-core.h
>>> @@ -20,7 +20,6 @@
>>>   #include <media/media-request.h>
>>>   #include <media/frame_vector.h>
>>>
>>> -#define VB2_MAX_FRAME  (32)
>>>   #define VB2_MAX_PLANES (8)
>>>
>>>   /**
>>> diff --git a/include/media/videobuf2-v4l2.h
>>> b/include/media/videobuf2-v4l2.h
>>> index 5a845887850b..88a7a565170e 100644
>>> --- a/include/media/videobuf2-v4l2.h
>>> +++ b/include/media/videobuf2-v4l2.h
>>> @@ -15,10 +15,6 @@
>>>   #include <linux/videodev2.h>
>>>   #include <media/videobuf2-core.h>
>>>
>>> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
>>> -#endif
>>> -
>>>   #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>   #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>>>   #endif
>>> -- 
>>> 2.39.2
>>>
-- 
Hsia-Jun(Randy) Li

