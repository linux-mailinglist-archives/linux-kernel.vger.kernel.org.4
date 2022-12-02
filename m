Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5464046F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiLBKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiLBKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:20:00 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC10CCFDE;
        Fri,  2 Dec 2022 02:20:00 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p1394-003CCS-AZ; Fri, 02 Dec 2022 18:19:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:19:50 +0800
Date:   Fri, 2 Dec 2022 18:19:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Corentin Labbe <clabbe@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] crypto: amlogic - Save a few bytes of memory
Message-ID: <Y4nRRtV3ZCr+DJlM@gondor.apana.org.au>
References: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c797dc5e9248498918916a6eeedaa25de2196e8c.1669154149.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:56:19PM +0100, Christophe JAILLET wrote:
> There is no real point in allocating dedicated memory for the irqs array.
> MAXFLOW is only 2, so it is easier to allocated the needed space
> directly within the 'meson_dev' structure.
> 
> This saves some memory allocation and avoids an indirection when using the
> irqs array.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/amlogic/amlogic-gxl-core.c | 1 -
>  drivers/crypto/amlogic/amlogic-gxl.h      | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
