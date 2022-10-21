Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0960765E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJULj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJULjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:39:24 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCCC9;
        Fri, 21 Oct 2022 04:39:19 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olqMF-004dzU-4V; Fri, 21 Oct 2022 19:39:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:39:11 +0800
Date:   Fri, 21 Oct 2022 19:39:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tomas Marek <tomas.marek@elrest.cz>
Cc:     mpm@selenic.com, mcoquelin.stm32@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, oleg.karfich@wago.com
Subject: Re: [PATCH 0/2] hwrng: stm32 - improve performance
Message-ID: <Y1KE3zg3cn7kVH5t@gondor.apana.org.au>
References: <20221012160924.12226-1-tomas.marek@elrest.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012160924.12226-1-tomas.marek@elrest.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 06:09:22PM +0200, Tomas Marek wrote:
> Fix issues in the STM32 TRNG driver to improve performance.
> 
> Tomas Marek (2):
>   hwrng: stm32 - fix number of returned bytes on read
>   hwrng: stm32 - fix read of the last word
> 
>  drivers/char/hw_random/stm32-rng.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> -- 
> 2.17.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
