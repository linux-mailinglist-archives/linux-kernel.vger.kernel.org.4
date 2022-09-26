Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC455EAC97
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiIZQdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIZQcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:32:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20056118DF8;
        Mon, 26 Sep 2022 08:21:19 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:21:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664205666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hhmGJNBhfqo9Hwk6td6VqtlutXUDzo9USjDd+979GU=;
        b=Rb/4sTXmE1qGDzKwCZjYWdenU7ymuI09Gmvco7pVAsjlrVS05RpZSansfLl0YotxW2J4cc
        dbfB4PAibuSxhOmp8kkBuIzwmXOx2J5F9vkCW+E/nD0whGsT/6KEnXuPZVgXCqCOe0kRxc
        dxmH8eRKrZGobVEKUDCdVwOyAKOVyh8POSBBMKjuSKZNx66qt758fifduXiXwsA3dzo1TF
        4FESthX93O90R1SjwEOmBHJnS0OGsmYDLC9SKDyZe0UbEp7UhQo4bxB7DvTX0sp8oHxRTA
        BszxGjK+aJsKn+pMzt0DSqlFYc4+Uh1J6uvBLLZ7UFIKqGwlBzc26oIVsi7G0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664205666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hhmGJNBhfqo9Hwk6td6VqtlutXUDzo9USjDd+979GU=;
        b=HI+z+Koh7A9hraD4/Q47OfXwUiH0E2elhYL0jQOWt5ML8U6VSZrCLRm5x9SLZqN0cJtAEd
        8bvKOIjHXypIW3AQ==
From:   tip-bot2 for Luciano =?utf-8?q?Le=C3=A3o?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/cpu: Include the header of
 init_ia32_feat_ctl()'s prototype
Cc:     lucianorsleao@gmail.com, Borislav Petkov <bp@suse.de>,
        n@nfraprado.net, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220922200053.1357470-1-lucianorsleao@gmail.com>
References: <20220922200053.1357470-1-lucianorsleao@gmail.com>
MIME-Version: 1.0
Message-ID: <166420566460.401.3267753468961488287.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     30ea703a38ef76ca119673cd8bdd05c6e068e2ac
Gitweb:        https://git.kernel.org/tip/30ea703a38ef76ca119673cd8bdd05c6e06=
8e2ac
Author:        Luciano Le=C3=A3o <lucianorsleao@gmail.com>
AuthorDate:    Thu, 22 Sep 2022 17:00:54 -03:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 26 Sep 2022 17:06:27 +02:00

x86/cpu: Include the header of init_ia32_feat_ctl()'s prototype

Include the header containing the prototype of init_ia32_feat_ctl(),
solving the following warning:

  $ make W=3D1 arch/x86/kernel/cpu/feat_ctl.o
  arch/x86/kernel/cpu/feat_ctl.c:112:6: warning: no previous prototype for =
=E2=80=98init_ia32_feat_ctl=E2=80=99 [-Wmissing-prototypes]
    112 | void init_ia32_feat_ctl(struct cpuinfo_x86 *c)

This warning appeared after commit

  5d5103595e9e5 ("x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during wakeu=
p")

had moved the function init_ia32_feat_ctl()'s prototype from
arch/x86/kernel/cpu/cpu.h to arch/x86/include/asm/cpu.h.

Note that, before the commit mentioned above, the header include "cpu.h"
(arch/x86/kernel/cpu/cpu.h) was added by commit

  0e79ad863df43 ("x86/cpu: Fix a -Wmissing-prototypes warning for init_ia32_f=
eat_ctl()")

solely to fix init_ia32_feat_ctl()'s missing prototype. So, the header
include "cpu.h" is no longer necessary.

  [ bp: Massage commit message. ]

Fixes: 5d5103595e9e5 ("x86/cpu: Reinitialize IA32_FEAT_CTL MSR on BSP during =
wakeup")
Signed-off-by: Luciano Le=C3=A3o <lucianorsleao@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: N=C3=ADcolas F. R. A. Prado <n@nfraprado.net>
Link: https://lore.kernel.org/r/20220922200053.1357470-1-lucianorsleao@gmail.=
com
---
 arch/x86/kernel/cpu/feat_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 993697e..0385124 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/tboot.h>
=20
+#include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/msr-index.h>
 #include <asm/processor.h>
 #include <asm/vmx.h>
-#include "cpu.h"
=20
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
