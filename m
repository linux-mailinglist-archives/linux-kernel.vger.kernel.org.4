Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA168162C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbjA3QRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjA3QRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:17:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD372137
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:17:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 93DE21EC0644;
        Mon, 30 Jan 2023 17:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675095435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=cAdgbpzn0eknmmug36VtvpQWaeyU4NiY1E5GmYpwRno=;
        b=D4X7ygigmfYq+SpLaDwCzSGfaf9YddH95mXagzDO6Qck57cvRlVDaru4ScMr7mFNyRBtzG
        RDzLbsHGKpOnSr4QjokUJ8QtahikwSwgvx+cYDitSbNnpIY2uu5nE3D8fNhp3/Y8nunJGD
        rrqOaWs/Ie/SArtR/B8IYj30cjuFv04=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] x86/microcode: Some fixes
Date:   Mon, 30 Jan 2023 17:17:05 +0100
Message-Id: <20230130161709.11615-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

here's a small set of fixes which materialized from me staring at the
AMD side of the loader code in recent times.

Comments and suggestions are always appreciated.

Thx.

[ TODO for self: Add patches 1 and 2 in patch 3's stable field as
   prerequisites for backporting. ]

Borislav Petkov (AMD) (4):
  x86/microcode/amd: Remove load_microcode_amd()'s bsp parameter
  x86/microcode/AMD: Add a @cpu parameter to the reloading functions
  x86/microcode/AMD: Fix mixed steppings support
  x86/microcode/core: Return an error only when necessary

 arch/x86/include/asm/microcode.h     |  4 +-
 arch/x86/include/asm/microcode_amd.h |  4 +-
 arch/x86/kernel/cpu/microcode/amd.c  | 55 +++++++++++++---------------
 arch/x86/kernel/cpu/microcode/core.c | 12 +++---
 4 files changed, 36 insertions(+), 39 deletions(-)

-- 
2.35.1

