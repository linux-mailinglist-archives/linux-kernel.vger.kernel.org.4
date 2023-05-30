Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4433D716084
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjE3Mvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjE3Mvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:51:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49787E40;
        Tue, 30 May 2023 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685451063; x=1716987063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=81Z+HN/HXj5AQPxeRiT1gdchzsxtqZSuUxHWE9CobS0=;
  b=GSjKmkOQpsX4wwnjyXZ+tach/INi7um6/sS+2m/u1nRxbWn89vjZ3QIb
   e731g+JdyiW8GVlYAAyURA2VpBdg/DOjLb2TTfzTxixtqFJ6TOBDZgVUD
   Yo8EilQahej4Ss/TsydxE24MYu2fEJ5QHG04EmvRr2EgVn470QLLmrXb2
   BcWjKRYbeJ0hF+bke7WA9EhQnYbURTyCzkAbAPnaNKGH7J/+k1jMdkSGz
   oIN7KgB+7pjjLZQxN8NvKZuNr644j2JD7xfl24ln7jCna7kW0UAkf5GGv
   qNNOG38byFhRjSpjD1v0QFzN+0L0MmjXujkfhRIx8UeZD0WzzaJ4DQNGT
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="scan'208";a="227583731"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 05:50:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 05:50:10 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 05:50:07 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <soc@kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>, <corbet@lwn.net>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <olof@lixom.net>,
        <palmer@dabbelt.com>, <robh+dt@kernel.org>, <arnd@arndb.de>
Subject: [PATCH v2] Documentation/process: add soc maintainer handbook
Date:   Tue, 30 May 2023 13:49:36 +0100
Message-ID: <20230530-multiple-whooping-ee5706fceb67@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11964; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=81Z+HN/HXj5AQPxeRiT1gdchzsxtqZSuUxHWE9CobS0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmlH+4xSB3++qBlgt5B9mzdXOsosxDHWeIvDy9/JXZdKKfq bKdZRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDaEi1MAJqL2hJFhzfcit6zZu/YuKH/LnrUs76 zt7tM2H76lBecu+me57fSO1YwMe5peThB4n6SvG6Zw1LD84DmLEJ+wY5N/TN8z6ceH3kuFrAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd suggested that adding a maintainer handbook for the SoC "subsystem"
would be helpful in trying to bring on board maintainers for the various
new platforms cropping up in RISC-V land.

Add a document briefly describing the role of the SoC subsystem and some
basic advice for (new) platform maintainers.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes in v2:
- add Krzysztof's suggested method for avoiding inter-branch
  dependencies
- explicitly mention that tags should be signed
- link to the devicetree abi document, rather than trying to explain it
  here & reword that whole section
- fix some typos, capitalisation & unify bullet style

The devicetree abi doc feels quite out of date at this point, and could
probably do with a spring clean - but it also feels like hallowed ground
on which one should tread lightly, so I won't go near that til Rob is
back.
---
 Documentation/devicetree/bindings/ABI.rst     |   2 +
 .../devicetree/bindings/writing-schema.rst    |   2 +
 .../process/maintainer-handbooks.rst          |   3 +-
 Documentation/process/maintainer-soc.rst      | 178 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 5 files changed, 185 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/process/maintainer-soc.rst

diff --git a/Documentation/devicetree/bindings/ABI.rst b/Documentation/devicetree/bindings/ABI.rst
index a885713cf184..93ec82f78ae5 100644
--- a/Documentation/devicetree/bindings/ABI.rst
+++ b/Documentation/devicetree/bindings/ABI.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _devicetree-abi:
+
 ===================
 Devicetree (DT) ABI
 ===================
diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
index 4a381d20f2b4..640d857dabf3 100644
--- a/Documentation/devicetree/bindings/writing-schema.rst
+++ b/Documentation/devicetree/bindings/writing-schema.rst
@@ -136,6 +136,8 @@ installed. Ensure they are in your PATH (~/.local/bin by default).
 
 Recommended is also to install yamllint (used by dtschema when present).
 
+.. _running-checks:
+
 Running checks
 ~~~~~~~~~~~~~~
 
diff --git a/Documentation/process/maintainer-handbooks.rst b/Documentation/process/maintainer-handbooks.rst
index d783060b4cc6..fe24cb665fb7 100644
--- a/Documentation/process/maintainer-handbooks.rst
+++ b/Documentation/process/maintainer-handbooks.rst
@@ -15,5 +15,6 @@ Contents:
    :numbered:
    :maxdepth: 2
 
-   maintainer-tip
    maintainer-netdev
+   maintainer-soc
+   maintainer-tip
diff --git a/Documentation/process/maintainer-soc.rst b/Documentation/process/maintainer-soc.rst
new file mode 100644
index 000000000000..9683c7d199b2
--- /dev/null
+++ b/Documentation/process/maintainer-soc.rst
@@ -0,0 +1,178 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _maintainer-soc:
+
+=============
+SoC Subsystem
+=============
+
+Overview
+--------
+
+The SoC subsystem is a place of aggregation for SoC-specific code.
+The main components of the subsystem are:
+
+* devicetrees for 32- & 64-bit ARM and RISC-V
+* 32-bit ARM board files (arch/arm/mach*)
+* 32- & 64-bit ARM defconfigs
+* SoC specific drivers across architectures, in particular for 32- & 64-bit
+  ARM, RISC-V and Loongarch
+
+These "SoC specific drivers" do not include clock, GPIO etc drivers that have
+other top-level maintainers. The drivers/soc/ directory is generally meant
+for kernel-internal drivers that are used by other drivers to provide SoC
+specific functionality like identifying a SoC revision or interfacing with
+power domains.
+
+The SoC subsystem also serves as an intermediate location for changes to
+drivers/bus, drivers/firmware, drivers/reset and drivers/memory.  The addition
+of new platforms, or the removal of existing ones, often go through the SoC
+tree as a dedicated branch covering multiple subsystems.
+
+The main SoC tree is housed on git.kernel.org:
+  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/
+
+Clearly this is quite a wide range of topics, which no one person, or even
+small group of people are capable of maintaining.  Instead, the SoC subsystem
+is comprised of many submaintainers, each taking care of individual platforms
+and driver sub-directories.
+In this regard, "platform" usually refers to a series of SoCs from a given
+vendor, for example, Nvidia's series of Tegra SoCs.  Many submaintainers operate
+on a vendor level, responsible for multiple product lines.  For several reasons,
+including acquisitions/different business units in a company, things vary
+significantly here.  The various submaintainers are documented in the
+MAINTAINERS file.
+
+Most of these submaintainers have their own trees where they stage patches,
+sending pull requests to the main SoC tree.  These trees are usually, but not
+always, listed in MAINTAINERS.  The main SoC maintainers can be reached via the
+alias soc@kernel.org if there is no platform-specific maintainer, or if they
+are unresponsive.
+
+What the SoC tree is not, however, is a location for architecture specific code
+changes.  Each architecture has it's own maintainers that are responsible for
+architectural details, cpu errata and the like.
+
+Information for (new) Submaintainers
+------------------------------------
+
+As new platforms spring up, they often bring with them new submaintainers,
+many of whom work for the silicon vendor, and may not be familiar with the
+process.
+
+Devicetree ABI Stability
+~~~~~~~~~~~~~~~~~~~~~~~~
+
+Perhaps one of the most important things to highlight is that dt-bindings
+document the ABI between the devicetree and the kernel. Please see
+:ref:`devicetree-abi` more information on the ABI.
+
+If changes are being made to a devicetree that are incompatible with old
+kernels, the devicetree patch should not be applied until the driver is, or an
+appropriate time later.  Most importantly, any incompatible changes should be
+clearly pointed out in the patch description and pull request, along with the
+expected impact on existing users, such as bootloaders or other operating
+systems.
+
+Driver Branch Dependencies
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A common problem is synchronizing changes between device drivers and devicetree
+files, even if a change is compatible in both directions, this may require
+coordinating how the changes get merged through different maintainer trees.
+
+Usually the branch that includes a driver change will also include the
+corresponding change to the devicetree binding description, to ensure they are
+in fact compatible.  This means that the devicetree branch can end up causing
+warnings in the "make dtbs_check" step.  If a devicetree change depends on
+missing additions to a header file in include/dt-bindings/, it will fail the
+"make dtbs" step and not get merged.
+
+There are multiple ways to deal with this:
+
+* Avoid defining custom macros in include/dt-bindings/ for hardware constants
+  that can be derived from a datasheet -- binding macros in header file should
+  only be used as a last resort if there is no natural way to define a binding
+
+* Use literal values in the devicetree file in place of macros even when a
+  header is required, and change them to the named representation in a
+  following release
+
+* Defer the devicetree changes to a release after the binding and driver have
+  already been merged
+
+* Change the bindings in a shared immutable branch that is used as the base for
+  both the driver change and the devicetree changes
+
+* Add duplicate defines in the devicetree file guarded by an #ifndef section,
+  removing them in a later release
+
+Devicetree Naming Convention
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The general naming scheme for devicetree files are as follows.  The aspects of a
+platform that are set at the SoC level, like cpu cores, are contained in a file
+named $soc.dtsi, for example, jh7100.dtsi.  Integration details, that will vary
+from board to board, are described in $soc-$board.dtsi.  An example of this is
+jh7100-beaglev-starlight.dts.  Often many boards are variations on a theme, and
+frequently there are intermediate files, such as jh7100-common.dtsi, which sit
+between the $soc.dtsi and $soc-$board.dts files, containing the descriptions of
+common hardware.
+
+Some platforms also have System on Modules, containing an SoC, which are then
+integrated into several different boards. For these platforms, $soc-$som.dtsi
+and $soc-$som-$board.dts are typical.
+
+Directories are usually named after the vendor of the SoC at the time of it's
+inclusion, leading to some historical directory names in the tree.
+
+Validating Devicetree Files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``make dtbs_check`` can be used to validate that devicetree files are compliant
+with the dt-bindings that describe the ABI.  Please see :ref:`running-checks`
+for more information on the validation of devicetrees.
+
+For new platforms, or additions to existing ones, ``make dtbs_check`` should not
+add any new warnings.  For RISC-V, as it has the advantage of being a newer
+architecture, ``make dtbs_check W=1`` is required to not add any new warnings.
+If in any doubt about a devicetree change, reach out to the devicetree
+maintainers.
+
+Branches and Pull Requests
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Just as the main SoC tree has several branches, it is expected that
+submaintainers will do the same. Driver, defconfig and devicetree changes should
+all be split into separate branches and appear in separate pull requests to the
+SoC maintainers.  Each branch should be usable by itself and avoid
+regressions that originate from dependencies on other branches.
+
+Small sets of patches can also be sent as separate emails to soc@kernel.org,
+grouped into the same categories.
+
+If changes do not fit into the normal patterns, there can be additional
+top-level branches, e.g. for a treewide rework, or the addition of new SoC
+platforms including dts files and drivers.
+
+Branches with a lot of changes can benefit from getting split up into separate
+topics branches, even if they end up getting merged into the same branch of the
+SoC tree.  An example here would be one branch for devicetree warning fixes, one
+for a rework and one for newly added boards.
+
+Another common way to split up changes is to send an early pull request with the
+majority of the changes at some point between rc1 and rc4, following up with one
+or more smaller pull requests towards the end of the cycle that can add late
+changes or address problems idenfied while testing the first set.
+
+While there is no cut-off time for late pull requests, it helps to only send
+small branches as time gets closer to the merge window.
+
+Pull requests for bugfixes for the current release can be sent at any time, but
+again having multiple smaller branches is better than trying to combine too many
+patches into one pull request.
+
+The subject line of a pull request should begin with "[GIT PULL]" and made using
+a signed tag, rather than a branch.  This tag should contain a short description
+summarising the changes in the pull request.  For more detail on sending pull
+requests, please see :ref:`pullrequests`.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..29631c325857 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1815,6 +1815,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 C:	irc://irc.libera.chat/armlinux
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
+F:	Documentation/process/maintainer-soc.rst
 F:	arch/arm/boot/dts/Makefile
 F:	arch/arm64/boot/dts/Makefile
 
-- 
2.39.2

