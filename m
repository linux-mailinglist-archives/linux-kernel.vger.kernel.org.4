Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2291E68BD6A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjBFNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjBFNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:00:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC323329;
        Mon,  6 Feb 2023 05:00:09 -0800 (PST)
Date:   Mon, 06 Feb 2023 13:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPPSWF1IR2b3xSpi294gSyVTszfWLwynEyv+R7qzIpM=;
        b=x/Xwi1fALjBqNYEHLVG22nlw03tsfhyL5Fr6JnQke2X5IdLuK22/Fws+yPdUWaGRule0qx
        uw3hHewaOGTuIbhN8zeUj+bc8O0leL+nBOe0c+462Q+4KOYgEvvI7dHf8GuFCmCkMenMJ4
        gPEovob00xjkDKrYEwcQj74HDZYwfj+ccTa5nHe+/0sr6IVz/WFriCbjYoYuk/hQkp3RDX
        Tf1ZAKoxJlaZDgv8GLxq+5D0YpLpOkgtg11CRctuE9a4hkteZafabfzV4oGY3VMkbJzi2W
        8XYXesMOMODLIxP95E+VOefPp+/uvBapaSTTvtu3ZUOlyZzpeIb1SVZy8rtS/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675688406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPPSWF1IR2b3xSpi294gSyVTszfWLwynEyv+R7qzIpM=;
        b=pjny2TDUwOkKx8H/FTCDpQfLlAXMjvoS1lhDXanTx9EjAdKcXPSxD2FCn4RBjB6NfqNdn3
        B4ThcAy2ft0XTSDQ==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Remove load_microcode_amd()'s
 bsp parameter
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230130161709.11615-2-bp@alien8.de>
References: <20230130161709.11615-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <167568840642.4906.3159553171121184156.tip-bot2@tip-bot2>
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

Commit-ID:     2355370cd941cbb20882cc3f34460f9f2b8f9a18
Gitweb:        https://git.kernel.org/tip/2355370cd941cbb20882cc3f34460f9f2b8f9a18
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 17 Jan 2023 23:59:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Feb 2023 11:13:04 +01:00

x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter

It is always the BSP.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230130161709.11615-2-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index d144f91..c2ac6c4 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -553,8 +553,7 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 	early_apply_microcode(cpuid_1_eax, cp.data, cp.size, false);
 }
 
-static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 {
@@ -572,7 +571,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(true, x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
@@ -851,8 +850,7 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-static enum ucode_state
-load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
 	struct ucode_patch *p;
 	enum ucode_state ret;
@@ -876,10 +874,6 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
 		ret = UCODE_NEW;
 	}
 
-	/* save BSP's matching patch for early load */
-	if (!save)
-		return ret;
-
 	memset(amd_ucode_patch, 0, PATCH_MAX_SIZE);
 	memcpy(amd_ucode_patch, p->data, min_t(u32, p->size, PATCH_MAX_SIZE));
 
@@ -906,14 +900,9 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
-	bool bsp = c->cpu_index == boot_cpu_data.cpu_index;
 	enum ucode_state ret = UCODE_NFOUND;
 	const struct firmware *fw;
 
-	/* reload ucode container only on the boot cpu */
-	if (!bsp)
-		return UCODE_OK;
-
 	if (c->x86 >= 0x15)
 		snprintf(fw_name, sizeof(fw_name), "amd-ucode/microcode_amd_fam%.2xh.bin", c->x86);
 
@@ -926,7 +915,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device)
 	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
 
-	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
+	ret = load_microcode_amd(c->x86, fw->data, fw->size);
 
  fw_release:
 	release_firmware(fw);
