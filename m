Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFB735268
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFSKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjFSKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:34:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F964CA;
        Mon, 19 Jun 2023 03:34:17 -0700 (PDT)
Date:   Mon, 19 Jun 2023 10:34:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687170856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzKIAkSRNHA5Cf1RLkHRArxPwsAojW8HDj1bvezLzf4=;
        b=wVz0QZ4oAdkldlkaSS4r5USfgXKKSTN2s+NwWrqv7AmnBHUIrM1tVpXu3Zmle+OsiYP+V1
        HQ7ZD0cEK6Z1qSw0kFbgc1Kyynqu/WwRUmxz5HJ5UnYKESnVM2P5pVpVW+JqKFyCfHERK2
        CT5CPqef1IyUdkBEnzpTev5e8AT5WivMG+4SKiDZYhG0RQfQavglQt9883E1DcVGdWrQM/
        IRyQ9dkBOQfwPuT9eIIqX0Yz4UdnRoJVxyv6L4JNRlgkgBodNxNnf7DSjpcwKmPhYuUZI0
        UHnHZpAIEt4P/Y160PRuBiSu+PgkL+zYxv0oFZIKh243e0w/+x+EwqH754JcDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687170856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tzKIAkSRNHA5Cf1RLkHRArxPwsAojW8HDj1bvezLzf4=;
        b=NkiMitom9yLW+v8kO5yTC5xYgRUGQvlkX596aeYc4cPnhxO0WZRimMVr4uWcoq7Q/Vjc7m
        aZyaK+z+lDYSgbAQ==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] Documentation: virt: Clean up paravirt_ops doc
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230610054310.6242-1-rdunlap@infradead.org>
References: <20230610054310.6242-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <168717085535.404.15451163061150954875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     6f7f812f54b46da88ec6e98b4a10e501d0d7164c
Gitweb:        https://git.kernel.org/tip/6f7f812f54b46da88ec6e98b4a10e501d0d7164c
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 09 Jun 2023 22:43:10 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 19 Jun 2023 12:09:54 +02:00

Documentation: virt: Clean up paravirt_ops doc

Clarify language. Clean up grammar. Hyphenate some words.

Change "low-ops" to "low-level" since "low-ops" isn't defined or even
mentioned anywhere else in the kernel source tree.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20230610054310.6242-1-rdunlap@infradead.org
---
 Documentation/virt/paravirt_ops.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/paravirt_ops.rst b/Documentation/virt/paravirt_ops.rst
index 6b789d2..62d867e 100644
--- a/Documentation/virt/paravirt_ops.rst
+++ b/Documentation/virt/paravirt_ops.rst
@@ -5,31 +5,31 @@ Paravirt_ops
 ============
 
 Linux provides support for different hypervisor virtualization technologies.
-Historically different binary kernels would be required in order to support
-different hypervisors, this restriction was removed with pv_ops.
+Historically, different binary kernels would be required in order to support
+different hypervisors; this restriction was removed with pv_ops.
 Linux pv_ops is a virtualization API which enables support for different
 hypervisors. It allows each hypervisor to override critical operations and
 allows a single kernel binary to run on all supported execution environments
 including native machine -- without any hypervisors.
 
 pv_ops provides a set of function pointers which represent operations
-corresponding to low level critical instructions and high level
-functionalities in various areas. pv-ops allows for optimizations at run
-time by enabling binary patching of the low-ops critical operations
+corresponding to low-level critical instructions and high-level
+functionalities in various areas. pv_ops allows for optimizations at run
+time by enabling binary patching of the low-level critical operations
 at boot time.
 
 pv_ops operations are classified into three categories:
 
 - simple indirect call
-   These operations correspond to high level functionality where it is
+   These operations correspond to high-level functionality where it is
    known that the overhead of indirect call isn't very important.
 
 - indirect call which allows optimization with binary patch
-   Usually these operations correspond to low level critical instructions. They
+   Usually these operations correspond to low-level critical instructions. They
    are called frequently and are performance critical. The overhead is
    very important.
 
 - a set of macros for hand written assembly code
    Hand written assembly codes (.S files) also need paravirtualization
-   because they include sensitive instructions or some of code paths in
+   because they include sensitive instructions or some code paths in
    them are very performance critical.
