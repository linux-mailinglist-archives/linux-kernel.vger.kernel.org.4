Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBCB640468
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbiLBKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiLBKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:19:25 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF6CCED0;
        Fri,  2 Dec 2022 02:19:24 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p138O-003CBV-E7; Fri, 02 Dec 2022 18:19:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:19:08 +0800
Date:   Fri, 2 Dec 2022 18:19:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nikolaus Voss <nikolaus.voss@haag-streit.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Nikolaus Voss <nv@vosn.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: caam: blob_gen.c: warn if key is insecure
Message-ID: <Y4nRHLAJeaVs1vMW@gondor.apana.org.au>
References: <20221121141929.2E36427E9@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121141929.2E36427E9@mail.steuer-voss.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 03:12:41PM +0100, Nikolaus Voss wrote:
> If CAAM is not in "trusted" or "secure" state, a fixed non-volatile key
> is used instead of the unique device key. This is the default mode of
> operation without secure boot (HAB). In this scenario, CAAM encrypted
> blobs should be used only for testing but not in a production
> environment, so issue a warning.
> 
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> 
> ---
> CHANGES
> =======
> v2: make warning more verbose, correct register, style fixes
> v3: fix sparse warning "dereference of noderef expression"
>     by using ioread32() to dereference iomem pointer
> 
>  drivers/crypto/caam/blob_gen.c | 9 +++++++++
>  drivers/crypto/caam/regs.h     | 3 +++
>  2 files changed, 12 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
