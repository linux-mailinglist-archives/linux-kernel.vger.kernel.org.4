Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4204E607EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJUTJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJUTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:09:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA96174E;
        Fri, 21 Oct 2022 12:09:19 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0F2B866025DF;
        Fri, 21 Oct 2022 20:09:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666379358;
        bh=TSzB9s/nYLhBExyStCN6t0/NJr0MxrTNQOpVLK8HItQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7Q8hxrolHCXqkoQxqQfkVh/NJ6dOT90S8sE0RxXfxzzzpq92P9/xuguTgU8NEqn4
         rAG0Ea15bDF/myzfJs9Nwgrk046HdFo7r/zZjF9ek4kxPekv9sI9Ve/j8Vg+G0HCNl
         /nBMVRyIB3UKQrSxFUlfeE3/p1sZf9HmqfXJZEANOViwDZEoYuo16O/ClyQYc+q92H
         yu6V6kSHXlQRLfpclTWw28+DD/NRmKkBCPtavzluivXxDI4Y6ez340z7qvVP+Ol9Ny
         Le16K8HyW3uNf6MIZlBx++r/JocAc8AC2sa4YKavd9m2gIWmgCuTshxnNSA3r7ry/m
         9D1ef9zLR9Hhg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: dt-bindings: rt5682: Add AVDD, MICVDD and VBAT supplies
Date:   Fri, 21 Oct 2022 15:09:08 -0400
Message-Id: <20221021190908.1502026-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021190908.1502026-1-nfraprado@collabora.com>
References: <20221021190908.1502026-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682 codec can have three supplies: AVDD, MICVDD and VBAT. Add
properties for them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/sound/rt5682.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index c5f2b8febcee..5ccf4eaf12a9 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -48,6 +48,12 @@ Optional properties:
 
 - #sound-dai-cells: Should be set to '<0>'.
 
+- AVDD-supply: phandle to the regulator supplying AVDD
+
+- MICVDD-supply: phandle to the regulator supplying MICVDD
+
+- VBAT-supply: phandle to the regulator supplying VBAT
+
 Pins on the device (for linking into audio routes) for RT5682:
 
   * DMIC L1
-- 
2.38.1

