Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75370830C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjERNny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjERNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:43:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA9197
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:43:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510e682795fso1260306a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1684417408; x=1687009408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syWYO51VRp94yF3opKnKmtPw35D4EIKzu5G0RvTFocs=;
        b=KIkh+jl9bH64JH+lGhgRW+aN4MOnz7mlraSBy9II30ruBmycRDDg7ODankgfGNnv0D
         KiydShM4L8gyE683YcQZOzekxwQjntX0yUvBTKfyUN6WqVBl7e6jUVeITILQ7QPJM3vz
         eg0dyW4I0J00wYc85uo3rhiIAbW51EEV584H5CSCHbJjlAYrZCjaAFwHGWESscK9Bs80
         GlfXFJ78KPTV3OyVEJCViTK6IpvzxOReO9oHoKAmLWg7q7HVrxj+1ujuDjpF+wjqq+Bm
         2d2ENEGd7Rt0ftR1nfgTRmfa39ETzaC8VAGBXHhgTjPspD9e+TT05ixfrT3Jc+DK0Bgj
         ACcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684417408; x=1687009408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syWYO51VRp94yF3opKnKmtPw35D4EIKzu5G0RvTFocs=;
        b=YNXbV3O6/Lnco2fO6wsWs/nOXCcyYZOLFk36issxNFjHYnQBa4gY11i79fEv0P9xCw
         YLJOdEd+u2SdAcqrjnEakhmkWk4rMEHq9kbvuyXma7GC9c60jZ2PA3/fvaX/f5oMY1jM
         0+Gp0luNJy3BB+JSeDhc8ZRLOVcvESZ7NFjTWncko6LKZWckx3bLfOqerdeudNJbAE1/
         SaZom+bfBt+KMmR21hXdPhxcJ2QFbz34eVemjFA4nAYXzf2/xhNaGhYEeP66tsmMsRuY
         0LR6mtRwNmGuhkdJ+b2/LOg/RFvP+TSp2QNU2445Nh/LaTY0PGGGrBPOj+XQzpaGMxKz
         1ZVA==
X-Gm-Message-State: AC+VfDwT4UydA9GiQKHvYM9L8PPtWhXhY4YoocMHmy/oEtpptwzkAvaR
        fLSINxr7azMUyEYc7o0XM67dP2pDBqj5ESzjy/+bDA==
X-Google-Smtp-Source: ACHHUZ4A4qtceoPHALKTZ04L44/TMQgiKjEqtoY0Gb45OdNwSBS6pGfJ6rdsC12vS6vgqVXUOyqh3OY+LpIDd0XGUdo=
X-Received: by 2002:aa7:c25a:0:b0:50b:fb49:39c9 with SMTP id
 y26-20020aa7c25a000000b0050bfb4939c9mr4549494edo.34.1684417408194; Thu, 18
 May 2023 06:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy> <20230518-4050231ca8dbe93c08cf9c9a@orel>
In-Reply-To: <20230518-4050231ca8dbe93c08cf9c9a@orel>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 18 May 2023 19:13:15 +0530
Message-ID: <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        conor@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 4:02=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:
> > intro
> > =3D=3D=3D=3D=3D
> >
> > When the RISC-V dt-bindings were accepted upstream in Linux, the base
> > ISA etc had yet to be ratified. By the ratification of the base ISA,
> > incompatible changes had snuck into the specifications - for example th=
e
> > Zicsr and Zifencei extensions were spun out of the base ISA.
> >
> > Fast forward to today, and the reason for this patch.
> > Currently the riscv,isa dt property permits only a specific subset of
> > the ISA string - in particular it excludes version numbering.
> > With the current constraints, it is not possible to discern whether
> > "rv64i" means that the hart supports the fence.i instruction, for
> > example.
> > Future systems may choose to implement their own instruction fencing,
> > perhaps using a vendor extension, or they may not implement the optiona=
l
> > counter extensions. Software needs a way to determine this.
> >
> > versioning schemes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > "Use the extension versions that are described in the ISA manual" you
> > may say, and it's not like this has not been considered.
> > Firstly, software that parses the riscv,isa property at runtime will
> > need to contain a lookup table of some sort that maps arbitrary version=
s
> > to versions it understands. There is not a consistent application of
> > version number applied to extensions, with a higgledy-piggledy
> > collection of tags, "bare" and version documents awaiting the reader on
> > the "recently ratified extensions" page:
> > https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
> >
> >       As an aside, this is reflected in the patch too, since many
> >       extensions have yet to appear in a release of the ISA specs,
> >       and are defined by commits in their respective "working draft"
> >       repositories.
> >
> > Secondly, there is an issue of backwards compatibility, whereby allowin=
g
> > numbers in the ISA string, some parsers may be broken. This would
> > require an additional property to be created to even use the versions i=
n
> > this manner.
> >
> > boolean properties
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > If a new property is needed, the whole approach may as well be looked a=
t
> > from the bottom up. A string with limited character choices etc is
> > hardly the best approach for communicating extension information to
> > software.
> >
> > Switching to using boolean properties, one per extension, allows us to
> > define explicit meanings for the DT representation of each extension -
> > rather than the current situation where different operating systems or
> > other bits of software may impart different meanings to characters in
> > the string. Clearly the best source of meanings is the specifications
> > themselves, this just provides us the ability to choose at what point
> > in time the meaning is set. If an extension changes incompatibility in
> > the future, a new property will be required.
> >
> > Off-list, some of the RVI folks have committed to shoring up the wordin=
g
> > in either the ISA specifications, the riscv-isa-manual or
> > so that in the future, modifications to and additions or removals of
> > features will require a new extension. Codifying that assertion
> > somewhere would make it quite unlikely that compatibility would be
> > broken, but we have the tools required to deal with it, if & when it
> > crops up.
> > It is in our collective interest, as consumers of extension meanings, t=
o
> > define a scheme that enforces compatibility.
> >
> > The use of boolean properties, rather than elements in a string, will
> > also permit validation that the strings have a meaning, as well as
> > potentially reject mutually exclusive combinations, or enforce
> > dependencies between instructions. That would not be possible with the
> > current dt-schema infrastructure for arbitrary strings, as we would nee=
d
> > to add a riscv,isa parser to dt-validate!
> >       That's not implemented in this patch, but rather left as
> >       future work!
> >
> > acpi
> > =3D=3D=3D=3D
> >
> > The current ACPI ECR is based on having a string unfortunately, but
> > ideally ACPI will move to another method, perhaps GUIDs, that give
> > explicit meaning to extensions.
> >
> > parser simplicity
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Many systems that parse DT at runtime already implement an function tha=
t
> > can check for the presence of boolean properties, rather than having to
> > implement - although unfortunately for backwards compatibility with old
> > dtbs, existing parsers may not be removable - which may greatly simplif=
y
> > dt parsing code. For example, in Linux, checking for an extension
> > becomes as simple as:
> >       of_property_present(node, "riscv,isa-extension-zicbom")
> >
> > vendor extensions
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Compared to riscv,isa, this proposed scheme promotes vendor extensions,
> > oft touted as the strength of RISC-V, to first-class citizens.
> > At present, extensions are defined as meaning what the RISC-V ISA
> > specifications say they do. There is no realistic way of using that
> > interface to provide cross-platform definitions for what vendor
> > extensions mean. Vendor extensions may also have even less consistency
> > than RVI do in terms of versioning, or no care about backwards
> > compatibility.
> > A boolean property allows us to assign explicit meanings on a per vendo=
r
> > extension basis, backed up by a description of their meanings.
> >
> > fin
> > =3D=3D=3D
> >
> > Create a new file to store the extension meanings, each in the form
> > riscv,isa-extension-<foo> and a new riscv,isa-base property to replace
> > the missing aspect of riscv,isa - the base ISA implemented by a hart.
> > As a starting point, properties were added for extensions currently use=
d
> > in Linux.
> >
> > Finally, mark riscv,isa as deprecated. o7.
> >
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > CC: Alistair Francis <alistair.francis@wdc.com>
> > CC: Andrew Jones <ajones@ventanamicro.com>
> > CC: Anup Patel <apatel@ventanamicro.com>
> > CC: Atish Patra <atishp@atishpatra.org>
> > CC: Jessica Clarke <jrtc27@jrtc27.com>
> > CC: Rick Chen <rick@andestech.com>
> > CC: Leo <ycliang@andestech.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: qemu-riscv@nongnu.org
> > CC: u-boot@lists.denx.de
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > I've tried to CC a few folks here that would care about this, but I am
> > sure there are more. I'll go cross-post it to sw-dev, if it allows me t=
o
> > post there...
> > ---
> >  .../devicetree/bindings/riscv/cpus.yaml       |  45 +--
> >  .../devicetree/bindings/riscv/extensions.yaml | 259 ++++++++++++++++++
> >  2 files changed, 282 insertions(+), 22 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/extensions.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docume=
ntation/devicetree/bindings/riscv/cpus.yaml
> > index 3d2934b15e80..446801fb7495 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -23,6 +23,9 @@ description: |
> >    two cores, each of which has two hyperthreads, could be described as
> >    having four harts.
> >
> > +allOf:
> > +  - $ref: extensions.yaml
> > +
> >  properties:
> >    compatible:
> >      oneOf:
> > @@ -79,25 +82,6 @@ properties:
> >      description:
> >        The blocksize in bytes for the Zicboz cache operations.
> >
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
> >
> > @@ -133,8 +117,13 @@ properties:
> >        DMIPS/MHz, relative to highest capacity-dmips-mhz
> >        in the system.
> >
> > +oneOf:
> > +  - required:
> > +      - riscv,isa
>
> This is the part Anup keeps reminding me about. We can create better ways
> to handle extensions in DT and ACPI, but we'll still need to parse ISA
> strings to handle legacy DTs and holdouts that keep creating ISA strings,
> at least during the deprecation period, since ISA strings are still "the
> way to do it" according to the spec.

Coming up with an alternate way in DT is fine but we can't deprecate
ISA strings since ISA strings are widely used:
1) Various bootloaders
2) It is part of /proc/cpuinfo
3) Hypervisors use it to communicate HW features to Guest/VM.
Hypervisors can't get away from generating ISA strings because
Hypervisors don't know what is running inside Guest/VM.

In the case of ACPI, it is a very different situation. Like Sunil mentioned=
,
ACPI will always follow mechanisms defined by RVI (such as ISA string).
Other ACPI approaches such as GUID for ISA extension are simply not
scalable and will take a lot more memory for ACPI tables compared to
ISA strings.

>
> Also, if we assume the wording in the spec does get shored up, then,
> unless I'm missing something, the list of advantages for this boolean
> proposal from your commit message would be

IMO, we should try our best to have the wordings changed in RVI spec.

>
> * More character choices for name -- probably not a huge gain for ratifie=
d
>   extensions, since the boolean properties will likely still use the same
>   name as the ISA string (riscv,isa-extension-<name>). But, for vendor
>   extensions, this is indeed a major improvement, since vendor extension
>   boolean property names may need to be extended in unambiguous ways to
>   handle changes in the extension.
>
> * Simpler, more complete DT validation (but we still need a best effort
>   for legacy ISA strings)
>
> * Simpler DT parsing (but we still need the current parser for legacy ISA
>   strings)
>
> > +  - required:
> > +      - riscv,isa-base
> > +
> >  required:
> > -  - riscv,isa
> >    - interrupt-controller
> >
> >  additionalProperties: true
> > @@ -177,7 +166,13 @@ examples:
> >                  i-tlb-size =3D <32>;
> >                  mmu-type =3D "riscv,sv39";
> >                  reg =3D <1>;
> > -                riscv,isa =3D "rv64imafdc";
> > +                riscv,isa-base =3D "rv64i";
> > +                riscv,isa-extension-i;
> > +                riscv,isa-extension-m;
> > +                riscv,isa-extension-a;
> > +                riscv,isa-extension-f;
> > +                riscv,isa-extension-d;
> > +                riscv,isa-extension-c;

One downside of this new approach is it will increase the size of DTB.
Imaging 50 such DT properties in 46 CPU DT nodes.

Regards,
Anup

> >                  tlb-split;
> >                  cpu_intc1: interrupt-controller {
> >                          #interrupt-cells =3D <1>;
> > @@ -196,7 +191,13 @@ examples:
> >                  device_type =3D "cpu";
> >                  reg =3D <0>;
> >                  compatible =3D "riscv";
> > -                riscv,isa =3D "rv64imafdc";
> > +                riscv,isa-base =3D "rv64i";
> > +                riscv,isa-extension-i;
> > +                riscv,isa-extension-m;
> > +                riscv,isa-extension-a;
> > +                riscv,isa-extension-f;
> > +                riscv,isa-extension-d;
> > +                riscv,isa-extension-c;
> >                  mmu-type =3D "riscv,sv48";
> >                  interrupt-controller {
> >                          #interrupt-cells =3D <1>;
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
>
> > +  meaning they are ratified by RISC-V International, and others are "v=
endor"
> > +  extensions.  This document defines properties that indicate whether =
a hart
> > +  supports a given extensions.
>
> drop 'a' or depluralize 'extensions'
>
> > +
> > +  Once a standard extension has been ratified, no features can be adde=
d or
>
> I'd change 'features' to 'changes in behavior', and then...
>
> > +  removed without the creation of a new extension for that sub- or sup=
er-set.
>
> ...drop 'for that sub- or super-set'
>
> > +  The properties for standard extensions therefore map to their origin=
ally
> > +  ratified states, with the exception of the I, Zicntr & Zihpm extensi=
ons.
>
> Can you elaborate on the exceptions? Or, if the exceptions are described
> below, maybe a '(see below)' here would help ease the reader's
> insecurities about their lack of knowledge about these exceptions, as
> they'll see that the education is coming :-)
>
> > +
> > +select:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: riscv
> > +
> > +properties:
> > +  riscv,isa:
> > +    description:
> > +      Identifies the specific RISC-V instruction set architecture
> > +      supported by the hart.  These are documented in the RISC-V
> > +      User-Level ISA document, available from
> > +      https://riscv.org/specifications/
> > +
> > +      Due to revisions of the ISA specification, some deviations
> > +      have arisen over time.
> > +      Notably, riscv,isa was defined prior to the creation of the
> > +      Zicsr and Zifencei extensions and thus "i" implies
> > +      "zicsr_zifencei".
> > +
> > +      While the isa strings in ISA specification are case
>                                  ^ the
>
>                                  (but I see this was a faithful move
>                                  of the current text, so maybe better
>                                  to fix it up separately)
>
> > +      insensitive, letters in the riscv,isa string must be all
> > +      lowercase to simplify parsing.
> > +
> > +      This property has been deprecated due to disparity between the
> > +      extension at the time of its creation and ratification of the
> > +      base ISA.
> > +
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(=
?:_[hsxz](?:[a-z])+)*$
> > +    deprecated: true
> > +
> > +  riscv,isa-base:
> > +    description:
> > +      The base ISA implemented by this hart, as described by the 20191=
213
> > +      version of the unprivileged ISA specification.
> > +    enum:
> > +      - rv32i
> > +      - rv64i
> > +
> > +  riscv,isa-extension-i:
> > +    type: boolean
> > +    description:
> > +      The base integer instruction set, as ratified in the 20191213 ve=
rsion of the
> > +      unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-m:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for integer multiplication and division=
, as
> > +      ratified in the 20191213 version of the unprivileged ISA specifi=
cation.
> > +
> > +  riscv,isa-extension-a:
> > +    type: boolean
> > +    description:
> > +      The standard A extension for atomic instructions, as ratified in=
 the
> > +      20191213 version of the unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-f:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for single-precision floating point, as
>                       ^ F
>
> > +      ratified in the 20191213 version of the unprivileged ISA specifi=
cation.
> > +
> > +  riscv,isa-extension-d:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for double-precision floating-point, as
>                       ^ D
>
> > +      ratified in the 20191213 version of the unprivileged ISA specifi=
cation.
> > +
> > +  riscv,isa-extension-q:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for quad-precision floating-point, as r=
atified in
>                       ^ Q
>
> > +      the 20191213 version of the unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-c:
> > +    type: boolean
> > +    description:
> > +      The standard M extension for compressed instructions, as ratifie=
d in the
>                       ^ C
>
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
>
> > +      version of the privileged ISA specification.
> > +
> > +  # Additional Standard Extensions, sorted by category then alphabetic=
ally
>
> Can we just do pure alphabetically? And the single-letter extensions abov=
e
> don't have a "sorted by" comment above them. I guess they need one, or
> maybe they can also be alphabetical?
>
> > +
> > +  riscv,isa-extension-zicntr:
> > +    type: boolean
> > +    description:
> > +      The standard Zicntr extension for base counters and timers, as r=
atified
> > +      in the 20191213 version of the unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-zicsr:
> > +    type: boolean
> > +    description:
> > +      The standard Zicsr extension for control and status register ins=
tructions,
> > +      as ratified in the 20191213 version of the unprivileged ISA spec=
ification.
> > +
> > +  riscv,isa-extension-zifencei:
> > +    type: boolean
> > +    description:
> > +      The standard Zifencei extension for instruction-fetch fence, as =
ratified
> > +      in the 20191213 version of the unprivileged ISA specification.
> > +
> > +  riscv,isa-extension-zihpm:
> > +    type: boolean
> > +    description:
> > +      The standard Zihpm extension for hardware performance counters, =
as
> > +      ratified in the 20191213 version of the unprivileged ISA specifi=
cation.
> > +
> > +  riscv,isa-extension-zicbom:
> > +    type: boolean
> > +    description:
> > +      The standard Zicbom extension for base cache management operatio=
ns as
> > +      ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-=
CMOs.
> > +
> > +  riscv,isa-extension-zicbop:
> > +    type: boolean
> > +    description:
> > +      The standard Zicbop extension for cache-block prefetch instructi=
ons as
> > +      ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-=
CMOs.
> > +
> > +  riscv,isa-extension-zicboz:
> > +    type: boolean
> > +    description:
> > +      The standard  Zicbomz extension for cache-block zeroing as ratif=
ied in
>                      ^ ^Zicboz
>                      ^ extra space
>
> (The repetition is making my vision blur, so I'm feeling like I should
> write a script to compare $a and $b, where $a is riscv,isa-extension-$a
> and $b is 'The standard $b' to make sure they match :-) But I probably
> won't...
>
> > +      commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
> > +
> > +  riscv,isa-extension-zihintpause:
> > +    type: boolean
> > +    description: |
> > +      The standard Zihintpause extension for pause hints, as ratified =
in
> > +      commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manu=
al.
> > +
> > +  riscv,isa-extension-zba:
> > +    type: boolean
> > +    description: |
> > +      The standard Zba bit-manipulation extension for address generati=
on
> > +      acceleration instructions as ratified at commit 6d33919 ("Merge =
pull
> > +      request #158 from hirooih/clmul-fix-loop-end-condition") of
> > +      riscv-bitmanip.
> > +
> > +  riscv,isa-extension-zbb:
> > +    type: boolean
> > +    description: |
> > +      The standard Zbb bit-manipulation extension for basic bit-manipu=
lation as
> > +      atified at commit 6d33919 ("Merge pull request #158 from
>          ^ ratified
>
> > +      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
> > +
> > +  riscv,isa-extension-zbc:
> > +    type: boolean
> > +    description: |
> > +      The standard Zbc bit-manipulation extension for carry-less multi=
plication
> > +      as ratified at commit 6d33919 ("Merge pull request #158 from
> > +      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
> > +
> > +  riscv,isa-extension-zbs:
> > +    type: boolean
> > +    description: |
> > +      The standard Zbs bit-manipulation extension for single-bit instr=
uctions
> > +      as ratified at commit 6d33919 ("Merge pull request #158 from
> > +      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
> > +
> > +  riscv,isa-extension-ztso:
> > +    type: boolean
> > +    description:
> > +      The standard Ztso extension for total store ordering, as ratifie=
d in
> > +      commit 2e5236 ("Ztso is now ratified.") of the riscv-isa-manual.
> > +
> > + # Standard Supervisor-level Extensions, sorted by category then alpha=
betically
>
> The spec only says alphabetical sorting for supervisor-level extensions,
> no category.
>
> > +
> > +  'riscv,isa-extension-smaia':
> > +    type: boolean
> > +    description: |
> > +      The standard Smaia supervisor-level extension for the advanced i=
nterrupt
> > +      architecture for machine-mode-visible csr and behavioural change=
s to
> > +      interrupts as frozen at commit ccbddab ("Merge pull request #42 =
from
> > +      riscv/jhauser-2023-RC4") of riscv-aia.
> > +
> > +  riscv,isa-extension-ssaia:
> > +    type: boolean
> > +    description: |
> > +      The standard Ssaia supervisor-level extension for the advanced i=
nterrupt
> > +      architecture for supervisor-mode-visible csr and behavioural cha=
nges to
> > +      interrupts as frozen at commit ccbddab ("Merge pull request #42 =
from
> > +      riscv/jhauser-2023-RC4") of riscv-aia.
> > +
> > +  riscv,isa-extension-sscofpmf:
> > +    type: boolean
> > +    description: |
> > +      The standard supervisor-level extension for count overflow and m=
ode-based
>                      ^ Sscofpmf
>
> > +      filtering as ratified at commit 01d1df0 ("Add ability to manuall=
y trigger
> > +      workflow. (#2)") of riscv-count-overflow.
> > +
> > +  riscv,isa-extension-sstc:
> > +    type: boolean
> > +    description:
> > +      The standard supervisor-level extension for time compare
>                      ^ Sstc
>
> > +      as ratified at commit 3f9ed34 ("Add ability to manually trigger
> > +      workflow. (#2)") of riscv-time-compare.
> > +
> > +  riscv,isa-extension-svinval:
> > +    type: boolean
> > +    description:
> > +      The standard Svinval supervisor-level extension for fine-grained
> > +      address-translation cache invalidation as ratified in the 201912=
13 version
> > +      of the privileged ISA specification.
> > +
> > +  riscv,isa-extension-svnapot:
> > +    type: boolean
> > +    description:
> > +      The standard Svnapot supervisor-level extensions for napot trans=
lation
> > +      contiguity as ratified in the 20191213 version of the privileged=
 ISA
> > +      specification.
> > +
> > +  riscv,isa-extension-svpbmt:
> > +    type: boolean
> > +    description:
> > +      The standard Svpbmt supervisor-level extensions for page-based m=
emory
> > +      types as ratified in the 20191213 version of the privileged ISA
> > +      specification.
> > +
> > +additionalProperties: true
> > +...
> > --
> > 2.39.2
> >
>
> I'll take your word for it on the versions/dates/commit hashes referenced=
,
> at least until we get closer to actually merging this.
>
> Thanks,
> drew
