Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31836C7C9C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbjCXKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCXKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:30:00 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A4D21974;
        Fri, 24 Mar 2023 03:29:58 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfeg9-008Fdj-5v; Fri, 24 Mar 2023 18:29:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 18:29:49 +0800
Date:   Fri, 24 Mar 2023 18:29:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfshcina.com
Subject: Re: [PATCH] crypto: remove unnecessary (void*) conversions
Message-ID: <ZB17nbEv5gPOMtsJ@gondor.apana.org.au>
References: <20230317062603.1729-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317062603.1729-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:26:03PM +0800, Yu Zhe wrote:
> Pointer variables of void * type do not require type cast.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/crypto/hifn_795x.c | 24 ++++++++++++------------
>  drivers/crypto/img-hash.c  |  2 +-
>  drivers/crypto/sa2ul.c     |  6 +++---
>  drivers/crypto/sahara.c    |  4 ++--
>  4 files changed, 18 insertions(+), 18 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
