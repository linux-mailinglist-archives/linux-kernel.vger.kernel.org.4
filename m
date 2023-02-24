Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881F56A19F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBXKUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBXKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:20:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA896199E1;
        Fri, 24 Feb 2023 02:20:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A2E8B81C28;
        Fri, 24 Feb 2023 10:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2011DC433A1;
        Fri, 24 Feb 2023 10:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677234012;
        bh=SValdW6+twrhc9WaF8TDt1HwWsjc8tggUimhMXutwNE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=p8T3zAeY6HKyIz16y1uFkaqTWkmLe/QfwY/mshJ11Rr8UKH4J/MkG0tfP6tkUICPV
         JvBjU103RXk4KXZsfASenHLYC6UCsgqgDLWbe7giOveL++JWn18AqWjuoxseLdOjVE
         irqHHh20Y088Jv5fkiZqQHhvESUWIZDuvhrAMtiCFNofC6tFIGOLwOSDn2NOXRvjZv
         a3cVJrzTx39HUKlWJECoVUdet4b6emqSmIn/e59eSrxE2I3ba4wNHkarQAhLD8WyF1
         hFJFwsW3E792PzsKaTMySboq3N0azktGkhpOJUfXnCgGI1JKyoLMj3ulXSawbvQW/K
         DGL96038lCK7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A2C6FA9E;
        Fri, 24 Feb 2023 10:20:12 +0000 (UTC)
From:   Sasha Finkelstein via B4 Relay 
        <devnull+fnkl.kernel.gmail.com@kernel.org>
Date:   Fri, 24 Feb 2023 11:20:09 +0100
Subject: [PATCH RFC 4/4] MAINTAINERS: Add entries for Apple Z2 touchscreen
 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-z2-for-ml-v1-4-028f2b85dc15@gmail.com>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
In-Reply-To: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677234010; l=1179;
 i=fnkl.kernel@gmail.com; s=20230213; h=from:subject:message-id;
 bh=ggm8RQAgJMgDmyKCZW5wheYPzEDID9Bijlhv3t/bJyQ=;
 b=ENiTipmIoLajED2qHTBaE1/jKCUb7/G8ftPxAilvHYwrfNUbOCmash09AKIAa80Je9DyxdEZd
 GEq2eHPPOLXCFqkrUc4lgVskHrtLJTTxppc34us0xJKLom6OkmU50KZ
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=7LFSAJtxIWAs9LzCIyX0sSvCZy2wQTyEIu1zch6o804=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20230213 with auth_id=28
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: <fnkl.kernel@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add the MAINTAINERS entries for the driver

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 135d93368d36..12811aa1bd01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1958,6 +1958,7 @@ F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
 F:	Documentation/devicetree/bindings/cpufreq/apple,cluster-cpufreq.yaml
 F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
+F:	Documentation/devicetree/bindings/input/touchscreen/apple,z2-touchscreen.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
 F:	Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -1976,6 +1977,7 @@ F:	drivers/cpufreq/apple-soc-cpufreq.c
 F:	drivers/dma/apple-admac.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
+F:	drivers/input/touchscreen/apple_z2.c
 F:	drivers/iommu/apple-dart.c
 F:	drivers/iommu/io-pgtable-dart.c
 F:	drivers/irqchip/irq-apple-aic.c

-- 
Git-137.1)

