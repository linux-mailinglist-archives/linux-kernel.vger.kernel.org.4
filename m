Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206673DAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjFZJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjFZJMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:12:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D58A10E3;
        Mon, 26 Jun 2023 02:10:48 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:10:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYTQrCC+RSsXOLgejvaT9+3BmV6u5vHSR79WcyKmmcU=;
        b=zsoz/X5XPLCX/M6x5Y7zOOejCePWaSjuQZlV0Ty83i6j60Wpdk8HwfCYu043ytcSO49m/F
        O8ID/YNn1HmIWpvebGfglOQjwOmkJBaw7wObOAl8t2/vAg8eUh7XPrmzQxqj/u5AZiCJ66
        4gbBBJA8G1bLXofhwxKxjSJaF1Xh/hAfezo/UJQjIlozgNeMry1YogT8axJWpfbDPIc9P9
        p3poSeWohWKDBij8WYBHQGhNEUx5XrwxsQ+Z0p+EJub+cGgqjQpP6GIbkrnZ7b1GPOMdZf
        GvMEz9EcIYJ6gHWsuZ41c7y4tw9nnRhS4RlptG1GUqgok1w7zxGUwaSKS/z/Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770647;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYTQrCC+RSsXOLgejvaT9+3BmV6u5vHSR79WcyKmmcU=;
        b=NGytLUmfbO/oNPtlO1qrFJJbGEdAKPNf1xdVnOiLeyDSfKzJEC1Rx8HzJVUmt9gmK0nUmw
        7CdLZmWtLTfajuDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Merge tag 'irqchip-6.5' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230623224345.3577134-1-maz@kernel.org>
References: <20230623224345.3577134-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <168777064603.404.8030430839930136395.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f121ab7f4ac32ed2aa51035534926f9507a8308b
Gitweb:        https://git.kernel.org/tip/f121ab7f4ac32ed2aa51035534926f9507a8308b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 26 Jun 2023 11:05:49 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Jun 2023 11:05:49 +02:00

Merge tag 'irqchip-6.5' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

Pull irqchip updates from Marc Zyngier:

  - A number of Loogson/Loogarch fixes

  - Allow the core code to retrigger an interrupt that has
    fired while the same interrupt is being handled on another
    CPU, papering over a GICv3 architecture issue

  - Work around an integration problem on ASR8601, where the CPU
    numbering isn't representable in the GIC implementation...

  - Add some missing interrupt to the STM32 irqchip

  - A bunch of warning squashing triggered by W=1 builds

Link: https://lore.kernel.org/r/20230623224345.3577134-1-maz@kernel.org
---
