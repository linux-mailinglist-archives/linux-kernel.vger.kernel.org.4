Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363F36B6628
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 14:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCLNK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 09:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCLNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 09:10:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AB84614A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:10:52 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id g17so12449119lfv.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 06:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678626650;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tDIef+aPGuB5wQknGJ7abVMxEUnE+NE/6MUxxwCrbfI=;
        b=NMdrxhVttGmcRNAsGiInCqSOxvErRHAm7Ww0QEvoQulpE8GIZZmdUI6Qc8Bar5z5iO
         XKZ8HNJwJG6TmE8bGZW5D/Am6Uj4VNukG0U/N0ts2NEWCJtgWV8Rc+/PNQIg0p6Dl8Zk
         L+xSPXHyeoRAsOamDZ0bsYg9iPod2caaCBGSpht57kYSTpF6NK+6ikirzMyCQq2OsX0b
         nUYDf4sopMYkRHd6L8Zs7tSQPmaORyXkXePnFGlX+alkIVTuKbOHyTDyaZtXLZmOnffm
         c+GAaXydNZbd1A402ZN/wSeIkMMIgVn1bMdm9OdvGG/lI64E45a3wdpEf/eOu95e6iPk
         +psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626650;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDIef+aPGuB5wQknGJ7abVMxEUnE+NE/6MUxxwCrbfI=;
        b=FJTP/k2eQvDYpQbMo0is+/jl1WTR9lJRPq/3yIKgzUEbV4OL83QYIqPZmyfxeV56hg
         0JHMam/NAb2F/IS6T741Ui8J1wiw3KMsVV+xZO8J6KnsRSV2hQqsFyrOLn0DO9WWRpUv
         jKGbYArIerl+DbLnejA9b7BYXpdO/SayFGVb/0ETYft0Ok5pAiKoNlqG0RZs7AfWPz1q
         FEyjF4v1G6De4yUSwHEdNeHSa9uk7W9mKq3b8AYqtOB2y4fW8WVRn6kjHSnDqJvWip3M
         rZpU5my1pXUmERU0OFn+vfSP3jlxYP0FBQTF1so7SazQiVeuxpsWb7LBikqX6qOpxowQ
         yWwg==
X-Gm-Message-State: AO0yUKXIUOYcpjHbAjP+G3Cw4Yv96jFNC3yDcvqcCxpb6F9esnQtl+qb
        ab0kAd58siVLRio0oLPcGE9k1UXxHKv1adDX
X-Google-Smtp-Source: AK7set/ZuhOlFPVW8Ud3ll9chVvSzx40ZBlSOIUr5smic+z5WIGbrzDYvp/9sDRqVhSJvYVnDiSZ5A==
X-Received: by 2002:ac2:539a:0:b0:4cc:b784:c47e with SMTP id g26-20020ac2539a000000b004ccb784c47emr8446381lfh.62.1678626650658;
        Sun, 12 Mar 2023 06:10:50 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos78xx-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id c24-20020a2e6818000000b00290716d65dcsm644822lja.136.2023.03.12.06.10.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:10:50 -0700 (PDT)
Message-Id: <1678626510.1783316-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678626510.1783316-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 16:03:15 +0300
Subject: [PATCH v3 1/2] dt-bindings: exynos-dw-mshc-common: add exynos78xx
 variants
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.

Add two new compatible strings, "samsung,exynos78xx-dw-mshc" and
"samsung,exynos78xx-dw-mshc-smu" respectively, to denote exynos78xx
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi                      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..a72a67792 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos78xx-dw-mshc
+      - samsung,exynos78xx-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
index 23c2e0bb0..4b94ac9da 100644
--- a/arch/arm64/boot/dts/exynos/exynos7885.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
@@ -294,7 +294,7 @@ pmu_system_controller: system-controller@11c80000 {
 		};
 
 		mmc_0: mmc@13500000 {
-			compatible = "samsung,exynos7-dw-mshc-smu";
+			compatible = "samsung,exynos78xx-dw-mshc-smu";
 			reg = <0x13500000 0x2000>;
 			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
-- 
2.38.3


