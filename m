Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2931C6A7346
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCASQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCASQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:16:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8B4BEB6;
        Wed,  1 Mar 2023 10:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CCF6145E;
        Wed,  1 Mar 2023 18:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41182C433EF;
        Wed,  1 Mar 2023 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677694603;
        bh=y8I+qHPjyMsWTIcZZzinTslQl9KBS0SHFE/bCto1EBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jgvht4/35VGCp62Mm0crvOWS+Q7yksEpq6+xalFSCejazQSuSFo7RkAWv8vzHB9S2
         zSy/z5Ss9N5OsVMpm/HzrMXHuWn7HjaEGg9AyzGemnp6Rfdd/r+gRYAGt5E/grCKaY
         X2FljVYzonJlRyi4MEX9i01auwqLdTducL4xcx2MIAX09cIiSGLJDeVasqEnZsN3Vo
         LsgtvCrNy6uIrbuQ7oURfpO6JyzJiRyDby5JhWqmOoSrGxzF3cyQh0NFHygpNf7/m9
         a/zuTndIX0Ftw16vWcuXp1h96arpnB/D6P/tnWRBJjLkk9cGU04BzQjtCx6PDs5EjX
         5Blvv0WLKwW1w==
Date:   Wed, 1 Mar 2023 10:16:39 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     linux-kernel@vger.kernel.org, jgross@suse.com,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
Subject: Re: [PATCH v2.1 09/24] mips/cpu: Expose play_dead()'s prototype
 definition
Message-ID: <20230301181639.ajqdeh7g3m3fpqhk@treble>
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <39835bc75af2e812fce56400533cb2ab41bcf0e2.1676358308.git.jpoimboe@kernel.org>
 <080a5ccb-7fa0-1a75-538f-a09dc146fc4e@linaro.org>
 <20230214181101.3a2tscbmwdnwbqpu@treble>
 <c56dc4b9-035d-7773-ecb2-0e1ac6af7abc@linaro.org>
 <20230216184249.ogaqsaykottpxtcb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216184249.ogaqsaykottpxtcb@treble>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:42:52AM -0800, Josh Poimboeuf wrote:
> Include <asm/smp.h> to make sure play_dead() matches its prototype going
> forward.
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

The latest version of this patch triggered a new kbuild warning which is
fixed by the below patch.  If there are no objections I'll bundle it in
with the rest of the set for merging.

---8<---

Subject: [PATCH] mips/smp: Add CONFIG_SMP guard for raw_smp_processor_id()
Content-type: text/plain

Without CONFIG_SMP, raw_smp_processor_id() is not expected to be defined
by the arch.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302220755.HM8J8GOR-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/mips/include/asm/smp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index 4eee29b7845c..cf992b8b1e46 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -25,6 +25,7 @@ extern cpumask_t cpu_sibling_map[];
 extern cpumask_t cpu_core_map[];
 extern cpumask_t cpu_foreign_map[];
 
+#ifdef CONFIG_SMP
 static inline int raw_smp_processor_id(void)
 {
 #if defined(__VDSO__)
@@ -36,6 +37,7 @@ static inline int raw_smp_processor_id(void)
 #endif
 }
 #define raw_smp_processor_id raw_smp_processor_id
+#endif
 
 /* Map from cpu id to sequential logical cpu number.  This will only
    not be idempotent when cpus failed to come on-line.	*/
-- 
2.39.1

