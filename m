Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE0763F0C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiLAMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLAMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:44:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DFE8C6AF;
        Thu,  1 Dec 2022 04:44:22 -0800 (PST)
Date:   Thu, 01 Dec 2022 12:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669898661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0215NXy7e4twwueg69QpPuwlThUK7b9x8eLXzNd1cg=;
        b=1Ox7nVSCZiy0YgHDcXqkZDjotNB3/4UxumThdPyNaKk11PWFMk23ej1mgzHnxCONuxF49R
        wTK9goXGfvan+VxR3IsiZ/aYLV0kNiG1Ik9CeThX3NW8b2eS1rGLxwjIvs4gSpIfG04Fat
        Ll55RqmLZuELpWBO0C8OnvE/Scu7ladphnLye7vlJ3javYJThIAI1k0geeniAuhkhd4eFm
        at7qbenn6bjfwZZ/+spxygk+zAfUCJYHWt13NOa9svE42HZ2XDPqLCO7hXIHLhAZbMIRTZ
        OKuIpBO3upxF8pP08PuvD0dYAh73yi7CbDXHYsScMoLO0NKtu7iy49Kiue/dMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669898661;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0215NXy7e4twwueg69QpPuwlThUK7b9x8eLXzNd1cg=;
        b=9D4PS2c3usd4YlHKsW14u8HUcgeYe0qZuFYXxRreu/BxR3gM9O9zckne9wf1keYvLxgfRg
        nDNeeZLthBS04vBg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Repair kernel-doc for clockevent_delta2ns()
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221102091048.15068-1-lukas.bulwahn@gmail.com>
References: <20221102091048.15068-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <166989865935.4906.6699824644885829339.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ebe11732838f39bd10bddafd4dfe2f97010fde62
Gitweb:        https://git.kernel.org/tip/ebe11732838f39bd10bddafd4dfe2f97010fde62
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 02 Nov 2022 10:10:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 01 Dec 2022 13:35:41 +01:00

clockevents: Repair kernel-doc for clockevent_delta2ns()

Since the introduction of clockevents, i.e., commit d316c57ff6bf
("clockevents: add core functionality"), there has been a mismatch between
the function and the kernel-doc comment for clockevent_delta2ns().

Hence, ./scripts/kernel-doc -none kernel/time/clockevents.c warns about it.

Adjust the kernel-doc comment for clockevent_delta2ns() for make W=1
happiness.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221102091048.15068-1-lukas.bulwahn@gmail.com

---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 5d85014..960143b 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -76,7 +76,7 @@ static u64 cev_delta2ns(unsigned long latch, struct clock_event_device *evt,
 }
 
 /**
- * clockevents_delta2ns - Convert a latch value (device ticks) to nanoseconds
+ * clockevent_delta2ns - Convert a latch value (device ticks) to nanoseconds
  * @latch:	value to convert
  * @evt:	pointer to clock event device descriptor
  *
