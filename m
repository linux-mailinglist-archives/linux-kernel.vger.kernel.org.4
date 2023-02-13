Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5401E694F55
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjBMS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBMS0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:26:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73AE729D;
        Mon, 13 Feb 2023 10:26:29 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:26:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676312786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbK2WHvhSg+SOoT1oNRyZ8wxHQCPRD2NWBEhjIx3iGQ=;
        b=oaTqvjr4ZdIMx7BIqrC9XbvheNvFlJtTTKiW7LzkyC3Z+xB1u6Rw5v6k03mQ43LnF6XkXo
        3jQah31PUfJygLUql97YpsFQ/4seNqhi/M9SGlknDC7OQVGAdVoS2iKK8wAH/bPW2J1m7L
        teYT6NJGvsPw1GXSWID2OUItOnEHky5ploLvEC0IXifEaBATsDFGMCk3mHIEPrnHqWX/Zr
        LSrutooZxiYalVfHaYxbqLO/82OKIM1rZYDYBqWAnP2LtTcdS+pvcYtm+HYOvP/xIpFfXL
        f13ccui5rbovz3cpBdWHbDooNFqq2RXsbR8WKT4Q6K3Y/FQa++l+An2t3fxHcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676312786;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbK2WHvhSg+SOoT1oNRyZ8wxHQCPRD2NWBEhjIx3iGQ=;
        b=w9kPDhMsO3sms+UFPkNaWOgOIWKiKj8DDXg2RbIjf4Su8rfPZnrMtijp/ls/RujBtY07xa
        cdkDjh/KakV8dzCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.3-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b7d1d982-d717-2930-b353-19b92cbe390f@linaro.org>
References: <b7d1d982-d717-2930-b353-19b92cbe390f@linaro.org>
MIME-Version: 1.0
Message-ID: <167631278583.4906.15590834467092467336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7b0f95f28fc74f2a92662c26044d9d31c5ffd1e1
Gitweb:        https://git.kernel.org/tip/7b0f95f28fc74f2a92662c26044d9d31c5f=
fd1e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 13 Feb 2023 19:21:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Feb 2023 19:21:38 +01:00

Merge tag 'timers-v6.3-rc1' of https://git.linaro.org/people/daniel.lezcano/l=
inux into timers/core

Pull clocksource/event changes from Daniel Lezcano:

   - Add rktimer for rv1126 Rockchip based board (Jagan Teki)

   - Initialize hrtimer based broadcast clock event device on RISC-V
     before C3STOP can be used (Conor Dooley)

   - Add DT binding for RISC-V timer and add the C3STOP flag if the DT
     tells the timer can not wake up the CPU (Anup Patel)

   - Increase the RISC-V timer rating as it is more efficient than mmio
     timers (Samuel Holland)

   - Drop obsolete dependency on COMPILE_TEST on microchip-pit64b as the
     OF is already depending on it (Jean Delvare)

   - Mark sh_cmt, sh_tmu, em_sti drivers as non-removable (Uwe
     Kleine-K=C3=B6nig)

   - Add binding description for mediatek,mt8365-systimer (Bernhard
     Rosenkr=C3=A4nzer)

   - Add compatibles for T-Head's C9xx (Icenowy Zheng)

   - Restrict the microchip-pit64b compilation to the ARM architecture
     and add the delay timer (Claudiu Beznea)

   - Set the static key to select the SBI or Sstc timer sooner to prevent
     the first call to use the SBI while Sstc must be used (Matt Evans)

   - Add the CLOCK_EVT_FEAT_DYNIRQ flag to optimize the timer wake up on
     the sun4i platform (Yangtao Li)

Link: https://lore.kernel/org/r/b7d1d982-d717-2930-b353-19b92cbe390f@linaro.o=
rg
---
