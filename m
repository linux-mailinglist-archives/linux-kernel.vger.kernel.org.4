Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F7E669155
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAMIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjAMIkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:40:31 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB3268C9C;
        Fri, 13 Jan 2023 00:40:30 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pGFbi-00HA2b-73; Fri, 13 Jan 2023 16:40:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 16:40:14 +0800
Date:   Fri, 13 Jan 2023 16:40:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/3] crypto: Allwinner D1 crypto support
Message-ID: <Y8EY7kALf8bYNwov@gondor.apana.org.au>
References: <20221231220146.646-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231220146.646-1-samuel@sholland.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 04:01:42PM -0600, Samuel Holland wrote:
> This series finishes adding crypto support for the Allwinner D1 SoC. The
> driver patch from v1 was merged, but not the binding[1]. This turned out
> to be a good thing, because I later found that the TRNG needed another
> clock reference in the devicetree. That is fixed in v2. I include the DT
> update here too, since the SoC DT has been on the list for a while[2].
> 
> [1]: https://lore.kernel.org/all/20211119051026.13049-1-samuel@sholland.org/T/
> [2]: https://lore.kernel.org/lkml/20221208090237.20572-1-samuel@sholland.org/
> 
> Changes in v2:
>  - Add TRNG clock
> 
> Samuel Holland (3):
>   dt-bindings: crypto: sun8i-ce: Add compatible for D1
>   crypto: sun8i-ce - Add TRNG clock to the D1 variant
>   riscv: dts: allwinner: d1: Add crypto engine node
> 
>  .../bindings/crypto/allwinner,sun8i-ce.yaml   | 33 ++++++++++++++-----
>  .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 12 +++++++
>  .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  |  2 +-
>  4 files changed, 39 insertions(+), 9 deletions(-)
> 
> -- 
> 2.37.4

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
