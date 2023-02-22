Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE369FB36
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbjBVSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjBVSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:40:21 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE02E815
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:40:07 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:38986)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pUu24-00Dnet-QD; Wed, 22 Feb 2023 11:40:00 -0700
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:55064 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pUu23-008QvD-8P; Wed, 22 Feb 2023 11:40:00 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Zeng Heng <zengheng4@huawei.com>,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        tiwai@suse.de, jolsa@kernel.org, vbabka@suse.cz,
        keescook@chromium.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, bp@alien8.de, bhe@redhat.com,
        eric.devolder@oracle.com, hpa@zytor.com, jroedel@suse.de,
        dave.hansen@linux.intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com, x86@kernel.org,
        xiexiuqi@huawei.com
References: <20230217120604.435608-1-zengheng4@huawei.com>
        <Y/ZMEesgPnRR3LsG@hirez.programming.kicks-ass.net>
Date:   Wed, 22 Feb 2023 12:39:22 -0600
In-Reply-To: <Y/ZMEesgPnRR3LsG@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 22 Feb 2023 18:08:33 +0100")
Message-ID: <87r0uh5yud.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1pUu23-008QvD-8P;;;mid=<87r0uh5yud.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/dxRcuxLgBwhyAiPUu5WcSTmvMIC31BhU=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 944 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.2%), b_tie_ro: 10 (1.0%), parse: 0.99
        (0.1%), extract_message_metadata: 18 (1.9%), get_uri_detail_list: 2.6
        (0.3%), tests_pri_-2000: 18 (1.9%), tests_pri_-1000: 2.8 (0.3%),
        tests_pri_-950: 1.31 (0.1%), tests_pri_-900: 1.07 (0.1%),
        tests_pri_-200: 0.90 (0.1%), tests_pri_-100: 12 (1.3%), tests_pri_-90:
        78 (8.3%), check_bayes: 73 (7.8%), b_tokenize: 15 (1.5%),
        b_tok_get_all: 13 (1.4%), b_comp_prob: 4.1 (0.4%), b_tok_touch_all: 38
        (4.0%), b_finish: 0.81 (0.1%), tests_pri_0: 435 (46.0%),
        check_dkim_signature: 0.75 (0.1%), check_dkim_adsp: 4.0 (0.4%),
        poll_dns_idle: 342 (36.3%), tests_pri_10: 2.2 (0.2%), tests_pri_500:
        358 (37.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH v4] x86/kdump: terminate watchdog NMI interrupt to
 avoid kdump crashes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Feb 17, 2023 at 08:06:04PM +0800, Zeng Heng wrote:
>> If the cpu panics within the NMI interrupt context, there could be
>> unhandled NMI interrupts in the background which are blocked by processor
>> until next IRET instruction executes. Since that, it prevents nested
>> NMI handler execution.
>> 
>> In case of IRET execution during kdump reboot and no proper NMIs handler
>> registered at that point (such as during EFI loader)

EFI loader?  kexec on panic is supposed to be kernel to kernel.
If someone is getting EFI involved that is a bug.

>>, we need to ensure
>> watchdog no work any more, or kdump would crash later. So call
>> perf_event_exit_cpu() at the very last moment in the panic shutdown.

Why can't the crash recovery kernel handle this?

Sometimes we very much do have cases where the crash recovery kernel
can not handle it and we can in the dying kernel.  But every line
of code that is added to the code path the crashing kernel takes
increases the probability that something will go wrong and a crash
will not be captured.

>> !! Here I know it's not allowed to call perf_event_exit_cpu() within nmi
>> context, because of mutex_lock, smp_call_function and so on.
>> Is there any experts know about the similar function which allowed to call
>> within atomic context (Neither x86_pmu_disable() nor x86_pmu_disable_all()
>> do work after my practice)?
>> 
>> Thank you in advance.
>> 
>> Here provide one of test case to reproduce the concerned issue:
>>   1. # cat uncorrected
>>      CPU 1 BANK 4
>>      STATUS uncorrected 0xc0
>>      MCGSTATUS  EIPV MCIP
>>      ADDR 0x1234
>>      RIP 0xdeadbabe
>>      RAISINGCPU 0
>>      MCGCAP SER CMCI TES 0x6
>>   2. # modprobe mce_inject
>>   3. # mce-inject uncorrected
>> 
>> Mce-inject would trigger kernel panic under NMI interrupt context. In
>> addition, we need another NMI interrupt raise (such as from watchdog)
>> during panic process. Set proper watchdog threshold value and/or add an
>> artificial delay to make sure watchdog interrupt raise during the panic
>> procedure and the involved issue would occur.
>> 
>> Fixes: ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   v1: add dummy NMI interrupt handler in EFI loader
>>   v2: tidy up changelog, add comments (by Ingo Molnar)
>>   v3: add iret_to_self() to deal with blocked NMIs in advance
>>   v4: call perf_event_exit_cpu() to terminate watchdog in panic shutdown
>> 
>>  arch/x86/kernel/crash.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 305514431f26..f46df94bbdad 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/memblock.h>
>> +#include <linux/perf_event.h>
>> 
>>  #include <asm/processor.h>
>>  #include <asm/hardirq.h>
>> @@ -170,6 +171,15 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
>>  #ifdef CONFIG_HPET_TIMER
>>  	hpet_disable();
>>  #endif
>> +
>> +	/*
>> +	 * If the cpu panics within the NMI interrupt context,
>> +	 * we need to ensure no more NMI interrupts blocked by
>> +	 * processor. In case of IRET execution during kdump
>> +	 * path and no proper NMIs handler registered at that
>> +	 * point, here terminate watchdog in panic shutdown.
>> +	 */
>> +	perf_event_exit_cpu(smp_processor_id());
>
> This kills all of perf, including but not limited to the hardware
> watchdog. However, it does nothing to external NMI sources like the NMI
> button found on some HP machines.
>
> Still I suppose it is sufficient for the normal case.

Except the architecture appears to be wrong.  I don't see any
explanation and I can't think of one why we don't just leave
NMIs deliberately disabled until the crash recover kernel
figured out how to enable them safely.

Eric


>>  	crash_save_cpu(regs, safe_smp_processor_id());
>>  }
>> 
>> --
>> 2.25.1
>> 
