Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0064FF55
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 16:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiLRPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 10:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRPuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 10:50:32 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853ECA185
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 07:50:30 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1p6vvj-0007vO-HB; Sun, 18 Dec 2022 16:50:23 +0100
Date:   Sun, 18 Dec 2022 16:50:23 +0100
From:   Martin Kaiser <lists@kaiser.cx>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Prefer kcalloc over kzalloc
Message-ID: <20221218155023.tn6244fhbtwgkl7o@viti.kaiser.cx>
References: <20221216223942.334221-1-tegongkang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216223942.334221-1-tegongkang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Kang Minchul (tegongkang@gmail.com):

> Fixed following checkpatch.pl warning:
>  * WARNING: Prefer kcalloc over kzalloc with multiply

> Instead of specifying (number of bytes) * (size) as arugment
> in kzalloc, prefer kcalloc.

> Signed-off-by: Kang Minchul <tegongkang@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 34494f08c0cd..36ce1e3f9c81 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -1564,7 +1564,7 @@ int rtw_alloc_hwxmits(struct adapter *padapter)

>  	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;

> -	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
> +	pxmitpriv->hwxmits = kcalloc(pxmitpriv->hwxmit_entry, sizeof(struct hw_xmit), GFP_KERNEL);
>  	if (!pxmitpriv->hwxmits)
>  		return -ENOMEM;

> -- 
> 2.34.1

Reviewed-by: Martin Kaiser <martin@kaiser.cx>
