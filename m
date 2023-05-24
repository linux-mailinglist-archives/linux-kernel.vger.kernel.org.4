Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC070F3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjEXKPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjEXKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:14:28 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1DDC0;
        Wed, 24 May 2023 03:14:09 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1lVE-00Ckzq-PC; Wed, 24 May 2023 18:13:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 May 2023 18:13:56 +0800
Date:   Wed, 24 May 2023 18:13:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: aegis: add header for internal prototypes
Message-ID: <ZG3jZJ7XPMrb3isX@gondor.apana.org.au>
References: <20230516202855.561496-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516202855.561496-1-arnd@kernel.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:28:48PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns if prototypes are only visible to the caller but
> not the callee:
> 
> crypto/aegis128-neon-inner.c:134:6: warning: no previous prototype for 'crypto_aegis128_init_neon' [-Wmissing-prototypes]
> crypto/aegis128-neon-inner.c:164:6: warning: no previous prototype for 'crypto_aegis128_update_neon' [-Wmissing-prototypes]
> crypto/aegis128-neon-inner.c:221:6: warning: no previous prototype for 'crypto_aegis128_encrypt_chunk_neon' [-Wmissing-prototypes]
> crypto/aegis128-neon-inner.c:270:6: warning: no previous prototype for 'crypto_aegis128_decrypt_chunk_neon' [-Wmissing-prototypes]
> crypto/aegis128-neon-inner.c:316:5: warning: no previous prototype for 'crypto_aegis128_final_neon' [-Wmissing-prototypes]
> 
> The prototypes cannot be in the regular aegis.h, as the inner neon code
> cannot include normal kernel headers. Instead add a new header just for
> the functions provided by this file.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/aegis-neon.h          | 17 +++++++++++++++++
>  crypto/aegis128-neon-inner.c |  1 +
>  crypto/aegis128-neon.c       | 12 +-----------
>  3 files changed, 19 insertions(+), 11 deletions(-)
>  create mode 100644 crypto/aegis-neon.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
