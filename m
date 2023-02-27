Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A4C6A4732
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB0Qlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0Qld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:41:33 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7A23107
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:41:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c18so7317810qte.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=mZK6LeX7z5VZYct/x3qbpKzfYxbIlheF7rhtEPOT3/8=;
        b=I5O5uZecNoO8yiPrQ8I40mdCE2jF9q9/jiCuSWkn4+4XpmLRp6+E/uHofwQaLm2tKK
         BaVnbOA0Cc9zD8CF4+vfUiUHAywVdR86dilzPLPVrpFT34+JzzZ4Z9yDWHUlsDoXXJNd
         9bW5z5455LPCpwyNQdPZ2JvvCTB4jMKcKizffH9BCrQQYp5XcRnxXZU9sfOUimoyOOta
         JFI7yKFKEUKijQTaQRm0VJAL74GrJ7viAQ+dm+tNQsOD+886Yo+IqDruoTecf767/50i
         vEr69rXB+xhsv00T1m9MRCWegS9EEYfzZM6x1YVnsD6qH9fV7pH/Uaz0jSTdnnMrQcpz
         1MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZK6LeX7z5VZYct/x3qbpKzfYxbIlheF7rhtEPOT3/8=;
        b=Ou1ePQIizI89wv5WoIAH2Q640vU20z3uOsNdXvc+FXEu61Y+18NMweeDXBWaxIbrSl
         i0ILorHc97+wEqqKowwB4xskFutC/UKfNgY4LTlWWu+NLRhSX1hBHIPnJ0ThFY4c4t5F
         1lAh31j62fxotOp7kVRDIQ/rCt/L1jqH4/GFkLbiMZzJJ4YUj9JUuvOpYjJx2wW3QZSJ
         Sx5+oaWoht4udRkTO9p6RDKq1+G6GlQocioEZCPn6apqW1iO8RMSOqAancG85W02/HCU
         NrM+za1w2alvS/s0Fu/9jOWPqr1wAZL0opAzIKW7BD8nLJMZC6NLIiv2d31YbwIUDR2o
         ukOw==
X-Gm-Message-State: AO0yUKUxMUkXXkPleMBlv4jDATxI1LvqjdfpENnBsouD8VDFZr7N1wze
        SDmkfYHnxAwK20kGngVR3MY=
X-Google-Smtp-Source: AK7set8dfzlW7a/WkPN2lUpzoC8W7qX3y3mq+kVuU0A3p0XBKYanpamyYslp9JtVHLn56Xh34vZOSw==
X-Received: by 2002:ac8:5803:0:b0:3b6:2c3b:8c00 with SMTP id g3-20020ac85803000000b003b62c3b8c00mr44096137qtg.66.1677516091850;
        Mon, 27 Feb 2023 08:41:31 -0800 (PST)
Received: from ArchLinux ([68.74.118.125])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87108000000b003bf9f9f1844sm4869361qto.71.2023.02.27.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:41:31 -0800 (PST)
References: <20230227075346.69658-1-schspa@gmail.com>
 <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
 <20230227102808.2cea9705@gandalf.local.home>
 <Y/zPv+L2iqOkD2Oa@hirez.programming.kicks-ass.net>
 <20230227105310.08d9a46e@gandalf.local.home>
User-agent: mu4e 1.7.5; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Date:   Tue, 28 Feb 2023 00:36:26 +0800
In-reply-to: <20230227105310.08d9a46e@gandalf.local.home>
Message-ID: <m2mt4z5adr.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt <rostedt@goodmis.org> writes:

> On Mon, 27 Feb 2023 16:43:59 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
>> On Mon, Feb 27, 2023 at 10:28:08AM -0500, Steven Rostedt wrote:
>> 
>> > So what exact race are you trying to catch here?  
>> 
>> on-stack copmletion with a wait_for_completion that can return early
>> (eg. killable, interruptible, or timeout) can go out of scope (eg, free
>> the completion) with the other side calling complete() on some possibly
>> re-used piece of stack.
>> 
>> IOW, Use-after-Free.
>> 
>> Care must be taken to ensure the other side (whatever does complete())
>> is either terminated or otherwise stopped from calling complete() on an
>> out-of-scope variable.
>
> I got that. But as you were stating as well, when care is taken, the script
> appears to still report it. The example I gave has:
>
>         req = blk_mq_alloc_request(q, REQ_OP_DRV_OUT, 0);
> [..]
>         req->end_io_data = &wait;
> [..]
>         hba->tmf_rqs[req->tag] = req;
> [..]
>         err = wait_for_completion_io_timeout(&wait,
> [..]
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         hba->tmf_rqs[req->tag] = NULL;
>         __clear_bit(task_tag, &hba->outstanding_tasks);
>         spin_unlock_irqrestore(hba->host->host_lock, flags);
>
>
> And where the complete is:
>
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         pending = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
>         issued = hba->outstanding_tasks & ~pending;
>         for_each_set_bit(tag, &issued, hba->nutmrs) {
>                 struct request *req = hba->tmf_rqs[tag];
>                 struct completion *c = req->end_io_data;
>  
>                 complete(c);
>                 ret = IRQ_HANDLED;
>         }
>         spin_unlock_irqrestore(hba->host->host_lock, flags);
>
> So the spinlock is making sure that the complete() only works on a
> completion if it is still there.
>
There is nothing wrong with your code.

This script will not check the hba->host->host_lock lock, and there is
another hba->outstanding_tasks bit mask to ensure that there is no UAF
here. But this script doesn't have a way to get these implicit
conditions.

> I guess I should have asked, how is this script differentiating between
> where there's a problem and where there isn't.
>
> If you remove the spinlocks, then there would most definitely be a race,
> and I'm not even sure if the supplied patch would improve this much.
>
> -- Steve


-- 
BRs
Schspa Shi
