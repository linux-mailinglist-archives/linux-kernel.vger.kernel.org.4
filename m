Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB1D710BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240324AbjEYMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbjEYMWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:22:24 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB10C135
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:22:22 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-43278f6d551so291020137.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685017342; x=1687609342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TiwQ2LI2rFbV2HsiZtBqVjQ7FkEpztC2S2POKBZ5Nkw=;
        b=Pairwt/ui9UAklFCQB9R2NjLwqTDpezcblarmRFlxPLxS/GCGHocJjLRyc34vfxCuw
         ztWx54wI1SsPHFrGvS2yg+2OgDfkk17aSmnNanXzCRV9jfRoX2Hrx1RHB/bILDj95yIY
         RyZMLKHFnM0GfURqCgFTF5Tu5f260oGaBlxeEsAOpggnV7pIpNUO0z+Ua6IoA6QiEFWo
         /MgmqkmSrritUbASLXVqR0DfaibX1Ua5psO1KIN9GsRadhyv7ZO0mBMfhRhWU8wqupLx
         WLHn3G0c3sfF4R+fZ5jnRdFbJiMEVAODXZMzC2nbT6Q1AnwH4Z38xRz+A5MVB0OdpSIh
         JpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685017342; x=1687609342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiwQ2LI2rFbV2HsiZtBqVjQ7FkEpztC2S2POKBZ5Nkw=;
        b=G7oth8Qo2v03jPzKLIJC3+uLjGfqEju3Wi3udJhRgbxOEEytZPWsgOIuSpU6stqxnW
         G+Zri4fYAS6rfj0GQKSj/8ONb8L/NAa+wZdDBkcSYtxeRM6a+2K+RUVslPdnFy4G+mE0
         PPQxZ+jrTiIPUzd7MbBca6zBD0InSBBa7Sc3QrmLBseg4wbTAZc0az63hJfb8b7ZcWAa
         0QqXjuun8xOOTx1eQdG+1B54bi8lyhSF/yQe0g9RhxTn01DqmlhXlBXrYolZO0nKDmUi
         O0G0ObMpztHgXV32GafAGnRbCIts1ewxU0X46tVgNkplaPyiyXvAds27EpUKFVOPHypv
         vWgw==
X-Gm-Message-State: AC+VfDxNfW2bTVqSwPR6txuaejPKP/sD53osJf97tNB3yHGHoWE3TGfi
        LQoxW3p1G52vGZMb2fZHQFqKtQOKxfc1oQwCfkFXbg==
X-Google-Smtp-Source: ACHHUZ5USy7xBZdaQ9EIY3V990pi9ccxJIXFmf1abk8usVqRBWsZ21K0L8edNCZ/kBX2J+JdfxU2nPBC5SFy1/0xHOE=
X-Received: by 2002:a05:6102:3177:b0:439:63f5:1a7 with SMTP id
 l23-20020a056102317700b0043963f501a7mr2068412vsm.12.1685017341910; Thu, 25
 May 2023 05:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvVZ9WF-2zfrYeo3xnWNra0QGxLzei+b4yANZwEvr5CYw@mail.gmail.com>
 <20230524140744.GK4253@hirez.programming.kicks-ass.net> <CA+G9fYsP1XN31sWMtPsaXzRtiAvHsn+A2cFZS2s6+muE_Qh61Q@mail.gmail.com>
 <20230524175442.GO4253@hirez.programming.kicks-ass.net> <797a1074-4174-402a-a172-78191dfb426c@app.fastmail.com>
In-Reply-To: <797a1074-4174-402a-a172-78191dfb426c@app.fastmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 May 2023 17:52:10 +0530
Message-ID: <CA+G9fYsfp6V8jP3MGNAnOTSGseRUMepEWhAPt_KoUiN7GcGsYA@mail.gmail.com>
Subject: Re: qemu-x86_64 compat: LTP: controllers: RIP: 0010:__alloc_pages
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, LTP List <ltp@lists.linux.it>,
        lkft-triage@lists.linaro.org, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 at 02:03, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, May 24, 2023, at 19:54, Peter Zijlstra wrote:
> > On Wed, May 24, 2023 at 09:39:50PM +0530, Naresh Kamboju wrote:
> >> FYI,
> >> These are running in AWS cloud as qemu-i386 and qemu-x86_64.
> >
> > Are these hosted on x86 and using KVM or are they hosted on Graviton and
> > using TCG x86 ?
> >
> > Supposedly TCG x86 is known 'funny' and if that's what you're using it
> > would be very good to confirm the problem on x86 hardware.

I see the following logs while booting.

<3>[    1.834686] kvm_intel: VMX not supported by CPU 0
<3>[    1.835860] kvm_amd: SVM not supported by CPU 0, not amd or hygon

And they are running on x86 machines.

>
> Even on x86 cloud instances you are likely to run with TCG if
> the host does not support nested virtualization. So the question
> really is what specific cloud instance type this was running
> on, and if KVM was actually used or not.  From what I could
> find on the web, Amazon EC2 only supports KVM guests inside of
> bare-metal instances but not any of the normal virtualized ones,
> while other providers using KVM (Google, Microsoft, ...) do support
> nested guests.
>
>       Arnd
