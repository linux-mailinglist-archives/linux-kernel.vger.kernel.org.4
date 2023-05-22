Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9682F70B4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEVGVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEVGVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:21:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B7BCF;
        Sun, 21 May 2023 23:21:07 -0700 (PDT)
Date:   Mon, 22 May 2023 06:21:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684736464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nl//gg82Y1wK4EJZJUqHwr3bm6EvVQg6av4czVXouLM=;
        b=zSEtmQb6rx7nsoynyQZCErQ6UJPq+V01TUZYxrPN0HoM34J0dEsc1jclI5s0P07/7T3XUs
        ZmiiQACvZtBEJexDpT++TT5EBz6pOoFUunLe+l8XAgEiSQyIbXaMgEWBsA9KTn6tiMf8CD
        9vs8k4T17Md5ZU8TFttTWAMw2vBmUkVTXBgTrCHKznkwwAbqAmhcm4BL2K7CQCTR+2CbuZ
        vGXftJAYDeNFOThwOi27baJ03Mw8ecrappbc64k6wrI1WaRSG38yGPOxelnIX6QhXeL8sj
        YWWoX+QbjQ4yPd1l7Lo5dUZ2sIx+mheiU+MC7eifFScI91GfjNEQTj/y2MDS0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684736464;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nl//gg82Y1wK4EJZJUqHwr3bm6EvVQg6av4czVXouLM=;
        b=Jkbp1M2RP/yKsuxyGVdvW7PPdZHAua+txv7Cp2pCZWbeey7tyHUe3cUIMXEnHiXTqqGwxt
        KZMvO3dMg0M7L+AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.4-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230521101812.2520740-1-maz@kernel.org>
References: <20230521101812.2520740-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168473646279.404.11156140451881416759.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4115af49d2c24e840461fb83027315e2d2de6db4
Gitweb:        https://git.kernel.org/tip/4115af49d2c24e840461fb83027315e2d2de6db4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 22 May 2023 08:11:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 22 May 2023 08:11:01 +02:00

Merge tag 'irqchip-fixes-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zyngier:

  - MIPS GIC fixes for issues that could result in either
    loss of state in the interrupt controller, or a deadlock

  - Workaround for Mediatek Chromebooks that only save/restore
    partial state when turning the GIC redistributors off,
    resulting if fireworks if Linux uses interrupt priorities
    for pseudo-NMIs

  - Fix the MBIGEN error handling on init

  - Mark meson-gpio OF data structures as __maybe_unused,
    avoiding compilation warnings on non-OF setups

Link: https://lore.kernel.org/lkml/20230521101812.2520740-1-maz@kernel.org
---
