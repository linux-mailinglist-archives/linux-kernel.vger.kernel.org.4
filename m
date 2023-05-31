Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C06E7188CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjEaRtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjEaRtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:49:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30910135;
        Wed, 31 May 2023 10:49:04 -0700 (PDT)
Date:   Wed, 31 May 2023 17:49:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685555342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOn6x3AozCBBpfR6dbtaX2BxqOGwH5ggpmXeuAyznSc=;
        b=R2KchUbkhf1S0kroPiZdGoO9uCLOX7ul7c/81CTBFRuGcFR2BiF74L3EkLOtp+c68tphya
        pYQUDhoF7J3BhJN2e+SDPTyUAafmpHtmM8wiEShF+eVUtmLUndnp3Di7terfLJI5q7yfcn
        pZUJRchrcwAdd9BjDvqpbSC88PjQxAL8ytlXia8tePx6wQ2O4pTIj8oXX/5gkVN856QPl9
        zsalYjP8N8NTIDQ4vHOLeLbzcf4xP8CQl22lHqob8+/C2lRt3XuI1z9/CtZuLmawJVUI64
        2aY8imgprt0V9t0Fpq9G8ZULNrYZhNFU2wR2/mGVYvj4CK346bhMIFvbaM6MqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685555342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOn6x3AozCBBpfR6dbtaX2BxqOGwH5ggpmXeuAyznSc=;
        b=qBReCQcT2ga27hCYuVOH3Zvv9X6n+jAXImNkhiKW8g8syI8gA3e1x2UCHZApuLaOTFHeBm
        pFfFxJDWy82eQXBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-6.4-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230531160549.433528-1-maz@kernel.org>
References: <20230531160549.433528-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168555534175.404.15649510085660741280.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     2d5b205dfa32b5f0f357ebc9db73931d2186391e
Gitweb:        https://git.kernel.org/tip/2d5b205dfa32b5f0f357ebc9db73931d2186391e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 31 May 2023 19:42:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 May 2023 19:42:53 +02:00

Merge tag 'irqchip-fixes-6.4-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull an irqchip fix from Marc Zyngier:

 - Fix regression introduced by the Mediatek workaround.

Link: https://lore.kernel.org/lkml/20230531160549.433528-1-maz@kernel.org
---
