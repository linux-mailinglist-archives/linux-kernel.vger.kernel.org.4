Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661E6BCBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCPKDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCPKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:03:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C6A11EBB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:03:03 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A7B2641BA8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678960981;
        bh=3Iay0DaDVJbQ2QDw/QwIxB9ScHbcf8fjxGVoUCDjsJI=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=OwHlV8itae4/0YpyYXDRoy3y2r1qyEooYuIoKU63AgW+uiEx2C1hRz/VvIhPyP8Ql
         F45qrkJCdZUpfIBNIfmBUOQAhuU5dG7NjMM8CYoBsaydPqiPbPXyKMgpuXOyQiW9ig
         oL1bk8lYRjQpf+OC6M8UPj0jsjdZT1QnxsNCscMS8yjjQSvI4YJkbKdqDBC5FletxA
         tnNBIKBBV06s8wO3jFZQ5kCMqq6FccC2DbHXr7T2m44Jr+ZBJIQ1em8TbCap1VfWpG
         T2+xOq4w39Lx3GJuSkLnB/xBemaPcg70VvQN+R5Gjwy5W+cbcrBUvrUBYOKkbPaXEy
         jE+l2/d0K7sVA==
Received: by mail-ed1-f70.google.com with SMTP id z14-20020a05640235ce00b004e07ddbc2f8so2287890edc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Iay0DaDVJbQ2QDw/QwIxB9ScHbcf8fjxGVoUCDjsJI=;
        b=xaiH7/tOfaXdZQFFxDrnwrsW0qd0wd1XQT7DZWZ7V+dbtEJ8mIm4a0WNA1cz6A6akz
         KjHVEcVkIy+FvYOWtJmGGgwQWLwnfGIneTWumWH/bdTfB0fHscrE6ZM4DpajOXikCyi+
         oslKPbT2eH2CSSQz+TOjedMuFiphOPQbmXnHKFlW5/N0Fg15v5BuZkr/q6v9KqS4bJd2
         +Ny9F5k880mVppMsSIO81RgIFLFRT71MEcfC+1W/9jdZW7B+t4REsCukhCYbUc0Nl5b/
         NjfcEXRSkAKQ3yxGjaH5s6+izANC05ZcVJULTMczE1+t9EjQq+kK2jTVx2SCbrQXds6e
         eEYw==
X-Gm-Message-State: AO0yUKUICvcSCzUaBtj4NbOInN0B3q9O9WtPb66PByvRiyeR0z9RZ2gd
        BzZ/2zrmBlylLSfcR+GiORcLXFeIZxg/rilTfzo6xduLzmM6gGxJrGqE81w0TU4CW+gFJoXWOGK
        6D4tmlXJ2gF+QRa1jV/dOY26PyqDXQgx6xFzeb1ZzdQ==
X-Received: by 2002:aa7:c516:0:b0:49e:4786:a0e2 with SMTP id o22-20020aa7c516000000b0049e4786a0e2mr5756500edq.14.1678960981447;
        Thu, 16 Mar 2023 03:03:01 -0700 (PDT)
X-Google-Smtp-Source: AK7set+i5WvP90KcaZoZzqteUHXGh3wmG3g5bw5sdQNI8MoxkWUXa97NE37OSBbbqIztW5R9ZHZbtw==
X-Received: by 2002:aa7:c516:0:b0:49e:4786:a0e2 with SMTP id o22-20020aa7c516000000b0049e4786a0e2mr5756484edq.14.1678960981165;
        Thu, 16 Mar 2023 03:03:01 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id lx20-20020a170906af1400b00930c6c01c9esm327844ejb.143.2023.03.16.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 03:03:00 -0700 (PDT)
Date:   Thu, 16 Mar 2023 11:03:00 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBLpVDmy8BXQZve9@righiandr-XPS-13-7390>
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
 <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
 <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
 <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXET+A2rk+WQyebKPNtSvzzS0nJdMbx3uT1JgMxOvqfx4w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 10:55:58AM +0100, Ard Biesheuvel wrote:
> (cc Darren)
> 
> On Thu, 16 Mar 2023 at 10:45, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> > > Hello Andrea,
> > >
> > > On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > > > gets stuck and never completes the boot. On the console I see this:
> > > >
> > > > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > > > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > > > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > > > [   72.064949] Task dump for CPU 22:
> > > > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > > > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > > > [   72.082595] Call trace:
> > > > [   72.085029]  __switch_to+0xbc/0x100
> > > > [   72.088508]  0xffff80000fe83d4c
> > > >
> > > > After that, as a consequence, I start to get a lot of hung task timeout traces.
> > > >
> > > > I tried to bisect the problem and I found that the offending commit is
> > > > this one:
> > > >
> > > >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > > >
> > > > I've reverted this commit for now and everything works just fine, but I
> > > > was wondering if the problem could be caused by a lack of entropy on
> > > > these arm64 boxes or something else.
> > > >
> > > > Any suggestion? Let me know if you want me to do any specific test.
> > > >
> > >
> > > Thanks for the report.
> > >
> > > This is most likely the EFI SetVariable() call going off into the
> > > weeds and never returning.
> > >
> > > Is this an Ampere Altra system by any chance? Do you see it on
> > > different types of hardware?
> >
> > This is: Ampere eMAG / Lenovo ThinkSystem HR330a.
> >
> > >
> > > Could you check whether SetVariable works on this system? E.g. by
> > > updating the EFI boot timeout (sudo efibootmgr -t <n>)?
> >
> > ubuntu@kuzzle:~$ sudo efibootmgr -t 10
> > ^C^C^C^C
> >
> > ^ Stuck there, so it really looks like SetVariable is the problem.
> >
> 
> Could you please share the output of
> 
> dmidecode -s bios
> dmidecode -s system-family

$ sudo dmidecode -s bios-vendor
LENOVO
$ sudo dmidecode -s bios-version
hve104r-1.15
$ sudo dmidecode -s bios-release-date
02/26/2021
$ sudo dmidecode -s bios-revision
1.15
$ sudo dmidecode -s system-family
Lenovo ThinkSystem HR330A/HR350A

-Andrea
