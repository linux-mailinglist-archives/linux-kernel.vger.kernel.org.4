Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4916865BE1A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbjACKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjACKbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80852D130;
        Tue,  3 Jan 2023 02:31:04 -0800 (PST)
Date:   Tue, 03 Jan 2023 10:31:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672741863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+BkaD7lZp54ZDlj55Oj3b+LyvZHIQcsivXRYKAEKbw=;
        b=sImWRDBPkIDpRkUkabXPcRer6HQ4ZZmHIeZ/stFfpM6NSj/CdmAgEVwAxE1DFkhVUNzHwp
        pC5cgLGloqNaMohNEqc01ppvHs7Yqg7egC50m0toTEPJgGHonjLY8XUX5DgDK0Bb4gGLgh
        FanIUAzmmHKK3gAASnYL3U/TuynM+bHn/4az8Qn8XPj75OIfEnaPndxLjTg2hIiJREjHfP
        ceP53ZrIAwwMkAUL2v7taTerwUeXLzoXFg5WrMFM+OZJpOsM4tkoTf+m+Epz1pK26h5AJZ
        idy9U8JbUdXgSkhojI7Y490OgfulyDeQqQWExbo4fVmuHMjCHNILcKYzH44qUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672741863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S+BkaD7lZp54ZDlj55Oj3b+LyvZHIQcsivXRYKAEKbw=;
        b=tvxNCF+q+hmegi9orbAnokQ/lk+a/By7yHaZlZqVIFE/Z2lzNMzIaRtVsn8LOpzBRa/Z93
        TYXZRocruSOVGNAg==
From:   "tip-bot2 for Anuradha Weeraman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/lib: Include <asm/misc.h> to fix a missing
 prototypes warning at build time
Cc:     Anuradha Weeraman <anuradha@debian.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230103034637.74679-1-anuradha@debian.org>
References: <20230103034637.74679-1-anuradha@debian.org>
MIME-Version: 1.0
Message-ID: <167274186311.4906.18084319743062649732.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     4651b9438b69ffa771c6e94020920a026ba86e98
Gitweb:        https://git.kernel.org/tip/4651b9438b69ffa771c6e94020920a026ba86e98
Author:        Anuradha Weeraman <anuradha@debian.org>
AuthorDate:    Tue, 03 Jan 2023 09:16:34 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Jan 2023 11:11:03 +01:00

x86/lib: Include <asm/misc.h> to fix a missing prototypes warning at build time

Signed-off-by: Anuradha Weeraman <anuradha@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230103034637.74679-1-anuradha@debian.org
---
 arch/x86/lib/misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index a018ec4..92cd8ec 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <asm/misc.h>
+
 /*
  * Count the digits of @val including a possible sign.
  *
