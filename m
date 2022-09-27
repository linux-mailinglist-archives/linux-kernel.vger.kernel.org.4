Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B25EC4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiI0NkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232711AbiI0Njy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:39:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5014D24C;
        Tue, 27 Sep 2022 06:39:52 -0700 (PDT)
Date:   Tue, 27 Sep 2022 13:39:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664285990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sTM+Tk0yIkyiFXfjLwa2ka+r2b7M1L7zx63zPhB5zA=;
        b=lxlDUeIWk3MAwWMb+M91EdjYmxP3yG3k74ZjKoilj8kyxONPhgdLX9bSmfk+dpP7vCU+fO
        aw3rOYH3P8GAa250FbdD42OQcH29LmL/mwf/+c9fju9ukahBa5ofii33ioTaqBT4fUgONu
        wv7MqDObgfw9oUc/IUeH9Ol2Blh45fY8O184X+PIqOMKYS/7QptPjkiXwS6AVNB5SsYaEU
        1NmSMaey2i/zKK1mRa29jh7h1LuMfBZQq0DFW0b4kBzuFj9/vw6+P1hhKvEmi3FPiuHMZe
        phgsPGCK9TPoOoWyVfVpcjTp1/3IFZrSp1fw7masiexwdX3JEVoGDsDvm9BaAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664285990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5sTM+Tk0yIkyiFXfjLwa2ka+r2b7M1L7zx63zPhB5zA=;
        b=qgvfl0DL5qq6IDqZ9RLADl6GzBEN8avXGUEPYJZlLOZClQYmkb3W+jxkyyroc2p/geJxD9
        NLH8YQmSThh2gnAw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.0-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220916085158.2592518-1-maz@kernel.org>
References: <20220916085158.2592518-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <166428598915.401.11155367040658865873.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     c0cca6a66458a0daa627774de7ca2b678a6bb3d8
Gitweb:        https://git.kernel.org/tip/c0cca6a66458a0daa627774de7ca2b678a6bb3d8
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 27 Sep 2022 15:29:33 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 27 Sep 2022 15:29:33 +02:00

Merge tag 'irqchip-fixes-6.0-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull more irqchip fixes for 6.0 from Marc Zyngier:

  - A couple of configuration fixes for the recently merged Loongarch drivers

  - A fix to avoid dynamic allocation of a cpumask which was causing issues
    with PREEMPT_RT and the GICv3 ITS

  - A tightening of an error check in the stm32 exti driver

Link: https://lore.kernel.org/r/20220916085158.2592518-1-maz@kernel.org
---
