Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908CE72CAF6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjFLQFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjFLQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:05:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B913C4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 09:05:05 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B23AC1EC072D;
        Mon, 12 Jun 2023 18:05:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686585903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IZpLNOqSbDuZpKhS2q1odsHPxnz/htzzGl6mBP3wM0E=;
        b=Mpb6pTpYSJICayZuP28qQgZPhSzA8+LCiU/Ao7NFrmdGFledf57H77l5A+9F+cVD0l6Zmk
        F3XXWht4hXQdRtrtdiBFTgMukACbE4epTWD4nS5QKLouXdA4N47zvDsbSbTSHvaYiSslX9
        6X6kE7QogopUSxYRsNuDkWArpJVgk2E=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WHUnk5Q3Np4X; Mon, 12 Jun 2023 16:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686585901; bh=IZpLNOqSbDuZpKhS2q1odsHPxnz/htzzGl6mBP3wM0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=McRicWcMlD8YGuPmFEP/HrLQXF4MIkQ681/tGBzFolOHgP/X1j/GFlFo39f7sQFb/
         rr0w7aIM4WAeStEgpgZ9YW8IXlK+GGS+43aXZMnwfAAsTkT/FcuTvXyiEnpJM6Szhv
         KTkpOUjx79rqt4MFseUMLrW1D8BmNHEj2S6qofkJfwz8Y/gHf+ZRK/uY0edq8mIZd6
         YtevUWcI2/IuTNeaC+uxIy/x9Vx187wAkMdEaT/1eCrSSWhQCb+FZ7mDkOTXFLW7+o
         pNsYHavtgS2lCrojT49jgFOHlpS3BMhrtmXOa3ILeMTyGneHq2exqjT4Wk0OlIuoRl
         CeZi0AcZZ0lgx+fW0B60XvGS4WfRPpadZ8A7g1ppdzHNG8vwZLmrqAcl+Qoob5NA9i
         CQXqpu96vVHvFJ1/aFIXa2W8+XquspYrGbJk5qTdFZvYBJspVf9rB7K0ti9GNxTfYU
         cen9ozZjmS4Qu8Ocmbxcta+V7s2YgvUD9q91XzlGEkPKrNeZkpOj5YPxEyf7KuODkY
         xmZ7lLsV8Ys6FKqpPTRDY/DVmhiXpAO5dxBxySnPcJzKT3zaq9d/wbNrX6haqBVj/8
         lWhN7DGyABHKxDYngXP0DZODlA2Q75Ux9MP229OfiBmJwXkGppnvuTiQP44LjAUGKH
         2YOos6ID+Hdrj4cbauKRRlLc=
Received: from zn.tnic (p200300ea971dc5F0329C23FfFEa6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f0:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A4D940E01D0;
        Mon, 12 Jun 2023 16:04:58 +0000 (UTC)
Date:   Mon, 12 Jun 2023 18:04:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add a "microcode=" command line option
Message-ID: <20230612160453.GMZIdCJfmI2sCRxCFX@fat_crate.local>
References: <20230605141332.25948-1-bp@alien8.de>
 <20230605141332.25948-2-bp@alien8.de>
 <87ilbs7lcr.ffs@tglx>
 <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230612154246.GLZIc89v6Q2THgsY8N@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diff ontop with the proposed changes so that they're easily reviewable:

---
diff --git a/Documentation/arch/x86/microcode.rst b/Documentation/arch/x86/microcode.rst
index b627c6f36bcf..767e3e36935e 100644
--- a/Documentation/arch/x86/microcode.rst
+++ b/Documentation/arch/x86/microcode.rst
@@ -238,3 +238,13 @@ the final kernel image. The early loader finds them and applies them.
 Needless to say, this method is not the most flexible one because it
 requires rebuilding the kernel each time updated microcode from the CPU
 vendor is available.
+
+Loader control
+==============
+
+/sys/devices/system/cpu/microcode/control controls different aspects of
+the microcode loader's behavior and can be used to modify it by toggling
+bits in that file. Currently defined controls are:
+
+bit 0:  Do not load on all SMT threads on AMD. Loading on all logical
+        threads is enabled by default.
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 76b530697951..3755f4a3c820 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -703,7 +703,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 
 	/* need to apply patch? */
 	if ((rev > mc_amd->hdr.patch_id) ||
-	    (rev == mc_amd->hdr.patch_id && !(control & LATE_ALL_THREADS))) {
+	    (rev == mc_amd->hdr.patch_id && !(microcode_control & LATE_ALL_THREADS))) {
 		ret = UCODE_OK;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5f3185d2814c..7ec87872756b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -47,7 +47,7 @@
 static struct microcode_ops	*microcode_ops;
 static bool dis_ucode_ldr = true;
 
-unsigned long control = LATE_ALL_THREADS;
+unsigned long microcode_control = LATE_ALL_THREADS;
 
 bool initrd_gone;
 
@@ -529,7 +529,7 @@ static ssize_t processor_flags_show(struct device *dev,
 static ssize_t control_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "0x%lx\n", control);
+	return sprintf(buf, "0x%lx\n", microcode_control);
 }
 
 static ssize_t control_store(struct device *dev,
@@ -544,7 +544,7 @@ static ssize_t control_store(struct device *dev,
 	if (val & CONTROL_FLAGS_MASK)
 		return -EINVAL;
 
-	control = val;
+	microcode_control = val;
 
 	return count;
 }
@@ -722,7 +722,7 @@ static int __init parse_cmdline_param(char *str)
 		str++;
 
 	if (!strcmp(str, "no_late_all"))
-		control &= ~LATE_ALL_THREADS;
+		microcode_control &= ~LATE_ALL_THREADS;
 
         return 1;
 }
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 5e3c5fc3851f..3823c8ec8f97 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -2,7 +2,7 @@
 #ifndef __X86_MICROCODE_INTERNAL_H__
 #define __X86_MICROCODE_INTERNAL_H__
 
-extern unsigned long control;
+extern unsigned long microcode_control;
 
 /* Loader control flags. */
 enum control_flags {

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
