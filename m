Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7C616BED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKBSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiKBSUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BBC2F3A4;
        Wed,  2 Nov 2022 11:20:15 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4DB7C6602946;
        Wed,  2 Nov 2022 18:20:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413214;
        bh=nT5ZYip6ykx0KuIPyyYFqsRIdtNMhO9TwzCn0g2rnOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6T/zZ1oQgFPo591b9rXyFM7G48u1J0BMKzZX6A9EFo+URmWGIwR2nTi8wsKoK5/P
         MrcxZzjRmBjDyj7NkA4ZR28MVBcMeibpOQj8qwzIeDa3o4ETcBOoWjCw5xMJjjoJdR
         5ULSNgo0+OulqriO4/fo91kCBOXktrAwxJ6b1y7ua9HbDHNNJ7U8gbzd+QrWLw7yJb
         YxJx1CI3Lqz6s01sdYBAQMptNzMbGhqDGsQrS2YYfqwc+s0lgOUArJw/Qgpl/MP+QJ
         GHWCJbnJGStTBzsU4zvHjzZ6LHwmBnms42KdhIg0SIOxR36R8TS/H9qVRKMpvnhsJn
         tZnQoq5zmvaZg==
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
Subject: [PATCH v2 4/8] ASoC: dt-bindings: rt5682: Add DBVDD and LDO1-IN supplies
Date:   Wed,  2 Nov 2022 14:19:58 -0400
Message-Id: <20221102182002.255282-5-nfraprado@collabora.com>
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

The rt5682 codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 Documentation/devicetree/bindings/sound/rt5682.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index 89e6245b870e..5e1d08de18a5 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -17,6 +17,12 @@ Required properties:
 - VBAT-supply: phandle to the regulator supplying battery power through the
   VBAT pin. Either MICVDD or VBAT should be present.
 
+- DBVDD-supply: phandle to the regulator supplying I/O power through the DBVDD
+  pin.
+
+- LDO1-IN-supply: phandle to the regulator supplying power to the digital core
+  and charge pump through the LDO1_IN pin.
+
 Optional properties:
 
 - interrupts : The CODEC's interrupt output.
@@ -87,4 +93,6 @@ rt5682 {
 
 	AVDD-supply = <&avdd_reg>;
 	MICVDD-supply = <&micvdd_reg>;
+	DBVDD-supply = <&dbvdd_reg>;
+	LDO1-IN-supply = <&ldo1_in_reg>;
 };
-- 
2.38.1

