Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217B75FE695
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 03:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJNB3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 21:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJNB3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 21:29:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F218D192B85
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:29:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so4465158wmr.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 18:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9vsXu9SUkLdER4qbW1tYGk87yFN3MaIhSuC2OqkgV0=;
        b=eixRdh/64Jh2YnN/cb1gWlieABMN4LDcTvbejDYY8s7XnlYH+wWL+03Shz7kmnriKJ
         nyePdDHSnZdXYon1tIDPsxtIHv9cb0Sna4tu66pDAKSc+OQ5gwdDT2vgYP1iwmtHKZ7v
         h7RpU0CXDVJWpsufd7RkDyv0H+skfY4PxMDbbCbvc43Fv9XbiJqgPJedceDUxXUsHnqj
         zFGtdt28wUvNAtZfvFKu/5soud4ZaImq2bEQZDHqJijbJCLTI9hsx5OkoawOSs7wRUjK
         84lJ3P/t8yLQ1CXqE+gHFldpl93B7gi1qZGALOI9/Ch6icNIElWzrBJfpJQL+cdHsC9T
         Xpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9vsXu9SUkLdER4qbW1tYGk87yFN3MaIhSuC2OqkgV0=;
        b=HnN9GghvihAsa6sOrbF2csWYDZO1N3EfHMd5907eTwQtntPXkhEx9GqyWd3WUuAV80
         mOVTao0A84epxHmPg9QGuuN9Kac90Xj1ITyWjmOfZC4gOWAKAPPFYUp7cy+7uQtXk3fN
         KWdI4HZLuoznpXQjhgqQGyBkRxlqTwtRijfz/4QuZKsTHBQ5dQVB+ZhnLTHcgfhakuhV
         bQBAoCpem/0WtZ7fbnwgI2dyM5HNF9DaCbKyo7IKQEriNutwCSXGJ1K5gBnK/XaxhRwh
         dRk6ukv92H/qgLW4jNsCS3j7K2+8EVprXKl1ZTg6gEXNADfT9LyHzhAlmHM+uJzPo6OH
         vyVA==
X-Gm-Message-State: ACrzQf2NNrH/oTk+zrGkw6oyuosiI23ShEQVFzEBCMjRyy9mgXzoRcbJ
        3O4LXyzbA9wB70FIr11pALhqVkibooFvKaqhA4ZTmQ==
X-Google-Smtp-Source: AMsMyM7rFxsRQZzycsIFLaFoamzsHtfFt9ULPZVcRWs8q0f8N4AFETPNEFapdAuQ+938kglatd8RxBhVd+FS+PvrZoQ=
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id
 l17-20020a1ced11000000b003b4d3e10becmr1657654wmh.196.1665710969386; Thu, 13
 Oct 2022 18:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
 <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com> <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
In-Reply-To: <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 13 Oct 2022 18:28:53 -0700
Message-ID: <CAJD7tkYUoW3YU-R1wNBADdUDHVprq6CP3axD9md3gJzW=yhiFw@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     John Stultz <jstultz@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 5:03 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
> >
> > On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > So I think it reasonable to say its bounded by approximately  2 *
> > > NSEC_PER_SEC/HZ +/- 11%.
> >
> > Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11
>
> Thanks so much for the detailed response :)
>
> IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
> (essentially 0)? I feel like I miscalculated, this error bound is too
> good to be true.

Never mind, I thought HZ is the cpu speed for some reason. It's the
number of jiffies per second, right?
So if HZ is 1000, the error bound is actually ~2 ms, which is very
large considering that the unit is ns.

Right?

>
> >
> > thanks
> > -john
