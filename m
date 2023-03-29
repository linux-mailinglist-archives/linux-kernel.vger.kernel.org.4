Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597F26CD573
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjC2Iz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjC2IzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:55:14 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E43AB4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j24so14883867wrd.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680080101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQkdLJH1pptyvVBYIMjpYp2X0cm5UeAwV0k97lbZ02w=;
        b=6Uuhw4SZ8KNxmIU4Rt6ZpiMUKZYxMhTqOoR37sn8PGHMs2isNDy4uGLZzF2o0uw8pX
         ulMW0V2DVv+YVbH/uadcHuLAIybTZ80u2nWIbGvQ82p9tRhhtJzNZefQCtSBkI09LFSv
         Fw5pYDVuhn6noZc0ATKT5gfy/xdQUIW6a7cvRqeLbNxet/Ae+TS8tqt1cP7F5ke2fQKV
         Qy+Dhtfkwt7wM2HDrIRZQgFWb2KIzAWu622SP6/9uqbOgDW6uRt4AoM6s/82RDnVBMfm
         JyjzX4gQaUvewZ3ot4mRo2TrXKdUHcAt81Pz3QUJJR/WcQNdw3RvmqpujxIxDN1ylX8c
         M5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQkdLJH1pptyvVBYIMjpYp2X0cm5UeAwV0k97lbZ02w=;
        b=V7UuTSM21mLJfsMLB2xNaXNyvYFdQ13dsFuip3DCeTjYCLtLlUT5eh7Lb60JPJFXsL
         fwve1/WjwyAXQt5IKqLA9EHJIkZf3W/dZ6DEaEyOKBca1WoZENC1vKWanvh9COP/58Aj
         Ew3b3ZyRf+38GWZdB23l1UZdZwQL95BOqFva7PX//AcV3Hi2V0vjQYPDtjYbBSTpg4zC
         rCaZjKWjhGUC6o3x50k24xO/MXILsp8KDM9X4CgRrZQaVlbUpK+YC5g6yB1ZNcDXnhci
         av0FgT3hSiH4DW3fLkVW9e1IplXon2RFNSdC9+muCRai+EoQC4ZKCA0kjKS/abPzRPsd
         6/3g==
X-Gm-Message-State: AAQBX9e0T0FXMXDlYULVM4bwvNeAzFIShZEZi0gM0twA/odSrA9WPSLw
        gM9xOpdV+YrPMEDh9q8OttSygw==
X-Google-Smtp-Source: AKy350b9G7J+QMoUbPNcQRlgqmiJdoa79V18SfeBWC1Bcrw810jNbJYGDf9D5khfb8hEy430C3xiOQ==
X-Received: by 2002:a05:6000:b:b0:2d8:2b0f:c3a3 with SMTP id h11-20020a056000000b00b002d82b0fc3a3mr13618009wrx.70.1680080101142;
        Wed, 29 Mar 2023 01:55:01 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f9-20020adff989000000b002cea392f000sm29571964wrr.69.2023.03.29.01.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 01:55:00 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 29 Mar 2023 10:54:28 +0200
Subject: [PATCH v3 07/17] arm64: dts: mediatek: add mt6357 PMIC support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v3-7-0003e80e0095@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=mvWYCtO8a3agAvj56gAEer+sR1kkD5/63RgRdiDwnr0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkI/zc5pYmoGfGivEZISvH9w1c8+Z+7eWhfM/jDpzW
 Ninyz5SJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCP83AAKCRArRkmdfjHURXZBD/
 0ZeMwkwsyHSmIA1GlE8JTHKFWbSo0pJ3pPUOCIo2CUyT/yItznGYDlyObZc49myC0vxLcl68loZzO7
 UyxRVrsGTguL5Bc0yzUPCnT8ffQKJfSPwETPqLV0eU2llN9f2QKtF7wDTBCAvpVL7zuanJIu5NIMHq
 ABjyLu152Sql/V65zGgIuutyMITg3mAWgtZMbfgh8TgDsKxwUicXqgMReAOgvoyzOvwEJqKGMhva7b
 Yb9VC+wEJnUBXD6ZLZ2qW4FD5/0UnZzyIJeYhA32jwpmIuK2egTPJsMPokhBd80H7jvI+Ipxurt9mS
 so81b2DU0fOvUHADDl40PBo4MhLGeoZYRcb41AbEg565THDP3tfrmvoLi/vWBE70cmjwuXMcLN3tUM
 bQsoMEtClp7e3WewMIIjQrU2aAmPQygHwegCTaBgl6I9NS8wOL4Ajz2yWqNU0+fGbgpVbyYD25Ixhv
 IBoaDsY9VEAWH0TLj+3XCXHQ29A2isO6Bg2lAzKhIFjZWVZ75MlJ+O0aCEYav+wNIza9GSD7LHun9i
 NRhtBBrxW+Pdcc6kHW+uQp2qS8D1fwu6C4TG2EaYBvpNCSXnXGteyPB2jJV7SsIYTtzgLCDaOmyHVj
 UqmMa0bwvQKZ8+FXXRdKuywJoDdTU+ivaZvQ61GFkLuletdlbBrq+rUXy6yg==
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

This power management system chip integration helps to manage regulators
and keys.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index fc7f6d8ae173..2f88562c638a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
 #include "mt8365.dtsi"
+#include "mt6357.dtsi"
 
 / {
 	model = "MediaTek MT8365 Open Platform EVK";
@@ -96,6 +97,13 @@ &i2c0 {
 	#size-cells = <0>;
 };
 
+&mt6357_pmic {
+	interrupt-parent = <&pio>;
+	interrupts = <145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

