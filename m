Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903E36575ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiL1LcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiL1LcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:32:13 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C826425
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:32:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id e21so970822pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTmLp3WPbuZV+b+hTAD9egOWKyUGIagroxlWC31ebpo=;
        b=nvJ56kdO6TYBqlvfyBBy44mrPbj6j0sswfmD+BfW6JUnz947+VBa0I4+vIvGnGxL2C
         xsOILcAE8JSmL+VcfWGh+DcPuST3RRIwqbyi/SEUy/pYwNbKJkCU429Z+w9m3YyJfkj+
         osoiuk3YMs4zhIh181anhkeSpwMm/FhgqeYWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTmLp3WPbuZV+b+hTAD9egOWKyUGIagroxlWC31ebpo=;
        b=xbC/B9QdO+ih4MHJrjiKM+V0QzWC8IruALBropbX7UFNj31faDoAMo90nqzI4iWm7g
         y44E8Nrmh5ZYm6StM+jqPfLpkzmdLi+Fq39PvJen2d5CUKFVEQyxSLfptNY4/y/Wi2Ri
         FbiEa9xgF1TLks/4Ar4ZSn93YFc5QVzQoWWcHdj4D7lVe3omKZiGIRkNB1nWNJ54NdVI
         cHTEnn2Zbo/d32PRfe7XaxtwcD7iJzFFCj7dyuklr+M5nGnjnnxKWH5tzbNNq+fg7f1J
         9dPC/jYgCfrF6fg/5w/ZN5HctThNR+bKb7qLrI6IfJGDiWCHnuvsa5iClk9gUVYYwE+o
         b2+Q==
X-Gm-Message-State: AFqh2korio1gXJLbCLUI8BEHkkSyCbzW2lm8kbkPdrAyJbvtQ43MJoKT
        4wUsl2euw3lrjTrkdz7AoGAlwWuqOym8Yavi
X-Google-Smtp-Source: AMrXdXsMYQjyC6xgL+G4AOqkuUQJXWG3LyE0123LXzv3W/PwJe5cSz4GYQWNfvPJ8/GMg0yggFHymw==
X-Received: by 2002:a05:6a00:26d8:b0:56b:9b71:ca2f with SMTP id p24-20020a056a0026d800b0056b9b71ca2fmr23155416pfw.11.1672227132377;
        Wed, 28 Dec 2022 03:32:12 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:882f:1d5e:9d7e:ebbd])
        by smtp.gmail.com with ESMTPSA id w18-20020aa79a12000000b00581816425f3sm1987756pfj.112.2022.12.28.03.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 03:32:12 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] arm64: dts: mt8183: jacuzzi: Move panel under aux-bus
Date:   Wed, 28 Dec 2022 19:32:04 +0800
Message-Id: <20221228113204.1551180-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read edp panel edid through aux bus, which is a more preferred way. Also
use a more generic compatible since each jacuzzi models use different
panels.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../dts/mediatek/mt8183-kukui-jacuzzi.dtsi    | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 3ac83be53627..543286ce9cea 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -6,18 +6,6 @@
 #include "mt8183-kukui.dtsi"
 
 / {
-	panel: panel {
-		compatible = "auo,b116xw03";
-		power-supply = <&pp3300_panel>;
-		backlight = <&backlight_lcd0>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&anx7625_out>;
-			};
-		};
-	};
-
 	pp1200_mipibrdg: pp1200-mipibrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1200_mipibrdg";
@@ -181,6 +169,20 @@ anx7625_out: endpoint {
 				remote-endpoint = <&panel_in>;
 			};
 		};
+
+		aux-bus {
+			panel: panel {
+				compatible = "edp-panel";
+				power-supply = <&pp3300_panel>;
+				backlight = <&backlight_lcd0>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&anx7625_out>;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.39.0.314.g84b9a713c41-goog

