Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F3B6E8E79
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjDTJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjDTJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:45:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951333A82;
        Thu, 20 Apr 2023 02:44:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D498666032C3;
        Thu, 20 Apr 2023 10:44:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681983888;
        bh=Yqz9hxxQpWZLM7rhN5aHeOJGmtYVI7oPhYrdCY62XwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzbdLfM1L2lDA4EF69I31/GpYjSqkZ8Yewgd7Ym3oQbNgU017Ezx+R1FN0DZTMfw8
         GIh0PF8dBPEYGc0ujaEeoPgULCWknjDfMaNO1BNV1So1LxgOFxQPxfyilG3m40EiTd
         Kg+Tne0YZowKPFJzng/zaRpGS+z4fvFQdj08sQ+tzsd/Udrwz8JYgHJI9TdI+gnxDX
         bHs8DKZ/7W/idXhbDBMpD1k4lGedjnXATxFqIEwhBGm56Xv3RY7rKnwmOm8N6Dx2nf
         g32GlXMl90pIm8u8oAZ7rp/xEKsIpZiGqqOHDB1P4mBRuuqmwyX8ZshQmR1s3ATOyy
         BIMBtKTbGjFfQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 5/5] arm64: dts: mediatek: cherry-tomato-r1: Enable NVMe PCI-Express port
Date:   Thu, 20 Apr 2023 11:44:33 +0200
Message-Id: <20230420094433.42794-6-angelogioacchino.delregno@collabora.com>
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

On Tomato rev1 the PCIe0 controller is used for NVMe storage.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
index 2d5e8f371b6d..11fc83ddf236 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
@@ -20,6 +20,13 @@ &sound {
 	model = "mt8195_r1019_5682";
 };
 
+&pcie0 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins_default>;
+};
+
 &ts_10 {
 	status = "okay";
 };
-- 
2.40.0

