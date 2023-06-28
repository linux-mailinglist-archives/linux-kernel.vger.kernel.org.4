Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9543574150D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjF1Pbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjF1Pbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:31:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12264268F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:31:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5769e6a6818so49568297b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 08:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687966304; x=1690558304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alA+9QzS9zH77sAl3VfJFAv0p+kwwajQRB5n/xPS5Qo=;
        b=crUFEwv8XCnBlJANlgtN+hjHTzv47vtJrDMI+8tdcpsCUhlR1Q8m8sprLUQTVbVhw6
         N9kh6nzDXRlkGOab2+/7npRNpa8gawcSPvP8wLHmuJv4ujVODjhAdi/veralZHof5SHm
         DSMKXLibtl1BNPm+5UbQRCSrvPGEKbVTCK2JUsjrbCNX7Q8/OjT1nn4ftMT97ArvEUaI
         DHceQAJeek55APTZ53zsqejCrUTnK2e/ZX4I7T+ynxjIS/YTsviLRR/HlQ8kfoPVa0HG
         KhyUeYsePZCtCLGgCjSQ+u0XNSKMQbOff3cjaiGPz4fQr5lAARGQyUjAR9ohGhHr3a48
         tvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687966304; x=1690558304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alA+9QzS9zH77sAl3VfJFAv0p+kwwajQRB5n/xPS5Qo=;
        b=UEUTlJ6shFyDp1/xkpBNTjwedHxsTM+viA4fsE9OzsZNS9Cm99O5G046EVKA+I4xx6
         dqkTlNPfOGnNIbz/HLphXVoYCYohHkKeinrTPBmiK7bWaHgTksSyYQ5u2Jns9RR+Bbhy
         Rix6ODQqujSDlHrcly2LpS+BjgL6CyJVtFT3YrZam0HD7LNyQUyYPvjAwFf8XLlP0FXU
         32TZYWCvdyo2i+SdrFdqQuzbqlBG7lrqVaEXlo69r+ewiXa+3CUe1ZeAboOkORm17Qn9
         7sOF3mGeg19is3RrmELCLpG+74sJcDBC8ZptkabTU4y/6S9nbBIglPDeyqu98xwGQB/g
         1RsQ==
X-Gm-Message-State: AC+VfDzVsZdHDxkiaGOYuIrJ0z5I5B6940trUWc0XG+34DOiWfoinHOI
        mSPa5iXKa4rjRo5VBhBKnf1OMSe0vfphkIIUkhrBrg==
X-Google-Smtp-Source: ACHHUZ4+ehEpupdw1d+J4V1m0aMiUclAUgPjVmRD48hAPqLDWipwVABvE/bWUFGQFKr3RwOlpf/xh9b6dxhDy4Jjrok=
X-Received: by 2002:a0d:c786:0:b0:570:8854:8e9e with SMTP id
 j128-20020a0dc786000000b0057088548e9emr30415426ywd.33.1687966304011; Wed, 28
 Jun 2023 08:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ac8c0366-c236-4a7f-b351-b59e2d9a19ab@palmer-ri-x1c9> <mhng-9dcef543-3e4c-4d58-ad5a-cf3487270672@palmer-ri-x1c9>
In-Reply-To: <mhng-9dcef543-3e4c-4d58-ad5a-cf3487270672@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 28 Jun 2023 21:01:32 +0530
Message-ID: <CAK9=C2Vy-4V9kgnga98tiC3TeHkR2LFPakyBbS8s_h3_Z=ieyQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 7:46=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Tue, 27 Jun 2023 08:49:06 PDT (-0700), Palmer Dabbelt wrote:
> > On Mon, 26 Jun 2023 23:52:06 PDT (-0700), apatel@ventanamicro.com wrote=
:
> >> On Tue, Jun 27, 2023 at 1:23=E2=80=AFAM Palmer Dabbelt <palmer@rivosin=
c.com> wrote:
> >>>
> >>> On Mon, 26 Jun 2023 10:38:43 PDT (-0700), apatel@ventanamicro.com wro=
te:
> >>> > On Mon, Jun 26, 2023 at 3:42=E2=80=AFPM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> >>> >>
> >>> >> intro
> >>> >> =3D=3D=3D=3D=3D
> >>> >>
> >>> >> When the RISC-V dt-bindings were accepted upstream in Linux, the b=
ase
> >>> >> ISA etc had yet to be ratified. By the ratification of the base IS=
A,
> >>> >> incompatible changes had snuck into the specifications - for examp=
le the
> >>> >> Zicsr and Zifencei extensions were spun out of the base ISA.
> >>> >>
> >>> >> Fast forward to today, and the reason for this patch.
> >>> >> Currently the riscv,isa dt property permits only a specific subset=
 of
> >>> >> the ISA string - in particular it excludes version numbering.
> >>> >> With the current constraints, it is not possible to discern whethe=
r
> >>> >> "rv64i" means that the hart supports the fence.i instruction, for
> >>> >> example.
> >>> >> Future systems may choose to implement their own instruction fenci=
ng,
> >>> >> perhaps using a vendor extension, or they may not implement the op=
tional
> >>> >> counter extensions. Software needs a way to determine this.
> >>> >>
> >>> >> versioning schemes
> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >>
> >>> >> "Use the extension versions that are described in the ISA manual" =
you
> >>> >> may say, and it's not like this has not been considered.
> >>> >> Firstly, software that parses the riscv,isa property at runtime wi=
ll
> >>> >> need to contain a lookup table of some sort that maps arbitrary ve=
rsions
> >>> >> to versions it understands. There is not a consistent application =
of
> >>> >> version number applied to extensions, with a higgledy-piggledy
> >>> >> collection of tags, "bare" and versioned documents awaiting the re=
ader
> >>> >> on the "recently ratified extensions" page:
> >>> >> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
> >>> >>
> >>> >>         As an aside, and this is reflected in the patch too, since=
 many
> >>> >>         extensions have yet to appear in a release of the ISA spec=
s,
> >>> >>         they are defined by commits in their respective "working d=
raft"
> >>> >>         repositories.
> >>> >>
> >>> >> Secondly, there is an issue of backwards compatibility, whereby al=
lowing
> >>> >> numbers in the ISA string, some parsers may be broken. This would
> >>> >> require an additional property to be created to even use the versi=
ons in
> >>> >> this manner.
> >>> >>
> >>> >> ~boolean properties~ string array property
> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >>
> >>> >> If a new property is needed, the whole approach may as well be loo=
ked at
> >>> >> from the bottom up. A string with limited character choices etc is
> >>> >> hardly the best approach for communicating extension information t=
o
> >>> >> software.
> >>> >>
> >>> >> Switching to using properties that are defined on a per extension =
basis,
> >>> >> allows us to define explicit meanings for the DT representation of=
 each
> >>> >> extension - rather than the current situation where different oper=
ating
> >>> >> systems or other bits of software may impart different meanings to
> >>> >> characters in the string.
> >>> >> Clearly the best source of meanings is the specifications themselv=
es,
> >>> >> this just provides us the ability to choose at what point in time =
the
> >>> >> meaning is set. If an extension changes incompatibility in the fut=
ure,
> >>> >> a new property will be required.
> >>> >>
> >>> >> Off-list, some of the RVI folks have committed to shoring up the w=
ording
> >>> >> in either the ISA specifications, the riscv-isa-manual or
> >>> >> so that in the future, modifications to and additions or removals =
of
> >>> >> features will require a new extension. Codifying that assertion
> >>> >> somewhere would make it quite unlikely that compatibility would be
> >>> >> broken, but we have the tools required to deal with it, if & when =
it
> >>> >> crops up.
> >>> >> It is in our collective interest, as consumers of extension meanin=
gs, to
> >>> >> define a scheme that enforces compatibility.
> >>> >>
> >>> >> The use of individual properties, rather than elements in a single
> >>> >> string, will also permit validation that the properties have a mea=
ning,
> >>> >> as well as potentially reject mutually exclusive combinations, or
> >>> >> enforce dependencies between extensions. That would not have be po=
ssible
> >>> >> with the current dt-schema infrastructure for arbitrary strings, a=
s we
> >>> >> would need to add a riscv,isa parser to dt-validate!
> >>> >> That's not implemented in this patch, but rather left as future wo=
rk (for
> >>> >> the brave, or the foolish).
> >>> >>
> >>> >> acpi
> >>> >> =3D=3D=3D=3D
> >>> >>
> >>> >> The current ACPI ECR is based on having a single ISA string unfort=
unately,
> >>> >> but ideally ACPI will move to another method, perhaps GUIDs, that =
give
> >>> >> explicit meaning to extensions.
> >>> >
> >>> > Drop this paragraph on ACPI.
> >>> >
> >>> > We clearly mentioned previously that ACPI will follow specs defined=
 by RVI.
> >>> > There are scalability issues in using GUIDs for each ISA extension.
> >>>
> >>> Which spec are we following for the ACPI ISA string?
> >>
> >> ACPI RHCT follows the "ISA Extension Naming Conventions"
> >> defined by the RISC-V unpriv spec. I understand that there are
> >> unresolved issues in the "ISA Extension Naming Conventions"
> >> which should be addressed by RVI and we should also try our
> >> best to have this fixed in the spec.
> >
> > Which version of the spec?  We've had a ton of issues related to
> > versioning everywhere else the ISA string has been used, we need to kno=
w
> > specifically which version we're parsing in order to do anything
> > meaningful with it.
>
> Anup: Can you please provide a pointer to the spec this is supposed to
> implement?  I don't want to end up in the same spot again where we're
> presuming some spec changes, we've got to support whatever we merge no
> matter what happens on the spec side.
>
> In theory I'm on vacation today, but I'll try and look at the thread
> again tonight when I get back.

It is the "Chapter 29. ISA Extension Naming Conventions" of the
RISC-V unpriv specification.
(https://github.com/riscv/riscv-isa-manual/releases/download/riscv-isa-rele=
ase-1239329-2023-05-23/unpriv-isa-asciidoc.pdf)

The RISC-V unpriv specification is only a collection of extensions
hence it does not have its own version.

We should work with RVI to address the concerns/clarifications
that we need in "Chapter 29. ISA Extension Naming Conventions".

We can also create GitHub issues for unpriv spec if that helps.

Regards,
Anup

>
> >> In any case, ACPI spec is owned by UEFI forum so it does
> >> not make sense to define/recommend anything for ACPI in
> >> DT bindings.
> >
> > Unless I missed something this is just a long commit message, it's not
> > even in the docs.  If you don't want the DT side to even mention ACPI
> > that's fine with me, though, I don't really care.
> >
> >>
> >> Regards,
> >> Anup
> >>
> >>
> >>
> >>>
> >>> > Regards,
> >>> > Anup
> >>> >
> >>> >>
> >>> >> parser simplicity
> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >>
> >>> >> Many systems that parse DT at runtime already implement an functio=
n that
> >>> >> can check for the presence of a string in an array of string, as i=
t is
> >>> >> similar to the process for parsing a list of compatible strings, s=
o a
> >>> >> bunch of new, custom, DT parsing should not be needed.
> >>> >> Getting rid of "riscv,isa" parsing would be a nice simplification,=
 but
> >>> >> unfortunately for backwards compatibility with old dtbs, existing
> >>> >> parsers may not be removable - which may greatly simplify
> >>> >> dt parsing code. In Linux, for example, checking for whether a har=
t
> >>> >> supports an extension becomes as simple as:
> >>> >>         of_property_match_string(node, "riscv,isa-extensions", "zi=
cbom")
> >>> >>
> >>> >> vendor extensions
> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> >>
> >>> >> Compared to riscv,isa, this proposed scheme promotes vendor extens=
ions,
> >>> >> oft touted as the strength of RISC-V, to first-class citizens.
> >>> >> At present, extensions are defined as meaning what the RISC-V ISA
> >>> >> specifications say they do. There is no realistic way of using tha=
t
> >>> >> interface to provide cross-platform definitions for what vendor
> >>> >> extensions mean. Vendor extensions may also have even less consist=
ency
> >>> >> than RVI do in terms of versioning, or no care about backwards
> >>> >> compatibility.
> >>> >> The new property allows us to assign explicit meanings on a per ve=
ndor
> >>> >> extension basis, backed up by a description of their meanings.
> >>> >>
> >>> >> fin
> >>> >> =3D=3D=3D
> >>> >>
> >>> >> Create a new file to store the extension meanings and a new
> >>> >> riscv,isa-base property to replace the aspect of riscv,isa that is
> >>> >> not represented by the new property - the base ISA implemented by =
a hart.
> >>> >>
> >>> >> As a starting point, add properties for extensions currently used =
in
> >>> >> Linux.
> >>> >>
> >>> >> Finally, mark riscv,isa as deprecated, as removing support for it =
in
> >>> >> existing programs would be an ABI break.
> >>> >>
> >>> >> CC: Palmer Dabbelt <palmer@dabbelt.com>
> >>> >> CC: Paul Walmsley <paul.walmsley@sifive.com>
> >>> >> CC: Rob Herring <robh+dt@kernel.org>
> >>> >> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >>> >> CC: Alistair Francis <alistair.francis@wdc.com>
> >>> >> CC: Andrew Jones <ajones@ventanamicro.com>
> >>> >> CC: Anup Patel <apatel@ventanamicro.com>
> >>> >> CC: Atish Patra <atishp@atishpatra.org>
> >>> >> CC: Jessica Clarke <jrtc27@jrtc27.com>
> >>> >> CC: Rick Chen <rick@andestech.com>
> >>> >> CC: Leo <ycliang@andestech.com>
> >>> >> CC: Oleksii <oleksii.kurochko@gmail.com>
> >>> >> CC: linux-riscv@lists.infradead.org
> >>> >> CC: qemu-riscv@nongnu.org
> >>> >> CC: u-boot@lists.denx.de
> >>> >> CC: devicetree@vger.kernel.org
> >>> >> CC: linux-kernel@vger.kernel.org
> >>> >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >>> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>> >> ---
> >>> >> Changes in v3:
> >>> >> - Per Rob's suggestion, switch to an array of strings. Cuts down o=
n the
> >>> >>   size, compared to booleans. It has a standard mechanism for pars=
ing
> >>> >>   (you need to parse arrays of strings for compatibles). It still =
allows
> >>> >>   for having a limited set of explicitly defined properties - so t=
he
> >>> >>   advantages over a free-form string still apply.
> >>> >> - Pick up Palmer's Ack and Review (although I expect that he will =
be the
> >>> >>   one to apply this).
> >>> >> ---
> >>> >>  .../devicetree/bindings/riscv/cpus.yaml       |  43 ++-
> >>> >>  .../devicetree/bindings/riscv/extensions.yaml | 245 +++++++++++++=
+++++
> >>> >>  2 files changed, 265 insertions(+), 23 deletions(-)
> >>> >>  create mode 100644 Documentation/devicetree/bindings/riscv/extens=
ions.yaml
> >>> >>
> >>> >> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/D=
ocumentation/devicetree/bindings/riscv/cpus.yaml
> >>> >> index 67bd239ead0b..74bc92591086 100644
> >>> >> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> >> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>> >> @@ -25,6 +25,7 @@ description: |
> >>> >>
> >>> >>  allOf:
> >>> >>    - $ref: /schemas/cpu.yaml#
> >>> >> +  - $ref: extensions.yaml
> >>> >>
> >>> >>  properties:
> >>> >>    compatible:
> >>> >> @@ -82,25 +83,6 @@ properties:
> >>> >>      description:
> >>> >>        The blocksize in bytes for the Zicboz cache operations.
> >>> >>
> >>> >> -  riscv,isa:
> >>> >> -    description:
> >>> >> -      Identifies the specific RISC-V instruction set architecture
> >>> >> -      supported by the hart.  These are documented in the RISC-V
> >>> >> -      User-Level ISA document, available from
> >>> >> -      https://riscv.org/specifications/
> >>> >> -
> >>> >> -      Due to revisions of the ISA specification, some deviations
> >>> >> -      have arisen over time.
> >>> >> -      Notably, riscv,isa was defined prior to the creation of the
> >>> >> -      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
> >>> >> -      implies "zicntr_zicsr_zifencei_zihpm".
> >>> >> -
> >>> >> -      While the isa strings in ISA specification are case
> >>> >> -      insensitive, letters in the riscv,isa string must be all
> >>> >> -      lowercase.
> >>> >> -    $ref: /schemas/types.yaml#/definitions/string
> >>> >> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z]=
)+)?(?:_[hsxz](?:[a-z])+)*$
> >>> >> -
> >>> >>    # RISC-V has multiple properties for cache op block sizes as th=
e sizes
> >>> >>    # differ between individual CBO extensions
> >>> >>    cache-op-block-size: false
> >>> >> @@ -139,8 +121,17 @@ properties:
> >>> >>        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >>> >>        in the system.
> >>> >>
> >>> >> +oneOf:
> >>> >> +  - required:
> >>> >> +      - riscv,isa
> >>> >> +  - required:
> >>> >> +      - riscv,isa-base
> >>> >> +
> >>> >> +dependencies:
> >>> >> +  riscv,isa-base: [ "riscv,isa-extensions" ]
> >>> >> +  riscv,isa-extensions: [ "riscv,isa-base" ]
> >>> >> +
> >>> >>  required:
> >>> >> -  - riscv,isa
> >>> >>    - interrupt-controller
> >>> >>
> >>> >>  unevaluatedProperties: false
> >>> >> @@ -160,7 +151,9 @@ examples:
> >>> >>                  i-cache-sets =3D <128>;
> >>> >>                  i-cache-size =3D <16384>;
> >>> >>                  reg =3D <0>;
> >>> >> -                riscv,isa =3D "rv64imac";
> >>> >> +                riscv,isa-base =3D "rv64i";
> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "c";
> >>> >> +
> >>> >>                  cpu_intc0: interrupt-controller {
> >>> >>                          #interrupt-cells =3D <1>;
> >>> >>                          compatible =3D "riscv,cpu-intc";
> >>> >> @@ -183,8 +176,10 @@ examples:
> >>> >>                  i-tlb-size =3D <32>;
> >>> >>                  mmu-type =3D "riscv,sv39";
> >>> >>                  reg =3D <1>;
> >>> >> -                riscv,isa =3D "rv64imafdc";
> >>> >>                  tlb-split;
> >>> >> +                riscv,isa-base =3D "rv64i";
> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c";
> >>> >> +
> >>> >>                  cpu_intc1: interrupt-controller {
> >>> >>                          #interrupt-cells =3D <1>;
> >>> >>                          compatible =3D "riscv,cpu-intc";
> >>> >> @@ -202,8 +197,10 @@ examples:
> >>> >>                  device_type =3D "cpu";
> >>> >>                  reg =3D <0>;
> >>> >>                  compatible =3D "riscv";
> >>> >> -                riscv,isa =3D "rv64imafdc";
> >>> >>                  mmu-type =3D "riscv,sv48";
> >>> >> +                riscv,isa-base =3D "rv64i";
> >>> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d",=
 "c";
> >>> >> +
> >>> >>                  interrupt-controller {
> >>> >>                          #interrupt-cells =3D <1>;
> >>> >>                          interrupt-controller;
> >>> >> diff --git a/Documentation/devicetree/bindings/riscv/extensions.ya=
ml b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>> >> new file mode 100644
> >>> >> index 000000000000..af98307f2c2c
> >>> >> --- /dev/null
> >>> >> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>> >> @@ -0,0 +1,245 @@
> >>> >> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >>> >> +%YAML 1.2
> >>> >> +---
> >>> >> +$id: http://devicetree.org/schemas/riscv/extensions.yaml#
> >>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> >> +
> >>> >> +title: RISC-V ISA extensions
> >>> >> +
> >>> >> +maintainers:
> >>> >> +  - Paul Walmsley <paul.walmsley@sifive.com>
> >>> >> +  - Palmer Dabbelt <palmer@sifive.com>
> >>> >> +  - Conor Dooley <conor@kernel.org>
> >>> >> +
> >>> >> +description: |
> >>> >> +  RISC-V has a large number of extensions, some of which are "sta=
ndard"
> >>> >> +  extensions, meaning they are ratified by RISC-V International, =
and others
> >>> >> +  are "vendor" extensions.
> >>> >> +  This document defines properties that indicate whether a hart s=
upports a
> >>> >> +  given extension.
> >>> >> +
> >>> >> +  Once a standard extension has been ratified, no changes in beha=
viour can be
> >>> >> +  made without the creation of a new extension.
> >>> >> +  The properties for standard extensions therefore map to their o=
riginally
> >>> >> +  ratified states, with the exception of the I, Zicntr & Zihpm ex=
tensions.
> >>> >> +  See the "i" property for more information.
> >>> >> +
> >>> >> +select:
> >>> >> +  properties:
> >>> >> +    compatible:
> >>> >> +      contains:
> >>> >> +        const: riscv
> >>> >> +
> >>> >> +properties:
> >>> >> +  riscv,isa:
> >>> >> +    description:
> >>> >> +      Identifies the specific RISC-V instruction set architecture
> >>> >> +      supported by the hart.  These are documented in the RISC-V
> >>> >> +      User-Level ISA document, available from
> >>> >> +      https://riscv.org/specifications/
> >>> >> +
> >>> >> +      Due to revisions of the ISA specification, some deviations
> >>> >> +      have arisen over time.
> >>> >> +      Notably, riscv,isa was defined prior to the creation of the
> >>> >> +      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
> >>> >> +      implies "zicntr_zicsr_zifencei_zihpm".
> >>> >> +
> >>> >> +      While the isa strings in ISA specification are case
> >>> >> +      insensitive, letters in the riscv,isa string must be all
> >>> >> +      lowercase.
> >>> >> +    $ref: /schemas/types.yaml#/definitions/string
> >>> >> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z]=
)+)?(?:_[hsxz](?:[a-z])+)*$
> >>> >> +    deprecated: true
> >>> >> +
> >>> >> +  riscv,isa-base:
> >>> >> +    description:
> >>> >> +      The base ISA implemented by this hart, as described by the =
20191213
> >>> >> +      version of the unprivileged ISA specification.
> >>> >> +    enum:
> >>> >> +      - rv32i
> >>> >> +      - rv64i
> >>> >> +
> >>> >> +  riscv,isa-extensions:
> >>> >> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>> >> +    minItems: 1
> >>> >> +    description: Extensions supported by the hart.
> >>> >> +    items:
> >>> >> +      anyOf:
> >>> >> +        # single letter extensions, in canonical order
> >>> >> +        - const: i
> >>> >> +          description: |
> >>> >> +            The base integer instruction set, as ratified in the =
20191213
> >>> >> +            version of the unprivileged ISA specification, with t=
he exception of
> >>> >> +            counter access.
> >>> >> +            Counter access was removed after the ratification of =
the 20191213
> >>> >> +            version of the unprivileged specification and shunted=
 into the
> >>> >> +            Zicntr and Zihpm extensions.
> >>> >> +
> >>> >> +        - const: m
> >>> >> +          description:
> >>> >> +            The standard M extension for integer multiplication a=
nd division, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: a
> >>> >> +          description:
> >>> >> +            The standard A extension for atomic instructions, as =
ratified in the
> >>> >> +            20191213 version of the unprivileged ISA specificatio=
n.
> >>> >> +
> >>> >> +        - const: f
> >>> >> +          description:
> >>> >> +            The standard F extension for single-precision floatin=
g point, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: d
> >>> >> +          description:
> >>> >> +            The standard D extension for double-precision floatin=
g-point, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: q
> >>> >> +          description:
> >>> >> +            The standard Q extension for quad-precision floating-=
point, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: c
> >>> >> +          description:
> >>> >> +            The standard C extension for compressed instructions,=
 as ratified in
> >>> >> +            the 20191213 version of the unprivileged ISA specific=
ation.
> >>> >> +
> >>> >> +        - const: v
> >>> >> +          description:
> >>> >> +            The standard V extension for vector operations, as ra=
tified
> >>> >> +            in-and-around commit 7a6c8ae ("Fix text that describe=
s vfmv.v.f
> >>> >> +            encoding") of the riscv-v-spec.
> >>> >> +
> >>> >> +        - const: h
> >>> >> +          description:
> >>> >> +            The standard H extension for hypervisors as ratified =
in the 20191213
> >>> >> +            version of the privileged ISA specification.
> >>> >> +
> >>> >> +        # multi-letter extensions, sorted alphanumerically
> >>> >> +        - const: smaia
> >>> >> +          description: |
> >>> >> +            The standard Smaia supervisor-level extension for the=
 advanced
> >>> >> +            interrupt architecture for machine-mode-visible csr a=
nd behavioural
> >>> >> +            changes to interrupts as frozen at commit ccbddab ("M=
erge pull
> >>> >> +            request #42 from riscv/jhauser-2023-RC4") of riscv-ai=
a.
> >>> >> +
> >>> >> +        - const: ssaia
> >>> >> +          description: |
> >>> >> +            The standard Ssaia supervisor-level extension for the=
 advanced
> >>> >> +            interrupt architecture for supervisor-mode-visible cs=
r and
> >>> >> +            behavioural changes to interrupts as frozen at commit=
 ccbddab
> >>> >> +            ("Merge pull request #42 from riscv/jhauser-2023-RC4"=
) of riscv-aia.
> >>> >> +
> >>> >> +        - const: sscofpmf
> >>> >> +          description: |
> >>> >> +            The standard Sscofpmf supervisor-level extension for =
count overflow
> >>> >> +            and mode-based filtering as ratified at commit 01d1df=
0 ("Add ability
> >>> >> +            to manually trigger workflow. (#2)") of riscv-count-o=
verflow.
> >>> >> +
> >>> >> +        - const: sstc
> >>> >> +          description: |
> >>> >> +            The standard Sstc supervisor-level extension for time=
 compare as
> >>> >> +            ratified at commit 3f9ed34 ("Add ability to manually =
trigger
> >>> >> +            workflow. (#2)") of riscv-time-compare.
> >>> >> +
> >>> >> +        - const: svinval
> >>> >> +          description:
> >>> >> +            The standard Svinval supervisor-level extension for f=
ine-grained
> >>> >> +            address-translation cache invalidation as ratified in=
 the 20191213
> >>> >> +            version of the privileged ISA specification.
> >>> >> +
> >>> >> +        - const: svnapot
> >>> >> +          description:
> >>> >> +            The standard Svnapot supervisor-level extensions for =
napot
> >>> >> +            translation contiguity as ratified in the 20191213 ve=
rsion of the
> >>> >> +            privileged ISA specification.
> >>> >> +
> >>> >> +        - const: svpbmt
> >>> >> +          description:
> >>> >> +            The standard Svpbmt supervisor-level extensions for p=
age-based
> >>> >> +            memory types as ratified in the 20191213 version of t=
he privileged
> >>> >> +            ISA specification.
> >>> >> +
> >>> >> +        - const: zba
> >>> >> +          description: |
> >>> >> +            The standard Zba bit-manipulation extension for addre=
ss generation
> >>> >> +            acceleration instructions as ratified at commit 6d339=
19 ("Merge pull
> >>> >> +            request #158 from hirooih/clmul-fix-loop-end-conditio=
n") of
> >>> >> +            riscv-bitmanip.
> >>> >> +
> >>> >> +        - const: zbb
> >>> >> +          description: |
> >>> >> +            The standard Zbb bit-manipulation extension for basic=
 bit-manipulation
> >>> >> +            as ratified at commit 6d33919 ("Merge pull request #1=
58 from
> >>> >> +            hirooih/clmul-fix-loop-end-condition") of riscv-bitma=
nip.
> >>> >> +
> >>> >> +        - const: zbc
> >>> >> +          description: |
> >>> >> +            The standard Zbc bit-manipulation extension for carry=
-less
> >>> >> +            multiplication as ratified at commit 6d33919 ("Merge =
pull request
> >>> >> +            #158 from hirooih/clmul-fix-loop-end-condition") of r=
iscv-bitmanip.
> >>> >> +
> >>> >> +        - const: zbs
> >>> >> +          description: |
> >>> >> +            The standard Zbs bit-manipulation extension for singl=
e-bit
> >>> >> +            instructions as ratified at commit 6d33919 ("Merge pu=
ll request #158
> >>> >> +            from hirooih/clmul-fix-loop-end-condition") of riscv-=
bitmanip.
> >>> >> +
> >>> >> +        - const: zicbom
> >>> >> +          description:
> >>> >> +            The standard Zicbom extension for base cache manageme=
nt operations as
> >>> >> +            ratified in commit 3dd606f ("Create cmobase-v1.0.pdf"=
) of riscv-CMOs.
> >>> >> +
> >>> >> +        - const: zicbop
> >>> >> +          description:
> >>> >> +            The standard Zicbop extension for cache-block prefetc=
h instructions
> >>> >> +            as ratified in commit 3dd606f ("Create cmobase-v1.0.p=
df") of
> >>> >> +            riscv-CMOs.
> >>> >> +
> >>> >> +        - const: zicboz
> >>> >> +          description:
> >>> >> +            The standard Zicboz extension for cache-block zeroing=
 as ratified
> >>> >> +            in commit 3dd606f ("Create cmobase-v1.0.pdf") of risc=
v-CMOs.
> >>> >> +
> >>> >> +        - const: zicntr
> >>> >> +          description:
> >>> >> +            The standard Zicntr extension for base counters and t=
imers, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: zicsr
> >>> >> +          description:
> >>> >> +            The standard Zicsr extension for control and status r=
egister
> >>> >> +            instructions, as ratified in the 20191213 version of =
the
> >>> >> +            unprivileged ISA specification.
> >>> >> +
> >>> >> +        - const: zifencei
> >>> >> +          description:
> >>> >> +            The standard Zifencei extension for instruction-fetch=
 fence, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: zihintpause
> >>> >> +          description:
> >>> >> +            The standard Zihintpause extension for pause hints, a=
s ratified in
> >>> >> +            commit d8ab5c7 ("Zihintpause is ratified") of the ris=
cv-isa-manual.
> >>> >> +
> >>> >> +        - const: zihpm
> >>> >> +          description:
> >>> >> +            The standard Zihpm extension for hardware performance=
 counters, as
> >>> >> +            ratified in the 20191213 version of the unprivileged =
ISA
> >>> >> +            specification.
> >>> >> +
> >>> >> +        - const: ztso
> >>> >> +          description:
> >>> >> +            The standard Ztso extension for total store ordering,=
 as ratified
> >>> >> +            in commit 2e5236 ("Ztso is now ratified.") of the
> >>> >> +            riscv-isa-manual.
> >>> >> +
> >>> >> +additionalProperties: true
> >>> >> +...
> >>> >> --
> >>> >> 2.40.1
> >>> >>
