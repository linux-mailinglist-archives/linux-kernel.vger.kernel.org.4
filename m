Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E3E6485E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiLIPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiLIPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:47:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E737FB6;
        Fri,  9 Dec 2022 07:47:27 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:47:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yVbJpzaf1w317Dy1LDwVLXIIF+GPE5lsvg9s421slY=;
        b=gWMvEZxpIR1kXVjYWpx5wlxA85jrSRGnR3v27EvABsa0WLbCobdzbixUHkLsmJ2F63ChLI
        xKCD4bKgKr34K58JpZDy1Mq0+7jyZt9Vio2jm1laFe9u8zZ5Eo6lNg4kAB0mu5qKRkJG4R
        wDgH2I328HTpGemtdit/IXOQfYf+bQdU0OdylHG6sFVuZEzVLgXRqxezoB+QQ1Lww9dcUC
        s/hQoi9rYB+PqmwQG48/cwKGkvRCApt1n9NdMxA34XE+KgJ+XIZnjIY6dkEq6sUyKtgx92
        uYaxk955DXmycTtXkxSVT9UOzAtBpl/p4c2IrhMNcUee2EyayPZtc/OZ5Oq4zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670600844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yVbJpzaf1w317Dy1LDwVLXIIF+GPE5lsvg9s421slY=;
        b=FAQFBeVauMlgUWUGErYgJa9arWuSKP9OQgxF0XeoJs4ko/DQcJiHc3skUIqcp9QAHKGsbc
        jd3rZrIz3SuZD4AA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.2-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <3c4c3bb2-b849-0c87-0948-8a36984bdde4@linaro.org>
References: <3c4c3bb2-b849-0c87-0948-8a36984bdde4@linaro.org>
MIME-Version: 1.0
Message-ID: <167060084414.4906.17415351148962544132.tip-bot2@tip-bot2>
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

Commit-ID:     18a207849218d8c15072f449e6d0b901262290c9
Gitweb:        https://git.kernel.org/tip/18a207849218d8c15072f449e6d0b901262=
290c9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 09 Dec 2022 16:41:58 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Dec 2022 16:41:58 +01:00

Merge tag 'timers-v6.2-rc1' of https://git.linaro.org/people/daniel.lezcano/l=
inux into timers/core

Pull clockevent/source driver updates from Daniel Lezcano:

  - Add DT bindings for the Rockchip rk3128 timer (Johan Jonker)

  - Change the DT bindings for the npcm7xx timer in order to specify
    multiple clocks and enable the clock for the timer1 on WPCM450
    (Jonathan Neusch=C3=A4fer)

  - Fix the timer duration being too long the ARM architected timer in
    order to prevent an integer overflow leading to a negative value and
    an immediate interruption (Joe Korty)

  - Fix an unused pointer warning reported by lkp and some cleanups in
    the timer TI dm (Tony Lindgren)

  - Fix a missing call to clk_disable_unprepare() in the error path at
    init time on the timer TI dm (Yang Yingliang)

  - Use kstrtobool() instead of strtobool() in the ARM architected timer
    (Christophe JAILLET)

  - Add DT bindings for r8a779g0 on Renesas platform (Wolfram Sang)

Link: https://lore.kernel.org/all/3c4c3bb2-b849-0c87-0948-8a36984bdde4@linaro=
.org
---
