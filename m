Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24C7745A47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjGCKai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGCKaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:30:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2BC2;
        Mon,  3 Jul 2023 03:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688380182; x=1719916182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPRtOyIqm/BcHFGgw0cl0PQB3rNvTkemYLiSjsKMtC8=;
  b=lgQcLcxXS6tm08dcYjRk4ZvAK0jB5DcP3tf0eYLFioo5husdgQzGw9UD
   GBdnWvEWPd/t8tTZ+12euwKXm8mA+MXtZR760SAL0+FAoBLsdKm9Sc40N
   VRISpfxRA9OewqRBpmZTJ/WWe82h4LcbSGYnSVh2CQf+lKNec7cY7e9KN
   cB0gfvSBI1SSFmZtweXaQwaDQG4eah0b6Wd3A80mZhQYM9gHP+kCgduUa
   rUKsUqTijOHQ24/bYh6a/J5p/xhNL3yp2JJvylADoAPeMx3Z+C2cCy7Jb
   GztVaqCcdOZP8aSHFl3bl5rdbK3x8GdRb2JtStw15a0KT5/FpRzqa55xI
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="222963013"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2023 03:29:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Jul 2023 03:29:15 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Jul 2023 03:29:12 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <palmer@dabbelt.com>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Jones <ajones@ventanamicro.com>,
        "Heiko Stuebner" <heiko.stuebner@vrull.eu>,
        Evan Green <evan@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        <linux-doc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/11] RISC-V: add missing single letter extension definitions
Date:   Mon, 3 Jul 2023 11:27:58 +0100
Message-ID: <20230703-unlocking-straining-5c814e99642b@wendy>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
References: <20230703-repayment-vocalist-e4f3eeac2b2a@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=HPRtOyIqm/BcHFGgw0cl0PQB3rNvTkemYLiSjsKMtC8=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmLFq2OYbpqeyguNVtBVfCDrszyTnumf3Wt4c9vmhndmfJq 4iOGjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkRhUjw+Rrx1P3PZiWeORP1PbA5U 1VeZMWzZhuYfJ9y34dHvkbO3gYGU6tF/o1Jfnay2e5p43/n9xduypM8YrpwczNvfuMMxZGs/IBAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate adding single letter extensions to riscv_isa_ext, add
definitions for the extensions present in base_riscv_exts that do not
already have them.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 2460ac2fc7ed..a20e4ade1b53 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -14,12 +14,17 @@
 #include <uapi/asm/hwcap.h>
 
 #define RISCV_ISA_EXT_a		('a' - 'a')
+#define RISCV_ISA_EXT_b		('b' - 'a')
 #define RISCV_ISA_EXT_c		('c' - 'a')
 #define RISCV_ISA_EXT_d		('d' - 'a')
 #define RISCV_ISA_EXT_f		('f' - 'a')
 #define RISCV_ISA_EXT_h		('h' - 'a')
 #define RISCV_ISA_EXT_i		('i' - 'a')
+#define RISCV_ISA_EXT_j		('j' - 'a')
+#define RISCV_ISA_EXT_k		('k' - 'a')
 #define RISCV_ISA_EXT_m		('m' - 'a')
+#define RISCV_ISA_EXT_p		('p' - 'a')
+#define RISCV_ISA_EXT_q		('q' - 'a')
 #define RISCV_ISA_EXT_s		('s' - 'a')
 #define RISCV_ISA_EXT_u		('u' - 'a')
 #define RISCV_ISA_EXT_v		('v' - 'a')
-- 
2.40.1

