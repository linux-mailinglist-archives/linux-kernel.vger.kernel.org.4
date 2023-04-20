Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8226E8E76
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjDTJp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbjDTJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:45:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687530DC;
        Thu, 20 Apr 2023 02:44:47 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E31B6603277;
        Thu, 20 Apr 2023 10:44:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681983886;
        bh=Ki82b4gc4Fw7arzhH5GwpAwTU4+4dn3MwLzf+E35F7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i9MxS6MJ2jPtcCh0u1FFZtTDC2G63yQc8253Cb6PGy/OMZ53SbLfhsn2H+iJ/0GYG
         P7MMNwZtdOqVxuxyJQL/h9q2eUkMYTFWuIIBbhEP06SHP2Zm5F0TCcMjChLSfLDS/l
         xCAkzdwGaZltA7wRXbOdpHFMS7s95ZWpqxtbgOyIpt9MmobDDAZoTqhKeMA6zNZ8jl
         RH0czZq6TOQ2CT0J1vW+5FTSfz/8to02Nbj+X4lxaL0tO2etlYLgflmUl3orBm6xYt
         GTQr7ngNDziMKRd9hW0KGKGxDbmc9w/E2D0yfBVrxtl1kCMLMpq5lePDoYD2r85aG7
         GsT7c6UbK3AHA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 2/5] arm64: dts: mediatek: cherry: Assign dp-intf aliases
Date:   Thu, 20 Apr 2023 11:44:30 +0200
Message-Id: <20230420094433.42794-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Cherry boards, the IP at 0x1c015000 (dp_intf0) is used as primary
dp-intf, while the other at 0x1c113000 (dp_intf1) is used as secondary:
assign them to dp-intf{0,1} aliases respectively.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 0820e9ba3829..918380697a9a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -10,6 +10,8 @@
 
 / {
 	aliases {
+		dp-intf0 = &dp_intf0;
+		dp-intf1 = &dp_intf1;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.40.0

