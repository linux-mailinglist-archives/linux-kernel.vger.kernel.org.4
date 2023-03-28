Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589EF6CB53D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjC1D66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjC1D6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:58:54 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E1B5;
        Mon, 27 Mar 2023 20:58:53 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ph0Tf-009Oce-Ss; Tue, 28 Mar 2023 11:58:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 28 Mar 2023 11:58:31 +0800
Date:   Tue, 28 Mar 2023 11:58:31 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Li kunyu <kunyu@nfschina.com>, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: Re: [Linux-stm32] [v7 PATCH 8/8] crypto: stm32 - Save and restore
 between each request
Message-ID: <ZCJl55aGJO8CFO0j@gondor.apana.org.au>
References: <ZAxFBR3TdA7jUAgJ@gondor.apana.org.au>
 <E1pavED-002xbf-LL@formenos.hmeau.com>
 <e7cd1e8b-9ebc-ff6d-a8c4-1ccd11df6de1@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7cd1e8b-9ebc-ff6d-a8c4-1ccd11df6de1@foss.st.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:33:10AM +0200, Thomas BOURGOIN wrote:
> 
> I'm working on the patch for STM32MP13.

...
 
> The version of HASH implemented in the STM32MP13 provides new algorithms (SHA512, SHA3, ...).
> Because of that, the constant HASH_CSR_REGISTER_NUMBER increases (from 54 to 103).
> Hence, the size of stm32_hash_state is equal to 688 which is bigger than HASH_MAX_STATESIZE(=512)
> and the driver fails to register the algorithms.
> 
> Is there any reasons why HASH_MAX_STATESIZE is set to 512 ?
> I only see it used to define static arrays, so maybe it could be set to 1024.

Thanks for reaching out.  Please fix your emails so that they
are plain-text only, otherwise you won't be able to send any
patches to the list.

I have just sent out two patches to remove this limit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
