Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576DE6EAE23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjDUPhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjDUPhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:37:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDA6CC39;
        Fri, 21 Apr 2023 08:37:41 -0700 (PDT)
Date:   Fri, 21 Apr 2023 15:37:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682091460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjxNB4+oTRTQaZLCIYPpQHi0l9Hx+bN+fVofiZ0FxzM=;
        b=n6PcWuO/6Q2I+2dYotWJGm3De36Gy7q5dXzR4BTr0Fw4hCZfc9kji9lBG/QX31VCekg6Hk
        ahHDZIMJJkOHmv1J8nE7fwlWoR3ttKNRfU7hLzMsWBUrhRM0ipUFdRd7OcA3I7kdKAjQmp
        XS3IeFnjs5Udzr9I+uUNYMZPADYZ7FHTAs0FVD0cf4Dx2bZI/9StpprumV/T4ZSbQAQ3cI
        obGGIUFv4+T7pZDyrC2TH1MFcUpSs98MWXu+9Txwdqp0Ov6IR82LkWhB5AzReSUaUU6Piq
        PGj7c5pgeGagmF2NERYUM/8bxtYguKaqdoCSF5MldqGwU65bXIPbZB8nb8gW6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682091460;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjxNB4+oTRTQaZLCIYPpQHi0l9Hx+bN+fVofiZ0FxzM=;
        b=i1uNScj54z56DJJb7M34Mb1c3qFtB4UM4NYbS+EKlsCajyBeXgcUWOK+09Qv5iNspJAKMc
        bY3wZt9JMCktR7AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-6.4' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230421132104.3021536-1-maz@kernel.org>
References: <20230421132104.3021536-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168209145920.404.17555415810428593879.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f37202aa6e5d6d39a48f744d962fd2bf3a8a452b
Gitweb:        https://git.kernel.org/tip/f37202aa6e5d6d39a48f744d962fd2bf3a8a452b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 21 Apr 2023 17:30:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Apr 2023 17:30:57 +02:00

Merge tag 'irqchip-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip changes from Marc Zyngier:

 - Large RISC-V IPI rework to make way for a new interrupt
   architecture

 - More Loongarch fixes from Lianmin Lv, fixing issues in the so
   called "dual-bridge" systems.

 - Workaround for the nvidia T241 chip that gets confused in
   3 and 4 socket configurations, leading to the GIC
   malfunctionning in some contexts

 - Drop support for non-firmware driven GIC configurarations
   now that the old ARM11MP Cavium board is gone

 - Workaround for the Rockchip 3588 chip that doesn't
   correctly deal with the shareability attributes.

 - Replace uses of of_find_property() with the more appropriate
   of_property_read_bool()

 - Make bcm-6345-l1 request its MMIO region

 - Add suspend support to the SiFive PLIC

 - Drop support for stih415, stih416 and stid127 platforms

Link: https://lore.kernel.org/lkml/20230421132104.3021536-1-maz@kernel.org
---
