Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF0266C945
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjAPQra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjAPQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:46:59 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7C13B0D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:34:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id vw16so6211454ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VKurv2fBxvZBgI8zffGgWfWcbuA/mY2GbURj2GBqtuI=;
        b=hDKG6BvYivh2vxmy8FbZagCDJ7pdkQqIBjP64nFrRQh2tXrf5j9lICcPG+Wn2DhvDs
         t7Rq/pK8Hf0N7V7VMT/y6cafH5BMy6f3ELyJiSvoG65kL3Gwer7GHV2csDkcM2GA3BC5
         aGhw1UdkswTFWrivsMwTB0groXZpxAtVvr41NDXjVSoog0GCclTTWqySKKjmLmdHZm32
         FuExRep2B67j11jv2eApvVYEovtnufCcXgOrMvb58oiXZLPxUwTX8qySUiIVaybH9D/k
         b4jvPRzWcv+w3ipU0Vv6GP3m+sGsksg610ijpcvdVajkLB3vsfhpDpLDt3j3yQ5Kdjx5
         YLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKurv2fBxvZBgI8zffGgWfWcbuA/mY2GbURj2GBqtuI=;
        b=TfyTsg+sBCyrUg0MjSNGPxo8Nyr4fJtVIl0Htc3c2Zib8iUhkgHIHXsrNsIBgr+C9i
         T5hInhyz/kTFPvFQLx6CR0owVeiRDHh9LH2G2Fncv62DEezUh5JO91g0E8VcXJAphloX
         6/Fi1rlpGld37491R1lmFJNCygsClnneblgOWKxumCXiAE6kaTayDRDuD+z4lMR77KOe
         pZllKHob5R4cd0eZFI/D6lBxl/i9/kJk40cVrx9156I3JGZr2YeTq5J40w+1QxEngaxh
         FipysGLVGDXzslK1T3z8OJfhcIbMXWjWujdIBrq81OpDyLray1O8bnDy78xpxEuX61aA
         Oziw==
X-Gm-Message-State: AFqh2kpuXa+PbfdrFDGRqmUu1oZKwq3uprJLq/PL8+hSLvLR7/Ua2fi5
        hZOe5r3QSC7fg0VgvN6T6mg=
X-Google-Smtp-Source: AMrXdXtwBz3Uu0Cw7081MlKCKmhbz7gEc4fI3TqKyRF/mOPKqlazXXsAB1bNvFtKi7Yz7UnCzsqkTg==
X-Received: by 2002:a17:906:1681:b0:86e:c9e2:6313 with SMTP id s1-20020a170906168100b0086ec9e26313mr6806079ejd.32.1673886890330;
        Mon, 16 Jan 2023 08:34:50 -0800 (PST)
Received: from fedora.. ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id kx5-20020a170907774500b007c14ae38a80sm11887805ejc.122.2023.01.16.08.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:34:49 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/PAT: use try_cmpxchg in set_page_memtype
Date:   Mon, 16 Jan 2023 17:34:46 +0100
Message-Id: <20230116163446.4734-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
set_page_memtype.  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

Note that the value from *ptr should be read using READ_ONCE to prevent
the compiler from merging, refetching or reordering the read.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/mm/pat/memtype.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index fb4b1b5e0dea..6d1ba2dda35d 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -159,10 +159,10 @@ static inline void set_page_memtype(struct page *pg,
 		break;
 	}
 
+	old_flags = READ_ONCE(pg->flags);
 	do {
-		old_flags = pg->flags;
 		new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
-	} while (cmpxchg(&pg->flags, old_flags, new_flags) != old_flags);
+	} while (!try_cmpxchg(&pg->flags, &old_flags, new_flags));
 }
 #else
 static inline enum page_cache_mode get_page_memtype(struct page *pg)
-- 
2.39.0

