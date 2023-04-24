Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FE6D0CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjC3Rda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjC3Rd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:33:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D55E3B9;
        Thu, 30 Mar 2023 10:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E77F62153;
        Thu, 30 Mar 2023 17:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E270AC4339B;
        Thu, 30 Mar 2023 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680197605;
        bh=TGL8LvZqyVxudl1AdJeWsuMMfvnopGjKpYxAOrJpzy4=;
        h=From:To:Cc:Subject:Date:From;
        b=Dz70YwfcOg3FFIMMjW+kEPATlY4d4XAso+J4MLhYZCUi8c1MQIJJR9ArlXFXtn6Po
         WDizL1uUvqCozQYSQxSGBFe8f2C3v7pTaHXUTsCfRis0BTMRd8IM52D+aDAh9Uw5qR
         XgTB12gaYTU5pfa5zfjNcQyNjaeZnmQO6wtjpPzGTBWflqEkFW6iJ5LEoEH8gGnONb
         spzh9sQIoTBqSgYRgUeI+AX39IpoaQhu2Fgf7ZaBIwjoezxBbkSiwxrWPsQT9bbfXq
         2ucqx2MUXVSPeRzhcnFHQUK5mJ43Erp/lrqjCN5cQA/Lm9E89eECLFThDkws4GiOJy
         Dt5+Es/74O7+g==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     conor@kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Scott Wood <oss@buserror.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Serge Semin <fancer.lancer@gmail.com>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-msm@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v1] dt-bindings: move cache controller bindings to a cache directory
Date:   Thu, 30 Mar 2023 18:32:56 +0100
Message-Id: <20230330173255.109731-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7705; i=conor.dooley@microchip.com; h=from:subject; bh=U174NDGDWgBy3a6MdGCxngbevjl5LWTvwwYlkqVhFOU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmqx4+/W3VH8+eXe3LXF4bmrv5kxlLtPcvql9nNt4wlY kpd3r0yHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIv0yGv8IP2QrkFOpE/P6p VB84cOlmx07PxwW2PffnVz7lMOBpL2Fk6Ej/scgw8P6E9Tv7D97XSDn+oOgS24HLK7mm2Vl9nW3 FyAsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

There's a bunch of bindings for (mostly l2) cache controllers
scattered to the four winds, move them to a common directory.
I renamed the freescale l2cache.txt file, as while that might make sense
when the parent dir is fsl, it's confusing after the move.
The two Marvell bindings have had a "marvell," prefix added to match
their compatibles.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../{memory-controllers => cache}/baikal,bt1-l2-ctl.yaml        | 2 +-
 .../{powerpc/fsl/l2cache.txt => cache/freescale-l2cache.txt}    | 0
 Documentation/devicetree/bindings/{arm => cache}/l2c2x0.yaml    | 2 +-
 .../{arm/mrvl/feroceon.txt => cache/marvell,feroceon-cache.txt} | 0
 .../{arm/mrvl/tauros2.txt => cache/marvell,tauros2-cache.txt}   | 0
 .../devicetree/bindings/{arm/msm => cache}/qcom,llcc.yaml       | 2 +-
 .../devicetree/bindings/{riscv => cache}/sifive,ccache0.yaml    | 2 +-
 .../socionext => cache}/socionext,uniphier-system-cache.yaml    | 2 +-
 MAINTAINERS                                                     | 2 ++
 9 files changed, 7 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{memory-controllers => cache}/baikal,bt1-l2-ctl.yaml (95%)
 rename Documentation/devicetree/bindings/{powerpc/fsl/l2cache.txt => cache/freescale-l2cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm => cache}/l2c2x0.yaml (99%)
 rename Documentation/devicetree/bindings/{arm/mrvl/feroceon.txt => cache/marvell,feroceon-cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/mrvl/tauros2.txt => cache/marvell,tauros2-cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/msm => cache}/qcom,llcc.yaml (96%)
 rename Documentation/devicetree/bindings/{riscv => cache}/sifive,ccache0.yaml (98%)
 rename Documentation/devicetree/bindings/{arm/socionext => cache}/socionext,uniphier-system-cache.yaml (96%)

diff --git a/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-l2-ctl.yaml b/Documentation/devicetree/bindings/cache/baikal,bt1-l2-ctl.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/memory-controllers/baikal,bt1-l2-ctl.yaml
rename to Documentation/devicetree/bindings/cache/baikal,bt1-l2-ctl.yaml
index 1fca282f64a2..ec4f367bc0b4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/baikal,bt1-l2-ctl.yaml
+++ b/Documentation/devicetree/bindings/cache/baikal,bt1-l2-ctl.yaml
@@ -2,7 +2,7 @@
 # Copyright (C) 2020 BAIKAL ELECTRONICS, JSC
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/memory-controllers/baikal,bt1-l2-ctl.yaml#
+$id: http://devicetree.org/schemas/cache/baikal,bt1-l2-ctl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Baikal-T1 L2-cache Control Block
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt b/Documentation/devicetree/bindings/cache/freescale-l2cache.txt
similarity index 100%
rename from Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
rename to Documentation/devicetree/bindings/cache/freescale-l2cache.txt
diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.yaml b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/arm/l2c2x0.yaml
rename to Documentation/devicetree/bindings/cache/l2c2x0.yaml
index 6b8f4d4fa580..d7840a5c4037 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/l2c2x0.yaml#
+$id: http://devicetree.org/schemas/cache/l2c2x0.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ARM L2 Cache Controller
diff --git a/Documentation/devicetree/bindings/arm/mrvl/feroceon.txt b/Documentation/devicetree/bindings/cache/marvell,feroceon-cache.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mrvl/feroceon.txt
rename to Documentation/devicetree/bindings/cache/marvell,feroceon-cache.txt
diff --git a/Documentation/devicetree/bindings/arm/mrvl/tauros2.txt b/Documentation/devicetree/bindings/cache/marvell,tauros2-cache.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/mrvl/tauros2.txt
rename to Documentation/devicetree/bindings/cache/marvell,tauros2-cache.txt
diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
rename to Documentation/devicetree/bindings/cache/qcom,llcc.yaml
index 38efcad56dbd..14eb5175dac4 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/cache/qcom,llcc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/msm/qcom,llcc.yaml#
+$id: http://devicetree.org/schemas/cache/qcom,llcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Last Level Cache Controller
diff --git a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
rename to Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
index eb6ab73c0f31..8a6a78e1a7ab 100644
--- a/Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml
+++ b/Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
@@ -2,7 +2,7 @@
 # Copyright (C) 2020 SiFive, Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/riscv/sifive,ccache0.yaml#
+$id: http://devicetree.org/schemas/cache/sifive,ccache0.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: SiFive Composable Cache Controller
diff --git a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml b/Documentation/devicetree/bindings/cache/socionext,uniphier-system-cache.yaml
similarity index 96%
rename from Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
rename to Documentation/devicetree/bindings/cache/socionext,uniphier-system-cache.yaml
index 6096c082d56d..3196263685a3 100644
--- a/Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
+++ b/Documentation/devicetree/bindings/cache/socionext,uniphier-system-cache.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/socionext/socionext,uniphier-system-cache.yaml#
+$id: http://devicetree.org/schemas/cache/socionext,uniphier-system-cache.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: UniPhier outer cache controller
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..bbb0f252522b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11893,6 +11893,7 @@ M:	Scott Wood <oss@buserror.net>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
+F:	Documentation/devicetree/bindings/cache/freescale-l2cache.txt
 F:	Documentation/devicetree/bindings/powerpc/fsl/
 F:	arch/powerpc/platforms/83xx/
 F:	arch/powerpc/platforms/85xx/
@@ -19073,6 +19074,7 @@ M:	Conor Dooley <conor@kernel.org>
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	Documentation/devicetree/bindings/cache/sifive,ccache0.yaml
 F:	drivers/soc/sifive/
 
 SILEAD TOUCHSCREEN DRIVER
-- 
2.39.2

