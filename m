Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0843D698F26
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBPI6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBPI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:58:07 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7ea9::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606946E91;
        Thu, 16 Feb 2023 00:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9aOZ5rWlmTBlWgB5zXK2MTPYVm6pYW4NPy5P1tMj58c0mlgCbt+zc/eqJNqivUCXzBNC97D3dXDJ7bIb72uguamJ/RMMq7r6gDVm0rvDt1k+SLfu88aAf9Uspne0RuiaBWMjt+luHQUXmAklyGq1NnojxSqVoC+jBid7M7MZuuRkRG4if3zbS8FmiM9V6B+Xg2cLaRQwKK66ViSqayHhckYKvJ8WG7qsl+6Ox1So0szwf/i2rTHZTpzThtbQDT6w+ypz/maLoHXFgG6ZYYrgejK5qqZgIlP25abjmSfCwAk+EVkEbZ4dM4ZKOr6xP7/GZmz3wVJQdz5ArApvqsZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vAWESRYC7z9byeLEW4568Xup2R4G1JpP4IXHmUqN+w=;
 b=Lgj5xZUJjDdv3zXtGhRWdaByM/uflp1bSkDwfTmPoqKYSlSR+4uFqALStRKsfoC8/2gE4aOc27PkV3H7nfQ5L82FvSJnrZIYOiM3hnkhBd6mtWoBLFLR0cVWNnZkeyQ6mw8e29YCtKEtAHLuKf6Rnh46rVDyYGSzOO4z3vI6H9x2dEKu1ONud45QJy0Bsnh9DCdVrGipfvILi7LEjrMb6X8MkRpeekTyDe9RzlzQmXsxTkV3PhlA2vxtOFmHu4NIPOy0XWJ6IP9T1bsgio4VKApD+QXou2HbV8+QgHjlu+VoRIYhij4zLpIoIBxKfbJP0RPR2AH33davsFHOrI6dPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vAWESRYC7z9byeLEW4568Xup2R4G1JpP4IXHmUqN+w=;
 b=UQftEVVKTtjnmCvQIxIHdvJ0WIFGNPq7xzzQ1GXxPJ+hGPBzH8VGkjPgj20jQGDulvsRE+7p6HqYCf5AlwyipSaDCrKGnvlJjeTQU4y1eWE2xKsDLlaRYuOyZkooBT9eAMo56kujCw5g480GQNU9YD4+vv/AdhQNfvL3RQ/2V9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CO3PR03MB6792.namprd03.prod.outlook.com (2603:10b6:303:164::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:58:01 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::10e9:e275:9f10:67cc%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 08:58:00 +0000
Message-ID: <aa85c526-da32-d108-f85e-5dcd2cc8c846@synaptics.com>
Date:   Thu, 16 Feb 2023 16:57:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 01/12] media: v4l2: Add NV15 pixel format
Content-Language: en-GB
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
 <20230101-patch-series-v2-6-2-rc1-v2-1-fa1897efac14@collabora.com>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-1-fa1897efac14@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0082.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::23) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CO3PR03MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b28fe3-b173-4199-550e-08db0ffbe817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJAfGx5bR9oWsAsggP6hDtJwOkEB+IZBGKhoIedlhnYesRrWx2XwqWtQWkLgomBjG4a7lbaTkUnWnwhyV0kwfISo7C4Y33OgNfWmDQcSNq+jGFI2J/L2Lvf+U4kLsH+7M05jc5N2LfAGtAK6pvPO6dlU/ob8Yb5k85hQn1Z8elfHM2Q1UHEVGJAq5yDESdVYfYhT7x35lsgTb95BpkDCQYXRmlA3P1JeWS1Q8Rk7nSVVvnfsxiX8hGWRDhKFWEZx0dZutH4cEqmfX0mo6off/tzzchKNZKNAeyFnBgzUZ0f1TBG9UoN/VulBNll5XPSauPmov0oIcRxzoTMbCQLdoFBFbCONcxzU2mQcSiBWIenM7JnSLAS4gDf9nPXUdM4rCWmCKVCcUxt8sQMkDpUlF6csoXsaOr68Wa59+ugkVxlEhekmeVEEJgWx2U6MWB6YySfoiYLjjsXdyoAU/+MiLAdCMafGunbjUHqtAtl9YzZR7nUDAUJ2pP/s0rLe7VbrQ8KabnOv/uYKKubKx8xzf0KD0VR7YYGBy1cF3tvaYga/v5GlOoOKbECkXK4qizPQpLexv9vC3oVIREtmZkvzuf5uF9RDxmMJFyo5uG9Dnx+DN01vQk5TY+040jcctlii2+aWOjg/1rPDDN7e8WqmNr4NH+oPAWh/zQPlb+FkUXK8h6zsjtKI6bjyLJ3SjFncKg1UbCNdHAe5xgEj4TB6hdW9uX+Bg2JOiGn5RnUMPXdQhHrlUW/vcJ0TCmEZG3aNWXncu/9FH3stygyBwSm30Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199018)(4326008)(5660300002)(316002)(31686004)(54906003)(2906002)(41300700001)(66556008)(8676002)(6916009)(8936002)(7416002)(66476007)(66946007)(6486002)(52116002)(478600001)(36756003)(26005)(6506007)(186003)(53546011)(6512007)(2616005)(83380400001)(6666004)(31696002)(38100700002)(38350700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTdTSmU3Vy9oUm5ocFEvaS90RmdDcmtCRGMyU3k4Yk9TQ1VJS3d2OEFWeVJw?=
 =?utf-8?B?Qm5sWGhsT2VvZjRPTzJ6ZUttVDJNMEUxQnBXeUROQWJHSllIOWh1cjdKWlZS?=
 =?utf-8?B?K2dDK25NU1dxN0pha1pJQm1pVjJCcUNmdiswWFFtd1d0Rkg1d0pIcXhzazBD?=
 =?utf-8?B?RFBFQUpVMHUxQ1h4YkliTGl4cFpsQkJUdUZvQTV6ZEQ2L1ZRVVl5OVBvcW4w?=
 =?utf-8?B?M2hKYm9QOFhwU1NCSWk3dS9xUCtjdkFCVXk4TnIxU3NDZlk1cm9TZnlxTTBx?=
 =?utf-8?B?UnlBL3JFdE1ILzF6OVBQcHowZ1ZKZFJWaXZQek1VVXloSGE5ZFBjenQ4T3lp?=
 =?utf-8?B?UFFUSkwrRlNPdHZuUlV2bUhwZjBSRmt5U1Vhc2VFNGFaNHAvbnNXVE1RMUc0?=
 =?utf-8?B?T3RSeCtwQi9GbmJYWCtxUXBVd1dFdmMxWlZqVDViKzNYYmhOdklNQkI3YnhL?=
 =?utf-8?B?ZVNWdlNUOTMzc1V0UTFiZ1FrSFFlQXBXWm9PTE9uTGZRV1BlY3RjSXJERjVX?=
 =?utf-8?B?bytrK2NkZUpQaGpxRkNPQmZYZjJzcFQ0b0IralIybmZYT3BON2xXazE4NFJl?=
 =?utf-8?B?ZHUrb1FpRHBUVFFTb05rZGt6akN0VlllS2JTMUQySmw3c1l5QWVObS9vY1BJ?=
 =?utf-8?B?UFZkcFNGaHlJMVV4RUMwZXJSVW02dzc1bWJpaURaWk13Rm1uWktqNnRRcUpM?=
 =?utf-8?B?M0drM1FEQ3llQ0tZREhpMVJnUUlEeUJ1bXZMa1ZkSDJ2eGd0Y2xqR0NUdGI3?=
 =?utf-8?B?TFRXUk9Yd3BxSjR0eVUzVzljT2djOHJJeXM1RnFJZmxrRnNabkdKaGJmR3Vy?=
 =?utf-8?B?V2hibnFtTkFWTEZVYnhjUHBuRlB4RWhvUnhiZGFlQ2dBaWttMG5UUWVvNVQ5?=
 =?utf-8?B?TnBJcGdSR0Z6Q0oveFFIUkp2S3Q2YkErbjQ4LzdmWlVpYkdHam4zMjV6dzY4?=
 =?utf-8?B?anNjZFJYTnRtejBVdEtCTHpjZjBrdFBGN1k1dnl5eXAvUWwvRnJjRnMyREM3?=
 =?utf-8?B?MDY0enJnUmc5SXlES0ZkTUpKTXNJcS9Ic1A4Ynd2MmlxczFqUjJSVHFoaFZ1?=
 =?utf-8?B?RGtJWnBCV2tXeVkwa3R2T2FoOWVKT282ZGxVTytqVStnRmN1dERxNUl0cWUw?=
 =?utf-8?B?UDQ3elhNU3VDdzhMVU52eENMdE1FTmhVdmUvc0o5UkNDcDl4YzRlTjVYaWZv?=
 =?utf-8?B?OHVNZWZBT1BFVHk1TWdvWUJpVkhYZkgyRU0rQWFYeEgzcGkxTkpLdzY0azFO?=
 =?utf-8?B?SDNPUVNpU2tyL3g5VG9PTFFFelByVkFaZ1M0K242dlVRWGYvdWdET3NQZXYx?=
 =?utf-8?B?VDVaSy81NlhFdzNCMTNNTWtTdlk1WnRtUkNMTXhzRVkrSnhqemdzbEJXWTVL?=
 =?utf-8?B?T0RibHkxV0ZnV21hL2R4UFRrN01uaXJQc1EyYXRQVDN1aVpRcnVhYitaWUxx?=
 =?utf-8?B?bG9GRnJ6TC9nMXk4REVzdjJRU3NsY0MzYmZpc2lDYWxaaUxHazJoOGlLcHha?=
 =?utf-8?B?ZG9NOHpidGU0NEQwN2Q2YVNER25KeHJrS0xLTGhYdjNQVVdWQ2g0djRwSXpH?=
 =?utf-8?B?YUNIV0VyTW9QNCtlVzRDUVB6TXZFdmdNbTBXSTBWK25HOWFQQ0FnVWErZ0lW?=
 =?utf-8?B?NlZRRDQ0M3NzbEorakQxZnNTUE92aHFhM2dvUVdia2ZaR0lKbm9OS2VRWWFu?=
 =?utf-8?B?V0dqbnN1WlQzQTI3SFloNHAydFlJQk8wUEIzeTlZSVVMazNzL2U2dCtyTVhz?=
 =?utf-8?B?eHhZOFI0aEt2NXR6d05kN3VicHUzMm9ueHcvUVVvR20vVVZybjNrWjJ3WGF0?=
 =?utf-8?B?ZHhrTlpOTzJYMStlYWU2VzNPREtGMXQ3ZFVOU2xma1FWOENDWDBQcGtsVkdT?=
 =?utf-8?B?MFpneStSNXF2WTdpdG5vNnFucnZsYmlxemRNbi9kcVk1R2EyOW1Vb0RHRVVh?=
 =?utf-8?B?ek01WXdPanUzSXFobmo1Z3I3RGxFRDlhWHNCZklOVElsSTFCa3VzSWtKMUV5?=
 =?utf-8?B?N1N5UXZ1d2J0ZVIwaVk0WFd6TUc4SmNnV21adTZFdlhzYzNYOEFtbkdyZW52?=
 =?utf-8?B?SkVqSnFXdWJSN3U1R1hLTnhSM2JvRjRxUG5MY0ZrVy9wa21TaUpoSWllMnlk?=
 =?utf-8?Q?nBMNjKeKBoOlpkE65/pEl1X3d?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b28fe3-b173-4199-550e-08db0ffbe817
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:58:00.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0+Lzn+FusPsU9G7fR+8C8gmD8kUcAh7lqvsH2kMU/PQLbP2Gbduk8rFs9DxqFigjKpFmss0t9uAKdvirEixgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR03MB6792
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/12/23 20:56, Sebastian Fricke wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> From: Jonas Karlman <jonas@kwiboo.se>
> 
> Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit buffers.
> 
I think this pixel format in the Rockchip platform supports multiple 
planes buffers. It is all right not to add more variant until the ext 
pixel format and buffer APIs are merged.

I just want to mention the need of this.
> NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 but has no
> padding between components. Instead, luminance and chrominance samples are grouped
> into 4s so that each group is packed into an integer number of bytes:
> 
> YYYY = UVUV = 4 * 10 bits = 40 bits = 5 bytes
> 
> The '15' suffix refers to the optimum effective bits per pixel
> which is achieved when the total number of luminance samples is a multiple
> of 8 for NV15.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>   .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  | 75 ++++++++++++++++++++++
>   drivers/media/v4l2-core/v4l2-common.c              |  2 +
>   drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
>   include/uapi/linux/videodev2.h                     |  1 +
>   4 files changed, 79 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index f1d5bb7b806d..7d8d228f8063 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -79,6 +79,13 @@ All components are stored with the same number of bits per component.
>         - Cr, Cb
>         - Yes
>         - Linear
> +    * - V4L2_PIX_FMT_NV15
> +      - 'NV15'
> +      - 15
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - Linear
>       * - V4L2_PIX_FMT_NV12M
>         - 'NM12'
>         - 8
> @@ -183,6 +190,7 @@ horizontally.
> 
>   .. _V4L2-PIX-FMT-NV12:
>   .. _V4L2-PIX-FMT-NV21:
> +.. _V4L2-PIX-FMT-NV15:
>   .. _V4L2-PIX-FMT-NV12M:
>   .. _V4L2-PIX-FMT-NV21M:
>   .. _V4L2-PIX-FMT-P010:
> @@ -586,6 +594,73 @@ Data in the 10 high bits, zeros in the 6 low bits, arranged in little endian ord
>         - Cb\ :sub:`11`
>         - Cr\ :sub:`11`
> 
> +.. _V4L2_PIX_FMT_NV15:
> +
> +NV15
> +----
> +
> +Similar to P010, a semi-planar 10-bit Y/CbCr format, but all components are
> +packed without any padding between each other. As a side-effect, each group of
> +4 components are stored over 5 bytes (YYYY or UVUV = 4 * 10 bits = 40 bits = 5
> +bytes).
> +
> +.. flat-table:: Sample 4x4 NV15 Image
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start + 0:
> +      - Y'\ :sub:`00`
> +      - Y'\ :sub:`01`
> +      - Y'\ :sub:`02`
> +      - Y'\ :sub:`03`
> +    * - start + 8:
> +      - Y'\ :sub:`04`
> +      - Y'\ :sub:`10`
> +      - Y'\ :sub:`11`
> +      - Y'\ :sub:`12`
> +    * - start + 16:
> +      - Y'\ :sub:`13`
> +      - Y'\ :sub:`14`
> +      - Y'\ :sub:`20`
> +      - Y'\ :sub:`21`
> +    * - start + 24:
> +      - Y'\ :sub:`22`
> +      - Y'\ :sub:`23`
> +      - Y'\ :sub:`24`
> +      - Y'\ :sub:`30`
> +    * - start + 32:
> +      - Y'\ :sub:`31`
> +      - Y'\ :sub:`32`
> +      - Y'\ :sub:`33`
> +      - Y'\ :sub:`34`
> +
> +    * - start + 0:
> +      - Cb\ :sub:`00`
> +      - Cr\ :sub:`00`
> +      - Cb\ :sub:`01`
> +      - Cr\ :sub:`01`
> +    * - start + 8:
> +      - Cb\ :sub:`02`
> +      - Cr\ :sub:`02`
> +      - Cb\ :sub:`03`
> +      - Cr\ :sub:`03`
> +    * - start + 16:
> +      - Cb\ :sub:`04`
> +      - Cr\ :sub:`04`
> +      - Cb\ :sub:`10`
> +      - Cr\ :sub:`10`
> +    * - start + 24:
> +      - Cb\ :sub:`11`
> +      - Cr\ :sub:`11`
> +      - Cb\ :sub:`12`
> +      - Cr\ :sub:`12`
> +    * - start + 32:
> +      - Cb\ :sub:`13`
> +      - Cr\ :sub:`13`
> +      - Cb\ :sub:`14`
> +      - Cr\ :sub:`14`
> +
> +.. raw:: latex
> 
>   Fully Planar YUV Formats
>   ========================
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
> index 40f56e044640..be23e319fb3a 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
>                  /* YUV planar formats */
>                  { .format = V4L2_PIX_FMT_NV12,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
>                  { .format = V4L2_PIX_FMT_NV21,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
> +               { .format = V4L2_PIX_FMT_NV15,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 5, 5, 0, 0 }, .hdiv = 2, .vdiv = 2,
> +                 .block_w = { 4, 2, 0, 0 }, .block_h = { 1, 1, 0, 0 } },
>                  { .format = V4L2_PIX_FMT_NV16,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>                  { .format = V4L2_PIX_FMT_NV61,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 1 },
>                  { .format = V4L2_PIX_FMT_NV24,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 1, .vdiv = 1 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> index 8e0a0ff62a70..1c80ad78ef00 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>          case V4L2_PIX_FMT_M420:         descr = "YUV 4:2:0 (M420)"; break;
>          case V4L2_PIX_FMT_NV12:         descr = "Y/UV 4:2:0"; break;
>          case V4L2_PIX_FMT_NV21:         descr = "Y/VU 4:2:0"; break;
> +       case V4L2_PIX_FMT_NV15:         descr = "10-bit Y/UV 4:2:0 (Packed)"; break;
>          case V4L2_PIX_FMT_NV16:         descr = "Y/UV 4:2:2"; break;
>          case V4L2_PIX_FMT_NV61:         descr = "Y/VU 4:2:2"; break;
>          case V4L2_PIX_FMT_NV24:         descr = "Y/UV 4:4:4"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 1befd181a4cc..e9731286dc77 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -621,6 +621,7 @@ struct v4l2_pix_format {
>   /* two planes -- one Y, one Cr + Cb interleaved  */
>   #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
>   #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
> +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/CbCr 4:2:0 10-bit packed */
>   #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
>   #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
>   #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
> 
> --
> 2.25.1

-- 
Hsia-Jun(Randy) Li
