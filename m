Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9840C616BE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiKBSUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiKBSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BD42F392;
        Wed,  2 Nov 2022 11:20:11 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C37566028E7;
        Wed,  2 Nov 2022 18:20:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413209;
        bh=iEfgs5/IYGmZLK5vLu7xq05AP6DxnckLW0sEoea0frY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtRxA8W7bF4/NcHMNMq2PIygyK9OwqM6gojFJZtfrdzUWgCwWIJ1+icj6wGwudqt5
         PzNGvMHcirjs4x71srNeg+LokD8kJ4nvjbmjdOivqdkqInWpfUs/GM8VqsNmlOHzbp
         JwS/5eEcJr9cxAOuuexzZdLbtJPFJpykDI24zVXWa5xn7N+VQLCLXU8rRrtO+maI5P
         exexpzKigGQt9GvuLvJqvVuVpI1EnaxFRg4GxpYR3kkAgwNjaOkLR+xLywCidA0C6D
         jFQOHCp5jR2W32OxAgZVMbOGTKBkd+diQMDc3qGY+5yQzbIR00tXUIY8rPaJR0eJcs
         Vu4KhtT3aze1g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
Date:   Wed,  2 Nov 2022 14:19:55 -0400
Message-Id: <20221102182002.255282-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
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

The rt5682s codec has two supplies - AVDD and MICVDD - which are already
used by sc7180-trogdor-kingoftown.dtsi. Document them in the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v1)

 .../devicetree/bindings/sound/realtek,rt5682s.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 1c0b06d82369..b7338bfc0f5a 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -90,11 +90,20 @@ properties:
   "#sound-dai-cells":
     const: 1
 
+  AVDD-supply:
+    description: Regulator supplying analog power through the AVDD pin.
+
+  MICVDD-supply:
+    description: Regulator supplying power for the microphone bias through the
+      MICVDD pin.
+
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - AVDD-supply
+  - MICVDD-supply
 
 examples:
   - |
@@ -120,5 +129,8 @@ examples:
 
             clocks = <&osc>;
             clock-names = "mclk";
+
+            AVDD-supply = <&avdd_reg>;
+            MICVDD-supply = <&micvdd_reg>;
         };
     };
-- 
2.38.1

