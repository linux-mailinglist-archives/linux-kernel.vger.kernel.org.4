Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C5607654
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiJULg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJULgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:36:20 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0A262DC8;
        Fri, 21 Oct 2022 04:36:12 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1olqIH-004dqC-90; Fri, 21 Oct 2022 19:35:06 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Oct 2022 19:35:05 +0800
Date:   Fri, 21 Oct 2022 19:35:05 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Robert Elliott <elliott@hpe.com>
Cc:     davem@davemloft.net, jarod@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Message-ID: <Y1KD6WKjrM20wffZ@gondor.apana.org.au>
References: <20220930214014.37194-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930214014.37194-1-elliott@hpe.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:40:14PM -0500, Robert Elliott wrote:
> When a test mode invokes multiple tests (e.g., mode 0 invokes modes
> 1 through 199, and mode 3 tests three block cipher modes with des),
> don't keep accumulating the return values with ret += tcrypt_test(),
> which results in a bogus value if more than one report a nonzero
> value (e.g., two reporting -2 (-ENOENT) end up reporting -4 (-EINTR)).
> Instead, keep track of the minimum return value reported by any
> subtest.
> 
> Fixes: 4e033a6bc70f ("crypto: tcrypt - Do not exit on success in fips mode")
> Signed-off-by: Robert Elliott <elliott@hpe.com>
> ---
>  crypto/tcrypt.c | 256 ++++++++++++++++++++++++------------------------
>  1 file changed, 128 insertions(+), 128 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
