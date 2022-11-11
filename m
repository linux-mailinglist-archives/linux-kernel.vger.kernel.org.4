Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0362565D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiKKJOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiKKJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:14:03 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE45800C;
        Fri, 11 Nov 2022 01:14:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM17eKNegAxX1M1xcJSw1E7ZENbS4lA9C5+fCvJmg73MylaiUgwuk96XsrRV9szZjVhLgN9ESi4IoPV/hRCEMbZPBvRlT6TfFMtvc6WZx307DS6DgYwXufsI9mC7uuz/uYQfR8ET0P0cntJGXY8mqX5/cTl/Rb8d2jh5bO3+QeY9m2sMbjTLf8jwR56qD+zNCQ4hl0YTCKCifwAq2Xcrk7KOdrRwn1UbKOAWo/jFjGSSf0+B7hWOCjz9ZvQTpsxvkiCNcqo2JjYeJ/CcVqrH+zcadYudniQrPurCH8KtZ7GyyH93rdfd3ensMcxhP5npTfDgmvzwI6Zc4LnxpEZTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKDpUVdUgzZShfkRONApw2H/8OSut3+L4FLhYf1LOFg=;
 b=lnj/HROWkIO0bVmAVvO8Miytks5nOderHTTn9k+52dU/f6UoDsbjGR3ejAcbH1qEf7ql0G+sE0yRhdEbbj/dMKm7EHCDXNHP8QQrmyM4dNbctTbVUxprDNP4OXpSbGVf/Ce/Azj+xLT9PfuzCg5GZF22bBNa3z54eDCrLCrMSY+8wuapzJQKstVwV2qpp46+ERfmqwLhRDHAoTdKQWXbFrzS/dwc2VQuFX7mCu/q2rn/Wx5unUYh+s3NyeddmCLe6y1pDuxAgyH7qembZlhDjjMJ2wAUy08D+3mP1E9RlcpBouc0Oh5tB9wh8Ar39M4ekQHM1NmqfJQGl1KbEF5c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKDpUVdUgzZShfkRONApw2H/8OSut3+L4FLhYf1LOFg=;
 b=Ue4hkrfvrbfvj5B7R+AqfnOMQ6iDc2l7nDHv/shEDIZyuZrzOu8tywL21eSuTj2qbzfnNOGfldXF7jg7S09JL3l+C1l4THXol/2r0zj3H5t+7anVVjdM8zKRnSmDnVbST/rFBOYVqEQomzWH733Pp33ZXvRW1VHeOxrKuSalVsw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 09:14:00 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 09:14:00 +0000
Message-ID: <60870934-1842-161a-5ece-9e188ebbf279@synaptics.com>
Date:   Fri, 11 Nov 2022 17:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-US
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>, mchehab@kernel.org,
        hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
        sakari.ailus@iki.fi, boris.brezillon@collabora.com,
        hiroh@chromium.org, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
 <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
 <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
 <91a96b4a-a91e-aae6-733f-c307ca6840f0@synaptics.com>
 <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5DD4QgDs-Dff_SB2tNT3d9Hs8HG0rkQFPV+6vgvKqg+qA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW4PR03MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab253fb-7ef6-446e-d930-08dac3c511c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YinsYGM/m6IEeWgS+BXGUPmgz26cA58ir0/p5o1p0Yk3GmF/JF25chMVJmudvYbBmcotXbYcPa/NWkrIqHQmlyaE8TdsAN+rH1+/apxqT3zwLj/pp8DujkaZa4cn8gnmOFUZVYkRu7Z5K8Ynfqs/sXQQanDWnMPUFJLEqkcCA2whoid6W3ekZK1d3UwEVEUfCQqXH9AWn9FBHGgenulXVdHtozB/FnokHp2lRCQ7Z6dFSQEg8+2mH249Kw9nE9nKM4NDX6HA6ETlaiLAnIDfN3rOQ6dN85Ve0LFxvzLfHnuyLDl0tmhet6Vy+04yfMCXSy8BTT0ipMiXq8q3H6dvdGlQWGpVmpdE4/moyxvhyAWfQ8SwzqzAEL0gjLLTSKYwlkRt4x/QF2eAQEcnbULPRbXOIAFMg/FfNQYEurhcYoEIpzLtagPKxHUbz80AMnZJW9q9Ohe3iaCbUyHuZe2qB+OX69JdCk9Q6MXfnA5UX3byZuG1fZ2uD5TPyqxgniVV9rfnoZnSUW75A3vOf3AZ3Qrt1eJOJQICh4TP8Wzt7hsaUj8FfU3QbB2/HXhFW1to3vdKAEFia+WL7REXESeP+rPfUsAwKEhVZnXlgcutXgzneJvzfdsMAhBCC/CU9p+jO27LGPwCOVJfbogpT2cGEIJoBBmzGaBQGUCswGFSjqYi9OVovbMgogLSFYRHejqsMQr8sX8MZkdRgJG5ojzrBjhy+62G+ZqQB+RecOl0xqNqWM0T0Tc2TNJhMWT2KR+1Vbsnx4W7mNnxpUKm1vnYt104VBA9SbzgOKki0mUEDgzsHYzETSFta/fQS1C+5Mlp99On+D0ZdlhtLJwE/6AI0hz2xU6J/gJa37L2peD6f5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(966005)(66556008)(66899015)(6486002)(6512007)(66476007)(31686004)(26005)(4326008)(8676002)(66946007)(66574015)(83380400001)(2906002)(86362001)(478600001)(31696002)(6666004)(38100700002)(6506007)(53546011)(8936002)(2616005)(41300700001)(52116002)(6916009)(54906003)(5660300002)(36756003)(316002)(38350700002)(7416002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUxYZmJwVlZkUEFlL01OR3pWYjRYa1dZcmd2UzdFNXJkdXFoMjNwd01JK1hL?=
 =?utf-8?B?Z1ZQNXhvUzc3anFCcXp1SEh4dXdkaWVIMmNNNm1ocTgreUJjZ0RuNzNCN2Zs?=
 =?utf-8?B?Q09JOWpBTW5LMHZ2UDM5YjQrNWJyWlB1MnR0RWJvNFRuSDhXcEUzUlp1LzN1?=
 =?utf-8?B?dUNLa1RYM1Jiajl4cE4veUtVYURpK2lBQkVFZk40QUFLejM2RVV1RnQ2T05l?=
 =?utf-8?B?UE1OS3MwNTYxdGJlNGpsakgyWElRZUxVSDdGSDJJampNaXBpUWxmOFg4TkNz?=
 =?utf-8?B?U1drTWE2ZExQZXE2UG9jbCtLaFZvODQzTDFNcGRMYUtPSkxuN29VNDhFd1VY?=
 =?utf-8?B?NGpIY0c4Y0srREhNazQvTVBXT1gzekhaQmZBN1lTK2JNeURxaUJYUXU1NDVm?=
 =?utf-8?B?WWFDNnFScE80MEtRY21nY0hJMlJJdkU3MzUwZW52bGhkK2pUaG1QbFJMc29R?=
 =?utf-8?B?U2orSUxiKzN6K0drTkVGaDgzVThvdmNyKzROZzdiQlBKV0lxQTBaZDcydW9v?=
 =?utf-8?B?ODU2dVRrcHIyMlNmTDhsYlI4cldjWHFZR0dOR1VqRnZQUGRxa0JuWmhVUUc1?=
 =?utf-8?B?T0pHeEM2NkQ4amdqdG9seGh1bk1PN0VsTmpyWFpCM3B4VG85LzZCY2lqLzBT?=
 =?utf-8?B?ak5VUWtROUZxNXB4QWx3VFJpdFBDc2Q5b1o1RDBlWndPNG15UzZUZ0FhQWFn?=
 =?utf-8?B?aGsvdkk5RTh4dElGeStodmRUVFdJcnVCN203aVg2Z1dBMjFCTFJxc1ZSVjBI?=
 =?utf-8?B?dElTK2N5TnA1UWtsamNFTmZyN1FuQTVzQlZZaXNHRHIycEI3a2dma1p6anRE?=
 =?utf-8?B?Uzd2azEyZnB5cWlKdXJmOVpOQ3VxZ1k3S3UyVm5kdnd5TDg2RHRVV0tDdWph?=
 =?utf-8?B?eCtKQVpRclhFand3cWxLSzR4c2txMzhpUXorclI2U3FzVVJFNVFUa051RWlE?=
 =?utf-8?B?Rkk0WEpQWHRzY1ZVWUZpeVlpMVNtbUQzWko3d25RS21GZnYzMnlSSU9IR0FK?=
 =?utf-8?B?c05DN3B2dUlKUWd2SXpHcDZ4R3B4U21xeWliSm1uRWp0a2FGeW5UUzR2TmQy?=
 =?utf-8?B?NkdQcXpEV2RUQWx6UURpUXdzZWJSdGZNc1c2ZWNtR3FNVkRlOHZudk0zWkxy?=
 =?utf-8?B?RVpJaTdBalpUQklHNWV3T0dzZFh3ZWxWSjQzSTRSS1RSdDRvcnNSalFvc0p6?=
 =?utf-8?B?TEVEMmdLczF6RkxyUHcyc3l2Z05aenVjZWpqRWU5Um94UXpzRHJHOUg1ZE5R?=
 =?utf-8?B?WWVudjFGc2lDbEFtUXBrbmRZUjRHcDdHNzBDTmpHS2poV0JvOGNFRFR0NnFG?=
 =?utf-8?B?QURpbGlkS3I4dGI3Q2R2SUlMSVhiQzNvL2MrcnErYWFUTldaSUNNM3RtK0JR?=
 =?utf-8?B?bTJPdzJxdHZaVkU2dUlpUGRXcTlIU1FBOUNtY05pclJTTE5WZy9FaGt0dWtq?=
 =?utf-8?B?YzRET29PSjh4WnQvVnBRc3ZwMWg4WDFtMlhHL3JFZWpNajR5NWdMM2hZQVV5?=
 =?utf-8?B?MCtsVTV3VlA2TjN5NzZSZ1NsYkJJUXYrMmVNNDMwT0oxYlNOU1EyS3lKMFQ4?=
 =?utf-8?B?cE1lalhCOUliNEtDdXVhVnhxT0V0RnI3ZzF4V1FXOFAxbUNMTjBOTmVFNFNS?=
 =?utf-8?B?bEg4UTQvN2dXSmpuaUFpakgzd211c3JXRXJ1ZTNEYklNdC9ZWmdCYS9saXMr?=
 =?utf-8?B?ZlVheURRd0JBZ2hrSURzd3hJSEs5WXhCQkE2S0pEdmtKSnNoNWtSenppbFFL?=
 =?utf-8?B?ajE1M1ByR2JjZFVLSEkrQVZNQys3NTkwUVEwUnZPWHpQRXVWbmFST01rbmRo?=
 =?utf-8?B?S3JocGt4UkNxVEwySUhmU3pQZ04vUzR0THM2R29KZHRTOEFVV2lMc1hQRk4r?=
 =?utf-8?B?TnpRdDd2bW9HRU9XclJsT1QwRHo5bFN4d3Znc1VYcHZORDlHZ1pjR3pPNmlm?=
 =?utf-8?B?dFNBeUFodWxvWXFGY3lqbjk5ZzV4SFRuY0wxdnJ4UzJBY1RCbG1LRktncCsx?=
 =?utf-8?B?cXdiRmxNREJPSkxIN0lGYU5KQVZBKzJtcElsaGJEb2lmSmovTTFoTDhvald0?=
 =?utf-8?B?dFcveG1HTU1GREV6WVZscWxITHVIMk04ekwxL1Y0bHJzbkFzdHRVSzh6elRn?=
 =?utf-8?Q?HSreRJebVJTrcmnos/olhI2TI?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab253fb-7ef6-446e-d930-08dac3c511c4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 09:14:00.1683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lA18pzT+VBS/GdAYfsGKkTnjFPgCTYXe0TweHHuUHfRU/4NMOlMlJUifMVF2spjTpWzNaSkyhAh4dw7ZpGIZKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6379
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 16:52, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Nov 11, 2022 at 3:31 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>>
>> On 11/11/22 13:48, Tomasz Figa wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>>>
>>>>
>>>>
>>>> On 11/11/22 01:06, Nicolas Dufresne wrote:
>>>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>>
>>>>>
>>>>> Le samedi 05 novembre 2022 à 23:19 +0800, Hsia-Jun Li a écrit :
>>>>>>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
>>>>>>>> VIDIOC_ENUM_FMT
>>>>>>>> would just report NV12M.
>>>>>>>
>>>>>>> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
>>>>>>> report both (unless I'm missing something, which is probably the case).
>>>>>>>
>>>>>>> The idea was to deprecate the M-variants one day.
>>>>>> I was thinking the way in DRM API is better, always assuming it would
>>>>>> always in a multiple planes. The only problem is we don't have a way to
>>>>>> let the allocator that allocate contiguous memory for planes when we
>>>>>> need to do that.
>>>>>
>>>>> Its not too late to allow this to be negotiated, but I would move this out of
>>>>> the pixel format definition to stop the explosion of duplicate pixel formats,
>>>>> which is a nightmare to deal with.
>>>> I wonder whether we need to keep the pixel formats in videodev2.h
>>>> anymore. If we would like to use the modifiers from drm_fourcc.h, why
>>>> don't we use their pixel formats, they should be the same values of
>>>> non-M variant pixel formats of v4l2.
>>>>
>>>> Let videodev2.h only maintain the those codecs or motion based
>>>> compressed (pixel) formats.
>>>>
>>>> If I simplify the discussion, we want to
>>>>> negotiate contiguity with the driver. The new FMT structure should have a
>>>>> CONTIGUOUS flag. So if userpace sets:
>>>>>
>>>>>      S_FMT(NV12, CONTIGUOUS)
>>>> I wonder whether we would allow some planes being contiguous while some
>>>> would not. For example, the graphics planes could be in a contiguous
>>>> memory address while its compression metadata are not.
>>>> Although that is not the case of our platform. I believe it sounds like
>>>> reasonable case for improving the performance, two meta planes could
>>>> resident in a different memory bank.
>>>
>>> I feel like this would be only useful in the MMAP mode. Looking at how
>>> the other UAPIs are evolving, things are going towards
>>> userspace-managed allocations, using, for example, DMA-buf heaps. I
>>> think we should follow the trend and keep the MMAP mode just at the
>>> same level of functionality as is today and focus on improvements and
>>> new functionality for the DMABUF mode.
>>>
>> I know there are still some devices(encoder) which only have one
>> register for storing the address of a graphics buffer.
> 
> For those, the legacy MMAP mode (with existing functionality) can be
> successfully used, we wouldn't be removing it any time soon. Just
> don't want to design new functionality specifically for the legacy
> mode.
> 
But it prevents the encoder using the buffer from the outside.
For example, there was an PCI-e interface camera which would write to 
the system memory where is configured to its register, then we would 
like to encode those buffers.
>>>>
>>>> That lead to another question which I forgot whether I mention it before.
>>>>
>>>> There are four modifiers in DRM while we would only one in these patches.
>>>>    From the EGL
>>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__registry.khronos.org_EGL_extensions_EXT_EGL-5FEXT-5Fimage-5Fdma-5Fbuf-5Fimport-5Fmodifiers.txt&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=mCebYOAiZK6pbpH1MrZGq-ZkDW-OqORCSwsCEX9ScgdXk_yfWZFJPC5aC93CUg5F&s=rtmW_t2LYoJ6g3Y5wgyICmABu-2Npw3JCOlvUVIYH2o&e=
>>>>
>>>> The modifier for echo plane could be different. I wish it would be
>>>> better to create a framebuffer being aware of which planes are graphics
>>>> or metadata.
>>>
>>> What's an echo plane?
>>>
>> They could be
>> DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
>> DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
>> DRM_FORMAT_MOD_SYNA_MTR
>> DRM_FORMAT_MOD_SYNA_MTR
>> Or
>> DRM_FORMAT_MOD_SYNA_V4H3P8_64L4
>> DRM_FORMAT_MOD_SYNA_V4H3P8_64L4
>>
>> in our platform. It could give a better idea on what is stored in a plane.
> 
> Yes, that's what I was thinking, but my question is more about what
> those planes hold.
DRM_FORMAT_MOD_SYNA_V4H1* or DRM_FORMAT_MOD_SYNA_V4H3P8*
would be the luma and chroma (un)compressed data here. They are 
modifiers to NV12 and NV15.
  Are you sure that they should be planes of the same
> buffer rather than separate buffers?
I am not sure about your question here. I prefer they are in a different 
memory plane. But not all Android APIs support that. If I just think 
about our platform and GNU Linux, I won't care about those limitations.
> 
>>> That said, it indeed looks like we may want to be consistent with DRM
>>> here and allow per-plane modifiers.
>>>
>>>>
>>>> I wonder whether it would be better that convincing the DRM maintainer
>>>> adding a non vendor flag for contiguous memory allocation here(DRM
>>>> itself don't need it).
>>>> While whether the memory could be contiguous for these vendor pixel
>>>> formats, it is complex vendor defined.
>>>
>>> Memory allocation doesn't sound to me like it is related to formats or
>>> modifiers in any way. I agree with Nicolas that if we want to allow
>>> the userspace to specify if the memory should be contiguous or not,
>>> that should be a separate flag and actually I'd probably see it in
>>> REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
>>>
>> I agree with that. But here is a problem, if there was a display
>> device(DRM) that only supports contiguous planes in a frame buffer.
>> How do we be aware of that?
> 
> That's why I think the MMAP mode is not scalable and shouldn't be
> expanded anymore. Both V4L2 and DRM devices should describe their
> constraints to the userspace and then the userspace should allocate
> accordingly from the right DMA-buf heap. (Or as Android and ChromeOS
> do, just have a central allocator library that understands the
> constraints, so there is no need to query the drivers.)
> 
Because we are working for embedded platforms which don't have memory 
beyond the system memory. I believe those GPU vendors would hate idea of 
DMAheap only.
>>>>
>>>>>
>>>>> The driver can accepts, and return the unmodified structure, or may drop the
>>>>> CONTIGUOUS flag, which would mean its not supported. Could be the other way
>>>>> around too. As for allocation, if you have CONTIGUOUS flag set, userspace does
>>>>> not have to export or map memory for each planes, as they are the same. We
>>>>> simply need to define the offset as relative to their allocation, which I think
>>>>> is the most sensible thing.
>>>>>
>>>>> Nicolas
>>>>>
>>>>
>>>> --
>>>> Hsia-Jun(Randy) Li
>>
>> --
>> Hsia-Jun(Randy) Li

-- 
Hsia-Jun(Randy) Li
