Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8006132B9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJaJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJaJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:29:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD56DEB2;
        Mon, 31 Oct 2022 02:29:53 -0700 (PDT)
Date:   Mon, 31 Oct 2022 09:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667208591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JoBSIhXypW7Gy7Obhvf5aa/rV/BTWBY+BBqZAjQMbg=;
        b=kHIix0t4TWaMAEx0Sb2Nnl8P8w+D+kkx3wBg6mKBF343Zmj3qAgwjPalHzlqK85eZIT37i
        XCV84jcvqMTHIySq5HQCt4nXxpZ5Qln5ZTzq8/7mWN0213XDbX+WZR2h50niKp4vReHxnS
        lgSLYSp4zAQJ9u9BjsJwqlajDJdDjPJ0X0+xvpBte+kRhUb8QgEZcgB2EYx62vVMAZDls9
        26mytd6ymr+7LJRR/aGHZqt9GFX/pELHpnO9x94gU6Juv2gYjlh06SixNFkPhouIZt0Saj
        SvVV9cfkkY5PQloaA74xjstu6Uqf6rjrtuS729bHiljIMiYD+6pjJy70w10L5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667208591;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JoBSIhXypW7Gy7Obhvf5aa/rV/BTWBY+BBqZAjQMbg=;
        b=Bb7KrgNjPgTBspLcPQZFBmcNwrbRkU+0vfzAoNN14az92Fi3jT836oQdQ5R5xAIEH+QPHh
        dDu9ouqzJ4thtKDA==
From:   "tip-bot2 for Chen Lifu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/i8259: Make default_legacy_pic static
Cc:     Chen Lifu <chenlifu@huawei.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220823021958.3052493-1-chenlifu@huawei.com>
References: <20220823021958.3052493-1-chenlifu@huawei.com>
MIME-Version: 1.0
Message-ID: <166720858963.7716.9924110502009264129.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c9053e1c5a6fca221946f95d1fe6e47f69fb303a
Gitweb:        https://git.kernel.org/tip/c9053e1c5a6fca221946f95d1fe6e47f69fb303a
Author:        Chen Lifu <chenlifu@huawei.com>
AuthorDate:    Tue, 23 Aug 2022 10:19:58 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 31 Oct 2022 10:20:32 +01:00

x86/i8259: Make default_legacy_pic static

The symbol is not used outside of the file, so mark it static.

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220823021958.3052493-1-chenlifu@huawei.com
---
 arch/x86/kernel/i8259.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 15aefa3..3aa5304 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -407,7 +407,7 @@ struct legacy_pic null_legacy_pic = {
 	.make_irq = legacy_pic_uint_noop,
 };
 
-struct legacy_pic default_legacy_pic = {
+static struct legacy_pic default_legacy_pic = {
 	.nr_legacy_irqs = NR_IRQS_LEGACY,
 	.chip  = &i8259A_chip,
 	.mask = mask_8259A_irq,
