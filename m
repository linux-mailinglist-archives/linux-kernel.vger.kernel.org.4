Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B26F989E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjEGNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEGNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 09:20:04 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3517DDB;
        Sun,  7 May 2023 06:20:01 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pveIl-006CHt-F5; Sun, 07 May 2023 21:19:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 07 May 2023 21:19:48 +0800
Date:   Sun, 7 May 2023 21:19:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.4
Message-ID: <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
References: <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZARrt99wJb7IhoY4@gondor.apana.org.au>
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

Hi Linus:

The following changes since commit 482c84e906e535072c55395acabd3a58e9443d12:

  i2c: designware: Add doorbell support for Mendocino (2023-04-20 18:20:05 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p2 

for you to fetch changes up to b8969a1b69672b163d057e7745ebc915df689211:

  crypto: api - Fix CRYPTO_USER checks for report function (2023-05-02 18:22:24 +0800)

----------------------------------------------------------------
This push fixes the following problems:

- A long-standing bug in crypto_engine.
- A buggy but harmless check in the sun8i-ss driver. 
- A regression in the CRYPTO_USER interface.
----------------------------------------------------------------

Christophe JAILLET (1):
      crypto: sun8i-ss - Fix a test in sun8i_ss_setup_ivs()

Olivier Bacon (1):
      crypto: engine - fix crypto_queue backlog handling

Ondrej Mosnacek (1):
      crypto: api - Fix CRYPTO_USER checks for report function

 crypto/acompress.c                                  | 2 +-
 crypto/aead.c                                       | 2 +-
 crypto/ahash.c                                      | 2 +-
 crypto/akcipher.c                                   | 2 +-
 crypto/algapi.c                                     | 3 +++
 crypto/crypto_engine.c                              | 6 +++---
 crypto/kpp.c                                        | 2 +-
 crypto/rng.c                                        | 2 +-
 crypto/scompress.c                                  | 2 +-
 crypto/shash.c                                      | 2 +-
 crypto/skcipher.c                                   | 2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 2 +-
 12 files changed, 16 insertions(+), 13 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
