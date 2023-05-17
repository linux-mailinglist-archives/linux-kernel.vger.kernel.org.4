Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD817062DB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjEQI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEQI2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:28:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B267F527E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30786c87cdaso404246f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684312120; x=1686904120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eu5wBdYDMhnKWI5ZxIuGItWy4vhuwotpURg9WclmXbc=;
        b=zIEMmEp/p4baKiwPiWx4vvDG7lZye60jRK4898SytiBhtv9P8kFt940oGyM8ocD124
         Y5HS30fPZgiK2xJbjH1akWcvDYdm63FHfsqnE7JG2NuyfyzWP/yvaGCGgSoIVLMMW2z2
         4IOXGzvHbR5+NPqysE6mH8I8ChFvD/qX2su72c5YGXbFuVH1a0B+Ijsxes7gjWHFHFmM
         xpL1yWC7T5N5+HlNhXdIjAPiqi++HCwih9qcCS3f7CKULcf5jXTJYJjubR98/HZEvncb
         pfGmWkAJLzUsPeidPc/rvnCUPu0hpH1HMixPdVuj6s/i3xZEfp4AWDM6jF0aKxqI563u
         2yjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684312120; x=1686904120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eu5wBdYDMhnKWI5ZxIuGItWy4vhuwotpURg9WclmXbc=;
        b=E1wiea/vd3LabGts3zbFyVOSXhuVhOZY4NrkpL+1md+LaKRW39bvrPVc3yxC13PxLa
         J0xaj5mS9szk4+X+VDjwtl9gyxfp0mwcfLuhw8uWhZN5NhBHhTNMep/QZczBxXLr6aiU
         qImZvzEMVj3eQFJ794rocqu0gSp9UfvIxlWtvSL/Jf2pfqYbLwj9ER66QgInM5FBkhAq
         ZsIj4nt5GLz9PT21Ilg/bFIuQrA4MC78r1xRtgLQXypM6biwlBLdrj/RureEOntoKm3Q
         J6rbVaheI9IJw4qcAG+C8xH4vUUAGxYb0O12JdLTxm9gqwUEwTruJtaicY2rWpUjnHTo
         TzYg==
X-Gm-Message-State: AC+VfDyOOeW5dxv9VoIcN1Iotau7Q1Ms7mHoTCw2YdUhjKM0uvq6iMbz
        uBHAkoYMlXa0NNVl1+TL2OoUSw==
X-Google-Smtp-Source: ACHHUZ7INZJPU8cqk0722h+0YqO59eQXTHphgYKZEse4d+7xGRQU1V77UbgdFuGbvNnU0EXfdpv9DQ==
X-Received: by 2002:a05:6000:1184:b0:307:8a39:5568 with SMTP id g4-20020a056000118400b003078a395568mr12477wrx.7.1684312119941;
        Wed, 17 May 2023 01:28:39 -0700 (PDT)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c4-20020a056000104400b0030922ba6d0csm2323066wrx.45.2023.05.17.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 01:28:39 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 17 May 2023 10:28:20 +0200
Subject: [PATCH 2/2] clk: mediatek: mt8365: remove the max clock number
 defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-fix-clk-index-v1-2-142077a1732b@baylibre.com>
References: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
In-Reply-To: <20230517-fix-clk-index-v1-0-142077a1732b@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3076; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=PSoSzv1xmNtqCH3MpEopV6wHPK3FDL/LaVYm5PLJAXs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkZJA0Um0n64a27LeuDv6FePlEhoVZS6flRLZoow6O
 +IcDoNCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZGSQNAAKCRArRkmdfjHURc/nEA
 CTrShs0dbmr8P/p47L1ojpwfc7xJgpvhyvbBz+HyEevnxmcPbHujlP6oXbCaOpjf8d77Fyjko3SAem
 aGX7nSyFMz47BY+wen7kHvGW5zAKy1o227fXyIiOUdmz91RkJf4PqVuUGGg1V3cfcDuXEi4T381/3S
 7zTX+E3LmEtuALIGvYbkXzO0FEj/ppXbyWFhKbu6+6G/JNKoL7nh9bSy5jQ8mx44jLp50EqS2ZvqB+
 pkT6ObvKwN8lvyfWEWWo8eYTdGFKKjjt5tMJ5WuKyuvFeglef2u/z+rzBRF+4ABPByqHgOHUvP5QUU
 KR9ug3rY1oEkQH7d9V2kjD5PaNZ+8r+ofHat5/afF3MoaQ311TtL2F/8aI3i30LfKr6U0kupwuLn/r
 OVosm8nVkv/LagdvEK2t8/v0ZicEH2yDheCCJ4pqJZzTm7QHIEN49KawaWh8Om3A/Zt7TnYibr9xnV
 X0hOmWH7mbOJ4/0lWeGEA8XZ/5/GXrQlixZe+8hw2K/VOxZhEqB4EfhqiYW7RLzjGsGuk2nUA6VrFW
 SP5CQN8vLVxudT1osnLRbRJBmNZ5Fyaz7dWaJql9kpMn9VlVEWXWaFqZDnMeHyMNyHCTorRmMbfL0y
 9qUtu1dizs+9+q6IQf9MNrV/blPwJJniu7pZpBYtVqqLn5ul1eXrbw4MMaAQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we swap to the generic MTK probe function [1], the *_NR_CLK
defines used to know the number of defined clocks are no longer
necessary. This patch remove all *_NR_CLK.

[1]: Commit ffe91cb28f6a ("clk: mediatek: mt8365: Convert to
     mtk_clk_simple_{probe,remove}()")

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 include/dt-bindings/clock/mediatek,mt8365-clk.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/dt-bindings/clock/mediatek,mt8365-clk.h b/include/dt-bindings/clock/mediatek,mt8365-clk.h
index fd59c8bdeb24..a1df91f73d73 100644
--- a/include/dt-bindings/clock/mediatek,mt8365-clk.h
+++ b/include/dt-bindings/clock/mediatek,mt8365-clk.h
@@ -142,7 +142,6 @@
 #define CLK_TOP_CONN_26M		132
 #define CLK_TOP_DSP_32K			133
 #define CLK_TOP_DSP_26M			134
-#define CLK_TOP_NR_CLK			135
 
 /* INFRACFG */
 #define CLK_IFR_PMIC_TMR		0
@@ -214,11 +213,9 @@
 #define CLK_IFR_SSUSB_SYS		66
 #define CLK_IFR_SSUSB_REF		67
 #define CLK_IFR_SSUSB_XHCI		68
-#define CLK_IFR_NR_CLK			69
 
 /* PERICFG */
 #define CLK_PERIAXI			0
-#define CLK_PERI_NR_CLK			1
 
 /* APMIXEDSYS */
 #define CLK_APMIXED_ARMPLL		0
@@ -238,7 +235,6 @@
 
 /* GCE */
 #define CLK_GCE_FAXI			0
-#define CLK_GCE_NR_CLK			1
 
 /* AUDIOTOP */
 #define CLK_AUD_AFE			0
@@ -259,40 +255,31 @@
 #define CLK_AUD_I2S2_BK			15
 #define CLK_AUD_I2S3_BK			16
 #define CLK_AUD_I2S4_BK			17
-#define CLK_AUD_NR_CLK			18
 
 /* MIPI_CSI0A */
 #define CLK_MIPI0A_CSR_CSI_EN_0A	0
-#define CLK_MIPI_RX_ANA_CSI0A_NR_CLK	1
 
 /* MIPI_CSI0B */
 #define CLK_MIPI0B_CSR_CSI_EN_0B	0
-#define CLK_MIPI_RX_ANA_CSI0B_NR_CLK	1
 
 /* MIPI_CSI1A */
 #define CLK_MIPI1A_CSR_CSI_EN_1A	0
-#define CLK_MIPI_RX_ANA_CSI1A_NR_CLK	1
 
 /* MIPI_CSI1B */
 #define CLK_MIPI1B_CSR_CSI_EN_1B	0
-#define CLK_MIPI_RX_ANA_CSI1B_NR_CLK	1
 
 /* MIPI_CSI2A */
 #define CLK_MIPI2A_CSR_CSI_EN_2A	0
-#define CLK_MIPI_RX_ANA_CSI2A_NR_CLK	1
 
 /* MIPI_CSI2B */
 #define CLK_MIPI2B_CSR_CSI_EN_2B	0
-#define CLK_MIPI_RX_ANA_CSI2B_NR_CLK	1
 
 /* MCUCFG */
 #define CLK_MCU_BUS_SEL			0
-#define CLK_MCU_NR_CLK			1
 
 /* MFGCFG */
 #define CLK_MFG_BG3D			0
 #define CLK_MFG_MBIST_DIAG		1
-#define CLK_MFG_NR_CLK			2
 
 /* MMSYS */
 #define CLK_MM_MM_MDP_RDMA0		0
@@ -331,7 +318,6 @@
 #define CLK_MM_MM_DPI0			33
 #define CLK_MM_LVDSTX_PXL		34
 #define CLK_MM_LVDSTX_CTS		35
-#define CLK_MM_NR_CLK			36
 
 /* IMGSYS */
 #define CLK_CAM_LARB2			0
@@ -342,17 +328,14 @@
 #define CLK_CAMSV1			5
 #define CLK_CAM_FDVT			6
 #define CLK_CAM_WPE			7
-#define CLK_CAM_NR_CLK			8
 
 /* VDECSYS */
 #define CLK_VDEC_VDEC			0
 #define CLK_VDEC_LARB1			1
-#define CLK_VDEC_NR_CLK			2
 
 /* VENCSYS */
 #define CLK_VENC			0
 #define CLK_VENC_JPGENC			1
-#define CLK_VENC_NR_CLK			2
 
 /* APUSYS */
 #define CLK_APU_IPU_CK			0
@@ -361,6 +344,5 @@
 #define CLK_APU_IF_CK			3
 #define CLK_APU_EDMA			4
 #define CLK_APU_AHB			5
-#define CLK_APU_NR_CLK			6
 
 #endif /* _DT_BINDINGS_CLK_MT8365_H */

-- 
2.25.1

