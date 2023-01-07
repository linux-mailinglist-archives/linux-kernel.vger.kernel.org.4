Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1A660E32
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjAGLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAGLEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:04:55 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9879F4F124;
        Sat,  7 Jan 2023 03:04:54 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay40so2704294wmb.2;
        Sat, 07 Jan 2023 03:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jV2yBF+mbkDE0BvyOwe05ARE6EO7XhtOfB/KJLMsfFA=;
        b=BzPTx+ODS2RwGu5d9Av3CGI6XJ0NbmKP1pStUzg0M0m6+VF6wu2vf0tqTwK0k6q0qV
         Fbx7Y4Wluy9p+k8PZjL3FOoLufHJHxtq2K/BaarEwd/dPtd/DgO4uDiDqLUXCcfzSy4g
         Wd0wz4xfpZYGbxR/O6enZWRjIhs25ZrrKgwvTGouDcupcbkSfLeRveiApotbcr4XMgph
         w/4+08uhP/RwKAozhcyw6lYPvScMk8zL6fmWwbkyxQOkT9WdSUz8lze9ta3Mlh7zLg9k
         cM2v76pe7iQT/2ZR+EkGweLVXlhhfTIoWJwjo2u32vXfi3qjeDrWte72tROnSs3wxhtS
         1Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV2yBF+mbkDE0BvyOwe05ARE6EO7XhtOfB/KJLMsfFA=;
        b=f6beJaoz3jCOL/c6eOjf3eeUBcHKDVUaH0Uw7trbB+q3preXNB8XQN+BgMEgXIqyrg
         ztQ0YAwwQaBudBMFT671W0eam+CskRUARfQ2XtTMgg7PiwB16C4qvG0b2DGR8BAeYCdV
         bjE0ugK+fesG9oz6KyRgSvF1+EPPvRlWpElpDIRlqjl3n5CE931DsOVRR67+Oc0OvvUU
         qarRyALAo/0CgrsP1WoMbvFscUnStpWk5q7ULbXRDwxCcfn2VYXgqtcJFerXS2Z6O5F8
         beGTpGvDntwL4xWdS5LKe1BVCIIzmFG6ZI1prA001YwkI8usgU5FZC7q8O2rG9nMPSjr
         Vt0w==
X-Gm-Message-State: AFqh2kp6KNn7SZRVsi7FHGQnApV2HTmVi/cE5A8/t+/ipcJNN8L/Cf0I
        P0aGIHmiHJAhWmac1ay0yUU=
X-Google-Smtp-Source: AMrXdXuUafS1AFxogNrZXZJj6k6oC1QjVGeJmfZCRFdf2sgwNHMbrVBUD4+y7GGme2gWJhcqxBhA0A==
X-Received: by 2002:a05:600c:601e:b0:3c6:e61e:ae71 with SMTP id az30-20020a05600c601e00b003c6e61eae71mr50341357wmb.1.1673089493118;
        Sat, 07 Jan 2023 03:04:53 -0800 (PST)
Received: from gmail.com (1F2EF507.nat.pool.telekom.hu. [31.46.245.7])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003c6f8d30e40sm10657278wms.31.2023.01.07.03.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jan 2023 03:04:50 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 7 Jan 2023 12:04:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
Message-ID: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202155817.2102944-4-vschneid@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <vschneid@redhat.com> wrote:

> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
> of smp_call_function*() via either generic_exec_single() or
> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
> 
> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Ingo Molnar <mingo@kernel.org>

Patch series logistics:

 - No objections from the scheduler side, this feature looks pretty useful.

 - Certain patches are incomplete, others are noted as being merged 
   separately, so I presume you'll send an updated/completed series 
   eventually?

 - We can merge this via the scheduler tree I suspect, as most callbacks 
   affected relate to tip:sched/core and tmp:smp/core - but if you have 
   some other preferred tree that's fine too.

Thanks,

	Ingo
