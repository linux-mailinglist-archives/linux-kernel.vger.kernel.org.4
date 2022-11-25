Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF4A638684
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 10:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKYJrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 04:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiKYJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 04:46:26 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD1C42180;
        Fri, 25 Nov 2022 01:45:23 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oyVGq-000hvO-5H; Fri, 25 Nov 2022 17:45:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Nov 2022 17:45:20 +0800
Date:   Fri, 25 Nov 2022 17:45:20 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhang Yiqun <zhangyiqun@phytium.com.cn>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangyiqun@phytium.com.cn
Subject: Re: [PATCH] crypto: tcrypt - Fix multibuffer skcipher speed test mem
 leak
Message-ID: <Y4COsJN27wpejCEV@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116092411.2432-1-zhangyiqun@phytium.com.cn>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Yiqun <zhangyiqun@phytium.com.cn> wrote:
> In the past, the data for mb-skcipher test has been allocated
> twice, that means the first allcated memory area is without
> free, which may cause a potential memory leakage. So this
> patch is to remove one allocation to fix this error.
> 
> Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
> ---
> crypto/tcrypt.c | 9 ---------
> 1 file changed, 9 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
