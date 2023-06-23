Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2309A73B299
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjFWIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjFWIVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:21:42 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F052C26BC;
        Fri, 23 Jun 2023 01:21:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qCc2k-006KV5-3n; Fri, 23 Jun 2023 16:21:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jun 2023 16:21:22 +0800
Date:   Fri, 23 Jun 2023 16:21:22 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 0/2] crypto: starfive - Add RSA algo to drivers
Message-ID: <ZJVWAu78LakoToCR@gondor.apana.org.au>
References: <20230612085230.193507-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612085230.193507-1-jiajie.ho@starfivetech.com>
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

On Mon, Jun 12, 2023 at 04:52:28PM +0800, Jia Jie Ho wrote:
> This patch series adds RSA support to VisionFive 2 SoCs. Patch 1 updates
> current irq handling of hash module to prevent conflict among other
> crypto modules. Patch 2 adds RSA algo to crypto engine drivers.
> 
> Changes v2 -> v3:
>  - Rearranged irq mask clear sequence to prevent spurious interrupt
>    from completing pka_done prematurely (Herbert)
> 
> Changes v1 -> v2:
>  - Removed ASYNC flag (Herbert)
> 
> Jia Jie Ho (2):
>   crypto: starfive - Update hash module irq handling
>   crypto: starfive - Add RSA algo support
> 
>  drivers/crypto/starfive/Kconfig       |   1 +
>  drivers/crypto/starfive/Makefile      |   2 +-
>  drivers/crypto/starfive/jh7110-cryp.c |  20 +-
>  drivers/crypto/starfive/jh7110-cryp.h |  45 ++
>  drivers/crypto/starfive/jh7110-hash.c |   9 +-
>  drivers/crypto/starfive/jh7110-rsa.c  | 617 ++++++++++++++++++++++++++
>  6 files changed, 691 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/crypto/starfive/jh7110-rsa.c
> 
> -- 
> 2.34.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
