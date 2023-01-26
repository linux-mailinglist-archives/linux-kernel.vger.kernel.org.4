Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AC567D569
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjAZThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAZThv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:37:51 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56636BBFD;
        Thu, 26 Jan 2023 11:37:41 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 905EC161F6C;
        Thu, 26 Jan 2023 20:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1674761858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3ccBGHlkR7MMpjrKhllmWGIlkOOuku6DhNh/iMepjLE=;
        b=cJPGgG++Ab2U/1JZqYXw0bmHl52qFK0eApA8lh9ZUgKgdZhGn6mFZRgIBnulZ3GwtNEtbf
        9FbHkNoaahgsURd6bHAM3pVFjm8h6k1A77c6iahJAjI9UA+WOSGKBWCALO4lJ5Blnddxbj
        S4KNuFYRjrGtFQ5msk1sOjb0oaeVjPQ=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson-gxm-khadas-vim2: use gpio-fan matrix instead of an array
Date:   Thu, 26 Jan 2023 20:37:32 +0100
Message-Id: <20230126193732.69699-1-david@ixit.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes.

Adjust to comply with dt-schema requirements
and make it possible to validate values.

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2: added Acked-by, and stripped from other DTS changes as requested.
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index b21172ece1fa..74897a154891 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -52,10 +52,11 @@ gpio_fan: gpio-fan {
 		gpios = <&gpio GPIODV_14 GPIO_ACTIVE_HIGH
 			 &gpio GPIODV_15 GPIO_ACTIVE_HIGH>;
 		/* Dummy RPM values since fan is optional */
-		gpio-fan,speed-map = <0 0
-				      1 1
-				      2 2
-				      3 3>;
+		gpio-fan,speed-map =
+				<0 0>,
+				<1 1>,
+				<2 2>,
+				<3 3>;
 		#cooling-cells = <2>;
 	};
 
-- 
2.39.0

