Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB45E8927
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 09:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiIXHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiIXHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 03:31:07 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B871E3C5;
        Sat, 24 Sep 2022 00:31:05 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1obzcr-007vwW-Gi; Sat, 24 Sep 2022 17:31:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 24 Sep 2022 15:31:01 +0800
Date:   Sat, 24 Sep 2022 15:31:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     williamsukatube@163.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        williamsukatube@163.com
Subject: Re: [PATCH -next] hwrng: Remove duplicate include
Message-ID: <Yy6yNaTVnwvHaN8U@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917095505.5646-1-williamsukatube@163.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@163.com>
> 
> In file: drivers/char/hw_random/core.c,
> '#include <linux/random.h>' has included at line: 18,
> now it is duplicated include at line: 24, so delete duplicated include.
> 
> Signed-off-by: William Dean <williamsukatube@163.com>
> ---
> drivers/char/hw_random/core.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 16f227b995e8..56d171cd2fc6 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -21,7 +21,6 @@
> #include <linux/sched/signal.h>
> #include <linux/miscdevice.h>
> #include <linux/module.h>
> -#include <linux/random.h>
> #include <linux/sched.h>
> #include <linux/slab.h>
> #include <linux/uaccess.h>

This is supposed to be sorted so please remove the other inclusion
instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
