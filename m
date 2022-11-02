Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CCA616BEB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiKBSUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiKBSUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0E72F648;
        Wed,  2 Nov 2022 11:20:12 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F00BF66028C5;
        Wed,  2 Nov 2022 18:20:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413211;
        bh=XreP8pLNPdmHQfo0+zus9VHh3oAKdgBVqoqtrPoAkGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzrG8eadOfxEzZBS9K6GzlezW9SFPw4pfPCJF8Og2axj/E7qE8ax0bfb/iLBTQzXm
         1CtK92x5oD8NiBEyf/uzIT0fhfoAeJxS0brRuKQf7lTDXSciMlhi37GYvfXuExdvTe
         LFP3yaxPBLiEA6IrTYnIncu2tfW6esFBimzicYLWt//iV+Yes8+ahiPzalbteNGJWM
         vL/P3xTOQGQEKMSxqHV8K+iYuLYGI6GvrcBRsh8NadLFrWAY4ZXtKzY7gPHSyBTjm9
         V19JXyACh5qP45pZHiUrPElIRXHjyno3qlh9MP3KdthKIQ8v9OnHwOaQ1wtshGZmTD
         DkEO754P4pjRA==
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
Subject: [PATCH v2 2/8] ASoC: dt-bindings: realtek,rt5682s: Add DBVDD and LDO1-IN supplies
Date:   Wed,  2 Nov 2022 14:19:56 -0400
Message-Id: <20221102182002.255282-3-nfraprado@collabora.com>
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

The rt5682s codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 .../devicetree/bindings/sound/realtek,rt5682s.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index b7338bfc0f5a..dc418652f241 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -97,6 +97,13 @@ properties:
     description: Regulator supplying power for the microphone bias through the
       MICVDD pin.
 
+  DBVDD-supply:
+    description: Regulator supplying I/O power through the DBVDD pin.
+
+  LDO1-IN-supply:
+    description: Regulator supplying power to the digital core and charge pump
+      through the LDO1_IN pin.
+
 additionalProperties: false
 
 required:
@@ -104,6 +111,8 @@ required:
   - reg
   - AVDD-supply
   - MICVDD-supply
+  - DBVDD-supply
+  - LDO1-IN-supply
 
 examples:
   - |
@@ -132,5 +141,7 @@ examples:
 
             AVDD-supply = <&avdd_reg>;
             MICVDD-supply = <&micvdd_reg>;
+            DBVDD-supply = <&dbvdd_reg>;
+            LDO1-IN-supply = <&ldo1_in_reg>;
         };
     };
-- 
2.38.1

