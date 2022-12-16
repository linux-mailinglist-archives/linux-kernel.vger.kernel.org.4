Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCB64E9AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLPKp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 05:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 05:45:23 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955601BEAB
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:45:22 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a16so3033359edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfKEqRAnCk1XoFzkUavcpoDLtAY1Rz2nZE3D5K7l538=;
        b=rCgB4A2V+Oz1UM8NAbAxIpEmw5z9zXoYymJhqazd5FeIwyU36CZj4hY1CMcodSVBWz
         kBnsy10GF//kUYo3O1vuIXL7WIaT/XO+6IBBK5GDn9VR01NhtjzTSvYvYpft8vifewWD
         m2rVC0Cgg+GwpUVPY8Dwot18pdqU+A+yNtt2dtPft0ZjTFUkBynLW+ZYKZhGihBEp+M+
         y5bXy5D/qgYtRryZP7R6T05m8hTsqY8GVXpeaWdsy3EFlGX46/yrdjOj7LXJmVpKqRH0
         ZnqGFfXPujTV/ehwfLory2lvYGbJSEysepZRi7LAiv3bKNm1JM+rJNWMC84+4v2Om04w
         b0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfKEqRAnCk1XoFzkUavcpoDLtAY1Rz2nZE3D5K7l538=;
        b=wKbewI5ZsTVkyv7LvFZwJTLUmW2C+rnGSu7YmDB5msp0LW58w73/tUiqJfQbegIqge
         P0h32e02dc9zEmDpD3RFI+6aXIeeqn1M+v8luz1wrYoVaHb9onwMitiKUNuRKJgKzSNG
         82uvyz0IT+MEnkhjRY94qmzIu9v51Yc1WNrflb2UXt3FsUKeSqbaGTRNcp5F2bxXBxiT
         yL1PE63spdtly2EftwXdbp/eZxAW94J13LKHFW5srBpYenYs6cNnhAPTKSgheYU6vUmG
         VU1n0+17YLOAiTnoA87accqK48JbijEgpsQKpl7qtRqIu4b/ge4Y2GDuy8TlVXgDQWLm
         aY3g==
X-Gm-Message-State: ANoB5pkKl9l3Ejpu/irFeAVsN22ykp6qwmc/8KVuGxKhdMIe+2ZzcMWQ
        j8OWMsvTbfp1EIifKVDltpCizUFjrlGcWEaqP3FpmJ3NvmOrQiPgIeY=
X-Google-Smtp-Source: AA0mqf6/bON0/tO+hvyAlOPEUEFLU6+KpvH9QUl6JWX+jtbzuhCsUQa70EjpcuFkFtFkDnaocA++CTuIRq/0TXhgEqk=
X-Received: by 2002:a05:6402:1c1d:b0:46d:66ea:a5c2 with SMTP id
 ck29-20020a0564021c1d00b0046d66eaa5c2mr7683071edb.284.1671187521142; Fri, 16
 Dec 2022 02:45:21 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 16 Dec 2022 11:45:10 +0100
Message-ID: <CADYN=9LfFwNjToc8nhrD1MMZnQptyMNjbEFaMjPXuzzxADMbsA@mail.gmail.com>
Subject: BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
To:     thunder.leizhen@huawei.com, mcgrof@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm building an arm64 allmodconfig kernel (see the .config [1]) on
yesterdays next tag 20221215 with KALLSYMS_SELFTEST enabled and I saw
the following bug when the selftest ran:

[29725.015182][   T58] BUG: sleeping function called from invalid
context at kernel/kallsyms.c:305
[29725.022953][   T58] in_atomic(): 0, irqs_disabled(): 128,
non_block: 0, pid: 58, name: kallsyms_test
[29725.031272][   T58] preempt_count: 0, expected: 0
[29725.035903][   T58] RCU nest depth: 0, expected: 0
[29725.040574][   T58] no locks held by kallsyms_test/58.
[29725.045494][   T58] irq event stamp: 18899904
[29725.049809][ T58] hardirqs last enabled at (18899903):
finish_task_switch.isra.0 (core.c:?)
[29725.059608][ T58] hardirqs last disabled at (18899904):
test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
[29725.069936][ T58] softirqs last enabled at (18899886): __do_softirq (??:?)
[29725.078670][ T58] softirqs last disabled at (18899879):
____do_softirq (irq.c:?)
[29725.087399][   T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G
             T  6.1.0-next-20221215 #2
0a142be8faea13ac333ed9a1cf4e71b6966ad16e
[29725.099607][   T58] Hardware name: linux,dummy-virt (DT)
[29725.104674][   T58] Call trace:
[29725.107909][ T58] dump_backtrace (??:?)
[29725.112706][ T58] show_stack (??:?)
[29725.116883][ T58] dump_stack_lvl (??:?)
[29725.121666][ T58] dump_stack (??:?)
[29725.125852][ T58] __might_resched (??:?)
[29725.130712][ T58] kallsyms_on_each_symbol (??:?)
[29725.136018][ T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
[29725.142008][ T58] test_entry (kallsyms_selftest.c:?)
[29725.146312][ T58] kthread (kthread.c:?)
[29725.150567][ T58] ret_from_fork (??:?)
[29734.975283][   T58] kallsyms_selftest: kallsyms_on_each_symbol()
traverse all: 5744310840 ns
[29734.992268][   T58] kallsyms_selftest:
kallsyms_on_each_match_symbol() traverse all: 1164580 ns
[29735.049679][   T58] kallsyms_selftest: finish

looks like the issue is that test_perf_kallsyms_on_each_symbol() does
these function calls:

       local_irq_save(flags);
       t0 = sched_clock();
       kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
       t1 = sched_clock();
       local_irq_restore(flags);

and inside kallsyms_on_each_match_symbol(), cond_resched() is called.

Any ideas how to solve this?

Cheers,
Anders
[1] https://people.linaro.org/~anders.roxell/next-20221215.config
