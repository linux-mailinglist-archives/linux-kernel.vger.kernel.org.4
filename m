Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17E263962A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKZNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiKZNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C21DDD9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:37 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02FqIBMeYxXeJpNx5OEkeKsSfmSX594FWZ91a1rffnA=;
        b=Ecl9wYVl7VEfdIH5cr5rtlmXz4OTj6+IV8KRphyGG6yzTs2E4+dAEexDQXRYe7CN69lnoY
        IPkVvHE2Uxk9EmgQP9PrQ14Ep8pmezkKc0KvvnbSLm/plbBCutnWw75I5cKA2s6QL1iwGS
        wQ9JatblzNQm0sgzR+pfLerUCEG4NAL3YN7xg49exyHpbRUgsCPTXB/2KzVZeE80qOcg/C
        X9W3yK7uo5dwVtxzc3/xh1PiV6/AEWM5YZ34enKgFnYUNSVYzcu8yxg8GvJ3adb+vUs62N
        RmmHgfEKFaERFjBis2HbT0gG32sktWqTMKCpTmKj+TCcp/hTQcBnCiVZZ9m9NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469676;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02FqIBMeYxXeJpNx5OEkeKsSfmSX594FWZ91a1rffnA=;
        b=N3+qdrIBsZgRkWrO/9VsKeGgM8eP6PesQ8l7/hLPx6TVzgO69ox57Q9CddjNoR0QZQDNzG
        2SydaB4L4G5B5HAw==
From:   "irqchip-bot for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Mark aic_info structs
 __initconst
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marc Zyngier <maz@kernel.org>,
        Eric Curtin <ecurtin@redhat.com>, tglx@linutronix.de
In-Reply-To: <20221021235523.76585-1-konrad.dybcio@somainline.org>
References: <20221021235523.76585-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Message-ID: <166946967479.4906.12648220580394295984.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d46b99656a16c450681985661a249dbb18e55cc4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d46b99656a16c450681985661a249dbb18e55cc4
Author:        Konrad Dybcio <konrad.dybcio@somainline.org>
AuthorDate:    Sat, 22 Oct 2022 01:55:23 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:42 

irqchip/apple-aic: Mark aic_info structs __initconst

These structs hold information used only at init time that never
gets modified, hence mark them __initconst.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Suggested-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221021235523.76585-1-konrad.dybcio@somainline.org
---
 drivers/irqchip/irq-apple-aic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1c2813a..ae3437f 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -248,14 +248,14 @@ struct aic_info {
 	bool fast_ipi;
 };
 
-static const struct aic_info aic1_info = {
+static const struct aic_info aic1_info __initconst = {
 	.version	= 1,
 
 	.event		= AIC_EVENT,
 	.target_cpu	= AIC_TARGET_CPU,
 };
 
-static const struct aic_info aic1_fipi_info = {
+static const struct aic_info aic1_fipi_info __initconst = {
 	.version	= 1,
 
 	.event		= AIC_EVENT,
@@ -264,7 +264,7 @@ static const struct aic_info aic1_fipi_info = {
 	.fast_ipi	= true,
 };
 
-static const struct aic_info aic2_info = {
+static const struct aic_info aic2_info __initconst = {
 	.version	= 2,
 
 	.irq_cfg	= AIC2_IRQ_CFG,
