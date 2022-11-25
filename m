Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F256638D48
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiKYPMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiKYPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:11:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADF42997
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x17so7188220wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 07:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wK0CnlZOX9M/iM8SewTczZ0sLEDRfVMf5U5O9npWUVY=;
        b=AjMhDKUSXlx31DgwVj59ktOHNOh5SInBB3Ica2qU2iTSFLl0FwgV5TPGAfJdydc+KJ
         n95nGRnjpEYMuNDi51sGoLqUpiUkP5MK2WGX6s/JbwPTziQPppNxTM9sFxdB/hWC3WXB
         oth989ifui1J3CNEn8NUdXx2nNr1MOLgaF9nWIW0QXBvQxjqDtphj2q4g7GwmxrlvLC8
         bewP7mKt06c0/hh+nio3CDoQzJHYRkRm/WyMY5ZdE4saUGPsVPGgr7w7SXI4pGQRTBII
         O0kM4fldfkHrqeRTbInIEFAS01RUwVUzzmWGYO7/eqpKytOJMn4tQZL1EwIvLpfXivaI
         yF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK0CnlZOX9M/iM8SewTczZ0sLEDRfVMf5U5O9npWUVY=;
        b=JS1YnPvUVcbh+wfXxLbE1Fd4smJ7Kh2waNVvRyLoVxV7e7hmuyMEnEfjXJWhX+nMDa
         /61BAX7P73s2NeczeTvSMyvujS6wOpGETPwgTlpxUxc5rZ+mpsAWFT1FRYrKdLHVKB1Y
         IJoAKsPGvu8JDGDZCm5dAwErl/kzVpbljpr16VrEcXdT4QcbarjzSmCr1N8qm/xTe8nk
         G+3OXNa0tOKXP9PnNd0fY5ARvVR8IunYUNYZcEsvw6KY1CNwAoCP58R3XOzJSO7TEbWE
         upG4wrhSYD3GNcaV3NaO8E4Kg1sXItdK6mBZuuipUvus8vNsOF0qiX4x9VcI8GnF8ofd
         8DUg==
X-Gm-Message-State: ANoB5pmixJ7ge8EYEB4kkZe7gdhxoL4WEQ+8kAcSs2hSI/WDSnLWDCdQ
        oQxPqk0QJyU+lGAR/SBr57mc0g==
X-Google-Smtp-Source: AA0mqf4T1yb35EpIiyEZ2qo9ePUN9VXa08cg2ZMi6OWKY9wZcGVA3BSKqkuf73pxaZ1l/ntdNVH30Q==
X-Received: by 2002:a5d:6183:0:b0:241:d386:f6d4 with SMTP id j3-20020a5d6183000000b00241d386f6d4mr13377172wru.707.1669389089975;
        Fri, 25 Nov 2022 07:11:29 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id w10-20020a05600c474a00b003b435c41103sm11565885wmo.0.2022.11.25.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:11:29 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 25 Nov 2022 16:10:19 +0100
Subject: [PATCH v6 08/10] arm64: dts: mt8173: change node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v6-8-4f589756befa@baylibre.com>
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=sciAdvxNeIHiHj/noxHzFC381BQRCLfnWiRAfVX/Ztg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjgNsXQ7iac4y/5bvYvfe1/XziFY5k1T+DtRd9Rmg3
 xQh0OBSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY4DbFwAKCRArRkmdfjHURWflD/
 4nuSKT8b5l8xDKS+q7gXOeVYhoAwNCl/KmRiV4oy4YMsbQpfEAMAYjBGM47Pwn6UdymVpk7+HeDXqx
 qRP2Aq2917yfRFh5xLKCEzpwIxTzQYu2xuCgBy1QCJ9dEAoK4FlzZNC4pkd4VVt2Eme2EXMkjhECQG
 u/QiQOridfxML1KnAkkl2gmaPKXc6g1nupW5ki8kNUy51+h98SExHp/K3ep29xfj/XALTbSuO9AI+e
 oW4Fx/T+Frbj/YS9tLQ8kh43rvv0hrkq7D9X0j50QsQb6cYHLuxTTIigkNCXnKJ406XHi9z6laXRZ2
 r292CcCk2xCCHqUlHusYpP8lV/LOj17WT1m+E4eBbWUQIe8aw/c+Yrtk16Jf76Eq3y5D5pKpQ1loJ5
 0wd/sEMOJ/hAmxN2ao/LvR/qOWqyaw4mifXIvebOlTys1NYhj0IZS8Aoi6I2Bg2nGBCJvqYUYrKrVZ
 ZKTwod6OyfzPOlazL5rXpJACTsIpMIu4Yaq0lbD8fBR6sfwE8DAwy6tiNY+8sSv3k/wHjy2rnWohp0
 EE8bkTdxUNg0XmaddcRbv0jJzm7S9abQyz1D0T2IkkLREXgkw5H2cbf0zIuCKZ872BAySimW7KxQ8G
 PZ1gATf0/CAjzm2pA6SSG7WzbmR/NgOLj4S3YD8Dp2TihgbAfrPanSLGskhQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Change the node name from "mt6397" to "pmic" to be consistent
with the generic names recommendation.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 2 +-
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..a8f5c48e1782 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -913,7 +913,7 @@ &pwm0 {
 };
 
 &pwrap {
-	pmic: mt6397 {
+	pmic: pmic {
 		compatible = "mediatek,mt6397";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
index 0b5f154007be..755df5694234 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -300,7 +300,7 @@ &pwrap {
 	/* Only MT8173 E1 needs USB power domain */
 	power-domains = <&spm MT8173_POWER_DOMAIN_USB>;
 
-	pmic: mt6397 {
+	pmic: pmic {
 		compatible = "mediatek,mt6397";
 		interrupt-parent = <&pio>;
 		interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;

-- 
b4 0.10.1
