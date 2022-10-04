Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73295F3FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiJDJam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:28:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6C2ED7F;
        Tue,  4 Oct 2022 02:27:31 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyLUT8/kaSzHraI28N4w7Ig9Zb3r8EmbgFo9vN5p0RY=;
        b=R9aq9rMfaRCazfWnUQOJrfl5o7lGoQfu76LD6EnHzcWBkniw3ve0LaxCZeTsbkHdK53bwl
        jRJgwqgvYxaF5iehEANZGcs2pfXI0izq262CBqOYFahdKgLIRGJyNzT+qNb1/XiGELQOWp
        m3dFHTpF8bPzias6aQhX1QfZJ7kFPwls/HH59vKKK0CAK1kpTjISFqeDaKwUymcSr2q8d0
        gWVSoeuhtNPeW+gz8WKQa0hUt1jsxhfczkz4sQZdbLY0gDhTQsVrv25ZKca+/cfpjyb+Db
        ceBILsfUdBeubMgF1saKeVMUTn0bUCIQcVx751FaF2E3iQst4rl+wJF5IT7BoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KyLUT8/kaSzHraI28N4w7Ig9Zb3r8EmbgFo9vN5p0RY=;
        b=1JXPnB+1IS8gI2lOCOzCDUeiVKFdPfhJHtyccpyZw32w+A6YP/EJiJAV2b7AcXFXfeev/E
        gEM1TfR0SZhBCMAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.1-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b28ac4b0-5745-b3a9-b7e7-cc86dcb1b023@linaro.org>
References: <b28ac4b0-5745-b3a9-b7e7-cc86dcb1b023@linaro.org>
MIME-Version: 1.0
Message-ID: <166487564919.401.15289923804337246345.tip-bot2@tip-bot2>
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

Commit-ID:     6cb5ce13357de06d376d300778eee2009f53d8cb
Gitweb:        https://git.kernel.org/tip/6cb5ce13357de06d376d300778eee2009f53d8cb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Oct 2022 11:22:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 04 Oct 2022 11:22:43 +02:00

Merge tag 'timers-v6.1-rc1' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

Pull clocksource/event updates from Daniel Lezcano:

  - Added DT bindings for Mediatek MT8188 (Johnson Wang)

  - Added DT bindings for Renesas r8a779f0 (Wolfram Sang)

  - Added support for RZ/V2L SoC (Lad Prabhakar)

  - Rename TIMER_IRQ_EN to TIMER_IRQ_CLEAR to prevent confusion on sun4i
    (Victor Hassan)

  - Added support for Exynos ARTPEC-8 MCT, including DT bindings
    (Vincent Whitchurch)

  - Fixed handling of ARM erratum 858921 on the ARM Arch timer (Kunkun
    Jiang)

  - Added missing call platform_device_put() in the error path on ther
    GXP timer (Lin Yujun)

  - Cleaned the timer TI DM driver by self-encapsulating the code,
    dropping dead code and simplifying some functions (Tony Lindgren)

  - Added a DT property to tell the driver the clock is no longer
    divided on recent NXP hardware (Peng Fan)

  - Fixed the CNTPCT_LO and CNTVCT_LO values in the ARM arch timer (Yang
    Guo)

Link: https://lore.kernel.org/r/b28ac4b0-5745-b3a9-b7e7-cc86dcb1b023@linaro.org
---
