Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61876CF650
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjC2WW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC2WW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:22:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06D110D7;
        Wed, 29 Mar 2023 15:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gMQbwbQvnYou5tX0hVPmxBnpsbNNqz1dO1zb952RlkU=; b=R96kFXZJ48c1n9gXxle4XCisZw
        OdLM2BbuZhDTvtLmfI8knLSifXDpfjl9gdKlVCTqi3AqAUElGbbrs7LckHmRHJZfgcooX0zux5hz7
        o0GsLJLVy3dDn3+p6QmM1Uw+pyXGOyqUmRXCA5kw55azbuudrPqPpjUW1+RvZlftqle+A2IsJsB5y
        zcDw7cqtExETdr8zwu9phY9zHOong2x+FM3z4oRU4KStSnlLQXsl6v+YWSSJdaauvdiAmnVNq+eJR
        OX/jePARWvs9TGaFGBY2nWAyRHowWs+oQvogNYqw+VQ2KgEjw5lOIOgqV4eF4Za22PWyttOA2nYcD
        /8wMxsYw==;
Received: from p200300ccff069c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:9c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pheBs-0005q9-PA; Thu, 30 Mar 2023 00:22:49 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pheBr-00DobL-0x;
        Thu, 30 Mar 2023 00:22:47 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, tony@atomide.com
Cc:     Andrew Davis <afd@ti.com>, Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Thu, 30 Mar 2023 00:22:46 +0200
Message-Id: <20230329222246.3292766-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Davis <afd@ti.com>

Convert omap.txt to yaml.

Signed-off-by: Andrew Davis <afd@ti.com>
[various cleanup, adding OpenPandora,Epson Moverio BT-200]
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in V2:
- renamed file
- fixed gta04
- added Openpandora, Epson Moverio BT-200
- drop example
- remove descriptions if just reformatting the name

 Documentation/devicetree/bindings/arm/ti.yaml | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti.yaml

diff --git a/Documentation/devicetree/bindings/arm/ti.yaml b/Documentation/devicetree/bindings/arm/ti.yaml
new file mode 100644
index 000000000000..735e3f0e8143
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP SoC architecture
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description: Platforms based on Texas Instruments OMAP SoC architecture.
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: TI OMAP2420 SoC based platforms
+        items:
+          - enum:
+              - ti,omap2420-h4
+              - nokia,n800
+              - nokia,n810
+              - nokia,n810-wimax
+          - const: ti,omap2420
+          - const: ti,omap2
+
+      - description: TI OMAP2430 SoC based platforms
+        items:
+          - enum:
+              - ti,omap2430-sdp # TI OMAP2430 SDP
+          - const: ti,omap2430
+          - const: ti,omap2
+
+      - description: TI OMAP3430 SoC based platforms
+        items:
+          - enum:
+              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom OMAP35xx SOM-LV Development Kit
+              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx Torpedo Development Kit
+              - ti,omap3430-sdp
+              - ti,omap3-beagle
+              - compulab,omap3-cm-t3530
+              - timll,omap3-devkit8000
+              - ti,omap3-evm                  # TI OMAP35XX EVM (TMDSEVM3530)
+              - ti,omap3-ldp                  # TI OMAP3430 LDP (Zoom1 Labrador)
+              - nokia,omap3-n900
+              - openpandora,omap3-pandora-600mhz
+          - const: ti,omap3430
+          - const: ti,omap3
+
+      - description: TI OMAP3630 SoC based platforms
+        items:
+          - enum:
+              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom DM3730 SOM-LV Development Kit
+              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
+              - ti,omap3-beagle-xm
+              - compulab,omap3-cm-t3730
+              - amazon,omap3-echo             # Amazon Echo (first generation)
+              - ti,omap3-evm-37xx             # TI OMAP37XX EVM (TMDSEVM3730)
+              - goldelico,gta04
+              - nokia,omap3-n9
+              - nokia,omap3-n950
+              - lg,omap3-sniper               # LG Optimus Black
+              - ti,omap3-zoom3
+              - openpandora,omap3-pandora-1ghz
+          - const: ti,omap3630
+          - const: ti,omap3
+
+      - description: TI AM35 SoC based platforms
+        items:
+          - enum:
+              - teejet,mt_ventoux
+              - ti,am3517-craneboard     # TI AM3517 CraneBoard (TMDSEVM3517)
+              - ti,am3517-evm            # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
+              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
+          - const: ti,am3517
+          - const: ti,omap3
+
+      - description: TI OMAP4430 SoC based platforms
+        items:
+          - enum:
+              - motorola,droid4         # Motorola Droid 4 XT894
+              - motorola,droid-bionic   # Motorola Droid Bionic XT875
+              - amazon,omap4-kc1        # Amazon Kindle Fire (first generation)
+              - ti,omap4-panda
+              - ti,omap4-sdp
+          - const: ti,omap4430
+          - const: ti,omap4
+
+      - description: TI OMAP4460 SoC based platforms
+        items:
+          - enum:
+              - ti,omap4-panda-es
+              - epson,epson,embt2ws    # Epson Moverio BT-200
+          - const: ti,omap4460
+          - const: ti,omap4
+
+      - description: TI OMAP5 SoC based platforms
+        items:
+          - enum:
+              - compulab,omap5-cm-t54
+              - isee,omap5-igep0050
+              - ti,omap5-uevm
+          - const: ti,omap5
+
+      - description: TI AM33 SoC based platforms
+        items:
+          - enum:
+              - ti,am335x-bone
+              - compulab,cm-t335
+              - ti,am335x-evm
+              - ti,am335x-evmsk
+              - bosch,am335x-guardian
+              - ti,am3359-icev2
+              - novatech,am335x-lxm  # NovaTech OrionLXm
+              - moxa,uc-2101
+              - moxa,uc-8100-me-t
+              - gumstix,am335x-pepper
+              - tcl,am335x-sl50      # Toby Churchill SL50 Series
+          - pattern: '^ti,am33(5[1246789]|xx)$' # ti,am33xx is legacy please use full SoC name
+
+      - description: TI AM43 SoC based platforms
+        items:
+          - enum:
+              - compulab,am437x-cm-t43
+              - ti,am437x-gp-evm
+              - ti,am437x-idk-evm
+              - ti,am437x-sk-evm
+          - pattern: '^ti,am4372[26789]$'
+          - const: ti,am43
+
+      - description: TI AM57 SoC based platforms
+        items:
+          - enum:
+              - beagle,am5729-beagleboneai
+              - compulab,cl-som-am57x
+              - ti,am5718-idk
+              - ti,am5728-idk
+              - ti,am5748-idk
+          - pattern: '^ti,am57[0124][689]$'
+          - const: ti,am57
+
+      - description: TI DRA7 SoC based platforms
+        items:
+          - enum:
+              - ti,dra718-evm
+              - ti,dra722-evm
+              - ti,dra742-evm
+              - ti,dra762-evm
+          - pattern: '^ti,dra7[12456][024568p]$'
+          - const: ti,dra7
+
+additionalProperties: true
+
+...
-- 
2.30.2

