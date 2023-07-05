Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA37748289
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGEKvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjGEKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D5CE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AA0A614EA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C02C433C8;
        Wed,  5 Jul 2023 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688554310;
        bh=j1PRxiA3cbBtv82P0AXnECISX+jSkREEWP8RwdooE+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6yxnjU8VDYuxH6xc3n4fjR+UuqhZdEXp9TM6actgmcc2VurAGPpUA1h1co1VD3iY
         +CEz0YGVzCfbEIVD07kHsff1tmdERyJPiqS5Wsz4/HUlyKwMhW8EYdpt8gRMJpOlJZ
         +FAwdIEABGw/6pvPKcd47ySUgiycOwL5yLCSHeRLKdPdrXJ2+W7BnnmR7drEgv2/fu
         NpBTgpkkB5hsFawg5uadE54c3qJBchG5DirPSEPh6dr8Qx5LUgy3Lf9l8smqWUPRqn
         jf9t3A8B3UKhCy26XOtM6RrN/U3qgf15Rsv7iSYr6yrWao59YQxooNcJ75BwQU3Rg0
         9qHtfFuQx1vjA==
Date:   Wed, 5 Jul 2023 13:51:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Markus.Elfring@web.de, Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:QLOGIC QL4xxx ETHERNET DRIVER" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] qed: Remove a duplicate assignment in
 qed_rdma_create_srq()
Message-ID: <20230705105146.GN6455@unreal>
References: <20230705103547.15072-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705103547.15072-1-duminjie@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 06:35:46PM +0800, Minjie Du wrote:
> Delete a duplicate statement from this function implementation.
> 
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  drivers/net/ethernet/qlogic/qed/qed_rdma.c | 1 -
>  1 file changed, 1 deletion(-)

This patch should be resubmitted after merge window ends.

Please specify net-next target in patch subject and add changelog
that describes the differences between versions.

Thanks

> 
> diff --git a/drivers/net/ethernet/qlogic/qed/qed_rdma.c b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> index 5a5dbbb8d..41efced49 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_rdma.c
> @@ -1795,7 +1795,6 @@ qed_rdma_create_srq(void *rdma_cxt,
>  
>  	opaque_fid = p_hwfn->hw_info.opaque_fid;
>  
> -	opaque_fid = p_hwfn->hw_info.opaque_fid;
>  	init_data.opaque_fid = opaque_fid;
>  	init_data.comp_mode = QED_SPQ_MODE_EBLOCK;
>  
> -- 
> 2.39.0
> 
> 
