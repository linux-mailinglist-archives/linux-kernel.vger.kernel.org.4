Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3E660302
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjAFPUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAFPTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:19:02 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320AD809BA;
        Fri,  6 Jan 2023 07:19:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pDoUW-00Ebxu-03; Fri, 06 Jan 2023 23:18:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Jan 2023 23:18:43 +0800
Date:   Fri, 6 Jan 2023 23:18:43 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vladis Dronov <vdronov@redhat.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Nicolai Stange <nstange@suse.de>,
        Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] Trivial set of FIPS 140-3 related changes
Message-ID: <Y7g70ztCEb0SbITW@gondor.apana.org.au>
References: <20221229211710.14912-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229211710.14912-1-vdronov@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 10:17:04PM +0100, Vladis Dronov wrote:
> Hi,
> 
> This patchset and cover letter was initially composed by Nicolai Stange
> and sent earlier as:
> 
> https://lore.kernel.org/r/20221108142025.13461-1-nstange@suse.de/
> with a subject: [PATCH 0/4] Trivial set of FIPS 140-3 related changes
> 
> I'm adding patches 2 and 3 which (I hope) resolve issues spotted by
> reviewers of previous version of the patchset. This new patchset should
> ease our future kernel work on the FIPS mode.
> 
> I'm quoting Nicolai's cover letter here:
> 
> > Hi all,
> > 
> > these four rather unrelated patches are basically a dump of some of the
> > more trivial changes required for working towards FIPS 140-3 conformance.
> > 
> > Please pick as you deem appropriate.
> > 
> > Thanks!
> > 
> > Nicolai
> 
> v2: fixed a block comment formatting
> 
> v3: "Reviewed-by: Eric Biggers" was copied from the v1 thread:
>     https://lore.kernel.org/r/Y6OXuT95MlkNanSR@sol.localdomain/
> 
> Nicolai Stange (4):
>   crypto: xts - restrict key lengths to approved values in FIPS mode
>   crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
>   crypto: testmgr - disallow plain ghash in FIPS mode
>   crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode
> 
> Vladis Dronov (2):
>   crypto: xts - drop xts_check_key()
>   crypto: xts - drop redundant xts key check
> 
>  arch/s390/crypto/aes_s390.c                   |  4 ---
>  arch/s390/crypto/paes_s390.c                  |  2 +-
>  crypto/testmgr.c                              |  4 +--
>  drivers/crypto/atmel-aes.c                    |  2 +-
>  drivers/crypto/axis/artpec6_crypto.c          |  2 +-
>  drivers/crypto/cavium/cpt/cptvf_algs.c        |  8 +++---
>  .../crypto/cavium/nitrox/nitrox_skcipher.c    |  8 +++---
>  drivers/crypto/ccree/cc_cipher.c              |  2 +-
>  .../crypto/marvell/octeontx/otx_cptvf_algs.c  |  2 +-
>  .../marvell/octeontx2/otx2_cptvf_algs.c       |  2 +-
>  include/crypto/xts.h                          | 25 +++++++------------
>  11 files changed, 23 insertions(+), 38 deletions(-)
> 
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> -- 
> 2.38.1

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
