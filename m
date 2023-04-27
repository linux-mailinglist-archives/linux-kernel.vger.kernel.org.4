Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C96F00A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 08:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242855AbjD0GEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 02:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjD0GEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 02:04:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD82718;
        Wed, 26 Apr 2023 23:04:36 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1682575474;
        bh=cyecpHnIeBWNjwg8xQ+JBS0N+v6dd3dFUm88xA+Uels=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txX6NVbXb1wjkUb6eKuiG5cTqi+P8kEbA+NQRE/yk+lsmkCTBKMEjaq0PdLiFd8d1
         YHz8dWYeKyT6jiarWAwjsymdjI/UoCvie5kG7+Yu+YwnTp4pbgHowqGPx60T4NIhrk
         pXAnbqRrp+wIue2easFng2qDBnwVzWRoUXbgmnos=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd: automatically load module on genl access
Message-ID: <a71f01e8-8724-4c21-95b4-3a6be9f9dceb@t-8ch.de>
References: <20221110052438.2188-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110052438.2188-1-linux@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josef,

could you take a look at this?

... ping

Thanks,
Thomas

On 2022-11-10 06:24:38+0100, Thomas Weißschuh wrote:
> Instead of forcing the user to manually load the module do it
> automatically.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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
