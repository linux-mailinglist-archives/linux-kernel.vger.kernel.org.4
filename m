Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA0B621C52
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiKHSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiKHSoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:44:23 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7625E23BD8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:44:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id cl5so22411584wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJeLrYqcWtMc9mhPkVpaKIYTLHS4W3xdI9EsCwSsotY=;
        b=biv33dAVK0U5i5MEa6CkrodxDxu6a0R66D7XCMVyBy+AC2hO4Z/3FFV36HoASetlDy
         pxcnYqcwwNkpTo+UAzKkhQa3Nof7BbYTR9fT2A2KLzNxA03r3UCGauI8r/fPhj7CZKGP
         D3TZVM02YmTe9JiNbklo3UmcwzfYWmI32gMUbuiohUiL27fYamBwcFfBievvKJYUqqiN
         Zc2Bsq3qZCjmNZTwzdtm4dF1WfvICr2wE/iTY4VkUbmXI9fewuY3O7N+3X/i7eLcSNy8
         vXthvoPeyyVAYgFBzLTI6Dx9Y2UP7P7Nnkiw8zEw/mJelbjCS3EEIefDyL9KNkqaajX+
         YETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJeLrYqcWtMc9mhPkVpaKIYTLHS4W3xdI9EsCwSsotY=;
        b=Cc/HBaj87wHKoLoWd+YfB+juJZjUEwG//XjUoOe3gYVE/Vzni/R1hQfwlROgAf4Bbt
         /hLfXm+n65b+BF0Vx1Nc63f/RYAUM/Y+3iKqBARB8zxmqbIz4Gp27bWoUlC8jYc6blft
         3wl76kleHukfpXO75ZSJr/YN0rMib8SLnzsbO7st/QJHQJ/I4KqyV3ZjvlpelJPcrh2T
         zC32mMoPbc+5OaH1X4ZD8Ov/qmCTMtxY1kGvRxoQMSI0BUsFEQQs2wPy98NIoHizcD5M
         ox41L4IijcoPGSvnpBLmJl0dhHoG6LPlag/KMQ5SxtmeRcEa1ru4x66UeaGNCcSsM+/h
         /RtA==
X-Gm-Message-State: ACrzQf2njCanc9vMdjIm8+8C6IBY+aEFtsP1b7E0LWew5iIRp6ZSkwPq
        O8bygeiZ7C8xrwx8w/Ge5o285w==
X-Google-Smtp-Source: AMsMyM6IXfeEQpvmpO23cacYwl39le9IUzWdtAfJe6RH1eNBhFjuncvHaTiUSkUY8dJEkteYMwXRdw==
X-Received: by 2002:a5d:5711:0:b0:236:598d:83ed with SMTP id a17-20020a5d5711000000b00236598d83edmr38047119wrv.190.1667933058935;
        Tue, 08 Nov 2022 10:44:18 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id m6-20020a05600c3b0600b003cf6c2f9513sm13564009wms.2.2022.11.08.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:44:18 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 08 Nov 2022 19:43:41 +0100
Subject: [PATCH v4 6/9] arm64: dts: mt6358: change node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v4-6-5d2bb58e6087@baylibre.com>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
In-Reply-To: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
To:     Fabien Parent <fabien.parent@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-leds@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=c7wPKy75bT8ebg54aEIMfSMAkZtNftilP/SW804aUPE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjaqN6jeuBbx1egeCFBr+5jX9bet3A4Pwleqhx62Kq
 W/Ijc4GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2qjegAKCRArRkmdfjHURf3LEA
 CF1Xpb/hnOAfCPOPFX4/cEosoj8b+gWVDOXucqf5mES7uM7fB/63fjBR64lOwygfpfgtD8mQVJZajm
 4RmqRjRtQDXMLCV9vdTAc9WXJuMkgmy0VSFbCccqD1ATI4Fx1Wj48QHPoHL0HMjvUKe11ZQGMVi94g
 Au8t43WCgXn1kfSFPHZZF4vfevlovrT7DrAe8ySWJ8LRFc4KM3l6oB2+JFJzVQzip01X0mYaqIhSDN
 I+ZRUVKLKpriTI/IHkHySXgupWVds7RJnHYDKanWCDuS8zHGg/mNsqll3vnikVMl6+RfYtNabJOx4g
 FuTjd8+YdnDQwgLwGuPc+H6O34JCcjw1OA/DWu3u0j3mM9YUAaair3dPPISfqANCoAgAhSV0enbswd
 yvBSqmU/3PI2ybS9DAGQdKbkBPIq/qlbIqVNvtBnu3t32kvkYg8jVuYSgTLipUMTkmFzQ4bnNeA2pa
 vAs83nMOD1ppd5VVy3SKFkHAVZybS0TcjftKjFxNKlX5Hzp+PLZjOjRXmZQ6g6xHvmjJ7De3u90Kh6
 iHHokLSky59s3h6UGCyvospzR+BtUN4jOvbi/50qtCvv8L90FrBrc9EMxmU0bWmwxrA1RJ8dtaCHNn
 xU45lFbJdLN2m/z2bcgC0imzHEbkPA853MdanRw8fT2NPnLXopYqhb9XIsZg==
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

- Change the node name from "mt6358" to "pmic" to be consistent
with mediatek,pwrap.yaml documentation.

- Change the node name from "mt6358rtc" to "rtc" to be consistent
with mediatek,mt6397-rtc.yaml documentation.

- Change the node name from "mt6358keys" to "keys" to be consistent
with mediatek,pmic-keys.yaml documentation.

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
