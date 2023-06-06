Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E996A723B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjFFIWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjFFIWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:22:07 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8C4123;
        Tue,  6 Jun 2023 01:22:00 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q6Rwt-00HFv4-F2; Tue, 06 Jun 2023 16:21:52 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Jun 2023 16:21:51 +0800
Date:   Tue, 6 Jun 2023 16:21:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] crypto: Fix checkpatch issues
Message-ID: <ZH7sn7i2t+5IrXXK@gondor.apana.org.au>
References: <20230603142453.92582-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603142453.92582-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 04:24:53PM +0200, Franziska Naepelt wrote:
> crypto/crct10dif_common.c
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> 
> crypto/fcrypt.c
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> - WARNING: Block comments use a trailing */ on a separate line
> 
> crypto/hmac.c
> - WARNING: Missing a blank line after declarations
> 
> crypto/md4.c
> - WARNING: Missing or malformed SPDX-License-Identifier tag
> - ERROR: space required after that ',' (ctx:VxV)
> - ERROR: space prohibited after that open square bracket '['
> - WARNING: space prohibited between function name and open parenthesis '('
> - ERROR: code indent should use tabs where possible
> 
> not fixed:
> crypto/md4.c
> - ERROR: space required after that ',' (ctx:VxV)
>    Lines 64, 65, 66 have not been fixed due to readability
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
>  crypto/crct10dif_common.c |  1 +
>  crypto/fcrypt.c           |  4 +++-
>  crypto/hmac.c             |  1 +
>  crypto/md4.c              | 11 ++++++-----
>  4 files changed, 11 insertions(+), 6 deletions(-)

Please split these up into individual patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
