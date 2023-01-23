Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47266779CE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAWLGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWLGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:06:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1390622007
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:06:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so7935817pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/I86Z/A4vUmDO3vQeaY3oHdbWoJpUdKGI1G6b8aHKA=;
        b=Ghr8PLpIvSjorLyynWGAiXrbw7WRRLugRpMSn2S7gmkovqgkfCtTDV5O07BMcxTfv8
         LbsvM02ZrfpuxjLY/ruanhSOOe0oKBVD1piTrO1b4KyaTmjHsqdHJQnEmt3bS4FVbhuU
         UAWZgjOMkn9G3V9UZFO8JR7qagNtZhaLlCcy+JExtFu7wkYdEa7Qqnh1sDP9HPWlwGTG
         LEqb1rYjCf2Dqmv/LqCWH/7X1XPAWTV60C4WmJ7kw5L2P/V9Ag6MBgYkg88vbMr8yYQ7
         W05bcGTr6sylxQVVuSWs2nw4fHUjhp3fmdRKS0VRYD9ZR64PcTVCJP/q9VvHnj8oVRPV
         KrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/I86Z/A4vUmDO3vQeaY3oHdbWoJpUdKGI1G6b8aHKA=;
        b=JgJYUnKWiKhUYjMZQhpiBqECkRRM/adOHrV80+Lzy/pDstKSYl5J/NW2npcc26agRx
         tKd8bINOW9fINkv61AvR41Vf32/2Q2+cD6qLV1wR8V4JQiMwINJkdRcNmz5U6j55Wkaz
         Wg29JNIymX3QzjH7wfy8QxekaI1r3NuBgaKsZl80jGCA+CFX58ttTglacA/DhVZOQaO7
         GMk5YYpQey975eO80MydrmRt6VK/eP0VcUCQR3i7X1eEQEVACpy4K6u1Aq3xDiiNpqed
         RBXV9VxGTDXKJ3YmNFROj3G0OivSZmFfWH9j7BAg8mkiI3wcxfMvfcziPsrYfMAtwhja
         D+sw==
X-Gm-Message-State: AFqh2koxsGhp1STJ+/Y826hcSktAxu1HgdYQ8Wh2FvavMHCdFk8ozAjE
        BBgX+BN9+J/hyTtXjoOcRjU=
X-Google-Smtp-Source: AMrXdXtxivLHoJGdzl+QyVBQo+pyGySBqrjtCueB1+npGD2LlyGq4N5iiUokIr1y0L9xCD1PZmzlrA==
X-Received: by 2002:a17:90b:3b83:b0:22b:ae7e:9699 with SMTP id pc3-20020a17090b3b8300b0022bae7e9699mr12568240pjb.12.1674472011488;
        Mon, 23 Jan 2023 03:06:51 -0800 (PST)
Received: from localhost.localdomain ([49.207.218.227])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090aee8600b00229962d07bcsm6448692pjz.6.2023.01.23.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 03:06:50 -0800 (PST)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Zhiyuan Dai <daizhiyuan@phytium.com.cn>,
        Prathu Baronia <prathubaronia2011@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: el2_setup.h: fix spelling typo in comments
Date:   Mon, 23 Jan 2023 16:36:38 +0530
Message-Id: <20230123110639.10473-1-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- "evailable" -> "available"

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 arch/arm64/include/asm/el2_setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index 668569adf4d3..40567b9bb019 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -177,7 +177,7 @@
 /**
  * Initialize EL2 registers to sane values. This should be called early on all
  * cores that were booted in EL2. Note that everything gets initialised as
- * if VHE was not evailable. The kernel context will be upgraded to VHE
+ * if VHE was not available. The kernel context will be upgraded to VHE
  * if possible later on in the boot process
  *
  * Regs: x0, x1 and x2 are clobbered.
-- 
2.17.1

