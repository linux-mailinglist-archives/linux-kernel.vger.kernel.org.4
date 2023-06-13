Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8472DBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbjFMIDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjFMIDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:03:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC219B5;
        Tue, 13 Jun 2023 01:02:51 -0700 (PDT)
Date:   Tue, 13 Jun 2023 08:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686643369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YpJn7ym7O+kUFtJNN1uSkvsegGCM6j+jfCyCTBlrxM=;
        b=rQG7TQY/8f4Gxoz42JdNmfPEw3qpEH4kl5pIFztaumvpSgY7FkjAtA3UwpMNTeAYuHVP5D
        Iscr7R7nxVL+P+L8qxecO1YrUaX8dn4Ctjf9n1Jk5qVnUCBZmmEP9w7PVopEA890HZ1mQc
        wTBesJVXZhduElCl6Ce1jJRqGzJSrjFSMAPYcEb7pjDCh0LIehwYxfwp7irIoGETW6ZbDL
        CQ5klr4Xqie/qY6Cgd8Q1jV4WmfJy333E6WxrraDZVul5rOTCo5M4eQ0KAxST1NhSUfxpQ
        ip+eixvIkzVRRAH4vNy+u99RxEB17xGNofIPSLoX8GaI/hfS61shXjgKK3mUmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686643369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/YpJn7ym7O+kUFtJNN1uSkvsegGCM6j+jfCyCTBlrxM=;
        b=BTtY1GEHqBQPSDaJlvoQtvBtA2T4zK/KJNO8DptrEluiVG2nUlFioCxDunNDHopDaW/6Bj
        bh4LjTAByLhxrrCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] MAINTAINERS: Add CPU HOTPLUG entry
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87o7ll6ogo.ffs@tglx>
References: <87o7ll6ogo.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168664336821.404.8200536168212514927.tip-bot2@tip-bot2>
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

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     60be49bdf1d4ddb9e2deb7aa718d5b8bc167ee4e
Gitweb:        https://git.kernel.org/tip/60be49bdf1d4ddb9e2deb7aa718d5b8bc167ee4e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 12 Jun 2023 11:04:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Jun 2023 09:57:18 +02:00

MAINTAINERS: Add CPU HOTPLUG entry

Document the status quo and add myself and Peter as CPU hotplug
maintainers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/87o7ll6ogo.ffs@tglx

---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886..273f980 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5341,6 +5341,18 @@ F:	include/linux/sched/cpufreq.h
 F:	kernel/sched/cpufreq*.c
 F:	tools/testing/selftests/cpufreq/
 
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
 CPU IDLE TIME MANAGEMENT FRAMEWORK
 M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Daniel Lezcano <daniel.lezcano@linaro.org>
