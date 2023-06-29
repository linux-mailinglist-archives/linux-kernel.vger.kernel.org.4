Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083C74209A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjF2GqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF2GpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:45:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4449E3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:41:26 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57045429f76so3121537b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1688020885; x=1690612885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKnLINTzxB96KsBJdntWN6ao7sSjSfWcCe9u0ZZxeis=;
        b=DrLpbjIH/Hporfq5RtgUrzWAiOw8d7aAgOchhbPvkeazhx8ICvAe4RoGGE+WAsFqXK
         c4kxBCHyB64a03fTdiav5b1hMwMCXZ/8yqDV9Me36UvPcn0kG+sZvk7AvTem3DCmhXI/
         9EZLYqXc0IZAkejQXAvcp53S8yoGyUgWW7puLz8kkkXke/vx3xNre4NNDHyXi+/JcRTF
         qF723CLBMfTiFjOtUMMe2TfXE6l8rN3HOiXssLTbkFDi0B4TzIIoblzNFupV27tsXsD1
         o1xUChnVUVhgGlVqsfhIsIdE6sCXmTh97ieUqG9R7aempH7EWd9uu8tNftK2YINSJpwl
         CqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688020885; x=1690612885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKnLINTzxB96KsBJdntWN6ao7sSjSfWcCe9u0ZZxeis=;
        b=iNbu7mTpaxsEFmmprntJJDOrGuIywkn1lOK+7utRRsU6UuLR7r57jFUwFXTnG2EdY9
         l6NiYgIFK1TPXCyXQzy1TFPGucMnxOBqq2ezN9g/N1OLjyro1GzcyVW1y6ChS0Tm+Kss
         NfTQ973pmSuDm5Z+KUORZAf5eqNudtQVxiI96UPztmmfnCnpnh0vgADOzCYY7xjZaD/S
         hxSxCk0NngSNS0XjT+mx1xEO+usclMuGTr6LU555Z3+vy9s7xzzlOs1/abpilcLSaECY
         Y/tfzHviyHSir38EY5r3e0QWR3dWeLrr7wKd1hzhfmYI+t6j9pmXEIf2iGkv1iybrE62
         iKaQ==
X-Gm-Message-State: AC+VfDyChnNfGkzg1rI9mfbGwBQcNhR5brSf3xkpGLzoe8DN34DtmAC5
        VxoTPlgSx84H020S71fj+GR8P0EGzXJY6uprjpFhdw==
X-Google-Smtp-Source: ACHHUZ6iOyD8Fy4vYCRD3FUf5OCKu3Ed6Zz0Ao91vtTluXDb8woXIFvNLxgnmPEXH2xQXBQTY4KALeXjRaIsdfJ92To=
X-Received: by 2002:a0d:dfcb:0:b0:570:89bf:6f10 with SMTP id
 i194-20020a0ddfcb000000b0057089bf6f10mr31006541ywe.25.1688020885399; Wed, 28
 Jun 2023 23:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK9=C2Vy-4V9kgnga98tiC3TeHkR2LFPakyBbS8s_h3_Z=ieyQ@mail.gmail.com>
 <mhng-092e2e51-5856-41be-b5a5-919694d8da03@palmer-ri-x1c9>
In-Reply-To: <mhng-092e2e51-5856-41be-b5a5-919694d8da03@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 29 Jun 2023 12:11:14 +0530
Message-ID: <CAK9=C2XBQ8j1x0iq1tM9c_BVv-JNeECafGRWBn+iuwvKwKw2SQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: deprecate riscv,isa
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        ajones@ventanamicro.com, atishp@atishpatra.org, jrtc27@jrtc27.com,
        rick@andestech.com, ycliang@andestech.com,
        oleksii.kurochko@gmail.com, linux-riscv@lists.infradead.org,
        qemu-riscv@nongnu.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 8:49=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Wed, 28 Jun 2023 08:31:32 PDT (-0700), apatel@ventanamicro.com wrote:
> > On Wed, Jun 28, 2023 at 7:46=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.=
com> wrote:
> >>
> >> On Tue, 27 Jun 2023 08:49:06 PDT (-0700), Palmer Dabbelt wrote:
> >> > On Mon, 26 Jun 2023 23:52:06 PDT (-0700), apatel@ventanamicro.com wr=
ote:
> >> >> On Tue, Jun 27, 2023 at 1:23=E2=80=AFAM Palmer Dabbelt <palmer@rivo=
sinc.com> wrote:
> >> >>>
> >> >>> On Mon, 26 Jun 2023 10:38:43 PDT (-0700), apatel@ventanamicro.com =
wrote:
> >> >>> > On Mon, Jun 26, 2023 at 3:42=E2=80=AFPM Conor Dooley <conor.dool=
ey@microchip.com> wrote:
> >> >>> >>
> >> >>> >> intro
> >> >>> >> =3D=3D=3D=3D=3D
> >> >>> >>
> >> >>> >> When the RISC-V dt-bindings were accepted upstream in Linux, th=
e base
> >> >>> >> ISA etc had yet to be ratified. By the ratification of the base=
 ISA,
> >> >>> >> incompatible changes had snuck into the specifications - for ex=
ample the
> >> >>> >> Zicsr and Zifencei extensions were spun out of the base ISA.
> >> >>> >>
> >> >>> >> Fast forward to today, and the reason for this patch.
> >> >>> >> Currently the riscv,isa dt property permits only a specific sub=
set of
> >> >>> >> the ISA string - in particular it excludes version numbering.
> >> >>> >> With the current constraints, it is not possible to discern whe=
ther
> >> >>> >> "rv64i" means that the hart supports the fence.i instruction, f=
or
> >> >>> >> example.
> >> >>> >> Future systems may choose to implement their own instruction fe=
ncing,
> >> >>> >> perhaps using a vendor extension, or they may not implement the=
 optional
> >> >>> >> counter extensions. Software needs a way to determine this.
> >> >>> >>
> >> >>> >> versioning schemes
> >> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>> >>
> >> >>> >> "Use the extension versions that are described in the ISA manua=
l" you
> >> >>> >> may say, and it's not like this has not been considered.
> >> >>> >> Firstly, software that parses the riscv,isa property at runtime=
 will
> >> >>> >> need to contain a lookup table of some sort that maps arbitrary=
 versions
> >> >>> >> to versions it understands. There is not a consistent applicati=
on of
> >> >>> >> version number applied to extensions, with a higgledy-piggledy
> >> >>> >> collection of tags, "bare" and versioned documents awaiting the=
 reader
> >> >>> >> on the "recently ratified extensions" page:
> >> >>> >> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extension=
s
> >> >>> >>
> >> >>> >>         As an aside, and this is reflected in the patch too, si=
nce many
> >> >>> >>         extensions have yet to appear in a release of the ISA s=
pecs,
> >> >>> >>         they are defined by commits in their respective "workin=
g draft"
> >> >>> >>         repositories.
> >> >>> >>
> >> >>> >> Secondly, there is an issue of backwards compatibility, whereby=
 allowing
> >> >>> >> numbers in the ISA string, some parsers may be broken. This wou=
ld
> >> >>> >> require an additional property to be created to even use the ve=
rsions in
> >> >>> >> this manner.
> >> >>> >>
> >> >>> >> ~boolean properties~ string array property
> >> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>> >>
> >> >>> >> If a new property is needed, the whole approach may as well be =
looked at
> >> >>> >> from the bottom up. A string with limited character choices etc=
 is
> >> >>> >> hardly the best approach for communicating extension informatio=
n to
> >> >>> >> software.
> >> >>> >>
> >> >>> >> Switching to using properties that are defined on a per extensi=
on basis,
> >> >>> >> allows us to define explicit meanings for the DT representation=
 of each
> >> >>> >> extension - rather than the current situation where different o=
perating
> >> >>> >> systems or other bits of software may impart different meanings=
 to
> >> >>> >> characters in the string.
> >> >>> >> Clearly the best source of meanings is the specifications thems=
elves,
> >> >>> >> this just provides us the ability to choose at what point in ti=
me the
> >> >>> >> meaning is set. If an extension changes incompatibility in the =
future,
> >> >>> >> a new property will be required.
> >> >>> >>
> >> >>> >> Off-list, some of the RVI folks have committed to shoring up th=
e wording
> >> >>> >> in either the ISA specifications, the riscv-isa-manual or
> >> >>> >> so that in the future, modifications to and additions or remova=
ls of
> >> >>> >> features will require a new extension. Codifying that assertion
> >> >>> >> somewhere would make it quite unlikely that compatibility would=
 be
> >> >>> >> broken, but we have the tools required to deal with it, if & wh=
en it
> >> >>> >> crops up.
> >> >>> >> It is in our collective interest, as consumers of extension mea=
nings, to
> >> >>> >> define a scheme that enforces compatibility.
> >> >>> >>
> >> >>> >> The use of individual properties, rather than elements in a sin=
gle
> >> >>> >> string, will also permit validation that the properties have a =
meaning,
> >> >>> >> as well as potentially reject mutually exclusive combinations, =
or
> >> >>> >> enforce dependencies between extensions. That would not have be=
 possible
> >> >>> >> with the current dt-schema infrastructure for arbitrary strings=
, as we
> >> >>> >> would need to add a riscv,isa parser to dt-validate!
> >> >>> >> That's not implemented in this patch, but rather left as future=
 work (for
> >> >>> >> the brave, or the foolish).
> >> >>> >>
> >> >>> >> acpi
> >> >>> >> =3D=3D=3D=3D
> >> >>> >>
> >> >>> >> The current ACPI ECR is based on having a single ISA string unf=
ortunately,
> >> >>> >> but ideally ACPI will move to another method, perhaps GUIDs, th=
at give
> >> >>> >> explicit meaning to extensions.
> >> >>> >
> >> >>> > Drop this paragraph on ACPI.
> >> >>> >
> >> >>> > We clearly mentioned previously that ACPI will follow specs defi=
ned by RVI.
> >> >>> > There are scalability issues in using GUIDs for each ISA extensi=
on.
> >> >>>
> >> >>> Which spec are we following for the ACPI ISA string?
> >> >>
> >> >> ACPI RHCT follows the "ISA Extension Naming Conventions"
> >> >> defined by the RISC-V unpriv spec. I understand that there are
> >> >> unresolved issues in the "ISA Extension Naming Conventions"
> >> >> which should be addressed by RVI and we should also try our
> >> >> best to have this fixed in the spec.
> >> >
> >> > Which version of the spec?  We've had a ton of issues related to
> >> > versioning everywhere else the ISA string has been used, we need to =
know
> >> > specifically which version we're parsing in order to do anything
> >> > meaningful with it.
> >>
> >> Anup: Can you please provide a pointer to the spec this is supposed to
> >> implement?  I don't want to end up in the same spot again where we're
> >> presuming some spec changes, we've got to support whatever we merge no
> >> matter what happens on the spec side.
> >>
> >> In theory I'm on vacation today, but I'll try and look at the thread
> >> again tonight when I get back.
> >
> > It is the "Chapter 29. ISA Extension Naming Conventions" of the
> > RISC-V unpriv specification.
> > (https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-=
release-1239329-2023-05-23/unpriv-isa-asciidoc.pdf)
> >
> > The RISC-V unpriv specification is only a collection of extensions
> > hence it does not have its own version.
>
> There's a version right on the front page, it says "Version ASCIIDOC
> Conversion, 12/2022".  There's a few with that version, but versioning
> is pretty broken in RISC-V land so we've mostly just started running
> with the commits/tags.
>
> It also says it's a pre release version, but if that's what ACPI is
> using then I'm fine with it -- the key is that whatever we're supporting
> we're stuck with, as we have to maintain compatibility here.
>
> > We should work with RVI to address the concerns/clarifications
> > that we need in "Chapter 29. ISA Extension Naming Conventions".
> >
> > We can also create GitHub issues for unpriv spec if that helps.
>
> The nice thing about starting with a new interface is that there's
> nothing to be compatible with, so there's no issues.  Given what a mess
> ISA strings have been everywhere else I'm sure we'll have some, but
> that's problem for later.
>
> I couldn't find anywhere else this was written down, so I started an
> ACPI doc -- as usual maybe a bit odd for just the one thing, but we
> usually end up with more.
>
> https://lore.kernel.org/r/20230629031705.15575-1-palmer@rivosinc.com/

The "ISA string node structure" does mention that "ISA string" is
"Null-terminated ASCII Instruction Set Architecture (ISA) string for this
hart. The format of the ISA string is defined in the RISC-V unprivileged
specification."
(Refer, page6 of
https://docs.google.com/document/d/1zSw9eaW3tlrdGxkclo9FsLvYxUvhAjRCR8_71Ef=
RJR4/edit?usp=3Dsharing)

Currently, the ACPI spec does not mention the exact version of the
"ISA string" chapter in the RISC-V unprivileged specification which
can be improved.

Also, there is a 2-byte "revision" field in the "ISA string node structure"
which can be used in the future to specify a different version of the
"ISA string" chapter.

Regards,
Anup

>
>
> > Regards,
> > Anup
> >
> >>
> >> >> In any case, ACPI spec is owned by UEFI forum so it does
> >> >> not make sense to define/recommend anything for ACPI in
> >> >> DT bindings.
> >> >
> >> > Unless I missed something this is just a long commit message, it's n=
ot
> >> > even in the docs.  If you don't want the DT side to even mention ACP=
I
> >> > that's fine with me, though, I don't really care.
> >> >
> >> >>
> >> >> Regards,
> >> >> Anup
> >> >>
> >> >>
> >> >>
> >> >>>
> >> >>> > Regards,
> >> >>> > Anup
> >> >>> >
> >> >>> >>
> >> >>> >> parser simplicity
> >> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>> >>
> >> >>> >> Many systems that parse DT at runtime already implement an func=
tion that
> >> >>> >> can check for the presence of a string in an array of string, a=
s it is
> >> >>> >> similar to the process for parsing a list of compatible strings=
, so a
> >> >>> >> bunch of new, custom, DT parsing should not be needed.
> >> >>> >> Getting rid of "riscv,isa" parsing would be a nice simplificati=
on, but
> >> >>> >> unfortunately for backwards compatibility with old dtbs, existi=
ng
> >> >>> >> parsers may not be removable - which may greatly simplify
> >> >>> >> dt parsing code. In Linux, for example, checking for whether a =
hart
> >> >>> >> supports an extension becomes as simple as:
> >> >>> >>         of_property_match_string(node, "riscv,isa-extensions", =
"zicbom")
> >> >>> >>
> >> >>> >> vendor extensions
> >> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >>> >>
> >> >>> >> Compared to riscv,isa, this proposed scheme promotes vendor ext=
ensions,
> >> >>> >> oft touted as the strength of RISC-V, to first-class citizens.
> >> >>> >> At present, extensions are defined as meaning what the RISC-V I=
SA
> >> >>> >> specifications say they do. There is no realistic way of using =
that
> >> >>> >> interface to provide cross-platform definitions for what vendor
> >> >>> >> extensions mean. Vendor extensions may also have even less cons=
istency
> >> >>> >> than RVI do in terms of versioning, or no care about backwards
> >> >>> >> compatibility.
> >> >>> >> The new property allows us to assign explicit meanings on a per=
 vendor
> >> >>> >> extension basis, backed up by a description of their meanings.
> >> >>> >>
> >> >>> >> fin
> >> >>> >> =3D=3D=3D
> >> >>> >>
> >> >>> >> Create a new file to store the extension meanings and a new
> >> >>> >> riscv,isa-base property to replace the aspect of riscv,isa that=
 is
> >> >>> >> not represented by the new property - the base ISA implemented =
by a hart.
> >> >>> >>
> >> >>> >> As a starting point, add properties for extensions currently us=
ed in
> >> >>> >> Linux.
> >> >>> >>
> >> >>> >> Finally, mark riscv,isa as deprecated, as removing support for =
it in
> >> >>> >> existing programs would be an ABI break.
> >> >>> >>
> >> >>> >> CC: Palmer Dabbelt <palmer@dabbelt.com>
> >> >>> >> CC: Paul Walmsley <paul.walmsley@sifive.com>
> >> >>> >> CC: Rob Herring <robh+dt@kernel.org>
> >> >>> >> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >> >>> >> CC: Alistair Francis <alistair.francis@wdc.com>
> >> >>> >> CC: Andrew Jones <ajones@ventanamicro.com>
> >> >>> >> CC: Anup Patel <apatel@ventanamicro.com>
> >> >>> >> CC: Atish Patra <atishp@atishpatra.org>
> >> >>> >> CC: Jessica Clarke <jrtc27@jrtc27.com>
> >> >>> >> CC: Rick Chen <rick@andestech.com>
> >> >>> >> CC: Leo <ycliang@andestech.com>
> >> >>> >> CC: Oleksii <oleksii.kurochko@gmail.com>
> >> >>> >> CC: linux-riscv@lists.infradead.org
> >> >>> >> CC: qemu-riscv@nongnu.org
> >> >>> >> CC: u-boot@lists.denx.de
> >> >>> >> CC: devicetree@vger.kernel.org
> >> >>> >> CC: linux-kernel@vger.kernel.org
> >> >>> >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> >>> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> >>> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> >>> >> ---
> >> >>> >> Changes in v3:
> >> >>> >> - Per Rob's suggestion, switch to an array of strings. Cuts dow=
n on the
> >> >>> >>   size, compared to booleans. It has a standard mechanism for p=
arsing
> >> >>> >>   (you need to parse arrays of strings for compatibles). It sti=
ll allows
> >> >>> >>   for having a limited set of explicitly defined properties - s=
o the
> >> >>> >>   advantages over a free-form string still apply.
> >> >>> >> - Pick up Palmer's Ack and Review (although I expect that he wi=
ll be the
> >> >>> >>   one to apply this).
> >> >>> >> ---
> >> >>> >>  .../devicetree/bindings/riscv/cpus.yaml       |  43 ++-
> >> >>> >>  .../devicetree/bindings/riscv/extensions.yaml | 245 ++++++++++=
++++++++
> >> >>> >>  2 files changed, 265 insertions(+), 23 deletions(-)
> >> >>> >>  create mode 100644 Documentation/devicetree/bindings/riscv/ext=
ensions.yaml
> >> >>> >>
> >> >>> >> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml =
b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >> >>> >> index 67bd239ead0b..74bc92591086 100644
> >> >>> >> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >> >>> >> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >> >>> >> @@ -25,6 +25,7 @@ description: |
> >> >>> >>
> >> >>> >>  allOf:
> >> >>> >>    - $ref: /schemas/cpu.yaml#
> >> >>> >> +  - $ref: extensions.yaml
> >> >>> >>
> >> >>> >>  properties:
> >> >>> >>    compatible:
> >> >>> >> @@ -82,25 +83,6 @@ properties:
> >> >>> >>      description:
> >> >>> >>        The blocksize in bytes for the Zicboz cache operations.
> >> >>> >>
> >> >>> >> -  riscv,isa:
> >> >>> >> -    description:
> >> >>> >> -      Identifies the specific RISC-V instruction set architect=
ure
> >> >>> >> -      supported by the hart.  These are documented in the RISC=
-V
> >> >>> >> -      User-Level ISA document, available from
> >> >>> >> -      https://riscv.org/specifications/
> >> >>> >> -
> >> >>> >> -      Due to revisions of the ISA specification, some deviatio=
ns
> >> >>> >> -      have arisen over time.
> >> >>> >> -      Notably, riscv,isa was defined prior to the creation of =
the
> >> >>> >> -      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i=
"
> >> >>> >> -      implies "zicntr_zicsr_zifencei_zihpm".
> >> >>> >> -
> >> >>> >> -      While the isa strings in ISA specification are case
> >> >>> >> -      insensitive, letters in the riscv,isa string must be all
> >> >>> >> -      lowercase.
> >> >>> >> -    $ref: /schemas/types.yaml#/definitions/string
> >> >>> >> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a=
-z])+)?(?:_[hsxz](?:[a-z])+)*$
> >> >>> >> -
> >> >>> >>    # RISC-V has multiple properties for cache op block sizes as=
 the sizes
> >> >>> >>    # differ between individual CBO extensions
> >> >>> >>    cache-op-block-size: false
> >> >>> >> @@ -139,8 +121,17 @@ properties:
> >> >>> >>        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >> >>> >>        in the system.
> >> >>> >>
> >> >>> >> +oneOf:
> >> >>> >> +  - required:
> >> >>> >> +      - riscv,isa
> >> >>> >> +  - required:
> >> >>> >> +      - riscv,isa-base
> >> >>> >> +
> >> >>> >> +dependencies:
> >> >>> >> +  riscv,isa-base: [ "riscv,isa-extensions" ]
> >> >>> >> +  riscv,isa-extensions: [ "riscv,isa-base" ]
> >> >>> >> +
> >> >>> >>  required:
> >> >>> >> -  - riscv,isa
> >> >>> >>    - interrupt-controller
> >> >>> >>
> >> >>> >>  unevaluatedProperties: false
> >> >>> >> @@ -160,7 +151,9 @@ examples:
> >> >>> >>                  i-cache-sets =3D <128>;
> >> >>> >>                  i-cache-size =3D <16384>;
> >> >>> >>                  reg =3D <0>;
> >> >>> >> -                riscv,isa =3D "rv64imac";
> >> >>> >> +                riscv,isa-base =3D "rv64i";
> >> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "c";
> >> >>> >> +
> >> >>> >>                  cpu_intc0: interrupt-controller {
> >> >>> >>                          #interrupt-cells =3D <1>;
> >> >>> >>                          compatible =3D "riscv,cpu-intc";
> >> >>> >> @@ -183,8 +176,10 @@ examples:
> >> >>> >>                  i-tlb-size =3D <32>;
> >> >>> >>                  mmu-type =3D "riscv,sv39";
> >> >>> >>                  reg =3D <1>;
> >> >>> >> -                riscv,isa =3D "rv64imafdc";
> >> >>> >>                  tlb-split;
> >> >>> >> +                riscv,isa-base =3D "rv64i";
> >> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "=
d", "c";
> >> >>> >> +
> >> >>> >>                  cpu_intc1: interrupt-controller {
> >> >>> >>                          #interrupt-cells =3D <1>;
> >> >>> >>                          compatible =3D "riscv,cpu-intc";
> >> >>> >> @@ -202,8 +197,10 @@ examples:
> >> >>> >>                  device_type =3D "cpu";
> >> >>> >>                  reg =3D <0>;
> >> >>> >>                  compatible =3D "riscv";
> >> >>> >> -                riscv,isa =3D "rv64imafdc";
> >> >>> >>                  mmu-type =3D "riscv,sv48";
> >> >>> >> +                riscv,isa-base =3D "rv64i";
> >> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "=
d", "c";
> >> >>> >> +
> >> >>> >>                  interrupt-controller {
> >> >>> >>                          #interrupt-cells =3D <1>;
> >> >>> >>                          interrupt-controller;
> >> >>> >> diff --git a/Documentation/devicetree/bindings/riscv/extensions=
.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >> >>> >> new file mode 100644
> >> >>> >> index 000000000000..af98307f2c2c
> >> >>> >> --- /dev/null
> >> >>> >> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >> >>> >> @@ -0,0 +1,245 @@
> >> >>> >> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> >>> >> +%YAML 1.2
> >> >>> >> +---
> >> >>> >> +$id: http://devicetree.org/schemas/riscv/extensions.yaml#
> >> >>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> >>> >> +
> >> >>> >> +title: RISC-V ISA extensions
> >> >>> >> +
> >> >>> >> +maintainers:
> >> >>> >> +  - Paul Walmsley <paul.walmsley@sifive.com>
> >> >>> >> +  - Palmer Dabbelt <palmer@sifive.com>
> >> >>> >> +  - Conor Dooley <conor@kernel.org>
> >> >>> >> +
> >> >>> >> +description: |
> >> >>> >> +  RISC-V has a large number of extensions, some of which are "=
standard"
> >> >>> >> +  extensions, meaning they are ratified by RISC-V Internationa=
l, and others
> >> >>> >> +  are "vendor" extensions.
> >> >>> >> +  This document defines properties that indicate whether a har=
t supports a
> >> >>> >> +  given extension.
> >> >>> >> +
> >> >>> >> +  Once a standard extension has been ratified, no changes in b=
ehaviour can be
> >> >>> >> +  made without the creation of a new extension.
> >> >>> >> +  The properties for standard extensions therefore map to thei=
r originally
> >> >>> >> +  ratified states, with the exception of the I, Zicntr & Zihpm=
 extensions.
> >> >>> >> +  See the "i" property for more information.
> >> >>> >> +
> >> >>> >> +select:
> >> >>> >> +  properties:
> >> >>> >> +    compatible:
> >> >>> >> +      contains:
> >> >>> >> +        const: riscv
> >> >>> >> +
> >> >>> >> +properties:
> >> >>> >> +  riscv,isa:
> >> >>> >> +    description:
> >> >>> >> +      Identifies the specific RISC-V instruction set architect=
ure
> >> >>> >> +      supported by the hart.  These are documented in the RISC=
-V
> >> >>> >> +      User-Level ISA document, available from
> >> >>> >> +      https://riscv.org/specifications/
> >> >>> >> +
> >> >>> >> +      Due to revisions of the ISA specification, some deviatio=
ns
> >> >>> >> +      have arisen over time.
> >> >>> >> +      Notably, riscv,isa was defined prior to the creation of =
the
> >> >>> >> +      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i=
"
> >> >>> >> +      implies "zicntr_zicsr_zifencei_zihpm".
> >> >>> >> +
> >> >>> >> +      While the isa strings in ISA specification are case
> >> >>> >> +      insensitive, letters in the riscv,isa string must be all
> >> >>> >> +      lowercase.
> >> >>> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> >>> >> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a=
-z])+)?(?:_[hsxz](?:[a-z])+)*$
> >> >>> >> +    deprecated: true
> >> >>> >> +
> >> >>> >> +  riscv,isa-base:
> >> >>> >> +    description:
> >> >>> >> +      The base ISA implemented by this hart, as described by t=
he 20191213
> >> >>> >> +      version of the unprivileged ISA specification.
> >> >>> >> +    enum:
> >> >>> >> +      - rv32i
> >> >>> >> +      - rv64i
> >> >>> >> +
> >> >>> >> +  riscv,isa-extensions:
> >> >>> >> +    $ref: /schemas/types.yaml#/definitions/string-array
> >> >>> >> +    minItems: 1
> >> >>> >> +    description: Extensions supported by the hart.
> >> >>> >> +    items:
> >> >>> >> +      anyOf:
> >> >>> >> +        # single letter extensions, in canonical order
> >> >>> >> +        - const: i
> >> >>> >> +          description: |
> >> >>> >> +            The base integer instruction set, as ratified in t=
he 20191213
> >> >>> >> +            version of the unprivileged ISA specification, wit=
h the exception of
> >> >>> >> +            counter access.
> >> >>> >> +            Counter access was removed after the ratification =
of the 20191213
> >> >>> >> +            version of the unprivileged specification and shun=
ted into the
> >> >>> >> +            Zicntr and Zihpm extensions.
> >> >>> >> +
> >> >>> >> +        - const: m
> >> >>> >> +          description:
> >> >>> >> +            The standard M extension for integer multiplicatio=
n and division, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: a
> >> >>> >> +          description:
> >> >>> >> +            The standard A extension for atomic instructions, =
as ratified in the
> >> >>> >> +            20191213 version of the unprivileged ISA specifica=
tion.
> >> >>> >> +
> >> >>> >> +        - const: f
> >> >>> >> +          description:
> >> >>> >> +            The standard F extension for single-precision floa=
ting point, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: d
> >> >>> >> +          description:
> >> >>> >> +            The standard D extension for double-precision floa=
ting-point, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: q
> >> >>> >> +          description:
> >> >>> >> +            The standard Q extension for quad-precision floati=
ng-point, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: c
> >> >>> >> +          description:
> >> >>> >> +            The standard C extension for compressed instructio=
ns, as ratified in
> >> >>> >> +            the 20191213 version of the unprivileged ISA speci=
fication.
> >> >>> >> +
> >> >>> >> +        - const: v
> >> >>> >> +          description:
> >> >>> >> +            The standard V extension for vector operations, as=
 ratified
> >> >>> >> +            in-and-around commit 7a6c8ae ("Fix text that descr=
ibes vfmv.v.f
> >> >>> >> +            encoding") of the riscv-v-spec.
> >> >>> >> +
> >> >>> >> +        - const: h
> >> >>> >> +          description:
> >> >>> >> +            The standard H extension for hypervisors as ratifi=
ed in the 20191213
> >> >>> >> +            version of the privileged ISA specification.
> >> >>> >> +
> >> >>> >> +        # multi-letter extensions, sorted alphanumerically
> >> >>> >> +        - const: smaia
> >> >>> >> +          description: |
> >> >>> >> +            The standard Smaia supervisor-level extension for =
the advanced
> >> >>> >> +            interrupt architecture for machine-mode-visible cs=
r and behavioural
> >> >>> >> +            changes to interrupts as frozen at commit ccbddab =
("Merge pull
> >> >>> >> +            request #42 from riscv/jhauser-2023-RC4") of riscv=
-aia.
> >> >>> >> +
> >> >>> >> +        - const: ssaia
> >> >>> >> +          description: |
> >> >>> >> +            The standard Ssaia supervisor-level extension for =
the advanced
> >> >>> >> +            interrupt architecture for supervisor-mode-visible=
 csr and
> >> >>> >> +            behavioural changes to interrupts as frozen at com=
mit ccbddab
> >> >>> >> +            ("Merge pull request #42 from riscv/jhauser-2023-R=
C4") of riscv-aia.
> >> >>> >> +
> >> >>> >> +        - const: sscofpmf
> >> >>> >> +          description: |
> >> >>> >> +            The standard Sscofpmf supervisor-level extension f=
or count overflow
> >> >>> >> +            and mode-based filtering as ratified at commit 01d=
1df0 ("Add ability
> >> >>> >> +            to manually trigger workflow. (#2)") of riscv-coun=
t-overflow.
> >> >>> >> +
> >> >>> >> +        - const: sstc
> >> >>> >> +          description: |
> >> >>> >> +            The standard Sstc supervisor-level extension for t=
ime compare as
> >> >>> >> +            ratified at commit 3f9ed34 ("Add ability to manual=
ly trigger
> >> >>> >> +            workflow. (#2)") of riscv-time-compare.
> >> >>> >> +
> >> >>> >> +        - const: svinval
> >> >>> >> +          description:
> >> >>> >> +            The standard Svinval supervisor-level extension fo=
r fine-grained
> >> >>> >> +            address-translation cache invalidation as ratified=
 in the 20191213
> >> >>> >> +            version of the privileged ISA specification.
> >> >>> >> +
> >> >>> >> +        - const: svnapot
> >> >>> >> +          description:
> >> >>> >> +            The standard Svnapot supervisor-level extensions f=
or napot
> >> >>> >> +            translation contiguity as ratified in the 20191213=
 version of the
> >> >>> >> +            privileged ISA specification.
> >> >>> >> +
> >> >>> >> +        - const: svpbmt
> >> >>> >> +          description:
> >> >>> >> +            The standard Svpbmt supervisor-level extensions fo=
r page-based
> >> >>> >> +            memory types as ratified in the 20191213 version o=
f the privileged
> >> >>> >> +            ISA specification.
> >> >>> >> +
> >> >>> >> +        - const: zba
> >> >>> >> +          description: |
> >> >>> >> +            The standard Zba bit-manipulation extension for ad=
dress generation
> >> >>> >> +            acceleration instructions as ratified at commit 6d=
33919 ("Merge pull
> >> >>> >> +            request #158 from hirooih/clmul-fix-loop-end-condi=
tion") of
> >> >>> >> +            riscv-bitmanip.
> >> >>> >> +
> >> >>> >> +        - const: zbb
> >> >>> >> +          description: |
> >> >>> >> +            The standard Zbb bit-manipulation extension for ba=
sic bit-manipulation
> >> >>> >> +            as ratified at commit 6d33919 ("Merge pull request=
 #158 from
> >> >>> >> +            hirooih/clmul-fix-loop-end-condition") of riscv-bi=
tmanip.
> >> >>> >> +
> >> >>> >> +        - const: zbc
> >> >>> >> +          description: |
> >> >>> >> +            The standard Zbc bit-manipulation extension for ca=
rry-less
> >> >>> >> +            multiplication as ratified at commit 6d33919 ("Mer=
ge pull request
> >> >>> >> +            #158 from hirooih/clmul-fix-loop-end-condition") o=
f riscv-bitmanip.
> >> >>> >> +
> >> >>> >> +        - const: zbs
> >> >>> >> +          description: |
> >> >>> >> +            The standard Zbs bit-manipulation extension for si=
ngle-bit
> >> >>> >> +            instructions as ratified at commit 6d33919 ("Merge=
 pull request #158
> >> >>> >> +            from hirooih/clmul-fix-loop-end-condition") of ris=
cv-bitmanip.
> >> >>> >> +
> >> >>> >> +        - const: zicbom
> >> >>> >> +          description:
> >> >>> >> +            The standard Zicbom extension for base cache manag=
ement operations as
> >> >>> >> +            ratified in commit 3dd606f ("Create cmobase-v1.0.p=
df") of riscv-CMOs.
> >> >>> >> +
> >> >>> >> +        - const: zicbop
> >> >>> >> +          description:
> >> >>> >> +            The standard Zicbop extension for cache-block pref=
etch instructions
> >> >>> >> +            as ratified in commit 3dd606f ("Create cmobase-v1.=
0.pdf") of
> >> >>> >> +            riscv-CMOs.
> >> >>> >> +
> >> >>> >> +        - const: zicboz
> >> >>> >> +          description:
> >> >>> >> +            The standard Zicboz extension for cache-block zero=
ing as ratified
> >> >>> >> +            in commit 3dd606f ("Create cmobase-v1.0.pdf") of r=
iscv-CMOs.
> >> >>> >> +
> >> >>> >> +        - const: zicntr
> >> >>> >> +          description:
> >> >>> >> +            The standard Zicntr extension for base counters an=
d timers, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: zicsr
> >> >>> >> +          description:
> >> >>> >> +            The standard Zicsr extension for control and statu=
s register
> >> >>> >> +            instructions, as ratified in the 20191213 version =
of the
> >> >>> >> +            unprivileged ISA specification.
> >> >>> >> +
> >> >>> >> +        - const: zifencei
> >> >>> >> +          description:
> >> >>> >> +            The standard Zifencei extension for instruction-fe=
tch fence, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: zihintpause
> >> >>> >> +          description:
> >> >>> >> +            The standard Zihintpause extension for pause hints=
, as ratified in
> >> >>> >> +            commit d8ab5c7 ("Zihintpause is ratified") of the =
riscv-isa-manual.
> >> >>> >> +
> >> >>> >> +        - const: zihpm
> >> >>> >> +          description:
> >> >>> >> +            The standard Zihpm extension for hardware performa=
nce counters, as
> >> >>> >> +            ratified in the 20191213 version of the unprivileg=
ed ISA
> >> >>> >> +            specification.
> >> >>> >> +
> >> >>> >> +        - const: ztso
> >> >>> >> +          description:
> >> >>> >> +            The standard Ztso extension for total store orderi=
ng, as ratified
> >> >>> >> +            in commit 2e5236 ("Ztso is now ratified.") of the
> >> >>> >> +            riscv-isa-manual.
> >> >>> >> +
> >> >>> >> +additionalProperties: true
> >> >>> >> +...
> >> >>> >> --
> >> >>> >> 2.40.1
> >> >>> >>
