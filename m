Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430C873423A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbjFQQ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346322AbjFQQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:27:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E366211D;
        Sat, 17 Jun 2023 09:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C9A61172;
        Sat, 17 Jun 2023 16:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFA5C433C8;
        Sat, 17 Jun 2023 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687019240;
        bh=tuyRjugUtNnv9NSvg0JKtT6JTySfG2QjgD5pYhGE3Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rLemWZcmp8D3z8QRkuuDf2liEEtC/neuEkSmoLSHnQgiOwulQ7eCL/KBpJl/rE7vD
         JsSZ7N3EO5eX40xP6q9hxFDd+WPWvBpQNSbyo1UlzK7m6yoyfDzOEug7yDnSj9Fvzt
         nKCg/BZZqu33EPlM0+umikiChGZTZREweHOfuARN/WVQ0TLKBBsX6Ceagyp7pAoTPd
         mOC5vFCkJXkH33fDdscyRniDJTOsqMdatDrVeOLEry1ZzoDRoLeO3oQ0yu9YySZAZF
         EKqUT7hzvN73HeXK1nCs/c8NEeZnncnkWCHCu/f8TxBQdKxKHIWISGi0u3n95wWZFw
         3jJlEXSWOSoyQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 7/8] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Date:   Sun, 18 Jun 2023 00:15:28 +0800
Message-Id: <20230617161529.2092-8-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
References: <20230617161529.2092-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, I would like to maintain the T-HEAD RISC-V SoC support.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..68805b09654f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18162,6 +18162,14 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V THEAD SoC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+M:	Guo Ren <guoren@kernel.org>
+M:	Fu Wei <wefu@redhat.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/thead/
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.40.0

