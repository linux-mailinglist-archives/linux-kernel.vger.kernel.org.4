Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E286796CA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjAXLjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjAXLjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:39:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30727166F4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:39:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d2so13568605wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pO0gnmqvMi8936RpUesIY7OLCwa7UX2sbv4nhIVFZOo=;
        b=qrraxzm55ZKdMTAZAllssEM+P/T7uUUYIArvwS0NOTYcEbnttpPOODv55uihgxbUpl
         vfe57htQgJFyoaldmcIqg7GYdvDhb2IDwH9rraMn2iy9wP8rPlUiVmIz4TEENGmHndIQ
         RE0G6xQcpSShL4ncExiHb9xKzaMSNgm+QxqV8Si8xauzbtQVgBIzUiI4HZmBl2xp5VRL
         UG0QUuAtnkDG/YCHMbp1lkKya28onrwDEqDrnDJmN+Rve2R4Sk2vk5qz9VGZ3C9UcHcv
         0qmxFdYYBULW1NcuKBeTxFmZPKuU76FEcRFlZKDzYj6xEv50CGm/EjpFSDRX5hQATVmQ
         WK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pO0gnmqvMi8936RpUesIY7OLCwa7UX2sbv4nhIVFZOo=;
        b=VbwL4KFrBoGWeyss7ljM/aAfc+L/opaLFT1rhrFQuaa3A8TrhgaxrDcWh2WAY5d06A
         9ZRvVC8hXmBw0vCtgk3XPC6KVjEZaWdL/H5T5+j3vXslZ7L1QX5jCh1SzaPY+LIHCmjb
         fdU2ZkupsM+In5geqfto8FOKWGc+Oool3JP6ppF7YTRTg8y/18F1rOx8xuxmch3Yvi8m
         x6ixDdBpm3ourzQPGySr6OaFNUmBrmrXLM8fCMPEV89rPyIfFmG0QFLA8Q+MW7kDJqfd
         bNVE7Bt85E9YWXYhQjPZgSv90QVqEyuMfXQElm+z1iogTUgwbkChT4x99fnxMoDoOG0T
         1Q4Q==
X-Gm-Message-State: AO0yUKWW6FBXlNSurF6/ck2RTsDz6JHxTHpfh8DVxMYR9ZC0SlejU809
        3NDWEVr7FR3eRoKHEbmYrLt7JA==
X-Google-Smtp-Source: AK7set8MJPdBctzje+F7wc+VYwjJ28N0Us/KhM9TGGZSY0l7Zl1LQJhfGgUFqg/uPmMzuFP/eaWrwg==
X-Received: by 2002:adf:f345:0:b0:2bf:aee3:394b with SMTP id e5-20020adff345000000b002bfaee3394bmr1935520wrp.50.1674560349695;
        Tue, 24 Jan 2023 03:39:09 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b002bddac15b3dsm1006482wrf.33.2023.01.24.03.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 03:39:09 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 24 Jan 2023 12:39:08 +0100
Subject: [PATCH] arm64: dts: amlogic: meson-sm1-odroid-hc4: fix active fan
 thermal trip
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230124-topic-odroid-hc4-upstream-fix-fan-trip-v1-1-b0c6aa355d93@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFvDz2MC/x2NQQrDIBBFrxJcd0BNuulVShc6TupAqjKaUAi5e
 4cu34P//mk6CVM3j+k0Qgd3rkXB3SaDOZQ3ASdl462frfMLjNoYoSapnCDjAnvrQyh8YOUvrKH
 AEG5gnb1HdIhz9EZjMXSCKKFg1lzZt01lE9LR//35uq4fJRsyfo0AAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ricardo Pardini <ricardo@pardini.net>,
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

Add an active trip tied to the on-board fan cooling device, which is better
than describing it along the passive cooling maps.

Fixes: 33b14f663df8 ("arm64: dts: meson: add initial device-tree for ODROID-HC4")
Reported-by: Ricardo Pardini <ricardo@pardini.net>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
index a1f0c38ccadd..74088e7280fe 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts
@@ -76,9 +76,17 @@ sound {
 };
 
 &cpu_thermal {
+	trips {
+		cpu_active: cpu-active {
+			temperature = <60000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
 	cooling-maps {
 		map {
-			trip = <&cpu_passive>;
+			trip = <&cpu_active>;
 			cooling-device = <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 		};
 	};

---
base-commit: 7bf70dbb18820b37406fdfa2aaf14c2f5c71a11a
change-id: 20230124-topic-odroid-hc4-upstream-fix-fan-trip-0105bc1cc3b2

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

