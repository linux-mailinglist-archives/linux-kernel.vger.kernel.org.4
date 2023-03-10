Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663406B525E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCJUz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjCJUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:54:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3EF136894;
        Fri, 10 Mar 2023 12:54:54 -0800 (PST)
Date:   Fri, 10 Mar 2023 20:54:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678481692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqbewNBczoo3bF06S0q1OyIw53gsnHtNQwBqPxSbp6Y=;
        b=YhVZ/pNgjFgYGz3qwAEfyUtr+u0L+o0XH+3S3x41H0RD0l0F/8An0MiPgEp6TnYJbXNfbv
        VN+TmoNE6KfwBcbi6LLndsWOwirXhRfNmJy/NRJUbDHlqms/z344uAK2uWX4Xw367KcUEC
        dYIsBjwbKuDeheF+fnlUOwIPlz2wxGgELWyuEWGimFfAoIrihRQV5498bglJ8+nqw6DWS1
        0eNnq1Vrdp1Eer7JqNan0MTZhf4P9sWNjBDeYQlBl+BoVNDJSXbuUlwDRQ2rNkq8TACjXB
        SvuwzMKOTFdzmdAWuWswe/o8Ki/mGkPxUYpncagcteRlwc4Rsl+igfSe8pwxvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678481692;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqbewNBczoo3bF06S0q1OyIw53gsnHtNQwBqPxSbp6Y=;
        b=a4BC9vkizVeB0iEnS3BBzk178GFoNHU5gMFR9QM2keVBvGYlGq7tkaQFQ1RiNFsJ5yNiqT
        +GMMbbdkAi9XDsBA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] mips/cpu: Mark play_dead() __noreturn
Cc:     Florian Fainelli <f.fainelli@gmail.com>, philmd@linaro.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2897b51a9b8beb5b594fe66fb1d3a479ddd2a0e2.1676358308.git.jpoimboe@kernel.org>
References: <2897b51a9b8beb5b594fe66fb1d3a479ddd2a0e2.1676358308.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167848169199.5837.7685473363893004243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9e57f049d1571db1dc77c69c87403defc9d3e5ae
Gitweb:        https://git.kernel.org/tip/9e57f049d1571db1dc77c69c87403defc9d=
3e5ae
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 13 Feb 2023 23:05:45 -08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 08 Mar 2023 08:44:23 -08:00

mips/cpu: Mark play_dead() __noreturn

play_dead() doesn't return.  Annotate it as such.  By extension this
also makes arch_cpu_idle_dead() noreturn.

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Link: https://lore.kernel.org/r/2897b51a9b8beb5b594fe66fb1d3a479ddd2a0e2.1676=
358308.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/include/asm/smp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 5d9ff61..4eee29b 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -88,7 +88,7 @@ static inline void __cpu_die(unsigned int cpu)
 	mp_ops->cpu_die(cpu);
 }
=20
-extern void play_dead(void);
+extern void __noreturn play_dead(void);
 #endif
=20
 #ifdef CONFIG_KEXEC
