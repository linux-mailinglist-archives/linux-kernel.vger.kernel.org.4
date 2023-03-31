Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB4A6D1D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjCaJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjCaJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:54:42 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B21DFB8;
        Fri, 31 Mar 2023 02:54:00 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1piBS3-00AlBo-Tq; Fri, 31 Mar 2023 17:53:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Mar 2023 17:53:43 +0800
Date:   Fri, 31 Mar 2023 17:53:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        davem@davemloft.net, kim.phillips@freescale.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] crypto: caam: Clear some memory in instantiate_rng()
Message-ID: <ZCatp5UWC/la+flQ@gondor.apana.org.au>
References: <41a7e41bb5a14f1e6e68a81c16c90e3ad4542ab1.1679381782.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41a7e41bb5a14f1e6e68a81c16c90e3ad4542ab1.1679381782.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:59:30AM +0100, Christophe JAILLET wrote:
> According to the comment at the end of the 'for' loop just a few lines
> below, it looks needed to clear 'desc'.
> 
> So it should also be cleared for the first iteration.
> 
> Move the memset() to the beginning of the loop to be safe.
> 
> Fixes: 281922a1d4f5 ("crypto: caam - add support for SEC v5.x RNG4")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v1 --> v2:
>    - move the memset() instead of doing s/kmalloc/kzalloc/
>    - adding a Fixes tag
> 
> v1:
>    https://lore.kernel.org/all/16d6bf3bd7a6e96a8262fcd4680e3ccbb5a50478.1679355849.git.christophe.jaillet@wanadoo.fr/
> 
> For for loop has been introduceD in commit 1005bccd7a4a ("crypto: caam -
> enable instantiation of all RNG4 state handles"). But if 'desc' really
> needs to be cleared, the issue was there before (thus the Fixes tag in
> the commit log)
> ---
>  drivers/crypto/caam/ctrl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
