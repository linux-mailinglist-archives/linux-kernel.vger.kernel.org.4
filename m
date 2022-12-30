Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B44365999D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiL3PP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3PPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:15:55 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F369140B7;
        Fri, 30 Dec 2022 07:15:53 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pBH6d-00COx2-Oe; Fri, 30 Dec 2022 23:15:36 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Dec 2022 23:15:35 +0800
Date:   Fri, 30 Dec 2022 23:15:35 +0800
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
Subject: Re: [PATCH v2] crypto: caam: blob_gen.c: fix CAAM io mem access
Message-ID: <Y68Al6xfXj2ZvgHv@gondor.apana.org.au>
References: <20221220081750.2D0183BDB@mail.steuer-voss.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220081750.2D0183BDB@mail.steuer-voss.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 09:17:50AM +0100, Nikolaus Voss wrote:
> IO memory access has to be done with accessors defined in caam/regs.h
> as there are little-endian architectures with a big-endian CAAM unit.
> 
> Fixes: 6a83830f649a ("crypto: caam - warn if blob_gen key is insecure")
> Signed-off-by: Nikolaus Voss <nikolaus.voss@haag-streit.com>
> Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> ---
> v2: added upstream commit ref and reviewed-by line
> 
>  drivers/crypto/caam/blob_gen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
