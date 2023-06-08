Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A939728699
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbjFHRtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjFHRtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:49:15 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7852D42;
        Thu,  8 Jun 2023 10:49:13 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6b15e510630so570461a34.3;
        Thu, 08 Jun 2023 10:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686246551; x=1688838551;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WrR2D8ApD1fWX5hojwIV0SLICJZBdxighBSqahhOUM8=;
        b=fBS41vnK2WJcjx5qe0LvmtHULA/oM25tND85w81ZuAvMo11OAxhfm0qC9ktjrG3yyL
         xATtlxzS6g+FsB5x4xlSkebptvZEqkQ0HbJqCGaIbnRSPxwORy8aAqee8G884pnmPpAd
         2O/FbHd/qBA0fzvIYq7WSyaBuG2pqY+veikpFryBVAJ1LZUNZcNtzVwYHr4XA71hfi1y
         htMc4VL6ZgyF7ENNShp4Q++1XW6deLjHr+wlE3LLPI8rh/RqJ3nxTnvyqYdXyvqYeYMM
         q/qZRdf1hydEFVM0hMXwzpmNFAATHBQ8vpZISkmcueuhGOYlY+0XEgcDOcDbk4OSCBRd
         g85Q==
X-Gm-Message-State: AC+VfDzJEcDvUuc1iLfJiJWPjZz9pgvRfyeBTa6ST9l8Eu0bAuWNNmXH
        1EOfFGvWmzOiw2p/OexQfw==
X-Google-Smtp-Source: ACHHUZ4qqeNQJw4b85sgVojxz/Ckidtai67WfUX7oDZeoaGJMYAmMUojHFYJVgeGOi+p8Mjp87BalA==
X-Received: by 2002:a9d:7a47:0:b0:6ad:e7dc:851d with SMTP id z7-20020a9d7a47000000b006ade7dc851dmr5441669otm.33.1686246551433;
        Thu, 08 Jun 2023 10:49:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056638293800b0041658c1838asm403567jab.81.2023.06.08.10.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 10:49:10 -0700 (PDT)
Received: (nullmailer pid 3085775 invoked by uid 1000);
        Thu, 08 Jun 2023 17:49:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <apatel@ventanamicro.com>, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, Andrew Jones <ajones@ventanamicro.com>,
        palmer@dabbelt.com, Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rick Chen <rick@andestech.com>, linux-kernel@vger.kernel.org,
        Leo <ycliang@andestech.com>
In-Reply-To: <20230608-sitting-bath-31eddc03c5a5@spud>
References: <20230608-sitting-bath-31eddc03c5a5@spud>
Message-Id: <168624654839.3085745.9088493205796442132.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
Date:   Thu, 08 Jun 2023 11:49:08 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 08 Jun 2023 17:54:05 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> intro
> =====
> 
> When the RISC-V dt-bindings were accepted upstream in Linux, the base
> ISA etc had yet to be ratified. By the ratification of the base ISA,
> incompatible changes had snuck into the specifications - for example the
> Zicsr and Zifencei extensions were spun out of the base ISA.
> 
> Fast forward to today, and the reason for this patch.
> Currently the riscv,isa dt property permits only a specific subset of
> the ISA string - in particular it excludes version numbering.
> With the current constraints, it is not possible to discern whether
> "rv64i" means that the hart supports the fence.i instruction, for
> example.
> Future systems may choose to implement their own instruction fencing,
> perhaps using a vendor extension, or they may not implement the optional
> counter extensions. Software needs a way to determine this.
> 
> versioning schemes
> ==================
> 
> "Use the extension versions that are described in the ISA manual" you
> may say, and it's not like this has not been considered.
> Firstly, software that parses the riscv,isa property at runtime will
> need to contain a lookup table of some sort that maps arbitrary versions
> to versions it understands. There is not a consistent application of
> version number applied to extensions, with a higgledy-piggledy
> collection of tags, "bare" and version documents awaiting the reader on
> the "recently ratified extensions" page:
> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
> 
> 	As an aside, this is reflected in the patch too, since many
> 	extensions have yet to appear in a release of the ISA specs,
> 	and are defined by commits in their respective "working draft"
> 	repositories.
> 
> Secondly, there is an issue of backwards compatibility, whereby allowing
> numbers in the ISA string, some parsers may be broken. This would
> require an additional property to be created to even use the versions in
> this manner.
> 
> boolean properties
> ==================
> 
> If a new property is needed, the whole approach may as well be looked at
> from the bottom up. A string with limited character choices etc is
> hardly the best approach for communicating extension information to
> software.
> 
> Switching to using boolean properties, one per extension, allows us to
> define explicit meanings for the DT representation of each extension -
> rather than the current situation where different operating systems or
> other bits of software may impart different meanings to characters in
> the string. Clearly the best source of meanings is the specifications
> themselves, this just provides us the ability to choose at what point
> in time the meaning is set. If an extension changes incompatibility in
> the future, a new property will be required.
> 
> Off-list, some of the RVI folks have committed to shoring up the wording
> in either the ISA specifications, the riscv-isa-manual or
> so that in the future, modifications to and additions or removals of
> features will require a new extension. Codifying that assertion
> somewhere would make it quite unlikely that compatibility would be
> broken, but we have the tools required to deal with it, if & when it
> crops up.
> It is in our collective interest, as consumers of extension meanings, to
> define a scheme that enforces compatibility.
> 
> The use of boolean properties, rather than elements in a string, will
> also permit validation that the strings have a meaning, as well as
> potentially reject mutually exclusive combinations, or enforce
> dependencies between instructions. That would not be possible with the
> current dt-schema infrastructure for arbitrary strings, as we would need
> to add a riscv,isa parser to dt-validate! That's not implemented in this
> patch, but rather left as future work (for the brave, or the foolish).
> 
> acpi
> ====
> 
> The current ACPI ECR is based on having a string unfortunately, but
> ideally ACPI will move to another method, perhaps GUIDs, that give
> explicit meaning to extensions.
> 
> parser simplicity
> =================
> 
> Many systems that parse DT at runtime already implement an function that
> can check for the presence of boolean properties, rather than having to
> implement - although unfortunately for backwards compatibility with old
> dtbs, existing parsers may not be removable - which may greatly simplify
> dt parsing code. For example, in Linux, checking for an extension
> becomes as simple as:
> 	of_property_present(extension_node, "zicbom")
> 
> vendor extensions
> =================
> 
> Compared to riscv,isa, this proposed scheme promotes vendor extensions,
> oft touted as the strength of RISC-V, to first-class citizens.
> At present, extensions are defined as meaning what the RISC-V ISA
> specifications say they do. There is no realistic way of using that
> interface to provide cross-platform definitions for what vendor
> extensions mean. Vendor extensions may also have even less consistency
> than RVI do in terms of versioning, or no care about backwards
> compatibility.
> A boolean property allows us to assign explicit meanings on a per vendor
> extension basis, backed up by a description of their meanings.
> 
> fin
> ===
> 
> Create a new file to store the extension meanings, each of which are
> boolean children of a riscv,isa-extensions node and a new
> riscv,isa-base property to replace the aspect of riscv,isa that is
> not represented by booleans - the base ISA implemented by a hart.
> Originally I proposed properties in the cpu node, rather than as a child
> of the cpu node, but some concerns were raised about the size of the dtb
> for systems with dozens of cpus & dozens of extensions. Using a child
> node, and dropping the "riscv,isa-extension-" prefix saves the guts of
> 20 bytes per extension, per hart, and hopefully placates the size
> conscious.
> 
> As a starting point, add properties for extensions currently used in
> Linux.
> 
> Finally, mark riscv,isa as deprecated, as removing it is an ABI break.
> 
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Paul Walmsley <paul.walmsley@sifive.com>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Alistair Francis <alistair.francis@wdc.com>
> CC: Andrew Jones <ajones@ventanamicro.com>
> CC: Anup Patel <apatel@ventanamicro.com>
> CC: Atish Patra <atishp@atishpatra.org>
> CC: Jessica Clarke <jrtc27@jrtc27.com>
> CC: Rick Chen <rick@andestech.com>
> CC: Leo <ycliang@andestech.com>
> CC: Oleksii <oleksii.kurochko@gmail.com>
> CC: linux-riscv@lists.infradead.org
> CC: qemu-riscv@nongnu.org
> CC: u-boot@lists.denx.de
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - Use Sean's suggestion of a child node to calm fears of bloat
> - Fixup a rake of wording etc issues that Drew pointed out
> 
> As a result of implementing Sean's suggestion, I believe I need to add
> riscv,isa-extensions as an exception to the rules preventing vendor
> properties being of object type, otherwise dt_binding_check is less than
> happy with me.
> 
> I've tried to CC a few folks here that would care about this, but I am
> sure there are more. I'll go cross-post it to sw-dev, if it allows me to
> post there...
> ---
>  .../devicetree/bindings/riscv/cpus.yaml       |  57 ++--
>  .../devicetree/bindings/riscv/extensions.yaml | 278 ++++++++++++++++++
>  2 files changed, 313 insertions(+), 22 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/riscv/extensions.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
	Additional properties are not allowed ('additionalProperties', 'properties' were unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('additionalProperties', 'properties', 'type' were unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/riscv/extensions.yaml: properties:riscv,isa-extensions: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'boolean' was expected
		hint: A vendor boolean property can use "type: boolean"
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230608-sitting-bath-31eddc03c5a5@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

