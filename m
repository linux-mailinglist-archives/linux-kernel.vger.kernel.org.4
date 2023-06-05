Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F2721FEB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjFEHnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjFEHmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:42:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2AA1;
        Mon,  5 Jun 2023 00:42:53 -0700 (PDT)
Date:   Mon, 05 Jun 2023 07:42:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ba9q3iN+Z2ewL0yyhXqVC3QSs+Izd3MziOgbzMw9POQ=;
        b=NUnYhH44MDwN/+i5hH7X0msB/qxMzZUEUNRCTBxnQWEG0sDOZpllTBUo8il9XFOA1/TDiU
        rPLUxG67jJFtKZWS89ATMigAdQbC1vedEHVcn47bQYrkXJKeKhQrgtoAhZhiq/HA6xW0Jf
        Wc/UohmAKHup42HL9fvS0OkcyiRydZoH37KeUzx9zWR7DgJU+af+1NHADt/435g/KLVJS+
        EuVnwuecgOUmzCSzXWaQpuxQFwbTf+WgiOHNfgry1O49Qg7dKhk+cDLjbDhI3vZKf8UTeJ
        UOoC2EtYMqqm3MFHqyrh2NXNpG/SOs7H2xNkoYefMKq3FJIW3NHZ7yH89cwB/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685950971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Ba9q3iN+Z2ewL0yyhXqVC3QSs+Izd3MziOgbzMw9POQ=;
        b=NtbK7bmJ61GlL1iLwWKbhAR5wTahMiJR8yLcITb8CePsZGsqT3C3cujApEkoWob5EjXB0j
        oRC8eePp5UuuClCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] parisc: Raise minimal GCC version
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168595097071.404.11892659028716011342.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8664645ade97b66a9d150cae43f4e6eef737b97d
Gitweb:        https://git.kernel.org/tip/8664645ade97b66a9d150cae43f4e6eef737b97d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 02 Jun 2023 16:33:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jun 2023 09:36:37 +02:00

parisc: Raise minimal GCC version

64-bit targets need the __int128 type, which for pa-risc means raising
the minimum gcc version to 11.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Helge Deller <deller@gmx.de>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/20230602143912.GI620383%40hirez.programming.kicks-ass.net
---
 scripts/min-tool-version.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 20d483e..367c37f 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -17,7 +17,11 @@ binutils)
 	echo 2.25.0
 	;;
 gcc)
-	echo 5.1.0
+	if [ "$SRCARCH" = parisc ]; then
+		echo 11.0.0
+	else
+		echo 5.1.0
+	fi
 	;;
 llvm)
 	if [ "$SRCARCH" = s390 ]; then
