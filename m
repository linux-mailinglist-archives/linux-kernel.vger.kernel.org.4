Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45365998F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbiL3PDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3PDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:03:47 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E8140DF;
        Fri, 30 Dec 2022 07:03:47 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBGuu-00COew-Kk; Fri, 30 Dec 2022 23:03:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 23:03:28 +0800
Date:   Fri, 30 Dec 2022 23:03:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel: Add capability case for the 0x600 SHA and
 AES IP versions
Message-ID: <Y679wJ1pe3leVBxI@gondor.apana.org.au>
References: <20221207135953.136557-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207135953.136557-1-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 03:59:55PM +0200, Sergiu Moga wrote:
> In order for the driver to be made aware of the capabilities of the SHA
> and AES IP versions 0x600 , such as those present on the SAM9X60 SoC's,
> add a corresponding switch case to the capability method of the respective
> drivers. Without this, besides the capabilities not being correctly set,
> the self tests may hang since the driver is endlessly waiting for a
> completion to be set by a never occurring DMA interrupt handler.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  drivers/crypto/atmel-aes.c | 1 +
>  drivers/crypto/atmel-sha.c | 1 +
>  2 files changed, 2 insertions(+)

Patch applied.  Thanks.
--
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
