Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA45616BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiKBSU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiKBSUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C0E2F02A;
        Wed,  2 Nov 2022 11:20:14 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AFC3066028E3;
        Wed,  2 Nov 2022 18:20:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413213;
        bh=aHKXHg5yRWCszz4RN5TUFELZQbFWp0LXSet1RHes8lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqLVraj7daBs/qNGOyMgszO7PYrOjdyFfjnFJkoiTC/1Jxm/fdHpn0MZNNjV/xUG1
         b3Z+YeiUD0HOls+xF1xUB8EfRTcIy/2diBZJonReDRRWGhA0t29hD/yq0j1MYKI4b9
         eu/eJZCBtewDSvaKdl0j7KdrJS72+y7SaCc1xlT2boF2tHuejdDD0xlja5TjdcC/ol
         1y6pTQcLfzmyYA6AMGsydD7QgHx/yyqfVxIa9rZx24pTRUl/i1MuQ8gZh2ET6VQzFF
         MNb1qX2O0oXwypUhidFIpRE4syMtSyg6o0s4pUfbFJxnVhvCW0C5V1aav0HiKUUUMh
         iDE4Mo2/OxTPA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies
Date:   Wed,  2 Nov 2022 14:19:57 -0400
Message-Id: <20221102182002.255282-4-nfraprado@collabora.com>
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

The rt5682 codec has three supplies - AVDD, MICVDD and VBAT - which are
already used by sc7180-trogdor.dtsi. Document them in the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/sound/rt5682.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 6b87db68337c..89e6245b870e 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -8,6 +8,15 @@ Required properties:
 
 - reg : The I2C address of the device.
 
+- AVDD-supply: phandle to the regulator supplying analog power through the
+  AVDD pin
+
+- MICVDD-supply: phandle to the regulator supplying power for the microphone
+  bias through the MICVDD pin. Either MICVDD or VBAT should be present.
+
+- VBAT-supply: phandle to the regulator supplying battery power through the
+  VBAT pin. Either MICVDD or VBAT should be present.
+
 Optional properties:
 
 - interrupts : The CODEC's interrupt output.
@@ -75,4 +84,7 @@ rt5682 {
 
 	clocks = <&osc>;
 	clock-names = "mclk";
+
+	AVDD-supply = <&avdd_reg>;
+	MICVDD-supply = <&micvdd_reg>;
 };
-- 
2.38.1

