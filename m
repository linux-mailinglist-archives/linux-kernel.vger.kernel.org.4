Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917D66D72C6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 05:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjDED52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDED50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 23:57:26 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC323A9C;
        Tue,  4 Apr 2023 20:57:24 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 97F78604EF;
        Wed,  5 Apr 2023 05:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680667040; bh=HZuD+MKn7phIrvRfAMJbjIdkN1k3kb2qlxRisHEGii4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h5ta7N2GfaKPbHi1nNgEm9lrYvvcJwKFIFEqQy7cDBQpTnBcPshHGLUkd92fPWCz8
         6efMGUfKmaDEFt/E5+NlzsY1GfMPC+RNW+aNV+FvHCd5XpQlfjsXnv/dV923+WS6Jv
         AxC5V3Uz9Nr8ohcXy1rRigOP8/crtv12z2qC3OqVxim1LR3z4x9iXP3ltu+2XDJw2p
         iOLZ4ksUP36TK6x/8/nuUvqeQu3qi0KYwCIPljwckK05DrOKEunwLl0OPwiswzYrcR
         /BIS47bZ9wJR/jQAR2rwqwM4Ww3YAGAw3mFPF6+RMAMI/7V5F7CtAYCOgikyCcQDzH
         TW3fcfLFLF4kg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jJKGqjeFbw94; Wed,  5 Apr 2023 05:57:17 +0200 (CEST)
Received: from [192.168.1.4] (unknown [94.250.188.177])
        by domac.alu.hr (Postfix) with ESMTPSA id 69C6B604ED;
        Wed,  5 Apr 2023 05:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680667037; bh=HZuD+MKn7phIrvRfAMJbjIdkN1k3kb2qlxRisHEGii4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bmeVjFzu8bq40L0K77soTcH9sQD/pSNHYU8J/iAj8zRsce5K5ekJsWhL+GOkwa4V4
         vHvkxQ77AhuFGL6wqisWoQhmEcG3cRfzFYGjB3ZRi6dMGd73QJ9PS4CGD4q8Oyyz0S
         AOg01Qss0yZJOByMZp8oKNEVvGv+N7MeRfPSS1kjO4kAyDX4oIPvYFMdXCx1XBfXpV
         ozDIqMgltC1UoFZSKhHQdwbKm9EtcgjvjJ8W++6dDuuBBOmrRysHNqXVy+foxgc42h
         0yuTpf9W/WhJ4sENrdKt2mFIuVBwJPIkVSKn9se//ysfWihgRQFQgUKGrynpL2hYZl
         qggc4u3vkZRPQ==
Message-ID: <5d6332fc-a64a-5e1a-33e0-a7f1e31b2f90@alu.unizg.hr>
Date:   Wed, 5 Apr 2023 05:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] tracing: Free error logs of tracing instances
Content-Language: en-US, hr
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20230404194504.5790b95f@gandalf.local.home>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230404194504.5790b95f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 04. 2023. 01:45, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When a tracing instance is removed, the error messages that hold errors
> that occurred in the instance needs to be freed. The following reports a
> memory leak:
> 
>  # cd /sys/kernel/tracing
>  # mkdir instances/foo
>  # echo 'hist:keys=x' > instances/foo/events/sched/sched_switch/trigger
>  # cat instances/foo/error_log
>  [  117.404795] hist:sched:sched_switch: error: Couldn't find field
>    Command: hist:keys=x
>                       ^
>  # rmdir instances/foo
> 
> Then check for memory leaks:
> 
>  # echo scan > /sys/kernel/debug/kmemleak
>  # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88810d8ec700 (size 192):
>   comm "bash", pid 869, jiffies 4294950577 (age 215.752s)
>   hex dump (first 32 bytes):
>     60 dd 68 61 81 88 ff ff 60 dd 68 61 81 88 ff ff  `.ha....`.ha....
>     a0 30 8c 83 ff ff ff ff 26 00 0a 00 00 00 00 00  .0......&.......
>   backtrace:
>     [<00000000dae26536>] kmalloc_trace+0x2a/0xa0
>     [<00000000b2938940>] tracing_log_err+0x277/0x2e0
>     [<000000004a0e1b07>] parse_atom+0x966/0xb40
>     [<0000000023b24337>] parse_expr+0x5f3/0xdb0
>     [<00000000594ad074>] event_hist_trigger_parse+0x27f8/0x3560
>     [<00000000293a9645>] trigger_process_regex+0x135/0x1a0
>     [<000000005c22b4f2>] event_trigger_write+0x87/0xf0
>     [<000000002cadc509>] vfs_write+0x162/0x670
>     [<0000000059c3b9be>] ksys_write+0xca/0x170
>     [<00000000f1cddc00>] do_syscall_64+0x3e/0xc0
>     [<00000000868ac68c>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> unreferenced object 0xffff888170c35a00 (size 32):
>   comm "bash", pid 869, jiffies 4294950577 (age 215.752s)
>   hex dump (first 32 bytes):
>     0a 20 20 43 6f 6d 6d 61 6e 64 3a 20 68 69 73 74  .  Command: hist
>     3a 6b 65 79 73 3d 78 0a 00 00 00 00 00 00 00 00  :keys=x.........
>   backtrace:
>     [<000000006a747de5>] __kmalloc+0x4d/0x160
>     [<000000000039df5f>] tracing_log_err+0x29b/0x2e0
>     [<000000004a0e1b07>] parse_atom+0x966/0xb40
>     [<0000000023b24337>] parse_expr+0x5f3/0xdb0
>     [<00000000594ad074>] event_hist_trigger_parse+0x27f8/0x3560
>     [<00000000293a9645>] trigger_process_regex+0x135/0x1a0
>     [<000000005c22b4f2>] event_trigger_write+0x87/0xf0
>     [<000000002cadc509>] vfs_write+0x162/0x670
>     [<0000000059c3b9be>] ksys_write+0xca/0x170
>     [<00000000f1cddc00>] do_syscall_64+0x3e/0xc0
>     [<00000000868ac68c>] entry_SYSCALL_64_after_hwframe+0x72/0xdc
> 
> The problem is that the error log needs to be freed when the instance is
> removed.
> 
> Link: https://lore.kernel.org/lkml/76134d9f-a5ba-6a0d-37b3-28310b4a1e91@alu.unizg.hr/
> 
> Cc: stable@vger.kernel.org
> Fixes: 2f754e771b1a6 ("tracing: Have the error logs show up in the proper instances")
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ae51f1dea8e..352a804b016d 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9516,6 +9516,7 @@ static int __remove_instance(struct trace_array *tr)
>  	tracefs_remove(tr->dir);
>  	free_percpu(tr->last_func_repeats);
>  	free_trace_buffers(tr);
> +	clear_tracing_err_log(tr);
>  
>  	for (i = 0; i < tr->nr_topts; i++) {
>  		kfree(tr->topts[i].topts);

Hello,

Apparently, this fixed the issue (leak) with the same config, kernel commit and
HW.

Please add

Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

at your convenience.

The bisect was obviously misleading, but not intentionally. This is the first time
my bisect was wrong (out of five or six), so I will thoroughly investigate the fault,
for - needless to say - quality binary search bisect is essential to hunt down bugs.

But they say that "Nobody wins them all."

Thank you very much for patching this at such a short notice.

(I cannot remember why I did not Cc: kernel/trace developers back then on Jan 27th,
probably I thought the test independently triggered vfs_write() bug.)

Have a nice evening, and God bless!!

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

