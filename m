Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C97438B4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjF3JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3JwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:52:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66261726;
        Fri, 30 Jun 2023 02:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkOxNA9K3e0RMtXKEZIVQaSHxgKDfYIdWdcDoJrZr42kScFsAmvdygKHRbhRvYD0JVwi6MCL4x4JWETb2jLGRNbcNIVhtH5ut7LwoW/cb1zOJyl1af/mzqn/qi4YDqTRUnruZmaQniUF+hEznkSAsRVlbSQNSGcZe9souruxlE1oiPdYV18tbB7A4JimNuHa6toP61FBFLgsc/mftNqJzXNJ/UpIfixIgploVHi7ESAuRqGsw5QGPTI4hiLBQplh9ZRs/NyAINF8krubRKpUcFoaj1Wff3XkYTadiLTvNCbrZmGeLkiygrNogN3KgXo0J7zPJBchIR78hubZUX3mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEb50R7C/FR4tGGhtnS6qhQEBLBgoH9vsOoJ0v4mUG0=;
 b=HKZs6U1+Jy5F5S9AviKGXONfUj+cuaX+TqREJSxFcqp/Q2FztMOuIjMgie56sZGFGY6nso0YPGTZg2Ayl8KPZtIqLdxRuwxRm6O7Kz98T0yiapFLd2Jj0wSXEPuBacSNucb4GgdepZmAex2uwW3INkg5jDZGX9cJoitikzrD4VswN6Kb1DGj0yHrpX1L0BrNyDs6G6jCOb6sWquIZ6VUIKWUDbo/vMvcdPqTDxLIzoqqDgPqXFLNpjGv1+qUDAxAuprxi7r6bORKIG9l+IlxC9uIfhUINkPcabsGvVFw6YGkEJlj1wpyVyk6NM6KTGor07JtURHXgxNKmOfVfKRZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEb50R7C/FR4tGGhtnS6qhQEBLBgoH9vsOoJ0v4mUG0=;
 b=HLiJ+vPO9Rg59mqR1Rmtivy+mGB6ZuC43o676QZfpecIxKI2RsW/HdFYiMHohBwEG6Rh3hfrCHL6RaRJq/OFLZJhWqq1ur7D9RRIyva8rpNvw86aVEzgxS+f9CCpLkyUObRsEusdb2lXVCqrWg1exf53e4E+GJ0cUaczf68GQOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by BLAPR03MB5649.namprd03.prod.outlook.com (2603:10b6:208:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 09:51:56 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:51:56 +0000
Message-ID: <e7444263-0ce5-1575-8cca-1e51b1cfbe9a@synaptics.com>
Date:   Fri, 30 Jun 2023 17:51:47 +0800
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
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20230622131349.144160-5-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0251.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::16) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|BLAPR03MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b48e132-8e81-4c81-9c4a-08db794fa3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qO5mTdCOUcAOJ4dGFhXg0peUkH4kRGANA4uYvpO72OA4jFXRhJnNKWcUCZDCzc25FW09rctOWDfqQf8tb0/Sq867TC1EumMEmJ21r1vdHWx6LAxmBJSf9LNuBpRuu5CRJBUxfFvIqDRN8lBVWR+e8mY41dLMvHP8z5xk8XlneWiIrXexB+iPnpOBRx2pWQdyHGapY7lQTibY7giudLnN8ZcBL0XxKL/dp0UtJfmRreeMgBnEifffWVxHEYTb1TtaE+e7rhVhFGST9jjRkj0jWGv8u6PqmFV8ffg5JZw3yykc0B+exz8n9tmqZ/ok+0OVW5Q2YfIJlo8kU0ryeVZZVOWeCa7wilCR4RZ5FoXMThB+vK/GU74P+DGRGz+MxdndhCHAvmTma1VsuPxjFaj+wZdFHFvJ0AWHk8omG9PQzV6v8hy9BAglePkobssAZqtt2gXKEQVNkSrc9JnZOxRz1P+8+X6R8QKEqG2ejNfMSl9ZxKyNGV0smlp72yM6ukYdWS7isnDn/YY5eKi+ERPMOyqnY75kah9lrCPLogd4Z2of0i+edxr1WlN7SkPN8a5XN8zt4WaeaUl1Ph0pvJd5LRIaV/cYmAW+10hzxbr1LwKO1oUq7yRaEXExEspAxyHkM0n7ssDOaaVzdGwifEB+TnJTRkSyMkG+oC/Kud5yNpLDu2Cob0aLseZofiFHe2Q9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39850400004)(366004)(451199021)(53546011)(6506007)(36756003)(66556008)(6486002)(83380400001)(478600001)(26005)(2616005)(6666004)(52116002)(6512007)(186003)(2906002)(86362001)(7416002)(316002)(5660300002)(66476007)(38350700002)(31696002)(66946007)(8676002)(6916009)(41300700001)(4326008)(38100700002)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGlKY0U4cXg0T1M5YzJJNXVOODVHbURJZ3ZsNmRxckt0RlFMd0YvQXpmRFNZ?=
 =?utf-8?B?UzFXdExMSXc2ejkyRzNqeVBxcWRjNW9kTHVVYUNLMVloOEtCeTcrRnBtaU0y?=
 =?utf-8?B?UjJFSDBETjUxNzlpQmNKblpTcHdKSUZNSkh0N2x4SWJKRElqV0U5N2VLQTNz?=
 =?utf-8?B?UmpuZDdVbnZZSmhYYnZFV1BBUk5DWHBtTFVSYXNmMlVBcUVkcWlSV2NFTXQv?=
 =?utf-8?B?WmY5L1dDY2hRREhBMEVsNmUrSXRqZjlnSEt3VGt6SjJETEZ3TlEzWWlpbVR0?=
 =?utf-8?B?cFV1N1NvcGxUNUZya2hKdmhXOWNaZWJuZWVNampURWZrQ3lYU3BRMUNFZFRr?=
 =?utf-8?B?a3pMbHJjTEpiV2oyd2RwUjJtNUtmanEzQ1FFTnB2UWliWVdyOFh0eHBjV2hM?=
 =?utf-8?B?M2ZKZUZUQXJyR2VYV3ppbHJ3SXVUN3FNYjAxZUhDeFZhYlRYa1dtVlJpNXRk?=
 =?utf-8?B?SGFSUHZLaTNZNWZhQlc1cElTS1d3eEZraUV0b3Y3M01aWGwrbzZUeU90eENr?=
 =?utf-8?B?ZWVUY1B3dS9Db1p5aDl2OUJWSkkzazhhaUovMnVrbmpDcGtsUUJlVjJBOS9S?=
 =?utf-8?B?c1lTQWIrYXlrZmdiOHlSTGJVS0tHNWw5OXVCalhsR3hIQlkrYlhvL3RhT0hV?=
 =?utf-8?B?NmREUk1NTFlieE5HcVdualR0YnVQeCt0dnJpTGRjdUV4WWkvUFlzcCtFbEtB?=
 =?utf-8?B?TlNCaVd5bDR2ZGt0QXRqNDFJSHVxTlhDTWo1L1FtZlQ1UENXODBWSlBJZ1ow?=
 =?utf-8?B?WTVkOTVpc0FyaXcyL2JhY0RHMHJDc1FsR3NndXM0d2hreGdUaXc0czZQOHFp?=
 =?utf-8?B?T1c3T2U3Z05qWmpFaXZPcmVaNnMxSnQrVGhLRkUwNjF1OXRuNzJSaFV5QUJM?=
 =?utf-8?B?Ui9ydXZqRm5qK2s5Qnhqd1EzdEJERlFCV0VWWVlQTVZxSUFxUnJQblJaSUlB?=
 =?utf-8?B?UDNwYUxDWDgrRjc2YTc2dW50QmlMUEdHaEpodlI0VnNoSWE4OUd5NUg0M1Nl?=
 =?utf-8?B?MmsxVnFMeFlKNlhxVnRrQVRySVk5TmxQdTl3NU8xTjQvUUozdUtZbjlnS1Ju?=
 =?utf-8?B?Z0Y1VGF4YmNCalAyNXRLeUtKUnBjNXcrT05ZYmRCS2RKbWQ2eVRRVWhJMEdm?=
 =?utf-8?B?RHFadjZMcEk2UWNpRWxvcTdHd1pIcytmOHdDNDRZTmJXUXZnQWJSdmtYRU1J?=
 =?utf-8?B?YldQRCtrTVlUUmNKYnY3Mk5TS2tCSGNOVVc1L0dsaEtpSHJ3UWtNaTA5cW56?=
 =?utf-8?B?MElWMitTSmkxWmhLV0VMdFdHMERXb3JXcGh5ZVJRaXF2YjJzRzR0cExteTBR?=
 =?utf-8?B?QU9BRC9DN2xlbVp2K2FZK2NNUVZEcG8zTXdKYTVyanRGWEVVVERFUmRzQmxt?=
 =?utf-8?B?eGhVbHJxOU1VZTVhek1XdzBRWUtWdEdMY1NGWWc0NW82UExpa25FcCtSaHRX?=
 =?utf-8?B?TzdzMGdLQmtKcG1MS2c1UkFTb2FpQXdZTWtUcUdrOWxUbS84VG5JY2taVlVw?=
 =?utf-8?B?SnlTNTdyTGhvT2NQT05KVzE0ZmI5bURiVmhDY3NuQ1kyTWlEVTBaa0tybWU1?=
 =?utf-8?B?UTFKVlVqOFg4RlFIcTR3T1pMVzNKazh3QVJaKy9aYWhhY2poSkFDbVgxWENn?=
 =?utf-8?B?Y0lLelZkNW1rSHl0T0ZjekI3QkVRN1g4cE1pTzRJYlZMMTN2NVZnajdiU1dZ?=
 =?utf-8?B?ODdqQTlwQTJySmhxbUhEWDIxSjB0bGlFdkprN2sycVdLR1hQNHhHWXZ0ajRa?=
 =?utf-8?B?UEQvV2d6VHppNHVaNTRCRTJoZnp4OTJQYUlPcVRiT0xHS1pqRVIxVDBqaXND?=
 =?utf-8?B?RmpnM1dLNnhtTVFoNTNsSEhFMVVyS2hpTDhFUlhJbXZjNFUxOUJmcWFEWm9O?=
 =?utf-8?B?UW1kNnNvdXpIVUgzVjd4dDk1WWRlN0tOVWdZbXFJZFdIc0kzMDdQZTVvSVpW?=
 =?utf-8?B?SXFSZWNzVUpHRWN1OVJvU0hyRjJ2a3FBVFlqUjdFd0cyOG1LM1dmVWhZTEpt?=
 =?utf-8?B?ZkJ6YkVsVjgxckllRVVtVlMzZStDNDNHMnNNUHhudjJteE43Vk9DT0FIT05D?=
 =?utf-8?B?cUVIZGpHNkcreXZmYktCakdTU0M2L1ZWd0FxQy9ESGo0dUg5NjlGcmVVWmx4?=
 =?utf-8?Q?o4hyEU2pzt0GGOo0PYbVbFeer?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b48e132-8e81-4c81-9c4a-08db794fa3ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:51:56.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ULsmvgYV14IAdasUocgpYSLNM4ydMnyY4s/2LA4xKfb8qRSP+6YsylPo4FsHmHff6vqW01cJ1EN5M9biQb7YxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5649
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/22/23 21:13, Benjamin Gaignard wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> After changing bufs arrays to a dynamic allocated array
> VB2_MAX_FRAME doesn't mean anything for videobuf2 core.

I think make it 64 which is the VB2_MAX_FRAME in Android GKI kernel is 
more reasonable.

It would be hard to iterate the whole array, it would go worse with a 
filter. Such iterate may need to go twice because you mix 
post-processing buffer and decoding buffer(with MV) in the same array.

> Remove it from the core definitions but keep it for drivers internal
> needs.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>   drivers/media/common/videobuf2/videobuf2-core.c               | 2 ++
>   drivers/media/platform/amphion/vdec.c                         | 1 +
>   .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c | 2 ++
>   drivers/media/platform/qcom/venus/hfi.h                       | 2 ++
>   drivers/media/platform/verisilicon/hantro_hw.h                | 2 ++
>   drivers/staging/media/ipu3/ipu3-v4l2.c                        | 2 ++
>   include/media/videobuf2-core.h                                | 1 -
>   include/media/videobuf2-v4l2.h                                | 4 ----
>   8 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 86e1e926fa45..899783f67580 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -31,6 +31,8 @@
>
>   #include <trace/events/vb2.h>
>
> +#define VB2_MAX_FRAME  32
> +
>   static int debug;
>   module_param(debug, int, 0644);
>
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
> index 3fa1a74a2e20..b3219f6d17fa 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -28,6 +28,7 @@
>
>   #define VDEC_MIN_BUFFER_CAP            8
>   #define VDEC_MIN_BUFFER_OUT            8
> +#define VB2_MAX_FRAME                  32
>
>   struct vdec_fs_info {
>          char name[8];
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index 6532a69f1fa8..a1e0f24bb91c 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -16,6 +16,8 @@
>   #include "../vdec_drv_if.h"
>   #include "../vdec_vpu_if.h"
>
> +#define VB2_MAX_FRAME  32
> +
>   /* reset_frame_context defined in VP9 spec */
>   #define VP9_RESET_FRAME_CONTEXT_NONE0 0
>   #define VP9_RESET_FRAME_CONTEXT_NONE1 1
> diff --git a/drivers/media/platform/qcom/venus/hfi.h b/drivers/media/platform/qcom/venus/hfi.h
> index f25d412d6553..bd5ca5a8b945 100644
> --- a/drivers/media/platform/qcom/venus/hfi.h
> +++ b/drivers/media/platform/qcom/venus/hfi.h
> @@ -10,6 +10,8 @@
>
>   #include "hfi_helper.h"
>
> +#define VB2_MAX_FRAME                          32
> +
>   #define VIDC_SESSION_TYPE_VPE                  0
>   #define VIDC_SESSION_TYPE_ENC                  1
>   #define VIDC_SESSION_TYPE_DEC                  2
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
> index e83f0c523a30..9e8faf7ba6fb 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -15,6 +15,8 @@
>   #include <media/v4l2-vp9.h>
>   #include <media/videobuf2-core.h>
>
> +#define VB2_MAX_FRAME  32
> +
>   #define DEC_8190_ALIGN_MASK    0x07U
>
>   #define MB_DIM                 16
> diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
> index e530767e80a5..6627b5c2d4d6 100644
> --- a/drivers/staging/media/ipu3/ipu3-v4l2.c
> +++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
> @@ -10,6 +10,8 @@
>   #include "ipu3.h"
>   #include "ipu3-dmamap.h"
>
> +#define VB2_MAX_FRAME  32
> +
>   /******************** v4l2_subdev_ops ********************/
>
>   #define IPU3_RUNNING_MODE_VIDEO                0
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 77921cf894ef..080b783d608d 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -20,7 +20,6 @@
>   #include <media/media-request.h>
>   #include <media/frame_vector.h>
>
> -#define VB2_MAX_FRAME  (32)
>   #define VB2_MAX_PLANES (8)
>
>   /**
> diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
> index 5a845887850b..88a7a565170e 100644
> --- a/include/media/videobuf2-v4l2.h
> +++ b/include/media/videobuf2-v4l2.h
> @@ -15,10 +15,6 @@
>   #include <linux/videodev2.h>
>   #include <media/videobuf2-core.h>
>
> -#if VB2_MAX_FRAME != VIDEO_MAX_FRAME
> -#error VB2_MAX_FRAME != VIDEO_MAX_FRAME
> -#endif
> -
>   #if VB2_MAX_PLANES != VIDEO_MAX_PLANES
>   #error VB2_MAX_PLANES != VIDEO_MAX_PLANES
>   #endif
> --
> 2.39.2
>
-- 
Hsia-Jun(Randy) Li

