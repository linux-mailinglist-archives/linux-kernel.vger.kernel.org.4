Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F267955E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjAXKfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjAXKek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:34:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2F41B43
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:32 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so13396187wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifzjlY99+yJztqe7FARfMu6jlp+GfQJvBGzzQqxPZBs=;
        b=kxWYxI2FutjBslqyG+lI10Qg4rhf4tUQt3JHpMJJWwfz4koO2rIOm+ynasq88387Z4
         kUwqSz7A5mHvVNXV++U/VXQAKv0joDyCW0ceLE8FySgkUUSTz36B6G8xnAMnt3MDaPUD
         2PvZZPzHf4JL+Nmvl6KZWFedklhlUPBA/zJ22FC25vTDf3Wn4pY5IA34VgKsgjAhydUc
         G8rFsd2dSJCt16FLpk33voTzZnnacB90ugckjbQ1NSqmJO9CQt9yvmeOl16t6jR0EjwR
         6Hlj8drZR/p+2ThYCrNM4OZYFqvCidrUyA0Wb+nKRWBesvN0gq86pgJDkUwOuj/yHmXc
         MvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifzjlY99+yJztqe7FARfMu6jlp+GfQJvBGzzQqxPZBs=;
        b=tDX5mLpflbRmgDPDoLkSQgula18xQ4CrUjA3NTaMWhS3gQqEqjt1kEa3+XF5nYN4tt
         uyF3TYYj1hyQcXuue/P4kRYhHLaaWO5q463iF1fjX0slhrqe/ieRk91tJ69MWMEDA0RJ
         2eIgLHfn0foXcMwt/+TsdhKj+tQN0yvjRU9W98b9cFcNDxicOxWBjD4FqXd3iUsB19Cg
         hC/J1MULOye0tV+j5LksuTLH6mMEBUQaDatZk3dRmPTaO3Uui6Ft0niUORyLB4cxD8kg
         ZVOYG/EQHsEU4iAb1nn3CDVaBu64c5QLuYLgzHRsq1H39Nd7hQXnTnTfwERD2fk+L7Mb
         /L5Q==
X-Gm-Message-State: AFqh2koWEXcQLyUCqbuX/fdZFAMjzK0ndfJI8/pQsKwZu1QW2aZTFiKf
        Vr7WERh4ATGzkLTRbpzIpEhd/g==
X-Google-Smtp-Source: AMrXdXvnRcBiwv9p96+TSCf4nh3ZFbnS+Q3RT5HiQV9H2MVRSLIYvXTjdAhVfme5LdIwlx1KSHL33A==
X-Received: by 2002:a05:6000:1816:b0:2bd:fe5a:b579 with SMTP id m22-20020a056000181600b002bdfe5ab579mr22265168wrh.70.1674556470825;
        Tue, 24 Jan 2023 02:34:30 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020adfcd86000000b002bded7da2b8sm1551889wrj.102.2023.01.24.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 02:34:30 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 11:34:28 +0100
Subject: [PATCH 07/14] arm64: dts: amlogic:
 meson-gxl-s905w-jethome-jethub-j80: fix invalid rtc node name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-b4-amlogic-bindings-fixups-v1-7-44351528957e@linaro.org>
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
pcf8563@51: $nodename:0: 'pcf8563@51' does not match '^rtc(@.*|-[0-9a-f])*$'

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
index bb7412070cb2..a18d6d241a5a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts
@@ -239,7 +239,7 @@ &i2c_B {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c_b_pins>;
 
-	pcf8563: pcf8563@51 {
+	pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 		status = "okay";

-- 
2.34.1

