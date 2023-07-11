Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95C74E75B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjGKGbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AC4116
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D3B861336
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2FFC433C8;
        Tue, 11 Jul 2023 06:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689057094;
        bh=rLCq6il+gOpNtxEJbxzI2Ce9xDoda14FwO05ImMBhQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4ahMrCFfuMkTa+Noeh5oeBU+FwgSXZFMkytOsnNYj0XPzgEjioWFbsE3NsaLpWIE
         6rZRtrqRB4HpkrLArsvuSeuBSDsQmJIVKHtGghV8CI001WPGBBF347q6dnwBDsbWka
         MeRgeU33J5rpr8FNKa3Bdmn6OI6vu2j6RpJfCvyghYvPiI6z+GWvgVxOQRxTuucJhk
         5FGjxeAniw/KPT380IvmYz4Ql2wdKU70i5Q8J+puPv/8was0T93byQq2GPJbZ71Ztj
         poJ1exuBZBnm1Wy8osnSja63wqAoi6rYkDaJntaIhV3p7QxDGjzFFTGcKPPX7gYzKh
         xGqlMxbkdwQyA==
Date:   Tue, 11 Jul 2023 09:31:25 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH RESEND net-next] bnxt_en: use dev_consume_skb_any() in
 bnxt_tx_int
Message-ID: <20230711063125.GA41919@unreal>
References: <20230710094747.943782-1-imagedong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710094747.943782-1-imagedong@tencent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:47:47PM +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> Replace dev_kfree_skb_any() with dev_consume_skb_any() in bnxt_tx_int()
> to clear the unnecessary noise of "kfree_skb" event.

Can you please be more specific in the commit message what "unnecessary
noise" you reduced?

> 
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
