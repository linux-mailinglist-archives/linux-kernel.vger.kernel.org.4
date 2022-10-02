Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5005F2247
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJBJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiJBJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6E23382
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g20so8962449ljg.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ujnj5A/lShQ8erz1tXEnkksj3gclKzTZxcGk/51ITnk=;
        b=YW5Jmj4HgVbpnV3mZlvg9vryhFc+BAOTcOtKKDpfQ4V97Lh0Up7xmKCvfkct+SBXcC
         Uq96hXolB7XoT75el9r5D5EuC5XcxB37OlsFX26EWCs894UUZNOrKmh17yA1Y7fNg8zL
         1kNrIHXu0MX5Bny2mQnCyUOLHtZMrl0aCgpmDh8QeYMSZIEpha47GlQNAwdb0JsuJVCk
         Q5IAM88nRBQEc9LQZ5OPsNw+wPyr+RJ8a0UGN6AElrI8LOj3cHpuzmf+XKGV8LS829v9
         Om8DBhj8JUH655GoSh3ewhApdGvpny6smuMoihXYkhtvles93nYwHYVx2/5RK6DRg+47
         pBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ujnj5A/lShQ8erz1tXEnkksj3gclKzTZxcGk/51ITnk=;
        b=zzzIrDQNtQXTypZkSLE7uq7FfSJATsPI2CbslTxglfYQE/IBczafFs6Zhl21Z71GKP
         tuyphPjqDRex9uW+Wmga1hgGIExkBmEnq21jJ4yRWt4FFUfJFPDbRlCCGJXo0mI86IQy
         bzml6OPghKFVl9StGJ8imheOag4fp9m2CXSg9VQfKWWh0W9tDOc0AX2Ny0kBrZj9sA/i
         cE0CBpzKgUgLpe2/xfvHiEi9QEUaDaymK+Rl2JoBg7gcwi4G4ROKn1GC1TmReX3Bd4sN
         A3dt86vZ7al9r6TXRkYzO/tSg/lkWRvbQ9mwpj2k26mUhr7Urx0U9EO39kZBqRCp3u8G
         S/mw==
X-Gm-Message-State: ACrzQf0SidhbeNOLMv5touLBFod5xd9mYYWjoxP0H4tP1sB5zetg/mxW
        jbaMwX766h9yWLHh7MXsYCWrHw==
X-Google-Smtp-Source: AMsMyM4AvSraxR+knK/00LE1gTTiBeGSeW+z6LcSw/BQ8VQZtcfjQj2OdN+BpUNjqJ/3aVAQrdHyxw==
X-Received: by 2002:a2e:7a15:0:b0:26c:6543:e4a9 with SMTP id v21-20020a2e7a15000000b0026c6543e4a9mr4800596ljc.204.1664702405693;
        Sun, 02 Oct 2022 02:20:05 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bi8-20020a0565120e8800b0049602a81111sm1024528lfb.107.2022.10.02.02.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ls1021: correct indentation
Date:   Sun,  2 Oct 2022 11:20:04 +0200
Message-Id: <20221002092004.68928-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
index f3ddea934f1b..d2cae8c7d7a6 100644
--- a/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
+++ b/arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts
@@ -30,11 +30,11 @@ sys_mclk: clock-mclk {
 	};
 
 	reg_3p3v: regulator-3p3v {
-		  compatible = "regulator-fixed";
-		  regulator-name = "3P3V";
-		  regulator-min-microvolt = <3300000>;
-		  regulator-max-microvolt = <3300000>;
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
 	};
 
 	leds {
-- 
2.34.1

