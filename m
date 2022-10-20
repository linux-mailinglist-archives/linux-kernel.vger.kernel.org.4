Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC6606612
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJTQoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJTQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:44:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F71D376C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:44:04 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 8so298196qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCYmgHvEPKbZ5vruevbjABctVUy0E3HVNWMddp3+fnE=;
        b=b1FaMx4zpmPyHn37fxHeyedzFXbiVAWmXlhQ+gdkz7isW69U2iI7sPk7/GY6VzmSae
         YOygspvS1fYRYByQx231URmi0ClvfoW7Xdmu5U8xaXZnsRNbZbSl6jRkvchaDZg7gXvl
         4e7t0EeVz1qqUQb4d06qppLeVAvbQ79eVgzEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:date:cc:in-reply-to:from:mime-version
         :subject:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCYmgHvEPKbZ5vruevbjABctVUy0E3HVNWMddp3+fnE=;
        b=ubBZf6dDUsYSBcHjBH0LhYmPkurMN5IUzRCiwRON4oBZykGJP9gSuGMDM5P5QBAGZ0
         uRmb7uPMT0jnV220N81rhWZFkefSt4F8Nt4fgYhTdM6Go7fIXuCxAjc31KKO42BZ/KLr
         MahLcn2gGQTFz+7pROmCBvw9sDhK33UzxfZyTm9L9QN0tupHa9IfDZax+Rhjr34MD+7V
         IX7Mwu4billCZnoXRnUUorwcxUmHanMqGwvzTg4EyyQB+rgwXQN8jdV4pTv1/+u78sBe
         RPOjEZV4b/7wbQhIgdDWaBsPHVugMTm85r7RuuFxnBS5fXFcUeCo06B6UzdxgQPbHa9w
         pp3Q==
X-Gm-Message-State: ACrzQf1vtYvUu7bVuCVnO1KrpqN0zY6mM2aE7Yk16wu5hau7rnE6ySpz
        OcKaZTSzhzCI+GYTLN+eMI+RnuLRy8HQ7A==
X-Google-Smtp-Source: AMsMyM5r4V5C0jVIZ0eGtdde2+6n0yR4PZDdcNJelmW/ywCjRcgv67MYG6GR3jsoxbgNGXWsy16NkA==
X-Received: by 2002:a05:620a:95b:b0:6ec:90d2:5fe7 with SMTP id w27-20020a05620a095b00b006ec90d25fe7mr9945946qkw.425.1666284243742;
        Thu, 20 Oct 2022 09:44:03 -0700 (PDT)
Received: from smtpclient.apple (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id w28-20020a05622a191c00b0039bfe8acff6sm6252155qtc.58.2022.10.20.09.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 09:44:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tracing: Add trace_trigger kernel command line option
Mime-Version: 1.0 (1.0)
X-Apple-Notify-Thread: NO
X-Universally-Unique-Identifier: A4F70607-8B1E-49F6-B059-128D5035B89F
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20221020123357.0f90e823@gandalf.local.home>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Thu, 20 Oct 2022 12:44:02 -0400
X-Apple-Message-Smime-Encrypt: NO
Message-Id: <7D1D0BC3-F596-408F-8920-073D7BCAF546@joelfernandes.org>
References: <20221020123357.0f90e823@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: iPhone Mail (19G82)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 20, 2022, at 12:33 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> =EF=BB=BFOn Thu, 20 Oct 2022 08:59:00 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
>=20
>>> On Wed, Oct 19, 2022 at 08:07:45PM -0400, Steven Rostedt wrote:
>>> On Wed, 19 Oct 2022 20:01:37 -0400
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>=20
>>>> @@ -90,6 +90,10 @@ int unregister_tracepoint_module_notifier(struct not=
ifier_block *nb)
>>>> #ifdef CONFIG_TRACEPOINTS
>>>> static inline void tracepoint_synchronize_unregister(void)
>>>> {
>>>> +    /* Early updates do not need synchronization */
>>>> +    if (early_boot_irqs_disabled)
>>>> +        return;
>>>> +
>>>>    synchronize_srcu(&tracepoint_srcu);
>>>>    synchronize_rcu(); =20
>>>=20
>>> I wonder if this check should be just moved to the RCU synchronization
>>> code? That is, if early_boot_irqs_disabled is set, do nothing, as there
>>> should be nothing to synchronize against. =20
>>=20
>> There already is a similar check, but it follows the lockdep check.
>>=20
>> Does the following patch help?
>=20
> Not sure if it would.
>=20
> I added this:

I=E2=80=99m not working today, so I can=E2=80=99t look very closely. But cou=
ld you remove
the might_sleep() from rcu_gp_is_blocking() and see if it fixes your issue?

I think that function call might be incompatible with early boot. Just a hun=
ch.

  - Joel


> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c03fd7037add..79ac31a6a87b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2748,9 +2748,12 @@ void trace_buffered_event_disable(void)
>                   disable_trace_buffered_event, NULL, 1);
>    preempt_enable();
>=20
> +    if (!irqs_disabled())
> +        printk("IRQS DISABLED!! before %s:%d\n", __func__, __LINE__);
>    /* Wait for all current users to finish */
> -    if (!early_boot_irqs_disabled)
> -        synchronize_rcu();
> +    synchronize_rcu();
> +    if (!irqs_disabled())
> +        printk("IRQS DISABLED!! after %s:%d\n", __func__, __LINE__);
>=20
>    for_each_tracing_cpu(cpu) {
>        free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
>=20
> Which produced this:
>=20
>=20
> [    0.972867] ftrace: allocating 47021 entries in 184 pages
> [    0.978285] ftrace section at ffffffffacef74c0 sorted properly
> [    0.991153] ftrace: allocated 184 pages with 4 groups
> [    0.996163] Dynamic Preempt: full
> [    0.999354] rcu: Preemptible hierarchical RCU implementation.
> [    1.005020] rcu:     RCU restricting CPUs from NR_CPUS=3D128 to nr_cpu_=
ids=3D8.
> [    1.011680]  Tasks-RCU CPU stall warnings timeout set to 120000 (rcu_ta=
sk_stall_timeout).
> [    1.019813]  Trampoline variant of Tasks RCU enabled.
> [    1.024831]  Rude variant of Tasks RCU enabled.
> [    1.029330]  Tracing variant of Tasks RCU enabled.
> [    1.034089] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
> [    1.041699] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_id=
s=3D8
> [    1.052607] IRQS DISABLED!! after trace_buffered_event_disable:2756
> [    1.058712] NR_IRQS: 8448, nr_irqs: 488, preallocated irqs: 16
> [    1.064670] NO_HZ: Full dynticks CPUs: 3.
> [    1.068501] rcu:     Offload RCU callbacks from CPUs: 3.
> [    1.073519] rcu: srcu_init: Setting srcu_struct sizes based on contenti=
on.
> [    1.080400] ------------[ cut here ]------------
> [    1.084938] Interrupts were enabled early
> [    1.088919] WARNING: CPU: 0 PID: 0 at init/main.c:1061 start_kernel+0x3=
6f/0x4e8
> [    1.096184] Modules linked in:
> [    1.099213] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.1.0-rc1-test+ #=
468
> [    1.106047] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A,=
 BIOS K01 v03.03 07/14/2016
> [    1.114960] RIP: 0010:start_kernel+0x36f/0x4e8
> [    1.119373] Code: 48 27 53 e8 fd 7b 03 00 e8 55 72 e5 fe e8 6b 05 03 00=
 ff 15 2a f9 89 ff 0f ba e0 09 73 0e 48 c7 c7 98 25 31 ac e8 01 5b df fe <0f=
> 0b c6 05 c7 2c af ff 00 e8 ba 36 47 fe ff 15 14 f9 89 ff e8 56
> [    1.138057] RSP: 0000:ffffffffac603f30 EFLAGS: 00010286
> [    1.143248] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000=
000000
> [    1.150343] RDX: 0000000000000002 RSI: 00000000ffffdfff RDI: 0000000000=
000001
> [    1.157438] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffffac=
603dd8
> [    1.164537] R10: 0000000000000003 R11: ffffffffac734168 R12: 0000000000=
00180a
> [    1.171633] R13: 00000000010fecf0 R14: 0000000000000000 R15: 00000000d4=
4e3018
> [    1.178730] FS:  0000000000000000(0000) GS:ffff93ee1aa00000(0000) knlGS=
:0000000000000000
> [    1.186778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.192489] CR2: ffff93ee1edff000 CR3: 000000002e60a001 CR4: 0000000000=
0606f0
> [    1.199584] Call Trace:
> [    1.202009]  <TASK>
>=20
>=20
> So I'm not sure how just updating srcu will do anything to prevent this.
>=20
> -- Steve
>=20
>>=20
>>                            Thanx, Paul
>>=20
>> ------------------------------------------------------------------------
>>=20
>> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>> index ca4b5dcec675b..356ef70d5442c 100644
>> --- a/kernel/rcu/srcutree.c
>> +++ b/kernel/rcu/srcutree.c
>> @@ -1267,14 +1267,15 @@ static void __synchronize_srcu(struct srcu_struct=
 *ssp, bool do_norm)
>> {
>>    struct rcu_synchronize rcu;
>>=20
>> +    if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>> +        return;
>> +
>>    RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
>>             lock_is_held(&rcu_bh_lock_map) ||
>>             lock_is_held(&rcu_lock_map) ||
>>             lock_is_held(&rcu_sched_lock_map),
>>             "Illegal synchronize_srcu() in same-type SRCU (or in RCU) rea=
d-side critical section");
>>=20
>> -    if (rcu_scheduler_active =3D=3D RCU_SCHEDULER_INACTIVE)
>> -        return;
>>    might_sleep();
>>    check_init_srcu_struct(ssp);
>>    init_completion(&rcu.completion);
>=20
