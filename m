Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620AE68DC87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjBGPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjBGPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:08:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F017CDD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:08:20 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u10so8197357wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdyZ473lVA8OnD87M9JEuHkPDAOV01LT74z6WsPQWzk=;
        b=kLB2UTtw3XnsMVL1Xa8yJdzg3oEv4Md8+s1kYYUq22KV983pPMVUgUdIWkdNmf/7cR
         2+HBvOcxwZ20gbLOttYvkECNrlWwbJPA8+sztM7/VJ//FMVbh9JOBXJApSx9+Z2OPKrF
         7AfKR+vtB+L5F5jiTSL42FN7GdtQrPY063qUZG8nymVVM9alaJksUYd38VlkCz0Hzb9m
         r61STAZBiEOrbL6R3JQ9XHJ67yxL1HbYOd4KyBdL7JAiIEluBE1bUylUKucrDDtE6QRU
         r9WXhCWgRybkaJ/nU9fCv37yOYKsBeq5xO18/d0Z4XIHhaTGCnQARkhvbcDmYQmS12kT
         8JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdyZ473lVA8OnD87M9JEuHkPDAOV01LT74z6WsPQWzk=;
        b=32neGaCDXFNIuGnxt9fDipk8T8upLAfs1kUqj17Lzgyd3peavPU5Pu/P1oIamDX822
         1noNq7ly/L3JZ49g7ExdR0lLqBlXe6Mvh6kjVsaa79TK5BGsDpeNEHwAVD/3BmQinQlL
         +VtBpkKtsmfwKpshzaLKanVzE6lvLFEqEfFfbxAHm7x45L7Ny/UgqDTDulIUt3H6IHLd
         5TP8z237OOQJ2pdDAo7jBTHKfFZdnpre9EP5Br1J4QjzZc3vsx9RRcMzg7My+bUfooTr
         dkmRlstAUYC7wGMM0kxgTKjBwS9A2Tr0+aWzTF1AMGZWNuU0eaX4KoZ9qhf4ecVxsj+7
         KB2g==
X-Gm-Message-State: AO0yUKXut2pI3ioc046cpQclpGmjfHxKwzdbCKBac48OXmeZuXO48xhU
        c5Qn32RrJ9IrxLKaXCFD+l2/0w==
X-Google-Smtp-Source: AK7set9UX4L+q9rkPE0pXHvyXjKRsVlJKGg8FkwHRftV7xqugC9lVDiF5q9EyMvYcfiDS1mqyvu+kw==
X-Received: by 2002:a05:600c:a287:b0:3df:ee64:4814 with SMTP id hu7-20020a05600ca28700b003dfee644814mr3462318wmb.20.1675782499714;
        Tue, 07 Feb 2023 07:08:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22092173wms.28.2023.02.07.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:08:19 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 07 Feb 2023 16:07:58 +0100
Subject: [PATCH 5/8] arm64: dts: amlogic: meson-g12b-odroid-go-ultra:
 rename keypad-gpio pinctrl node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-b4-amlogic-bindings-fixups-v2-v1-5-93b7e50286e7@linaro.org>
References: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
In-Reply-To: <20230207-b4-amlogic-bindings-fixups-v2-v1-0-93b7e50286e7@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Yuntian Zhang <yt@radxa.com>
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

Fixes the following bindings check error:
pinctrl@40: keypad-gpio: {...} is not of type 'array'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
index c8e5a0a42b89..29d642e746d4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
@@ -620,7 +620,7 @@ &frddr_a {
 };
 
 &periphs_pinctrl {
-	keypad_gpio_pins: keypad-gpio {
+	keypad_gpio_pins: keypad-gpio-state {
 		mux {
 			groups = "GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3",
 			         "GPIOX_4", "GPIOX_5", "GPIOX_6", "GPIOX_7",

-- 
2.34.1

