Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B242654052
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbiLVL4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiLVLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:54:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA69B2CC97;
        Thu, 22 Dec 2022 03:49:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF2CE6602CDA;
        Thu, 22 Dec 2022 11:49:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709775;
        bh=Tr/46hNNOpqiOPa/o4lwiU65I35XnBdfwH4jCPa5+O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkvZjgkK5shQMRzCcdGGltXudtsDvdURUWGjYcJTBAXYZPzM7FfHwOfzn3Wrx5UtU
         bioxR2SRpIqJ6SmRehVzitgBgg/+RFltcUtMqpaBXy6Ct4YnpLVakKNoF9tC1m4nXG
         dIA20SB/YDTwdbU3zYfcMcxyiKXFGErxLiBUGYAkQ6AXeJy+JHoKdDr1YAyrDOEjE/
         QZgX/7PV/SzOT7C2vae5zGZQwaZNFTJJBJuAn7xJgBGyLhGA794rpKjl5ropAJ9aon
         HuGag79PsKpMLd6qdcf+Y3LC+y87JX6zKrhb70p7qnSg75NdWr8/4AdJDmWuSIPjQ9
         eWEeyp7OPIGEA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 12/25] dt-bindings: clock: mt2701/mt6779: Add dummy clock with ID 0
Date:   Thu, 22 Dec 2022 12:48:44 +0100
Message-Id: <20221222114857.120060-13-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
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

As done for MT8173 and as a preparation for clock controller drivers
cleanups, add a dummy clock with ID 0, allowing us to simplify
driver probe.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 include/dt-bindings/clock/mt2701-clk.h | 3 +++
 include/dt-bindings/clock/mt6779-clk.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 6d531d5ae065..0ec2c81453b0 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -7,6 +7,9 @@
 #ifndef _DT_BINDINGS_CLK_MT2701_H
 #define _DT_BINDINGS_CLK_MT2701_H
 
+/* Dummy clock for backwards compatibility */
+#define CLK_DUMMY			0
+
 /* TOPCKGEN */
 #define CLK_TOP_SYSPLL				1
 #define CLK_TOP_SYSPLL_D2			2
diff --git a/include/dt-bindings/clock/mt6779-clk.h b/include/dt-bindings/clock/mt6779-clk.h
index b083139afbd2..478d4af33b2a 100644
--- a/include/dt-bindings/clock/mt6779-clk.h
+++ b/include/dt-bindings/clock/mt6779-clk.h
@@ -7,6 +7,9 @@
 #ifndef _DT_BINDINGS_CLK_MT6779_H
 #define _DT_BINDINGS_CLK_MT6779_H
 
+/* Dummy clock for backwards compatibility */
+#define CLK_DUMMY			0
+
 /* TOPCKGEN */
 #define CLK_TOP_AXI			1
 #define CLK_TOP_MM			2
-- 
2.39.0

