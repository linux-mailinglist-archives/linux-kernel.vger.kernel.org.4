Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76593707C67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 10:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjERI7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjERI7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 04:59:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEEE1FD8;
        Thu, 18 May 2023 01:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684400339; x=1715936339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OJ2mVKQ9f4KyeSK1ddmgnLirN/TPyanwSJydgPw7d6k=;
  b=zaoOuwbJi6RN4yCcPnDsCNFEExSTFNXiur7L7vJBPZX+GcGnL2rnHMgo
   alGd8EagyF8DByk7ei7tz8OimT7TkOEwWjigoVzZPaT2+IsEMCo7Ww//N
   fWYazkjEj3yQrn2Q9rgqMRjgbdSToW4/6HSFzi/TI1fCCTxao2iGfEhgr
   5oVoGlbo4hJkqPtXuLc/y0uXCGcRhXsn6zFi9Y8O9YNGwmbnXtIEK4fzS
   OxnXY+crPOpR/3KBJR+BFovrY7DB/wJnaFqfI3CuH0TFjjHOPFFFSw/KJ
   7htTKM54at/lxBbAWwzwBEHM1NY5DnDa8Qg5GYxUa2ZBbQ6Zql/oliB2B
   w==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="216063725"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 01:58:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 01:58:57 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 01:58:54 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Anup Patel" <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Jessica Clarke" <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Date:   Thu, 18 May 2023 09:58:30 +0100
Message-ID: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19633; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=OJ2mVKQ9f4KyeSK1ddmgnLirN/TPyanwSJydgPw7d6k=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmpL7YK3vl9ftHtDyoLDt59dO6ONa9g5LxoY1bxi2rhfo3p Zk42HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIfCZGhv3ZbrXTew37jwv/bmc3V+ 1icbifmhzw2i+EPf6BkLaqN8P/WovLisVZWa7pz7ZOVP7Xu8x4Z87B1xrTjq7WmORtvrCeDQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
to add a riscv,isa parser to dt-validate!
	That's not implemented in this patch, but rather left as
	future work!

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
	of_property_present(node, "riscv,isa-extension-zicbom")

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

Create a new file to store the extension meanings, each in the form
riscv,isa-extension-<foo> and a new riscv,isa-base property to replace
the missing aspect of riscv,isa - the base ISA implemented by a hart.
As a starting point, properties were added for extensions currently used
in Linux.

Finally, mark riscv,isa as deprecated. o7.

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
CC: linux-riscv@lists.infradead.org
CC: qemu-riscv@nongnu.org
CC: u-boot@lists.denx.de
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
I've tried to CC a few folks here that would care about this, but I am
sure there are more. I'll go cross-post it to sw-dev, if it allows me to
post there...
---
 .../devicetree/bindings/riscv/cpus.yaml       |  45 +--
 .../devicetree/bindings/riscv/extensions.yaml | 259 ++++++++++++++++++
 2 files changed, 282 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/extensions.yaml

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 3d2934b15e80..446801fb7495 100644
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
 
@@ -133,8 +117,13 @@ properties:
       DMIPS/MHz, relative to highest capacity-dmips-mhz
       in the system.
 
+oneOf:
+  - required:
+      - riscv,isa
+  - required:
+      - riscv,isa-base
+
 required:
-  - riscv,isa
   - interrupt-controller
 
 additionalProperties: true
@@ -177,7 +166,13 @@ examples:
                 i-tlb-size = <32>;
                 mmu-type = "riscv,sv39";
                 reg = <1>;
-                riscv,isa = "rv64imafdc";
+                riscv,isa-base = "rv64i";
+                riscv,isa-extension-i;
+                riscv,isa-extension-m;
+                riscv,isa-extension-a;
+                riscv,isa-extension-f;
+                riscv,isa-extension-d;
+                riscv,isa-extension-c;
                 tlb-split;
                 cpu_intc1: interrupt-controller {
                         #interrupt-cells = <1>;
@@ -196,7 +191,13 @@ examples:
                 device_type = "cpu";
                 reg = <0>;
                 compatible = "riscv";
-                riscv,isa = "rv64imafdc";
+                riscv,isa-base = "rv64i";
+                riscv,isa-extension-i;
+                riscv,isa-extension-m;
+                riscv,isa-extension-a;
+                riscv,isa-extension-f;
+                riscv,isa-extension-d;
+                riscv,isa-extension-c;
                 mmu-type = "riscv,sv48";
                 interrupt-controller {
                         #interrupt-cells = <1>;
diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
new file mode 100644
index 000000000000..1b4d726f7174
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -0,0 +1,259 @@
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
+  RISC-V has large number of extensions, some of which "standard" extensions,
+  meaning they are ratified by RISC-V International, and others are "vendor"
+  extensions.  This document defines properties that indicate whether a hart
+  supports a given extensions.
+
+  Once a standard extension has been ratified, no features can be added or
+  removed without the creation of a new extension for that sub- or super-set.
+  The properties for standard extensions therefore map to their originally
+  ratified states, with the exception of the I, Zicntr & Zihpm extensions.
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
+      While the isa strings in ISA specification are case
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
+  riscv,isa-extension-i:
+    type: boolean
+    description:
+      The base integer instruction set, as ratified in the 20191213 version of the
+      unprivileged ISA specification.
+
+  riscv,isa-extension-m:
+    type: boolean
+    description:
+      The standard M extension for integer multiplication and division, as
+      ratified in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-a:
+    type: boolean
+    description:
+      The standard A extension for atomic instructions, as ratified in the
+      20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-f:
+    type: boolean
+    description:
+      The standard M extension for single-precision floating point, as
+      ratified in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-d:
+    type: boolean
+    description:
+      The standard M extension for double-precision floating-point, as
+      ratified in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-q:
+    type: boolean
+    description:
+      The standard M extension for quad-precision floating-point, as ratified in
+      the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-c:
+    type: boolean
+    description:
+      The standard M extension for compressed instructions, as ratified in the
+      20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-v:
+    type: boolean
+    description:
+      The standard V extension for vector operations, as ratified in-and-around
+      commit 7a6c8ae ("Fix text that describes vfmv.v.f encoding") of the
+      riscv-v-spec.
+
+  riscv,isa-extension-h:
+    type: boolean
+    description:
+      The standard h extension for hypervisors as ratified in the 20191213
+      version of the privileged ISA specification.
+
+  # Additional Standard Extensions, sorted by category then alphabetically
+
+  riscv,isa-extension-zicntr:
+    type: boolean
+    description:
+      The standard Zicntr extension for base counters and timers, as ratified
+      in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-zicsr:
+    type: boolean
+    description:
+      The standard Zicsr extension for control and status register instructions,
+      as ratified in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-zifencei:
+    type: boolean
+    description:
+      The standard Zifencei extension for instruction-fetch fence, as ratified
+      in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-zihpm:
+    type: boolean
+    description:
+      The standard Zihpm extension for hardware performance counters, as
+      ratified in the 20191213 version of the unprivileged ISA specification.
+
+  riscv,isa-extension-zicbom:
+    type: boolean
+    description:
+      The standard Zicbom extension for base cache management operations as
+      ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+  riscv,isa-extension-zicbop:
+    type: boolean
+    description:
+      The standard Zicbop extension for cache-block prefetch instructions as
+      ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+  riscv,isa-extension-zicboz:
+    type: boolean
+    description:
+      The standard  Zicbomz extension for cache-block zeroing as ratified in
+      commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
+
+  riscv,isa-extension-zihintpause:
+    type: boolean
+    description: |
+      The standard Zihintpause extension for pause hints, as ratified in
+      commit d8ab5c7 ("Zihintpause is ratified") of the riscv-isa-manual.
+
+  riscv,isa-extension-zba:
+    type: boolean
+    description: |
+      The standard Zba bit-manipulation extension for address generation
+      acceleration instructions as ratified at commit 6d33919 ("Merge pull
+      request #158 from hirooih/clmul-fix-loop-end-condition") of
+      riscv-bitmanip.
+
+  riscv,isa-extension-zbb:
+    type: boolean
+    description: |
+      The standard Zbb bit-manipulation extension for basic bit-manipulation as
+      atified at commit 6d33919 ("Merge pull request #158 from
+      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+  riscv,isa-extension-zbc:
+    type: boolean
+    description: |
+      The standard Zbc bit-manipulation extension for carry-less multiplication
+      as ratified at commit 6d33919 ("Merge pull request #158 from
+      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+  riscv,isa-extension-zbs:
+    type: boolean
+    description: |
+      The standard Zbs bit-manipulation extension for single-bit instructions
+      as ratified at commit 6d33919 ("Merge pull request #158 from
+      hirooih/clmul-fix-loop-end-condition") of riscv-bitmanip.
+
+  riscv,isa-extension-ztso:
+    type: boolean
+    description:
+      The standard Ztso extension for total store ordering, as ratified in
+      commit 2e5236 ("Ztso is now ratified.") of the riscv-isa-manual.
+
+ # Standard Supervisor-level Extensions, sorted by category then alphabetically
+
+  'riscv,isa-extension-smaia':
+    type: boolean
+    description: |
+      The standard Smaia supervisor-level extension for the advanced interrupt
+      architecture for machine-mode-visible csr and behavioural changes to
+      interrupts as frozen at commit ccbddab ("Merge pull request #42 from
+      riscv/jhauser-2023-RC4") of riscv-aia.
+
+  riscv,isa-extension-ssaia:
+    type: boolean
+    description: |
+      The standard Ssaia supervisor-level extension for the advanced interrupt
+      architecture for supervisor-mode-visible csr and behavioural changes to
+      interrupts as frozen at commit ccbddab ("Merge pull request #42 from
+      riscv/jhauser-2023-RC4") of riscv-aia.
+
+  riscv,isa-extension-sscofpmf:
+    type: boolean
+    description: |
+      The standard supervisor-level extension for count overflow and mode-based
+      filtering as ratified at commit 01d1df0 ("Add ability to manually trigger
+      workflow. (#2)") of riscv-count-overflow.
+
+  riscv,isa-extension-sstc:
+    type: boolean
+    description:
+      The standard supervisor-level extension for time compare
+      as ratified at commit 3f9ed34 ("Add ability to manually trigger
+      workflow. (#2)") of riscv-time-compare.
+
+  riscv,isa-extension-svinval:
+    type: boolean
+    description:
+      The standard Svinval supervisor-level extension for fine-grained
+      address-translation cache invalidation as ratified in the 20191213 version
+      of the privileged ISA specification.
+
+  riscv,isa-extension-svnapot:
+    type: boolean
+    description:
+      The standard Svnapot supervisor-level extensions for napot translation
+      contiguity as ratified in the 20191213 version of the privileged ISA
+      specification.
+
+  riscv,isa-extension-svpbmt:
+    type: boolean
+    description:
+      The standard Svpbmt supervisor-level extensions for page-based memory
+      types as ratified in the 20191213 version of the privileged ISA
+      specification.
+
+additionalProperties: true
+...
-- 
2.39.2

