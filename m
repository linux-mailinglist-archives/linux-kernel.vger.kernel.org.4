Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4806D1F6A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjCaLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjCaLrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85E5B9E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680263199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiaD/4tMRyy1IsOsTj3zp03+vuUgB/x5nAQukHMowB8=;
        b=YmYjQ1Pb39507QBo8H9Vz9dlq2HIPU4bApV1zi9EinrDDbazBK64wkeWKH04lV2pziUPr6
        tyBHYLMl85xU8CiXCF/vQZSqNtI6/07wphx5SqqHLAb4p90fOS7NdtbzOuUpqphcioE5iE
        vVeC2v0+Ztb6V0j67Jxtsd/BTMqIKSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-Ecv1FegEOO-NwsaZLNUZVw-1; Fri, 31 Mar 2023 07:46:37 -0400
X-MC-Unique: Ecv1FegEOO-NwsaZLNUZVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AEA3811E7C;
        Fri, 31 Mar 2023 11:46:37 +0000 (UTC)
Received: from localhost (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E07492B00;
        Fri, 31 Mar 2023 11:46:35 +0000 (UTC)
Date:   Fri, 31 Mar 2023 19:46:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Rename addr_to_vb_xarray() function
Message-ID: <ZCbIGDUVoirll/JW@MiWiFi-R3L-srv>
References: <20230331073727.6968-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331073727.6968-1-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/23 at 09:37am, Uladzislau Rezki (Sony) wrote:
> Short the name of the addr_to_vb_xarray() function to the
> addr_to_vb_xa(). This aligns with other internal function
> abbreviations.
> 
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 671d6d5d5b78..b8b646f8a00d 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1945,7 +1945,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>   * used as a hash table. When used as a hash a 'cpu' passed to
>   * per_cpu() is not actually a CPU but rather a hash index.
>   *
> - * A hash function is addr_to_vb_xarray() which hashes any address
> + * A hash function is addr_to_vb_xa() which hashes any address
>   * to a specific index(in a hash) it belongs to. This then uses a
>   * per_cpu() macro to access an array with generated index.
>   *
> @@ -1971,7 +1971,7 @@ static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
>   * however xarray spinlocks protect against any contention that remains.
>   */
>  static struct xarray *
> -addr_to_vb_xarray(unsigned long addr)
> +addr_to_vb_xa(unsigned long addr)
>  {
>  	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
>  
> @@ -2048,7 +2048,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
>  	bitmap_set(vb->used_map, 0, (1UL << order));
>  	INIT_LIST_HEAD(&vb->free_list);
>  
> -	xa = addr_to_vb_xarray(va->va_start);
> +	xa = addr_to_vb_xa(va->va_start);
>  	vb_idx = addr_to_vb_idx(va->va_start);
>  	err = xa_insert(xa, vb_idx, vb, gfp_mask);
>  	if (err) {
> @@ -2070,7 +2070,7 @@ static void free_vmap_block(struct vmap_block *vb)
>  	struct vmap_block *tmp;
>  	struct xarray *xa;
>  
> -	xa = addr_to_vb_xarray(vb->va->va_start);
> +	xa = addr_to_vb_xa(vb->va->va_start);
>  	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
>  	BUG_ON(tmp != vb);
>  
> @@ -2193,7 +2193,7 @@ static void vb_free(unsigned long addr, unsigned long size)
>  	order = get_order(size);
>  	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
>  
> -	xa = addr_to_vb_xarray(addr);
> +	xa = addr_to_vb_xa(addr);
>  	vb = xa_load(xa, addr_to_vb_idx(addr));
>  
>  	spin_lock(&vb->lock);
> @@ -3556,7 +3556,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
>  	 * Area is split into regions and tracked with vmap_block, read out
>  	 * each region and zero fill the hole between regions.
>  	 */
> -	xa = addr_to_vb_xarray((unsigned long) addr);
> +	xa = addr_to_vb_xa((unsigned long) addr);
>  	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
>  	if (!vb)
>  		goto finished;

Reviewed-by: Baoquan He <bhe@redhat.com>

