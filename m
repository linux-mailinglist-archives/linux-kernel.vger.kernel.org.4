Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3323625142
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiKKDEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbiKKDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:04:19 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181E5B592;
        Thu, 10 Nov 2022 19:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKeoRoCuQ09nole9jMLoW1nWbWD8nZ/kcv0yOL/d7aXN6I28FmEYa1l1g/2iICP3rorFmx5dkiU/uAqbF4NpXFo7T1DzmDtyQD4mjTDlDmoUR5PofV+qEedWanoCY2mA7iZD6xgxdBbP08yXfUDl/c3g5ulnyAIghw19UkHkBB8en3PSS4wyNHRvEUzvRF3hHMEG6EvYp3A8RvVe3wv80zEklYb4VGaNdVJi3N87N7wV8zwNKnjnQ65WzeZ++3op0dZ77aCPLeEWM67yvxOfvanw5QePa3m2j2oCTITc6uoEGvD5bEen0/OFkEzz9lvcX5oDsaU4r17L8j+tepNv8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMJuDkkeifJQwO8ZStw5S2ptTpIV/hEYtGXnQJY2K/U=;
 b=TJ/OdtOM8PRsVpD8ek2xHFl/id2YleJCsLPnZ7XYaHSrpVrAetngficuSXjxQeEjg+tJkBRh5cBQpRQoqMQcY5rJmVy+4xwL8mBnFeTWZZuH+SdBgiynYDXBdMLHydnYsEw6kjCUP4e3C9NSjobyOww6ZJz/RtXfcB2a20TV3VNrjq6yFXq3Kc1y/tCY2iq2cr6h0xby0pGBvhNWRl0JGj7XCD7GaYLpV0S4EpmeqDTmC+DjQ12l1nNydO2Mq8xw8c5aJvVETVvN1kmzejlRivUOgaVYVZRnpLHKESIQdRrPXhW+yvKsNNOpKWeiuD7mn3khqRIgmd68J0aQg6CDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMJuDkkeifJQwO8ZStw5S2ptTpIV/hEYtGXnQJY2K/U=;
 b=fMjKLPAbogivKV5uSnQGOjxd9JNVpaArcFKi0mvTqX5LLwNehtl8qcANjQjXIiboDSV08Foeedc/5bFCH0jgy2Rfbo+ggEiX+hVpy1CWqMWlOAQcqSiliCL0XHVDYobgDiK3kvWgIjoVyRJFVJuUHPEJgy/PpPcDnHL0T18AfX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6447.namprd03.prod.outlook.com (2603:10b6:510:a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:04:15 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::a132:66d9:ed0f:e5c1%6]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 03:04:15 +0000
Message-ID: <3b1edf81-bcc0-0b56-7e55-93da55d7f747@synaptics.com>
Date:   Fri, 11 Nov 2022 11:03:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC PATCH v6 02/11] media: v4l2: Extend pixel formats to unify
 single/multi-planar handling (and more)
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     mchehab@kernel.org, hans.verkuil@cisco.com,
        laurent.pinchart@ideasonboard.com, sakari.ailus@iki.fi,
        boris.brezillon@collabora.com, hiroh@chromium.org,
        Brian.Starkey@arm.com, kernel@collabora.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        frkoenig@chromium.org, stanimir.varbanov@linaro.org,
        tfiga@chromium.org, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org
References: <20210114180738.1758707-1-helen.koike@collabora.com>
 <20210114180738.1758707-3-helen.koike@collabora.com>
 <d0d1f74f-7e77-1b18-0529-dbbec8889584@xs4all.nl>
 <577c56bf-146c-f34a-2028-075170076de7@collabora.com>
 <708221e8-a805-c394-6958-6c7ec24bfe66@synaptics.com>
 <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <03f6fd9ff6a757f6d1cb6cc552efcb0b94327104.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: a0650aa1-09e9-4619-0a81-08dac3916ab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: agtYm2LP3JkAbiGpHpZ6K1woDIs8GPesALrY4cfEHLMWwj8QaTMw07JrV8pqLSTs2zRdyOvy94qP9awyd0stnOHrJApIfxWXrEbc5S/VDQHwfx4Wqg9KXzx2UraeemSQ3YId6pKr1AQMEqT06F5++Ur8JdRGdl2B0J3L09kjVY5fTNLDL5uBobBrrodKpaH15Y1YZyWEIjMGCRdh7C33gvknt/Toy/LKK3cPrtiEgqul1vyHWX3VEUIWgETGVANskq3wKPsTA7aIuBLfJM8GEq6PqHZETXIZy4VB9jBt2SFOjAnXNhMDtrm9NSAzXaZhUdUcJ/LwxcDZleJBFKH0jIRy3ytJmgzpJsJ9p9z/9fdUg1lmnTS1+V59xjpK82w33T/C0TZHBj/Qu4Su+QqvAudRQmstffBgXK+F//oTOou3g6GOrlk2G+7JW6g3Ay2DofI0UirRa2pQRdehp/Lhb/1vLXZmsrOEtORAF02bLdN81x4q2gQNGtNstD1ruBRftir2wRgYsBJEUcpJCO+4rmKe/KQPA0ZjFWjbTgHYb0HBRC6b5x00cGrsFf3tXNYZLkXIZA3IWgveseTxxmBShcteBsubPJYEgmmaxSdiMTsE6KZ5erEIUMNIUq6WG1gHZK+2tr3A1S8JuRELzY4A0J56cLUC+16W8R6ItVYTQJxgTLJZJ6COTm6GYbdHhzxtf7Z42YwkTKiF4EKBdQBEq0vYHn7/kkkqXRC0+f9WFcfIbkmW8CNsCSPVBDF5RNSibIyi1KJBVNgOEDw4h4RR8zCf8zcwDhhMa77O2zZA3kyxjXIUGHpU02lFuVxS91lr4ty1qrAYBVqh3A7PZJEWUo93voIs4ma5MGEAsA0TyJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(66946007)(38100700002)(66556008)(66476007)(38350700002)(41300700001)(8676002)(4326008)(6512007)(53546011)(52116002)(966005)(478600001)(6506007)(83380400001)(316002)(6916009)(36756003)(6486002)(86362001)(186003)(2616005)(31696002)(66574015)(6666004)(26005)(66899015)(2906002)(31686004)(5660300002)(7416002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2tGVHJNVlkrRjRNR09vT1hiMWlQdkk4bDFzZGdPcUVxZG5uRGx0aEJxWUpY?=
 =?utf-8?B?V0RlMW9EUUtlQk9Rc3dnZCtRcllCYXJLTGQ0VmFUa09GU1ZXWVFZaVJsbHc0?=
 =?utf-8?B?NHYxTERvNndrZE9yMWpreWR3bVJxbU43a3cyeDhCUWFMYUQ3TDVQQlhaQlJN?=
 =?utf-8?B?N0h5eU5TTTVrZ0VWR2x0azdpZWhhZVpQZVNVL05Sam1qUnRQV2xoSlZGWXRz?=
 =?utf-8?B?QmNvYUFmbHp4cjUyOW5Ic2EvcUoxdWt5clBCRmVaN0RJN3p2NnkxcDBCWkh3?=
 =?utf-8?B?c3E4Yi9ZQmZvRVBGZGZMYmlVT3JXZzRqTjhza1VodGhTaXh1MVNLRlBtekVV?=
 =?utf-8?B?WFY4Ny9sT3JTVXdmMW5OcVFYR2N5MEx4cUxsUmFOdm5CVkZGdGlORTZuelUv?=
 =?utf-8?B?WmNDYmtIdkpnUmhwb3hQKzFFQUcyUGZFZVlJY0xHYjFWem9LQzlUSTBhMXJa?=
 =?utf-8?B?VGxhNFZPSUJEZU9lTittY1VsRWdzRUFPeGFIZTZIU25Ya3JFOHROLy8wZ0Fx?=
 =?utf-8?B?WDZrZnp4WmptajBSMlNMdm9HZktjaDVXbGZlR2RvWFQzOHlLeEFNZzRJZ3ZJ?=
 =?utf-8?B?N0NRTHFPZVN2azd0TXg0N2dqdmVTNkZ4NWlrVUtoazUvOXk3dGdVMGpQbzNt?=
 =?utf-8?B?aVpwbllZZGlKVndibWY2alJBMUttRm1ubWFmcm1uZVY1TG9wcitReWMvUlNG?=
 =?utf-8?B?REZZVzkveG5SdE44RUtCbUEzekxsMW9kNXpnNmgzMS9aK1RpWmw3a1FaRUQ5?=
 =?utf-8?B?VlhBMDlLRjlJUW81NGVDQkd5ejYvZFYvYk43K2ZzQmZHR1J4b1RGbEZTN2Z6?=
 =?utf-8?B?VmRncDBnTy8vYmd2V0JZdkVILzFOekFFZGhkQi9ORGlsUTlNaXRzOCtIeFFK?=
 =?utf-8?B?OXl3UjBOQklIdDBWbG0xSm4zMzVQNFZGMUpIMG5PbE5jMEhkRTdLa0pRRyta?=
 =?utf-8?B?ZVhmQjRjc212YWNNL2FGWEY1bU1NcGdacDJ5NERMOFBBQjNZVW5kSnpmcktZ?=
 =?utf-8?B?bC9ERGdaK3luMXRIUldzbG5tbU9NV1FnemZwbVZWZm16aTZ0cnZIUERTRXdm?=
 =?utf-8?B?TVBYYkZUbFJlaEMrN2VnajZvNFBhMEVtd0lZSTNmTk5EY3kzbFA1aG9zWWtv?=
 =?utf-8?B?VTdtK3ZVQUtuR1c0SFcyd2VKU3gzS1ljTGJjcldJRHBqOEp3RjJFdGxUVFhD?=
 =?utf-8?B?UVdqWmI2S1RMbnFwQjdCSnczMjJrREtna2FvT00zbUhSZnBrZmtVYzk5TFkr?=
 =?utf-8?B?SFZ3cU9PdWZMNjA0cytRT1RjZ2E2cjlEc29VcWxvTHdxNytqV3Zqb1NsRkRs?=
 =?utf-8?B?NFRyd3c4d0R6eGw5MGZ6OGVVajQ5M2xpZGpzZlFidXlvM0ZSci9qWjZLOHpv?=
 =?utf-8?B?NUcveWU5WkVzK3kxelhXUmpKRjhPNEVlTnM4WUZXS1JDVk93dDM2Q3dSTk94?=
 =?utf-8?B?d2hyMlMycHI4UnlScHduOVNjVWFQWFYwaTBGMC81TUpRVTlSUzB6bFdsb2R3?=
 =?utf-8?B?WXJTbjFOaDNscnhuclY0SzIveFZnVGUxQUxnNzBUNVJ0MGhjZnZ4VEQ2MUlX?=
 =?utf-8?B?NCtpeHVMN0tuL3JoYjJEWTFzMzFidG1JZS9IK1d4S3hxZ1E2SDkwdlo2cDFP?=
 =?utf-8?B?OHlhZlM3alB4WnNtdmFjK3N5MzJreHZqYTlKZzJIZkhraDVlaW1lcjU1YTBT?=
 =?utf-8?B?eExnTTROTU92SUFiNXJuSTEyVDRpaVFZMjVpRlV6bFMzd3FBeUxCczgyNEpE?=
 =?utf-8?B?RWpZYWY3K0xOcWt5dUpEMlU3V05ibWNBczI1bnJRWmhGS0FpUG1INGQ1NjQ1?=
 =?utf-8?B?bC9HeDA4Ym9tMnkwOEdKNmZVaFA5T3RpMDJKNENVb1pUdFlkZ1dFdHc1ZlV0?=
 =?utf-8?B?NkdaREFOcnNMMkllQlYrVTQ4bjJpekxBTGRZczExekVCai9iV0pJYW5zTlNG?=
 =?utf-8?B?cVFYRFJxbm9DYmlBQzBuN0NMSUpnbGc2T3RmU0VKNnVxR1FJaEFRWGpwMkpT?=
 =?utf-8?B?Q0ZlTVhDc21YL0RVSDQ3dmN0YW1OSVh5dEY1SVhHb28yQjBqNkJ4TE8xdVFN?=
 =?utf-8?B?MlpZMXhlVG9JRjNQQ1RCc05lWXU4dllkTDhNYTMvb294Y2hLNXNmNUxFZ09F?=
 =?utf-8?Q?ZBVfZSD6zIUbbOugV3fbeVj61?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0650aa1-09e9-4619-0a81-08dac3916ab4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:04:15.5610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQGt2RumuDl96cPjD53mXHq0JgssVrt0qKfzbR47Ka5ac6OLClH2RrA0qiz+GpqKEDTr17gDadybQNHAf8q4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6447
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/22 01:06, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le samedi 05 novembre 2022 à 23:19 +0800, Hsia-Jun Li a écrit :
>>>> VIDIOC_ENUM_EXT_PIX_FMT would report NV12 and NV12M, while
>>>> VIDIOC_ENUM_FMT
>>>> would just report NV12M.
>>>
>>> If NV12 and NV12M are equivalent in Ext API, I don't see why we would
>>> report both (unless I'm missing something, which is probably the case).
>>>
>>> The idea was to deprecate the M-variants one day.
>> I was thinking the way in DRM API is better, always assuming it would
>> always in a multiple planes. The only problem is we don't have a way to
>> let the allocator that allocate contiguous memory for planes when we
>> need to do that.
> 
> Its not too late to allow this to be negotiated, but I would move this out of
> the pixel format definition to stop the explosion of duplicate pixel formats,
> which is a nightmare to deal with. 
I wonder whether we need to keep the pixel formats in videodev2.h 
anymore. If we would like to use the modifiers from drm_fourcc.h, why 
don't we use their pixel formats, they should be the same values of 
non-M variant pixel formats of v4l2.

Let videodev2.h only maintain the those codecs or motion based 
compressed (pixel) formats.

If I simplify the discussion, we want to
> negotiate contiguity with the driver. The new FMT structure should have a
> CONTIGUOUS flag. So if userpace sets:
> 
>    S_FMT(NV12, CONTIGUOUS)
I wonder whether we would allow some planes being contiguous while some 
would not. For example, the graphics planes could be in a contiguous 
memory address while its compression metadata are not.
Although that is not the case of our platform. I believe it sounds like 
reasonable case for improving the performance, two meta planes could 
resident in a different memory bank.

That lead to another question which I forgot whether I mention it before.

There are four modifiers in DRM while we would only one in these patches.
 From the EGL
https://registry.khronos.org/EGL/extensions/EXT/EGL_EXT_image_dma_buf_import_modifiers.txt

The modifier for echo plane could be different. I wish it would be 
better to create a framebuffer being aware of which planes are graphics 
or metadata.

I wonder whether it would be better that convincing the DRM maintainer 
adding a non vendor flag for contiguous memory allocation here(DRM 
itself don't need it).
While whether the memory could be contiguous for these vendor pixel 
formats, it is complex vendor defined.

> 
> The driver can accepts, and return the unmodified structure, or may drop the
> CONTIGUOUS flag, which would mean its not supported. Could be the other way
> around too. As for allocation, if you have CONTIGUOUS flag set, userspace does
> not have to export or map memory for each planes, as they are the same. We
> simply need to define the offset as relative to their allocation, which I think
> is the most sensible thing.
> 
> Nicolas
> 

-- 
Hsia-Jun(Randy) Li
