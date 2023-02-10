Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84E691BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjBJJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBJJos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:44:48 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D4E2DE4A;
        Fri, 10 Feb 2023 01:44:45 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pQPxG-009bxi-FL; Fri, 10 Feb 2023 17:44:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 10 Feb 2023 17:44:30 +0800
Date:   Fri, 10 Feb 2023 17:44:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jenny Zhang <jenny.zhang@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: repair file entry for STARFIVE TRNG DRIVER
Message-ID: <Y+YR/mn9XIH3ueBN@gondor.apana.org.au>
References: <20230130073109.32025-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130073109.32025-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 08:31:09AM +0100, Lukas Bulwahn wrote:
> Commit c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
> adds the STARFIVE TRNG DRIVER section to MAINTAINERS, but refers to the
> non-existing file drivers/char/hw_random/starfive-trng.c rather than to the
> actually added file drivers/char/hw_random/jh7110-trng.c in this commit.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file entry in STARFIVE TRNG DRIVER.
> 
> Fixes: c388f458bc34 ("hwrng: starfive - Add TRNG driver for StarFive SoC")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jia Jie, please ack this patch.
> 
> Herbert, please pick this minor fix patch on top of the commit above. Thanks.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
