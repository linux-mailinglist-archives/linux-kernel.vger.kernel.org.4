Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06BA8616BFA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiKBSUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiKBSUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:20:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A412F39C;
        Wed,  2 Nov 2022 11:20:22 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06A4166028F8;
        Wed,  2 Nov 2022 18:20:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667413221;
        bh=/QzOMlinMw2KNMfW0WPe42TTNOsZDuKQIwgbcG/lv+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxOSZ5wZ5gas/AvmGFbr29AnR2CBbW8oShzREFwqzRR5fWmklTj5KVLayT1xwVnfP
         ef6J4cFRQbZcV/SMwM6MSstFV0hZpdJGgAKb+NdbcF9+cStkD5kWiUSJ81Bp/8XJVh
         EiTyrXyURJGVXF7cQ2mvhgWOkl0XfcIJL7xWbP+k6ZnGI6ps0lyWDADXjZrmJ9qpIf
         DJJgg5Wy1pOqcVxY8tst05lrB2mZ3PgZv78b7oL4Irj2u+dAWBNhpsaVEBTPg0Pjy9
         YLUy3HJ8fDHs7KiVM9kLLtFLrA4h5RzIe0vpzbgfVq6DTpSntXeaajTwX4lVXxOx0u
         1OHIkDELuYQlQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: qcom: sc7180-trogdor: Remove VBAT supply from rt5682s
Date:   Wed,  2 Nov 2022 14:20:02 -0400
Message-Id: <20221102182002.255282-9-nfraprado@collabora.com>
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

These devicetrees override a rt5682 node to use the rt5682s compatible,
however, unlike rt5682, rt5682s doesn't have a VBAT supply. Remove the
inexistent supply in the rt5682s nodes.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi          | 1 +
 .../dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts     | 1 +
 .../dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
index 74f0e07ea5cf..e0fb83a9a0b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
@@ -11,6 +11,7 @@
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
index aa605885c371..6225ab8329c3 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-boe-rt5682s.dts
@@ -19,6 +19,7 @@ / {
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
index 7116c44c8d85..b40b068dad6a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dts
@@ -19,6 +19,7 @@ / {
 
 &alc5682 {
 	compatible = "realtek,rt5682s";
+	/delete-property/ VBAT-supply;
 	realtek,dmic1-clk-pin = <2>;
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
-- 
2.38.1

