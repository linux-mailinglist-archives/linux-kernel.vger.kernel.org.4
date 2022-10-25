Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCC60D498
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJYTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJYTUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:20:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0DF27CDA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:19:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e15so9330596qvo.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PRbQ9l2cJ5/Xp7Wc/kQYxbrvovXMK7bxbsvxlXJVha4=;
        b=ExzfS4DSZyz8+0pwq7h/bN4D3MONYWpRC6+ZTn+LxivHa9MBkAx4+EnUe3Qz1w209U
         2XEJT/oMSiFfbTmSgyA2Y487y1OQcl+GON0GjVBCGWp5ilK92YhusdAH5SZGJzqeybr0
         XgYaJ6rP42+EqOUhVfhjhI25W80lyT0g2P3ux6fgGWsN8S72qveYLrMsadR8taDuctoE
         IWi1knY6XxKrGP9rl/gz1h4/dECuM5BYvLMmAfY1Ps80r9pmeR8cpL9hGyaKwB3KcbUi
         yqwH+srJPqc+d9JROjFVR3uuU7wuEpVHP5BEWlgXQ8+GqHkPKI8PHCmeAu+wv0vnZsiZ
         tULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRbQ9l2cJ5/Xp7Wc/kQYxbrvovXMK7bxbsvxlXJVha4=;
        b=rP39Ca3BZ7ZV4tQW/sggx0IXmuNIWz95AJMcHqbD5yTihQP0r7brDPjBj33gJtD4mA
         m6asjhGac49TmxFtp+9QGsuRiZYlJWJTzLdks9RnJ/APqxYlNxQ3yM58tuqKY45iba/c
         ipaZ7Yt2EdbewyaJGU0vSCUWQ6qXVyhACmQQi5iHimVlNJsmy8/SnSQLquhrClTcd3qk
         doCmpNvXjjFO6wS9+EXz293Il9tfJ6KCvLHU+35ut/TXpd8i3GI/0O8qq2D5Mr145KsC
         8k5TYin7+GrDJ19t2zy7ETEJsdLaKJRLNK0py4HWp8RgGSCuwF8MpkrBVlY/PVO0Y6o4
         TXgQ==
X-Gm-Message-State: ACrzQf2ePF92AxslnMwz26g+WWkqvt4vxF5lQy7vNOkznzLxlc5zl/4U
        kP/pKKy0OBkCEvIs8VB4EXRQP4MvWTGN7r+x5TdQsqw0TTw=
X-Google-Smtp-Source: AMsMyM4Mgkan2YLxZ84xQCAdzVfsxzqt6YtQwNRBGNRocA3ETw6Tfb8aBMRe4YQrkmOsLCaqzNmTCrKpYwmR/PAVtO8=
X-Received: by 2002:a0c:f00f:0:b0:4bb:6167:d338 with SMTP id
 z15-20020a0cf00f000000b004bb6167d338mr14629329qvk.11.1666725598347; Tue, 25
 Oct 2022 12:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
 <Y1embP5sEp/NPxK0@smile.fi.intel.com> <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB557390C5F741300BDE2BAA8BD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Oct 2022 22:19:22 +0300
Message-ID: <CAHp75VeNwvAppVdn+wqAYkzDS115ZuJqm9=gu0hyVoz14qWQkA@mail.gmail.com>
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
To:     Nathan Moinvaziri <nathan@nathanm.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 8:53 PM Nathan Moinvaziri <nathan@nathanm.com> wrote:
>
> Hi Andy,
>
> I appreciate your quick feedback!
>
> I have done as you suggested and published my results this time using Google benchmark:
> https://github.com/nmoinvaz/strcasecmp

Thank you for sharing!

Looks promising, but may I suggest a few things:
1) have you considered the word-at-a-time use (like strscpy() does)?
2) instead of using tolower() on both sides,  have you considered
(with the above in mind) to use XOR over words and if they are not 0,
check if the result is one of possible combinations of 0x20 and then
by excluding the non-letters from the range you may find the
difference?

So, I think it's a good exercise for the twiddling of bits.

> After you review it, and if you still think the patch is worthwhile then I can fix the other problems you mentioned for the original patch. If you think it is not worth it, then I understand.

P.S. Avoid top-posting in the Linux kernel mailing lists!

> -----Original Message-----
> From: Andy Shevchenko <andy@kernel.org>
> Sent: Tuesday, October 25, 2022 2:04 AM
> To: Nathan Moinvaziri <nathan@nathanm.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if chars match
>
> On Tue, Oct 25, 2022 at 11:00:36AM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:
>
> ...
>
> > > When running tests using Quick Benchmark with two matching 256
> > > character strings these changes result in anywhere between ~6-9x speed improvement.
> > >
> > > * We use unsigned char instead of int similar to strncasecmp.
> > > * We only subtract c1 - c2 when they are not equal.
>
> ...
>
> > You tell us that this is more preformant, but have not provided the
> > numbers. Can we see those, please?
>
> So, I have read carefully and see the reference to some QuickBenchmark I have no idea about. What I meant here is to have numbers provided by an (open
> source) tool (maybe even in-kernel test case) that anybody can test on their machines. You also missed details about how you run, what the data set has been used, etc.
>
> > Note, that you basically trash CPU cache lines when characters are not
> > equal, and before doing that you have a branching. I'm unsure that
> > your way is more performant than the original one.


-- 
With Best Regards,
Andy Shevchenko
