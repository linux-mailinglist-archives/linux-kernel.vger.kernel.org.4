Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6E72BBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjFLJKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjFLJJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:09:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E8E44BF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:04:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686560680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qLQa4feGJ3EEuc/ZE7iasB23VVOA8T8k3VYDwcq3txU=;
        b=IOTNY+nAOBT6LI+9nY3BLhayqFMcMitNSFec/rJuCi1eQ8/2/Y6fhSYzK5qVzyPXUr1vgy
        5EECtMErlilI44uZUrlK417a80umWalD0DeqI7td67LA6lOTqHPOxRVDr6u6w4MNcgwjgP
        YoiyIrTo61bu1soHXDZZuzBvJD3O5MBVe+C1Qduysz4iH5P3b5IC6CyvOG5pG/NeLmRH2x
        f/98JInm+cba499Myn0KcF0KZBSTRXKuDoxdeznz9rI6H1qpTjxt4BFw8QVQYAWAYvupaf
        ruWl8fX0QANGTuXG3opYNxgqMd8FQhFDsf5ZntY8bqGmncPuxYbu6BJxZA35kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686560680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qLQa4feGJ3EEuc/ZE7iasB23VVOA8T8k3VYDwcq3txU=;
        b=9GwZbATW69HXz2bitwftHRK9VVKbLdywzJSAV7IZTau1XmEvlvJI55oIFVe1f4ZmFjSJiR
        lMViPcmpxoUIkeBg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] MAINTAINERS: Add CPU HOTPLUG entry
Date:   Mon, 12 Jun 2023 11:04:39 +0200
Message-ID: <87o7ll6ogo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the status quo and add myself and Peter as CPU hotplug
maintainers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 MAINTAINERS |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5356,6 +5356,18 @@ F:	Documentation/driver-api/pm/cpuidle.r
 F:	drivers/cpuidle/
 F:	include/linux/cpuidle.h
 
+CPU HOTPLUG
+M:	Thomas Gleixner <tglx@linutronix.de>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
+F:	kernel/cpu.c
+F:	kernel/smpboot.*
+F:	include/linux/cpu.h
+F:	include/linux/cpuhotplug.h
+F:	include/linux/smpboot.h
+
 CPU POWER MONITORING SUBSYSTEM
 M:	Thomas Renninger <trenn@suse.com>
 M:	Shuah Khan <shuah@kernel.org>
