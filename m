Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FF6519CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 04:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiLTDzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 22:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLTDzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 22:55:50 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB008B1DD;
        Mon, 19 Dec 2022 19:55:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p7TjE-008kHh-3m; Tue, 20 Dec 2022 11:55:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Dec 2022 11:55:44 +0800
Date:   Tue, 20 Dec 2022 11:55:44 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] crypto: tcrypt - yield at end of test
Message-ID: <Y6EyQOBeUT9/PvJT@gondor.apana.org.au>
References: <20221219203733.3063192-1-elliott@hpe.com>
 <20221219203733.3063192-4-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219203733.3063192-4-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:37:33PM -0600, Robert Elliott wrote:
> Call cond_resched() to let the scheduler reschedule the
> CPU at the end of each test pass.
> 
> If the kernel is configured with CONFIG_PREEMPT_NONE=y (or
> preempt=none is used on the kernel command line), the only
> time the scheduler will intervene is when cond_resched()
> is called. So, repeated calls to
> 	modprobe tcrypt mode=<something>
> 
> hold the CPU for a long time.
> 
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  crypto/tcrypt.c | 1 +
>  1 file changed, 1 insertion(+)

I don't really see the point of this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
