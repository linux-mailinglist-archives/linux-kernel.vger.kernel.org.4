Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF46A6A48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCAJ4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCAJzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:55:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636A3B65B;
        Wed,  1 Mar 2023 01:55:41 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9879F6602124;
        Wed,  1 Mar 2023 09:55:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677664540;
        bh=eoUuj+cxZRXF8or5zd6PgagsDUpoYC3djot0WKXw2CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhkBXk2E6FkkjzWFHfrQFY3szV5J3eYC7vihoX8QMtmYiJnBouEHytcgWIlQdh774
         nS6GF8niejem4pwYCIwno8u55hl5sL17pA2rFL+6C1NU5TQAOaJ+PMSVPSts6GVego
         jQcb3SUaOknckuaAW+pYCoQIcsRRZEuQ9U/p7b9+cNkwPTPH09jpoPmfmSMzziuRFd
         xAaSRUyZ9Ji8z25/i+Gx+0B9NeY4FW0rhKzRhy3wUV583rDqmp+tC2W7XXsSd1Kpt8
         RdyY/5NKnuckUtJgOxFBDnaxTlSl3pVBDV7BFdxAenTHm56YjX5kPIDLTjeiYV+owM
         0MtB7C6puB40Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v4 16/19] arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
Date:   Wed,  1 Mar 2023 10:55:20 +0100
Message-Id: <20230301095523.428461-17-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
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

Enable the Mali-G57 found on this platform with the open-source
Panfrost driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 56749cfe7c33..24669093fbed 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -238,6 +238,11 @@ dptx_out: endpoint {
 	};
 };
 
+&gpu {
+	status = "okay";
+	mali-supply = <&mt6315_7_vbuck1>;
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.39.2

