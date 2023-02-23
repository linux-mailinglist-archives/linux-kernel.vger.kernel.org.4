Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63E26A05DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbjBWKTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjBWKTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:19:09 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE4B3D928;
        Thu, 23 Feb 2023 02:19:08 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pV8gZ-00EqAf-Ai; Thu, 23 Feb 2023 18:18:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Feb 2023 18:18:47 +0800
Date:   Thu, 23 Feb 2023 18:18:47 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 16/27] kbuild, crypto: remove MODULE_LICENSE in
 non-modules
Message-ID: <Y/c9h/DoB9kQK4PQ@gondor.apana.org.au>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-17-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222121453.91915-17-nick.alcock@oracle.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 12:14:42PM +0000, Nick Alcock wrote:
>
> diff --git a/lib/crypto/blake2s-generic.c b/lib/crypto/blake2s-generic.c
> index 75ccb3e633e6..4ffe3d927920 100644
> --- a/lib/crypto/blake2s-generic.c
> +++ b/lib/crypto/blake2s-generic.c
> @@ -110,6 +110,5 @@ void blake2s_compress_generic(struct blake2s_state *state, const u8 *block,
>  
>  EXPORT_SYMBOL(blake2s_compress_generic);
>  
> -MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("BLAKE2s hash function");
>  MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");

Please remove all module-related code and the inclusion of
module.h.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
