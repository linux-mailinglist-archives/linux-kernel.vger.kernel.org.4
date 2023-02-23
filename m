Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA126A0AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjBWNot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjBWNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:44:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E2757D0E;
        Thu, 23 Feb 2023 05:44:06 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2DDFE6602206;
        Thu, 23 Feb 2023 13:44:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159845;
        bh=862noHI/rREDzYDVTtjiXXlf1hVscfBOCM0dedbpEnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MGWa/tZWigRcJxgxhM8A1iWWkGMGzeUFou1U0A3VjGFkhm0eJ0rD6ThrC22N/K3pm
         U1DDgnyOzUqJVhcZhI4RR971z9KFzH/cBaPKtISZHOH9+u6Jm9qoCyzEx6O+Ub62xU
         pdLvmXZ0VihuTVW1bc6iZxSlh1NqCv/pgjSbEd0xeD33jT+r7ArI9k/AL/1UWEmiwk
         AGdJFK6hu7hK87LRdIKMlnuJ+Sqs/0OMb8e+H6Sh3gsganlfZuGiJdHsVZAC+dCtLF
         OTteXY0QB+l7iR+EiSUOkvEgtFhlc+OJm/Ch8jErxR0TfNBPAzNaXwX7iT88BW/EuK
         iY59O+s5v/wbQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 15/16] arm64: dts: mediatek: mt8195-cherry: Enable Mali-G57 GPU
Date:   Thu, 23 Feb 2023 14:43:44 +0100
Message-Id: <20230223134345.82625-16-angelogioacchino.delregno@collabora.com>
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

Enable the Mali-G57 found on this platform with the open-source
Panfrost driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

