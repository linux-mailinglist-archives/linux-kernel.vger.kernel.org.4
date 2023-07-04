Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B1746F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjGDKvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjGDKvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:51:05 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8070E6E;
        Tue,  4 Jul 2023 03:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQNsABBVR7Bwr/QX775B3GLwsaVoPqusI1RLKCna7UsjXyuTcWz9f7feol+S7QybDo9PagkaPUyJwt8mp5GbPwl+uwxwYlr+Fq8cyOdUfq2fqC3MQWSAtDwn9sQWAbKO/gJ05Boc/KvPdVyMP4fKqgSm4K2dBHFRPssxt1suve5IDN94MfMQNQExMoYThs0svnEwlJcrd3pj/k/nkaH0zebF4eHYEoE8csMaTs+uFW46yvEbXEffj43zRa5ecT/2ZIua2gPfVpQPn+YRBbPcyGn+G2Wzw4nimkpeGHqP1RaOHTHPruAw95z76qrd7uyYJbODy6b91V3jWJoTbrqfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLFHw4G+cQr/Od1ZX54Z9/AbU1rJtko4JDnFeaOfZGI=;
 b=VYNGKLNdrPrYLyh/p8E7Z84rGt5Dh4Nx8+Upd3wZfRfoFoI+E7ud/Pm/Sa6ABwq3gS8uYBVCa6JdkC+LijGC/3KSuaoibG3Oshs3tE5z3/of//6pV/fWZI4NmWZeWOp7w+YkQyoiOTP/O9a8s/seDtnsmJ+ciIZEal8+XGj2eQgsK/e9CzP4RbHUMLueXY8IiLUP6yCtMo3rIwop3NsHFU2gi2FxsGKsGXcfb9Ku1YpsdKmGmmrrVcVwm+eyvPy9zR4coYtOw9eMUZNOAPkhrZOxhXg6Rado9FqLiV6CUj8y8XcNbQwm/wvJeWvd+BBQlBRwj6Epp1eKbiaiXi1NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFHw4G+cQr/Od1ZX54Z9/AbU1rJtko4JDnFeaOfZGI=;
 b=HszUVTDf3i8me3fEtJpKa1niCdvYP8CLKXPMdMzbtXsDXmbgDcLW+pj0z2lQxNzHP8CMntaagllAZn+/hUfML8wPLeaqlIdSY5WugSAS6kbKfNqbPipeHNJwxhjNq4Q0648DkK2uJrf967s97VZs9QNuE0hcVQH1EM0MMqtBW+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by DM4PR03MB6078.namprd03.prod.outlook.com (2603:10b6:5:391::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 10:50:58 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::6882:b9c1:2b2d:998d%5]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 10:50:58 +0000
Message-ID: <08fa86bf-b4bf-408a-89f6-a0ebc222b253@synaptics.com>
Date:   Tue, 4 Jul 2023 18:50:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 8/8] videobuf2: handle non-contiguous DMA allocations
Content-Language: en-GB
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210302004624.31294-1-senozhatsky@chromium.org>
 <20210302004624.31294-9-senozhatsky@chromium.org>
From:   Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <20210302004624.31294-9-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0032.namprd07.prod.outlook.com
 (2603:10b6:510:e::7) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|DM4PR03MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4ee687-52fd-4ba3-6c59-08db7c7c8cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKOHIe+I4pSc9kLcn2CgyItB2qsPGgFSeUunrJTOuZEgYev4NZe70RpTR57sPtc65bpjrKabmOdjdkXl32pfdNJd/fs1ZqqoR1Tiw7Dzdwc16XL68mwCHH/PZ4d6H7vzuOg74LVOhQctBxkYEQ56fGwbxeODvjKuHRtBjhVrFjltFe3nWjW1H2hQE2a4YWmB0zaeH7VxGxGZtSh2IdyQn1GIH5Czqsq75nZv9bn09kOaZohJcZ1ab0RWh+j6Guezv+BULKCayuavQI9lBNxCJqIzLuUHD/gNH6jKoJh9WIDqsCseNln4VzDrXKo9D/wrg5abNI5Wxrdi6e17KrPxenvTKBp2Rce+1PeGFObO5l0zRh6sCU3Wb16Jf3JKrP8kRmVuomVluL+fW3BfGsddDqVwfPTyoZ5DcFNNz4ah6vRE9dIW17X2QpTvhLZ8L2oMZgKm5r+z04GaiuG8Dhs4gL0YEyfyj5u0EoJ2RUoZhBsE71QOyvfhZ938MXbZYYR7ryxelNqcGXwHiCgNbfaOTw4DnevjBwUiMDmlTKP+irvLIfwLg+M7Dg/TxhaD43m0N77P73dBV90HX/ToUgb5Wcnq3D1ek4H/uNkfPHlB5WYJTO4Ru0KCTDQ9cniG+BIXdimEDApJDwIqzlfysKoRdQMyEkVtak3B4UHEpKkzGrwDpiN8U9ZtZsMNvuf4VpYw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(86362001)(31696002)(31686004)(2616005)(6666004)(478600001)(6506007)(186003)(26005)(6512007)(53546011)(38100700002)(6486002)(52116002)(66556008)(316002)(66946007)(4326008)(38350700002)(66476007)(6916009)(83380400001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUF1NnVZSWMrR25VdFFpSzN2dWo5N1NCT0s2clNPeFdNNThpTnhGV0xMUVZ4?=
 =?utf-8?B?WVoyL1hQNXJDU1hZTzVqcktTeUdTTEViSVBPUlRxNVg4ek5sZjc5R1p1cEtG?=
 =?utf-8?B?SStTelZxeTJKeHRQUi9RYU1ldjhnZWlabkh4eTVnVkVkekthQWtCRTBmMTJ0?=
 =?utf-8?B?aHIyVnQzeG52YmFlZ3hkL3VrVkJiQTl2ZXQyTnRZVm9nbk02UGllY0tpODZF?=
 =?utf-8?B?dlNNdmpveHh6MEhFcS9BOFFNd2RIQ2crODRBV2I4MEpLcEw4OGhsOEl4TUtk?=
 =?utf-8?B?aGlvZEd5VElmR211OTYwYmJFbjAyWDJXdEticU1JSFQzS3JDSmZOdS9rQXRs?=
 =?utf-8?B?R3Jnd1ZuMmhjTXMrSFJ4aU90eHE1MVV1MGVtUnZQT2Z0ZTY5MkNzVEdYQm5F?=
 =?utf-8?B?Y05zN25GQUJ5WE16TUVwZjJsN2FHdDlwY2lYYW1pbEJLdUpKaHJ4VlNkaVAy?=
 =?utf-8?B?SitSdU5PWVhrNnVYMTdlWDB2L3lHMUI2MGRqUXZZMEZNSjg3a1ZwWHh1Q0Z3?=
 =?utf-8?B?WFNhMHNYeXh2Q1NrdXZnQXE5bUVXUGlGV21sNmc3eElZeTZhOFA5MVFGcHg2?=
 =?utf-8?B?K0VaYXFqR1NGbkpwQ1RybkFOS2JwdXRCQ29kZVJvSXhOelVaaTZiSE9UZyt4?=
 =?utf-8?B?NlI4SnVJVURZNStqRUZRdEJUa3VKVmppd0pDRE56Y3lmdk43djRpSldNUGVw?=
 =?utf-8?B?YWZSYWphbk1LbXJDNGFVbzRhRmhKZFgvUlQ4N3dtSUVuTUdYR09HSWsrcDlM?=
 =?utf-8?B?dk1aV1dRZ3JZZTVkR2oxNWlHZXVTd3Zqb2ZaeUkycWdRMmFKMVp5Z1ZiQlpZ?=
 =?utf-8?B?OHhUbmlOMG5vVHdYK1hKSFdzWXVFbVlvRWQ4ZkEzS2F4ZDRCU3hXMTFkbWJ4?=
 =?utf-8?B?azd1M0RETEErMDBodnZ5b1J4di9acVZoMG0ycE55MTNidmMvbEhVR21UYWhm?=
 =?utf-8?B?Yng3K3pEMkRKYWJVSmhSdytEOFJrY2pZR3VzYmJjZHhEWmZmTGladU5lU1pC?=
 =?utf-8?B?ZWxiNi8ycWFSUEY0a0RFVUVCZHpWR2lCbHZkME1OczVMUVowTTFTcDkxTWkr?=
 =?utf-8?B?NnJRbnZNT2JOK2tIYXhFN0ZNdk1yNVR5ZWw3VkxnWmxmN1BwU21rWG1kYXI3?=
 =?utf-8?B?S0JUSU5GVzk3K2NKQzdQeDF6VzdwMXpvR2tESmlVbHFsT1NoUGNmLzFvSlRQ?=
 =?utf-8?B?RXhFSFExdzdib1NKNDNRWWtJMG1NN2djRlZ3UzRoMEVWZVZiOVVGQ3J0QWk1?=
 =?utf-8?B?QUZvcDZJOGVKb3RoUDNDNXYrYTJWRjFTVmNpb3FNR21CUHJJVTVxUVZWemNB?=
 =?utf-8?B?RGJJaDNqdmd2Mk1BaGpmQ3VEZituUmRFdGxseHlqeERMN1djQktGS0MydTZ3?=
 =?utf-8?B?L0FOWGtCWFRYSGVqODk4OUpJM3BtVEhxSHE4N3pPR281OTlOVEJXN0dQSDVo?=
 =?utf-8?B?eHVmUEg1Z29kQlROQWZPeXZYaTBGWTNXd0hQSzJDQW1yUEh3ZjFvRW02U25W?=
 =?utf-8?B?eHNUTFdjaVhjZGFqN1ExcWEwN3dXNWxZTitpeFNPSTlYRHhFcWdOeW83OFd4?=
 =?utf-8?B?akRncG5IczQ4eTJjT2N6TDlMNjFYOFhKckZORW0xdE1FalBaT0NjKzF2YWp0?=
 =?utf-8?B?Zk96VHh6dEFGdXdERWh5cVpOUDMvNXgxRXQ4Y1lUWkJ6SlNQR2p3cy9zdk5r?=
 =?utf-8?B?VDRFWjBnaDY4U20weGN4U3A3bCtqVm5TV1RrRlRIZ3lhOTVzYjhGamt1RUZD?=
 =?utf-8?B?U2tUVlNFRDJqVmJSaUx6Nk5SQTdrUm16TWZuT2I2UjAxWlE1djBxL0lVN0lQ?=
 =?utf-8?B?enVhRDBnblhQQ0w0Smh1eGE5S1BhaVpMN1NQMC9kNlRpUThrYzdqbHZabStv?=
 =?utf-8?B?VUw2aFZCN0N6MG4zNFRPOWhUR2JHSzIvemFwWDE1ZlJLV0RHRHFhUTB4QzND?=
 =?utf-8?B?dHFYeGdMODRFMnRmbjRTanpob3FhREo5MG5vTU9OV2V1YzZrS1Vxcm85ODIv?=
 =?utf-8?B?dzJMZ2MyMWR3SGZPMXN3bUU0TlcxV0xmR2crWElyYW0vVXB4NWw1UCtNbEc0?=
 =?utf-8?B?SXRtL25jdXdWMHR5Vko5MFZTcUNHS1pKSWZtOTNiUVpIbS9wWGJ1VVhkTkxK?=
 =?utf-8?Q?aAqYf4elnWNw7b4nmDsSrFSo7?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4ee687-52fd-4ba3-6c59-08db7c7c8cd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 10:50:58.5527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nDhP7KHqYBLo9v0eRQkQ4e5Sv+XCSpOYk37GmFQNh4RiGwfxCpZL0NhCnDUTL6X+HL5h94pCji3126A7JHB1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6078
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sergey

I known this patch have been merged for a long time. I am thinking 
whether we need this flag in the new v4l2_ext_buffer.

On 3/2/21 08:46, Sergey Senozhatsky wrote:
> This adds support for new noncontiguous DMA API, which
> requires allocators to have two execution branches: one
> for the current API, and one for the new one.

There is no way we could allocate a coherent buffer in the platform 
except the x86.

Should we make this flag a platform compiling time fixed value?

And I didn't see Gstreamer nor FFmpeg uses it, it is obvious that they 
are running in many(almost all) embedded devices which are ARM.

>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> [hch: untested conversion to the ne API]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   .../common/videobuf2/videobuf2-dma-contig.c   | 141 +++++++++++++++---
>   1 file changed, 117 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index 1e218bc440c6..d6a9f7b682f3 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -17,6 +17,7 @@
>   #include <linux/sched.h>
>   #include <linux/slab.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/highmem.h>
>   
>   #include <media/videobuf2-v4l2.h>
>   #include <media/videobuf2-dma-contig.h>
> @@ -42,8 +43,14 @@ struct vb2_dc_buf {
>   	struct dma_buf_attachment	*db_attach;
>   
>   	struct vb2_buffer		*vb;
> +	unsigned int			non_coherent_mem:1;
>   };
>   
> +static bool vb2_dc_is_coherent(struct vb2_dc_buf *buf)
> +{
> +	return !buf->non_coherent_mem;
> +}
> +
>   /*********************************************/
>   /*        scatterlist table functions        */
>   /*********************************************/
> @@ -78,12 +85,21 @@ static void *vb2_dc_cookie(struct vb2_buffer *vb, void *buf_priv)
>   static void *vb2_dc_vaddr(struct vb2_buffer *vb, void *buf_priv)
>   {
>   	struct vb2_dc_buf *buf = buf_priv;
> -	struct dma_buf_map map;
> -	int ret;
>   
> -	if (!buf->vaddr && buf->db_attach) {
> -		ret = dma_buf_vmap(buf->db_attach->dmabuf, &map);
> -		buf->vaddr = ret ? NULL : map.vaddr;
> +	if (buf->vaddr)
> +		return buf->vaddr;
> +
> +	if (buf->db_attach) {
> +		struct dma_buf_map map;
> +
> +		if (!dma_buf_vmap(buf->db_attach->dmabuf, &map))
> +			buf->vaddr = map.vaddr;
> +	}
> +
> +	if (!vb2_dc_is_coherent(buf)) {
> +		buf->vaddr = dma_vmap_noncontiguous(buf->dev,
> +						    buf->size,
> +						    buf->dma_sgt);
>   	}
>   
>   	return buf->vaddr;
> @@ -101,13 +117,26 @@ static void vb2_dc_prepare(void *buf_priv)
>   	struct vb2_dc_buf *buf = buf_priv;
>   	struct sg_table *sgt = buf->dma_sgt;
>   
> +	/* This takes care of DMABUF and user-enforced cache sync hint */
>   	if (buf->vb->skip_cache_sync_on_prepare)
>   		return;
>   
> +	/*
> +	 * Coherent MMAP buffers do not need to be synced, unlike coherent
> +	 * USERPTR and non-coherent MMAP buffers.
> +	 */
> +	if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
> +		return;
> +
>   	if (!sgt)
>   		return;
>   
> +	/* For both USERPTR and non-coherent MMAP */
>   	dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
> +
> +	/* Non-coherrent MMAP only */
> +	if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> +		flush_kernel_vmap_range(buf->vaddr, buf->size);
>   }
>   
>   static void vb2_dc_finish(void *buf_priv)
> @@ -115,19 +144,46 @@ static void vb2_dc_finish(void *buf_priv)
>   	struct vb2_dc_buf *buf = buf_priv;
>   	struct sg_table *sgt = buf->dma_sgt;
>   
> +	/* This takes care of DMABUF and user-enforced cache sync hint */
>   	if (buf->vb->skip_cache_sync_on_finish)
>   		return;
>   
> +	/*
> +	 * Coherent MMAP buffers do not need to be synced, unlike coherent
> +	 * USERPTR and non-coherent MMAP buffers.
> +	 */
> +	if (buf->vb->memory == V4L2_MEMORY_MMAP && vb2_dc_is_coherent(buf))
> +		return;
> +
>   	if (!sgt)
>   		return;
>   
> +	/* For both USERPTR and non-coherent MMAP */
>   	dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
> +
> +	/* Non-coherrent MMAP only */
> +	if (!vb2_dc_is_coherent(buf) && buf->vaddr)
> +		invalidate_kernel_vmap_range(buf->vaddr, buf->size);
>   }
>   
>   /*********************************************/
>   /*        callbacks for MMAP buffers         */
>   /*********************************************/
>   
> +static void __vb2_dc_put(struct vb2_dc_buf *buf)
> +{
> +	if (vb2_dc_is_coherent(buf)) {
> +		dma_free_attrs(buf->dev, buf->size, buf->cookie,
> +			       buf->dma_addr, buf->attrs);
> +		return;
> +	}
> +
> +	if (buf->vaddr)
> +		dma_vunmap_noncontiguous(buf->dev, buf->vaddr);
> +	dma_free_noncontiguous(buf->dev, buf->size,
> +			       buf->dma_sgt, buf->dma_addr);
> +}
> +
>   static void vb2_dc_put(void *buf_priv)
>   {
>   	struct vb2_dc_buf *buf = buf_priv;
> @@ -139,17 +195,47 @@ static void vb2_dc_put(void *buf_priv)
>   		sg_free_table(buf->sgt_base);
>   		kfree(buf->sgt_base);
>   	}
> -	dma_free_attrs(buf->dev, buf->size, buf->cookie, buf->dma_addr,
> -		       buf->attrs);
> +	__vb2_dc_put(buf);
>   	put_device(buf->dev);
>   	kfree(buf);
>   }
>   
> +static int vb2_dc_alloc_coherent(struct vb2_dc_buf *buf)
> +{
> +	struct vb2_queue *q = buf->vb->vb2_queue;
> +
> +	buf->cookie = dma_alloc_attrs(buf->dev,
> +				      buf->size,
> +				      &buf->dma_addr,
> +				      GFP_KERNEL | q->gfp_flags,
> +				      buf->attrs);
> +	if (!buf->cookie)
> +		return -ENOMEM;
> +	if ((q->dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
> +		buf->vaddr = buf->cookie;
> +	return 0;
> +}
> +
> +static int vb2_dc_alloc_non_coherent(struct vb2_dc_buf *buf)
> +{
> +	struct vb2_queue *q = buf->vb->vb2_queue;
> +
> +	buf->dma_sgt = dma_alloc_noncontiguous(buf->dev,
> +					       buf->size,
> +					       buf->dma_dir,
> +					       GFP_KERNEL | q->gfp_flags,
> +					       buf->attrs);
> +	if (!buf->dma_sgt)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
>   static void *vb2_dc_alloc(struct vb2_buffer *vb,
>   			  struct device *dev,
>   			  unsigned long size)
>   {
>   	struct vb2_dc_buf *buf;
> +	int ret;
>   
>   	if (WARN_ON(!dev))
>   		return ERR_PTR(-EINVAL);
> @@ -159,27 +245,28 @@ static void *vb2_dc_alloc(struct vb2_buffer *vb,
>   		return ERR_PTR(-ENOMEM);
>   
>   	buf->attrs = vb->vb2_queue->dma_attrs;
> -	buf->cookie = dma_alloc_attrs(dev, size, &buf->dma_addr,
> -				      GFP_KERNEL | vb->vb2_queue->gfp_flags,
> -				      buf->attrs);
> -	if (!buf->cookie) {
> -		dev_err(dev, "dma_alloc_coherent of size %ld failed\n", size);
> -		kfree(buf);
> -		return ERR_PTR(-ENOMEM);
> -	}
> -
> -	if ((buf->attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
> -		buf->vaddr = buf->cookie;
> +	buf->dma_dir = vb->vb2_queue->dma_dir;
> +	buf->vb = vb;
> +	buf->non_coherent_mem = vb->vb2_queue->non_coherent_mem;
>   
> +	buf->size = size;
>   	/* Prevent the device from being released while the buffer is used */
>   	buf->dev = get_device(dev);
> -	buf->size = size;
> -	buf->dma_dir = vb->vb2_queue->dma_dir;
> +
> +	if (vb2_dc_is_coherent(buf))
> +		ret = vb2_dc_alloc_coherent(buf);
> +	else
> +		ret = vb2_dc_alloc_non_coherent(buf);
> +
> +	if (ret) {
> +		dev_err(dev, "dma alloc of size %ld failed\n", size);
> +		kfree(buf);
> +		return ERR_PTR(-ENOMEM);
> +	}
>   
>   	buf->handler.refcount = &buf->refcount;
>   	buf->handler.put = vb2_dc_put;
>   	buf->handler.arg = buf;
> -	buf->vb = vb;
>   
>   	refcount_set(&buf->refcount, 1);
>   
> @@ -196,9 +283,12 @@ static int vb2_dc_mmap(void *buf_priv, struct vm_area_struct *vma)
>   		return -EINVAL;
>   	}
>   
> -	ret = dma_mmap_attrs(buf->dev, vma, buf->cookie,
> -		buf->dma_addr, buf->size, buf->attrs);
> -
> +	if (vb2_dc_is_coherent(buf))
> +		ret = dma_mmap_attrs(buf->dev, vma, buf->cookie, buf->dma_addr,
> +				     buf->size, buf->attrs);
> +	else
> +		ret = dma_mmap_noncontiguous(buf->dev, vma, buf->size,
> +					     buf->dma_sgt);
>   	if (ret) {
>   		pr_err("Remapping memory failed, error: %d\n", ret);
>   		return ret;
> @@ -390,6 +480,9 @@ static struct sg_table *vb2_dc_get_base_sgt(struct vb2_dc_buf *buf)
>   	int ret;
>   	struct sg_table *sgt;
>   
> +	if (!vb2_dc_is_coherent(buf))
> +		return buf->dma_sgt;
> +
>   	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
>   	if (!sgt) {
>   		dev_err(buf->dev, "failed to alloc sg table\n");

-- 
Hsia-Jun(Randy) Li

