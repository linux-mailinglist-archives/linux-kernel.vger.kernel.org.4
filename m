Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579916A0AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234717AbjBWNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjBWNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2D57D03;
        Thu, 23 Feb 2023 05:44:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39FDF660220A;
        Thu, 23 Feb 2023 13:44:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159843;
        bh=5uTIKzxccTuXc8ARaKxHVjhHv2AKqCAZTuNnIoDmS70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sw4L5ZnqFa2sLyuyW38JEOlhxqihMMNhrcOZtS0RpYhksw57hMyge1E4LSf1I8J1P
         Ta9EdICsUkzksw7zGmVS+mf1y27y05qHPRegzsuouZLyfZ9sYpqMmZ8jYelECmMcm+
         E3pW6wlUovBL9sGjTVjvedOMt2U4qSDQkuQ4zNSQ0Da/Cak36Ds/L83szZviB/pjzY
         JbkYgXFpOnzsd2jVPOpkUzPwEK+lP7ZkVN9Tl7V2G1AkAt2ODXmGb7HcaHTZ+xl6GK
         kHo8Al6Vw1vxJA6rZUg7lZ/m2dBxaxhkgox/eQ7YD35KH3XgE0P/HjOUL19kdlviVK
         WWde/QVkRzJvA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: [PATCH v2 12/16] arm64: dts: mediatek: mt8192-asurada: Enable GPU
Date:   Thu, 23 Feb 2023 14:43:41 +0100
Message-Id: <20230223134345.82625-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
References: <20230223134345.82625-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Enable the GPU with its power supplies described.

Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
[wenst@: patch split out from MT8192 GPU node patch]
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
[Angelo: Minor commit title fix]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index c8b6e1a9605b..067685191ba6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -275,6 +275,11 @@ &dsi_out {
 	remote-endpoint = <&anx7625_in>;
 };
 
+&gpu {
+	mali-supply = <&mt6315_7_vbuck1>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.39.2

