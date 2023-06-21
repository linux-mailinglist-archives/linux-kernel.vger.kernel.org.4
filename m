Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAB273794C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFUCk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFUCk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:40:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E70B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=yrN0TSPCX1e/0XsrO5B8B1NSE+0Rtd/TbPfODXXanOM=; b=dM3m2eVsG8+T0uYUj/ho+JzvBS
        wPGDFpBxWsV9ZFvS1yjycat6STbD2MRcjhwymMGjR7vEmVjPkam/E2/bh6hIFMLQzrfP2vXE0cEX/
        BMp/GRcefJ2nf8OUA0mj5hJ4TBpMioNNWlPxvRkiP747oBKLwAoduWxUomelaUNDtGbKyVT1KrVwu
        XLeP+bly98Q85kXtUQtg1GgzTLIuQdobeDcRIDVR89y9FPhIxNXN9z8Kj+TrbeWqBXbZYBrnmWLgq
        5rb5XloE2TLIqV0bivRACOEr3XyyiLlS622AAscyBdJXXFOJ3DC03IbIQb4Cby3aIUXqryjeikMdh
        C8BibfpQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBnlf-00CyIW-1X;
        Wed, 21 Jun 2023 02:40:24 +0000
Message-ID: <a1dca14c-7d1e-e252-e081-8b24b9971adf@infradead.org>
Date:   Tue, 20 Jun 2023 19:40:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] soc: ti: k3-ringacc: Fixup documentation errors
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     vigneshr@ti.com, praneeth@ti.com, u-kumar1@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
References: <20230621023442.275128-1-nm@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621023442.275128-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 19:34, Nishanth Menon wrote:
> Fixup couple of misses in documentation. This squashes the following
> warnings:
> drivers/soc/ti/k3-ringacc.c:135: warning: Function parameter or member 'tdown_complete' not described in 'k3_ring_state'
> drivers/soc/ti/k3-ringacc.c:238: warning: expecting prototype for struct k3_ringacc. Prototype was for struct k3_ringacc_soc_data instead
> 
> While at this, replace "w/a" to indicate workaround to help clarify.
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes since V1:
> * Fixedup a couple of places where "w/a" is used - replaced with
>   "workaround" to indicate quirk workaround

Thanks for that. Good change.

> * Picked up Randy's Reviewed-by.
> 
> V1: https://lore.kernel.org/all/20230621022407.270842-1-nm@ti.com/
> 
>  drivers/soc/ti/k3-ringacc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 8f131368a758..999403e1b9e0 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -125,6 +125,7 @@ struct k3_ring_ops {
>   * @occ: Occupancy
>   * @windex: Write index
>   * @rindex: Read index
> + * @tdown_complete: Tear down complete state
>   */
>  struct k3_ring_state {
>  	u32 free;
> @@ -192,7 +193,7 @@ struct k3_ringacc_ops {
>   * @num_rings: number of ring in RA
>   * @rings_inuse: bitfield for ring usage tracking
>   * @rm_gp_range: general purpose rings range from tisci
> - * @dma_ring_reset_quirk: DMA reset w/a enable
> + * @dma_ring_reset_quirk: DMA reset workaround enable
>   * @num_proxies: number of RA proxies
>   * @proxy_inuse: bitfield for proxy usage tracking
>   * @rings: array of rings descriptors (struct @k3_ring)
> @@ -229,9 +230,9 @@ struct k3_ringacc {
>  };
>  
>  /**
> - * struct k3_ringacc - Rings accelerator SoC data
> + * struct k3_ringacc_soc_data - Rings accelerator SoC data
>   *
> - * @dma_ring_reset_quirk:  DMA reset w/a enable
> + * @dma_ring_reset_quirk:  DMA reset workaround enable
>   */
>  struct k3_ringacc_soc_data {
>  	unsigned dma_ring_reset_quirk:1;

-- 
~Randy
