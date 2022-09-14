Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20855B88E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiINNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiINNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:14:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AD50071
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:14:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t7so25605873wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=kK+4cuyn2x8bZa+3XjGCMKovnOpMsppyq3qKsdF2ffg=;
        b=QsXOsr8pctoL+dvXPhfMqitnyDpitQBYg6IdWPYLziAKQS/2z68AXxL7Y8ZMgltcne
         aRWXDvzTef1JmAU1pf2KgQ3C64iplqyg/YeTwBCHmNcJeKXhHUS3gjMMoatV4usMNXqh
         jT1KbXksezwoec5WtRhMr+2YINIFL+hwCazWfsb7so7TtN26A/d+KthKpin0bK3PZZ9o
         azLTC/dob2rz2LpTSVPEsaPiJMZeiDbRL6aVLY1oFMG1mksf/l/OxB+yfHxzOJ6kSNt7
         Zl6U1orgyaCHeeD3igXHWtWyXRcLahQ+59syyXa6vDU8ReDYj8jIy586OOsSRZq9fCCM
         FsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kK+4cuyn2x8bZa+3XjGCMKovnOpMsppyq3qKsdF2ffg=;
        b=v8A3JNcsOlnZbOSOCHlyjioKdCZzHvXE05iRware4Rx4OJ1cJfCTi1+B6a4dniLwil
         6+o5Ng4Mb38fZHvwqvqbukZFfy9ThrsFdFeLpNkLCsX5lllU73aA2ENOhesv7JXAxhyl
         DL0C1qHsTC0y0AxXqTHQRLJ6AIM69crvXjMzky5HFLEAAzmy7FxsL8Y+7kHbLFdA0bTi
         WqYFb//WomkK5i9mUMjFvBZ3mX6ry61BGSXfbJBYrzVW9ZuQJxsLbeJ+F+Va5RfVipzT
         itt8yqo1Tygh0DLkzFyp4IADBMWP+GrsnxHKCc7dWCdavK9eS7f+mWj1gwMepUgLKVvd
         s2TA==
X-Gm-Message-State: ACgBeo36l/u0DA0pXIw6lG2wWMPEvIBcY1emddbn7NvxEjfs/zmMbIg6
        QtZ1IQUcjgZM9rZGfd8nbOCD3g==
X-Google-Smtp-Source: AA6agR5ANUi79WWgOf9jC1tlgp0/htkLuK+NlPCxd4hKwfEcURAD7sCnBetWwAbHCF5GbmcQcIv1Ug==
X-Received: by 2002:a5d:4602:0:b0:228:62df:7d2f with SMTP id t2-20020a5d4602000000b0022862df7d2fmr21723881wrq.247.1663161257160;
        Wed, 14 Sep 2022 06:14:17 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b003a319b67f64sm8185249wms.0.2022.09.14.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 06:14:16 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8183: remove thermal zones without trips.
Date:   Wed, 14 Sep 2022 15:13:39 +0200
Message-Id: <20220914131339.18348-1-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal zones without trip point are not registered by thermal core.

tzts1 ~ tzts6 zones of mt8183 were intially introduced for test-purpose
only but are not supposed to remain on DT.

Remove the zones above and keep only cpu_thermal.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 57 ------------------------
 1 file changed, 57 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a2..f65fae8939de 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1182,63 +1182,6 @@ THERMAL_NO_LIMIT
 					};
 				};
 			};
-
-			/* The tzts1 ~ tzts6 don't need to polling */
-			/* The tzts1 ~ tzts6 don't need to thermal throttle */
-
-			tzts1: tzts1 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 1>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts2: tzts2 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 2>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts3: tzts3 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 3>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts4: tzts4 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 4>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tzts5: tzts5 {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 5>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
-
-			tztsABB: tztsABB {
-				polling-delay-passive = <0>;
-				polling-delay = <0>;
-				thermal-sensors = <&thermal 6>;
-				sustainable-power = <5000>;
-				trips {};
-				cooling-maps {};
-			};
 		};
 
 		pwm0: pwm@1100e000 {
-- 
2.37.3

