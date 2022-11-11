Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEAF6253D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiKKGcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiKKGcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:32:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D26CE5;
        Thu, 10 Nov 2022 22:31:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hbh0MeGAxeukl4qCkQT1epQXtUQY8HyHg1Aj1fWnpJP0NzN4O6/sxz9GmFLnLvnc52CXlbIFTkCF6ojr20/XA4Eu318m/2AvTzTN0MmWbBNHHD29eRvaG2Okj7APbEX4BWcdRymwkHCG2cCIqTmuvBY3FZUbbjpju+HwOCZDPWyWUnZTHd/9fAexbqSdQmcAPYqLAHShaRsZwTtEPW4mii/vdv5jvf5NHvJ1yfe95NuikAP6nVHa28qSyo9X3b7dZxj1dGj3f6fIUjvZtjrlNglrhXFYc8RhvBlxuWbR9HoS1j6PHQecAddwNWIYmv+v6F7LTC1hLToAhu8S+LseSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpZoHYJrHGvwVLh+l0Yn1HOzmZjCzIULpGm8ktZQv7I=;
 b=WSOmDqwovsjXBAj8DsKHxmhBLpHGWzy2P2vlhrM5+8/owyAI2asmP2kNCtf8Yr+lruH1+yZ1K6nf0jJ7zeCiBcvw3oArhLvpHis7+LUf6x2XoBJ96ITH0WXNNXT/ETQQM1qSlveX2wrTHEHHeAWYi6RKf4X04l6twieB0bdmQXJBZnesvI/5fCG8qVdVidk+c+7LB8YX/w9PdGsp5EaeyqptbfgXQnnFa8sN43cP7+Gf1qRHk78q+cu7qJQaIhDkNaFOT+gHKYH0n8rOTYFf8pDItL9V+8ty92dbwa7xfv17q+WCl5VtNgdaQeuzNIopp/ZlwfY7CJKwaXhTmCsukw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpZoHYJrHGvwVLh+l0Yn1HOzmZjCzIULpGm8ktZQv7I=;
 b=oxXSa3+61LqrzMGfcvLpPsRo0NcyPrCax+P8KdCo6LhDFYixg1HqMzhG2RU8DNsD72mTxaJYiSW9nRDYn1PRG78TobcXXaomott+pCNYIzsOmFso/NA9sLnGmdtuDhmFIac28Ua4Othh2JQvojb+IpLtRFm5ppbtcnXRjiMMA0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by SJ0PR03MB6615.namprd03.prod.outlook.com (2603:10b6:a03:388::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:31:00 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%5]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 06:30:59 +0000
Message-ID: <91a96b4a-a91e-aae6-733f-c307ca6840f0@synaptics.com>
Date:   Fri, 11 Nov 2022 14:30:46 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <CAAFQd5Ab0giyCS_69Wt4=C9yiBmLfV=0yZY2vGeaOwFgGsb_bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|SJ0PR03MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416783c-5712-4a95-81e5-08dac3ae4b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92FfLvLRlRvrQTaP3qdcJHSE0uLkoHIb/SKLixCkbdhP5oOiEG29aJGEGUIkMC9dgY1An3LppuLXq1NGBq2iqf2UH2KVDcbHxu+DNMK3jfx26X9TmYT/D1Rb/ZxSU8Y1G8XYxWjFrMXTVfN8RET05b8ul23l+f0y27XsbWsrVTdDbTYfpiJkNulldJ1ngH7zh4wUVoUixyUqGFCXEcn01QyE31l6YIOWk5V3aizWkHis2FTXpRpu7xrqmAXFCFP4a9vaqSn62jmPLYSCO/Zmpxlf+L0yRCJbTY7DKJdo4GkOtM6k5CpEEfxti+PixEOf4esOgKHTRxn6MNs5Mj607bE05SfI44/liYqjfoPrEYHS0QCkNm7eYxj+XAnHZVR9nmVp41TZc9qqpVeD0kXy/EM+2SGhK2dbJ27cH8+SJ9YLtse0kRPqgYXPVT9TvBOAI3e/KFXarhmX6QeESBR92dUI50jBn6hFfJeL7g0JUhNEfRgeuDX29uWqgxb92aXpJm3fcUX6EWIO1CK34f4lzG9eE0GW15qOPOyzkdsxSQN8lzc66PB5Au6WCU249V/gfQBuux0cy3TSBE1Q0N52oOqz6LEJRDxJ5aDl/UjAUTfi4+LZbRkLfoYnmIU877BztPTd4EPYZhhLbUaNUtloyd3beGkK/CZ0Kze1FN1E+zrZVSfu9auh2D/bbOHddKpVfj62gRRRohOLVoWlNgLh6jdWJTIWT9jR7fd4i01IoduU9EGotasUKxjwb7aYS/1ls7iHQYi5ExU0//3WpRFzESj/zk/BJ5q4+4cUuot1wsDOZb9HJA8TXVarjXsnD6gNJUy2EA68X+3Wn3cWAPOLu6b13jtRI3Mak7Y0HCn7Pfs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(66574015)(83380400001)(86362001)(31696002)(38100700002)(38350700002)(7416002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(66556008)(8936002)(52116002)(26005)(53546011)(6506007)(6512007)(186003)(6916009)(6666004)(316002)(54906003)(2616005)(6486002)(66476007)(66946007)(966005)(478600001)(36756003)(31686004)(66899015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlBdDBtVHZhVUl6YnBPNTlUUU9mYlpYRTJZeUkxMnMxeW1YZ09WL1d0RTJB?=
 =?utf-8?B?RjlicjJuaVplOHFKT2JOdVNiV3drcDQ4ak9EOGpCcjlzMmMvK0F0ZmpYRzV4?=
 =?utf-8?B?MWpoTFg4aXNLaHo2ZXZaSlJQZmpOdklrOStkK2Q4NUt0UkZSbmFXeGpYSS9T?=
 =?utf-8?B?b0ZnS2JVSlhnREVXaTJTZGR1ZXJicTU4eWVPeWY5anRid2tLRktwc2l6Zllt?=
 =?utf-8?B?dXF3dGVlOHJZOGk5dWNpZTN4cnAwcWYyTC9VTDhERE5XVzRyVDc2N0xJN21a?=
 =?utf-8?B?bVFnYUZiVURMSUxSdENZUU9hRUZPN09aQmp3TDFKdmRMaGFDZlF3aTRRekNC?=
 =?utf-8?B?YmRkREIrN0QxSDdXalNwUlMvKy9kNlV0cW9JaUpTbWdNcmUwMlV5a2ZOWlZ1?=
 =?utf-8?B?UjRSaUZBeXdwSWxFZFFLUlloN2R0UFFya2c4UWVUdUpxNE1jSEhQakFXS0VM?=
 =?utf-8?B?VHZBZDF6S3ZDdlNHQVBTMzFtdkhkbnpXR1h5ZUFzWVhVNXUrWVVUT0ZpeEFQ?=
 =?utf-8?B?VGNiaDhuRVhkOVRKMzV3OURVMms4d1h0OFRzaEExdGQ4Lzh5N3ZVVHlabXBU?=
 =?utf-8?B?ZFNPOE1tTndZdDQ4aWtKaFVnWWk1UzJZYXZrWTJEZXNtOFQxK21KQXFEa2do?=
 =?utf-8?B?QVBnNmdjVk9CN0tmcUhHTDA0WDVHRDBGc1M3WC9IVXpFTkVMKzNvQVNjY3Iv?=
 =?utf-8?B?VXNsTktrSkFKYzI1WDJLMTY2Sm9RNFd4ZlRhanIwL2RYUVF6bEZHeU80b2Jz?=
 =?utf-8?B?T3lBUGtDTVJ1a0daT2xWc1FldWp6Yk5UNy9PTkZ4L2I3bEU5SERzNDd6dEhn?=
 =?utf-8?B?Uy9ZMUNZcEduMUJwWFlaK1FDNGVRSHl5NzlmRmVzS204Ti9HZDlKUmlFeDVZ?=
 =?utf-8?B?bjZmblJRZERDd0ZXWlJhWVRDV2ljUFhQVDN1QStiaTJLUWMxY0k2L21LYnRo?=
 =?utf-8?B?cEhOUEtsQVI2d05EMENtekgwallHOVhGQlhFMUZ1REdCRVU1SU1oajZSb0ZQ?=
 =?utf-8?B?Njd5YTAwaUlCYTkrWHhYd1FxdlZsRUxqcDdYWlBJZmg5eHVFRUtuQkxNZjlL?=
 =?utf-8?B?TElhN0s1czVRNVAweTgwelM5MS8zdmVVN2d4UGxCN2ZSNE5UdWlLeERlaENI?=
 =?utf-8?B?T0ZoR0ZvSitCTTFiWUFpUmszR0lPcUhjaFJWUWZFak8wMFNML0VMTTlTVys5?=
 =?utf-8?B?UVNvbVNoWDRwUG1xT3hNQ0tnNzZoaWQzL1EwOFBwa1VkcGI1VkJPTGp5RW1r?=
 =?utf-8?B?RTlSZ2xYMEpPRFJ4TXg2WUtTbTFGZDNDTFJxUlhoSHl0Y1hrZzUySWtMcjM0?=
 =?utf-8?B?QlB0ZlZqMnVNSTRLWWZzSDlHMG9IU1NrWjVvNXBqTDRxREtCZXdZb1BZa01Y?=
 =?utf-8?B?MlVDL3IxSUxNbmU4dzlXUW11L2Flc0NMTngycEZBYTRQZ3FCdnV3MUV6d2h0?=
 =?utf-8?B?L3VrcVExOHp3S29KbkNQdVNTUjRHVGQzQ0ZCUzlDRmZhbGpaaXNwek9xKzFj?=
 =?utf-8?B?QXk1bmhzRDhUTHZUWVIwY3l0UUlsMkJ3Z2ZxU2JoRU1ReUVtTkFFRUwwZGR5?=
 =?utf-8?B?dDh2aU9iQ3RQZ1J5WndteU9CcXlaakNtektjTzB0ZWNxR2Q2L3h4UWpCVGdw?=
 =?utf-8?B?NW1LQWRGcUtURUFTUmxUS0F0REZ6bEY1SDFkcFA2emJaWmZJRXBEWkh0T0gr?=
 =?utf-8?B?RWt4Uit6cmc4SmM5ejZNKzl2OUMvSGUwQ1djTXQwdHF3b3FjWGNBamNxZWhK?=
 =?utf-8?B?SkQ0RnJycEtCaW9hVEU0RklVK3g0K3R2RXovQlRqS0hHNlVFalVYekZFMmdB?=
 =?utf-8?B?TnVxaVJEd3VTV0c2a1BXVGswT1dTV2RFSzVidllzUmVUYnNFZjZ3UnRtVjZB?=
 =?utf-8?B?RHZhYldiZm9RNHRjRHNxSlp5djJ0Rlo3c0I5b3REU283a09rbXJ6cFIvZFFt?=
 =?utf-8?B?UUQwVUJweEhDMWI4KzkzMVdYRnNqNU1GamVlSFZrSnVNOG5rRjhud0w1OWxQ?=
 =?utf-8?B?cDNYVjNIM1VHMDRhSXFJdWF6NEpSR2h3Ulp2NVRZUTlrc2srem5qQXdLdlJC?=
 =?utf-8?B?Y25Yc3k2Y1hDTmNLcjZlU1FadUliNWNSUUFPQ0RONzU2blFOZVRtNFBOOUpr?=
 =?utf-8?Q?mi9DntVc9tqull2gTCvry1KBy?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416783c-5712-4a95-81e5-08dac3ae4b92
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 06:30:58.8620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPZxJduXTWDCfNZIXNMNKzXpJ2B6MEaIafihisTU/p+GoXcWPksnRXQJifM0rXcAEvl6/tgBoC2EHDScQEx+IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6615
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 13:48, Tomasz Figa wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> On Fri, Nov 11, 2022 at 12:04 PM Hsia-Jun Li <Randy.Li@synaptics.com> wrote:
>>
>>
>>
>> On 11/11/22 01:06, Nicolas Dufresne wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Le samedi 05 novembre 2022 à 23:19 +0800, Hsia-Jun Li a écrit :
>>>>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
>>>>>> VIDIOC_ENUM_FMT
>>>>>> would just report NV12M.
>>>>>
>>>>> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
>>>>> report both (unless I'm missing something, which is probably the case).
>>>>>
>>>>> The idea was to deprecate the M-variants one day.
>>>> I was thinking the way in DRM API is better, always assuming it would
>>>> always in a multiple planes. The only problem is we don't have a way to
>>>> let the allocator that allocate contiguous memory for planes when we
>>>> need to do that.
>>>
>>> Its not too late to allow this to be negotiated, but I would move this out of
>>> the pixel format definition to stop the explosion of duplicate pixel formats,
>>> which is a nightmare to deal with.
>> I wonder whether we need to keep the pixel formats in videodev2.h
>> anymore. If we would like to use the modifiers from drm_fourcc.h, why
>> don't we use their pixel formats, they should be the same values of
>> non-M variant pixel formats of v4l2.
>>
>> Let videodev2.h only maintain the those codecs or motion based
>> compressed (pixel) formats.
>>
>> If I simplify the discussion, we want to
>>> negotiate contiguity with the driver. The new FMT structure should have a
>>> CONTIGUOUS flag. So if userpace sets:
>>>
>>>     S_FMT(NV12, CONTIGUOUS)
>> I wonder whether we would allow some planes being contiguous while some
>> would not. For example, the graphics planes could be in a contiguous
>> memory address while its compression metadata are not.
>> Although that is not the case of our platform. I believe it sounds like
>> reasonable case for improving the performance, two meta planes could
>> resident in a different memory bank.
> 
> I feel like this would be only useful in the MMAP mode. Looking at how
> the other UAPIs are evolving, things are going towards
> userspace-managed allocations, using, for example, DMA-buf heaps. I
> think we should follow the trend and keep the MMAP mode just at the
> same level of functionality as is today and focus on improvements and
> new functionality for the DMABUF mode.
> 
I know there are still some devices(encoder) which only have one 
register for storing the address of a graphics buffer.
>>
>> That lead to another question which I forgot whether I mention it before.
>>
>> There are four modifiers in DRM while we would only one in these patches.
>>   From the EGL
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__registry.khronos.org_EGL_extensions_EXT_EGL-5FEXT-5Fimage-5Fdma-5Fbuf-5Fimport-5Fmodifiers.txt&d=DwIFaQ&c=7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=P4xb2_7biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=mCebYOAiZK6pbpH1MrZGq-ZkDW-OqORCSwsCEX9ScgdXk_yfWZFJPC5aC93CUg5F&s=rtmW_t2LYoJ6g3Y5wgyICmABu-2Npw3JCOlvUVIYH2o&e=
>>
>> The modifier for echo plane could be different. I wish it would be
>> better to create a framebuffer being aware of which planes are graphics
>> or metadata.
> 
> What's an echo plane?
> 
They could be
DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
DRM_FORMAT_MOD_SYNA_V4H1_128L128_COMPRESSED
DRM_FORMAT_MOD_SYNA_MTR
DRM_FORMAT_MOD_SYNA_MTR
Or
DRM_FORMAT_MOD_SYNA_V4H3P8_64L4
DRM_FORMAT_MOD_SYNA_V4H3P8_64L4

in our platform. It could give a better idea on what is stored in a plane.
> That said, it indeed looks like we may want to be consistent with DRM
> here and allow per-plane modifiers.
> 
>>
>> I wonder whether it would be better that convincing the DRM maintainer
>> adding a non vendor flag for contiguous memory allocation here(DRM
>> itself don't need it).
>> While whether the memory could be contiguous for these vendor pixel
>> formats, it is complex vendor defined.
> 
> Memory allocation doesn't sound to me like it is related to formats or
> modifiers in any way. I agree with Nicolas that if we want to allow
> the userspace to specify if the memory should be contiguous or not,
> that should be a separate flag and actually I'd probably see it in
> REQBUF_EXT and CREATE_BUFS_EXT, rather than as a part of the format.
> 
I agree with that. But here is a problem, if there was a display 
device(DRM) that only supports contiguous planes in a frame buffer.
How do we be aware of that?
>>
>>>
>>> The driver can accepts, and return the unmodified structure, or may drop the
>>> CONTIGUOUS flag, which would mean its not supported. Could be the other way
>>> around too. As for allocation, if you have CONTIGUOUS flag set, userspace does
>>> not have to export or map memory for each planes, as they are the same. We
>>> simply need to define the offset as relative to their allocation, which I think
>>> is the most sensible thing.
>>>
>>> Nicolas
>>>
>>
>> --
>> Hsia-Jun(Randy) Li

-- 
Hsia-Jun(Randy) Li
