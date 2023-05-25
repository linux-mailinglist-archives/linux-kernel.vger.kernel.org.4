Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC171107C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjEYQJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjEYQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:09:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAC51B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:42 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-51452556acdso1234326a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030904; x=1687622904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f10B5ZIa9ITmPIMb+u+qs6/5+yRXx2vTTGWyb6FapHI=;
        b=j4k12bcqw1DZL7kzBgVq5yAW/945ZHX3GZezjaJBksDYmnZ+djZe6tAJRtfc2rCNd4
         LA2FPd9+VYvLe1kuYuZ2tCKzBtVSI8a/OfcOQ4S5Yt7+urECSd06+8xHd9WCUyScw392
         JafNrWXyz4HToplkXg+A475yLr5ytuiAkqpf7zo4dJwWY43Mdvl29PRtiKnTyYDnPP6r
         tW0xlmG/yK1qquV0+z/YJTP65mIMMrHrdbkY3+Jmu3Zdx5TbFXGTraCWAOESfPciF5KH
         MXAzmp7+eGuqZ9YKr4gOjDMF8iVCJOo2upNhlFxxFrlDFjVzjEO9CUU1/MO89ICsJQho
         tqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030904; x=1687622904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f10B5ZIa9ITmPIMb+u+qs6/5+yRXx2vTTGWyb6FapHI=;
        b=Ja3Uw6t5uH/3j77dHsJpAkUxSBHG6doCWC+C04GtLb9VhpYhUf467/2F0xySkfxPwC
         D+cuFiB+gkF5F0TWUrx4kdJh7gPSwQ0u4gE7sOuwC73z/FO4Mr82b9lmDoWQ6n8cAPDm
         KjKCoLJVnAnH2M+Zy7/ztTST743I0ErcfVyFLuMEC2Xd5tV/wpAwIPUkc42NrXcMS6H2
         W5l9zOUMngRVGm9+//SApFMoSKNXS26+FOQJslurz9PbdKhupRaWbWEz37hCC9UWo25A
         OMT/FO43EN0e28vgBN0fxkQop0gUO/Y47MPdiikuQgXsAHVuifpyWnPJ+mWyzt8MDkDw
         MAxg==
X-Gm-Message-State: AC+VfDwOfE2axGxxpMyedvyLVQZfAdCLQxBKyjYCD+OdAmQHTsdJGmRx
        Fu+DEC//AOAmbQ/WicVSLxU=
X-Google-Smtp-Source: ACHHUZ7BKJzUagaWoCZc5fUsRZnu5bnzIJTF9ZG7dnZ12jM5KiLtEtnsQDi59PS0Evp48sZLFX8c3A==
X-Received: by 2002:a17:903:430f:b0:1ac:874d:f55e with SMTP id jz15-20020a170903430f00b001ac874df55emr2063949plb.22.1685030904226;
        Thu, 25 May 2023 09:08:24 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b001ab12ccc2a7sm1611450plq.98.2023.05.25.09.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:08:23 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [RESEND PATCH 2/2] ARC: rename 16KSTACKS to DEBUG_STACKS
Date:   Fri, 26 May 2023 00:08:12 +0800
Message-Id: <20230525160813.39408-3-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525160813.39408-1-minhuadotchen@gmail.com>
References: <20230525160813.39408-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 16KSTACKS to DEBUG_STACKS.

arch/arc/Kconfig.debug says that the default stack size is 8KB
and it will become 16KB stack if 16KSTACKS is set.

However, the stack size is based on PAGE_SIZE, and it is
configurable by CONFIG_ARC_PAGE_SIZE_16K or CONFIG_ARC_PAGE_SIZE_4K.
When CONFIG_16KSTACKS=y:

PAGE_SHIFT==12 => THREAD_SIZE == (1 << (12 + 1)) = 8KB
PAGE_SHIFT==13 => THREAD_SIZE == (1 << (13 + 1)) = 16KB
PAGE_SHIFT==14 => THREAD_SIZE == (1 << (14 + 1)) = 32KB

We get correct 16KB stack only when PAGE_SHIFT is 13.

See arch/arc/include/uapi/asm/page.h:
/* PAGE_SHIFT determines the page size */
\#if defined(CONFIG_ARC_PAGE_SIZE_16K)
\#define PAGE_SHIFT 14
\#elif defined(CONFIG_ARC_PAGE_SIZE_4K)
\#define PAGE_SHIFT 12
\#else
\#define PAGE_SHIFT 13
\#endif

See arch/arc/include/asm/thread_info.h:
\#ifdef CONFIG_DEBUG_STACKS
\#define THREAD_SIZE_ORDER 1
\#else
\#define THREAD_SIZE_ORDER 0
\#endif

\#define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
\#define THREAD_SHIFT	(PAGE_SHIFT + THREAD_SIZE_ORDER)

To make CONFIG_16KSTACKS less confusing, rename it to DEBUG_STACKS
(as it is defined in Kconfig.debug) and modify the Kconfig
description. No functional changes intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arc/Kconfig.debug             | 7 ++++---
 arch/arc/include/asm/thread_info.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arc/Kconfig.debug b/arch/arc/Kconfig.debug
index 45add86decd5..9a1e140605c4 100644
--- a/arch/arc/Kconfig.debug
+++ b/arch/arc/Kconfig.debug
@@ -1,10 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config 16KSTACKS
-	bool "Use 16Kb for kernel stacks instead of 8Kb"
+config DEBUG_STACKS
+	bool "Use double sized kernel stacks"
 	help
-	  If you say Y here the kernel will use a  16Kb stacksize for the
+	  If you say Y here the kernel will use a double sized stack for the
 	  kernel stack attached to each process/thread. The default is 8K.
+	  (depends on CONFIG_ARC_PAGE_SIZE_16K or CONFIG_ARC_PAGE_SIZE_4K)
 	  This increases the resident kernel footprint and will cause less
 	  threads to run on the system and also increase the pressure
 	  on the VM subsystem for higher order allocations.
diff --git a/arch/arc/include/asm/thread_info.h b/arch/arc/include/asm/thread_info.h
index 9f9dd021501c..a7358d1225a6 100644
--- a/arch/arc/include/asm/thread_info.h
+++ b/arch/arc/include/asm/thread_info.h
@@ -15,7 +15,7 @@
 
 #include <asm/page.h>
 
-#ifdef CONFIG_16KSTACKS
+#ifdef CONFIG_DEBUG_STACKS
 #define THREAD_SIZE_ORDER 1
 #else
 #define THREAD_SIZE_ORDER 0
-- 
2.34.1

