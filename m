Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E624C640E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLBTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbiLBTVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:21:24 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADF6EF8B3;
        Fri,  2 Dec 2022 11:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=0NUu4ctHIlOxLau4TIcj+Sj7pIi/v+JOenF17DqHjZQ=; b=iSRBv/TWo0zdYt2Uko8NDseLAg
        jPbzfbBU9FPjf4MmG+1kiEz4Eu4gFoxlMNgt6e80tdC0woxsEJLWb72ZLr0Iicss49YjgqrvGzt65
        6GbXFVfCQQOPeZSRJT1bI7AENvEJbka+icCHmED7OvyAYBOOHCHbRo70f11BbRNBd7kVf/bw6rIGc
        sX0Xdb3M6T2Cnw3nEvdVs0kU89A2D43/LTj81k4zrxr8Enn1PgETTx4O+fS91odU1aN3V7cWEBtb5
        jvq9gNbHS+FWD1VG+mgWQ6AJfq3brAO6oBhmvjEiLoIwsOOgTiC2wqmx/BzRv+dQSEbghWKZ+Tx6P
        gLedwFjg==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1p1Bak-0098Qj-Hm; Fri, 02 Dec 2022 20:20:58 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1p1Baj-00Ex9e-3A;
        Fri, 02 Dec 2022 20:20:57 +0100
Date:   Fri, 2 Dec 2022 20:20:57 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: RNG: Add Rockchip RNG bindings
Message-ID: <Y4pQGRMzILrkRP/2@aurel32.net>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lin Jinhan <troy.lin@rock-chips.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221128184718.1963353-1-aurelien@aurel32.net>
 <20221128184718.1963353-2-aurelien@aurel32.net>
 <89b16ec5-f9a5-f836-f51a-8325448e4775@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89b16ec5-f9a5-f836-f51a-8325448e4775@linaro.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your feedback.

On 2022-11-29 10:24, Krzysztof Kozlowski wrote:
> On 28/11/2022 19:47, Aurelien Jarno wrote:
> > Add the RNG bindings for the RK3568 SoC from Rockchip
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...),
> so it is rng, not RNG. Also, you are not adding all-Rockhip RNG but a
> specific device.
> 
> Subject: drop second, redundant "bindings".
> 
> > 
> > Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> > ---
> >  .../bindings/rng/rockchip,rk3568-rng.yaml     | 60 +++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> > new file mode 100644
> > index 000000000000..c2f5ef69cf07
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rng/rockchip,rk3568-rng.yaml
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/rng/rockchip,rk3568-rng.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip TRNG
> > +
> > +description: True Random Number Generator for some Rockchip SoCs
> 
> s/for some Rockchip SoCs/on Rokchip RK3568 SoC/

My point there is that this driver should also work for other Rockchip
SoCs like the RK3588, but 1) it support for this SoC is being added and
not yet available in the Linux kernel 2) it hasn't been tested.

Should we mark it as RK3568 specific (or rather RK356x) and change that
once a compatible entry is added for the RK3588?

> > +
> > +maintainers:
> > +  - Aurelien Jarno <aurelien@aurel32.net>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3568-rng
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: TRNG clock
> > +      - description: TRNG AHB clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: trng_clk
> > +      - const: trng_hclk
> 
> These are too vague names. Everything is a clk in clock-names, so no
> need usually to add it as name suffix. Give them some descriptive names,
> e.g. core and ahb.

Those names are based on <include/dt-bindings/clock/rk3568-cru.h> and
other drivers seems to have used those for the names. But I understand
that broken things could have been merged, so I am fine changing that to
core and ahb.

> > +
> > +  resets:
> > +    maxItems: 1
> > +

Regards
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
