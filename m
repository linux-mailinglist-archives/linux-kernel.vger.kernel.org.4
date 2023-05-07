Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AB66F9B66
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjEGUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 16:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjEGUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 16:12:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21BD26AF;
        Sun,  7 May 2023 13:12:57 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac80ed7f26so41166011fa.1;
        Sun, 07 May 2023 13:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683490376; x=1686082376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRKM8LIUCNvoyKZPDIYQU6c99R0Qprh6pzqLDekWHaM=;
        b=Yf7agK590WDNiZi69lpTfJZFr8ng/CBE3R+PI6ZWj8ykd9CrLwNA7cntOY6QVvOepZ
         YWYv2xMXpSHHH4aQZa5eoZXyiIkO0klkM2b8dkHIzXMt690892x3C1w7mmvpC/39sgeY
         csplhp0gqPYZ7nfU28STpyNdIyxdHnQ/ahpemKsRR4s3+U8cJ97FZc9qnQO4gTbVrzDs
         2pQTiwtEXAqQ8Uea0Z8dDuKuC/8IMRaTFKETqohvv6qwlv+RKaM1GLz1A7CE9sFMq7Xw
         UeHKbGx+9luzL3TFUc/N1zZtrOXq/jUyN9xzEo9h9uZacxnuqFeYV5b94LtYGxLrUXPf
         +ksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683490376; x=1686082376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRKM8LIUCNvoyKZPDIYQU6c99R0Qprh6pzqLDekWHaM=;
        b=AaOsQAg7sFB27wSFnrZYKp5H0vrk8SyJHg7vR4nrbRc6r7/BujG7L45fPlUXG2299W
         BOVJxOb8qBbmku4NjuVNRLP8rXtlSQx3laiTc5dduKmWgwfMarxKiyziYG1o1QSafws8
         shlV6UcVwYsaKq4dcnygrh/K4nhvDioCjglVgwzaXei0spwJ7TphcKL/w28WJ/z5FiVm
         gTAmwG0s+qbxUmY141gigS+3r5L8gd9NXJJxlfcT4oBR8XeAlRfm71VPPpns5xZt3hva
         AFF6RnGWm9kjKvUBU6UYFBiaW7DsFkUfF2hlamLJ9MXAqD2y9QsZxDps8xxGNUiXaInF
         WogQ==
X-Gm-Message-State: AC+VfDykHcqsMxxs5Iv01X6cbe4f7vWIcv2f5Zu8p3cfeQuULPkVe5zi
        uamRiY1wvD6HXQ1m+5L/vzb1K0OP+px07A==
X-Google-Smtp-Source: ACHHUZ5X037Neowba5GMOWBVl/ydyXVTH9e/vEz5t2YrJxYhE71mDwsMp4d5sm2cQpRxhzs6O4cDtQ==
X-Received: by 2002:a2e:9c13:0:b0:2ad:814c:6ad5 with SMTP id s19-20020a2e9c13000000b002ad814c6ad5mr984789lji.46.1683490376204;
        Sun, 07 May 2023 13:12:56 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id m19-20020a2e9113000000b00293d7c95df1sm918031ljg.78.2023.05.07.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 13:12:55 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: msm8226: Add thermal zones node
Date:   Sun,  7 May 2023 23:12:24 +0300
Message-Id: <20230507201225.89694-7-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zones present on MSM8226 SoC.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index a0c3d25eea65..f68556b15183 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -752,6 +752,50 @@ smd-edge {
 		};
 	};
 
+	thermal-zones {
+		cpu0-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 5>;
+
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu1-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&tsens 2>;
+
+			trips {
+				cpu_alert1: trip0 {
+					temperature = <75000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit1: trip1 {
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 2
-- 
2.34.1

