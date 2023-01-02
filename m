Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EE965B683
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 19:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjABSSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 13:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 13:18:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96612C8;
        Mon,  2 Jan 2023 10:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C46E61093;
        Mon,  2 Jan 2023 18:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591AEC433EF;
        Mon,  2 Jan 2023 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672683510;
        bh=89S45z/8Tm/wRkpmUZ1bW+UDgb3zPm1RefIO82Il6MQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QN/9HLIBOoPzp3rwuXEcMvcqkyeoiHhfTryjSCgsvA2U7HG/MXUsjnzGIoWv96o8R
         C0nyz8ubHwMVLSUe9nSv14vlM5UPjz+S6Mosv9hYUmrtuEVxNo2qmxoU2LlWD+MQLE
         0XKEctxnBRFp4BE8j7xvY4lCTNBFuxKIVe8y65RcQ0QPSpWm6XSGSqZHd4FcJQSbqL
         /hgcKJ0Wd7nKQY6eA1zsgw6ZCzKfuuVj58vduDL0I56WTLH5l3yL/xx1IfNKJOnA7h
         Tt/w8bHVhD6sKoZpeVuWOC2m+5rHivfzkhAwdVZDXTa63Wy1psN/BAC71zo3n+47Fy
         eFBWobXg5eeQA==
Date:   Mon, 2 Jan 2023 18:17:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
Message-ID: <Y7MfyZBAErYGMZBK@spud>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com>
 <Y3EQ4JU7uGbIMGiW@spud>
 <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TQVrb+7+nS5b2faU"
Content-Disposition: inline
In-Reply-To: <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TQVrb+7+nS5b2faU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2023 at 10:20:48PM +0530, Anup Patel wrote:
> On Sun, Nov 13, 2022 at 9:14 PM Conor Dooley <conor@kernel.org> wrote:

> > > +  domain.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - vendor,chip-aplic
> >
> > Same comment here about the validity of this placeholder.
>=20
> Okay, I will add "riscv,qemu-aplic" as QEMU specific compatible string.

Ah neat. I think that's a fair compromise.

> > > +      - const: riscv,aplic

> > > +  msi-parent:
> > > +    description:
> > > +      The presence of this property implies that given APLIC domain =
forwards
> > > +      wired interrupts as MSIs to a AIA incoming message signaled in=
terrupt
> > > +      controller (IMSIC). This property should be considered only wh=
en the
> > > +      interrupts-extended property is absent.
> >
> > This mutual exclusion can be represented, can't it?
> > IIRC it is some sort of oneOf thing, somewhat like below:
> > oneOf:
> >   - required:
> >       - msi-parent
> >   - required:
> >       - interrupts-extended
> >
> > AFAIR from doing the i2c ocores binding, this will force the addition of
> > one, but not both, to a node.
> >
> > Or is this not actually mutually exclusive & the msi-parent property is
> > permitted but just left unused if interrupts-extended is present?
>=20
> If both are present then interrupts-extended is preferred.

Perhaps I am making a fool of myself here, but why would someone include
both of them at once, if only one is going to be used?
It would appear that making them explicitly mutually exclusive would
make the binding easier to understand.
What am I missing?

> > > +  riscv,children:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > +    minItems: 1
> > > +    maxItems: 1024
> > > +    description:
> > > +      This property represents a list of child APLIC domains for the=
 given
> > > +      APLIC domain. Each child APLIC domain is assigned child index =
in
> > > +      increasing order with the first child APLIC domain assigned ch=
ild
> > > +      index 0. The APLIC domain child index is used by firmware to d=
elegate
> > > +      interrupts from the given APLIC domain to a particular child A=
PLIC
> > > +      domain.
> > > +
> > > +  riscv,delegate:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > +    minItems: 1
> > > +    maxItems: 1024
> > > +    description:
> > > +      This property represents a interrupt delegation list where eac=
h entry
> > > +      is a triple consisting of child APLIC domain phandle, first in=
terrupt
> > > +      number, and last interrupt number. The firmware will configure=
 interrupt
> > > +      delegation registers based on interrupt delegation list.
> >
> > What is the inter dependence of the children and delegate?
> > Is it valid to have a delegate property without children?
> > Can the firmware delegate interrupts without the delegation list, based
> > on the children property alone? Or is it effectively useless without a
> > children property?
>=20
> Both properties convey different information. The "riscv,childen" describ=
es
> the association of child indexes with child APLIC domains whereas the
> "riscv,delegate" describes the interrupt delegation to few of the child
> APLIC domains.
>=20
>=20
> >
> > In your examples, the second has msi-parent but neither of these custom
> > properties. Do the children/delegate properties have a meaning in the
> > msi-parent case?
>=20
> The "riscv,childern" and "riscv,delegate" are only useful when we have
> hierarchy of multiple APLIC domains. The second example only has
> one APLIC domain hence these custom properties are absent.

It'd be great if you could include an example that explains the
difference as, IIRC, both Rob and I both were kinda confused as to how
the properties differ.

Thanks,
Conor.


--TQVrb+7+nS5b2faU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7MfyQAKCRB4tDGHoIJi
0thjAP99pOOK7i02KGfJvyYLevP0789k8SS2zN0cOk0Ie++/vwEA1hE5jLKlaIxR
MNgh209EnpK++6FWUk87WgaAxdmY0gg=
=gLSk
-----END PGP SIGNATURE-----

--TQVrb+7+nS5b2faU--
