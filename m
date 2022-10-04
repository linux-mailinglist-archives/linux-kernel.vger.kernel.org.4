Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884D45F4025
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJDJop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiJDJnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:43:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB4183AF;
        Tue,  4 Oct 2022 02:41:27 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664876485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ec3iNKmBuPnN5yEee4qUk9svLPnVQzkZTa53h9WRoeo=;
        b=qvNxS0rOJqO0/+i9M7hsJED0croTx0mNXPsvl0S1hDUE+iotWGp1Ga6kCrnqFxUUoQE/Gb
        TJ848MldCqgF8WitvYpEOZc4Al5xGNuqU75D5yQAuNy1nW7Q/QOozyV4TLAqWzIyD42vYG
        j5tUL2OVkiLEhOjVlrcrAFTERvhgy8SNt2P9GAdZYQLEKK6qhe0/WeD4JIJE08QvtV50+C
        2wkIhfAsvcF3SYLxD0W68SiEX/pidp5AoVsbEe1lXE9qK1yFKY7VTWrh3t7fK/SwcjoG4W
        qm4hRKAdQXUUSaCxX5M4nA/eD8pg+NOn5f10oLstLKtgWyStWu51Vuxgx/LWdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664876485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ec3iNKmBuPnN5yEee4qUk9svLPnVQzkZTa53h9WRoeo=;
        b=1Kr7CO7lWQyAAq53l2wENxu0merFqHZOZMOkf4RB8H1W800d9Aq2ztiNiBvC7T0xlhFVvB
        phub+dZaFfc5rXAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-6.1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221002125554.3902840-1-maz@kernel.org>
References: <20221002125554.3902840-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <166487648406.401.10131307174346356010.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     36de4f94197318e45ba77badb5b07274f5bc72a9
Gitweb:        https://git.kernel.org/tip/36de4f94197318e45ba77badb5b07274f5bc72a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Oct 2022 11:35:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 04 Oct 2022 11:35:20 +02:00

Merge tag 'irqchip-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

 - A new driver for the FSL MU widget that provides platform MSI

 - An update for the Realtek RTL irqchip to use a DT binding that
   actually describes the hardware

 - A handful of DT updates, as well as minor code and spelling fixes

Link: https://lore.kernel.org/r/20221002125554.3902840-1-maz@kernel.org
---
