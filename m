Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16DE6660D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 17:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbjAKQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238088AbjAKQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:41:41 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC121C123;
        Wed, 11 Jan 2023 08:40:32 -0800 (PST)
Date:   Wed, 11 Jan 2023 16:40:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1673455230;
        bh=1CxCJtXN8jkj7d+XLUeTWv6kMDXKx4rzhz2v14YhVsY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=RCEp35517cFDBBOE5Zgf53o0SXJ0BZvRVtjWgqTUaQLRipyhPS6dxBQppB26A/vBI
         77CgE5iEZf4TwJUAEsqeuISJpH/8kvU58kVeF3IMfZrBn8PiBPCBY4ODi7nPOIC8+0
         jx+ZFbtuRNSwW54W3fuWFKVyWzH/MRBmtRvBc5gw=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: automatically load module on genl access
Message-ID: <20230111164027.7oqg6zmkcpfitb3l@t-8ch.de>
References: <20221110052438.2188-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110052438.2188-1-linux@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 10, 2022 at 06:24:38AM +0100, Thomas Weiﬂschuh wrote:
> Instead of forcing the user to manually load the module do it
> automatically.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 5cffd96ef2d7..1c38a7ea9531 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2328,6 +2328,7 @@ static struct genl_family nbd_genl_family __ro_after_init = {
>  	.mcgrps		= nbd_mcast_grps,
>  	.n_mcgrps	= ARRAY_SIZE(nbd_mcast_grps),
>  };
> +MODULE_ALIAS_GENL_FAMILY(NBD_GENL_FAMILY_NAME);
>  
>  static int populate_nbd_status(struct nbd_device *nbd, struct sk_buff *reply)
>  {
> 
> base-commit: f67dd6ce0723ad013395f20a3f79d8a437d3f455
> -- 
> 2.38.1
> 

Any feedback on the patch?

Thanks,
Thomas
