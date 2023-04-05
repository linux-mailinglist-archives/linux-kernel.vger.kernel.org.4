Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C296D837D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjDEQTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjDEQTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:19:33 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FE26196;
        Wed,  5 Apr 2023 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZCgO4HfIooWDeY1HgUGYBR6VVrpESH7MTUz5ciZlkqY=; b=2/BmrE93UavblK0qtB5OL5fkce
        hbCnl/f/OoeVWVukPlD2AcAPP0ckQ8k4/s42wZIFp242Y7qLc8rkTNE4pFz/ksSajsQwW7O/A3X0m
        2R9DbylLJ62xB4ezj1Yoo/o0Cq4GQMxemC+XyoQOv3pnB7Y91cfMyEV58Uk3eafmOhR7RU+kgMvbT
        puMlF5iey4dY5absSoFyCmFc9YQ9ivwvZWvCODzHaYmeqiGEjnaZ8pvW2LK6Q5O7j2RW7v3xuLl2i
        Rg4akG5+EZL21fjTd9c+i0JbsYsj2zt0X+CCtecDMNsuTu4Ep9Sc/z5/lPYv93tA71ajh1Q8yZ/6K
        q+SECkPA==;
Received: from p200300ccff0b98001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:9800:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pk5qp-0001uA-0c; Wed, 05 Apr 2023 18:19:22 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pk5qo-00017t-08;
        Wed, 05 Apr 2023 18:19:10 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, andreas@kemnade.info, afd@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: omap: Convert omap.txt to yaml
Date:   Wed,  5 Apr 2023 18:19:07 +0200
Message-Id: <20230405161908.4312-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405161908.4312-1-andreas@kemnade.info>
References: <20230405161908.4312-1-andreas@kemnade.info>
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

CC: linux-omap@vger.kernel.org
Signed-off-by: Andrew Davis <afd@ti.com>
[various cleanup, adding Epson Moverio BT-200]
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../devicetree/bindings/arm/omap/omap.txt     | 152 ------------------
 .../devicetree/bindings/arm/ti/omap.yaml      | 147 +++++++++++++++++
 2 files changed, 147 insertions(+), 152 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/omap.yaml

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index fa8b31660cadd..0608ef36d0a68 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -41,49 +41,11 @@ SoC Type (optional):
 
 SoC Families:
 
-- OMAP2 generic - defaults to OMAP2420
-  compatible = "ti,omap2"
-- OMAP3 generic
-  compatible = "ti,omap3"
-- OMAP4 generic - defaults to OMAP4430
-  compatible = "ti,omap4"
-- OMAP5 generic - defaults to OMAP5430
-  compatible = "ti,omap5"
 - DRA7 generic - defaults to DRA742
   compatible = "ti,dra7"
-- AM33x generic
-  compatible = "ti,am33xx"
-- AM43x generic - defaults to AM4372
-  compatible = "ti,am43"
 
 SoCs:
 
-- OMAP2420
-  compatible = "ti,omap2420", "ti,omap2"
-- OMAP2430
-  compatible = "ti,omap2430", "ti,omap2"
-
-- OMAP3430
-  compatible = "ti,omap3430", "ti,omap3"
-  legacy: "ti,omap34xx" - please do not use any more
-- AM3517
-  compatible = "ti,am3517", "ti,omap3"
-- OMAP3630
-  compatible = "ti,omap3630", "ti,omap3"
-  legacy: "ti,omap36xx" - please do not use any more
-- AM335x
-  compatible = "ti,am33xx"
-
-- OMAP4430
-  compatible = "ti,omap4430", "ti,omap4"
-- OMAP4460
-  compatible = "ti,omap4460", "ti,omap4"
-
-- OMAP5430
-  compatible = "ti,omap5430", "ti,omap5"
-- OMAP5432
-  compatible = "ti,omap5432", "ti,omap5"
-
 - DRA762
   compatible = "ti,dra762", "ti,dra7"
 
@@ -96,116 +58,8 @@ SoCs:
 - DRA718
   compatible = "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
 
-- AM5748
-  compatible = "ti,am5748", "ti,dra762", "ti,dra7"
-
-- AM5728
-  compatible = "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
-
-- AM5726
-  compatible = "ti,am5726", "ti,dra742", "ti,dra74", "ti,dra7"
-
-- AM5718
-  compatible = "ti,am5718", "ti,dra722", "ti,dra72", "ti,dra7"
-
-- AM5716
-  compatible = "ti,am5716", "ti,dra722", "ti,dra72", "ti,dra7"
-
-- AM4372
-  compatible = "ti,am4372", "ti,am43"
-
 Boards (incomplete list of examples):
 
-- OMAP3 BeagleBoard : Low cost community board
-  compatible = "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
-
-- OMAP3 BeagleBoard A to B4 : Early BeagleBoard revisions A to B4 with a timer quirk
-  compatible = "ti,omap3-beagle-ab4", "ti,omap3-beagle", "ti,omap3430", "ti,omap3"
-
-- OMAP3 Tobi with Overo : Commercial expansion board with daughter board
-  compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3430", "ti,omap3"
-
-- OMAP4 SDP : Software Development Board
-  compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4"
-
-- OMAP4 PandaBoard : Low cost community board
-  compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4"
-
-- OMAP4 DuoVero with Parlor : Commercial expansion board with daughter board
-  compatible = "gumstix,omap4-duovero-parlor", "gumstix,omap4-duovero", "ti,omap4430", "ti,omap4";
-
-- OMAP4 VAR-STK-OM44 : Commercial dev kit with VAR-OM44CustomBoard and VAR-SOM-OM44 w/WLAN
-  compatible = "variscite,var-stk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
-
-- OMAP4 VAR-DVK-OM44 : Commercial dev kit with VAR-OM44CustomBoard, VAR-SOM-OM44 w/WLAN and LCD touchscreen
-  compatible = "variscite,var-dvk-om44", "variscite,var-som-om44", "ti,omap4460", "ti,omap4";
-
-- OMAP3 EVM : Software Development Board for OMAP35x, AM/DM37x
-  compatible = "ti,omap3-evm", "ti,omap3630", "ti,omap3"
-
-- AM335X EVM : Software Development Board for AM335x
-  compatible = "ti,am335x-evm", "ti,am33xx"
-
-- AM335X Bone : Low cost community board
-  compatible = "ti,am335x-bone", "ti,am33xx"
-
-- AM3359 ICEv2 : Low cost Industrial Communication Engine EVM.
-  compatible = "ti,am3359-icev2", "ti,am33xx"
-
-- AM335X OrionLXm : Substation Automation Platform
-  compatible = "novatech,am335x-lxm", "ti,am33xx"
-
-- AM335X phyBOARD-WEGA: Single Board Computer dev kit
-  compatible = "phytec,am335x-wega", "phytec,am335x-phycore-som", "ti,am33xx"
-
-- AM335X CM-T335 : System On Module, built around the Sitara AM3352/4
-  compatible = "compulab,cm-t335", "ti,am33xx"
-
-- AM335X SBC-T335 : single board computer, built around the Sitara AM3352/4
-  compatible = "compulab,sbc-t335", "compulab,cm-t335", "ti,am33xx"
-
-- AM335X phyCORE-AM335x: Development kit
-  compatible = "phytec,am335x-pcm-953", "phytec,am335x-phycore-som", "ti,am33xx"
-
-- AM335x phyBOARD-REGOR: Single Board Computer
-  compatible = "phytec,am335x-regor", "phytec,am335x-phycore-som", "ti,am33xx"
-
-- AM335X UC-8100-ME-T: Communication-centric industrial computing platform
-  compatible = "moxa,uc-8100-me-t", "ti,am33xx";
-
-- OMAP5 EVM : Evaluation Module
-  compatible = "ti,omap5-evm", "ti,omap5"
-
-- AM437x CM-T43
-  compatible = "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
-
-- AM437x SBC-T43
-  compatible = "compulab,am437x-sbc-t43", "compulab,am437x-cm-t43", "ti,am4372", "ti,am43"
-
-- AM43x EPOS EVM
-  compatible = "ti,am43x-epos-evm", "ti,am43", "ti,am438x"
-
-- AM437x GP EVM
-  compatible = "ti,am437x-gp-evm", "ti,am4372", "ti,am43"
-
-- AM437x SK EVM: AM437x StarterKit Evaluation Module
-  compatible = "ti,am437x-sk-evm", "ti,am4372", "ti,am43"
-
-- AM57XX CL-SOM-AM57x
-  compatible = "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
-
-- AM57XX SBC-AM57x
-  compatible = "compulab,sbc-am57x", "compulab,cl-som-am57x", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
-
-- AM5748 IDK
-  compatible = "ti,am5748-idk", "ti,am5748", "ti,dra762", "ti,dra7";
-
-- AM5728 IDK
-  compatible = "ti,am5728-idk", "ti,am5728", "ti,dra742", "ti,dra74", "ti,dra7"
-
-- AM5718 IDK
-  compatible = "ti,am5718-idk", "ti,am5718", "ti,dra7"
-
 - DRA762 EVM:  Software Development Board for DRA762
   compatible = "ti,dra76-evm", "ti,dra762", "ti,dra7"
 
@@ -217,9 +71,3 @@ Boards (incomplete list of examples):
 
 - DRA718 EVM: Software Development Board for DRA718
   compatible = "ti,dra718-evm", "ti,dra718", "ti,dra722", "ti,dra72", "ti,dra7"
-
-- DM3730 Logic PD Torpedo + Wireless: Commercial System on Module with WiFi and Bluetooth
-  compatible = "logicpd,dm3730-torpedo-devkit", "ti,omap3630", "ti,omap3"
-
-- DM3730 Logic PD SOM-LV: Commercial System on Module with WiFi and Bluetooth
-  compatible = "logicpd,dm3730-som-lv-devkit", "ti,omap3630", "ti,omap3"
diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
new file mode 100644
index 0000000000000..50be471d69939
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/ti/omap.yaml#
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
+              - nokia,n800
+              - nokia,n810
+              - nokia,n810-wimax
+              - ti,omap2420-h4
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
+              - compulab,omap3-cm-t3530
+              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom OMAP35xx SOM-LV Development Kit
+              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom OMAP35xx Torpedo Development Kit
+              - nokia,omap3-n900
+              - openpandora,omap3-pandora-600mhz
+              - ti,omap3430-sdp
+              - ti,omap3-beagle
+              - ti,omap3-evm                  # TI OMAP35XX EVM (TMDSEVM3530)
+              - ti,omap3-ldp                  # TI OMAP3430 LDP (Zoom1 Labrador)
+              - timll,omap3-devkit8000
+          - const: ti,omap3430
+          - const: ti,omap3
+
+      - description: TI OMAP3630 SoC based platforms
+        items:
+          - enum:
+              - amazon,omap3-echo             # Amazon Echo (first generation)
+              - compulab,omap3-cm-t3730
+              - goldelico,gta04
+              - lg,omap3-sniper               # LG Optimus Black
+              - logicpd,dm3730-som-lv-devkit  # LogicPD Zoom DM3730 SOM-LV Development Kit
+              - logicpd,dm3730-torpedo-devkit # LogicPD Zoom DM3730 Torpedo + Wireless Development Kit
+              - nokia,omap3-n9
+              - nokia,omap3-n950
+              - openpandora,omap3-pandora-1ghz
+              - ti,omap3-beagle-xm
+              - ti,omap3-evm-37xx             # TI OMAP37XX EVM (TMDSEVM3730)
+              - ti,omap3-zoom3
+          - const: ti,omap3630
+          - const: ti,omap3
+
+      - description: TI AM35 SoC based platforms
+        items:
+          - enum:
+              - compulab,omap3-sbc-t3517 # CompuLab SBC-T3517 with CM-T3517
+              - teejet,mt_ventoux
+              - ti,am3517-craneboard     # TI AM3517 CraneBoard (TMDSEVM3517)
+              - ti,am3517-evm            # TI AM3517 EVM (AM3517/05 TMDSEVM3517)
+          - const: ti,am3517
+          - const: ti,omap3
+
+      - description: TI OMAP4430 SoC based platforms
+        items:
+          - enum:
+              - amazon,omap4-kc1        # Amazon Kindle Fire (first generation)
+              - motorola,droid4         # Motorola Droid 4 XT894
+              - motorola,droid-bionic   # Motorola Droid Bionic XT875
+              - ti,omap4-panda
+              - ti,omap4-sdp
+          - const: ti,omap4430
+          - const: ti,omap4
+
+      - description: TI OMAP4460 SoC based platforms
+        items:
+          - enum:
+              - epson,epson,embt2ws    # Epson Moverio BT-200
+              - ti,omap4-panda-es
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
+              - bosch,am335x-guardian
+              - compulab,cm-t335
+              - gumstix,am335x-pepper
+              - moxa,uc-2101
+              - moxa,uc-8100-me-t
+              - novatech,am335x-lxm  # NovaTech OrionLXm
+              - tcl,am335x-sl50      # Toby Churchill SL50 Series
+              - ti,am335x-bone
+              - ti,am335x-evm
+              - ti,am335x-evmsk
+              - ti,am3359-icev2
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
+additionalProperties: true
+
+...
-- 
2.39.2

