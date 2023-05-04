Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCAE6F6D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjEDOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjEDOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 10:01:57 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2B97EDB
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1683208913; x=1685800913;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/jhHcFJ1LJ1W+GNxuQ4Xu89JZAN9lv1YtQk70nLZhYg=;
        b=KbnkbKv1o2EtOnTBGYsM8AxL1zbPUpKPNMicgIkPwhMC0ePhDQjrhrwkGvIf57dw
        W/5SI8H0vvbayuVQK+kA28emst2RIpiSOYFsu54zQpeVuP3lcAPqeJPzb076wFd3
        1ivkmGdK/KKYBMdzlAIKPBWT1Wl2fG+ewYi7bT/sKyg=;
X-AuditID: ac14000a-923ff70000007ecb-c6-6453bad1c0cc
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 20.DD.32459.1DAB3546; Thu,  4 May 2023 16:01:53 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 4 May
 2023 16:01:53 +0200
From:   Wadim Egorov <w.egorov@phytec.de>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>
CC:     <upstream@lists.phytec.de>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <gpiccoli@igalia.com>
Subject: [PATCH 1/2] dt-bindings: arm: ti: Add bindings for PHYTEC AM62x based hardware
Date:   Thu, 4 May 2023 16:01:42 +0200
Message-ID: <20230504140143.1425951-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWyRpKBR/firuAUgwcvZSzmHznHajHv/GF2
        izPduRbLP89mt+h78ZDZYtPja0Dx9T8ZLS7vmsNm8ebHWSaL1r1H2C3eXLjHYtH9Tt3i/9kP
        7A68HrMbLrJ4TJjdzeaxeM9LJo9NqzrZPO5c28PmsXlJvUd/dwurx/Eb25k8Pm+SC+CM4rJJ
        Sc3JLEst0rdL4Mo4+SOx4C9bxaq7W5gaGNexdjFycEgImEi0TK7uYuTkEBJYwiSx6LFSFyMX
        kP2YUeLX2ZvsIAk2AXWJOxu+sYLYIgK9jBJnWgpBipgFbjNKbF6ygw0kISwQLvHi3n4wm0VA
        RWL7s9dgNq+ApcT923vAbAkBeYmZl76zQ8QFJU7OfMICYjMDxZu3zmaGsCUkDr54wQxxkbzE
        i0vLWWB6p517zQxhh0ps/bKdaQKjwCwko2YhGTULyagFjMyrGIVyM5OzU4sys/UKMipLUpP1
        UlI3MYJiR4SBawdj3xyPQ4xMHIyHGCU4mJVEeD8U+qUI8aYkVlalFuXHF5XmpBYfYpTmYFES
        573fw5QoJJCeWJKanZpakFoEk2Xi4JRqYJz+MSzh1jNhgYYzqT+lr3w2qXfZJR/eVvJ0u9fi
        NduW/uurz1h7S/KTFMd3l8t7G7bkqKpt3Oz0mXW6ssuzuojeoyFbHXPy/KOOaWqLpl24d7hD
        65/XZo3l39ziO2ceUD4dzWzbwyHsff6G/JO512VP2e3LcJH9pnDsh398imOw2KyfhgaPniix
        FGckGmoxFxUnAgBl/Fz4iwIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for AM62x based phyCORE-AM62 SoM
and phyBOARD-Lyra RDK.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index e1183f90bb06..254b5ec51f34 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -25,6 +25,12 @@ properties:
               - ti,am62a7-sk
           - const: ti,am62a7
 
+      - description: K3 AM625 SoC PHYTEC phyBOARD-Lyra
+        items:
+          - const: phytec,am625-phyboard-lyra-rdk
+          - const: phytec,am62-phycore-som
+          - const: ti,am625
+
       - description: K3 AM625 SoC
         items:
           - enum:
-- 
2.25.1

