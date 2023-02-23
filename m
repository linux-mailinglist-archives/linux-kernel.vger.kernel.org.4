Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07646A0FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjBWSrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjBWSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:47:16 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AB15893
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:46:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s22so14842964lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 10:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d84WjkOkqupHcw+FU5vzhrvdpAfWUWehoXECwf0pUzI=;
        b=qhm3hPm+oSJ4s1ShP0lapEUYR5IkwmhP+F+TJeQKrxZd+TPQYlMiwjnu0Bj10ztB0Y
         YVurYzUsyGsKrzwbqRkGwEmL9maWHZaHGOOA65qnrC6JLnKcGptkWpvgQMgseJZlUAH2
         iYEoFhf2x9kip/2gCIgUrrWz9EeWQvDPbx5zbpqbicLx2RZgcVWR5xKL1BQro2kthufd
         kXPaewWe4ha8b3ROmFmaN0PuS2+nM4kSds4IAapt12zwv+KDBqlfRMQJj64QvmhtF2nf
         c+ZepL+WBfUJtsnpJmB//rjxP68pXKk+MNswp83Ty3nkVa+jVVkAAnxXoFpnZycxev4B
         pYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d84WjkOkqupHcw+FU5vzhrvdpAfWUWehoXECwf0pUzI=;
        b=F865C5ZRh40yKryf/GOpKDPnawPj2AJ6peUD59NcRIH7SkFYSSmoFQbDWUg7qU3M7h
         wfE8xKZ26P8npX2xmzu1mrX0/DdPaDY3+JIJ7GIsEKR18j47FjRo2bHvYPgMkxWWWVu4
         47zL0zrxpu9XJgtGeGqMQjcnDxp4NmpLwKYjq8Ol/BwjTdkluUvTGTkdnv7AFsSwGK4h
         3cB+FOyMd5NpxGSP2aJEnByaWh0z6m27g7jUkLagWHUmi9ZkG63KvUotg0Zs6S5v6pWT
         KjwX9NfJCKj0WR7geVDEmhyZ9QXSsbyUOl4RSML7VqAf3ODVPtWfymiornf01rOYTgjb
         KCwQ==
X-Gm-Message-State: AO0yUKUJZj16XORRabRb6DOZT3xBYRJ7KA30oQ8AM1ERm3PArfO9Y3b3
        wdDWj5slJu78tJXv8gDcw0Plofd8otKJes/G8qhB9g==
X-Google-Smtp-Source: AK7set9GVMhv/MFxdE4YCHJ+J6E6QpFq7wGeHK54sZrlaJUASkgEtczMsrA24TNPaRXTbFQJxd/Sez72HlZanbuvKhg=
X-Received: by 2002:ac2:5689:0:b0:4d5:ca42:aeed with SMTP id
 9-20020ac25689000000b004d5ca42aeedmr4072955lfr.13.1677178017989; Thu, 23 Feb
 2023 10:46:57 -0800 (PST)
MIME-Version: 1.0
References: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
 <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/cjW8qVhRTPiz0t@hirez.programming.kicks-ass.net>
From:   Beeman Strong <beeman@rivosinc.com>
Date:   Thu, 23 Feb 2023 10:46:46 -0800
Message-ID: <CAP55G9CmOai+L_5yhqAQT586sas5+zSc=NgeJZVa6U8WzQYf+Q@mail.gmail.com>
Subject: Re: Perf event to counter mapping question
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying again:
Hi Peter, thanks for the feedback.  Can you say more about AMD's
overlapping constraints?


On Thu, Feb 23, 2023 at 12:27 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 22, 2023 at 04:28:36PM -0800, Atish Patra wrote:
>
> > AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
> > much easier. It just needs to pick the next available counter.
> > On the other hand, x86 allows selective counter mapping which is
> > discovered from the json file and maintained in per event
> > constraints[4].
>
> All the contraint management is done in kernel, and yes, it's a giant
> pain in the rear side.
>
> From what I understand the reason for these contraints is complexity of
> implementation, less constraints is more 'wires' in the hardware.
>
> With PMU use being ever more popular, we're seeing the x86 PMU move
> towards less constraints -- although I don't think we'll ever get rid of
> them :/
>
> > 2. Mandate all-to-all mapping similar to ARM64.
>
> If at all possible, I would strongly recommend taking this route. Yes,
> the hardware people will complain, but newer x86 hardware having less,
> or simpler, constraints might be sufficient to convince them.
>
> (and if you do have to do contraints, please take a lesson from x86 and
>  *never* allow overlapping contraints as AMD had, solving those
>  constraints is not fun)
>
> As you note, this is *much* simpler to program and virtualize.
>
> > Note: This is only for programmable counters. If the platform supports
> > any fixed counters (i.e. can monitor
> > only a specific event), that needs to be provisioned via some other
> > method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
> > AMU not PMU.
>
> So free running counters are ideal and fairly simple to multiplex/use.
>
> The moment you start adding overflow interrupts / filters and any other
> complexities to fixed function counters it becomes a mess (look at the
> x86 PMU again).
