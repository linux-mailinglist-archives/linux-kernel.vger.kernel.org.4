Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D74F643EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiLFIfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiLFIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:34:53 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010D6448;
        Tue,  6 Dec 2022 00:34:37 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p2TP1-004OOs-Rt; Tue, 06 Dec 2022 16:34:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Dec 2022 16:34:11 +0800
Date:   Tue, 6 Dec 2022 16:34:11 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LinuxKernelMailingList@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 0/10] crypto: Driver conversions for DMA alignment
Message-ID: <Y47+gxbdKR03EYCj@gondor.apana.org.au>
References: <Y4nDL50nToBbi4DS@gondor.apana.org.au>
 <Y4xpGNNsfbucyUlt@infradead.org>
 <Y47BgCuZsYLX61A9@gondor.apana.org.au>
 <Y47g7qO8dsRdxCgf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y47g7qO8dsRdxCgf@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 10:27:58PM -0800, Christoph Hellwig wrote:
.
> But GFP_DMA never did do anything at all about alignment.  It picks
> allocations from ZONE_DMA (which on x86 is the first 16MB only).

Right.  I'm not arguing that they are correct or anything.  I'm
just saying that they are currently working on arm64 because of
the large minimum kmalloc alignment, and they will all be broken
afterwards.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
