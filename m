Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47F6E23B0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDNMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjDNMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:54:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EFF5FDE;
        Fri, 14 Apr 2023 05:54:34 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 50C4D6603224;
        Fri, 14 Apr 2023 13:54:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681476873;
        bh=79Xyn3JweqPQZ+zPYKJbf84qXzEBPD+1ifxyVQSTsFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7hYJfFwBiXHrm9ACTA0C437cyw527Jbo9CMfe4DcZeZGACYQwQLNLhXvBtN/Dpqv
         e+Ps9NVa3S0DIdT5ZtXA0FnbvuCRsE/M/MPQIa1ZnM6z++ZeNpamvslVB+hHQvl1hu
         zU9J2F/FCm9Dju5FYvZw2ZOqxlCETweZg00LpSXxqvGKn0enQ2oJsAVqJ2Yn94M9a4
         bEdUCXgXhIREYpf2PZb+JSlZipeu7Aw17LhJYrDPQiAUpzggHf4x+gHsG5dsHpgJCZ
         oITKOIJO9AZMarvxHX0p3rdlns0tcxDxEpebHHbXFF9M+gNRPB0iwFsft0uf+UxQZj
         Ab0Ofjp8Qrjnw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Drop RTC clock-frequency on rk3588-rock-5b
Date:   Fri, 14 Apr 2023 15:54:23 +0300
Message-Id: <20230414125425.124994-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414125425.124994-1-cristian.ciocaltea@collabora.com>
References: <20230414125425.124994-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hym8563 RTC driver doesn't handle the 'clock-frequency' property,
which is also indicated by the following dtbs_check warning:

  rk3588-rock-5b.dtb: rtc@51: Unevaluated properties are not allowed ('clock-frequency' was unexpected)
  From schema: Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml

Drop the unsupported property.

Fixes: 1e9c2404d887 ("arm64: dts: rockchip: Enable RTC support for Rock 5B")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 88b9f7ddf291..62750beb12aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -60,7 +60,6 @@ hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-		clock-frequency = <32768>;
 		clock-output-names = "hym8563";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hym8563_int>;
-- 
2.40.0

