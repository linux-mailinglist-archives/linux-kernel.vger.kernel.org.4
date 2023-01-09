Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE33662EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbjAISX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjAISXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:23:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8BA1742A;
        Mon,  9 Jan 2023 10:22:09 -0800 (PST)
Date:   Mon, 09 Jan 2023 18:22:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673288527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rUwRHOpeMmottQzafUCHpL3iCCe5UPPqlLHncTduVo=;
        b=yfitI0/+5Z6/mJKB5hBILT1xzObkeEl6YC4BMN/UJvbBGu9w3+hsqknTPaB9s2bq2/CB6a
        0omhcFxkbm/0tOqcES2ViIb0THTTEMbu9tzDpZKjg3AuGUD4iP3MAwl+zW0Q+tjbX7Jc51
        LOafarpYzq3vKvDMnX7CDGJhns05n5N6/ilcz17iNC8O65IeTJk1yRjX9amNm8WTzsTkky
        sV5jGeec+OFYZzISVSFHEHsxT2mfDxV/eYUZd4qzGjHA1CEF/qyPALwssKJDEDK1UMpcEu
        xwfpvWqeoqmy9JCdRkJtTyQVYioAQB2lh0c9hHDwWxsvJ9IArzox4G/OnLvVsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673288527;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rUwRHOpeMmottQzafUCHpL3iCCe5UPPqlLHncTduVo=;
        b=KQQR8aWCRQM+eR9faud3eh1wEfnu5O/51CvWglOHlYo3RQTk0JN7zpO3JV5c/Ry9PMn8Mh
        RfCnxIVQ9YCTIMAg==
From:   "tip-bot2 for Alexander Lobakin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] scripts/head-object-list: Remove x86 from the list
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109170403.4117105-3-alexandr.lobakin@intel.com>
References: <20230109170403.4117105-3-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Message-ID: <167328852698.4906.1342756515976813355.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     5353fff29e42d0efc844dcaf764336d20a7f6b44
Gitweb:        https://git.kernel.org/tip/5353fff29e42d0efc844dcaf764336d20a7f6b44
Author:        Alexander Lobakin <alexandr.lobakin@intel.com>
AuthorDate:    Mon, 09 Jan 2023 18:04:03 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Jan 2023 18:22:21 +01:00

scripts/head-object-list: Remove x86 from the list

Now that x86 boot code is not hardcoded to the particular linking
order, remove x86 files from the list and let them be placed inside
the vmlinux according only to the linker script and linker
preferences.

Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20230109170403.4117105-3-alexandr.lobakin@intel.com
---
 scripts/head-object-list.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
index b074134..b2a0e21 100644
--- a/scripts/head-object-list.txt
+++ b/scripts/head-object-list.txt
@@ -42,10 +42,4 @@ arch/s390/kernel/head64.o
 arch/sh/kernel/head_32.o
 arch/sparc/kernel/head_32.o
 arch/sparc/kernel/head_64.o
-arch/x86/kernel/head_32.o
-arch/x86/kernel/head_64.o
-arch/x86/kernel/head32.o
-arch/x86/kernel/head64.o
-arch/x86/kernel/ebda.o
-arch/x86/kernel/platform-quirks.o
 arch/xtensa/kernel/head.o
