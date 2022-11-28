Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8413863A89A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiK1MnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiK1Mm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:42:56 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC564E4;
        Mon, 28 Nov 2022 04:42:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6D18041EF0;
        Mon, 28 Nov 2022 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669639373; bh=SBgcElhpUc4MT68tmx19BwGELoM0ZF5BGvjBw82P0Lw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LlSo0LLK/GsVEe6+DBiT8NcAytsR2UudjTgh9acnYnEyUabkhJ+mZ+svmXw7LgnEl
         hp6vDjGU/6K6tY1huXuVXQnozw9yPLlpeX+uCOHCwnO3OI2dEx+PJtBrO/cxX5M1Zs
         0ZxFM+pvN4NW+uWXDu+i02mtom7wZ19PiRvGjmUkKA1ic7eTfq1P2ZtdQ6B1pnIUo5
         rYV3Z76CPMSBeZU3LTpC2iUEEKxM4JBjcujO3RAacq5VsAyN7aVR8gbNRLSYrZqHRC
         GGah8sFk3F+B7K2Ip9QMLkPVrwABoaAPu1neD8KVflwEUYLQZ0Y29zdVbvL8RoJK2o
         55P4JeG11UeDQ==
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
Subject: [PATCH v4 1/4] MAINTAINERS: Add entries for Apple SoC cpufreq driver
Date:   Mon, 28 Nov 2022 21:42:13 +0900
Message-Id: <20221128124216.13477-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128124216.13477-1-marcan@marcan.st>
References: <20221128124216.13477-1-marcan@marcan.st>
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

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..52df511ad87c 100644
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

