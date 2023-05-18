Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3C70881C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjERS5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjERS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7A10C3;
        Thu, 18 May 2023 11:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 067DD651B9;
        Thu, 18 May 2023 18:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC6AC433A0;
        Thu, 18 May 2023 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436237;
        bh=vxBYR6LtHdTWo59agyMO2DjmnNEXIpF3f4ssS0Pr5DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Km1I+KHyYtnUN0pmY1DDp07p0EmyV4uwgUlqNQjv0THFIX/Z+sDhlyrED7Snmr5wG
         EBwNATQzc89st4HbSJmDYMmrm3w5yciXzJkyjUc+sHSRI2QyKKTCULLkts4umpWAPE
         p4BxzkN2XkbTv1TzN86ZSgOUu6hTmJk3+/q4/QMDejKNDiIUzJYtXfm2+2RY0/bv0D
         UkhQ4NdCtw5rhpLhGbdcsmSM9lmdgliu5oHuN4yitls/IWMiqrzlzN7B8GFzYRiIar
         fvM366GxuOHSbd2dOom/rA2HjSkRZegJ5yQrRcbVnbJWK+qeAac5OuPgLLE5MR42l2
         Uw2Bj7cE/XPlQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 8/9] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Date:   Fri, 19 May 2023 02:45:40 +0800
Message-Id: <20230518184541.2627-9-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
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
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..6df20c65798a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18162,6 +18162,12 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V THEAD SoC SUPPORT
+M:	Jisheng Zhang <jszhang@kernel.org>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	arch/riscv/boot/dts/thead/
+
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
 M:	Jack Wang <jinpu.wang@ionos.com>
-- 
2.40.0

