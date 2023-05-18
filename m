Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E76707F02
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjERLQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:16:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E988B7;
        Thu, 18 May 2023 04:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684408580; x=1715944580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U8LmIZlVy2m1W8v/wdJAsGtoo4fdsTtTHn7NXom6u4c=;
  b=QYozv0ZcjVScECNlwyK5KmuBCpOGZKZ9dJYRhGlHDLezh0xnyNRwhMHH
   Y7pomQgbN9BTxFI4Rds0RpSazhVCwuywmv2qfGhxjEeI+i/tveZggRaa0
   bvpsu/eDERMJnpKxGBLkHPX22qQ+hZFNCvvnXGxCIccAALNXJn/Lt6Mk3
   b059GW6phXFPrkvtk6EOJGyxzpSlZsstPr/a/VRtSgs2jxoHnWOsifm1s
   iKM5OdgAgy3Uo30wEQUIFy8QxHhTSAwUp3htYGPdhDu4nD/bvr4pATh0Q
   MgjpTbx+9Gz4t2fZ5FQpyMFcjXNm4HPGkUEt88NSsriGm2Jy3tM8fEZga
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,285,1677567600"; 
   d="asc'?scan'208";a="211913064"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 04:16:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 04:16:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 04:16:13 -0700
Date:   Thu, 18 May 2023 12:15:52 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <palmer@dabbelt.com>, <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230518-retrial-remindful-ef21e3669c70@wendy>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RruE147I17+bCjXc"
Content-Disposition: inline
In-Reply-To: <20230518-4050231ca8dbe93c08cf9c9a@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--RruE147I17+bCjXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Drew,

On Thu, May 18, 2023 at 12:31:51PM +0200, Andrew Jones wrote:
> On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:

> > -  riscv,isa:
> > -    description:
> > -      Identifies the specific RISC-V instruction set architecture
> > -      supported by the hart.  These are documented in the RISC-V
> > -      User-Level ISA document, available from
> > -      https://riscv.org/specifications/
> > -
> > -      Due to revisions of the ISA specification, some deviations
> > -      have arisen over time.
> > -      Notably, riscv,isa was defined prior to the creation of the
> > -      Zicsr and Zifencei extensions and thus "i" implies
> > -      "zicsr_zifencei".
> > -
> > -      While the isa strings in ISA specification are case
> > -      insensitive, letters in the riscv,isa string must be all
> > -      lowercase to simplify parsing.
> > -    $ref: "/schemas/types.yaml#/definitions/string"
> > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(=
?:_[hsxz](?:[a-z])+)*$
> > -
> >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
> >    timebase-frequency: false
> > =20
> > @@ -133,8 +117,13 @@ properties:
> >        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >        in the system.
> > =20
> > +oneOf:
> > +  - required:
> > +      - riscv,isa
>=20
> This is the part Anup keeps reminding me about. We can create better ways
> to handle extensions in DT and ACPI, but we'll still need to parse ISA
> strings to handle legacy DTs and holdouts that keep creating ISA strings,
> at least during the deprecation period,

Yeah, we cannot remove the string parser from the kernel as we will
break existing users.
I don't see keeping it as a problem, we should be nice to people rather
than intentionally trip them up. Let them trip themselves up when their
implicit meaning doesn't match whatever bit of software they are
running's.

> since ISA strings are still "the
> way to do it" according to the spec.

I am not sure what this means, dt-bindings determine the DT ABI, not
what RVI puts in specs.

> Also, if we assume the wording in the spec does get shored up, then,
> unless I'm missing something, the list of advantages for this boolean
> proposal from your commit message would be

Well, shored up _AND_ adhered to. Actions speak far, far louder than
words in that respect unfortunately!

> * More character choices for name -- probably not a huge gain for ratified
>   extensions, since the boolean properties will likely still use the same
>   name as the ISA string (riscv,isa-extension-<name>). But, for vendor
>   extensions, this is indeed a major improvement, since vendor extension
>   boolean property names may need to be extended in unambiguous ways to
>   handle changes in the extension.
>=20
> * Simpler, more complete DT validation (but we still need a best effort
>   for legacy ISA strings)

The "best effort" validation via dt-bindings is the current regex. I've
intentionally marked it deprecated, rather than delete it partly for
that reason & partly out of consideration for other users.

> * Simpler DT parsing (but we still need the current parser for legacy ISA
>   strings)

Speaking only about Linux, we can use these meanings here for interpreting
the strings and then apply the fixups that correspond to the difference
between the defined meanings & those at the time of the dt-binding
originally being merged - unconditionally setting zifencei, zicsr, zicntr,
etc. If you don't implement those things, then expect to fall over.
Other operating systems etc may have different implicit meanings and
their own decisions to make!
Oh, and if the "foo" bit of "riscv,isa-extension-foo" doesn't match what
you put in riscv,isa then you keep the pieces. For example, if a vendor
has a vendor extension Xconor where version 1.0.1 is incompatible with
v1.0.0, the properties may be "riscv,isa-extension-xconor" and
"riscv,isa-extension-xconor-no-insnx". In that case, for Linux, I would
assert that there should/would be no way to get the later version of
that extension via riscv,isa.
There are no existing situations like this, so no backwards
compatibility is broken here. If/when it happens, the property is
deprecated and we can direct such cases to the new interface :)
Basically the same as:
https://lore.kernel.org/linux-riscv/20230504-oncoming-antihero-1ed69bb8f57d=
@spud/

	That reminds me, I need to re-spin that with more extensions set
	unconditionally.

If some new OS comes along, they don't need to implement riscv,isa at
all as it's deprecated.

I'd like to add another one:
* Unified meaning of extensions across bits of software. I actually have
  no idea what versions of things other OSes map the characters to.

> > diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/=
Documentation/devicetree/bindings/riscv/extensions.yaml
> > new file mode 100644
> > index 000000000000..1b4d726f7174
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> > @@ -0,0 +1,259 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/extensions.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V ISA extensions
> > +
> > +maintainers:
> > +  - Paul Walmsley <paul.walmsley@sifive.com>
> > +  - Palmer Dabbelt <palmer@sifive.com>
> > +  - Conor Dooley <conor@kernel.org>
> > +
> > +description: |
> > +  RISC-V has large number of extensions, some of which "standard" exte=
nsions,
>                ^ a                                       ^ are
>=20
> > +  meaning they are ratified by RISC-V International, and others are "v=
endor"
> > +  extensions.  This document defines properties that indicate whether =
a hart
> > +  supports a given extensions.
>=20
> drop 'a' or depluralize 'extensions'
>=20
> > +
> > +  Once a standard extension has been ratified, no features can be adde=
d or
>=20
> I'd change 'features' to 'changes in behavior', and then...
>=20
> > +  removed without the creation of a new extension for that sub- or sup=
er-set.
>=20
> ...drop 'for that sub- or super-set'
>=20
> > +  The properties for standard extensions therefore map to their origin=
ally
> > +  ratified states, with the exception of the I, Zicntr & Zihpm extensi=
ons.
>=20
> Can you elaborate on the exceptions? Or, if the exceptions are described
> below, maybe a '(see below)' here would help ease the reader's
> insecurities about their lack of knowledge about these exceptions, as
> they'll see that the education is coming :-)

Ah crap, I meant to note in the I section that timers were moved to
their own home. Since we are defining this stuff now, I felt that it'd
make sense to define riscv,isa-extension-i as meaning the ratified spec,
sans the counters.

> > +  riscv,isa-extension-f:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for single-precision floating point, as
>                       ^ F

Whoops. All of these are me realising this morning, after checking
everything a few times last night, that there was a dt_binding_check
complaint which prevented me implementing non-patterns as
patternProperties. As a result, I split everything back out into single
properties. It's always the last minute bits...

I could have had a mix of properties and pattern properties, but I
preferred to keep the ordering as something that people could more
easily use to locate properties.

> > +      20191213 version of the unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-v:
> > +    type: boolean
> > +    description:
> > +      The standard V extension for vector operations, as ratified in-a=
nd-around
> > +      commit 7a6c8ae ("Fix text that describes vfmv.v.f encoding") of =
the
> > +      riscv-v-spec.
> > +
> > +  riscv,isa-extension-h:
> > +    type: boolean
> > +    description:
> > +      The standard h extension for hypervisors as ratified in the 2019=
1213
>                       ^ H (might as well keep the case consistent)
>=20
> > +      version of the privileged ISA specification.
> > +
> > +  # Additional Standard Extensions, sorted by category then alphabetic=
ally
>=20
> Can we just do pure alphabetically? And the single-letter extensions above
> don't have a "sorted by" comment above them. I guess they need one, or
> maybe they can also be alphabetical?

I don't really have a preference for ordering. I'm happy to do pure
alphabetical.

> > +  riscv,isa-extension-zicboz:
> > +    type: boolean
> > +    description:
> > +      The standard  Zicbomz extension for cache-block zeroing as ratif=
ied in
>                      ^ ^Zicboz
>                      ^ extra space
>=20
> (The repetition is making my vision blur, so I'm feeling like I should
> write a script to compare $a and $b, where $a is riscv,isa-extension-$a
> and $b is 'The standard $b' to make sure they match :-) But I probably
> won't...

Again, same excuse! Silly me and all that.

> I'll take your word for it on the versions/dates/commit hashes referenced,
> at least until we get closer to actually merging this.

Aye & I am hoping that by the time that this could actually be
considered for merging that perhaps some of the items will migrate to
the riscv-isa-manual, instead of being flung to the four winds.

Thanks,
Conor.

--RruE147I17+bCjXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGYI6AAKCRB4tDGHoIJi
0gxgAP4kRyDG+G2i5on5GPEELH9BcCre8agCOjmib4rv7ZW4UwEAhcmBRsFClMo5
CixO0bNxyQgkd2rLb8MvtVn5FivN3gA=
=01SI
-----END PGP SIGNATURE-----

--RruE147I17+bCjXc--
