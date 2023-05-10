Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DF76FDB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbjEJKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJKTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:19:23 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E15F213B;
        Wed, 10 May 2023 03:19:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aae5c2423dso68513475ad.3;
        Wed, 10 May 2023 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683713961; x=1686305961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1t0ft/AfuKy/xQMa6et8iuTG4wcZxNYRj+6RIhEHQg=;
        b=QIn7qQyGu9KHA02ujG7t9C/xbo/Tw2O/IeCeYI61VMn9+jgbUaZbg1NtaoLSGqn1Ok
         Xe90gJ+r3SRKeS34/7oOM6jvIbWyhjhQ/TvzKX6rIy9BTF3CMXtkrrWy8ohl+giADPhq
         N/uoad4SmyQsBNdlpRe+/e+PFgXOvrjakYFTyPhROB+6YkVl1Jyd8sllHP1QeKv2Q9nD
         K/19jMnBenBArM/nj0/uPipZfqw5hvKKQZGLnpG5m07w8IEpB2hOqFPpc27RAxFlAgbJ
         H55faVr/w8momTJ96c0CYKQ74gDk+ttrdT+UYy6xk3yNrVyIkQpf9tAG9gFUZ8c8hv4Z
         cPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713961; x=1686305961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1t0ft/AfuKy/xQMa6et8iuTG4wcZxNYRj+6RIhEHQg=;
        b=QFCXtWg3CESiRfjkku2OPmxqCAMqiCGC/85paW9CYzGLc8Sj01Wmy7HgPknZIGJBjo
         4MbPf3SF5MX6d2qMHzL0R6r/5QDHpL6pydkajsCVmOa4IC9xrRBz5mdwFReh7hMVitjn
         bQBabvfZEU25fKTB7WMYJ5I08qFZMf0mbL4FMSPZMDBjJwT4OBp9SQNwyV6stSZjXKkb
         x/d4cGoB7c3VcgOMC6wfxcKzmPaqCAb3Z8Pilj5JKEsWQz23Au2TEypUPdTDddjjttGo
         N4p47yLblkcYQ6pzu36nkLi3HlebEYLf6txxTQub/7hamdrN5hqpBpSZCtP8qBHeTpi/
         cizQ==
X-Gm-Message-State: AC+VfDxJiG93xcWPn6dT6NULFqX6zUL+dvcV1WyMPS8Xxm8r59R0gGyi
        PVN9sTjMzAEkUPz1RK18Ru0=
X-Google-Smtp-Source: ACHHUZ67FWUbYYJrDsy2nIlpJYZhkPsodT3ItqoRkKPrzKQ+qLZzU8rxzk62MZG7RanBjvpefi6vIA==
X-Received: by 2002:a17:902:d3c6:b0:1a9:7e44:17 with SMTP id w6-20020a170902d3c600b001a97e440017mr15067440plb.17.1683713961643;
        Wed, 10 May 2023 03:19:21 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001aadd0d7364sm3393419plf.83.2023.05.10.03.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 03:19:21 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, guoren@kernel.org, suagrfillet@gmail.com,
        jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH V9 1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Wed, 10 May 2023 18:18:54 +0800
Message-Id: <20230510101857.2953955-2-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230510101857.2953955-1-suagrfillet@gmail.com>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In RISC-V, -fpatchable-function-entry option is used to support
dynamic ftrace in this commit afc76b8b8011 ("riscv: Using
PATCHABLE_FUNCTION_ENTRY instead of MCOUNT"). So recordmcount
don't have to be called to create the __mcount_loc section before
the vmlinux linking.

Here selects FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell
Makefile not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 348c0fa1fc8c..e0632493482f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -58,6 +58,7 @@ config RISCV
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.20.1

