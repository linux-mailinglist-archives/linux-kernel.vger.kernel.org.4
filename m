Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F162C74000A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjF0PtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjF0PtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:49:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8D219A4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:49:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso25191575ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1687880947; x=1690472947;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/zzI9WTifIh7mB6MxEEvFEb080gqJF87rhj08R5xZc=;
        b=AreweTlsOq7rEaDd5rYNZPMXr06zBU+6IL3WxHu2EOQPdBwZfduqMvScBrxemlxVuc
         8JAwT/+n0US464oBLoe7rBAHSXIphKDpRre7cEi0QVx0Xt1U4aBAl0L8F3BRfVTrb0Ko
         0NEyW26udjRrnh4z5jEo0hPY3oLJg/9Gl2aR/uVqfjOtcGw8U4ZQKntepS5cXugcdR0F
         HzS9DGeJig+r2R3z8YRAr0zwL4pTC2LxBeLSfM6UsOC0lWAq/ab2jGqhoW+DkIP0yUWl
         t2GO7CzJyZsr6lcyzW31r65sjpWOY8IYIJkdKNWbRwgSRxXhnqa5ikmXhPDiaQ6Pt12u
         t/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687880947; x=1690472947;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/zzI9WTifIh7mB6MxEEvFEb080gqJF87rhj08R5xZc=;
        b=hy/U5njK9jD4PJmf7OQNtF3tKOanRqo/XL6++erRsC1HG1eitg/oCnYpmkJ9WPKN75
         /JjP+PWM+Ty9ByP8wGMFrqNWbb8tcwBn+8M78hwokXHAzmwhrY/VPQURuhsZJLGPC2CY
         Vp9p7N6myLF4QYzj9YqOiobRKjIIjCRU7Fp3zsLyAWGhz55nNp7k6OuG0BqTZ/9+/Wgc
         XV0SMpVH54ntEVlNVHIa+kr+yeECBy+f43MCDH7g+f7Rk+rfZm4GM2fyyP7thcyXLezO
         1NEuQBL30t7EMQeYwPZgkvV69OcdB2vGoyOQyoauHINIm10jZONWziCMoboAVqhE2EDt
         8u7g==
X-Gm-Message-State: AC+VfDyWjM5SwJPRlokp4HfhAbYriSk5nPoijm+HkK06PIg1dmdxyle6
        iRmbfkRYS8Y8OMmVAYgQGF89Bg==
X-Google-Smtp-Source: ACHHUZ7tn08+tDgIIFMOlG9UrRlE6w4zD+NCnfo3ZCq1ND935NzmGYvMkedknN/e32qbdkxQYqtlOA==
X-Received: by 2002:a17:903:245:b0:1ac:451d:34a with SMTP id j5-20020a170903024500b001ac451d034amr12067763plh.33.1687880947298;
        Tue, 27 Jun 2023 08:49:07 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c08400b001b7fd4de08bsm4366880pld.129.2023.06.27.08.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:49:06 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:49:06 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Jun 2023 08:49:04 PDT (-0700)
Subject:     Re: [PATCH v3] dt-bindings: riscv: deprecate riscv,isa
In-Reply-To: <CAK9=C2U4BkJKH36r7C7TocEpDjqMJwrmpSL_cyWCveohQ+j_zg@mail.gmail.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        ajones@ventanamicro.com, atishp@atishpatra.org, jrtc27@jrtc27.com,
        rick@andestech.com, ycliang@andestech.com,
        oleksii.kurochko@gmail.com, linux-riscv@lists.infradead.org,
        qemu-riscv@nongnu.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     apatel@ventanamicro.com
Message-ID: <mhng-ac8c0366-c236-4a7f-b351-b59e2d9a19ab@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 23:52:06 PDT (-0700), apatel@ventanamicro.com wrote:
> On Tue, Jun 27, 2023 at 1:23 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>>
>> On Mon, 26 Jun 2023 10:38:43 PDT (-0700), apatel@ventanamicro.com wrote:
>> > On Mon, Jun 26, 2023 at 3:42 PM Conor Dooley <conor.dooley@microchip.com> wrote:
>> >>
>> >> intro
>> >> =====
>> >>
>> >> When the RISC-V dt-bindings were accepted upstream in Linux, the base
>> >> ISA etc had yet to be ratified. By the ratification of the base ISA,
>> >> incompatible changes had snuck into the specifications - for example the
>> >> Zicsr and Zifencei extensions were spun out of the base ISA.
>> >>
>> >> Fast forward to today, and the reason for this patch.
>> >> Currently the riscv,isa dt property permits only a specific subset of
>> >> the ISA string - in particular it excludes version numbering.
>> >> With the current constraints, it is not possible to discern whether
>> >> "rv64i" means that the hart supports the fence.i instruction, for
>> >> example.
>> >> Future systems may choose to implement their own instruction fencing,
>> >> perhaps using a vendor extension, or they may not implement the optional
>> >> counter extensions. Software needs a way to determine this.
>> >>
>> >> versioning schemes
>> >> ==================
>> >>
>> >> "Use the extension versions that are described in the ISA manual" you
>> >> may say, and it's not like this has not been considered.
>> >> Firstly, software that parses the riscv,isa property at runtime will
>> >> need to contain a lookup table of some sort that maps arbitrary versions
>> >> to versions it understands. There is not a consistent application of
>> >> version number applied to extensions, with a higgledy-piggledy
>> >> collection of tags, "bare" and versioned documents awaiting the reader
>> >> on the "recently ratified extensions" page:
>> >> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
>> >>
>> >>         As an aside, and this is reflected in the patch too, since many
>> >>         extensions have yet to appear in a release of the ISA specs,
>> >>         they are defined by commits in their respective "working draft"
>> >>         repositories.
>> >>
>> >> Secondly, there is an issue of backwards compatibility, whereby allowing
>> >> numbers in the ISA string, some parsers may be broken. This would
>> >> require an additional property to be created to even use the versions in
>> >> this manner.
>> >>
>> >> ~boolean properties~ string array property
>> >> ==========================================
>> >>
>> >> If a new property is needed, the whole approach may as well be looked at
>> >> from the bottom up. A string with limited character choices etc is
>> >> hardly the best approach for communicating extension information to
>> >> software.
>> >>
>> >> Switching to using properties that are defined on a per extension basis,
>> >> allows us to define explicit meanings for the DT representation of each
>> >> extension - rather than the current situation where different operating
>> >> systems or other bits of software may impart different meanings to
>> >> characters in the string.
>> >> Clearly the best source of meanings is the specifications themselves,
>> >> this just provides us the ability to choose at what point in time the
>> >> meaning is set. If an extension changes incompatibility in the future,
>> >> a new property will be required.
>> >>
>> >> Off-list, some of the RVI folks have committed to shoring up the wording
>> >> in either the ISA specifications, the riscv-isa-manual or
>> >> so that in the future, modifications to and additions or removals of
>> >> features will require a new extension. Codifying that assertion
>> >> somewhere would make it quite unlikely that compatibility would be
>> >> broken, but we have the tools required to deal with it, if & when it
>> >> crops up.
>> >> It is in our collective interest, as consumers of extension meanings, to
>> >> define a scheme that enforces compatibility.
>> >>
>> >> The use of individual properties, rather than elements in a single
>> >> string, will also permit validation that the properties have a meaning,
>> >> as well as potentially reject mutually exclusive combinations, or
>> >> enforce dependencies between extensions. That would not have be possible
>> >> with the current dt-schema infrastructure for arbitrary strings, as we
>> >> would need to add a riscv,isa parser to dt-validate!
>> >> That's not implemented in this patch, but rather left as future work (for
>> >> the brave, or the foolish).
>> >>
>> >> acpi
>> >> ====
>> >>
>> >> The current ACPI ECR is based on having a single ISA string unfortunately,
>> >> but ideally ACPI will move to another method, perhaps GUIDs, that give
>> >> explicit meaning to extensions.
>> >
>> > Drop this paragraph on ACPI.
>> >
>> > We clearly mentioned previously that ACPI will follow specs defined by RVI.
>> > There are scalability issues in using GUIDs for each ISA extension.
>>
>> Which spec are we following for the ACPI ISA string?
>
> ACPI RHCT follows the "ISA Extension Naming Conventions"
> defined by the RISC-V unpriv spec. I understand that there are
> unresolved issues in the "ISA Extension Naming Conventions"
> which should be addressed by RVI and we should also try our
> best to have this fixed in the spec.

Which version of the spec?  We've had a ton of issues related to 
versioning everywhere else the ISA string has been used, we need to know 
specifically which version we're parsing in order to do anything 
meaningful with it.

> In any case, ACPI spec is owned by UEFI forum so it does
> not make sense to define/recommend anything for ACPI in
> DT bindings.

Unless I missed something this is just a long commit message, it's not 
even in the docs.  If you don't want the DT side to even mention ACPI 
that's fine with me, though, I don't really care.

>
> Regards,
> Anup
>
>
>
>>
>> > Regards,
>> > Anup
>> >
>> >>
>> >> parser simplicity
>> >> =================
>> >>
>> >> Many systems that parse DT at runtime already implement an function that
>> >> can check for the presence of a string in an array of string, as it is
>> >> similar to the process for parsing a list of compatible strings, so a
>> >> bunch of new, custom, DT parsing should not be needed.
>> >> Getting rid of "riscv,isa" parsing would be a nice simplification, but
>> >> unfortunately for backwards compatibility with old dtbs, existing
>> >> parsers may not be removable - which may greatly simplify
>> >> dt parsing code. In Linux, for example, checking for whether a hart
>> >> supports an extension becomes as simple as:
>> >>         of_property_match_string(node, "riscv,isa-extensions", "zicbom")
>> >>
>> >> vendor extensions
>> >> =================
>> >>
>> >> Compared to riscv,isa, this proposed scheme promotes vendor extensions,
>> >> oft touted as the strength of RISC-V, to first-class citizens.
>> >> At present, extensions are defined as meaning what the RISC-V ISA
>> >> specifications say they do. There is no realistic way of using that
>> >> interface to provide cross-platform definitions for what vendor
>> >> extensions mean. Vendor extensions may also have even less consistency
>> >> than RVI do in terms of versioning, or no care about backwards
>> >> compatibility.
>> >> The new property allows us to assign explicit meanings on a per vendor
>> >> extension basis, backed up by a description of their meanings.
>> >>
>> >> fin
>> >> ===
>> >>
>> >> Create a new file to store the extension meanings and a new
>> >> riscv,isa-base property to replace the aspect of riscv,isa that is
>> >> not represented by the new property - the base ISA implemented by a hart.
>> >>
>> >> As a starting point, add properties for extensions currently used in
>> >> Linux.
>> >>
>> >> Finally, mark riscv,isa as deprecated, as removing support for it in
>> >> existing programs would be an ABI break.
>> >>
>> >> CC: Palmer Dabbelt <palmer@dabbelt.com>
>> >> CC: Paul Walmsley <paul.walmsley@sifive.com>
>> >> CC: Rob Herring <robh+dt@kernel.org>
>> >> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> >> CC: Alistair Francis <alistair.francis@wdc.com>
>> >> CC: Andrew Jones <ajones@ventanamicro.com>
>> >> CC: Anup Patel <apatel@ventanamicro.com>
>> >> CC: Atish Patra <atishp@atishpatra.org>
>> >> CC: Jessica Clarke <jrtc27@jrtc27.com>
>> >> CC: Rick Chen <rick@andestech.com>
>> >> CC: Leo <ycliang@andestech.com>
>> >> CC: Oleksii <oleksii.kurochko@gmail.com>
>> >> CC: linux-riscv@lists.infradead.org
>> >> CC: qemu-riscv@nongnu.org
>> >> CC: u-boot@lists.denx.de
>> >> CC: devicetree@vger.kernel.org
>> >> CC: linux-kernel@vger.kernel.org
>> >> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> >> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>> >> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>> >> ---
>> >> Changes in v3:
>> >> - Per Rob's suggestion, switch to an array of strings. Cuts down on the
>> >>   size, compared to booleans. It has a standard mechanism for parsing
>> >>   (you need to parse arrays of strings for compatibles). It still allows
>> >>   for having a limited set of explicitly defined properties - so the
>> >>   advantages over a free-form string still apply.
>> >> - Pick up Palmer's Ack and Review (although I expect that he will be the
>> >>   one to apply this).
>> >> ---
>> >>  .../devicetree/bindings/riscv/cpus.yaml       |  43 ++-
>> >>  .../devicetree/bindings/riscv/extensions.yaml | 245 ++++++++++++++++++
>> >>  2 files changed, 265 insertions(+), 23 deletions(-)
>> >>  create mode 100644 Documentation/devicetree/bindings/riscv/extensions.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> >> index 67bd239ead0b..74bc92591086 100644
>> >> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
>> >> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
>> >> @@ -25,6 +25,7 @@ description: |
>> >>
>> >>  allOf:
>> >>    - $ref: /schemas/cpu.yaml#
>> >> +  - $ref: extensions.yaml
>> >>
>> >>  properties:
>> >>    compatible:
>> >> @@ -82,25 +83,6 @@ properties:
>> >>      description:
>> >>        The blocksize in bytes for the Zicboz cache operations.
>> >>
>> >> -  riscv,isa:
>> >> -    description:
>> >> -      Identifies the specific RISC-V instruction set architecture
>> >> -      supported by the hart.  These are documented in the RISC-V
>> >> -      User-Level ISA document, available from
>> >> -      https://riscv.org/specifications/
>> >> -
>> >> -      Due to revisions of the ISA specification, some deviations
>> >> -      have arisen over time.
>> >> -      Notably, riscv,isa was defined prior to the creation of the
>> >> -      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
>> >> -      implies "zicntr_zicsr_zifencei_zihpm".
>> >> -
>> >> -      While the isa strings in ISA specification are case
>> >> -      insensitive, letters in the riscv,isa string must be all
>> >> -      lowercase.
>> >> -    $ref: /schemas/types.yaml#/definitions/string
>> >> -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> >> -
>> >>    # RISC-V has multiple properties for cache op block sizes as the sizes
>> >>    # differ between individual CBO extensions
>> >>    cache-op-block-size: false
>> >> @@ -139,8 +121,17 @@ properties:
>> >>        DMIPS/MHz, relative to highest capacity-dmips-mhz
>> >>        in the system.
>> >>
>> >> +oneOf:
>> >> +  - required:
>> >> +      - riscv,isa
>> >> +  - required:
>> >> +      - riscv,isa-base
>> >> +
>> >> +dependencies:
>> >> +  riscv,isa-base: [ "riscv,isa-extensions" ]
>> >> +  riscv,isa-extensions: [ "riscv,isa-base" ]
>> >> +
>> >>  required:
>> >> -  - riscv,isa
>> >>    - interrupt-controller
>> >>
>> >>  unevaluatedProperties: false
>> >> @@ -160,7 +151,9 @@ examples:
>> >>                  i-cache-sets = <128>;
>> >>                  i-cache-size = <16384>;
>> >>                  reg = <0>;
>> >> -                riscv,isa = "rv64imac";
>> >> +                riscv,isa-base = "rv64i";
>> >> +                riscv,isa-extensions = "i", "m", "a", "c";
>> >> +
>> >>                  cpu_intc0: interrupt-controller {
>> >>                          #interrupt-cells = <1>;
>> >>                          compatible = "riscv,cpu-intc";
>> >> @@ -183,8 +176,10 @@ examples:
>> >>                  i-tlb-size = <32>;
>> >>                  mmu-type = "riscv,sv39";
>> >>                  reg = <1>;
>> >> -                riscv,isa = "rv64imafdc";
>> >>                  tlb-split;
>> >> +                riscv,isa-base = "rv64i";
>> >> +                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
>> >> +
>> >>                  cpu_intc1: interrupt-controller {
>> >>                          #interrupt-cells = <1>;
>> >>                          compatible = "riscv,cpu-intc";
>> >> @@ -202,8 +197,10 @@ examples:
>> >>                  device_type = "cpu";
>> >>                  reg = <0>;
>> >>                  compatible = "riscv";
>> >> -                riscv,isa = "rv64imafdc";
>> >>                  mmu-type = "riscv,sv48";
>> >> +                riscv,isa-base = "rv64i";
>> >> +                riscv,isa-extensions = "i", "m", "a", "f", "d", "c";
>> >> +
>> >>                  interrupt-controller {
>> >>                          #interrupt-cells = <1>;
>> >>                          interrupt-controller;
>> >> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> >> new file mode 100644
>> >> index 000000000000..af98307f2c2c
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
>> >> @@ -0,0 +1,245 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/riscv/extensions.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: RISC-V ISA extensions
>> >> +
>> >> +maintainers:
>> >> +  - Paul Walmsley <paul.walmsley@sifive.com>
>> >> +  - Palmer Dabbelt <palmer@sifive.com>
>> >> +  - Conor Dooley <conor@kernel.org>
>> >> +
>> >> +description: |
>> >> +  RISC-V has a large number of extensions, some of which are "standard"
>> >> +  extensions, meaning they are ratified by RISC-V International, and others
>> >> +  are "vendor" extensions.
>> >> +  This document defines properties that indicate whether a hart supports a
>> >> +  given extension.
>> >> +
>> >> +  Once a standard extension has been ratified, no changes in behaviour can be
>> >> +  made without the creation of a new extension.
>> >> +  The properties for standard extensions therefore map to their originally
>> >> +  ratified states, with the exception of the I, Zicntr & Zihpm extensions.
>> >> +  See the "i" property for more information.
>> >> +
>> >> +select:
>> >> +  properties:
>> >> +    compatible:
>> >> +      contains:
>> >> +        const: riscv
>> >> +
>> >> +properties:
>> >> +  riscv,isa:
>> >> +    description:
>> >> +      Identifies the specific RISC-V instruction set architecture
>> >> +      supported by the hart.  These are documented in the RISC-V
>> >> +      User-Level ISA document, available from
>> >> +      https://riscv.org/specifications/
>> >> +
>> >> +      Due to revisions of the ISA specification, some deviations
>> >> +      have arisen over time.
>> >> +      Notably, riscv,isa was defined prior to the creation of the
>> >> +      Zicntr, Zicsr, Zifencei and Zihpm extensions and thus "i"
>> >> +      implies "zicntr_zicsr_zifencei_zihpm".
>> >> +
>> >> +      While the isa strings in ISA specification are case
>> >> +      insensitive, letters in the riscv,isa string must be all
>> >> +      lowercase.
>> >> +    $ref: /schemas/types.yaml#/definitions/string
>> >> +    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
>> >> +    deprecated: true
>> >> +
>> >> +  riscv,isa-base:
>> >> +    description:
>> >> +      The base ISA implemented by this hart, as described by the 20191213
>> >> +      version of the unprivileged ISA specification.
>> >> +    enum:
>> >> +      - rv32i
>> >> +      - rv64i
>> >> +
>> >> +  riscv,isa-extensions:
>> >> +    $ref: /schemas/types.yaml#/definitions/string-array
>> >> +    minItems: 1
>> >> +    description: Extensions supported by the hart.
>> >> +    items:
>> >> +      anyOf:
>> >> +        # single letter extensions, in canonical order
>> >> +        - const: i
>> >> +          description: |
>> >> +            The base integer instruction set, as ratified in the 20191213
>> >> +            version of the unprivileged ISA specification, with the exception of
>> >> +            counter access.
>> >> +            Counter access was removed after the ratification of the 20191213
>> >> +            version of the unprivileged specification and shunted into the
>> >> +            Zicntr and Zihpm extensions.
>> >> +
>> >> +        - const: m
>> >> +          description:
>> >> +            The standard M extension for integer multiplication and division, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: a
>> >> +          description:
>> >> +            The standard A extension for atomic instructions, as ratified in the
>> >> +            20191213 version of the unprivileged ISA specification.
>> >> +
>> >> +        - const: f
>> >> +          description:
>> >> +            The standard F extension for single-precision floating point, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: d
>> >> +          description:
>> >> +            The standard D extension for double-precision floating-point, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: q
>> >> +          description:
>> >> +            The standard Q extension for quad-precision floating-point, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: c
>> >> +          description:
>> >> +            The standard C extension for compressed instructions, as ratified in
>> >> +            the 20191213 version of the unprivileged ISA specification.
>> >> +
>> >> +        - const: v
>> >> +          description:
>> >> +            The standard V extension for vector operations, as ratified
>> >> +            in-and-around commit 7a6c8ae ("Fix text that describes vfmv.v.f
>> >> +            encoding") of the riscv-v-spec.
>> >> +
>> >> +        - const: h
>> >> +          description:
>> >> +            The standard H extension for hypervisors as ratified in the 20191213
>> >> +            version of the privileged ISA specification.
>> >> +
>> >> +        # multi-letter extensions, sorted alphanumerically
>> >> +        - const: smaia
>> >> +          description: |
>> >> +            The standard Smaia supervisor-level extension for the advanced
>> >> +            interrupt architecture for machine-mode-visible csr and behavioural
>> >> +            changes to interrupts as frozen at commit ccbddab ("Merge pull
>> >> +            request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>> >> +
>> >> +        - const: ssaia
>> >> +          description: |
>> >> +            The standard Ssaia supervisor-level extension for the advanced
>> >> +            interrupt architecture for supervisor-mode-visible csr and
>> >> +            behavioural changes to interrupts as frozen at commit ccbddab
>> >> +            ("Merge pull request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
>> >> +
>> >> +        - const: sscofpmf
>> >> +          description: |
>> >> +            The standard Sscofpmf supervisor-level extension for count overflow
>> >> +            and mode-based filtering as ratified at commit 01d1df0 ("Add ability
>> >> +            to manually trigger workflow. (#2)") of riscv-count-overflow.
>> >> +
>> >> +        - const: sstc
>> >> +          description: |
>> >> +            The standard Sstc supervisor-level extension for time compare as
>> >> +            ratified at commit 3f9ed34 ("Add ability to manually trigger
>> >> +            workflow. (#2)") of riscv-time-compare.
>> >> +
>> >> +        - const: svinval
>> >> +          description:
>> >> +            The standard Svinval supervisor-level extension for fine-grained
>> >> +            address-translation cache invalidation as ratified in the 20191213
>> >> +            version of the privileged ISA specification.
>> >> +
>> >> +        - const: svnapot
>> >> +          description:
>> >> +            The standard Svnapot supervisor-level extensions for napot
>> >> +            translation contiguity as ratified in the 20191213 version of the
>> >> +            privileged ISA specification.
>> >> +
>> >> +        - const: svpbmt
>> >> +          description:
>> >> +            The standard Svpbmt supervisor-level extensions for page-based
>> >> +            memory types as ratified in the 20191213 version of the privileged
>> >> +            ISA specification.
>> >> +
>> >> +        - const: zba
>> >> +          description: |
>> >> +            The standard Zba bit-manipulation extension for address generation
>> >> +            acceleration instructions as ratified at commit 6d33919 ("Merge pull
>> >> +            request #158 from hirooih/clmul-fix-loop-end-condition") of
>> >> +            riscv-bitmanip.
>> >> +
>> >> +        - const: zbb
>> >> +          description: |
>> >> +            The standard Zbb bit-manipulation extension for basic bit-manipulation
>> >> +            as ratified at commit 6d33919 ("Merge pull request #158 from
>> >> +            hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>> >> +
>> >> +        - const: zbc
>> >> +          description: |
>> >> +            The standard Zbc bit-manipulation extension for carry-less
>> >> +            multiplication as ratified at commit 6d33919 ("Merge pull request
>> >> +            #158 from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>> >> +
>> >> +        - const: zbs
>> >> +          description: |
>> >> +            The standard Zbs bit-manipulation extension for single-bit
>> >> +            instructions as ratified at commit 6d33919 ("Merge pull request #158
>> >> +            from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
>> >> +
>> >> +        - const: zicbom
>> >> +          description:
>> >> +            The standard Zicbom extension for base cache management operations as
>> >> +            ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>> >> +
>> >> +        - const: zicbop
>> >> +          description:
>> >> +            The standard Zicbop extension for cache-block prefetch instructions
>> >> +            as ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of
>> >> +            riscv-CMOs.
>> >> +
>> >> +        - const: zicboz
>> >> +          description:
>> >> +            The standard Zicboz extension for cache-block zeroing as ratified
>> >> +            in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>> >> +
>> >> +        - const: zicntr
>> >> +          description:
>> >> +            The standard Zicntr extension for base counters and timers, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: zicsr
>> >> +          description:
>> >> +            The standard Zicsr extension for control and status register
>> >> +            instructions, as ratified in the 20191213 version of the
>> >> +            unprivileged ISA specification.
>> >> +
>> >> +        - const: zifencei
>> >> +          description:
>> >> +            The standard Zifencei extension for instruction-fetch fence, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: zihintpause
>> >> +          description:
>> >> +            The standard Zihintpause extension for pause hints, as ratified in
>> >> +            commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
>> >> +
>> >> +        - const: zihpm
>> >> +          description:
>> >> +            The standard Zihpm extension for hardware performance counters, as
>> >> +            ratified in the 20191213 version of the unprivileged ISA
>> >> +            specification.
>> >> +
>> >> +        - const: ztso
>> >> +          description:
>> >> +            The standard Ztso extension for total store ordering, as ratified
>> >> +            in commit 2e5236 ("Ztso is now ratified.") of the
>> >> +            riscv-isa-manual.
>> >> +
>> >> +additionalProperties: true
>> >> +...
>> >> --
>> >> 2.40.1
>> >>
