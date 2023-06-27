Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D74A73F4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjF0Gwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjF0Gw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:52:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD811FCF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:52:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so921608276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1687848738; x=1690440738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Kc3zhOKZd/UjF/KeOsXx3lQ0wMmK16Rpt4hqELTARQ=;
        b=fk29Wt8e21i5Jb717SvKW8rsc0fMbI7Ui1WhkB+XFkow/Yd+D+z/mm9ohxqvB2VFMa
         C8fKQ/mmRrmVmhxMbWGa9S99qGfBiwwXHeFWiJx7OBij+c275IL3XNIEv8XEyUPLHIwJ
         MUtkk2NXED/8mZ7SaSn3XJkOFWqToe7rohzJ8c66gF4ZjAF6u2LQudZ0CN+oFqQT5eTT
         RVPgbioexilywj6m+aCZQZcY5EmJPQFiNfXf+UcrKQN7Q4uVfDq1MsbgGySfgIbqNx2a
         pkqDQkAVGkdBtxIYQ1Zr3u7tJjKo7VBKIjGuegEjnXw3HDWeI1NuMGzi+mEUnc2fq5AO
         naYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687848738; x=1690440738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Kc3zhOKZd/UjF/KeOsXx3lQ0wMmK16Rpt4hqELTARQ=;
        b=knwFIXOBn1ql1PnBRcfhG3Y7UNwk6H7QYVk929l/K4Em071rX2SNGQ+eXM59f/niCE
         fhDq+pg3INfX1AGtUEwqdK7VQzQ8pfkEZC6Ia3ljPkD4UhqzgTWofG3LQCUIXx2xAc9B
         tDWKlTHs3xFW6jENbLesjdLOerRQWXT+EX/xQoVz9reQhaArsyF0oSvMxEfcjTNdj2TO
         IzHHXJ6i99z5e5Gc57BfrFPdbH+jiQhrUrk44gKGZXzBY8XSfsb6MapJACrPxVP8hC92
         JQGZguM2tZQ5neliLDk+TnlZ3UV7jQmY9QKXgWqC9P2DrXROGRz+R002ziXBK0fUH2TE
         surw==
X-Gm-Message-State: AC+VfDwaeNvOvWkz+RzsfkIg0nhgu3y/L2se8pOeXt4t5g4OBOscJ1V4
        Pj/0QVIePVjSN+6i6BoqTo67mzMpFQJpRopLSV0dXg==
X-Google-Smtp-Source: ACHHUZ4X68+UT9pZjTqhq6kfHxaYXaPa5xnPgNVZwM3xd1Au7tnC5zTjjJ321aSiWw0nDk70iVNlvknHnQKuOTF1gEg=
X-Received: by 2002:a25:2543:0:b0:c13:14b0:d2b7 with SMTP id
 l64-20020a252543000000b00c1314b0d2b7mr9590769ybl.0.1687848737994; Mon, 26 Jun
 2023 23:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK9=C2UesoUCeb8k0DSCHi7Zr+B5U26KQ9oCs9map3a2zzYqAw@mail.gmail.com>
 <mhng-5b997e5c-757d-4fe3-9da2-183a4b93a873@palmer-ri-x1c9>
In-Reply-To: <mhng-5b997e5c-757d-4fe3-9da2-183a4b93a873@palmer-ri-x1c9>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 27 Jun 2023 12:22:06 +0530
Message-ID: <CAK9=C2U4BkJKH36r7C7TocEpDjqMJwrmpSL_cyWCveohQ+j_zg@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: deprecate riscv,isa
To:     Palmer Dabbelt <palmer@rivosinc.com>
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

On Tue, Jun 27, 2023 at 1:23=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.com=
> wrote:
>
> On Mon, 26 Jun 2023 10:38:43 PDT (-0700), apatel@ventanamicro.com wrote:
> > On Mon, Jun 26, 2023 at 3:42=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> >>
> >> intro
> >> =3D=3D=3D=3D=3D
> >>
> >> When the RISC-V dt-bindings were accepted upstream in Linux, the base
> >> ISA etc had yet to be ratified. By the ratification of the base ISA,
> >> incompatible changes had snuck into the specifications - for example t=
he
> >> Zicsr and Zifencei extensions were spun out of the base ISA.
> >>
> >> Fast forward to today, and the reason for this patch.
> >> Currently the riscv,isa dt property permits only a specific subset of
> >> the ISA string - in particular it excludes version numbering.
> >> With the current constraints, it is not possible to discern whether
> >> "rv64i" means that the hart supports the fence.i instruction, for
> >> example.
> >> Future systems may choose to implement their own instruction fencing,
> >> perhaps using a vendor extension, or they may not implement the option=
al
> >> counter extensions. Software needs a way to determine this.
> >>
> >> versioning schemes
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> "Use the extension versions that are described in the ISA manual" you
> >> may say, and it's not like this has not been considered.
> >> Firstly, software that parses the riscv,isa property at runtime will
> >> need to contain a lookup table of some sort that maps arbitrary versio=
ns
> >> to versions it understands. There is not a consistent application of
> >> version number applied to extensions, with a higgledy-piggledy
> >> collection of tags, "bare" and versioned documents awaiting the reader
> >> on the "recently ratified extensions" page:
> >> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
> >>
> >>         As an aside, and this is reflected in the patch too, since man=
y
> >>         extensions have yet to appear in a release of the ISA specs,
> >>         they are defined by commits in their respective "working draft=
"
> >>         repositories.
> >>
> >> Secondly, there is an issue of backwards compatibility, whereby allowi=
ng
> >> numbers in the ISA string, some parsers may be broken. This would
> >> require an additional property to be created to even use the versions =
in
> >> this manner.
> >>
> >> ~boolean properties~ string array property
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> If a new property is needed, the whole approach may as well be looked =
at
> >> from the bottom up. A string with limited character choices etc is
> >> hardly the best approach for communicating extension information to
> >> software.
> >>
> >> Switching to using properties that are defined on a per extension basi=
s,
> >> allows us to define explicit meanings for the DT representation of eac=
h
> >> extension - rather than the current situation where different operatin=
g
> >> systems or other bits of software may impart different meanings to
> >> characters in the string.
> >> Clearly the best source of meanings is the specifications themselves,
> >> this just provides us the ability to choose at what point in time the
> >> meaning is set. If an extension changes incompatibility in the future,
> >> a new property will be required.
> >>
> >> Off-list, some of the RVI folks have committed to shoring up the wordi=
ng
> >> in either the ISA specifications, the riscv-isa-manual or
> >> so that in the future, modifications to and additions or removals of
> >> features will require a new extension. Codifying that assertion
> >> somewhere would make it quite unlikely that compatibility would be
> >> broken, but we have the tools required to deal with it, if & when it
> >> crops up.
> >> It is in our collective interest, as consumers of extension meanings, =
to
> >> define a scheme that enforces compatibility.
> >>
> >> The use of individual properties, rather than elements in a single
> >> string, will also permit validation that the properties have a meaning=
,
> >> as well as potentially reject mutually exclusive combinations, or
> >> enforce dependencies between extensions. That would not have be possib=
le
> >> with the current dt-schema infrastructure for arbitrary strings, as we
> >> would need to add a riscv,isa parser to dt-validate!
> >> That's not implemented in this patch, but rather left as future work (=
for
> >> the brave, or the foolish).
> >>
> >> acpi
> >> =3D=3D=3D=3D
> >>
> >> The current ACPI ECR is based on having a single ISA string unfortunat=
ely,
> >> but ideally ACPI will move to another method, perhaps GUIDs, that give
> >> explicit meaning to extensions.
> >
> > Drop this paragraph on ACPI.
> >
> > We clearly mentioned previously that ACPI will follow specs defined by =
RVI.
> > There are scalability issues in using GUIDs for each ISA extension.
>
> Which spec are we following for the ACPI ISA string?

ACPI RHCT follows the "ISA Extension Naming Conventions"
defined by the RISC-V unpriv spec. I understand that there are
unresolved issues in the "ISA Extension Naming Conventions"
which should be addressed by RVI and we should also try our
best to have this fixed in the spec.

In any case, ACPI spec is owned by UEFI forum so it does
not make sense to define/recommend anything for ACPI in
DT bindings.

Regards,
Anup



>
> > Regards,
> > Anup
> >
> >>
> >> parser simplicity
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Many systems that parse DT at runtime already implement an function th=
at
> >> can check for the presence of a string in an array of string, as it is
> >> similar to the process for parsing a list of compatible strings, so a
> >> bunch of new, custom, DT parsing should not be needed.
> >> Getting rid of "riscv,isa" parsing would be a nice simplification, but
> >> unfortunately for backwards compatibility with old dtbs, existing
> >> parsers may not be removable - which may greatly simplify
> >> dt parsing code. In Linux, for example, checking for whether a hart
> >> supports an extension becomes as simple as:
> >>         of_property_match_string(node, "riscv,isa-extensions", "zicbom=
")
> >>
> >> vendor extensions
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> Compared to riscv,isa, this proposed scheme promotes vendor extensions=
,
> >> oft touted as the strength of RISC-V, to first-class citizens.
> >> At present, extensions are defined as meaning what the RISC-V ISA
> >> specifications say they do. There is no realistic way of using that
> >> interface to provide cross-platform definitions for what vendor
> >> extensions mean. Vendor extensions may also have even less consistency
> >> than RVI do in terms of versioning, or no care about backwards
> >> compatibility.
> >> The new property allows us to assign explicit meanings on a per vendor
> >> extension basis, backed up by a description of their meanings.
> >>
> >> fin
> >> =3D=3D=3D
> >>
> >> Create a new file to store the extension meanings and a new
> >> riscv,isa-base property to replace the aspect of riscv,isa that is
> >> not represented by the new property - the base ISA implemented by a ha=
rt.
> >>
> >> As a starting point, add properties for extensions currently used in
> >> Linux.
> >>
> >> Finally, mark riscv,isa as deprecated, as removing support for it in
> >> existing programs would be an ABI break.
> >>
> >> CC: Palmer Dabbelt <palmer@dabbelt.com>
> >> CC: Paul Walmsley <paul.walmsley@sifive.com>
> >> CC: Rob Herring <robh+dt@kernel.org>
> >> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> >> CC: Alistair Francis <alistair.francis@wdc.com>
> >> CC: Andrew Jones <ajones@ventanamicro.com>
> >> CC: Anup Patel <apatel@ventanamicro.com>
> >> CC: Atish Patra <atishp@atishpatra.org>
> >> CC: Jessica Clarke <jrtc27@jrtc27.com>
> >> CC: Rick Chen <rick@andestech.com>
> >> CC: Leo <ycliang@andestech.com>
> >> CC: Oleksii <oleksii.kurochko@gmail.com>
> >> CC: linux-riscv@lists.infradead.org
> >> CC: qemu-riscv@nongnu.org
> >> CC: u-boot@lists.denx.de
> >> CC: devicetree@vger.kernel.org
> >> CC: linux-kernel@vger.kernel.org
> >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >> ---
> >> Changes in v3:
> >> - Per Rob's suggestion, switch to an array of strings. Cuts down on th=
e
> >>   size, compared to booleans. It has a standard mechanism for parsing
> >>   (you need to parse arrays of strings for compatibles). It still allo=
ws
> >>   for having a limited set of explicitly defined properties - so the
> >>   advantages over a free-form string still apply.
> >> - Pick up Palmer's Ack and Review (although I expect that he will be t=
he
> >>   one to apply this).
> >> ---
> >>  .../devicetree/bindings/riscv/cpus.yaml       |  43 ++-
> >>  .../devicetree/bindings/riscv/extensions.yaml | 245 +++++++++++++++++=
+
> >>  2 files changed, 265 insertions(+), 23 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/riscv/extensions=
.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docum=
entation/devicetree/bindings/riscv/cpus.yaml
> >> index 67bd239ead0b..74bc92591086 100644
> >> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >> @@ -25,6 +25,7 @@ description: |
> >>
> >>  allOf:
> >>    - $ref: /schemas/cpu.yaml#
> >> +  - $ref: extensions.yaml
> >>
> >>  properties:
> >>    compatible:
> >> @@ -82,25 +83,6 @@ properties:
> >>      description:
> >>        The blocksize in bytes for the Zicboz cache operations.
> >>
> >> -  riscv,isa:
> >> -    description:
> >> -      Identifies the specific RISC-V instruction set architecture
> >> -      supported by the hart.  These are documented in the RISC-V
> >> -      User-Level ISA document, available from
> >> -      https://riscv.org/specifications/
> >> -
> >> -      Due to revisions of the ISA specification, some deviations
> >> -      have arisen over time.
> >> -      Notably, riscv,isa was defined prior to the creation of the
> >> -      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
> >> -      implies "zicntr_zicsr_zifencei_zihpm".
> >> -
> >> -      While the isa strings in ISA specification are case
> >> -      insensitive, letters in the riscv,isa string must be all
> >> -      lowercase.
> >> -    $ref: /schemas/types.yaml#/definitions/string
> >> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?=
(?:_[hsxz](?:[a-z])+)*$
> >> -
> >>    # RISC-V has multiple properties for cache op block sizes as the si=
zes
> >>    # differ between individual CBO extensions
> >>    cache-op-block-size: false
> >> @@ -139,8 +121,17 @@ properties:
> >>        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >>        in the system.
> >>
> >> +oneOf:
> >> +  - required:
> >> +      - riscv,isa
> >> +  - required:
> >> +      - riscv,isa-base
> >> +
> >> +dependencies:
> >> +  riscv,isa-base: [ "riscv,isa-extensions" ]
> >> +  riscv,isa-extensions: [ "riscv,isa-base" ]
> >> +
> >>  required:
> >> -  - riscv,isa
> >>    - interrupt-controller
> >>
> >>  unevaluatedProperties: false
> >> @@ -160,7 +151,9 @@ examples:
> >>                  i-cache-sets =3D <128>;
> >>                  i-cache-size =3D <16384>;
> >>                  reg =3D <0>;
> >> -                riscv,isa =3D "rv64imac";
> >> +                riscv,isa-base =3D "rv64i";
> >> +                riscv,isa-extensions =3D "i", "m", "a", "c";
> >> +
> >>                  cpu_intc0: interrupt-controller {
> >>                          #interrupt-cells =3D <1>;
> >>                          compatible =3D "riscv,cpu-intc";
> >> @@ -183,8 +176,10 @@ examples:
> >>                  i-tlb-size =3D <32>;
> >>                  mmu-type =3D "riscv,sv39";
> >>                  reg =3D <1>;
> >> -                riscv,isa =3D "rv64imafdc";
> >>                  tlb-split;
> >> +                riscv,isa-base =3D "rv64i";
> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c"=
;
> >> +
> >>                  cpu_intc1: interrupt-controller {
> >>                          #interrupt-cells =3D <1>;
> >>                          compatible =3D "riscv,cpu-intc";
> >> @@ -202,8 +197,10 @@ examples:
> >>                  device_type =3D "cpu";
> >>                  reg =3D <0>;
> >>                  compatible =3D "riscv";
> >> -                riscv,isa =3D "rv64imafdc";
> >>                  mmu-type =3D "riscv,sv48";
> >> +                riscv,isa-base =3D "rv64i";
> >> +                riscv,isa-extensions =3D "i", "m", "a", "f", "d", "c"=
;
> >> +
> >>                  interrupt-controller {
> >>                          #interrupt-cells =3D <1>;
> >>                          interrupt-controller;
> >> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b=
/Documentation/devicetree/bindings/riscv/extensions.yaml
> >> new file mode 100644
> >> index 000000000000..af98307f2c2c
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >> @@ -0,0 +1,245 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/riscv/extensions.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: RISC-V ISA extensions
> >> +
> >> +maintainers:
> >> +  - Paul Walmsley <paul.walmsley@sifive.com>
> >> +  - Palmer Dabbelt <palmer@sifive.com>
> >> +  - Conor Dooley <conor@kernel.org>
> >> +
> >> +description: |
> >> +  RISC-V has a large number of extensions, some of which are "standar=
d"
> >> +  extensions, meaning they are ratified by RISC-V International, and =
others
> >> +  are "vendor" extensions.
> >> +  This document defines properties that indicate whether a hart suppo=
rts a
> >> +  given extension.
> >> +
> >> +  Once a standard extension has been ratified, no changes in behaviou=
r can be
> >> +  made without the creation of a new extension.
> >> +  The properties for standard extensions therefore map to their origi=
nally
> >> +  ratified states, with the exception of the I, Zicntr & Zihpm extens=
ions.
> >> +  See the "i" property for more information.
> >> +
> >> +select:
> >> +  properties:
> >> +    compatible:
> >> +      contains:
> >> +        const: riscv
> >> +
> >> +properties:
> >> +  riscv,isa:
> >> +    description:
> >> +      Identifies the specific RISC-V instruction set architecture
> >> +      supported by the hart.  These are documented in the RISC-V
> >> +      User-Level ISA document, available from
> >> +      https://riscv.org/specifications/
> >> +
> >> +      Due to revisions of the ISA specification, some deviations
> >> +      have arisen over time.
> >> +      Notably, riscv,isa was defined prior to the creation of the
> >> +      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
> >> +      implies "zicntr_zicsr_zifencei_zihpm".
> >> +
> >> +      While the isa strings in ISA specification are case
> >> +      insensitive, letters in the riscv,isa string must be all
> >> +      lowercase.
> >> +    $ref: /schemas/types.yaml#/definitions/string
> >> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?=
(?:_[hsxz](?:[a-z])+)*$
> >> +    deprecated: true
> >> +
> >> +  riscv,isa-base:
> >> +    description:
> >> +      The base ISA implemented by this hart, as described by the 2019=
1213
> >> +      version of the unprivileged ISA specification.
> >> +    enum:
> >> +      - rv32i
> >> +      - rv64i
> >> +
> >> +  riscv,isa-extensions:
> >> +    $ref: /schemas/types.yaml#/definitions/string-array
> >> +    minItems: 1
> >> +    description: Extensions supported by the hart.
> >> +    items:
> >> +      anyOf:
> >> +        # single letter extensions, in canonical order
> >> +        - const: i
> >> +          description: |
> >> +            The base integer instruction set, as ratified in the 2019=
1213
> >> +            version of the unprivileged ISA specification, with the e=
xception of
> >> +            counter access.
> >> +            Counter access was removed after the ratification of the =
20191213
> >> +            version of the unprivileged specification and shunted int=
o the
> >> +            Zicntr and Zihpm extensions.
> >> +
> >> +        - const: m
> >> +          description:
> >> +            The standard M extension for integer multiplication and d=
ivision, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: a
> >> +          description:
> >> +            The standard A extension for atomic instructions, as rati=
fied in the
> >> +            20191213 version of the unprivileged ISA specification.
> >> +
> >> +        - const: f
> >> +          description:
> >> +            The standard F extension for single-precision floating po=
int, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: d
> >> +          description:
> >> +            The standard D extension for double-precision floating-po=
int, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: q
> >> +          description:
> >> +            The standard Q extension for quad-precision floating-poin=
t, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: c
> >> +          description:
> >> +            The standard C extension for compressed instructions, as =
ratified in
> >> +            the 20191213 version of the unprivileged ISA specificatio=
n.
> >> +
> >> +        - const: v
> >> +          description:
> >> +            The standard V extension for vector operations, as ratifi=
ed
> >> +            in-and-around commit 7a6c8ae ("Fix text that describes vf=
mv.v.f
> >> +            encoding") of the riscv-v-spec.
> >> +
> >> +        - const: h
> >> +          description:
> >> +            The standard H extension for hypervisors as ratified in t=
he 20191213
> >> +            version of the privileged ISA specification.
> >> +
> >> +        # multi-letter extensions, sorted alphanumerically
> >> +        - const: smaia
> >> +          description: |
> >> +            The standard Smaia supervisor-level extension for the adv=
anced
> >> +            interrupt architecture for machine-mode-visible csr and b=
ehavioural
> >> +            changes to interrupts as frozen at commit ccbddab ("Merge=
 pull
> >> +            request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
> >> +
> >> +        - const: ssaia
> >> +          description: |
> >> +            The standard Ssaia supervisor-level extension for the adv=
anced
> >> +            interrupt architecture for supervisor-mode-visible csr an=
d
> >> +            behavioural changes to interrupts as frozen at commit ccb=
ddab
> >> +            ("Merge pull request #42 from riscv/jhauser-2023-RC4") of=
 riscv-aia.
> >> +
> >> +        - const: sscofpmf
> >> +          description: |
> >> +            The standard Sscofpmf supervisor-level extension for coun=
t overflow
> >> +            and mode-based filtering as ratified at commit 01d1df0 ("=
Add ability
> >> +            to manually trigger workflow. (#2)") of riscv-count-overf=
low.
> >> +
> >> +        - const: sstc
> >> +          description: |
> >> +            The standard Sstc supervisor-level extension for time com=
pare as
> >> +            ratified at commit 3f9ed34 ("Add ability to manually trig=
ger
> >> +            workflow. (#2)") of riscv-time-compare.
> >> +
> >> +        - const: svinval
> >> +          description:
> >> +            The standard Svinval supervisor-level extension for fine-=
grained
> >> +            address-translation cache invalidation as ratified in the=
 20191213
> >> +            version of the privileged ISA specification.
> >> +
> >> +        - const: svnapot
> >> +          description:
> >> +            The standard Svnapot supervisor-level extensions for napo=
t
> >> +            translation contiguity as ratified in the 20191213 versio=
n of the
> >> +            privileged ISA specification.
> >> +
> >> +        - const: svpbmt
> >> +          description:
> >> +            The standard Svpbmt supervisor-level extensions for page-=
based
> >> +            memory types as ratified in the 20191213 version of the p=
rivileged
> >> +            ISA specification.
> >> +
> >> +        - const: zba
> >> +          description: |
> >> +            The standard Zba bit-manipulation extension for address g=
eneration
> >> +            acceleration instructions as ratified at commit 6d33919 (=
"Merge pull
> >> +            request #158 from hirooih/clmul-fix-loop-end-condition") =
of
> >> +            riscv-bitmanip.
> >> +
> >> +        - const: zbb
> >> +          description: |
> >> +            The standard Zbb bit-manipulation extension for basic bit=
-manipulation
> >> +            as ratified at commit 6d33919 ("Merge pull request #158 f=
rom
> >> +            hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
> >> +
> >> +        - const: zbc
> >> +          description: |
> >> +            The standard Zbc bit-manipulation extension for carry-les=
s
> >> +            multiplication as ratified at commit 6d33919 ("Merge pull=
 request
> >> +            #158 from hirooih/clmul-fix-loop-end-condition") of riscv=
-bitmanip.
> >> +
> >> +        - const: zbs
> >> +          description: |
> >> +            The standard Zbs bit-manipulation extension for single-bi=
t
> >> +            instructions as ratified at commit 6d33919 ("Merge pull r=
equest #158
> >> +            from hirooih/clmul-fix-loop-end-condition") of riscv-bitm=
anip.
> >> +
> >> +        - const: zicbom
> >> +          description:
> >> +            The standard Zicbom extension for base cache management o=
perations as
> >> +            ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of=
 riscv-CMOs.
> >> +
> >> +        - const: zicbop
> >> +          description:
> >> +            The standard Zicbop extension for cache-block prefetch in=
structions
> >> +            as ratified in commit 3dd606f ("Create cmobase-v1.0.pdf")=
 of
> >> +            riscv-CMOs.
> >> +
> >> +        - const: zicboz
> >> +          description:
> >> +            The standard Zicboz extension for cache-block zeroing as =
ratified
> >> +            in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CM=
Os.
> >> +
> >> +        - const: zicntr
> >> +          description:
> >> +            The standard Zicntr extension for base counters and timer=
s, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: zicsr
> >> +          description:
> >> +            The standard Zicsr extension for control and status regis=
ter
> >> +            instructions, as ratified in the 20191213 version of the
> >> +            unprivileged ISA specification.
> >> +
> >> +        - const: zifencei
> >> +          description:
> >> +            The standard Zifencei extension for instruction-fetch fen=
ce, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: zihintpause
> >> +          description:
> >> +            The standard Zihintpause extension for pause hints, as ra=
tified in
> >> +            commit d8ab5c7 ("Zihintpause is ratified") of the riscv-i=
sa-manual.
> >> +
> >> +        - const: zihpm
> >> +          description:
> >> +            The standard Zihpm extension for hardware performance cou=
nters, as
> >> +            ratified in the 20191213 version of the unprivileged ISA
> >> +            specification.
> >> +
> >> +        - const: ztso
> >> +          description:
> >> +            The standard Ztso extension for total store ordering, as =
ratified
> >> +            in commit 2e5236 ("Ztso is now ratified.") of the
> >> +            riscv-isa-manual.
> >> +
> >> +additionalProperties: true
> >> +...
> >> --
> >> 2.40.1
> >>
