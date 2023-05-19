Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCB97096DC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjESLzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjESLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 07:55:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBCD191;
        Fri, 19 May 2023 04:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684497328; x=1716033328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZcnD1s9sB8FFoJCCwAYWXI3hUc+y0AnVUaksQh1t5oY=;
  b=YthhLdx4CS3XELfxLHioR1+9GNrJt2q81drKB8VR7LtAb2CX1fhlaXTf
   aKEKalHMVHPfTFplE5layI5DaQj0mrL4OtYx9XR/ZRzrTD0DXUPLL77FM
   f3fZidlmePAFf0Wkty77ExnW4iEDXLfnq85YU2hE9TUkjzhGmAZqaM9Ma
   J3m+DlbVFLwMDpgWVefB4jDa735SQRZoYohQ+IWBfpIS7wHqxGiF8XR4/
   C8h6Lfjbf9XoRjx7CYPey1NGLw1ulU4yvaQeyLBpqnjx57mYaiV/T6xoN
   fBE1QvItW6bQ8zVDFx0t5a5mTWLUDOvn9y/nEPR5ogDQt/GUh1J9Dqggd
   w==;
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400"; 
   d="asc'?scan'208";a="214581983"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 04:55:27 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 04:55:26 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 19 May 2023 04:55:24 -0700
Date:   Fri, 19 May 2023 12:55:02 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel@sholland.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 06/10] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <20230519-squad-undermine-6124aafebafa@wendy>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-7-jszhang@kernel.org>
 <c6e44e14-35b2-da09-5e8c-4d47e7a7a055@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LxBuwS+otbeaG+3j"
Content-Disposition: inline
In-Reply-To: <c6e44e14-35b2-da09-5e8c-4d47e7a7a055@sholland.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--LxBuwS+otbeaG+3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:31:35PM -0500, Samuel Holland wrote:
> Hi Jisheng, DT maintainers,

Sick, thanks for piping up Samuel!
Both Rob and Krzysztof are not around at the moment, so that probably
leaves it up to me.. I'm adding Arnd in case he has a take here too.

> On 5/18/23 10:22, Jisheng Zhang wrote:
> > Several SoMs and boards are available that feature the Bouffalolab
> > bl808 SoC. Document the compatible strings.
> >=20
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/riscv/bouffalolab.yaml           | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab=
=2Eyaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b=
/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > new file mode 100644
> > index 000000000000..3b25d1a5d04a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bouffalo Lab Technology SoC-based boards
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description:
> > +  Bouffalo Lab Technology SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: Carrier boards for the Sipeed M1s SoM
> > +        items:
> > +          - enum:
> > +              - sipeed,m1s-dock
> > +          - const: sipeed,m1s
> > +          - const: bouffalolab,bl808
>=20
> As mentioned in the message for patch 5, "The Bouffalolab bl808 SoC
> contains three riscv CPUs, namely M0, D0 and LP. The D0 is 64bit RISC-V
> GC compatible, so can run linux."
>=20
> I have also been running U-Boot and NOMMU Linux on the less powerful,
> but still quite fast, "M0" core. However, this core needs a different
> DTB because:
>  1) The CPU is different (T-HEAD E907 instead of C906).
>  2) The interrupt routing is completely different.
>     a. The M0 core contains a CLIC instead of a PLIC.
>     b. The peripherals in the SoC are split between two buses. Those
>        on one bus have their IRQs directly connected to M0, and share
>        a multiplexed IRQ connection to D0; and vice versa for the
>        other bus. So each bus's interrupt-parent needs to be swapped.
>=20
> Using some preprocessor magic like we did for Allwinner and Renesas, I
> was able to share most of the SoC and board DTs between the cores[1].
> However, this still ends up with two DTs for each board. So here are my
> questions:
>  - Is this acceptable?

I expected it to look worse than it actually turned out to be.
I don't think Krzysztof in particular is a fan of having conditional
bits in dts files, but for the shared arm/riscv stuff there was not
really another sensible option.

>  - Is there precedent for how we should name the two board DTs?

Arnd might have some idea about precedent here, but I like your naming
well enough.

>  - How does this affect the board and SoC compatible strings?
>    - Should there be a separate "bouffalolab,bl808-d0" in addition to
>      "bouffalolab,bl808"?

What ordering were you intending here?
"pine64,0x64" "bouffalolab,bl808" "bouffalolab,bl808-d0"?

That doesn't really seem correct though, as it does not get less specific
as you move right.

"pine64,0x64" "bouffalolab,bl808-d0" "bouffalolab,bl808" doesn't seem
right either though, for the same sort of reason.

>    - Is it acceptable to use the same board compatible string for both,
>      since the _board_ part of the DT does not change, only things
>      inside the SoC?

I think you may need to have 2 compatibles per board, depending on which
cpu. Perhaps even as verbose as:
"pine61,0x64-d0" "pine64,0x64" "bouffalolab,bl808-d0" "bouffalolab,bl808"

Not exactly straightforward though, is it!

> It would be possible to avoid having two DTs per board by guarding all
> of the differences behind "#ifdef CONFIG_64BIT", but that seems wrong
> because you would end up with two totally incompatible DTBs named the
> same thing, depending on how the DTB was built.

I think having 2 dtbs is fine, and as I mentioned, I've seen Krzysztof
complain previously about conditional bits like that.

Cheers,
Conor.

--LxBuwS+otbeaG+3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGdjlgAKCRB4tDGHoIJi
0tAQAQCdbojzTmY2QrZpKQo0nj8+qxFONs8VYRfCsU2Xg2afPAEAtrBzj/r6BfCS
68C3HwnUUv5Vx+6SNWmBVEN/782qPAM=
=iT9e
-----END PGP SIGNATURE-----

--LxBuwS+otbeaG+3j--
