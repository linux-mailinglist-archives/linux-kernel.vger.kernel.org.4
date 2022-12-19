Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38D650A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 11:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiLSKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 05:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiLSKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:25:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FAD2BFF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d3so8543862plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 02:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuxPSSo3Y0HNcsTRiv4LvjgP5Z2vwZbV6xJtY/KrG9Q=;
        b=iF+qURoE+eCvIhH+hu11xDlB1z41T3hUX0eRuYMR58bqJYsHsO6szJg+DZ0pgRz+wZ
         i5fI07gMXNCVwPsbIoCJjldV6Lt0jxuXmy0716NkGPWBlvmfUyZtC3AJ/nIpRwRrApm/
         LjP9YyU7DMAGOKmaPhTxJyKGBaKPSFDooPoWgIBXTHa13GS8+DEN5wC7oWsNG2R0+/fJ
         kPb875U6gTeSe94NgDhGXPRwvzmBd7YqzJr6k+cM3sUUzigRoNQlsY/LKV84pTN7tApQ
         ZPGsGx0ao31/3sSiXBpLLjkFN1ED0R2Gk8fGBB09JcvLEAkQnIXpbwg7k2Vk2dhdLxzq
         p9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuxPSSo3Y0HNcsTRiv4LvjgP5Z2vwZbV6xJtY/KrG9Q=;
        b=POgU/4eHP33MknX3pUvUNuv3uSW9vZlpHfucRsMbXkpbWNGcQW/AuSVZOMyTXyk3iC
         KXCzCBLBzHlkHwPlFdFhBf3pFvX445eRli6f+Y87dsKjVfSj3g7609L71yaUx4ESol1+
         ZfAUoQbstrHFG20vcL5VWLVCLFL65uee6+3EYHyhl9IzYpG6EDdxPUcFlX3ynJbtTQWD
         H8IwP6+m/2AW0c+15/7LlhefYOxHsXIBvza7kar0m9xU6a6LjfmZX/YYt+LCpb1IjbNb
         DthwBkG7xLfjpmT+/0TLeOqhR0CMXZTLeUalyhAHdu7+EJWB62qFwUOC6ILNNqGHYSpx
         cZjw==
X-Gm-Message-State: ANoB5pne5JvpZRQ6UQOEk9XAlLqcUmci0sqJnvJ9y64T9UdxnRq/ih5I
        NxQQppmRmImwcqAcVu4O6FFcXQ==
X-Google-Smtp-Source: AA0mqf4GEGyKCoOt8J5bSCi51BhHaNtnFoTfzPjm6BU4YFeOTo96NYOksytiio/BBbWX+8uXBHIM1Q==
X-Received: by 2002:a17:90a:e147:b0:219:17bb:b854 with SMTP id ez7-20020a17090ae14700b0021917bbb854mr42684134pjb.29.1671445511662;
        Mon, 19 Dec 2022 02:25:11 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.5])
        by smtp.gmail.com with ESMTPSA id 89-20020a17090a0fe200b0020087d7e778sm8832731pjz.37.2022.12.19.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:25:11 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        daniel.thompson@linaro.org, dianders@chromium.org
Cc:     liwei391@huawei.com, mhiramat@kernel.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Mon, 19 Dec 2022 15:54:52 +0530
Message-Id: <20221219102452.2860088-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219102452.2860088-1-sumit.garg@linaro.org>
References: <20221219102452.2860088-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the first attempt to single-step has any effect. After
that all further stepping remains "stuck" at the same program counter
value.

Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
PSTATE.SS=1 should be set at each step before transferring the PE to the
'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
since the second single-step.

After the first single-step, the PE transferes to the 'Inactive' state,
with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
kernel_active_single_step()=true. Then the PE transferes to the
'Active-pending' state when ERET and returns to the debugger by step
exception.

Before this patch:
==================
Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb>

[0]kdb>
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
    is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb>

After this patch:
=================
Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
    is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
[1]kdb>

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Co-developed-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/include/asm/debug-monitors.h | 1 +
 arch/arm64/kernel/debug-monitors.c      | 5 +++++
 arch/arm64/kernel/kgdb.c                | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 7b7e05c02691..ce3875ad5cd3 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_regs_reset_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 3da09778267e..9af898b22ed4 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_regs_reset_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index cda9c1e9864f..51f204bbcf87 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -224,6 +224,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		 */
 		if (!kernel_active_single_step())
 			kernel_enable_single_step(linux_regs);
+		else
+			kernel_regs_reset_single_step(linux_regs);
 		err = 0;
 		break;
 	default:
-- 
2.34.1

