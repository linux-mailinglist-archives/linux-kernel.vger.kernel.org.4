Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE796CD57A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjC2Izc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjC2IzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14713449A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r29so14816923wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqk2Qvzyu9t26WJXQRSFQuOT876R213e4teZaPnt7S8=;
        b=tmNiVZKfDBwqaBjMYSt5jShG37Ea9DVxMpWLfF7figFH4xvPOL7KVQy4Nusib8WljY
         uKoBreQmjqeLYrvBVliUdUPa7n2myiW9timavJDUYNbbeEwhjOKiN3rGPfjAmTCUOvYB
         oMmKw7scLBYaXG+Jc5hTuaWNrHA+Bb09uveaj0DHBTo/MAGenOE+Is6mMjZmfNfkUVBY
         PUGPCudIuV/RS1VOAxKSvBboIChnBLviJ8TuCEMpzqrZfFsqKc50RP/7pDk3s8XpOoit
         BEeRQmuyQKNgySmIl2zvtVMpw10f6V4JdUus+1UG/Uua2fYr7ZhPHkwXgORPaN+G0mKt
         yooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqk2Qvzyu9t26WJXQRSFQuOT876R213e4teZaPnt7S8=;
        b=r+rsrDcJqH7DpZTkDRxANxVD0TMlgv3oHJoJ44DxzjOybYteRc77Kr6TFnYS05PS22
         MVr7KxN9o1+0tM0JwWZAVXh7G6pwufiUcR4yzQOVhgmiFGmYS/lsKpwYNS9YY3gbNhfw
         6KYnu1J8dXJfbXf3p/yu/7sRMvy+UZEGrqZAS6aJKGQt6CIsxmdRCoC1W2ihJIMKL0LO
         VqHnVQeyxT8r310wSzPEPyUe3w0AqIImYaJPHowPge1mQxDrW/wHOJixs3cqO4wiwlFA
         aQYJBGmf+zttizLMtLk91jzMfLcgJ42G3PefgOCcSKKG/de76gC+jaIM9JGBG1RH4g53
         j00A==
X-Gm-Message-State: AAQBX9frY9MnpY4Vnv4HzE3eRW5nrYqghY93obU1iFsE20heddsnEzmD
        nRjiZtgAPoQTs9T6sP75SdQClw==
X-Google-Smtp-Source: AKy350a+VmyKNKmoU0vGdq+Qx0GzPI8sMXzMn4Y8hAv8s7tgu+syjGsstEfJI0RmmKig0w7ptX4beQ==
X-Received: by 2002:a05:6000:2:b0:2cf:e3e3:5b01 with SMTP id h2-20020a056000000200b002cfe3e35b01mr13030662wrx.56.1680080102276;
        Wed, 29 Mar 2023 01:55:02 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:01 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:29 +0200
Subject: [PATCH v3 08/17] arm64: dts: mediatek: add mmc support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-8-0003e80e0095@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XaojZ0A2so1KNSkGRKVMJnwpl8L8iAIQlaJ1i/uKU2A=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zcl9hVkica3ymhQrqplhn/No6jFL3Bfwn/C10D
 vCjfaZCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURT+JD/
 4stjlo5xiNAPRnFaULq1CvghyHl+PhTAL+MvO6h/KWCwyrrM3apbeTLiOjcqmu90sJZ340MGt7Qi+a
 qAqezwGxIEew22HA6O674c+AR133Mx2+FVa02/TA5wVGrd6YQAxGTb0qndfaVECb/UJGh0qdySw5cD
 a45FC7f2/obl/IurYXvCZ3iE1aHYT58NqkEck6N21GujK/RUCS+C6mEaRYoYM3JXlCzoyTPY/dQX7y
 8y579K7A5dP8njLJl0lx2nJp8bIQW7JCusknUP3Q9uOxjasebB6Ew1myjgpKSJCn6YVmNtNYVtvn8I
 9DFlgUBF+5Jwo3fY1ZwDIVhcbTySC20YAi9ORO0Bskvx7MC03Vw29nSFmYZy4U046M9aPx1h5dlC98
 MOt5SYET8YUfI9ogmizNm/b5m7qFsnMMPc/Aso1/6BN6PUuu7UJ1NMZ0gKPhumvcwFVa/+27+cdNxx
 FSv7ZGzq3NpN79EVS8GvmG78FmGQPf1TEiW3apfQIJMPWChmvzRUlt49LthMQC5LlRYH7rwYv3aZtZ
 mSHqKuKtKQQJ5XBjhURYtqaSNAOoVA5aCw3rZQSqcGvPD4S9SCfedEENK6b+upE8SYYG9uuYFGO8Ot
 RxEcMJzQQA5TL5Jlg2rhmhbHgej17wjflVmHDp6YHsIjlVfy9AjvTWzNo6mA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are three ports of MSDC (MMC and SD Controller), which are:
- MSDC0: EMMC5.1
- MSDC1: SD3.0/SDIO3.0
- MSDC2: SDIO3.0+

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 687011353f69..a67eeca28da5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -399,6 +399,45 @@ usb_host: usb@11200000 {
 			};
 		};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11cd0000 0 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MSDC50_0_SEL>,
+				 <&infracfg CLK_IFR_MSDC0_HCLK>,
+				 <&infracfg CLK_IFR_MSDC0_SRC>;
+			clock-names = "source", "hclk", "source_cg";
+			status = "disabled";
+		};
+
+		mmc1: mmc@11240000 {
+			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11240000 0 0x1000>,
+			      <0 0x11c90000 0 0x1000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MSDC30_1_SEL>,
+				 <&infracfg CLK_IFR_MSDC1_HCLK>,
+				 <&infracfg CLK_IFR_MSDC1_SRC>;
+			clock-names = "source", "hclk", "source_cg";
+			status = "disabled";
+		};
+
+		mmc2: mmc@11250000 {
+			compatible = "mediatek,mt8365-mmc", "mediatek,mt8183-mmc";
+			reg = <0 0x11250000 0 0x1000>,
+			      <0 0x11c60000 0 0x1000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&topckgen CLK_TOP_MSDC50_2_SEL>,
+				 <&infracfg CLK_IFR_MSDC2_HCLK>,
+				 <&infracfg CLK_IFR_MSDC2_SRC>,
+				 <&infracfg CLK_IFR_MSDC2_BK>,
+				 <&infracfg CLK_IFR_AP_MSDC0>;
+			clock-names = "source", "hclk", "source_cg",
+				      "bus_clk", "sys_cg";
+			status = "disabled";
+		};
+
 		u3phy: t-phy@11cc0000 {
 			compatible = "mediatek,mt8365-tphy", "mediatek,generic-tphy-v2";
 			#address-cells = <1>;

-- 
2.25.1

