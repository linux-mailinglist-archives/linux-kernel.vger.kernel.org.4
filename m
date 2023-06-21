Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4796C73791D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFUC1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFUC1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:27:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6DB4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+emXSmaqTAHOu87SvCHsMDPb/3PkMxdWNPnv7ceznWs=; b=MwZ9TkB+IuUjC5T0m0DvSwij7l
        RqmOPyijvXGsAhsK9PIUxup56B7RynfeGaEfvME+lTc4BT+oT/HdEN9VhU8NaIhxmfhrSVTn1Fjfe
        8Hr8wIlrL1Xx0iQaq8moAGDmAzaqVvmFIKstWO758azjGWR0wBrXHrprhzxrFLG9roP4qQSg42IWp
        Y5hnvprSaH62cfMCSuOsf1/bXveHAoSm27SBUw4TawHe/1Nmq5YJNqJKq9PwkAgDLWVqF6VQ3xHId
        j/GS2KxNhzr8DHo0aMZnvzCiurCSvYKpRefrGqLdnGvyvWS2o03/k2C0COKrzr3HnyfW49voCk9P2
        8wa7FjoA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBnZH-00CwFW-1R;
        Wed, 21 Jun 2023 02:27:35 +0000
Message-ID: <88587e16-8517-bd02-1ce5-7437ce288cb6@infradead.org>
Date:   Tue, 20 Jun 2023 19:27:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] soc: ti: k3-ringacc: Fixup documentation errors
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Cc:     vigneshr@ti.com, praneeth@ti.com, u-kumar1@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
References: <20230621022407.270842-1-nm@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621022407.270842-1-nm@ti.com>
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



On 6/20/23 19:24, Nishanth Menon wrote:
> Fixup couple of misses in documentation. This squashes the following
> warnings:
> drivers/soc/ti/k3-ringacc.c:135: warning: Function parameter or member 'tdown_complete' not described in 'k3_ring_state'
> drivers/soc/ti/k3-ringacc.c:238: warning: expecting prototype for struct k3_ringacc. Prototype was for struct k3_ringacc_soc_data instead
> 
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

(more below)

> ---
>  drivers/soc/ti/k3-ringacc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 8f131368a758..548b9f605d86 100644
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
> @@ -229,7 +230,7 @@ struct k3_ringacc {
>  };
>  
>  /**
> - * struct k3_ringacc - Rings accelerator SoC data
> + * struct k3_ringacc_soc_data - Rings accelerator SoC data
>   *
>   * @dma_ring_reset_quirk:  DMA reset w/a enable

What does "w/a" mean?

>   */

Thanks.
-- 
~Randy
