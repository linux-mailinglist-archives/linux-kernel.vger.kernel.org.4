Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4036671EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjALMR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjALMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:16:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59017E03;
        Thu, 12 Jan 2023 04:16:35 -0800 (PST)
Date:   Thu, 12 Jan 2023 12:16:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hr+mul0VJvJPxTMVnhQxshphmnggQlorZscW78II/0=;
        b=kPjFTr/F0xG+xoWcUdyDbnXhkvQb+qsFkW4C9J6RmDqDG0EC4f67SxlII9+3q9GnxTfgaQ
        /NXf1oq0WtWqHyEkxzmUv2G1UnoZl0VbPSrFyQcHGQgtm0dQmG5KqK3vyL8FirdU4XZPKn
        9Xm6OIBQmNYWMJZuw8XwSUL8sW4u25oFwgqTEdZxFSjCKM6M9XblUamXz+2J+UoMhBeo9Y
        0X+8vo6NwGSx0zzitLkxeDbL56TsQNXpeMPKDbejwyDxsDJxbKfAB5Us0iQahqIvra6XAT
        41R//tBuJvhDkjFqmMiA45VyPjS9lcwmoblwKSravcwcEqo+J1n2k4NP2EfI9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673525793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hr+mul0VJvJPxTMVnhQxshphmnggQlorZscW78II/0=;
        b=zK7doBv+U/U4h6rwJH3LWjpV+/xUKplVadGQUXomDDiCXec251NlZgDSFK2dLm6un0AetL
        uOTzR3oL3qahQFCg==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/opcode: Add the LKGS instruction to x86-opcode-map
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Xin Li <xin3.li@intel.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230112072032.35626-3-xin3.li@intel.com>
References: <20230112072032.35626-3-xin3.li@intel.com>
MIME-Version: 1.0
Message-ID: <167352579311.4906.18357560247476615841.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     5a91f12660fe7249e37b11372bf599e02b6a319c
Gitweb:        https://git.kernel.org/tip/5a91f12660fe7249e37b11372bf599e02b6a319c
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Wed, 11 Jan 2023 23:20:29 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 12 Jan 2023 13:06:36 +01:00

x86/opcode: Add the LKGS instruction to x86-opcode-map

Add the instruction opcode used by LKGS to x86-opcode-map.

Opcode number is per public FRED draft spec v3.0.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230112072032.35626-3-xin3.li@intel.com
---
 arch/x86/lib/x86-opcode-map.txt       | 1 +
 tools/arch/x86/lib/x86-opcode-map.txt | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index d12d135..5168ee0 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1047,6 +1047,7 @@ GrpTable: Grp6
 3: LTR Ew
 4: VERR Ew
 5: VERW Ew
+6: LKGS Ew (F2)
 EndTable
 
 GrpTable: Grp7
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index d12d135..5168ee0 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1047,6 +1047,7 @@ GrpTable: Grp6
 3: LTR Ew
 4: VERR Ew
 5: VERW Ew
+6: LKGS Ew (F2)
 EndTable
 
 GrpTable: Grp7
