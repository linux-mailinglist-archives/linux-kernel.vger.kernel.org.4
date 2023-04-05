Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDAF6D7C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjDEL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjDEL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:59:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDCF19B2;
        Wed,  5 Apr 2023 04:59:52 -0700 (PDT)
Date:   Wed, 05 Apr 2023 11:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680695987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfKLvuagOWChq63eEh33ZdMW1yilj9ilbSG1CpfMTcQ=;
        b=R915ObUarSp604HUhbh7vYNUz+kDhI0QjT1txLO8AMyiOsjxNSL28OWC+BKbjAolRDIKsv
        N+z7nsz35Q7Tz0EfY0dRDWuekB0ZN6scdBgmwS9C/msnexxM3aQNx1yN9JArLo94ExlGxV
        1R2XpIYk/N9v8AetPpJlSKKCcYauAUADqaXfcnJUpgKpmIaCd8mI+IWQ2l1Sdmms/45xJI
        kaD6YeU3vMJhZIZ4MLTuyeHlOTBnY0MMC6922rkNejk+7jQLhfa525dRClzb7l4iV7jN0d
        XTxKfr628v0+FZHVRvWsK+i206TqSVvDzPi2GIYCvjHgcJrFHA3ef6NrbWmByw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680695987;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfKLvuagOWChq63eEh33ZdMW1yilj9ilbSG1CpfMTcQ=;
        b=7EGZpRpqMLLXRawIaHYmJ9yZBqQiH1OygNV0ys3WQ747AZkRJbwLMpYTjNJAabTAhUWrmv
        w8U4GF+FJTOwmhDg==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add model number for Intel Arrow Lake processor
Cc:     Tony Luck <tony.luck@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230404174641.426593-1-tony.luck@intel.com>
References: <20230404174641.426593-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <168069598684.404.14064362585512197712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     81515ecf155a38f3532bf5ddef88d651898df6be
Gitweb:        https://git.kernel.org/tip/81515ecf155a38f3532bf5ddef88d651898df6be
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 04 Apr 2023 10:46:41 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Apr 2023 13:36:26 +02:00

x86/cpu: Add model number for Intel Arrow Lake processor

Successor to Lunar Lake.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230404174641.426593-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index cbaf174..b3af2d4 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -125,6 +125,8 @@
 
 #define INTEL_FAM6_LUNARLAKE_M		0xBD
 
+#define INTEL_FAM6_ARROWLAKE		0xC6
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
