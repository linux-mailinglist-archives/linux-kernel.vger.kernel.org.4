Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288EF70062B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240950AbjELK77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjELK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:59:34 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51AB11DA9;
        Fri, 12 May 2023 03:59:32 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pxQUB-008CAA-Pw; Fri, 12 May 2023 18:58:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 May 2023 18:58:56 +0800
Date:   Fri, 12 May 2023 18:58:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Yang <mmyangfl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Jenny Zhang <jenny.zhang@starfivetech.com>,
        William Zhang <william.zhang@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwrng: histb - Move driver to
 drivers/char/hw_random/histb-rng.c
Message-ID: <ZF4b8Iz1CRPHCg4J@gondor.apana.org.au>
References: <20230421165700.1481002-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421165700.1481002-1-mmyangfl@gmail.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:56:49AM +0800, David Yang wrote:
> Move to drivers/char/hw_random since histb-(t)rng does not provide
> cryptography pseudo rng.
> 
> histb-rng is pretty like hisi-rng, but after investigation, we confirm
> there is no RNG_PHY_SEED register on histb-rng so a separate driver is
> needed.
> 
> Still we rename relevant function names to match those in hisi-rng.
> 
> Link: https://lore.kernel.org/r/20230401164448.1393336-1-mmyangfl@gmail.com
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
> v2: drop the dependency on HW_RANDOM
>  drivers/char/hw_random/Kconfig                | 11 +++
>  drivers/char/hw_random/Makefile               |  1 +
>  .../trng-stb.c => char/hw_random/histb-rng.c} | 83 +++++++++----------
>  drivers/crypto/hisilicon/Kconfig              |  7 --
>  drivers/crypto/hisilicon/Makefile             |  2 +-
>  drivers/crypto/hisilicon/trng/Makefile        |  3 -
>  6 files changed, 53 insertions(+), 54 deletions(-)
>  rename drivers/{crypto/hisilicon/trng/trng-stb.c => char/hw_random/histb-rng.c} (53%)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
