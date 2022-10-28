Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8C611BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJ1U4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiJ1Uzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CA11D2B6D;
        Fri, 28 Oct 2022 13:55:52 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 511DE6602942;
        Fri, 28 Oct 2022 21:55:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990551;
        bh=dgNVES+PG7HYw90A/f6Jhk6U5cFEmEyu1X+wMPSSjEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oaRdgjikT/hfU/s0FaK1hkwIVF9Y1l3kfEWLM3nrpKFDOtkGCt4iiQhaNF5w0vWVU
         zIdCEi74XlLewBLxA31M+O93kT6m6IHkaOqnJQBYeULCbVEfEui8tcb+9PyppGF/Qf
         SqiT6TbpVrmc/4K1bPbOy33UnzjCgqiEKisZpp6WhYqtPjE3Ojyk/tEewx+fMb2SgK
         QtwcSj+Nc1Pj0FNTvGETnpg2g7ADwR5RT0hg68udxeztOW5gIgbM+oX8TMFZ1xCKLJ
         eBHJAO0I3Ox7tEZ3VT5jxjTUjO2WYyLgBPGRPxHoff+zoCgJLI9eqKtF0NS+Kcqw89
         zfJ+AeGsHwAcQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] ASoC: dt-bindings: realtek,rt5682s: Add dbvdd and ldo1-in supplies
Date:   Fri, 28 Oct 2022 16:55:34 -0400
Message-Id: <20221028205540.3197304-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682s codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/sound/realtek,rt5682s.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index b7338bfc0f5a..5b2bbf6f9156 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -97,6 +97,13 @@ properties:
     description: Regulator supplying power for the microphone bias through the
       MICVDD pin.
 
+  dbvdd-supply:
+    description: Regulator supplying I/O power through the DBVDD pin.
+
+  ldo1-in-supply:
+    description: Regulator supplying power to the digital core and charge pump
+      through the LDO1_IN pin.
+
 additionalProperties: false
 
 required:
@@ -104,6 +111,8 @@ required:
   - reg
   - AVDD-supply
   - MICVDD-supply
+  - dbvdd-supply
+  - ldo1-in-supply
 
 examples:
   - |
@@ -132,5 +141,7 @@ examples:
 
             AVDD-supply = <&avdd_reg>;
             MICVDD-supply = <&micvdd_reg>;
+            dbvdd-supply = <&dbvdd_reg>;
+            ldo1-in-supply = <&ldo1_in_reg>;
         };
     };
-- 
2.38.1

