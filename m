Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2067955F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjAXKfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjAXKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E263F2AD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so13380094wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7aLtEs7xZLqbX/M3vqTpmpdXk5O/XmaNeEJy7udSj0=;
        b=iq3kiw3iUTYhik+54oPvKkwnT27ZQKiWduWQxEpVXfYIqkn5y+k9gLDEcIB2O38nV4
         kW8V0GWP5hSYgYTS6l0G8hx4YgIHV6R0ZpP9gUb2TYX+4qo+r4osdLlgWMFXOuTrsrVk
         zi3+8ydj5NJXHUIuk38VM5FfkFrU7BJFwqMffziH1mxd/HbwakdtlXUrG/7WVYhFA2Ez
         dnslDWy+JxtwOgICvVtG9FEZea2yQyvrmXfX4K/sHaIFp4TRf1tPNlQ+jPkvSJn3Eeej
         8TaY4grVevVvOs/PEKw2iAq2fqVeeWC5cNn19y8I6PNSgzyYRp59G45nABionvCwZxTP
         AdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7aLtEs7xZLqbX/M3vqTpmpdXk5O/XmaNeEJy7udSj0=;
        b=CHTTw3BkXdFW/KJa9IBKfkccewv2sfdGpXKG7RXq14U+L9R48OqhKr8vdAiU6yTPT/
         ocGEmS5RpAD1V6t0AjFpIN0C4UoKyRG4dNK5otp1O/44or8RAkS9QpQSCo8lF/xyn2xt
         dZ7rp9heq/q8XtEGibDevZGyLov8JXDMyPIxB7qSbpt3ghwKpUMUXOF6DwYlWcyHYmzL
         72zDDFcJnfhjDP37/vNrBYx0MBdM0QpSFZDrzjylY3XPHZVNe/3CDkrTZvDwVJj1sbNs
         6Yn50lTn9ZITlKRPqqxJonCGlku8g0OUknd6VNI8K4JsoTr4z+Gi7jj3sX1+ZXKUcvHn
         HLwg==
X-Gm-Message-State: AO0yUKXSH+F2GzIWY5aixmMqKNADhx8o7LsisMJIIjkS9HFTd6PB+NBb
        wU9ikccoWT3EQ1UR0N3sEMlomQ==
X-Google-Smtp-Source: AK7set/Ria4Bu0yxIrT6TvAgn8xrHUeT8sLczswCH+ri6tLmAbtY5lhH7pBQnO7C4PCoTxwiWfm9yw==
X-Received: by 2002:a5d:6d03:0:b0:2bf:b3ee:4a19 with SMTP id e3-20020a5d6d03000000b002bfb3ee4a19mr400789wrq.9.1674556472485;
        Tue, 24 Jan 2023 02:34:32 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:32 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:30 +0100
Subject: [PATCH 09/14] arm64: dts: amlogic: meson-gxl: add missing unit
 address to eth-phy-mux node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-9-44351528957e@linaro.org>
References: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
In-Reply-To: <20230124-b4-amlogic-bindings-fixups-v1-0-44351528957e@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
bus@c8834000: eth-phy-mux: {...} should not be valid under {'type': 'object'}

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 04e9d0f1bde0..5905a6df09b0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -773,7 +773,7 @@ mux {
 		};
 	};
 
-	eth-phy-mux {
+	eth-phy-mux@55c {
 		compatible = "mdio-mux-mmioreg", "mdio-mux";
 		#address-cells = <1>;
 		#size-cells = <0>;

-- 
2.34.1

