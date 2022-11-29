Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A173663C454
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiK2P5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236099AbiK2P5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA4E4AF02
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q7so21910857wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/qGjMKoEF7UDLliJtrbx4rWqxj8RHaEUJHMJYnhdEk=;
        b=TOsiGYJWlU06i615Mz744FgxUDKlfWugiNsD0nyP6JoNViXxEx7FInOrowZad02nja
         Dh1Y51nI4Qw1jbdXInFs03Mvzic7wnGOScDkDV1fA27qDRK8sNMkaai0kJMjFqlS/eB8
         Wp9AvEbyjpXMZX74PXz2LnOf0C5DmOH5c5WhyPSGNCMZuOPsfaCmhtRpSVD8g8uS4+AI
         0HjwkRa7cbw1tm0JtqKdhm4FJiqGndOSMzADHcWeUVSNqpXkJuQLuA2iFewtDiGutDAw
         ywcTs8E23DP2//hSgXnVoSDOFYMfqcgP632f+oYIFineYvq1z0KNzjAdsUmxMGEPwFHS
         hN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/qGjMKoEF7UDLliJtrbx4rWqxj8RHaEUJHMJYnhdEk=;
        b=moDiz/tplThSQxNHz7I35CTkJq0XilaBXlu47ajDb2NPY2g+nkPRUBXlCyM+Z7SPuu
         OYB1oKs6VI0Cnv07zdk1fBliXoeMjYEvLj8LhG60un8iVLNHZFvB00toN88eS3r1pnGu
         FPXNme3TQhuL66RUNWHhGvu+eK9dXztqnO6O1/syyrjgExNlpzm9BpsOWnainR/ufvNz
         zu/uRLMzX9iFe0HRODyzrDp2i5+EpH1hEWSz5pvTR+e9zKtCq/KfLKI2nJtghMaNcF/L
         gt/x+e/iPL6lnEtJI8FZItBk62f7p6qc0xprLAVc94Y4WZcsSjxbTCAzDrX0VOqFiQKa
         7rFg==
X-Gm-Message-State: ANoB5pl3QQj41paNH1KfMiPeWxK4aTIBZLjCkkB6XmiawjovRu+ndUnB
        owfSMcdajsjR9FOtwHSV4fHkcQ==
X-Google-Smtp-Source: AA0mqf4ECiXf+xdfJdG3vPJlwXjOVlpo58ypKEQwprRXnEZBSE2h4Nf8JytGPCENNIy+0CWe3mmdcA==
X-Received: by 2002:adf:a552:0:b0:242:1425:ddbd with SMTP id j18-20020adfa552000000b002421425ddbdmr7386279wrb.508.1669737430565;
        Tue, 29 Nov 2022 07:57:10 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f2-20020a7bc8c2000000b003cfb7c02542sm2601550wml.11.2022.11.29.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:57:10 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 29 Nov 2022 16:57:04 +0100
Subject: [PATCH v7 5/8] arm64: dts: mt6358: change node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v7-5-477e60126749@baylibre.com>
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=0w3mp8M+1h003hGCAyGu3KsDIgwbdfb6BOTNA6p/zCk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjhivPpE35gsPfyKhNRIC3z78IiW232tXy+OZbKIA2
 G56y7K+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4YrzwAKCRArRkmdfjHURTDmD/
 wMdcZOIkrsX6yCHGvtS81QT26C/yznAxYRkxNYzTDEM+du+IqJJtLf0oialBCX7syAleLnN22DFYZJ
 G6oBO8R5T52IJtZqIEcNOlb5PWCN7BKkLHo9Syqrp05N/63DM5K41sVQuZQyFRq567/x67KTuiF5sB
 RbQcuq3Ci7FZ/uPQFqRWXsDeJv6e10zTutW9VNj+BI8W62a3XX0BD0zA0jtLFQ79uVxvMqe7OgY/od
 gOJVNXwHDgdhU8u0brjiXi6f1A2cd9NjQRdDLHZ7KYeAulHM+fgGFLp7AR5k9XnrDb+LYKJlcXBp+0
 WCWaGH1LwGfABvAu0hVemEZJEsP1jpvzOHUdN1BMJar1pOkn4bwyV7mCf4WCvTs2MFRN89oBMkr613
 /GjAGEhviJ9H6ZdOTfZhYDJS4vZ6zCNyscKJzZq7EI4k+p71C7KGcvzVr6aKAh5FtqqaNboLQXWjZ7
 4sbe+NRK2IdZ8lnYb1P3yw2lEQ4bsxrNNsaltMYkox01+S8SMmrwDBDHw94lsMhTryUevGmuZvS6M3
 kT/DHM9EUGAlkN/CgkO5JPuD2osV8Uu46I3+oQuubap3r9uGjM4FlpC3hDAWiWDtS5YZjRGJs9LRuK
 KHJkB9un8+AsggdLz31HZTg6AfQ4ke819zx8h1bwG5ujBvHQdYLdO/flxnzw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the node name from "mt6358" to "pmic", "mt6358rtc" to "rtc" and
"mt6358keys" to "keys" to be consistent with the generic names recommendation.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 98f3b0e0c9f6..b605313bed99 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -5,7 +5,7 @@
 #include <dt-bindings/input/input.h>
 
 &pwrap {
-	pmic: mt6358 {
+	pmic: pmic {
 		compatible = "mediatek,mt6358";
 		interrupt-controller;
 		interrupt-parent = <&pio>;
@@ -355,11 +355,11 @@ mt6358_vsim2_reg: ldo_vsim2 {
 			};
 		};
 
-		mt6358rtc: mt6358rtc {
+		mt6358rtc: rtc {
 			compatible = "mediatek,mt6358-rtc";
 		};
 
-		mt6358keys: mt6358keys {
+		mt6358keys: keys {
 			compatible = "mediatek,mt6358-keys";
 			power {
 				linux,keycodes = <KEY_POWER>;

-- 
b4 0.10.1
