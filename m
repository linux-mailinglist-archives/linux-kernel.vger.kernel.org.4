Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870536ECB46
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjDXLZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjDXLZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:25:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391B26A3;
        Mon, 24 Apr 2023 04:25:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CED3166032A3;
        Mon, 24 Apr 2023 12:25:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682335530;
        bh=E3a2HggcnHyNJ74IvNKxPxlRZM32GuP7ERQkfR2uopU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c05bQPsdHBaHdIUKTGFwCDDnZRKlU1p2vYIE+90NQ712UgdQYDYbtMoKDWv1bNONZ
         4DUvoHgzRW6g3Wj8baavyazYFU0eUvhI9QH2CkaJTjQPI9LIgPWm/PfYiveaSV8Jl9
         oh0daANq1QosxicEdaigSdqmKqUSrtuOg9PgY83F4RFMEgLcloSCer2RGYoBuwrrQc
         oB5eZC6Y4Kvhrrom/hEGgF7qZriyD56pN3e85qCLwVYUWPb9bgV8p/d5NChdMW6lrX
         TBXTzWXPe4GjWNqzJcRL2xJxp9v/Gs09st2hOvjgk+m5rHqrH1cQTXj4CCJu9AuW8s
         maXVRW3bSDlnQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/4] arm64: dts: mediatek: mt8195: Assign dp-intf aliases
Date:   Mon, 24 Apr 2023 13:25:21 +0200
Message-Id: <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
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

Assign aliases for the primary and secondary dp-intf IP to properly
and reliably enable DisplayPort functionality.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index a44aae4ab953..b03a42fe27a6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -24,6 +24,8 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		dp-intf0 = &dp_intf0;
+		dp-intf1 = &dp_intf1;
 		gce0 = &gce0;
 		gce1 = &gce1;
 		ethdr0 = &ethdr0;
-- 
2.40.0

