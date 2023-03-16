Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807C86BCB4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjCPJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCPJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:45:24 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822D1A65A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:45:21 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5012241BA8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678959919;
        bh=LXsDC0Ydbf7JPu4lwbVwbKyGba5WvhZqraSUCmZhKD8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=uJAfIo2hUkQKTmA5rOfqCj/dF8v2tAM12rGGVhxAq52pi2qsEf2GbdpxJGviHzz57
         Gi1mpmhmNXR8/kVl36FxmIUWm+cjQsRXKWRNa4Wfqpl2bEEbwAKNRkCQ/Q79KllJS5
         bR7Ma+ZSC5JStzAtc9ohpPWJAlGYFqK/HhlXqsyx78enXe4aJkMEmm6HV7zq6kAAs0
         KirCcErXXuErvUkPmKXhiRtm82YHWr+uechEZurF4HQC2vbDtuQZ9S0CyCK3C4Y1F3
         frI2obhMG/wBzHhnDOMDwNB0ChgkJZ+sc+mEDpN6rgo3nY6TslBf9AXbAFhG2Bjozk
         jAnCYo3UEJE8A==
Received: by mail-ed1-f72.google.com with SMTP id en6-20020a056402528600b004fa01232e6aso2208986edb.16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678959919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXsDC0Ydbf7JPu4lwbVwbKyGba5WvhZqraSUCmZhKD8=;
        b=JmCrcNsIAZ/jy3QLBZ2SW8YBKA/KYJnLhNIaGEewAvZHIo9ycJyOvEl1YfdZQMRO0Y
         KSrEfIIyldDxdhMZ602gqkJu9r7BxYys1qVZfRvSKszFMBnYfOjBTgmTjgXLWpLRL/xC
         mFO7B2/sDVz6G4e/qjcn0lnmj0Wqn0/IL2tlxWayQqyMi1CVpgnkF/csUCjOMxyYtTG1
         VZwmVTqhZbX4zfGUmzNRY8Qp9Jj2QveOp8VX/zPi/n543tkTJmrS0LezXDJCJnxy8W//
         9V72UiN1Xlp/mo65/RLM0N6DqXYDp2qy5rIa0HS3C2ojHJkreH9u2oCpKMzK3jLYGdIh
         pm4A==
X-Gm-Message-State: AO0yUKW/Ofqf0vhyAcu7XF1wEwhAmb+9Qm82aiw0UZ4AK0/BvOoGlIfw
        t5LPguAHwC3DhVU5/ZeyOzbtT5BIYznzmIbioixsIpf2mQdlEn/QCcBmdRss8C/Dh7LQYQ9k04U
        geCLFJrZGGZEk7Ywag6jJxELLM4hm+j+AF4TE3WZnrA==
X-Received: by 2002:aa7:c052:0:b0:4fd:29e6:701b with SMTP id k18-20020aa7c052000000b004fd29e6701bmr5283404edo.38.1678959918980;
        Thu, 16 Mar 2023 02:45:18 -0700 (PDT)
X-Google-Smtp-Source: AK7set9mmYwXXPJpnpvNwg8PPWEuLxWf4VTQovyW+sfY1I6HgQB1YGpZWjb4RBwCKVD0TvtTtsYXfg==
X-Received: by 2002:aa7:c052:0:b0:4fd:29e6:701b with SMTP id k18-20020aa7c052000000b004fd29e6701bmr5283389edo.38.1678959918675;
        Thu, 16 Mar 2023 02:45:18 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id lg8-20020a170906f88800b008ca8b62cda6sm3673119ejb.177.2023.03.16.02.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 02:45:18 -0700 (PDT)
Date:   Thu, 16 Mar 2023 10:45:17 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Paolo Pisati <paolo.pisati@canonical.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel 6.2 stuck at boot (efi_call_rts) on arm64
Message-ID: <ZBLlLRVVxCbZfEJd@righiandr-XPS-13-7390>
References: <ZBLLSmLbt2P4ZN6O@righiandr-XPS-13-7390>
 <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHYqMdis99D3OaKf51eoCDW2+5NfcUEbF4Zrau4BcKgsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 08:58:20AM +0100, Ard Biesheuvel wrote:
> Hello Andrea,
> 
> On Thu, 16 Mar 2023 at 08:54, Andrea Righi <andrea.righi@canonical.com> wrote:
> >
> > Hello,
> >
> > the latest v6.2.6 kernel fails to boot on some arm64 systems, the kernel
> > gets stuck and never completes the boot. On the console I see this:
> >
> > [   72.043484] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > [   72.049571] rcu:     22-...0: (30 GPs behind) idle=b10c/1/0x4000000000000000 softirq=164/164 fqs=6443
> > [   72.058520]     (detected by 28, t=15005 jiffies, g=449, q=174 ncpus=32)
> > [   72.064949] Task dump for CPU 22:
> > [   72.068251] task:kworker/u64:5   state:R  running task     stack:0     pid:447   ppid:2      flags:0x0000000a
> > [   72.078156] Workqueue: efi_rts_wq efi_call_rts
> > [   72.082595] Call trace:
> > [   72.085029]  __switch_to+0xbc/0x100
> > [   72.088508]  0xffff80000fe83d4c
> >
> > After that, as a consequence, I start to get a lot of hung task timeout traces.
> >
> > I tried to bisect the problem and I found that the offending commit is
> > this one:
> >
> >  e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> >
> > I've reverted this commit for now and everything works just fine, but I
> > was wondering if the problem could be caused by a lack of entropy on
> > these arm64 boxes or something else.
> >
> > Any suggestion? Let me know if you want me to do any specific test.
> >
> 
> Thanks for the report.
> 
> This is most likely the EFI SetVariable() call going off into the
> weeds and never returning.
> 
> Is this an Ampere Altra system by any chance? Do you see it on
> different types of hardware?

This is: Ampere eMAG / Lenovo ThinkSystem HR330a.

> 
> Could you check whether SetVariable works on this system? E.g. by
> updating the EFI boot timeout (sudo efibootmgr -t <n>)?

ubuntu@kuzzle:~$ sudo efibootmgr -t 10
^C^C^C^C

^ Stuck there, so it really looks like SetVariable is the problem.

Thanks,
-Andrea
