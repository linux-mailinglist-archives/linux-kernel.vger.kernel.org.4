Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2448B6AAEF4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCEKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjCEKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:15:34 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21451E3A8;
        Sun,  5 Mar 2023 02:15:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pYlOh-000SfT-J0; Sun, 05 Mar 2023 18:15:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 05 Mar 2023 18:15:19 +0800
Date:   Sun, 5 Mar 2023 18:15:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [GIT PULL] Crypto Fixes for 6.3
Message-ID: <ZARrt99wJb7IhoY4@gondor.apana.org.au>
References: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus:

The following changes since commit 8b84475318641c2b89320859332544cf187e1cbd:

  crypto: x86/aria-avx - Do not use avx2 instructions (2023-02-14 13:39:33 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p2 

for you to fetch changes up to 660ca9470f9c613fa2c71a123a9469c80a697ee4:

  crypto: caam - Fix edesc/iv ordering mixup (2023-02-28 16:30:58 +0800)

----------------------------------------------------------------
This push fixes a regression in the caam driver.
----------------------------------------------------------------

Herbert Xu (1):
      crypto: caam - Fix edesc/iv ordering mixup

 drivers/crypto/caam/caamalg.c    | 26 +++++++++++++++++++-------
 drivers/crypto/caam/caamalg_qi.c | 40 ++++++++++++++++++++++++++--------------
 drivers/crypto/caam/qi.c         | 10 ++++++++--
 3 files changed, 53 insertions(+), 23 deletions(-)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
