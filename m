Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B651616726
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiKBQJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKBQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:09:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D52AE26;
        Wed,  2 Nov 2022 09:09:00 -0700 (PDT)
Date:   Wed, 02 Nov 2022 16:08:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667405339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1FAlv6BaRdWMZ19J6/1iAkBSs5gOogmElo5HpncE5g=;
        b=VllIqhRmI4xt8omBEdoXIGNt/HPUQePeAtfPSg+gf+riL5mn8hzZRNn1ESgXBgWwS+A6ze
        J91IoEULkGgQSPyJv4BNFf7K50W/fCSxrd3TyNUOEEu6aE1Cq94uIRV8paclft/htYyyRL
        YDLNmrJIBY1bEvXG66ZzHTGsTDfsg1qaLxhWpNoZWar2VMWxQqbwsCtoTftUI1wtL2qJXL
        p3XyZA7lMy3WzabJsLK6uA3E7N8UB2H8I7MW6JRgQobzYJHK6Sh7PAzw/Pl+CElPWvlKj5
        BRGbATItPllG1dTaKSScbun2tFjSgIXU3rdMfexEvmRDMmxqB5YKUe2lO/X6cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667405339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I1FAlv6BaRdWMZ19J6/1iAkBSs5gOogmElo5HpncE5g=;
        b=IcA3HNNvkUaBnnTwHlrsoanhFPfXWzZAvnN6qZU+Dj/hdBoaBcj/ObD+XOfmjQ21uxU/rS
        qAo5XeSvkl7f/jBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Kill refresh_fw
Cc:     Borislav Petkov <bp@suse.de>, Ashok Raj <ashok.raj@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221028142638.28498-4-bp@alien8.de>
References: <20221028142638.28498-4-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <166740533816.6127.12948035265909446351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     a61ac80ae52ea349416472cd52005f9988537208
Gitweb:        https://git.kernel.org/tip/a61ac80ae52ea349416472cd52005f9988537208
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 19 Oct 2022 19:16:20 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 02 Nov 2022 16:45:46 +01:00

x86/microcode: Kill refresh_fw

request_microcode_fw() can always request firmware now so drop this
superfluous argument.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Link: https://lore.kernel.org/r/20221028142638.28498-4-bp@alien8.de
---
 arch/x86/include/asm/microcode.h      | 3 +--
 arch/x86/kernel/cpu/microcode/amd.c   | 5 ++---
 arch/x86/kernel/cpu/microcode/core.c  | 2 +-
 arch/x86/kernel/cpu/microcode/intel.c | 3 +--
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 74ecc2b..d4c36fb 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -33,8 +33,7 @@ enum ucode_state {
 };
 
 struct microcode_ops {
-	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
-						  bool refresh_fw);
+	enum ucode_state (*request_microcode_fw) (int cpu, struct device *);
 
 	void (*microcode_fini_cpu) (int cpu);
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index e7410e9..b103d5e 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -891,8 +891,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
  *
  * These might be larger than 2K.
  */
-static enum ucode_state request_microcode_amd(int cpu, struct device *device,
-					      bool refresh_fw)
+static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -901,7 +900,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || !bsp)
+	if (!bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 63f7678..7c41e01 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -477,7 +477,7 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
-	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
+	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1fcbd67..8c35c70 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -885,8 +885,7 @@ static bool is_blacklisted(unsigned int cpu)
 	return false;
 }
 
-static enum ucode_state request_microcode_fw(int cpu, struct device *device,
-					     bool refresh_fw)
+static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
