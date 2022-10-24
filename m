Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE6860993B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 06:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJXEjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJXEjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 00:39:49 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542EE1FCC4;
        Sun, 23 Oct 2022 21:39:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 86C4B4249A;
        Mon, 24 Oct 2022 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1666586384; bh=Ll3nZx9A+ehUPc37begKWfofxpkHxbd5hBsp2PqJ+08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pJxdBSGaqM1cH6OcyMx4XZSVH21f8MKmZAeode/RxTRonmYbCbXIwn7VeCh0i9sTI
         m3tqnIxuCqNBDJkqWDLtM1/LWRHaXh1zdyMDmsWUjt598YmYIYs/4dsv5vy9hXltwJ
         NMr1GV7/L/8+AyhM28gDP6rtAxMRaA7t8jqPBoTG7eVRcMUSFvCvZFEf9BXEepFnlL
         K2NIgOUKC+WjUyIjjU1Z8kWALC90SPR9tP03BHItesbxTGQggmNSYhPtSz5+F6uzj+
         sk7H7TOaHaxZjZcB7lQIHcB+p62w2Y9cilQ/JRr9+pMMeceIoFPDBHN+WPMTjSYwp1
         hCNQ+n/+RVNgw==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] MAINTAINERS: Add entries for Apple SoC cpufreq driver
Date:   Mon, 24 Oct 2022 13:39:21 +0900
Message-Id: <20221024043925.25379-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221024043925.25379-1-marcan@marcan.st>
References: <20221024043925.25379-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This MAINTAINERS update is split, as usual, to facilitate merges via the
SoC tree and avoid conflicts.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..6783f5263b5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1897,6 +1897,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
+F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
@@ -1911,6 +1912,7 @@ F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
+F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
-- 
2.35.1

