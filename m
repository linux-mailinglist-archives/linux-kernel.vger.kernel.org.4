Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3846D9200
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjDFIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDFIvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:51:32 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE817A97;
        Thu,  6 Apr 2023 01:51:29 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pkLKc-00D1yW-99; Thu, 06 Apr 2023 16:50:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Apr 2023 16:50:58 +0800
Date:   Thu, 6 Apr 2023 16:50:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ryan.Wanner@microchip.com
Cc:     davem@davemloft.net, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] Atmel crypto engine fixes
Message-ID: <ZC6H8ox1EDasCTXJ@gondor.apana.org.au>
References: <cover.1680019905.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1680019905.git.Ryan.Wanner@microchip.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 12:56:25PM -0700, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> I made changes to the crypto engines to fix the errors in the crypto
> manager tests. Mainly having to do with in-place tests with two 
> scatter lists. These are built and tested in 6.2.7 kernel, the
> devices that are used for testing is the sam9x60, sama7g5, and
> sama5d27_som1_ek.
> 
> Adding support for zero-length messages for hmac-sha operations. Using
> the atmel_sha_fill_padding() function to padd the empty message manualy
> then disabling auto padding. This is built and tested on kernel 6.2.7
> using sam9x60, sama7g5, and sama5d27_som1_ek.
> 
> 
> Ryan Wanner (4):
>   crypto: atmel-sha: Add zero length message digest support for hmac
>   crypto: atmel-tdes - Detecting in-place operations with two sg lists
>   crypto: atmel-aes - Detecting in-place operations two sg lists
>   crypto: atmel-aes - Match cfb block size with generic implementation
> 
>  drivers/crypto/atmel-aes.c  | 16 +++++-----------
>  drivers/crypto/atmel-sha.c  | 34 ++++++++++++++++++++++++++++++----
>  drivers/crypto/atmel-tdes.c | 15 +++++----------
>  3 files changed, 40 insertions(+), 25 deletions(-)
> 
> -- 
> 2.37.2

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
