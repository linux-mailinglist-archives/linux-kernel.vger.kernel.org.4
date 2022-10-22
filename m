Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613BB608AFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiJVJSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 05:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiJVJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 05:17:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4E82E043F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:31:41 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o65so4120721iof.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iX6ZB1mXxDt5cJkxRAfDaCVuPNu25Wfl4HIXasXp/zE=;
        b=DtjYEobqYqn1PVq/AajYffhPc7LJyHOQ9CA3/KoXG+ez8a5IYQRrTz+GqqTGI1o2LM
         nXsGsbGuvQ5CzezAp0SOJqFHfqQu+AjM8MD4tEkoJpCdvNfg9siuagh4CSdN339c97YE
         D0/I08DG3kQKfLLoJe6AWEsMJVg1jhwx2c0VHwnCzieZw1kYf3gpAlD4h1JSirhQ9sGF
         YNA77kgqEjS5stjGliBuaoZBHXn6aTlst7TXHMRk0bIKbM7zzDmoLGrPYZnrCG7eBsFe
         ke0zzW13Gm+bkbSP0VDcVE/umejOgnSAcquIZ8ZcWv7uC+PpoC0z9cx0366JQOPOHmgy
         g8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX6ZB1mXxDt5cJkxRAfDaCVuPNu25Wfl4HIXasXp/zE=;
        b=NbkJz8CaXy43gJX5XpARd4cfsSxuR09iY6/CwGLhoO1P1vxT4oix6SYntttWS5ihK0
         5ZbHBqsWL4gBFlPFfdcNOM/Mgn+sHOQliFX0V0tz0AwZMtv+bA27rl1IQn/iu9V7T6Cx
         MNA3WuaLjNGWg8crs5fUn6tl26lvO2pp/fV93ZBxzjD+xF7WcCKO0xwShJiZWPffnBvo
         4CzW0hpN13WUWsFEt2K8/cvzuzFeoLbIYy/TNyUlmRRoPztEDmjtcG14kM3jvragwr0U
         w9XHBv7XCmj6ObXfsu+KFFKtIfbCs1JBkVwHofMS6gcH23OAI0NNPoy1XQEuwvylErLA
         CyUw==
X-Gm-Message-State: ACrzQf3XdBJS8Lye39IyVov8K+6mvLxq7QhPuYK22DQm8T+IeYcshPzX
        GuXTA+oojcCGXa46vdwAZ5+TDR/4E5iCwEkdPAnoHFAEB2LbxkLDjXg=
X-Google-Smtp-Source: AMsMyM5PyvIFnw7iJHcdHMBCUIsTVHymZdfP1Ub2JfJlRvOFhkTr/4Gk/oNAhxPPpG83UBJhFoETd7COaQYyxFvJUHQ=
X-Received: by 2002:ac8:5902:0:b0:39c:e440:6adb with SMTP id
 2-20020ac85902000000b0039ce4406adbmr19603840qty.18.1666426932343; Sat, 22 Oct
 2022 01:22:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221022070612.13009-1-tanjubrunostar0@gmail.com> <Y1OdSYH45MNbp03k@kroah.com>
In-Reply-To: <Y1OdSYH45MNbp03k@kroah.com>
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Sat, 22 Oct 2022 09:22:00 +0100
Message-ID: <CAHJEyKXYtMiUusyq8427SjJo5VFO09O6HH0kkBYsmYzx8BMeAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] a series of checkpatch fixes on the file: rxtx.c
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 9:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 22, 2022 at 07:06:06AM +0000, Tanjuate Brunostar wrote:
> > The fixes are similar, mostly long lines splitting. I had to make
> > serveral patches to ease the work of inspectors
> >
> > v2: fixed a compilation error found by the kernel test robot and
> > recompiled the code
> >
> > v3: tends out the error persisted in the second version. this version is
> > a correction of that
> >
> > Tanjuate Brunostar (6):
> >   staging: vt6655: fix lines ending in a '('
> >   staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
> >   staging: vt6655: refactor long lines of code in s_uFillDataHead
> >   staging: vt6655: refactor long lines of code in s_vGenerateTxParameter
> >   staging: vt6655: refactor long lines of code in the rest of the file
> >   staging: vt6655: refactor code to avoid a line ending in '('
> >
> >  drivers/staging/vt6655/rxtx.c | 532 ++++++++++++++++++++--------------
> >  1 file changed, 321 insertions(+), 211 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>
> Any reason you do not have "staging: vt6655:" as the prefix for this 0/X
> email subject line?
>
> thanks,
>
> greg k-h

oh I forgot to include it
