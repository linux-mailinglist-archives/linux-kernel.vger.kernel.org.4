Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD7680678
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjA3H3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjA3H3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:29:50 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388CD199FB;
        Sun, 29 Jan 2023 23:29:49 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pMObl-005UnV-U3; Mon, 30 Jan 2023 15:29:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Jan 2023 15:29:41 +0800
Date:   Mon, 30 Jan 2023 15:29:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        Jesper Nilsson <Jesper.Nilsson@axis.com>,
        Lars Persson <Lars.Persson@axis.com>, kernel <kernel@axis.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] crypto: axis - do not DMA to IV
Message-ID: <Y9dx5TXpoaGnxiDb@gondor.apana.org.au>
References: <20230110135042.2940847-1-vincent.whitchurch@axis.com>
 <20230110135042.2940847-3-vincent.whitchurch@axis.com>
 <Y8pa15wREUvWO1L8@gondor.apana.org.au>
 <Y9PwK/aVuD/dN1Lh@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9PwK/aVuD/dN1Lh@axis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:39:23PM +0100, Vincent Whitchurch wrote:
>
> Thanks, I'll fix this in v2.  Should we add a CRYPTO_DMA_ALIGN_ATTR
> macro similar to CRYPTO_MINALIGN_ATTR?

Sure we could do that.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
