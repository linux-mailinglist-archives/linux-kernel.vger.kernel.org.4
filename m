Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D436BA60D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCOEMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCOELx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:11:53 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB25D8AA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:11:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z10so10075809pgr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678853474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HKoujjtc9hCGDl1d2RjrGi/c9c1GCO8QdPXGn1k1ZhE=;
        b=PqGSN9BYMdbfE0eWEVmbysbCyChbr6sF9pWxkj85Kz5mkziotP9bSFSXW4C9708ksD
         PdMQdDG3U9RhQxCC+RljHg5ufQoAaOkiDJ7qb1zQhp+AnWEBYLxLDrsn+104v9cVnufh
         r8yR10WUyRReQ9MTec2gjjnuTMDIY3sM0fsUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678853474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKoujjtc9hCGDl1d2RjrGi/c9c1GCO8QdPXGn1k1ZhE=;
        b=cR4ttpDLeiH/AjEJdwQcVAPgjGf0xhUPx2wzskOkJTNYXO2TuPFbHpOA0cIC19CVSX
         eLVIA4NefPy52xL5WcDXLyClT20y4ArOGRAG3s50TXYRb8/90hFNwBmuErdebIrrtl18
         OYw35HGL2A5o1c2grfvmhDjKggBrOodRvW2hrYuQtK4gJlMrUyBOhomwNQud1VqOFlkn
         WwkAPvO2kGKhhUNb03yZOd+fvVFw0dkOzY8dHoTeu/qON4w7zaz1IsuUtqw2DSPMBP3y
         pNzD0AI0RPdXMxskEiYRd1il7MYXAHMHyS5ZkSp3lelx8cJpYDE1Qz4f3YVG3l1mtTfT
         e6Xw==
X-Gm-Message-State: AO0yUKW7Yt9PMraQKj4UAnFYHNfLc/NDYZyKvPM0AgqpUGtTC6pscRtx
        bn2X1QjNPN1iPjRxyEyrmlLDgA==
X-Google-Smtp-Source: AK7set9NjRWMOlC2eXp/43o2DAvOdU92TkqxbQHze5KccUrQJ7/Ck6guDEaybokQOD5ue/W6vTf3/Q==
X-Received: by 2002:a62:53c3:0:b0:5d7:637a:abcf with SMTP id h186-20020a6253c3000000b005d7637aabcfmr33159484pfb.32.1678853474423;
        Tue, 14 Mar 2023 21:11:14 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:3a77:bf68:24f0:1c75])
        by smtp.gmail.com with ESMTPSA id d13-20020aa7814d000000b0059261bd5bacsm2338685pfn.202.2023.03.14.21.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 21:11:14 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Pin-yen Lin <treapking@chromium.org>
Subject: [PATCH] Revert "arm64: dts: mediatek: mt8173-elm: Move display to ps8640 auxiliary bus"
Date:   Wed, 15 Mar 2023 12:11:07 +0800
Message-Id: <20230315041107.2886940-1-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c2d94f72140a28d0f516b7c5e8274a9c185a04ff.

The `lg_lp120up1_mode` defined in panel-edp.c is not working for some
panels used on elm/hana devices. Move the panel node out of the aux-bus
subnode so the driver only uses the modes retrieved from the EDID.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++-----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index d452cab28c67..d45a2aeb0eb1 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -90,6 +90,18 @@ switch-volume-up {
 		};
 	};
 
+	panel: panel {
+		compatible = "lg,lp120up1";
+		power-supply = <&panel_fixed_3v3>;
+		backlight = <&backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&ps8640_out>;
+			};
+		};
+	};
+
 	panel_fixed_3v3: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "PANEL_3V3";
@@ -282,20 +294,6 @@ ps8640_out: endpoint {
 				};
 			};
 		};
-
-		aux-bus {
-			panel: panel {
-				compatible = "lg,lp120up1";
-				power-supply = <&panel_fixed_3v3>;
-				backlight = <&backlight>;
-
-				port {
-					panel_in: endpoint {
-						remote-endpoint = <&ps8640_out>;
-					};
-				};
-			};
-		};
 	};
 };
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

