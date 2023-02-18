Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E269BDEB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBRXQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:16:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300F14E9D;
        Sat, 18 Feb 2023 15:16:14 -0800 (PST)
Date:   Sat, 18 Feb 2023 23:16:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676762171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8g43V4MCQR3o/SfYMnKdsdISnPMf7MbBo2vGHoXKMc=;
        b=p+X8khiLNZ+56Li0kR0e1pv9C/711fsQ2LhUgyD7zZ6pPgfKC/ojjYnmuFcv3jPaPQpUaE
        10ckiYmd7NNLxru8uJjmIHNvxTzffDuxE+TlxU6Yr+ThrVK1lLyyAciDSxSTmuafEVTWTH
        Y14w0K3oIKdKZTlXfOKHsURPykhJPYbw0tgpUBKA5sK4NohShIaDHk+mM9baoy9BBw6au4
        nFoxUgJQ9NbAfX6NA7FWKzKMCTidgCENphodcapuwb6eKRI0ut/W1x0SutxR8pCvEI0ZM5
        J1E1F4bmiPGnUvEWSI1yLoEEcKAYzfCuaky+2/T872cMmn+iAAH0X2dvnNwIOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676762171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8g43V4MCQR3o/SfYMnKdsdISnPMf7MbBo2vGHoXKMc=;
        b=nPdkwNy1V2sjSKOMo5iNscmlz3R/oWaWWXbovVQnHlHKyFaOmSFi3pObDN1lFN91x3vsNZ
        ossEvBWBSEN5LYBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-6.3' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230218143452.3817627-1-maz@kernel.org>
References: <20230218143452.3817627-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <167676216961.4906.9294968695532135789.tip-bot2@tip-bot2>
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

Commit-ID:     6f3ee0e22b4c62f44b8fa3c8de6e369a4d112a75
Gitweb:        https://git.kernel.org/tip/6f3ee0e22b4c62f44b8fa3c8de6e369a4d112a75
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 19 Feb 2023 00:07:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 19 Feb 2023 00:07:56 +01:00

Merge tag 'irqchip-6.3' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

   - New and improved irqdomain locking, closing a number of races that
     became apparent now that we are able to probe drivers in parallel

   - A bunch of OF node refcounting bugs have been fixed

   - We now have a new IPI mux, lifted from the Apple AIC code and
     made common. It is expected that riscv will eventually benefit
     from it

   - Two small fixes for the Broadcom L2 drivers

   - Various cleanups and minor bug fixes

Link: https://lore.kernel.org/r/20230218143452.3817627-1-maz@kernel.org
---
