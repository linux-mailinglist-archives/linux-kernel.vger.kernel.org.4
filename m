Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8726FF74E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjEKQaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbjEKQaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:30:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F775FDC
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96598a7c5e0so1421148366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1683822603; x=1686414603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3sm0sOG8kJdGXppUS7SqrEsY1zLRiuVvK2VuTgB8S8=;
        b=a0HRhJc447kPe4mamxtl0XDD5nMuRRJX+UQT2K2d+mhnat2X9/391H8+5JPRWwi1bs
         BRywDGNMmRgLazLuO6nCKu2/BG8QIFD61EOUECL4xo2a3JG9ENPwnlwEo+nWKypITgGq
         8Scr6kgnZqIx1/jffKO0C3PJ4ND1aVLUHMYzA98CPUuGpbYCA06x5A+WqY0TbyuBtEkh
         KAmjvyXeBKszncRnSWJFNT14SOWXkhuBJ4ab1r/jNTXmdZfdoVZTsXfwJLQz6DGqyMIF
         p5Hd+qD8AjLuDQHbQfhvr76i71Bm39V79+RdSQomiw0Qmd3OYydQfPPwd6eelk8zzR3M
         L3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822603; x=1686414603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3sm0sOG8kJdGXppUS7SqrEsY1zLRiuVvK2VuTgB8S8=;
        b=JEhYBotQyZiok4NF4uqNN68kHxLQSdRR7DgREEj7yP0wVoYVW9PB4QWYX8m7Nv4zBj
         +iUeOiiBM/WJRFK4hNE6CZvybqRPLWSXiq0bgsU7c2xafodWwg+ARnDtLD7Z7uFnBbYT
         AEYUmZoZ71a8L2s303vVjDI79den8nKW2urCsICpVxU7i2WktmyAf9aO4LJ6Wx+gTnBo
         xS2jAIdsPWOF0JJ3duRAU/VPSYlTzCEm4HjydSDNiZophWAml6St5MKrA+4rytFLwpQe
         G1woDcFUsayNX/bDVZWI5srVI/+1GrmAQLredR22tW2WRTWdXELXe38aUc+gONaZ7UZ8
         FKFQ==
X-Gm-Message-State: AC+VfDxMO3Goj67EcmaeUtyrSiPockmOYQ5cawdD9xfdg1IF+lpD2Wha
        I9bcQoLD8WGvvG15CCbq0ii66rlHMp1ZipOJYL4=
X-Google-Smtp-Source: ACHHUZ7dcjAqGp+Nphgec+LpwJsKU50aAP2CHGPq6Yfh5foCKjVbFWh/ZrIWc8QPj7Qy877cL2Asxw==
X-Received: by 2002:a17:907:3ea8:b0:94a:6f0d:38a4 with SMTP id hs40-20020a1709073ea800b0094a6f0d38a4mr20763978ejc.7.1683822602997;
        Thu, 11 May 2023 09:30:02 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v9-20020a170906338900b0094ee99eeb01sm4209935eja.150.2023.05.11.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:30:02 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Thu, 11 May 2023 18:29:24 +0200
Subject: [PATCH v7 04/11] arm64: dts: mediatek: add mt6357 PMIC support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v7-4-98cbdfac656e@baylibre.com>
References: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v7-0-98cbdfac656e@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=QwAiDhJXueyKUnGYKSko4cktLia5bmqONipL6za+jZs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkXRgEaGB957lUUUCMm7XYXzcG3/aVnUd1Kk0tS/Jk
 n2XNLt2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZF0YBAAKCRArRkmdfjHURfwPD/
 4tT9AZke84r9nHkctafa3Fs1Xn7zsrt+2IlnnC4FlYC8bDF0k3tzXr+U9ZIDyTBS26N6aGtB/sM+78
 V+Je8In9nU6331apw4IyZVZtCnibSTtw288DtcpgIZHFZbqQOzJjbX9qEqfEINyU0yRyXBGbi1imU5
 rAmXDt+wdV1ScSXG0NOl7DxqTSzkTcgbIxOYfuJfkWaHyq6AtvJfHdjgMzwcpjhYkRz9E3mWky4yTp
 RxkIQhHNrlzqPhlMs66KPx500H6zv+iU2pkd7zAbdCPlRaTCiLKx8a4opxFuPSb5ZBLo5B4wYBvmTN
 hA7mSzWTuv6lgMNklOnKqVMGdWokjxh6SDyg9MV7aUi/nlkVVS72q6gCF448TEuWHVy0+qLEHYzzxN
 SouambJpEcnlV5vldVHr6ufNjDwDQ94PlZEb1GidhIEW4yhB67okMZXrRG1ZONpO5+Xaf1HowCuVwV
 6V9ZSiw//Ns3m9LYy3dAY127mT2ZwUpvt+BQ0LnF6s8aBRfDDLHJVvGmhSVROsmxfxRpDHtF6gVSPG
 s4iD6nVMB918dzcn/JV/0HeVlU9Kh7oPUT3w8BmKjavIn6kHcDWlntmwXPsoYhjRKPqBJgyOjiVD7O
 06oomNEtw7CX3dFz8wz/tT/MphLIt5rHsnEjW9GtTncowtS+UmpTrpUsRYYQ==
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

This power management system chip integration helps to manage regulators
and keys.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index ceb48eb1a6e6..6074aa9c1c3e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
 #include "mt8365.dtsi"
+#include "mt6357.dtsi"
 
 / {
 	model = "MediaTek MT8365 Open Platform EVK";
@@ -94,6 +95,12 @@ &i2c0 {
 	status = "okay";
 };
 
+&mt6357_pmic {
+	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

