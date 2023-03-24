Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476066C7C91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCXK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCXK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:29:19 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A122036;
        Fri, 24 Mar 2023 03:29:13 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfefE-008Fa5-8g; Fri, 24 Mar 2023 18:28:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 18:28:52 +0800
Date:   Fri, 24 Mar 2023 18:28:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     ye.xingchen@zte.com.cn
Cc:     davem@davemloft.net, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: p10-aes-gcm - remove duplicate include header
Message-ID: <ZB17ZB2Pi8LEDXGj@gondor.apana.org.au>
References: <202303141631511535639@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303141631511535639@zte.com.cn>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:31:51PM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> crypto/algapi.h is included more than once.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/powerpc/crypto/aes-gcm-p10-glue.c | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
