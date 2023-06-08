Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84FD7285DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbjFHQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjFHQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D091210C;
        Thu,  8 Jun 2023 09:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC4D64F94;
        Thu,  8 Jun 2023 16:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49255C433EF;
        Thu,  8 Jun 2023 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686243318;
        bh=KSvvrTJDyOkdRG5sZ4sFODpUAl/ZxuXgWddUn4si4SY=;
        h=From:To:Cc:Subject:Date:From;
        b=X/8AKrCF+8PYH8K0xnDsfYRGQ93MXbp8rn8FO61OSTqwCsg+44bOQCKmRTkuXS0qa
         f7s5tA9bUhJ2ysdsdypVG4Mwy/9cBv8Vxv3l5HIf+9QR9a1bsHIJqaAKTjdXiKXVGE
         4ilcrf37iLWSy7OqZl2t7aPXU53kftgZid5XB0KW3+ziA0y2+8VrQ1SLmK9AZpnobU
         a/XoOzUorQJX5GPvvIFcLeqF0I77rCw/8l9L6TKFxd4It+vSKZ1LbjvBFYJ2FiUzPm
         yF5BHJZCjO1RkYEkFd/9ubPffJRP6vr7rCVPptCv0SjxUEw7x9ZWoUsZIFL84TlmE5
         orIt9Q+qhhILw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
Date:   Thu,  8 Jun 2023 17:54:05 +0100
Message-Id: <20230608-sitting-bath-31eddc03c5a5@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21286; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=IbV8LStoAI1P8c+YvddUPhGE70DITATuXCD/4gUp0s8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClN7Ksc19d82XVE71q2/xGu6XYuvowlddb1nPGH2xZft lY7E3mho5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABMpNmH4X/FvitUfpzjLN0uM HERiL2smaT19ruIWHK78YNn7LRFt8YwMF6vX35m55IX8h7mKFWs8vaVLxATuym+3jnhxjX2+ktN rdgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

intro
=====

When the RISC-V dt-bindings were accepted upstream in Linux, the base
ISA etc had yet to be ratified. By the ratification of the base ISA,
incompatible changes had snuck into the specifications - for example the
Zicsr and Zifencei extensions were spun out of the base ISA.

Fast forward to today, and the reason for this patch.
Currently the riscv,isa dt property permits only a specific subset of
the ISA string - in particular it excludes version numbering.
With the current constraints, it is not possible to discern whether
"rv64i" means that the hart supports the fence.i instruction, for
example.
Future systems may choose to implement their own instruction fencing,
perhaps using a vendor extension, or they may not implement the optional
counter extensions. Software needs a way to determine this.

versioning schemes
==================

"Use the extension versions that are described in the ISA manual" you
may say, and it's not like this has not been considered.
Firstly, software that parses the riscv,isa property at runtime will
need to contain a lookup table of some sort that maps arbitrary versions
to versions it understands. There is not a consistent application of
version number applied to extensions, with a higgledy-piggledy
collection of tags, "bare" and version documents awaiting the reader on
the "recently ratified extensions" page:
https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions

	As an aside, this is reflected in the patch too, since many
	extensions have yet to appear in a release of the ISA specs,
	and are defined by commits in their respective "working draft"
	repositories.

Secondly, there is an issue of backwards compatibility, whereby allowing
numbers in the ISA string, some parsers may be broken. This would
require an additional property to be created to even use the versions in
this manner.

boolean properties
==================

If a new property is needed, the whole approach may as well be looked at
from the bottom up. A string with limited character choices etc is
hardly the best approach for communicating extension information to
software.

Switching to using boolean properties, one per extension, allows us to
define explicit meanings for the DT representation of each extension -
rather than the current situation where different operating systems or
other bits of software may impart different meanings to characters in
the string. Clearly the best source of meanings is the specifications
themselves, this just provides us the ability to choose at what point
in time the meaning is set. If an extension changes incompatibility in
the future, a new property will be required.

Off-list, some of the RVI folks have committed to shoring up the wording
in either the ISA specifications, the riscv-isa-manual or
so that in the future, modifications to and additions or removals of
features will require a new extension. Codifying that assertion
somewhere would make it quite unlikely that compatibility would be
broken, but we have the tools required to deal with it, if & when it
crops up.
It is in our collective interest, as consumers of extension meanings, to
define a scheme that enforces compatibility.

The use of boolean properties, rather than elements in a string, will
also permit validation that the strings have a meaning, as well as
potentially reject mutually exclusive combinations, or enforce
dependencies between instructions. That would not be possible with the
current dt-schema infrastructure for arbitrary strings, as we would need
to add a riscv,isa parser to dt-validate! That's not implemented in this
patch, but rather left as future work (for the brave, or the foolish).

acpi
====

The current ACPI ECR is based on having a string unfortunately, but
ideally ACPI will move to another method, perhaps GUIDs, that give
explicit meaning to extensions.

parser simplicity
=================

Many systems that parse DT at runtime already implement an function that
can check for the presence of boolean properties, rather than having to
implement - although unfortunately for backwards compatibility with old
dtbs, existing parsers may not be removable - which may greatly simplify
dt parsing code. For example, in Linux, checking for an extension
becomes as simple as:
	of_property_present(extension_node, "zicbom")

vendor extensions
=================

Compared to riscv,isa, this proposed scheme promotes vendor extensions,
oft touted as the strength of RISC-V, to first-class citizens.
At present, extensions are defined as meaning what the RISC-V ISA
specifications say they do. There is no realistic way of using that
interface to provide cross-platform definitions for what vendor
extensions mean. Vendor extensions may also have even less consistency
than RVI do in terms of versioning, or no care about backwards
compatibility.
A boolean property allows us to assign explicit meanings on a per vendor
extension basis, backed up by a description of their meanings.

fin
===

Create a new file to store the extension meanings, each of which are
boolean children of a riscv,isa-extensions node and a new
riscv,isa-base property to replace the aspect of riscv,isa that is
not represented by booleans - the base ISA implemented by a hart.
Originally I proposed properties in the cpu node, rather than as a child
of the cpu node, but some concerns were raised about the size of the dtb
for systems with dozens of cpus & dozens of extensions. Using a child
node, and dropping the "riscv,isa-extension-" prefix saves the guts of
20 bytes per extension, per hart, and hopefully placates the size
conscious.

As a starting point, add properties for extensions currently used in
Linux.

Finally, mark riscv,isa as deprecated, as removing it is an ABI break.

CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Alistair Francis <alistair.francis@wdc.com>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Anup Patel <apatel@ventanamicro.com>
CC: Atish Patra <atishp@atishpatra.org>
CC: Jessica Clarke <jrtc27@jrtc27.com>
CC: Rick Chen <rick@andestech.com>
CC: Leo <ycliang@andestech.com>
CC: Oleksii <oleksii.kurochko@gmail.com>
CC: linux-riscv@lists.infradead.org
CC: qemu-riscv@nongnu.org
CC: u-boot@lists.denx.de
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- Use Sean's suggestion of a child node to calm fears of bloat
- Fixup a rake of wording etc issues that Drew pointed out

As a result of implementing Sean's suggestion, I believe I need to add
riscv,isa-extensions as an exception to the rules preventing vendor
properties being of object type, otherwise dt_binding_check is less than
happy with me.

I've tried to CC a few folks here that would care about this, but I am
sure there are more. I'll go cross-post it to sw-dev, if it allows me to
post there...
---
 .../devicetree/bindings/riscv/cpus.yaml       |  57 ++--
 .../devicetree/bindings/riscv/extensions.yaml | 278 ++++++++++++++++++
 2 files changed, 313 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/extensions.yaml

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 3d2934b15e80..1e4f67129f97 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -23,6 +23,9 @@ description: |
   two cores, each of which has two hyperthreads, could be described as
   having four harts.
 
+allOf:
+  - $ref: extensions.yaml
+
 properties:
   compatible:
     oneOf:
@@ -79,25 +82,6 @@ properties:
     description:
       The blocksize in bytes for the Zicboz cache operations.
 
-  riscv,isa:
-    description:
-      Identifies the specific RISC-V instruction set architecture
-      supported by the hart.  These are documented in the RISC-V
-      User-Level ISA document, available from
-      https://riscv.org/specifications/
-
-      Due to revisions of the ISA specification, some deviations
-      have arisen over time.
-      Notably, riscv,isa was defined prior to the creation of the
-      Zicsr and Zifencei extensions and thus "i" implies
-      "zicsr_zifencei".
-
-      While the isa strings in ISA specification are case
-      insensitive, letters in the riscv,isa string must be all
-      lowercase to simplify parsing.
-    $ref: "/schemas/types.yaml#/definitions/string"
-    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
-
   # RISC-V requires 'timebase-frequency' in /cpus, so disallow it here
   timebase-frequency: false
 
@@ -133,8 +117,17 @@ properties:
       DMIPS/MHz, relative to highest capacity-dmips-mhz
       in the system.
 
+oneOf:
+  - required:
+      - riscv,isa
+  - required:
+      - riscv,isa-base
+
+dependencies:
+  riscv,isa-base: [ "riscv,isa-extensions" ]
+  riscv,isa-extensions: [ "riscv,isa-base" ]
+
 required:
-  - riscv,isa
   - interrupt-controller
 
 additionalProperties: true
@@ -177,8 +170,18 @@ examples:
                 i-tlb-size = <32>;
                 mmu-type = "riscv,sv39";
                 reg = <1>;
-                riscv,isa = "rv64imafdc";
                 tlb-split;
+                riscv,isa-base = "rv64i";
+
+                riscv,isa-extensions {
+                  i;
+                  m;
+                  a;
+                  f;
+                  d;
+                  c;
+                };
+
                 cpu_intc1: interrupt-controller {
                         #interrupt-cells = <1>;
                         compatible = "riscv,cpu-intc";
@@ -196,8 +199,18 @@ examples:
                 device_type = "cpu";
                 reg = <0>;
                 compatible = "riscv";
-                riscv,isa = "rv64imafdc";
                 mmu-type = "riscv,sv48";
+                riscv,isa-base = "rv64i";
+
+                riscv,isa-extensions {
+                  i;
+                  m;
+                  a;
+                  f;
+                  d;
+                  c;
+                };
+
                 interrupt-controller {
                         #interrupt-cells = <1>;
                         interrupt-controller;
diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
new file mode 100644
index 000000000000..7257f186832e
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -0,0 +1,278 @@
+# SPDX-License-Identifier: (GPL-2.0 OR MIT)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/extensions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V ISA extensions
+
+maintainers:
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@sifive.com>
+  - Conor Dooley <conor@kernel.org>
+
+description: |
+  RISC-V has a large number of extensions, some of which are "standard"
+  extensions,   meaning they are ratified by RISC-V International, and others
+  are "vendor" extensions.
+  This document defines properties that indicate whether a hart supports a
+  given extension.
+
+  Once a standard extension has been ratified, no changes in behaviour can be
+  made without the creation of a new extension.
+  The properties for standard extensions therefore map to their originally
+  ratified states, with the exception of the I, Zicntr & Zihpm extensions.
+  See the "i" property for more information.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: riscv
+
+properties:
+  riscv,isa:
+    description:
+      Identifies the specific RISC-V instruction set architecture
+      supported by the hart.  These are documented in the RISC-V
+      User-Level ISA document, available from
+      https://riscv.org/specifications/
+
+      Due to revisions of the ISA specification, some deviations
+      have arisen over time.
+      Notably, riscv,isa was defined prior to the creation of the
+      Zicsr and Zifencei extensions and thus "i" implies
+      "zicsr_zifencei".
+
+      While the isa strings in the ISA specification are case
+      insensitive, letters in the riscv,isa string must be all
+      lowercase to simplify parsing.
+
+      This property has been deprecated due to disparity between the
+      extension at the time of its creation and ratification of the
+      base ISA.
+
+    $ref: /schemas/types.yaml#/definitions/string
+    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)?(?:_[hsxz](?:[a-z])+)*$
+    deprecated: true
+
+  riscv,isa-base:
+    description:
+      The base ISA implemented by this hart, as described by the 20191213
+      version of the unprivileged ISA specification.
+    enum:
+      - rv32i
+      - rv64i
+
+  riscv,isa-extensions:
+    type: object
+    description:
+      This child of the cpu node contains boolean properties, indicating which
+      ISA extensions are supported by the cpu.
+    additionalProperties: false
+    properties:
+      # single letter extensions, in canonical order
+
+      i:
+        type: boolean
+        description:
+          The base integer instruction set, as ratified in the 20191213 version
+          of the unprivileged ISA specification, with the exception of counter
+          access. Counter access was removed after the ratification of the
+          20191213 version of the unprivileged specification and shunted into
+          the Zicntr and Zihpm extensions.
+
+      m:
+        type: boolean
+        description:
+          The standard M extension for integer multiplication and division, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      a:
+        type: boolean
+        description:
+          The standard A extension for atomic instructions, as ratified in the
+          20191213 version of the unprivileged ISA specification.
+
+      f:
+        type: boolean
+        description:
+          The standard F extension for single-precision floating point, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      d:
+        type: boolean
+        description:
+          The standard D extension for double-precision floating-point, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      q:
+        type: boolean
+        description:
+          The standard Q extension for quad-precision floating-point, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      c:
+        type: boolean
+        description:
+          The standard C extension for compressed instructions, as ratified in
+          the 20191213 version of the unprivileged ISA specification.
+
+      v:
+        type: boolean
+        description:
+          The standard V extension for vector operations, as ratified
+          in-and-around commit 7a6c8ae ("Fix text that describes vfmv.v.f
+          encoding") of the riscv-v-spec.
+
+      h:
+        type: boolean
+        description:
+          The standard H extension for hypervisors as ratified in the 20191213
+          version of the privileged ISA specification.
+
+      # multi-letter extensions, sorted alphanumerically
+      smaia:
+        type: boolean
+        description: |
+          The standard Smaia supervisor-level extension for the advanced
+          interrupt architecture for machine-mode-visible csr and behavioural
+          changes to interrupts as frozen at commit ccbddab ("Merge pull
+          request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
+
+      ssaia:
+        type: boolean
+        description: |
+          The standard Ssaia supervisor-level extension for the advanced
+          interrupt architecture for supervisor-mode-visible csr and behavioural
+          changes to interrupts as frozen at commit ccbddab ("Merge pull request
+          #42 from riscv/jhauser-2023-RC4") of riscv-aia.
+
+      sscofpmf:
+        type: boolean
+        description: |
+          The standard Sscofpmf supervisor-level extension for count overflow
+          and mode-based filtering as ratified at commit 01d1df0 ("Add ability
+          to manually trigger workflow. (#2)") of riscv-count-overflow.
+
+      sstc:
+        type: boolean
+        description:
+          The standard Sstc supervisor-level extension for time compare as
+          ratified at commit 3f9ed34 ("Add ability to manually trigger workflow.
+          (#2)") of riscv-time-compare.
+
+      svinval:
+        type: boolean
+        description:
+          The standard Svinval supervisor-level extension for fine-grained
+          address-translation cache invalidation as ratified in the 20191213
+          version of the privileged ISA specification.
+
+      svnapot:
+        type: boolean
+        description:
+          The standard Svnapot supervisor-level extensions for napot translation
+          contiguity as ratified in the 20191213 version of the privileged ISA
+          specification.
+
+      svpbmt:
+        type: boolean
+        description:
+          The standard Svpbmt supervisor-level extensions for page-based memory
+          types as ratified in the 20191213 version of the privileged ISA
+          specification.
+
+      zba:
+        type: boolean
+        description: |
+          The standard Zba bit-manipulation extension for address generation
+          acceleration instructions as ratified at commit 6d33919 ("Merge pull
+          request #158 from hirooih/clmul-fix-loop-end-condition") of
+          riscv-bitmanip.
+
+      zbb:
+        type: boolean
+        description: |
+          The standard Zbb bit-manipulation extension for basic bit-manipulation
+          as ratified at commit 6d33919 ("Merge pull request #158 from
+          hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+      zbc:
+        type: boolean
+        description: |
+          The standard Zbc bit-manipulation extension for carry-less
+          multiplication as ratified at commit 6d33919 ("Merge pull request #158
+          from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+      zbs:
+        type: boolean
+        description: |
+          The standard Zbs bit-manipulation extension for single-bit
+          instructions as ratified at commit 6d33919 ("Merge pull request #158
+          from hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+      zicbom:
+        type: boolean
+        description:
+          The standard Zicbom extension for base cache management operations as
+          ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+      zicbop:
+        type: boolean
+        description:
+          The standard Zicbop extension for cache-block prefetch instructions as
+          ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+      zicboz:
+        type: boolean
+        description:
+          The standard  Zicbomz extension for cache-block zeroing as ratified in
+          commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+      zicntr:
+        type: boolean
+        description:
+          The standard Zicntr extension for base counters and timers, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      zicsr:
+        type: boolean
+        description:
+          The standard Zicsr extension for control and status register
+          instructions, as ratified in the 20191213 version of the unprivileged
+          ISA specification.
+
+      zifencei:
+        type: boolean
+        description:
+          The standard Zifencei extension for instruction-fetch fence, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      zihintpause:
+        type: boolean
+        description: |
+          The standard Zihintpause extension for pause hints, as ratified in
+          commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
+
+      zihpm:
+        type: boolean
+        description:
+          The standard Zihpm extension for hardware performance counters, as
+          ratified in the 20191213 version of the unprivileged ISA
+          specification.
+
+      ztso:
+        type: boolean
+        description:
+          The standard Ztso extension for total store ordering, as ratified in
+          commit 2e5236 ("Ztso is now ratified.") of the riscv-isa-manual.
+
+additionalProperties: true
+...
-- 
2.39.2

