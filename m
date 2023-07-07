Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23D674AF8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjGGLNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjGGLNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:13:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCDF1725;
        Fri,  7 Jul 2023 04:13:09 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-262e89a3ee2so1014160a91.1;
        Fri, 07 Jul 2023 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688728389; x=1691320389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCeaBwwnL9DCj9UeLPeRZVKmRBU2WViNtAg6co3DJFU=;
        b=EvYbNQZ7Z0nuMmbMS9PayRs1QzXKDcVz0fdG8FV8B4f6P0vHIaGn2U7t+cz/fIUNzc
         0ivxr1dCHz7IkmxokpgazvT0BZzHf3QpD7ivS1B3R15RZJNEREPnna2YJy463WJ4QHSI
         XrelnsSmrnZGvVk61SC3BTNtxiwT7epYBmc5wLLsc77tjKB4Q/9LGjlh3zF84YJ9HHAI
         feDcwOUYtWiNPGVhmKbgQOfgOzW+MrGifoAJTtl3MzHoy/R66DezlMYoVEHnNlQubCng
         kIIbbgrkVIaBZDAcCI5A0XduORV7QsSQcnPVjarOOTVtQlgvsuo+7K/WZDI1sUYa+7ft
         cy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688728389; x=1691320389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCeaBwwnL9DCj9UeLPeRZVKmRBU2WViNtAg6co3DJFU=;
        b=DO0EX1mQT6PvAMKtRB1pQ4eZxkMNUL5UEQaiilxiytxqDs0b550s088yUvLEiZp/vp
         YMbrloMOkTlvgPRU1dKMnkth+fv+KE39sGYHEK6Gc70pBvBK6vYkBzg3Hj49lLvErgnU
         ojuyJC9V5+uFBJ5Qciy4Gz2bh8fNSKDP6IYFF40Qc4BkfqBgvZ1PnXVoUW2YCvCkWTQc
         u6n79VUY1Rn+sFrJnSHaSXR/6E4vqn2JAB+kzN0zQjh7QMENqcJNp6QgHziXli3rUNqC
         RAlFblOjl6TBs2lcjsPx4HgB6qqIS0uJ7MT0b9QkkXb8bhX854xHcSfZyfGd9/IltaXP
         mKbA==
X-Gm-Message-State: ABy/qLYfELKKZ0t4VF7sO76CbfSpn/zidCsGsNtERtEpPqBfvK3Arnb8
        y+rmuMU+br6mdwkDMyjW+u9jq8djbrYjsw==
X-Google-Smtp-Source: APBJJlGzaJDo9yCUmKmo3Y/PpyOZ1LyWMRzRHSjSYXyLfXoio8q6lqyaSySH30bDCUK2Cn/gsvb5eg==
X-Received: by 2002:a17:903:1246:b0:1b8:17e8:5475 with SMTP id u6-20020a170903124600b001b817e85475mr4728619plh.24.1688728388737;
        Fri, 07 Jul 2023 04:13:08 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902744c00b001b8c8d06285sm1985639plt.122.2023.07.07.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 04:13:08 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 2/2] MIPS: loongson32: Remove regs-rtc.h
Date:   Fri,  7 Jul 2023 19:11:51 +0800
Message-Id: <20230707111151.461373-3-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707111151.461373-1-keguang.zhang@gmail.com>
References: <20230707111151.461373-1-keguang.zhang@gmail.com>
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

Since commit 9fb23090658a ("rtc: Remove the
Loongson-1 RTC driver"), no one is using regs-rtc.h.
Therefore, remove this obsolete header file.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-rtc.h    | 19 -------------------
 2 files changed, 20 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-rtc.h

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index bc27fcee3176..84f45461c832 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -46,6 +46,5 @@
 #define LS1X_CLK_BASE			0x1fe78030
 
 #include <regs-mux.h>
-#include <regs-rtc.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-rtc.h b/arch/mips/include/asm/mach-loongson32/regs-rtc.h
deleted file mode 100644
index a3d096be1607..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-rtc.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
- *
- * Loongson 1 RTC timer Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_RTC_H
-#define __ASM_MACH_LOONGSON32_REGS_RTC_H
-
-#define LS1X_RTC_REG(x) \
-		((void __iomem *)KSEG1ADDR(LS1X_RTC_BASE + (x)))
-
-#define LS1X_RTC_CTRL	LS1X_RTC_REG(0x40)
-
-#define RTC_EXTCLK_OK	(BIT(5) | BIT(8))
-#define RTC_EXTCLK_EN	BIT(8)
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_RTC_H */
-- 
2.39.2

