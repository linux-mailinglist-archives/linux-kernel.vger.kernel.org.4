Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7E611E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJ1XTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJ1XTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:19:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6C1FD35
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:19:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id f9so6080721pgj.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdbgZ8+Fu6n0HK4tgOaOYq43eN2AjNjj/Lhga+VAiyM=;
        b=aMw3oUjEz8KxyX5NRy8i43+HJNi8jXjsGtcRnti8nSdP4d/D/7x/NYETkIaL+23EEd
         37AA/MvumskK4g5anPHvbmKTEazSBxU8xWFpbfzNfVoHL8XP0rk5+6xe+EiYp19r4lgg
         3E2+1UsnCFUXhBv/6PElhfyEisP2ddRRJSTJQBGQiJch9HkvDg9XowGTYV86BxzccqYz
         woDM+lrq8UDV+DZZ021IjdtLqgVhH6v9U57om+imUTcuJkGHkuke/Q/IBc/q3cH2Vblp
         rbMzYHQKFrzrAiJ7g5Rku+VyVCcvidbHmCvRJM8e14ayWyUZFgykrPs9tabdGTJCZyeb
         IAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdbgZ8+Fu6n0HK4tgOaOYq43eN2AjNjj/Lhga+VAiyM=;
        b=5L0UciDwA9JSw+SzINCy2vtn9ML2XsuqTGx6/S7CAHiTgLBeXxoeu5T84rrV+W/hls
         5udyafOEcG7wtKQcmp0WY799kT8JpwriSHEndEUOfg2ZowPEl9fKfQc6N4Woh2BALxHA
         SIgwnYfdOV2vCKYTF1z+r9JitBICao6wXBes/UOqCHpbMpZ4kA4CNPYlb9SiHtw0WHCn
         LEfRugqi6PE2mv/CGeSTaCZyWEOI7mzKYAC/NeghwHv/1cuXD2u8cBdsO4YWtYw/VNrs
         mjQUZxmapXdBmSnuvtncgeEBBMurFlXhAPCA+vYgCgnFVUeOIPCA8OlfjaYCiKg50drH
         ZdoQ==
X-Gm-Message-State: ACrzQf39qTC5VqgVHayQ1OtqWH/H/kynfnzpxEhrEjrz8h+g1e9QQ3X+
        8QmXR5f/SdMiOXDCIisUNUCBGw8Cu4EeCA==
X-Google-Smtp-Source: AMsMyM7kBxRafshIfMOooOPKNBPhtCi9z2rUeho/arEVqJ9+3KvlGJVZHHufukrQPzCdagMN4rm8IQ==
X-Received: by 2002:a63:69c2:0:b0:46a:eeb1:e784 with SMTP id e185-20020a6369c2000000b0046aeeb1e784mr1617170pgc.589.1666999180528;
        Fri, 28 Oct 2022 16:19:40 -0700 (PDT)
Received: from rivos-atish.hq.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id jb5-20020a170903258500b00176ea6ce0efsm1335plb.109.2022.10.28.16.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 16:19:40 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] RISC-V: Do not issue remote fences until smp is available
Date:   Fri, 28 Oct 2022 16:19:29 -0700
Message-Id: <20221028231929.347918-1-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useless to issue remote fences if there is a single core
available. It becomes a bottleneck for sbi based rfences where
we will be making those ECALLs for no reason. Early code patching
because of static calls end up in this path.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/mm/cacheflush.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index f10cb47eac3a..7fafc8c26505 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -19,6 +19,10 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
+	/* No need to issue remote fence if only 1 cpu is online */
+	if (num_online_cpus() == 1)
+		return;
+
 	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
-- 
2.34.1

