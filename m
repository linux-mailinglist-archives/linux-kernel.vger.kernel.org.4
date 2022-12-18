Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1865045D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiLRSb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiLRSag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:36 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239D1CD
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:12 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so6813844wrb.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hihxsb5erPMsln/gUSY59M8NixzubgoudYMNGqOBjo=;
        b=NGfdREvNprmAmUc2BJDXguEpC2w1uGkTEXFyrIXXxIuEwHTPjUk4hCyMsZPtnXcXYO
         7Z8+mIOP4p24RV6wfinMQBSJgQvBHmrL4g1iJAP86SaPzliHiFAzCZzma++5/g4uGsR7
         a0wGEVcjdoz9mjfRmFRaSN97xKF45SO/lOkO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hihxsb5erPMsln/gUSY59M8NixzubgoudYMNGqOBjo=;
        b=RYhoRNvqP9lZgrhF6OS/zWnrL48R6AIf8e6pSYghQTHmVVmIOf2eNYWcGKNmlzHzG/
         6REjeevEc9tsW0jMB7tlLWQb4d7eXqg7EBGBvZJjXvlfw3KlKid8vK1i0PcyQY8AjjEx
         XJywm6yugo/Zjjt2k3ZqPAoJKL6QuDz4wbRYkbZzaGNtvOoThsNFDrxsINCiSQxG9MMb
         eO6hSwiRAq1upTHqOWz7sk3eOqWj+AviwZPmrXFclPfbvdyex+gjDAzBa9EwvbcdbPPK
         W1izk7wrxHuurb+MzUUXcXZCsUTU+fUWUCbuelX/cyabZ9WtHfmWDmDr/7r29QO42Tun
         l97g==
X-Gm-Message-State: ANoB5pnPX2mB7nAsja82L0x4miJ8/0Ep26W2t+TC91IfVDLr5LFt3btt
        +I8+ybKFReHpuJ6xmhBhQgd4qtZJ70WFb1WkJOCiPrceC0Ria2vLnBSRZHFnecJaDCL+1obwRP5
        BYwVbN6o/61Skh1x6FiIqsaX81mSH4H3wJY4ZOt+dQNEqjcPHCH43SQ4xtmwWn2SPw3IPpoG+VO
        VILohj7eFHC8+DUPRPHLAZU3BAug==
X-Google-Smtp-Source: AA0mqf7ane6F6HV8dfwJ2yQM+5/9KGiO2ahYsgbLaINapHO2VdmgET/fKqtkbjCUGRl/lQ7GPaTwxw==
X-Received: by 2002:a5d:4586:0:b0:242:1522:24a0 with SMTP id p6-20020a5d4586000000b00242152224a0mr24668948wrq.47.1671387550956;
        Sun, 18 Dec 2022 10:19:10 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:c45e:1c4b:fab4:ee34])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm7956489wrg.104.2022.12.18.10.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 10:19:10 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     Jason@zx2c4.com,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        aksecurity@gmail.com, ilay.bahat1@gmail.com
Subject: [PATCH v3 3/3] Replace invocation of weak PRNG in arch/x86/mm/kaslr.c
Date:   Sun, 18 Dec 2022 20:19:00 +0200
Message-Id: <a6b5907e2a1249f109c9112652cbbec244e00fba.1671277662.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
References: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

This third series add some changes to the commit messages,
and also replaces get_random_u32 with get_random_u32_below,
in a case a modulo operation is done on the result.

The memory randomization of the virtual address space of kernel memory regions
(physical memory mapping, vmalloc & vmemmap) inside arch/x86/mm/kaslr.c
is based on the function prandom_bytes_state which uses the prandom_u32 PRNG.

However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
To fix it, we have changed the invocation of prandom_bytes_state to get_random_bytes.

Unlike get_random_bytes which maintains its own state, prandom_bytes state needs to be seeded,
thus, we have omitted the call to the seeding function, since it is not needed anymore.

# Changes since v2

* edited commit message.


Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
---
 arch/x86/mm/kaslr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25..9ef8993d5 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -66,7 +66,6 @@ void __init kernel_randomize_memory(void)
 	size_t i;
 	unsigned long vaddr_start, vaddr;
 	unsigned long rand, memory_tb;
-	struct rnd_state rand_state;
 	unsigned long remain_entropy;
 	unsigned long vmemmap_size;
 
@@ -113,8 +112,6 @@ void __init kernel_randomize_memory(void)
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++)
 		remain_entropy -= get_padding(&kaslr_regions[i]);
 
-	prandom_seed_state(&rand_state, kaslr_get_random_long("Memory"));
-
 	for (i = 0; i < ARRAY_SIZE(kaslr_regions); i++) {
 		unsigned long entropy;
 
@@ -123,7 +120,7 @@ void __init kernel_randomize_memory(void)
 		 * available.
 		 */
 		entropy = remain_entropy / (ARRAY_SIZE(kaslr_regions) - i);
-		prandom_bytes_state(&rand_state, &rand, sizeof(rand));
+		get_random_bytes(&rand, sizeof(rand));
 		entropy = (rand % (entropy + 1)) & PUD_MASK;
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
-- 
2.38.0

