Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2B725C12
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239776AbjFGKwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbjFGKwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:52:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E31BF7;
        Wed,  7 Jun 2023 03:52:13 -0700 (PDT)
Date:   Wed, 07 Jun 2023 10:52:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686135127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6HYOm/5r4qtLnMuHCxa7nXtynzN3N5U+Whb5yp1Uys=;
        b=jMqFIdPldV1QOyFTyvgOEx49TmdZrxoCSPxYoBe/Gznx/ZXWBExzHWg4oOOAuuleqfuF/J
        202b4G+aCTRIwL8JbRLR/OGc/3/gNVjPHqR7w3ApZwS2J+Nh3szCAZaDwxNsJzfZCf37dl
        TKLTmGWD8QoePWoTos4NOQ4wlwSVTYr/dRlOxsYxmFgyllM4adBvOTMBmMSCrjXYbTxX6a
        IXgQVNwflp2/lcloK2TxdsOtwk2p29hcxTXikCKK1+nPcMbaI7tWQmqHsJqUaYM2Q0DUbW
        sike3YsQJRd4IPnY0VkJGaxjDzspf+Nsm+43DrFs4MuLMZ+SeGk4Wg5UyPmTXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686135127;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6HYOm/5r4qtLnMuHCxa7nXtynzN3N5U+Whb5yp1Uys=;
        b=eDhaQtlHcTxQLsoq/XDsaqqQDeZbkeMNTd33eqHgs6GL+ExBL0qSVB/tEs/TGB3nBtZMSX
        pSO1ErVPN6CmuoBg==
From:   "tip-bot2 for Peter Newman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] Documentation/x86: Documentation for MON group move feature
Cc:     Peter Newman <peternewman@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230419125015.693566-4-peternewman@google.com>
References: <20230419125015.693566-4-peternewman@google.com>
MIME-Version: 1.0
Message-ID: <168613512697.404.616009463445838312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e0a6ede2dd884adb73a7dde80444185b655f7c79
Gitweb:        https://git.kernel.org/tip/e0a6ede2dd884adb73a7dde80444185b655f7c79
Author:        Peter Newman <peternewman@google.com>
AuthorDate:    Wed, 19 Apr 2023 14:50:15 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 07 Jun 2023 12:42:12 +02:00

Documentation/x86: Documentation for MON group move feature

Describe new support for moving MON groups to a new parent CTRL_MON
group and its restrictions.

Signed-off-by: Peter Newman <peternewman@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/20230419125015.693566-4-peternewman@google.com
---
 Documentation/arch/x86/resctrl.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index 387ccbc..cb05d90 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -287,6 +287,13 @@ Removing a directory will move all tasks and cpus owned by the group it
 represents to the parent. Removing one of the created CTRL_MON groups
 will automatically remove all MON groups below it.
 
+Moving MON group directories to a new parent CTRL_MON group is supported
+for the purpose of changing the resource allocations of a MON group
+without impacting its monitoring data or assigned tasks. This operation
+is not allowed for MON groups which monitor CPUs. No other move
+operation is currently allowed other than simply renaming a CTRL_MON or
+MON group.
+
 All groups contain the following files:
 
 "tasks":
