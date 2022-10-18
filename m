Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129BD602310
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 06:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJREEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 00:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJREEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 00:04:37 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07412751;
        Mon, 17 Oct 2022 21:04:32 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1okdp1-00Foo3-6i; Tue, 18 Oct 2022 15:03:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 18 Oct 2022 12:03:19 +0800
Date:   Tue, 18 Oct 2022 12:03:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/polyval - Fix crashes when keys are not
 16-byte aligned
Message-ID: <Y04lhwMechdfBkUU@gondor.apana.org.au>
References: <20221017222620.715153-1-nhuck@google.com>
 <Y03fBQPM7h7+cfGK@sol.localdomain>
 <CAJkfWY5CXFQfSkM=U6u_DdLjDyLDoubqy2FeSZg5k7GBkOTnsQ@mail.gmail.com>
 <Y03vYKwgdK34Hyfh@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y03vYKwgdK34Hyfh@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 05:12:16PM -0700, Eric Biggers wrote:
>
> arm64 defines ARCH_DMA_MINALIGN to 128, so I don't think the same issue applies
> there.  Also the instructions used don't assume aligned addresses.

Note that arm64 may lower ARCH_KMALLOC_MINALIGN to 8 soon.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
