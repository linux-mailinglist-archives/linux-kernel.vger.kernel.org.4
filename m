Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5506B525B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCJUzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjCJUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F5132AAD;
        Fri, 10 Mar 2023 12:54:52 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj2T3nHSCII61UuobKMd/VFouyrRUA6umpKg7ruRMN8=;
        b=dFsCECxxzfvFqlgummr5MJYonAI9YRK4qLzf8/9fz8cVeipbjG2IA/Sox1h9Bb5ibq98PC
        tsHMtPd9n6IkinaR6WyfPsVpdloXQ4WK1fX1XByTEtetDOg7LXsa1h/ac6BO5GXHjuVOhi
        iMaIc7LTlJvThy5/Mun+9jSS9NlBvCPeQjcpIXZ6n3o7RyeMR9YMe6Bw47LtKgGWToYDVM
        0Xj4gcFHE71U3qcNckEs9Cd5RQHiL/aA3FYZuATyOsHK4t8E4pqbB5SiRiA63ZAW9Yv/gL
        lvhmVFw7iigr7zVmNDZssav6F7fQn1rKSnnAIKT1jAOh2WmONPl4VYYy8JUWXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481690;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uj2T3nHSCII61UuobKMd/VFouyrRUA6umpKg7ruRMN8=;
        b=ryHx5q8F79CVToReuXvNlsSZ9hlNuIsGesLRZL8PEAzsyscOOevENSC1ryculv8O1627nx
        EVYcHzYBqBgh5/Dw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] sh/cpu: Expose arch_cpu_idle_dead()'s prototype
 definition
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <3d9661e97828fb464a48d4becf18f12604831903.1676358308.git.jpoimboe@kernel.org>
References: <3d9661e97828fb464a48d4becf18f12604831903.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169026.5837.13626680006663400128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     fd49efb3c75475b65d7541ee40603498807ff110
Gitweb:        https://git.kernel.org/tip/fd49efb3c75475b65d7541ee40603498807ff110
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:49 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:25 -08:00

sh/cpu: Expose arch_cpu_idle_dead()'s prototype definition

Include <linux/cpu.h> to make sure arch_cpu_idle_dead() matches its
prototype going forward.

Link: https://lore.kernel.org/r/3d9661e97828fb464a48d4becf18f12604831903.1676358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/sh/kernel/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 3418c40..114f0c4 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 2002 - 2009  Paul Mundt
  */
+#include <linux/cpu.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mm.h>
