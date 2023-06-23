Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770473B2A5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFWIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFWIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:22:30 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7868E2105;
        Fri, 23 Jun 2023 01:22:28 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qCc3f-006KXc-4r; Fri, 23 Jun 2023 16:22:20 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 23 Jun 2023 16:22:19 +0800
Date:   Fri, 23 Jun 2023 16:22:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mahmoud Adam <mngyadam@amazon.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rsa - allow only odd e and restrict value in
 FIPS mode
Message-ID: <ZJVWO1ndSs0bupBC@gondor.apana.org.au>
References: <20230613161731.74081-1-mngyadam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613161731.74081-1-mngyadam@amazon.com>
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

On Tue, Jun 13, 2023 at 04:17:31PM +0000, Mahmoud Adam wrote:
> check if rsa public exponent is odd and check its value is between
> 2^16 < e < 2^256.
> 
> FIPS 186-5 DSS (page 35)[1] specify that:
> 1. The public exponent e shall be selected with the following constraints:
>   (a) The public verification exponent e shall be selected prior to
>   generating the primes, p and q, and the private signature exponent
>   d.
>   (b) The exponent e shall be an odd positive integer such that:
>    2^16 < e < 2^256.
> 
> [1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.186-5.pdf
> 
> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
> ---
>  crypto/rsa.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
