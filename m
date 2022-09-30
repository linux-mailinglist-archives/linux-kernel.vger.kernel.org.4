Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E501B5F0499
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiI3GOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiI3GOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:14:14 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801F110B1D;
        Thu, 29 Sep 2022 23:14:13 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe9HV-00A53u-JO; Fri, 30 Sep 2022 16:13:54 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 14:13:53 +0800
Date:   Fri, 30 Sep 2022 14:13:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: aspeed: fix build error when only
 CRYPTO_DEV_ASPEED is enabled
Message-ID: <YzaJIYl9PW+d48/l@gondor.apana.org.au>
References: <20220919063705.358225-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919063705.358225-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 02:37:05PM +0800, Neal Liu wrote:
> Fix build error within the following configs setting:
> - CONFIG_CRYPTO_DEV_ASPEED=y
> - CONFIG_CRYPTO_DEV_ASPEED_HACE_HASH is not set
> - CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO is not set
> 
> Error messages:
> make[4]: *** No rule to make target 'drivers/crypto/aspeed/aspeed_crypto.o'
> , needed by 'drivers/crypto/aspeed/built-in.a'.
> make[4]: Target '__build' not remade because of errors.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/crypto/aspeed/Kconfig  | 3 +--
>  drivers/crypto/aspeed/Makefile | 7 ++++---
>  2 files changed, 5 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
