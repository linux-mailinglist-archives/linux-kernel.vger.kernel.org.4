Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6178611BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJ1U4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJ1Uz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8924E1DDDFF;
        Fri, 28 Oct 2022 13:55:54 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 877906602940;
        Fri, 28 Oct 2022 21:55:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990553;
        bh=r1qaS5ViUxHsg1AZWvTvqTeEqXfMJSJaHVFIn2x377M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be5H31LH2WXgTiryfnYQhUfs1ziaP8O4tktnP6GMZ9lHvDHyDw2tANpsISZUTjfkq
         OcI8IdOUoPhFlnB3qhBKE+zTOFr8qvc6PGHUIHAF/tihmeyKrhB1OVbew/pCENPxhR
         leaM04Iv+RZx14OV/Nmu1BEDuiKsqYU3yFZn1zGc04GgfsNi/nqNwIuv1gANRlFMwA
         jryI7hRCxCgixD9PKbC/dQfE6IqYOk/SrDVapZBOtEoJBDvARQQcJI9ipqohMCMm9K
         ShWaLByQEudq5HXvmL7kzSonT2c3WSyQ8NanSXY5N5YFwdQbujlpjvNySmzHTMKBk+
         BcKXmrXvDlLhg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies
Date:   Fri, 28 Oct 2022 16:55:35 -0400
Message-Id: <20221028205540.3197304-4-nfraprado@collabora.com>
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

The rt5682 codec has three supplies - AVDD, MICVDD and VBAT - which are
already used by sc7180-trogdor.dtsi. Document them in the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Commit adapted from [1], changes:
- Made supplies required
- Improved supplies descriptions

[1] https://lore.kernel.org/all/20221024220015.1759428-5-nfraprado@collabora.com

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

