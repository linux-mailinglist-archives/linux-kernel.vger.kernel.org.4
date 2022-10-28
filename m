Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273DE611BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJ1U4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJ1Uz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F591EA541;
        Fri, 28 Oct 2022 13:55:56 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9DDD76602946;
        Fri, 28 Oct 2022 21:55:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990555;
        bh=kjJv2wI4r1COdPJDLysFujzo37yIvD0eiCbT/D7WY8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVADpfkI9YN8wvlcRgrsvTvdm8VyxolhpHN7+2z3ao+LKiotKKSHsYNVuoUFAh/X5
         ncUKhS0W2QJK0rnAK9M2Sp2D6+GfW+EtzDfDgpQyywPigP79gyWm1kGgGYzFhydyMP
         kjYlMenwb/GMAlTOrL1tgeoPOoLr7LMJPPIu4xH9IvcsHqDk6AXdcxs5SI4Mgc0OOw
         xxUN+QMiWsSbzESkpU+7viNdCpv1BUrC0GXVNOezS/xbb2CyuLjhaisxxTmgBgDqqc
         /M8/Awa1tJIQTDSnYKD1ENE4fwv8exUmDkeFZPoln8BPcQ5AFYuMIrp8nO2cb/Z/3n
         WH75CERAEuSFA==
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
Subject: [PATCH 4/8] ASoC: dt-bindings: rt5682: Add dbvdd and ldo1-in supplies
Date:   Fri, 28 Oct 2022 16:55:36 -0400
Message-Id: <20221028205540.3197304-5-nfraprado@collabora.com>
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

The rt5682 codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/sound/rt5682.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 89e6245b870e..948109ff0db3 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -17,6 +17,12 @@ Required properties:
 - VBAT-supply: phandle to the regulator supplying battery power through the
   VBAT pin. Either MICVDD or VBAT should be present.
 
+- dbvdd-supply: phandle to the regulator supplying I/O power through the DBVDD
+  pin.
+
+- ldo1-in-supply: phandle to the regulator supplying power to the digital core
+  and charge pump through the LDO1_IN pin.
+
 Optional properties:
 
 - interrupts : The CODEC's interrupt output.
@@ -87,4 +93,6 @@ rt5682 {
 
 	AVDD-supply = <&avdd_reg>;
 	MICVDD-supply = <&micvdd_reg>;
+	dbvdd-supply = <&dbvdd_reg>;
+	ldo1-in-supply = <&ldo1_in_reg>;
 };
-- 
2.38.1

