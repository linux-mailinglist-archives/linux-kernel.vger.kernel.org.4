Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5993F5FE6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJNCPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJNCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:15:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29F13ECF0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:15:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bs14so4439672ljb.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuy+ZMA4uPGTf3eZoCGwL2/k+5QRw/FFhfkU0kjMMa0=;
        b=Dr9qPuJzcDkqiovmS2bY/0BvhRLqTXnLQYia3409eGT0C9mWZoWdFPeleF6vsLxiwE
         pBOhPr1T/sRYTFbJDtNzoQuztzY7zBf1tseWWkhZrHDSBweUEfdI7Z2wpTbcVG7Bc7pB
         riGQSR0uEaYwrc7c7hxYTHpRhaYxEkLfPSkEE7tgIfP7QNXjkwhARmR1oKDrygQHiQtW
         dkSwh43ISWTOSyznK7torBvjXxX5c+LtRW/tPM/+e/lkN4sNxenh6N8XwaFOdVDXp3JR
         Sfzma1J0tOcX1o9qAdeZbyhl5KByrGfnBTyO4tYE0/aEuf/UztlGa/QJbdXWiaqv0IIC
         M5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuy+ZMA4uPGTf3eZoCGwL2/k+5QRw/FFhfkU0kjMMa0=;
        b=4tlplXVZxci9vZ4nrappNC8vjUo5u6tOtpKNcHIngxmRHhcg9tXmz6ZR7CzL4+qGrX
         CcDW1P3D7196rkPesCanZjquPDvXu5LOsqydUHfyAgmEOfZvDjmD0okK28amwFM9s3pz
         9wmA/ctNAMlQRWkSENyPQGISmA8YivEiQeHHhRaIJTaWIRo3El9kqyrwwtZBi9fB4SzO
         HU3Qh60RocS9TVkRTLAxF2Tqv8FnWdbNK6hvJUWXfojzfP9dq/cSIXYV8ahf0FJUIgOj
         tnbV6+8FDvIe+/rrkL/LTLhsa3TqOxzZn67ByjeZKPbrjPX18MGK7jnhmLSVM170iX5H
         J6rA==
X-Gm-Message-State: ACrzQf25I9B+zeLgHQC/CNgAwQfDq6EX84fN+E2ttJnXwbDtIKs9aMOE
        C60xriEdHIazTmYyq5cYTXoS0EmT9GsY4cvcY+P0
X-Google-Smtp-Source: AMsMyM49dZLWwOC7meVIiXUbcrIusOKXaoudHLdxZk3FeWJbP199/DbKsjYRGa5Tk1uTUEzuyYnlgtiPlCtaDeTRSpE=
X-Received: by 2002:a2e:9e50:0:b0:261:e3fd:cdc5 with SMTP id
 g16-20020a2e9e50000000b00261e3fdcdc5mr982059ljk.56.1665713743465; Thu, 13 Oct
 2022 19:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
 <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
 <CAJD7tkb=FSoRETXDMBs+ZUO1BhT7X1aG7wziYNtFg8XqmXH-Zw@mail.gmail.com> <CAJD7tkYUoW3YU-R1wNBADdUDHVprq6CP3axD9md3gJzW=yhiFw@mail.gmail.com>
In-Reply-To: <CAJD7tkYUoW3YU-R1wNBADdUDHVprq6CP3axD9md3gJzW=yhiFw@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 19:15:31 -0700
Message-ID: <CANDhNCpHGvw2MxexRFwpx4nAmqgwXw3G3DqkD2s0W3RNXZw2Bg@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Thu, Oct 13, 2022 at 6:29 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Thu, Oct 13, 2022 at 5:03 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Wed, Oct 12, 2022 at 8:07 PM John Stultz <jstultz@google.com> wrote:
> > >
> > > On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> > > > On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > So I think it reasonable to say its bounded by approximately  2 *
> > > > NSEC_PER_SEC/HZ +/- 11%.
> > >
> > > Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11
> >
> > Thanks so much for the detailed response :)
> >
> > IIUC this error bound is in ns. So on a 2 GHz cpu the bound is 0.11 ns
> > (essentially 0)? I feel like I miscalculated, this error bound is too
> > good to be true.
>
> Never mind, I thought HZ is the cpu speed for some reason. It's the
> number of jiffies per second, right?

Correct.

> So if HZ is 1000, the error bound is actually ~2 ms, which is very
> large considering that the unit is ns.

Uh, for HZ=1000, I think it's closer to 220us, but yes, for HZ=100 2.2ms.

thanks
-john
