Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA2367955B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjAXKfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjAXKej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:39 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98E541B4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r9so13403514wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJzShneJHj4d3JT3cYeiVzniHQ2E8HFG5vVm0+RLFIk=;
        b=u/YCRj3z6AWBMk1F2CzVe+9Y8Vf/OpLiJTIOIl3dZO0Xr1kBEfcuTgQT2vqYrBaxnj
         PC7x4Ck+DnbsT4S8+94xTWDU2fml1QrMM5De4CIgnA8/iW00NYmJAMLKNZFr+R7U1QlL
         3v+hY0eRAqK0RJd7Yw775tRZg5HZrgzU+9tb9zpvrGMznLvYxmbetFNVBRt5eILtTaIt
         zAyOUTMnj/e4Bmh9UbTDVGsJ8pZDvdJeIvs7s0m/HzqGY4TwAlPkOnHQA5hv+qWlLiXn
         7KUmftvnvCX2rYgD0kPXYjBUn64lyduK5mRqdZ4N+NJ9F9hpWX+71oxY2U7XhVnVVXWk
         m0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJzShneJHj4d3JT3cYeiVzniHQ2E8HFG5vVm0+RLFIk=;
        b=C80M+ZY5XcNEmC8NBLsZ72X6g7pLPTyLPbnawHHI6NUjnLjg8p1ZsW442Bucp6Gkz4
         +h9wbOu65oQw8LXcXaxWhYfB1j/WrFvdrOqnrB9UtIqVPaPM7Az/Ac9y7ngC2LLrYQe1
         9muF/AAm8m6Xg+QLKfdWFlYoF7QB5DesyNcz/k379nVJjqahd2S6LyKk7owk624/8rak
         jgH6irokdgguuvOjWDYDQqq51TSuawLxV8LmWRGhnlMjVj6NlmzQWGjixExyfnoGVafG
         6N42IuTSCWm597wH8IO0kcGlO7pesbBUL+xExLdKmlGNg9BRTOMH6gNQUvqp8RRIvC3P
         egFw==
X-Gm-Message-State: AFqh2kpPF8LvXDlu9dVKGyWSZ8MvcSnYVyba1C3iYqWAVosWCpoOEMUf
        AXkVTIxlrzv83oRU/b3hXkDJwQ==
X-Google-Smtp-Source: AMrXdXtD+WCyaBwihNaXexTggR1I5lmQccmj0wuEIaZSvJRfJaNM/WI7ebqOHeI0sDgUHmzGTH/TIw==
X-Received: by 2002:a05:6000:16ce:b0:2bd:d9cc:920a with SMTP id h14-20020a05600016ce00b002bdd9cc920amr29464286wrf.45.1674556468121;
        Tue, 24 Jan 2023 02:34:28 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:27 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:25 +0100
Subject: [PATCH 04/14] arm64: dts: amlogic: meson-axg-jethome-jethub-j1xx:
 fix supply name of USB controller node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-4-44351528957e@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes:
usb@ffe09080: 'phy-supply' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
index 22fd43b5fd73..1916c007cba5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi
@@ -303,7 +303,7 @@ &uart_AO_B {
 
 &usb {
 	status = "okay";
-	phy-supply = <&usb_pwr>;
+	vbus-supply = <&usb_pwr>;
 };
 
 &spicc1 {

-- 
2.34.1

