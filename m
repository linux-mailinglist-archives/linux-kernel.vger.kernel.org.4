Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511C688EC2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjBCFEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjBCFEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:04:04 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC22B618;
        Thu,  2 Feb 2023 21:03:33 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNoEA-0071QD-0I; Fri, 03 Feb 2023 13:03:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 Feb 2023 13:03:10 +0800
Date:   Fri, 3 Feb 2023 13:03:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Lafreniere <peter@n8pjl.ca>
Cc:     linux-crypto@vger.kernel.org, peter@n8pjl.ca, ardb@kernel.org,
        linux-kernel@vger.kernel.org, conor.dooley@microchip.com,
        x86@kernel.org
Subject: Re: [PATCH RESEND] crypto: x86 - exit fpu context earlier in ECB/CBC
 macros
Message-ID: <Y9yVjerSZcAkkmDf@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121183450.14570-1-peter@n8pjl.ca>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Lafreniere <peter@n8pjl.ca> wrote:
> Currently the ecb/cbc macros hold fpu context unnecessarily when using
> scalar cipher routines (e.g. when handling odd sizes of blocks per walk).
> 
> Change the macros to drop fpu context as soon as the fpu is out of use.
> 
> No performance impact found (on Intel Haswell).
> 
> Signed-off-by: Peter Lafreniere <peter@n8pjl.ca>
> ---
> arch/x86/crypto/ecb_cbc_helpers.h | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
