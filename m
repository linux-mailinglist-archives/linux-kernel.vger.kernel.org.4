Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0E65E908E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 02:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiIYAsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 20:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiIYAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 20:48:13 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A5645054
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 17:48:12 -0700 (PDT)
Received: from LT2ubnt.fritz.box (ip-084-118-157-002.um23.pools.vodafone-ip.de [84.118.157.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id F23273FD02;
        Sun, 25 Sep 2022 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1664066890;
        bh=olKkd4579n/2ZvwSQvhp6zSub7B8J6f3nomR6GM/prQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=E9ec9TfuZO3TwxFmPT44mTMyl7nJNLxppT7Z36cZaViQK+2oYgmTmdij9qqNRgbAz
         Or00mxqSH0bETD9X0oxUnPuowGyV2MBkAjgulAOQTYEz0xUhCbVmKIepq9PvevdaQQ
         z0meE5RHMC0n3rOoxPtxP8/ve093uSLm+qmUFZcj4KJeNvkoFO5Xpgj6Nh/SMVCQpf
         T5ENuc+kdh/EXcCScoKPIQnuDL+PtC6kGG405kbRVNQZh/LMOiu5rzWgly9Hq4tkYk
         vwPPOjDeeO+V78KrDKobERBRtEBmNRwYFHiwQEspOSsp5eQRFEjDCIvggpRMpPl/cL
         Qwk32W5XU08qw==
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv/vdso: typo therefor
Date:   Sun, 25 Sep 2022 02:47:57 +0200
Message-Id: <20220925004757.9089-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adverbs 'therefor' and 'therefore' have different meaning.
As the meaning here is 'consequently' the spelling should be 'therefore'.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/vdso.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index af981426fe0f..a7644f46d0e5 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -10,7 +10,7 @@
 
 /*
  * All systems with an MMU have a VDSO, but systems without an MMU don't
- * support shared libraries and therefor don't have one.
+ * support shared libraries and therefore don't have one.
  */
 #ifdef CONFIG_MMU
 
-- 
2.37.2

