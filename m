Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790C6EF0E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbjDZJOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 05:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbjDZJMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 05:12:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC41244A4;
        Wed, 26 Apr 2023 02:12:36 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682500354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eEWw2UgUIcY1/6Bj5z8sB9qImeKvvwVREQNFo/ZVpI=;
        b=Rjvic15lgAQvIaAccNlOsJ6xbDAsfPoUYiN5Fmh8nqo44LqpFH7ig6l6rpQDDk7jNdrQ2M
        mnozlo7kCIzQdcyDJ6yig6RBviOSFXNY2JaQe9JrDWYQ91cUjzplVuzVud6Wl9VMY/PYM/
        XiHSvVat4np+MNzxhDjL6nKvgUVEXQcTWKufh/V6QgV/2yf0C+dQWCoeh5LWTr0Ib5tZkW
        lKSsBrx9ZJF3K6CPrFbp20u9tJKPH3S5oedyFBzZkNgqtJwbWOIYDTtKg5Cc9BqP8VTaad
        WWNWBBdwuAgl0IgSUGjXqV0vQWxfZVkW9dTFqn5zgqfwxLkcu9EAkPYxs1h86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682500354;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eEWw2UgUIcY1/6Bj5z8sB9qImeKvvwVREQNFo/ZVpI=;
        b=Sc7UjOw5aX8kD2KdwGAJdSQobH7TrS1k65kRY8fHE9r91rLw6WNWDv63BKqpkCNXRz9tht
        sRFeBHGB1zUTQ2Cg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge tag 'timers-v6.4-rc1' of
 https://git.linaro.org/people/daniel.lezcano/linux into timers/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
References: <d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@linaro.org>
MIME-Version: 1.0
Message-ID: <168250035403.404.14046775663667152077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7e0664b660bc8f977d2948d8c8fbfc4809b3e6b4
Gitweb:        https://git.kernel.org/tip/7e0664b660bc8f977d2948d8c8fbfc4809b=
3e6b4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Apr 2023 11:03:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Apr 2023 11:06:00 +02:00

Merge tag 'timers-v6.4-rc1' of https://git.linaro.org/people/daniel.lezcano/l=
inux into timers/core

Pull clocksource and clockevent updates from Daniel Lezcano:

  - Fix error returned for shared timers on Exynos MCT timers (Krzysztof Kozl=
owski)

  - Code reorg by splitting the CPUXGPT timer code (AngeloGioacchino Del Regn=
o)

  - Remove the unused mxc_timer_init() function on i.MX (Fabio Estevam)

  - Replace of_get_address() and of_translate_address() calls with
    single call to of_address_to_resource() on TI timer (Rob Herring)

  - Mark driver as non-removable and remove useless remove() callback on
    SH MTU2 and STM32 LP timers. Improve the error message in the remove
    callback of the TI DM timer (Uwe Kleine-K=C3=B6nig)

  - Convert to platform remove callback returning void on Tegra186, TI
    DM timers (Uwe Kleine-K=C3=B6nig)

  - Drop pointless of_match_ptr for ID table in the STM32 LP timer
    (Krzysztof Kozlowski)

  - Fix memory leak in davinci_timer_register when init fails on DaVinci
    (Qinrun Dai)

  - Fix finding alwon timer regression on Timer TI DM (Tony Lindgren)

  - Use of_property_read_bool() for boolean properties on TI timer (Rob
    Herring)

  - Drop superfluous rk3288 compatible and add rk3588 compatible DT
    bindings (Cristian Ciocaltea)

Link: htttps://lore.kernel.org/lkml/d30fd923-e6e5-a1a6-ca76-1b39f8fad6c9@lina=
ro.org
---
