Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E97D62BE26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKPMeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiKPMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A665E6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j15so29713367wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L20WZDfB4Ry2n4XJgPN1jHb78hlwsc6RiwrnFa7B3l8=;
        b=2sgjlHBxqdWwtFrhVJB8iW1yxKZ2cpU/ng8+DLzHv8kTH5P754dpAb3i+qLO59zY5f
         tAbYx0PuP86OqDYnTs72Ms53vR2exDNmjxomDaB1gm+YI8W2cH9nUil+4gtWVF2dIsSf
         kfGCzQmrbL0lMaIGwqi0MHWl5PvA3WRK1o6j1sAqDG3QEShsMYMvebNMKEzg15YrS427
         V53Z9em/ftamEDGvGQNrQ2jz0zQs0kuSa+JfZzLdfHY7lTULX0agNVup6zZeluIWF5T+
         bKzHWjUvuL35aGT/PJraaZr5q+NopvYkIF797b220EBOjAM5WNn4T1MJdmse0c6hrdoL
         q4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L20WZDfB4Ry2n4XJgPN1jHb78hlwsc6RiwrnFa7B3l8=;
        b=XYGoA2zmgLZldNMBpbbkHo65esn7Ea3HVCP8BJt2JyI5V0DygrmAehr8nib0xLqJFX
         qpyZY9XRBvpWDZcZuTEOmN6bgCx0AqJ05cejzWb9u9Y/NoRfctTigaEGZw2ZMvGmq3Xg
         XpLivAIfkAYA77ds2JMovBX86E4tmZ0N45qOKyyV1I4qwBdNSPdRG/HZYearkIXCBg0X
         JW5sbnTwIeQ+2sHrv10VTM4nDYA3nEVJVmxdm/9NAuktnFLmdMV2qIZaINoQsxHRtBbn
         dXCYDWDwJxOHy/QKm9Ek4dfBkdErXHM4gNVMWE3945Etb+xkL5Z0lPlEhZQdNRpCB4LO
         0Jbg==
X-Gm-Message-State: ANoB5pkT3fKM5GzSOFdvJCL+8t9ZNiaIHnDg2agd9eBv6CwgvnWuvGGn
        uBLQFbLgn3vaw9u9fH+qF45aaA==
X-Google-Smtp-Source: AA0mqf4khQTenypGm3STBNu3vcrYHdKH0RrgEXM0QSi8ly0xCjMQR/O3vU6YbPaA5xg5D2azqPyn0g==
X-Received: by 2002:adf:fcce:0:b0:236:6ab6:a51c with SMTP id f14-20020adffcce000000b002366ab6a51cmr14184436wrs.54.1668602025031;
        Wed, 16 Nov 2022 04:33:45 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:44 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:33:02 +0100
Subject: [PATCH v5 08/10] arm64: dts: mt8173: change node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-8-8210d955dd3d@baylibre.com>
References: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v5-0-8210d955dd3d@baylibre.com>
To:     Flora Fu <flora.fu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=GBaNKrSWOOj3IIbimro7kSOdhFcUdE4vLaUrLB+TgIA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNiegKLOAjGwCfqePOAUGXCPeQFCHu6Os+/wzG+t
 VrGU5r2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURdAID/
 47+yQajMgunjJTszn1jqdu1ck+aZ9AoF/9pqC/z6QZxgFuZ4f+Lus/UfxCPM179jOS691bjF3ThMRg
 okUP8GEWY138LjJk2dmziTA8OH+VMdXO8SSiLwjX4MBGIFuak6cH8wPpFZJb8IxsaMaeF5jHk07WOg
 MgXjeuhcsV8rALPPv9B83HRjh2bBbmokwxh+jsW0r4jEGuwMwlr3xjXEjpCaih888TVWpq42og79Y3
 IVKUQEzoKuI19+dvvDO1FBU47Asy5BNqj373EP2qbYCP32qpyHUL5EHmn9rGMfF0hYUP6LnLUbqIX0
 WfTtBJvfc9IFgRIM7/04l7Z0j5HeUE4WQLi8jxSRs4QrFE6JQ8GsdmtdRQ+R4WyiamiSvxqf4RALjF
 6kOXgfCmCIqn2Y2s23SRIFiX0vlqnEkYh6B9psS2wqyWZPwMQyQsIgUwrbVQemHT8iMBBUflJwl1We
 864KwSHLGPnlm0J1zRvNzETRmg52ri4tSfANr1rb9MtiGTQFh0zFAhHAAmm8ELziYZkZWOK5jHzeul
 Wqd0vAV4OlB26cuo545E5CUOL/Z9+rW8fd0h0mdUOH9piOoR+vcz8pEggiRJIfDG5hbO2qCl3/MPst
 wpONj0Xw9HlH3ko32pbBvWMn3AW2BOUpLH6SXkL31avYSrnNDxXVrwz2fNbw==
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
with mediatek,pwrap.yaml documentation.

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
