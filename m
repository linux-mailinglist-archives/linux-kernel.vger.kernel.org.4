Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97962BE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiKPMeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbiKPMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:33:45 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551D42728
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:44 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l14so29691858wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJeLrYqcWtMc9mhPkVpaKIYTLHS4W3xdI9EsCwSsotY=;
        b=RE+scfJigrRMGaRyqu0nvEmq1ouw7HTydTee5XM1yNQHzz2DPFWGaPOLWChQ7hD/bw
         hs+CcD1wXGvVCf4y7B03pA9900k1R3YoSr8OO+M2pZglCBGrZza25ycrkmSaIGg5O/sG
         QMdl2tSrpofSupK8ENFv4BEeL8HzVzdUTjNs5+/N5ESObwI7N/RfvY0EIFyhmzcX2SRy
         juPjNn0YB9OvQsritJSAoiMojl5PQCzLCipb7lueI0SacRGPR53XB9bdiBmZLhTNGGFp
         vJPmEFyFPCB4ylVD9blqvfliP06L1nldV0B4W/8ogT0o6eb2zgnPxQuaX1YfjMDg1MkO
         A+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJeLrYqcWtMc9mhPkVpaKIYTLHS4W3xdI9EsCwSsotY=;
        b=Crm+NjOiR9mdnv9TBnzYmcaQ/Z0BpCkXzRm9501RblVztGFGCE0FlAvN9Ibid5Ufwv
         1ENCg17j8/Zf/Ir/MIWnrlzNOhcsv6CNPHW20UGF2GjYnCNTMDzOrMA3ZHYCZSRoU8BA
         J9U9t46TaFS22Av7LIJQe1xlHbOoUGzukxSSK7rRYbcjyYXPP3Xjiv+u6pWxLPpybsLr
         Ku8MomX5EFxz+LlgjrVrxL/4fIqHAoFqI3fDICb5f0QZ8kXLLIAFkXhBjF6t8WJHTRxY
         3HCdppRtf5N0yXwappD6xJ6xniqrH+YpwXUQN4n8lpX8ABwswNlLonJIrXV9AUWLoC3n
         1a3A==
X-Gm-Message-State: ANoB5pny1iDCfl06ev4NkejhHdwFxzDWyQc/7FH3/y1/JYBvY+qD+09/
        Q8UuLiUbqPOX6o0zVtRw9Hj3mQ==
X-Google-Smtp-Source: AA0mqf6HkkidY2au285VnM9daJO71u6fvJ/Ee92zMFYf2K2lAlbcB4yuAhtUtofCKcLOVlB4jTULzw==
X-Received: by 2002:adf:f244:0:b0:236:6fcb:a0b0 with SMTP id b4-20020adff244000000b002366fcba0b0mr13558904wrp.555.1668602023853;
        Wed, 16 Nov 2022 04:33:43 -0800 (PST)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z13-20020adff1cd000000b0024166413a4fsm15051607wro.37.2022.11.16.04.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:33:43 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 16 Nov 2022 13:33:01 +0100
Subject: [PATCH v5 07/10] arm64: dts: mt6358: change node names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mt6357-support-v5-7-8210d955dd3d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=c7wPKy75bT8ebg54aEIMfSMAkZtNftilP/SW804aUPE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjdNiejIJtPhWDcTqkPa+DfNFlbKX7l7D8TkEpyMUG
 ztTqHjqJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY3TYngAKCRArRkmdfjHURcRyD/
 93F7fWMEdJHVtnI9fw/5HzQJKi6Nie03CM3jv3sTRmtBH6Ea3N4jGFw1znI5sNkLA1o8991rCWjgn2
 feUCtH8fz45tV+QWRpQQRUpz1qLsyu33zsYbd87ZILmN9U4iSaqhfYwq7f2G7HDpvlvyzYlaA6EW61
 yRyzPT1/ujM0XdKOuRbC4GtNLa6rBNuTE+aHdj+qVZLUf0vF8SMx3IKvyDOTxKxW3mu/5+S6YvZlWH
 cgGitiNc+OkIIP5EPBvNjFHupaSRdY1PObh/KRloKjUBks9CLmjO8I9QDmGE8TcUSnWo0/yGTy65Nv
 TnnzanzPfgb2RZ2hIC2cnuajyD+WX3dBI4AF28EgmlYj4f0BaWaoXySTDUKEXkBe3DP90/I6iue6A3
 m3gsO1h9wcs0wONAzTqGH42FHuoUUYlSwjzrMf20PzLHxia/qNWlWi+zJKjNM5PjZJpJ5eiDpnZzNn
 iu0+t5DlWavoYJWUAUNT77uQo0/HTIVJ8JTHTZNQpMLs08A+lXEPy/uoo2zl4nVTRdhEg8ANx5lsLw
 riNrVFh9Ela760/vFiT82nAdfKA5hfwLST7PpjVliBrioNb3g0TrK7P6ZplT1wQRBA6abt97wybCt8
 37UhsEWRGHba9hq3JF0fDrsrueGQUAihKf66SsTYBd1WO7DDA2eTHr6mKwRA==
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
