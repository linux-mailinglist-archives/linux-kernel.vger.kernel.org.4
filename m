Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF1F688EC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBCFFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjBCFE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:04:58 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEFD21A11;
        Thu,  2 Feb 2023 21:04:29 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNoF6-0071Rd-7o; Fri, 03 Feb 2023 13:04:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Feb 2023 13:04:08 +0800
Date:   Fri, 3 Feb 2023 13:04:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        John Allen <john.allen@amd.com>
Subject: Re: [PATCH] crypto: ccp - Flush the SEV-ES TMR memory before giving
 it to firmware
Message-ID: <Y9yVyOQrtcAlsMVg@gondor.apana.org.au>
References: <9d112c35bf613a42453e05c69ec0c96a32ba6078.1674514388.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d112c35bf613a42453e05c69ec0c96a32ba6078.1674514388.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:53:08PM -0600, Tom Lendacky wrote:
> Perform a cache flush on the SEV-ES TMR memory after allocation to prevent
> any possibility of the firmware encountering an error should dirty cache
> lines be present. Use clflush_cache_range() to flush the SEV-ES TMR memory.
> 
> Fixes: 97f9ac3db661 ("crypto: ccp - Add support for SEV-ES to the PSP driver")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
