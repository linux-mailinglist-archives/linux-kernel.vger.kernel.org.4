Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70185FC1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJLIX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 04:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJLIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 04:23:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928571903C;
        Wed, 12 Oct 2022 01:23:44 -0700 (PDT)
Date:   Wed, 12 Oct 2022 08:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1665563021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gueAfz3RCcUmf5ukffxadlk31H0V727eR91oTgm4Xwg=;
        b=xXn6Z983xRoiawEGx1y9hVBZxN+QAqqAYuNE7XeDfjCPRlGyrESr6EkCTnDbI+i3IstEVx
        WzzhXkvTytlQJihmYHhXw9OgKyRS24lmDKk5x5M4+JKw61EI2Xq86nez/flh68KtO8R36D
        rtihAomdt/5tZQRajZr1W+XpLGgxzrFJj4KrsBYDQ07M+D053r7fbFu+KvC3Ak0aeioQYv
        7BhK+sm5jwdQcF9xXAlxisNy3FQUVQ6133uSbge7jmHKOx3mVte5juih5ABjiyVQLWX/vR
        rshlQ7y0owWHKcbJCo0Jea5OP06YQFRq9o080NUmFdH/x+DjORhfB3HDDIynaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1665563021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gueAfz3RCcUmf5ukffxadlk31H0V727eR91oTgm4Xwg=;
        b=0alRPI5C2eeo38kzYWmmgvcS8x9J5wQkEx0GexZ3r/hHcwUZWXVRqBHcI3jWG1dUT1FEgg
        ihZj9WbFg2wu3EAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-fixes-6.1-1' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221012075125.1244143-1-maz@kernel.org>
References: <20221012075125.1244143-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <166556302008.401.13593086163683620449.tip-bot2@tip-bot2>
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

Commit-ID:     b8d49bcd8fd19824888c766a217891855d8692ad
Gitweb:        https://git.kernel.org/tip/b8d49bcd8fd19824888c766a217891855d8692ad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 12 Oct 2022 10:14:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 12 Oct 2022 10:14:09 +02:00

Merge tag 'irqchip-fixes-6.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip fixes from Marc Zyngier:

  - Fix IMX-MU Kconfig, keeping it private to IMX

  - Fix a register offset for the same IMX-MU driver

  - Fix the ls-extirq irqchip driver that would use the wrong
    flavour of spinlocks

Link: https://lore.kernel.org/r/20221012075125.1244143-1-maz@kernel.org
---
