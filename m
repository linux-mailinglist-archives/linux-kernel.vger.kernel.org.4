Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D21A61DB99
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKEPTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKEPT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:19:29 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC571EEC7;
        Sat,  5 Nov 2022 08:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpHd9E7H7tyHyqRorJopuqEezF7qM1rp9vZxuqXdPOYyN/g14dFiZOa6oFFpLFcdwyPrgniaERP6+sXWqn/kCGGYfY31FpxyBHKTNr6TSZ/V26p8X74+dAPsYzipT7KHT0sCmWvZ9+c8NYmCuKJYAY1uut6h4SwpWHjD7nyVC4UkDDg3lT4LU/ZmiNLDUTchpvZBqdxEXWZswQNkOvXhO3ka5WEQG2RAMt6BbvTcZqMFAW7OdRRquZdKu7uKYlbrX6+0vmKbnpMlo2DHbWDSel1rEIFrPl/IdTOdjSqMXuZ6dskIC/GnXAMnt1lenJrX4la0od7+1MY96+wf+khCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcnZ0Zyv5XL/aZVXQYPGjkmPUb7mIz+GN7Yxmovrc3A=;
 b=glV3j6ugkWYAZ4hsV5TDDQiCMhNTyuY+c0XVujjS3UNj7mVK1toiBzKJnd+4eEckDJrbh9fy9+ksS/7Q0hgj9+QhyH/OYnhOUA4AZZDrgpq44PUurakz3HnAKCtz3HdckqyvUxd+dn2FWZnH5dVeHHpkrxJO/Y42HhSqotRXbS7NQDboIntFdHutiq7ZAy920bqhJ0COJIZ2G3pfe/ebfwIUucCEM1MsgvsWESLoxxkKC5dE99WAx3nI7xvbysHEv3/cng7q2A7M5eu/RU+mNjQNgiudAY63W629YiSEgi9q4CaZA+tTyMfJnPPJJu52KyhbinJloLhi2XuJ7lK7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcnZ0Zyv5XL/aZVXQYPGjkmPUb7mIz+GN7Yxmovrc3A=;
 b=LPk1P0bYhGit1E1Yi4iHFYwme6oYDrdkNL9kkcQ91aX7vQrNi31euhV80GymDGu6ii94mh9BhXawHVC2Pct8Q4BRKg29lcD5xrICLoLBz6lHg9Yoa2WyJrZcfR0FNY0hhbD7chfcPmW3PwsaZmvFW/K9o15KUMRHXOsNNtY0ZkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MN2PR03MB5358.namprd03.prod.outlook.com (2603:10b6:208:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Sat, 5 Nov
 2022 15:19:23 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%7]) with mapi id 15.20.5791.023; Sat, 5 Nov 2022
 15:19:23 +0000
Message-ID: <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
Date:   Sat, 5 Nov 2022 23:19:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
To:     Helen Koike <helen.koike@collabora.com>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        nicolas@ndufresne.ca, Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
Content-Language: en-US
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MN2PR03MB5358:EE_
X-MS-Office365-Filtering-Correlation-Id: 594a9563-eb4c-403f-e0f5-08dabf411e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GrbCm6BKR0KTfzS1OrpxlphHWcMCKBSiyiAUdH4DP2SA0AuxxPurrhwwsM04oRCWgi1kuIcVt6jJCOtxCRHDV4+hR8E4w3jRBF7VAHmoqoesR6P1pkVQzeorw6haSzMBvVinQThaCkaCo7wSeJlcHCVeXef29P/yxXljKs7Az3FcAJlW/J4ZoCVPZB+eh1dN9fGpCfoyKgsjmaI5I59yYx4SOG1Ky/J4GXLmbHHLqiONPb1+QVbPdEa/yYpKH7a1ZyncpV6MKmcOe+gSoPMU+erdCEgiWZYv73ihsUY0TlgTfRJrkxz7/QDkuPWoKbmRLqtE88pXuSoPYcMdg3o6dDbN7+pCFxojPkNxHpNHUPo6YH9zzfI2sffaGpg8QmTIPfZU7rAlRA37nA0OLyfbQbFvO2T/fPELCAqrS5uR15NG/GXCcv18evJvNQB4hgh7OF+1Mi9MVXvwD+KiauSazDSMuvlYd5IHps5eL36ijd6Mx92i33/qQe52lqXuYOqAdk0s3/ucc4c9mJFvFvfhEP50IMktrcWfig6B7oEsjmDuc/KU6T4Nc7LGb148kxQxWmGZgVa+u4dpKjolu5vWrqqfUs5YwlRwJJAuKTnDdXv93WI51e+YSXWictt48lHSWFwOdyVoG/eVcKqV2zJq4G6fQOO3rlHftImidcadItEt22XXWyv7iU42iQNrsNUE7Ztbul4MMLFNbpoj8Lu5PEM2F+xXoadUMXLpbS9Q4RaYaFf8VrQiLEI64LdM3j4bga3Z5aGcX2TQGperNbu9PoKWIbq9d5tGt06Sskc3LSHoUYjeo+7PH22So7xmPaf1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(4326008)(66946007)(38350700002)(66476007)(31696002)(6916009)(316002)(2906002)(41300700001)(66556008)(38100700002)(6486002)(7416002)(6666004)(8676002)(5660300002)(6512007)(53546011)(26005)(186003)(30864003)(83380400001)(86362001)(478600001)(31686004)(8936002)(2616005)(52116002)(36756003)(6506007)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09aTDhhSURISVBma0ZmSWlVbUtQNGtJNTZZU1lDRHg4R3ZUT0dlbXZHOWRQ?=
 =?utf-8?B?U253Ri9BdHd6UHZrM29sM1JDcjZaZ0RWS29qU1BvY3UxNUhxOHc0YUMrdUFi?=
 =?utf-8?B?cERrdy9jQ1lTWlpJNXQ2V1FEUXR4MFd3dDhMUFJiajJUOUFWVnozRVZFVFpn?=
 =?utf-8?B?N2RmU0Z2TVFGanZJVDVvZWE2RFFLZVE5WUZPWUpWamlWa1BxVW5GVnFUeXNh?=
 =?utf-8?B?VWVIUld4Ky9vYVl1N2s1VDFsTkRDS3hFUytrV0VXQVNhbjlrallqKzk3ZFRq?=
 =?utf-8?B?VTA3MGU4MkdIUmVKQmdjZU5RVkpPVjN5aytNWCtxclpaTlFSVkk5ZU1udzJQ?=
 =?utf-8?B?ZTVEWUZTLzROaCs2bWdYYkRGaWI0eTBKSXozS2htZGdxNFBDKzlUa080OTJY?=
 =?utf-8?B?d2orUDJxQXpKWVVMa0gveTJpbjRPc3NwTGdPb3NkOHVjM1FVUm5vM2llb1dE?=
 =?utf-8?B?UVVVeFdabEpBUkE2b3h0aTBCdFBJczg2VnQ5U0xIcXozWTE5WEFod29jRWJG?=
 =?utf-8?B?cDk2Ym1XSnVrMzQ1dUF0b3paYklocVdqZXFleDg1MmU1ZHo2UUtkK2MwUkRH?=
 =?utf-8?B?dzRHREV6RHFHOXFHcWpHREErMGJSN0xva3VKYnBWR1hydzhSVWVuek45dVF3?=
 =?utf-8?B?OE1aWVZqMldQS2crNnJBVnF1WU5xSGpMa1laK1B0QUNJZ05aRFJRMTcxQ3VQ?=
 =?utf-8?B?dEUrRmkyb0V2Q1djdE1WaXB3Q3BkZ0E5M2Z1V3IrdEU0Q0lsTzBGOE1Eb2Vs?=
 =?utf-8?B?dC9SVlJuS0Z0SUtBVWMwVURaYWRWM1RVVmQ3NVBEdW5zTnlGYUhRRUEwdUZo?=
 =?utf-8?B?OWRJVW52Tm44b1JEbEZFbTFtd2kzOXJHd3MrdnNrdHVzUm5Gc0U0NE43d2Rn?=
 =?utf-8?B?UWgyUWRjMVdKWFZuMzRTci8vV2FEVXdOc2xIaitoMnRoVi9JK0xjV3RZVmJF?=
 =?utf-8?B?enduVnl6L3BKZVVndnNvWlNYcXpjSDY2alVVTlhDL1l0ajhlQjg3S0UyTU9N?=
 =?utf-8?B?eDExZkQvcllLZGtUdWxDeW1FRUJieDlrY0tMMDNWSWdSTFZ3cmtzZU00K0M5?=
 =?utf-8?B?TkVWeHlxZjVueE1kbndxWktlanIveDEyejlPTzlqR1FhbCsyQ2c5L3NVVk9x?=
 =?utf-8?B?RGZQTzNVOW9yUVVnL3owVXdjUUVES045WGZMNHB1TEgzUDdXYXMvWWFObGVV?=
 =?utf-8?B?R3dRaUdiaGpicStaOXdTUGRMV0NOL2pXQ0NZSHdobiszQkJmemR3cGVaSmpi?=
 =?utf-8?B?TlpKVjZKWldrMFNGVExKeURGaCtMNUpYYlVMWStNMUM4dFpPbEh2Q2hMNk4w?=
 =?utf-8?B?V3hNRERUYlByY0ozRHo4Q1ZuU09nMkxYWDk1aEFkTzZTYnRDNWN4am11RjF3?=
 =?utf-8?B?eXN0NzY2c1U3aHNNY1VkSDBhenZLNlRvOTNTS3A3TjhvcGVWbVYrQlBheWlz?=
 =?utf-8?B?VXRPanFiTm10Wi9LUmRVQlROTHRzOVZXMWlvejhCdnVHZ2dlVjlvWENQbDUy?=
 =?utf-8?B?SFZkNExSME1UWEI2NEVxTjZyY3AvK0E0Z0tRbG8vMXlSdTRwZWxjUXhPL1Ro?=
 =?utf-8?B?M3NVZWo0YVlNNGpmbGJERmNiU1dsRkF0UGEvVlBsVXlrR0F2dS9LTGRXSkJ6?=
 =?utf-8?B?UEhzVDByK1dRSytISHpCalJLYmRNZTRPWmFTQ2E2MCtVMTkxQURTc3NsOWVq?=
 =?utf-8?B?UCswS2tOcTc2Y093YjB5NnNrV3djNlZPZ2N0T295RnZ1TC9MMisrc0Jjciti?=
 =?utf-8?B?MDRpekV6c2puVWFPa3Ivc3Y4U2dqa3ppNVVvZHdkWURCS2o2NFVndXNmT0xT?=
 =?utf-8?B?WmZCenE5djdPeWJwRXluZmNiMk5zNzRQSGhqalF2cFFiTmpXZVkyYW84enBQ?=
 =?utf-8?B?bzVSbStaRHRWSUY0N04xcGhJZWVmU3grNkZpNzZ2SWs5QjJzVUN5c1c1bGxv?=
 =?utf-8?B?Rm9YWUUzTGlmUWxTcVJUS1grbE93NWc2UGZtTktzd284MGpBeGkvcTBkdmtN?=
 =?utf-8?B?MGJYMjhlYTJsTWhrQ25LVGg4clhMbkFEaExBM21ZVU5iL2NsU0sxdjV4VTFK?=
 =?utf-8?B?YU5NT2R2Y2JaTjJQSXE1VVZQa0k1OFJmU0xZSGNSWTRNQ1lmRm41NktHMjl0?=
 =?utf-8?Q?jw7QTIiUMwXsDjwqbEMHL4wzZ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594a9563-eb4c-403f-e0f5-08dabf411e3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2022 15:19:23.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLD35YXtAkeSXxY9DXv9Ca371abq3NLmLkTS0aZxpqwCZgC+rfbLuJlj6kprvkH97yIgCPUG9abo685lz6GqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5358
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Helen

I didn't see any updates from V6 and V7-WIP in your repo. That is what I 
need to for our complex tile formats in our platform.

Any future plane here?

Besides I have some ideas on these patches.

On 2/24/21 23:12, Helen Koike wrote:
> Hi Hans,
> 
> Thank you for your comment, please see my reply below.
> 
> On 2/23/21 9:35 AM, Hans Verkuil wrote:
>> Hi Helen,
>>
>> On 14/01/2021 19:07, Helen Koike wrote:
>>> This is part of the multiplanar and singleplanar unification process.
>>> v4l2_ext_pix_format is supposed to work for both cases.
>>>
>>> We also add the concept of modifiers already employed in DRM to expose
>>> HW-specific formats (like tiled or compressed formats) and allow
>>> exchanging this information with the DRM subsystem in a consistent way.
>>>
>>> Note that only V4L2_BUF_TYPE_VIDEO_[OUTPUT,CAPTURE] are accepted in
>>> v4l2_ext_format, other types will be rejected if you use the
>>> {G,S,TRY}_EXT_PIX_FMT ioctls.
>>>
>>> New hooks have been added to v4l2_ioctl_ops to support those new ioctls
>>> in drivers, but, in the meantime, the core takes care of converting
>>> {S,G,TRY}_EXT_PIX_FMT requests into {S,G,TRY}_FMT so that old drivers 
>>> can
>>> still work if the userspace app/lib uses the new ioctls.
>>>
>>> The conversion is also done the other around to allow userspace
>>> apps/libs using {S,G,TRY}_FMT to work with drivers implementing the
>>> _ext_ hooks.
>>
>> I have some small comments below, but also one high level comment:
>>
>> Regarding M variants of pixelformats: this patch 'normalizes' them to
>> regular pixelformats in the extended API. This makes life complicated,
>> and I wonder if this is the right approach.
>>
>> Currently there are two reasons for a driver to support e.g. NV12M:
>> either luma and chroma need to be in two memory banks, or the luma
>> and chroma planes cannot be contiguous due to alignment requirements.
>>
>> The first requirement is still valid for drivers that support the 
>> extended API.
>> The second requirement is no longer a reason to support NV12M. But I
>> don't think we should just drop NV12M support if it was already supported
>> before the conversion to this extended API. Since NV12M allocates two 
>> buffers
>> instead of one, it is still different from a regular NV12.
> 
> I don't see what would be the difference when using NV12 and NV12M in 
> Ext API.
> NV12 could be used for both requirements. It would even allow the second
> requirement with a single memory buffer.
> 
Although I don't have problem here to support both single and multiple 
planes in our hardware. But using the single plane format here is not 
convience for us.

The tile format in our platform is little complex, you can't calculate 
the stride and sizeimage easily with just the modifier, width and 
height. Then we don't have a good place to record the offset here.

Besides, the luma and chroma planes would always need their own 
compression meta data planes. If we use NV12 here, that would make a 
very strange pixel format, one plane for the pixel datas and two planes 
for the meta data.

>>
>> I would prefer that such drivers support both NV12 and NV12M, so no
>> automatic conversion.
>>
>> A related question is how to handle pixelformat enumeration: with the
>> extended API an NV12 format might work, but not with the old API (e.g.
>> due to memory alignment requirements). I wonder if a 
>> VIDIOC_ENUM_EXT_PIX_FMT
>> isn't needed.
> 
> We need VIDIOC_ENUM_EXT_PIX_FMT for modifiers, but we can add it later.
> If the driver reports NV12M, userspace can use it and the framework
> normilizes it.
> 
>>
>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while 
>> VIDIOC_ENUM_FMT
>> would just report NV12M.
> 
> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
> report both (unless I'm missing something, which is probably the case).
> 
> The idea was to deprecate the M-variants one day.
I was thinking the way in DRM API is better, always assuming it would 
always in a multiple planes. The only problem is we don't have a way to 
let the allocator that allocate contiguous memory for planes when we 
need to do that.
> 
> Regards,
> Helen
> 
>>
>>>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>>> ---
>>>
>>> Changes in v6:
>>>   The main change here was fixing the conversion, so planes reflects 
>>> color planes,
>>>   and to implement this properly I made major refactors compared to 
>>> the previous
>>>   version.
>>> - struct v4l2_plane_ext_pix_format removed, using struct 
>>> v4l2_plane_pix_format instead (Tomasz)
>>> - refer to drm_fourcc.h in struct v4l2_ext_pix_format docs (Hans)
>>> - reorder colorimetry fields in struct v4l2_ext_pix_format (Hans)
>>> - do not set Ext ioctls as valid for vid_out_overlay (Tomasz)
>>> - refactor conversion functions, so planes are color planes (Tomasz)
>>> - Don't explicitly check for e->modifier != 0 in 
>>> v4l2_ext_pix_format_to_format() (Tomasz)
>>> - Use "ef" for extended formats in the framework for consistency 
>>> (Tomasz)
>>> - Handle xfer_func field in conversions (Tomasz)
>>> - Zero reserved fields in v4l_s_ext_pix_fmt() and 
>>> v4l_try_ext_pix_fmt() (Tomasz)
>>> - Refactor format functions to use v4l_fmt_ioctl_via_ext()
>>> - Several fixes/refactoring/changes
>>> - Remove EXT API for touch devices
>>>
>>> Changes in v5:
>>> - change sizes and reorder fields to avoid holes in the struct and make
>>>    it the same for 32 and 64 bits
>>> - removed __attribute__ ((packed)) from uapi structs
>>> - Fix doc warning from make htmldocs
>>> - Updated commit message with EXT_PIX prefix for the ioctls.
>>>
>>> Changes in v4:
>>> - Use v4l2_ext_pix_format directly in the ioctl, drop v4l2_ext_format,
>>> making V4L2_BUF_TYPE_VIDEO_[OUTPUT,CAPTURE] the only valid types.
>>> - Add reserved fields
>>> - Removed num_planes from struct v4l2_ext_pix_format
>>> - Removed flag field from struct v4l2_ext_pix_format, since the only
>>>    defined value is V4L2_PIX_FMT_FLAG_PREMUL_ALPHA only used by vsp1,
>>>    where we can use modifiers, or add it back later through the reserved
>>>    bits.
>>> - In v4l2_ext_format_to_format(), check if modifier is != MOD_LINEAR &&
>>>    != MOD_INVALID
>>> - Fix type assignment in v4l_g_fmt_ext_pix()
>>> - Rebased on top of media/master (post 5.8-rc1)
>>>
>>> Changes in v3:
>>> - Rebased on top of media/master (post 5.4-rc1)
>>>
>>> Changes in v2:
>>> - Move the modifier in v4l2_ext_format (was formerly placed in
>>>    v4l2_ext_plane)
>>> - Fix a few bugs in the converters and add a strict parameter to
>>>    allow conversion of uninitialized/mis-initialized objects
>>> ---
>>>   drivers/media/v4l2-core/v4l2-dev.c   |  27 +-
>>>   drivers/media/v4l2-core/v4l2-ioctl.c | 538 +++++++++++++++++++++++++--
>>>   include/media/v4l2-ioctl.h           |  28 ++
>>>   include/uapi/linux/videodev2.h       |  41 ++
>>>   4 files changed, 602 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-dev.c 
>>> b/drivers/media/v4l2-core/v4l2-dev.c
>>> index f9cff033d0dc..5add58cb6d45 100644
>>> --- a/drivers/media/v4l2-core/v4l2-dev.c
>>> +++ b/drivers/media/v4l2-core/v4l2-dev.c
>>> @@ -608,27 +608,42 @@ static void determine_valid_ioctls(struct 
>>> video_device *vdev)
>>>                      ops->vidioc_enum_fmt_vid_overlay)) ||
>>>               (is_tx && ops->vidioc_enum_fmt_vid_out))
>>>               set_bit(_IOC_NR(VIDIOC_ENUM_FMT), valid_ioctls);
>>> +        if ((is_rx && ops->vidioc_g_fmt_vid_overlay) ||
>>> +            (is_tx && ops->vidioc_g_fmt_vid_out_overlay))
>>> +             set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
>>>           if ((is_rx && (ops->vidioc_g_fmt_vid_cap ||
>>>                      ops->vidioc_g_fmt_vid_cap_mplane ||
>>> -                   ops->vidioc_g_fmt_vid_overlay)) ||
>>> +                   ops->vidioc_g_ext_pix_fmt_vid_cap)) ||
>>>               (is_tx && (ops->vidioc_g_fmt_vid_out ||
>>>                      ops->vidioc_g_fmt_vid_out_mplane ||
>>> -                   ops->vidioc_g_fmt_vid_out_overlay)))
>>> +                   ops->vidioc_g_ext_pix_fmt_vid_out))) {
>>>                set_bit(_IOC_NR(VIDIOC_G_FMT), valid_ioctls);
>>> +             set_bit(_IOC_NR(VIDIOC_G_EXT_PIX_FMT), valid_ioctls);
>>> +        }
>>> +        if ((is_rx && ops->vidioc_s_fmt_vid_overlay) ||
>>> +            (is_tx && ops->vidioc_s_fmt_vid_out_overlay))
>>> +             set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
>>>           if ((is_rx && (ops->vidioc_s_fmt_vid_cap ||
>>>                      ops->vidioc_s_fmt_vid_cap_mplane ||
>>> -                   ops->vidioc_s_fmt_vid_overlay)) ||
>>> +                   ops->vidioc_s_ext_pix_fmt_vid_cap)) ||
>>>               (is_tx && (ops->vidioc_s_fmt_vid_out ||
>>>                      ops->vidioc_s_fmt_vid_out_mplane ||
>>> -                   ops->vidioc_s_fmt_vid_out_overlay)))
>>> +                   ops->vidioc_s_ext_pix_fmt_vid_out))) {
>>>                set_bit(_IOC_NR(VIDIOC_S_FMT), valid_ioctls);
>>> +             set_bit(_IOC_NR(VIDIOC_S_EXT_PIX_FMT), valid_ioctls);
>>> +        }
>>> +        if ((is_rx && ops->vidioc_try_fmt_vid_overlay) ||
>>> +            (is_tx && ops->vidioc_try_fmt_vid_out_overlay))
>>> +             set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
>>>           if ((is_rx && (ops->vidioc_try_fmt_vid_cap ||
>>>                      ops->vidioc_try_fmt_vid_cap_mplane ||
>>> -                   ops->vidioc_try_fmt_vid_overlay)) ||
>>> +                   ops->vidioc_try_ext_pix_fmt_vid_cap)) ||
>>>               (is_tx && (ops->vidioc_try_fmt_vid_out ||
>>>                      ops->vidioc_try_fmt_vid_out_mplane ||
>>> -                   ops->vidioc_try_fmt_vid_out_overlay)))
>>> +                   ops->vidioc_try_ext_pix_fmt_vid_out))) {
>>>                set_bit(_IOC_NR(VIDIOC_TRY_FMT), valid_ioctls);
>>> +             set_bit(_IOC_NR(VIDIOC_TRY_EXT_PIX_FMT), valid_ioctls);
>>> +        }
>>>           SET_VALID_IOCTL(ops, VIDIOC_OVERLAY, vidioc_overlay);
>>>           SET_VALID_IOCTL(ops, VIDIOC_G_FBUF, vidioc_g_fbuf);
>>>           SET_VALID_IOCTL(ops, VIDIOC_S_FBUF, vidioc_s_fbuf);
>>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c 
>>> b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> index 848286a284f6..a9c07c0a73ec 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>>> @@ -18,6 +18,8 @@
>>>   #include <linux/videodev2.h>
>>> +#include <drm/drm_fourcc.h>
>>> +
>>>   #include <media/v4l2-common.h>
>>>   #include <media/v4l2-ioctl.h>
>>>   #include <media/v4l2-ctrls.h>
>>> @@ -38,6 +40,11 @@
>>>   #define is_valid_ioctl(vfd, cmd) test_bit(_IOC_NR(cmd), 
>>> (vfd)->valid_ioctls)
>>> +#define V4L2_IS_CAP_MULTIPLANAR(vdev)    (vdev->device_caps & \
>>> +                     (V4L2_CAP_VIDEO_CAPTURE_MPLANE | \
>>> +                     V4L2_CAP_VIDEO_OUTPUT_MPLANE | \
>>> +                     V4L2_CAP_VIDEO_M2M_MPLANE))
>>> +
>>>   struct std_descr {
>>>       v4l2_std_id std;
>>>       const char *descr;
>>> @@ -379,6 +386,27 @@ static void v4l_print_format(const void *arg, 
>>> bool write_only)
>>>       }
>>>   }
>>> +static void v4l_print_ext_pix_format(const void *arg, bool write_only)
>>> +{
>>> +    const struct v4l2_ext_pix_format *ef = arg;
>>> +    unsigned int i;
>>> +
>>> +    pr_cont("type=%s, width=%u, height=%u, format=%c%c%c%c, modifier 
>>> %llx, field=%s, colorspace=%d, ycbcr_enc=%u, quantization=%u, 
>>> xfer_func=%u\n",
>>> +        prt_names(ef->type, v4l2_type_names),
>>> +        ef->width, ef->height,
>>> +        (ef->pixelformat & 0xff),
>>> +        (ef->pixelformat >>  8) & 0xff,
>>> +        (ef->pixelformat >> 16) & 0xff,
>>> +        (ef->pixelformat >> 24) & 0xff,
>>> +        ef->modifier, prt_names(ef->field, v4l2_field_names),
>>> +        ef->colorspace, ef->ycbcr_enc,
>>> +        ef->quantization, ef->xfer_func);
>>> +    for (i = 0; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; 
>>> i++)
>>> +        pr_debug("plane %u: bytesperline=%u sizeimage=%u\n",
>>> +             i, ef->plane_fmt[i].bytesperline,
>>> +             ef->plane_fmt[i].sizeimage);
>>> +}
>>> +
>>>   static void v4l_print_framebuffer(const void *arg, bool write_only)
>>>   {
>>>       const struct v4l2_framebuffer *p = arg;
>>> @@ -963,11 +991,15 @@ static int check_fmt(struct file *file, enum 
>>> v4l2_buf_type type)
>>>       switch (type) {
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>>           if ((is_vid || is_tch) && is_rx &&
>>> -            (ops->vidioc_g_fmt_vid_cap || 
>>> ops->vidioc_g_fmt_vid_cap_mplane))
>>> +            (ops->vidioc_g_fmt_vid_cap ||
>>> +             ops->vidioc_g_ext_pix_fmt_vid_cap ||
>>> +             ops->vidioc_g_fmt_vid_cap_mplane))
>>>               return 0;
>>>           break;
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> -        if ((is_vid || is_tch) && is_rx && 
>>> ops->vidioc_g_fmt_vid_cap_mplane)
>>> +        if ((is_vid || is_tch) && is_rx &&
>>> +            (ops->vidioc_g_fmt_vid_cap_mplane ||
>>> +             ops->vidioc_g_ext_pix_fmt_vid_cap))
>>>               return 0;
>>>           break;
>>>       case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>>> @@ -976,11 +1008,15 @@ static int check_fmt(struct file *file, enum 
>>> v4l2_buf_type type)
>>>           break;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>>           if (is_vid && is_tx &&
>>> -            (ops->vidioc_g_fmt_vid_out || 
>>> ops->vidioc_g_fmt_vid_out_mplane))
>>> +            (ops->vidioc_g_fmt_vid_out ||
>>> +             ops->vidioc_g_ext_pix_fmt_vid_out ||
>>> +             ops->vidioc_g_fmt_vid_out_mplane))
>>>               return 0;
>>>           break;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> -        if (is_vid && is_tx && ops->vidioc_g_fmt_vid_out_mplane)
>>> +        if (is_vid && is_tx &&
>>> +            (ops->vidioc_g_ext_pix_fmt_vid_out ||
>>> +             ops->vidioc_g_fmt_vid_out_mplane))
>>>               return 0;
>>>           break;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>>> @@ -1060,6 +1096,204 @@ static void v4l_sanitize_format(struct 
>>> v4l2_format *fmt)
>>>              sizeof(fmt->fmt.pix) - offset);
>>>   }
>>> +static void
>>> +v4l2_ext_pix_format_to_pix_format(const struct v4l2_ext_pix_format *ef,
>>> +                  struct v4l2_pix_format *pix)
>>> +{
>>> +    unsigned int i;
>>> +
>>> +    pix->width = ef->width;
>>> +    pix->height = ef->height;
>>> +    pix->field = ef->field;
>>> +    pix->flags = V4L2_PIX_FMT_FLAG_SET_CSC;
>>> +    pix->colorspace = ef->colorspace;
>>> +    pix->ycbcr_enc = ef->ycbcr_enc;
>>> +    pix->priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>> +    pix->quantization = ef->quantization;
>>> +    pix->pixelformat = ef->pixelformat;
>>> +    pix->bytesperline = ef->plane_fmt[0].bytesperline;
>>> +    pix->sizeimage = ef->plane_fmt[0].sizeimage;
>>> +    for (i = 1; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; 
>>> i++)
>>> +        pix->sizeimage += ef->plane_fmt[i].sizeimage;
>>> +}
>>> +
>>> +static void
>>> +v4l2_ext_pix_format_to_pix_mp_format(const struct 
>>> v4l2_ext_pix_format *ef,
>>> +                     struct v4l2_pix_format_mplane *pix_mp)
>>> +{
>>> +    const struct v4l2_format_info *info =
>>> +                    v4l2_format_info(ef->pixelformat);
>>> +    unsigned int i;
>>> +
>>> +    pix_mp->width = ef->width;
>>> +    pix_mp->height = ef->height;
>>> +    pix_mp->field = ef->field;
>>> +    pix_mp->flags = V4L2_PIX_FMT_FLAG_SET_CSC;
>>> +    pix_mp->colorspace = ef->colorspace;
>>> +    pix_mp->ycbcr_enc = ef->ycbcr_enc;
>>> +    pix_mp->quantization = ef->quantization;
>>> +    pix_mp->pixelformat = ef->pixelformat;
>>> +
>>> +    /* This is true when converting to non-M-variant */
>>> +    if (info && info->mem_planes == 1) {
>>> +        pix_mp->plane_fmt[0] = ef->plane_fmt[0];
>>> +        pix_mp->num_planes = 1;
>>> +        for (i = 1; i < VIDEO_MAX_PLANES && 
>>> ef->plane_fmt[i].sizeimage; i++)
>>> +            pix_mp->plane_fmt[0].sizeimage += 
>>> ef->plane_fmt[i].sizeimage;
>>> +
>>> +        return;
>>> +    }
>>> +
>>> +    for (i = 0; i < VIDEO_MAX_PLANES && ef->plane_fmt[i].sizeimage; 
>>> i++)
>>> +        pix_mp->plane_fmt[i] = ef->plane_fmt[i];
>>> +    pix_mp->num_planes = i;
>>> +}
>>> +
>>> +/*
>>> + * v4l2_ext_pix_format_to_format - convert to v4l2_ext_pix_format to 
>>> v4l2_format
>>> + *
>>> + * @ef: A pointer to struct struct v4l2_ext_pix_format to be converted.
>>> + * @f: A pointer to struct v4l2_format to be filled.
>>> + * @is_mplane: Bool indicating if multiplanar API should be used in @f.
>>> + *
>>> + * If pixelformat should be converted to M-variant, change 
>>> ef->pixelformat
>>> + * to the M-variant before calling this function.
>>> + */
>>> +static void v4l2_ext_pix_format_to_format(const struct 
>>> v4l2_ext_pix_format *ef,
>>> +                      struct v4l2_format *f, bool is_mplane)
>>> +{
>>> +    memset(f, 0, sizeof(*f));
>>> +
>>> +    if (ef->modifier != DRM_FORMAT_MOD_LINEAR &&
>>> +        ef->modifier != DRM_FORMAT_MOD_INVALID)
>>> +        pr_warn("Modifiers are not supported in v4l2_format, 
>>> ignoring %llx\n",
>>> +            ef->modifier);
>>> +
>>> +    if (!is_mplane) {
>>> +        f->type = ef->type;
>>> +        v4l2_ext_pix_format_to_pix_format(ef, &f->fmt.pix);
>>> +        return;
>>> +    }
>>> +
>>> +    if (ef->type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
>>> +        f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>>> +    else
>>> +        f->type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
>>> +
>>> +    v4l2_ext_pix_format_to_pix_mp_format(ef, &f->fmt.pix_mp);
>>> +}
>>> +
>>> +static void
>>> +v4l2_pix_format_to_ext_pix_format(const struct v4l2_pix_format *pix,
>>> +                  struct v4l2_ext_pix_format *ef)
>>> +{
>>> +    const struct v4l2_format_info *info =
>>> +                    v4l2_format_info(pix->pixelformat);
>>> +    unsigned int i;
>>> +
>>> +    ef->width = pix->width;
>>> +    ef->height = pix->height;
>>> +    ef->field = pix->field;
>>> +    ef->colorspace = pix->colorspace;
>>> +    ef->ycbcr_enc = pix->ycbcr_enc;
>>> +    ef->quantization = pix->quantization;
>>> +    ef->xfer_func = pix->xfer_func;
>>> +    if (pix->flags)
>>> +        pr_warn("Ignoring pixelformat flags 0x%x\n", pix->flags);
>>> +
>>> +    /* We assume M-variants won't be used in this function */
>>> +    ef->pixelformat = pix->pixelformat;
>>> +
>>> +    ef->plane_fmt[0].bytesperline = pix->bytesperline;
>>> +    ef->plane_fmt[0].sizeimage = pix->sizeimage;
>>> +
>>> +    if (!info)
>>> +        return;
>>> +
>>> +    for (i = 1; i < info->comp_planes; i++) {
>>> +        ef->plane_fmt[i].bytesperline = pix->bytesperline / info->hdiv;
>>> +        ef->plane_fmt[i].sizeimage = ef->plane_fmt[i].bytesperline *
>>> +                         ef->height / info->vdiv;
>>> +        ef->plane_fmt[0].sizeimage -= ef->plane_fmt[i].sizeimage;
>>> +    }
>>> +}
>>> +
>>> +static void
>>> +v4l2_pix_mp_format_to_ext_pix_format(const struct 
>>> v4l2_pix_format_mplane *pix_mp,
>>> +                     struct v4l2_ext_pix_format *ef)
>>> +{
>>> +    const struct v4l2_format_info *info =
>>> +                    v4l2_format_info(pix_mp->pixelformat);
>>> +    unsigned int i;
>>> +
>>> +    ef->width = pix_mp->width;
>>> +    ef->height = pix_mp->height;
>>> +    ef->field = pix_mp->field;
>>> +    ef->colorspace = pix_mp->colorspace;
>>> +    ef->ycbcr_enc = pix_mp->ycbcr_enc;
>>> +    ef->quantization = pix_mp->quantization;
>>> +    ef->xfer_func = pix_mp->xfer_func;
>>> +    if (pix_mp->flags)
>>> +        pr_warn("Ignoring pixelformat flags 0x%x\n", pix_mp->flags);
>>> +
>>> +    if (!info)
>>> +        return;
>>> +
>>> +    ef->pixelformat = info && info->norm ?
>>
>> 'info &&' can be dropped, info is always non-NULL here.
>>
>>> +              info->norm : pix_mp->pixelformat;
>>> +
>>> +    if (info->comp_planes == info->mem_planes) {
>>> +        for (i = 0; i < pix_mp->num_planes && i < VIDEO_MAX_PLANES; 
>>> i++)
>>> +            ef->plane_fmt[i] = pix_mp->plane_fmt[i];
>>> +
>>> +        return;
>>> +    }
>>> +
>>> +    /* case where mem_planes is 1 and comp_planes > 1 */
>>> +    ef->plane_fmt[0] = pix_mp->plane_fmt[0];
>>> +    for (i = 1; i < info->comp_planes; i++) {
>>> +        ef->plane_fmt[i].bytesperline =
>>> +            pix_mp->plane_fmt[0].bytesperline / info->hdiv;
>>> +        ef->plane_fmt[i].sizeimage =
>>> +            ef->plane_fmt[i].bytesperline * ef->height / info->vdiv;
>>> +        ef->plane_fmt[0].sizeimage -= ef->plane_fmt[i].sizeimage;
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * v4l2_format_to_ext_pix_format - convert to v4l2_format to 
>>> v4l2_ext_pix_format
>>> + *
>>> + * @f: A pointer to struct v4l2_format to be converted.
>>> + * @ef: A pointer to struct struct v4l2_ext_pix_format to be filled.
>>> + *
>>> + * This method normalize the pixelformat to non-M variant.
>>> + */
>>> +static void v4l2_format_to_ext_pix_format(const struct v4l2_format *f,
>>> +                      struct v4l2_ext_pix_format *ef)
>>> +{
>>> +    memset(ef, 0, sizeof(*ef));
>>> +
>>> +    switch (f->type) {
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> +        ef->type = f->type;
>>> +        v4l2_pix_format_to_ext_pix_format(&f->fmt.pix, ef);
>>> +        break;
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> +        ef->type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>> +        v4l2_pix_mp_format_to_ext_pix_format(&f->fmt.pix_mp, ef);
>>> +        break;
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> +        ef->type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
>>> +        v4l2_pix_mp_format_to_ext_pix_format(&f->fmt.pix_mp, ef);
>>> +        break;
>>> +    default:
>>> +        WARN("Converting to Ext Pix Format with wrong buffer type 
>>> %s\n",
>>> +             prt_names(f->type, v4l2_type_names));
>>> +        break;
>>> +    }
>>> +}
>>> +
>>>   static int v4l_querycap(const struct v4l2_ioctl_ops *ops,
>>>                   struct file *file, void *fh, void *arg)
>>>   {
>>> @@ -1565,6 +1799,100 @@ static void v4l_pix_format_touch(struct 
>>> v4l2_pix_format *p)
>>>       p->xfer_func = 0;
>>>   }
>>> +static int v4l_fmt_ioctl_via_ext(const struct v4l2_ioctl_ops *ops,
>>> +                 struct file *file, void *fh,
>>> +                 struct v4l2_format *f,
>>> +                 unsigned int ioctl)
>>> +{
>>> +    bool is_multiplanar = V4L2_TYPE_IS_MULTIPLANAR(f->type);
>>> +    struct video_device *vdev = video_devdata(file);
>>> +    struct v4l2_ext_pix_format ef = {0};
>>> +    u32 original_pixfmt = 0;
>>> +    u32 cap_mask;
>>> +    int ret;
>>> +
>>> +    if (ioctl != VIDIOC_G_FMT) {
>>> +        /*
>>> +         * If CSC attributes are read only, set them to DEFAULT
>>> +         * to avoid changes by the driver.
>>> +         */
>>> +        if (is_multiplanar) {
>>> +            if (!(f->fmt.pix_mp.flags & V4L2_PIX_FMT_FLAG_SET_CSC)) {
>>> +                f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
>>> +                f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>>> +                f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
>>> +                f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
>>> +            }
>>> +            /* Unset the flag to avoid warning in the convertion */
>>> +            f->fmt.pix_mp.flags &= ~V4L2_PIX_FMT_FLAG_SET_CSC;
>>> +
>>> +            /* Save pixelformat in case M-variant is being used */
>>> +            original_pixfmt = f->fmt.pix_mp.pixelformat;
>>> +        } else {
>>> +            if (!(f->fmt.pix.flags & V4L2_PIX_FMT_FLAG_SET_CSC)) {
>>> +                f->fmt.pix.colorspace = V4L2_COLORSPACE_DEFAULT;
>>> +                f->fmt.pix.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
>>> +                f->fmt.pix.quantization = V4L2_QUANTIZATION_DEFAULT;
>>> +                f->fmt.pix.xfer_func = V4L2_XFER_FUNC_DEFAULT;
>>> +            }
>>> +            /* Unset the flag to avoid warning in the convertion */
>>> +            f->fmt.pix.flags &= ~V4L2_PIX_FMT_FLAG_SET_CSC;
>>> +        }
>>> +        v4l2_format_to_ext_pix_format(f, &ef);
>>> +    }
>>> +
>>> +    switch (f->type) {
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> +        cap_mask = V4L2_CAP_VIDEO_CAPTURE_MPLANE |
>>> +               V4L2_CAP_VIDEO_M2M_MPLANE;
>>> +        if (!!(vdev->device_caps & cap_mask) !=
>>> +            (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE))
>>> +            return -EINVAL;
>>> +
>>> +        ef.type = V4L2_BUF_TYPE_VIDEO_CAPTURE;
>>> +        if (ioctl == VIDIOC_G_FMT)
>>> +            ret = ops->vidioc_g_ext_pix_fmt_vid_cap(file, fh, &ef);
>>> +        else if (ioctl == VIDIOC_S_FMT)
>>> +            ret = ops->vidioc_s_ext_pix_fmt_vid_cap(file, fh, &ef);
>>> +        else
>>> +            ret = ops->vidioc_try_ext_pix_fmt_vid_cap(file, fh,
>>> +                                  &ef);
>>> +        break;
>>> +
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> +        cap_mask = V4L2_CAP_VIDEO_OUTPUT_MPLANE |
>>> +               V4L2_CAP_VIDEO_M2M_MPLANE;
>>> +        if (!!(vdev->device_caps & cap_mask) !=
>>> +            (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE))
>>> +            return -EINVAL;
>>> +
>>> +        ef.type = V4L2_BUF_TYPE_VIDEO_OUTPUT;
>>> +        if (ioctl == VIDIOC_G_FMT)
>>> +            ret = ops->vidioc_g_ext_pix_fmt_vid_out(file, fh, &ef);
>>> +        else if (ioctl == VIDIOC_S_FMT)
>>> +            ret = ops->vidioc_s_ext_pix_fmt_vid_out(file, fh, &ef);
>>> +        else
>>> +            ret = ops->vidioc_try_ext_pix_fmt_vid_out(file, fh,
>>> +                                  &ef);
>>> +        break;
>>> +
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    if (original_pixfmt != ef.pixelformat &&
>>> +        v4l2_format_info(original_pixfmt))
>>
>> Could this test be simplified to: 'if (original_pixfmt)'?
>>
>> I.e., if the original pixfmt was saved, then restore it here.
>>
>>> +        ef.pixelformat = original_pixfmt;
>>> +
>>> +    v4l2_ext_pix_format_to_format(&ef, f, is_multiplanar);
>>> +    return 0;
>>> +}
>>> +
>>>   static int v4l_g_fmt(const struct v4l2_ioctl_ops *ops,
>>>                   struct file *file, void *fh, void *arg)
>>>   {
>>> @@ -1601,17 +1929,26 @@ static int v4l_g_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       switch (p->type) {
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> -        if (unlikely(!ops->vidioc_g_fmt_vid_cap))
>>> +        if (unlikely(!ops->vidioc_g_fmt_vid_cap &&
>>> +                 !ops->vidioc_g_ext_pix_fmt_vid_cap))
>>>               break;
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>> -        ret = ops->vidioc_g_fmt_vid_cap(file, fh, arg);
>>> +        ret = ops->vidioc_g_fmt_vid_cap ?
>>> +              ops->vidioc_g_fmt_vid_cap(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg,
>>> +                        VIDIOC_G_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           if (vfd->vfl_type == VFL_TYPE_TOUCH)
>>>               v4l_pix_format_touch(&p->fmt.pix);
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> -        return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
>>> +        if (ops->vidioc_g_fmt_vid_cap_mplane)
>>> +            return ops->vidioc_g_fmt_vid_cap_mplane(file, fh, arg);
>>> +        else if (ops->vidioc_g_ext_pix_fmt_vid_cap)
>>
>> 'else' can be dropped.
>>
>>> +            return v4l_fmt_ioctl_via_ext(ops, file, fh, arg,
>>> +                             VIDIOC_G_FMT);
>>> +        break;
>>>       case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>>>           return ops->vidioc_g_fmt_vid_overlay(file, fh, arg);
>>>       case V4L2_BUF_TYPE_VBI_CAPTURE:
>>> @@ -1619,15 +1956,23 @@ static int v4l_g_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
>>>           return ops->vidioc_g_fmt_sliced_vbi_cap(file, fh, arg);
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> -        if (unlikely(!ops->vidioc_g_fmt_vid_out))
>>> +        if (unlikely(!ops->vidioc_g_fmt_vid_out &&
>>> +                 !ops->vidioc_g_ext_pix_fmt_vid_out))
>>>               break;
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>> -        ret = ops->vidioc_g_fmt_vid_out(file, fh, arg);
>>> +        ret = ops->vidioc_g_fmt_vid_out ?
>>> +              ops->vidioc_g_fmt_vid_out(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg, VIDIOC_G_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> -        return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
>>> +        if (ops->vidioc_g_fmt_vid_out_mplane)
>>> +            return ops->vidioc_g_fmt_vid_out_mplane(file, fh, arg);
>>> +        else if (ops->vidioc_g_ext_pix_fmt_vid_out)
>>
>> Ditto.
>>
>>> +            return v4l_fmt_ioctl_via_ext(ops, file, fh, arg,
>>> +                             VIDIOC_G_FMT);
>>> +        break;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>>>           return ops->vidioc_g_fmt_vid_out_overlay(file, fh, arg);
>>>       case V4L2_BUF_TYPE_VBI_OUTPUT:
>>> @@ -1646,6 +1991,42 @@ static int v4l_g_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       return -EINVAL;
>>>   }
>>> +static int v4l_g_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,
>>> +                 struct file *file, void *fh, void *arg)
>>> +{
>>> +    struct v4l2_ext_pix_format *ef = arg;
>>> +    struct v4l2_format f = {
>>> +        .type = ef->type,
>>> +    };
>>> +    int ret = check_fmt(file, ef->type);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    memset(ef, 0, sizeof(*ef));
>>> +    ef->type = f.type;
>>> +
>>> +    switch (f.type) {
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> +        if (ops->vidioc_g_ext_pix_fmt_vid_cap)
>>> +            return ops->vidioc_g_ext_pix_fmt_vid_cap(file, fh, ef);
>>> +        break;
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> +        if (ops->vidioc_g_ext_pix_fmt_vid_out)
>>> +            return ops->vidioc_g_ext_pix_fmt_vid_out(file, fh, ef);
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    ret = v4l_g_fmt(ops, file, fh, &f);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    v4l2_format_to_ext_pix_format(&f, ef);
>>> +    return 0;
>>> +}
>>> +
>>>   static int v4l_s_fmt(const struct v4l2_ioctl_ops *ops,
>>>                   struct file *file, void *fh, void *arg)
>>>   {
>>> @@ -1664,23 +2045,29 @@ static int v4l_s_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       switch (p->type) {
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> -        if (unlikely(!ops->vidioc_s_fmt_vid_cap))
>>> +        if (unlikely(!ops->vidioc_s_fmt_vid_cap &&
>>> +                 !ops->vidioc_s_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix);
>>> -        ret = ops->vidioc_s_fmt_vid_cap(file, fh, arg);
>>> +        ret = ops->vidioc_s_fmt_vid_cap ?
>>> +              ops->vidioc_s_fmt_vid_cap(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg, VIDIOC_S_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           if (vfd->vfl_type == VFL_TYPE_TOUCH)
>>>               v4l_pix_format_touch(&p->fmt.pix);
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> -        if (unlikely(!ops->vidioc_s_fmt_vid_cap_mplane))
>>> +        if (unlikely(!ops->vidioc_s_fmt_vid_cap_mplane &&
>>> +                 !ops->vidioc_s_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
>>>           for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
>>>               CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
>>>                         bytesperline);
>>> -        return ops->vidioc_s_fmt_vid_cap_mplane(file, fh, arg);
>>> +        return ops->vidioc_s_fmt_vid_cap_mplane ?
>>> +               ops->vidioc_s_fmt_vid_cap_mplane(file, fh, arg) :
>>> +               v4l_fmt_ioctl_via_ext(ops, file, fh, arg,  
>>> VIDIOC_S_FMT);
>>>       case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>>>           if (unlikely(!ops->vidioc_s_fmt_vid_overlay))
>>>               break;
>>> @@ -1697,21 +2084,27 @@ static int v4l_s_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>           CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
>>>           return ops->vidioc_s_fmt_sliced_vbi_cap(file, fh, arg);
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> -        if (unlikely(!ops->vidioc_s_fmt_vid_out))
>>> +        if (unlikely(!ops->vidioc_s_fmt_vid_out &&
>>> +                 !ops->vidioc_s_ext_pix_fmt_vid_out))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix);
>>> -        ret = ops->vidioc_s_fmt_vid_out(file, fh, arg);
>>> +        ret = ops->vidioc_s_fmt_vid_out ?
>>> +              ops->vidioc_s_fmt_vid_out(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg, VIDIOC_S_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> -        if (unlikely(!ops->vidioc_s_fmt_vid_out_mplane))
>>> +        if (unlikely(!ops->vidioc_s_fmt_vid_out_mplane &&
>>> +                 !ops->vidioc_s_ext_pix_fmt_vid_out))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
>>>           for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
>>>               CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
>>>                         bytesperline);
>>> -        return ops->vidioc_s_fmt_vid_out_mplane(file, fh, arg);
>>> +        return ops->vidioc_s_fmt_vid_out_mplane ?
>>> +               ops->vidioc_s_fmt_vid_out_mplane(file, fh, arg) :
>>> +               v4l_fmt_ioctl_via_ext(ops, file, fh, arg, VIDIOC_S_FMT);
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>>>           if (unlikely(!ops->vidioc_s_fmt_vid_out_overlay))
>>>               break;
>>> @@ -1751,6 +2144,43 @@ static int v4l_s_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       return -EINVAL;
>>>   }
>>> +static int v4l_s_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,
>>> +                 struct file *file, void *fh, void *arg)
>>> +{
>>> +    struct video_device *vfd = video_devdata(file);
>>> +    struct v4l2_ext_pix_format *ef = arg;
>>> +    struct v4l2_format f;
>>> +    int ret = check_fmt(file, ef->type);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    memset(ef->reserved, 0, sizeof(ef->reserved));
>>> +
>>> +    switch (ef->type) {
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> +        if (ops->vidioc_s_ext_pix_fmt_vid_cap)
>>> +            return ops->vidioc_s_ext_pix_fmt_vid_cap(file, fh, ef);
>>> +        break;
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> +        if (ops->vidioc_s_ext_pix_fmt_vid_out)
>>> +            return ops->vidioc_s_ext_pix_fmt_vid_out(file, fh, ef);
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    v4l2_ext_pix_format_to_format(ef, &f, 
>>> V4L2_IS_CAP_MULTIPLANAR(vfd));
>>> +
>>> +    ret = v4l_s_fmt(ops, file, fh, &f);
>>> +    if (ret)
>>> +        /* TODO: retry with M-variant of ef->pixelformat? */
>>
>> See my comments on this at the top.
>>
>>> +        return ret;
>>> +
>>> +    v4l2_format_to_ext_pix_format(&f, ef);
>>> +    return 0;
>>> +}
>>> +
>>>   static int v4l_try_fmt(const struct v4l2_ioctl_ops *ops,
>>>                   struct file *file, void *fh, void *arg)
>>>   {
>>> @@ -1766,23 +2196,30 @@ static int v4l_try_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       switch (p->type) {
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> -        if (unlikely(!ops->vidioc_try_fmt_vid_cap))
>>> +        if (unlikely(!ops->vidioc_try_fmt_vid_cap &&
>>> +                 !ops->vidioc_try_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix);
>>> -        ret = ops->vidioc_try_fmt_vid_cap(file, fh, arg);
>>> +        ret = ops->vidioc_try_fmt_vid_cap ?
>>> +              ops->vidioc_try_fmt_vid_cap(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg, 
>>> VIDIOC_TRY_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           if (vfd->vfl_type == VFL_TYPE_TOUCH)
>>>               v4l_pix_format_touch(&p->fmt.pix);
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> -        if (unlikely(!ops->vidioc_try_fmt_vid_cap_mplane))
>>> +        if (unlikely(!ops->vidioc_try_fmt_vid_cap_mplane &&
>>> +                 !ops->vidioc_try_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
>>>           for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
>>>               CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
>>>                         bytesperline);
>>> -        return ops->vidioc_try_fmt_vid_cap_mplane(file, fh, arg);
>>> +        return ops->vidioc_try_fmt_vid_cap_mplane ?
>>> +               ops->vidioc_try_fmt_vid_cap_mplane(file, fh, arg) :
>>> +               v4l_fmt_ioctl_via_ext(ops, file, fh, arg,
>>> +                         VIDIOC_TRY_FMT);
>>>       case V4L2_BUF_TYPE_VIDEO_OVERLAY:
>>>           if (unlikely(!ops->vidioc_try_fmt_vid_overlay))
>>>               break;
>>> @@ -1799,21 +2236,28 @@ static int v4l_try_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>           CLEAR_AFTER_FIELD(p, fmt.sliced.io_size);
>>>           return ops->vidioc_try_fmt_sliced_vbi_cap(file, fh, arg);
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> -        if (unlikely(!ops->vidioc_try_fmt_vid_out))
>>> +        if (unlikely(!ops->vidioc_try_fmt_vid_out &&
>>> +                 !ops->vidioc_try_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix);
>>> -        ret = ops->vidioc_try_fmt_vid_out(file, fh, arg);
>>> +        ret = ops->vidioc_try_fmt_vid_out ?
>>> +              ops->vidioc_try_fmt_vid_out(file, fh, arg) :
>>> +              v4l_fmt_ioctl_via_ext(ops, file, fh, arg, 
>>> VIDIOC_TRY_FMT);
>>>           /* just in case the driver zeroed it again */
>>>           p->fmt.pix.priv = V4L2_PIX_FMT_PRIV_MAGIC;
>>>           return ret;
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> -        if (unlikely(!ops->vidioc_try_fmt_vid_out_mplane))
>>> +        if (unlikely(!ops->vidioc_try_fmt_vid_out_mplane &&
>>> +                 !ops->vidioc_try_ext_pix_fmt_vid_cap))
>>>               break;
>>>           CLEAR_AFTER_FIELD(p, fmt.pix_mp.xfer_func);
>>>           for (i = 0; i < p->fmt.pix_mp.num_planes; i++)
>>>               CLEAR_AFTER_FIELD(&p->fmt.pix_mp.plane_fmt[i],
>>>                         bytesperline);
>>> -        return ops->vidioc_try_fmt_vid_out_mplane(file, fh, arg);
>>> +        return ops->vidioc_try_fmt_vid_out_mplane ?
>>> +               ops->vidioc_try_fmt_vid_out_mplane(file, fh, arg) :
>>> +               v4l_fmt_ioctl_via_ext(ops, file, fh, arg,
>>> +                         VIDIOC_TRY_FMT);
>>>       case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
>>>           if (unlikely(!ops->vidioc_try_fmt_vid_out_overlay))
>>>               break;
>>> @@ -1853,6 +2297,45 @@ static int v4l_try_fmt(const struct 
>>> v4l2_ioctl_ops *ops,
>>>       return -EINVAL;
>>>   }
>>> +static int v4l_try_ext_pix_fmt(const struct v4l2_ioctl_ops *ops,
>>> +                   struct file *file, void *fh, void *arg)
>>> +{
>>> +    struct video_device *vfd = video_devdata(file);
>>> +    struct v4l2_ext_pix_format *ef = arg;
>>> +    struct v4l2_format f;
>>> +    int ret = check_fmt(file, ef->type);
>>> +
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    memset(ef->reserved, 0, sizeof(ef->reserved));
>>> +
>>> +    switch (ef->type) {
>>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE:
>>> +        if (ops->vidioc_try_ext_pix_fmt_vid_cap)
>>> +            return ops->vidioc_try_ext_pix_fmt_vid_cap(file, fh,
>>> +                                   ef);
>>> +        break;
>>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT:
>>> +        if (ops->vidioc_try_ext_pix_fmt_vid_out)
>>> +            return ops->vidioc_try_ext_pix_fmt_vid_out(file, fh,
>>> +                                   ef);
>>> +        break;
>>> +    default:
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    v4l2_ext_pix_format_to_format(ef, &f, 
>>> V4L2_IS_CAP_MULTIPLANAR(vfd));
>>> +
>>> +    ret = v4l_try_fmt(ops, file, fh, &f);
>>> +    if (ret)
>>> +        /* TODO: retry with M-variant of ef->pixelformat? */
>>> +        return ret;
>>> +
>>> +    v4l2_format_to_ext_pix_format(&f, ef);
>>> +    return 0;
>>> +}
>>> +
>>>   static int v4l_streamon(const struct v4l2_ioctl_ops *ops,
>>>                   struct file *file, void *fh, void *arg)
>>>   {
>>> @@ -2854,6 +3337,9 @@ static const struct v4l2_ioctl_info 
>>> v4l2_ioctls[] = {
>>>       IOCTL_INFO(VIDIOC_ENUM_FREQ_BANDS, v4l_enum_freq_bands, 
>>> v4l_print_freq_band, 0),
>>>       IOCTL_INFO(VIDIOC_DBG_G_CHIP_INFO, v4l_dbg_g_chip_info, 
>>> v4l_print_dbg_chip_info, INFO_FL_CLEAR(v4l2_dbg_chip_info, match)),
>>>       IOCTL_INFO(VIDIOC_QUERY_EXT_CTRL, v4l_query_ext_ctrl, 
>>> v4l_print_query_ext_ctrl, INFO_FL_CTRL | 
>>> INFO_FL_CLEAR(v4l2_query_ext_ctrl, id)),
>>> +    IOCTL_INFO(VIDIOC_G_EXT_PIX_FMT, v4l_g_ext_pix_fmt, 
>>> v4l_print_ext_pix_format, 0),
>>> +    IOCTL_INFO(VIDIOC_S_EXT_PIX_FMT, v4l_s_ext_pix_fmt, 
>>> v4l_print_ext_pix_format, INFO_FL_PRIO),
>>> +    IOCTL_INFO(VIDIOC_TRY_EXT_PIX_FMT, v4l_try_ext_pix_fmt, 
>>> v4l_print_ext_pix_format, 0),
>>>   };
>>>   #define V4L2_IOCTLS ARRAY_SIZE(v4l2_ioctls)
>>> diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
>>> index edb733f21604..c44708dc9355 100644
>>> --- a/include/media/v4l2-ioctl.h
>>> +++ b/include/media/v4l2-ioctl.h
>>> @@ -48,11 +48,17 @@ struct v4l2_fh;
>>>    * @vidioc_g_fmt_vid_cap: pointer to the function that implements
>>>    *    :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video capture
>>>    *    in single plane mode
>>> + * @vidioc_g_ext_pix_fmt_vid_cap: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_G_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic 
>>> for video
>>> + *    capture
>>>    * @vidioc_g_fmt_vid_overlay: pointer to the function that implements
>>>    *    :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>>    * @vidioc_g_fmt_vid_out: pointer to the function that implements
>>>    *    :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video out
>>>    *    in single plane mode
>>> + * @vidioc_g_ext_pix_fmt_vid_out: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_G_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic 
>>> for video
>>> + *    out
>>>    * @vidioc_g_fmt_vid_out_overlay: pointer to the function that 
>>> implements
>>>    *    :ref:`VIDIOC_G_FMT <vidioc_g_fmt>` ioctl logic for video 
>>> overlay output
>>>    * @vidioc_g_fmt_vbi_cap: pointer to the function that implements
>>> @@ -82,11 +88,16 @@ struct v4l2_fh;
>>>    * @vidioc_s_fmt_vid_cap: pointer to the function that implements
>>>    *    :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video capture
>>>    *    in single plane mode
>>> + * @vidioc_s_ext_pix_fmt_vid_cap: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_S_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl logic 
>>> for video
>>> + *    capture
>>>    * @vidioc_s_fmt_vid_overlay: pointer to the function that implements
>>>    *    :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video overlay
>>>    * @vidioc_s_fmt_vid_out: pointer to the function that implements
>>>    *    :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video out
>>>    *    in single plane mode
>>> + * @vidioc_s_ext_pix_fmt_vid_out: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_S_EXT_PIX_FMT <vidioc_g_fmt>` ioctl logic for 
>>> video out
>>>    * @vidioc_s_fmt_vid_out_overlay: pointer to the function that 
>>> implements
>>>    *    :ref:`VIDIOC_S_FMT <vidioc_g_fmt>` ioctl logic for video 
>>> overlay output
>>>    * @vidioc_s_fmt_vbi_cap: pointer to the function that implements
>>> @@ -116,11 +127,16 @@ struct v4l2_fh;
>>>    * @vidioc_try_fmt_vid_cap: pointer to the function that implements
>>>    *    :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video 
>>> capture
>>>    *    in single plane mode
>>> + * @vidioc_try_ext_pix_fmt_vid_cap: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_TRY_EXT_PIX_FMT <vidioc_g_ext_pix_fmt>` ioctl 
>>> logic for
>>> +    video capture
>>>    * @vidioc_try_fmt_vid_overlay: pointer to the function that 
>>> implements
>>>    *    :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video 
>>> overlay
>>>    * @vidioc_try_fmt_vid_out: pointer to the function that implements
>>>    *    :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video out
>>>    *    in single plane mode
>>> + * @vidioc_try_ext_pix_fmt_vid_out: pointer to the function that 
>>> implements
>>> + *    :ref:`VIDIOC_TRY_EXT_PIX_FMT <vidioc_g_fmt>` ioctl logic for 
>>> video out
>>>    * @vidioc_try_fmt_vid_out_overlay: pointer to the function that 
>>> implements
>>>    *    :ref:`VIDIOC_TRY_FMT <vidioc_g_fmt>` ioctl logic for video 
>>> overlay
>>>    *    output
>>> @@ -319,10 +335,14 @@ struct v4l2_ioctl_ops {
>>>       /* VIDIOC_G_FMT handlers */
>>>       int (*vidioc_g_fmt_vid_cap)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>> +    int (*vidioc_g_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>>> +                        struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_g_fmt_vid_overlay)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>>       int (*vidioc_g_fmt_vid_out)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>> +    int (*vidioc_g_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>>> +                        struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_g_fmt_vid_out_overlay)(struct file *file, void *fh,
>>>                           struct v4l2_format *f);
>>>       int (*vidioc_g_fmt_vbi_cap)(struct file *file, void *fh,
>>> @@ -349,10 +369,14 @@ struct v4l2_ioctl_ops {
>>>       /* VIDIOC_S_FMT handlers */
>>>       int (*vidioc_s_fmt_vid_cap)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>> +    int (*vidioc_s_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>>> +                        struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_s_fmt_vid_overlay)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>>       int (*vidioc_s_fmt_vid_out)(struct file *file, void *fh,
>>>                       struct v4l2_format *f);
>>> +    int (*vidioc_s_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>>> +                        struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_s_fmt_vid_out_overlay)(struct file *file, void *fh,
>>>                           struct v4l2_format *f);
>>>       int (*vidioc_s_fmt_vbi_cap)(struct file *file, void *fh,
>>> @@ -379,10 +403,14 @@ struct v4l2_ioctl_ops {
>>>       /* VIDIOC_TRY_FMT handlers */
>>>       int (*vidioc_try_fmt_vid_cap)(struct file *file, void *fh,
>>>                         struct v4l2_format *f);
>>> +    int (*vidioc_try_ext_pix_fmt_vid_cap)(struct file *file, void *fh,
>>> +                          struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_try_fmt_vid_overlay)(struct file *file, void *fh,
>>>                         struct v4l2_format *f);
>>>       int (*vidioc_try_fmt_vid_out)(struct file *file, void *fh,
>>>                         struct v4l2_format *f);
>>> +    int (*vidioc_try_ext_pix_fmt_vid_out)(struct file *file, void *fh,
>>> +                          struct v4l2_ext_pix_format *ef);
>>>       int (*vidioc_try_fmt_vid_out_overlay)(struct file *file, void *fh,
>>>                            struct v4l2_format *f);
>>>       int (*vidioc_try_fmt_vbi_cap)(struct file *file, void *fh,
>>> diff --git a/include/uapi/linux/videodev2.h 
>>> b/include/uapi/linux/videodev2.h
>>> index d9b7c9177605..a2d850513708 100644
>>> --- a/include/uapi/linux/videodev2.h
>>> +++ b/include/uapi/linux/videodev2.h
>>> @@ -2270,6 +2270,43 @@ struct v4l2_pix_format_mplane {
>>>       __u8                reserved[7];
>>>   } __attribute__ ((packed));
>>> +/**
>>> + * struct v4l2_ext_pix_format - extended single/multiplanar format 
>>> definition
>>> + * @type:        type of the data stream; 
>>> V4L2_BUF_TYPE_VIDEO_CAPTURE or
>>> + *            V4L2_BUF_TYPE_VIDEO_OUTPUT
>>> + * @width:        image width in pixels
>>> + * @height:        image height in pixels
>>> + * @field:        enum v4l2_field; field order (for interlaced video)
>>> + * @plane_fmt:        per-plane information
>>> + * @pixelformat:    little endian four character code (fourcc)
>>> + * @modifier:        modifier applied to the format (used for tiled 
>>> formats
>>> + *            and other kind of HW-specific formats, like compressed
>>> + *            formats) as defined in drm_fourcc.h
>>> + * @colorspace:        enum v4l2_colorspace; supplemental to 
>>> pixelformat
>>> + * @xfer_func:        enum v4l2_xfer_func, colorspace transfer function
>>> + * @ycbcr_enc:        enum v4l2_ycbcr_encoding, Y'CbCr encoding
>>> + * @hsv_enc:        enum v4l2_hsv_encoding, HSV encoding
>>> + * @quantization:    enum v4l2_quantization, colorspace quantization
>>> + * @reserved:        extra space reserved for future fields, must be 
>>> set to 0
>>> + */
>>> +struct v4l2_ext_pix_format {
>>> +    __u32 type;
>>> +    __u32 width;
>>> +    __u32 height;
>>> +    __u32 field;
>>> +    struct v4l2_plane_pix_format plane_fmt[VIDEO_MAX_PLANES];
>>> +    __u32 pixelformat;
>>> +    __u64 modifier;
>>> +    __u32 colorspace;
>>> +    __u32 xfer_func;
>>> +    union {
>>> +        __u32 ycbcr_enc;
>>> +        __u32 hsv_enc;
>>> +    };
>>> +    __u32 quantization;
>>> +    __u32 reserved[9];
>>> +};
>>> +
>>>   /**
>>>    * struct v4l2_sdr_format - SDR format definition
>>>    * @pixelformat:    little endian four character code (fourcc)
>>> @@ -2583,6 +2620,10 @@ struct v4l2_create_buffers {
>>>   #define VIDIOC_QUERY_EXT_CTRL    _IOWR('V', 103, struct 
>>> v4l2_query_ext_ctrl)
>>> +#define VIDIOC_G_EXT_PIX_FMT    _IOWR('V', 104, struct 
>>> v4l2_ext_pix_format)
>>> +#define VIDIOC_S_EXT_PIX_FMT    _IOWR('V', 105, struct 
>>> v4l2_ext_pix_format)
>>> +#define VIDIOC_TRY_EXT_PIX_FMT    _IOWR('V', 106, struct 
>>> v4l2_ext_pix_format)
>>> +
>>>   /* Reminder: when adding new ioctls please add support for them to
>>>      drivers/media/v4l2-core/v4l2-compat-ioctl32.c as well! */
>>>
>>
>> Regards,
>>
>>     Hans
>>
> 

-- 
Hsia-Jun(Randy) Li
