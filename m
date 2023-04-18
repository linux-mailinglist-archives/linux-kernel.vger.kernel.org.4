Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E26E6789
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDROxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDROxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18BCC1A;
        Tue, 18 Apr 2023 07:53:30 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmPjJBzLTCdEguTsxNxwSAO233jGo261m+4uUayQTnU=;
        b=cWT6amvogla3FldDOMdt1M7X8Ysd5z2EJhG5jitL/U1KljL4rIh8znDAP4+i1kDtx1VD7c
        x5wwWU31KDJS1z5iTbyCH2mPm1krP1lU3HOMMxBraxZ/EjKplana8XhaBmvtUtp+QDOAVL
        pvbeNHqMb4s/t2+cRMl1HCk9iQtPLLPi+fqK70Fe1Wkuy3g+DzNKbdbp/O428i5gSpc8nn
        //j6c/7Zki1Xz7O9P/fI2xp7GQWzryAMGfCLj/Lm42OezodmdtAdSmjda++FcNFsdx8qMi
        JmZPhlkJqsNiZaO6x9dxL+BSJlDu55xwJda+W3tm7/h4ZDDRKOhKk8+VjB8B0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmPjJBzLTCdEguTsxNxwSAO233jGo261m+4uUayQTnU=;
        b=ouTWlTeB0vFFrmIcvjeji7RZiRgFM94NO0jTLGmsRkki41L3DYhTSwyovTOz0DxQTVRsHI
        6FEWQ0Obd9EVzxDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] MAINTAINERS: Remove stale email address
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-7-frederic@kernel.org>
References: <20230222144649.624380-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182960830.404.1310379856866938109.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     9a1d4b8a7b80c5c796f05744851c535c5020024b
Gitweb:        https://git.kernel.org/tip/9a1d4b8a7b80c5c796f05744851c535c5020024b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

MAINTAINERS: Remove stale email address

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-7-frederic@kernel.org

---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d8ebab5..ee7e011 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14746,7 +14746,7 @@ F:	include/uapi/linux/nitro_enclaves.h
 F:	samples/nitro_enclaves/
 
 NOHZ, DYNTICKS SUPPORT
-M:	Frederic Weisbecker <fweisbec@gmail.com>
+M:	Frederic Weisbecker <frederic@kernel.org>
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@kernel.org>
 L:	linux-kernel@vger.kernel.org
