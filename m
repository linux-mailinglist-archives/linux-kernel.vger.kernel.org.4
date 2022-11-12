Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574E662694F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKLL6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 06:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:58:17 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAD114D02
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:58:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id i10so9333121ejg.6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dr4Vea0ZgfDIrh0NgQW5X1KnTm1YYJOqCu5lHDruVuo=;
        b=LyNePSjeGke1N99yFA9QNQES3SGpxz5Cnv1ATBzBblS+nYYvj/fhpx3erl1MIHgyXz
         gljwcL3cUEr1/aBDJ55hdiM9mRVHOE7zShbXAIJeTUaa24ZzmJW1HmPbgCcG/HZZxXYW
         MG1tL6bjeKzMLMVSXbqo+9EqWMO4pOcimjUDCfWEIyUvS7z0djf1MLObXOHBG7DwNRtv
         gZBIkLTRn73yhITr6RQukRR9yylyqlHuMrO6qlSMY+oUA3V9gd0WHjznrfXdt3dMj05F
         Vl8CXcvgmlDCmgZKfDtDPTuXXWX8w26p3WM2Ij7Q62CWqO7G8BN9gezOUYrE/vc+3Fmp
         Hjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dr4Vea0ZgfDIrh0NgQW5X1KnTm1YYJOqCu5lHDruVuo=;
        b=XLm5RdvefX1xY8zD+BdI6MrbXgHUJhSw2TAT8g3eT+a55lhPb6x0TznKQOHAZ4RNX7
         qdYdQanOyVa3rLCodcNsT2wtpszks1ezX4ZoFTxmhSDQQMVOSEcRAVwqUlY/MTAmgcA0
         lSdguoHKkDI0QncMup+SHjMUE7cMmYTsTBEaBBiETrRpzqF4SBqrGHttfvu0T3Iatuec
         VhY57g0cu4DHr5jBXemdXjhUXDsQXeFrWx5qWDGvBVpJVF5UOzeQ7Pqfa/vgzGH3C6gQ
         VbLk4/mV5joRzQfRllNEKQ7XBGqcoRg0yY3Vuk24UKBO8oXjDAzD3YXhLZS6psIXFio0
         R35g==
X-Gm-Message-State: ANoB5pkTZIYGuRIf+eyNZyA0DISjlZD/zKXLl/3H4S59m2QACqD9nmoe
        5T4YeZOPbnkHspzfOy6JQ9aQ6UuShO+7Aj4+XCLN4gIO
X-Google-Smtp-Source: AA0mqf4CaXymmqSrv8yHZ6uYbBq+7vdvdFmirtvcTF0/8lgbemDKeM+hQrrJIcgwmUgZw6+D6fLQeiZoGMPx8e8zs0A=
X-Received: by 2002:a17:906:f2c3:b0:78d:d762:5457 with SMTP id
 gz3-20020a170906f2c300b0078dd7625457mr5248096ejb.67.1668254295317; Sat, 12
 Nov 2022 03:58:15 -0800 (PST)
MIME-Version: 1.0
References: <CAOM0=dbwNs1XcnD0i+SrC1S-SNFEGXM5G8QrVCqAxaz=YkAEFg@mail.gmail.com>
 <20221112074759.GA5111@1wt.eu> <CAOM0=daopCt=LthGStL2zHYxgQ6iphLLfKZjxcPS07yCvyq42Q@mail.gmail.com>
 <20221112113410.GA5553@1wt.eu>
In-Reply-To: <20221112113410.GA5553@1wt.eu>
From:   A <amit234234234234@gmail.com>
Date:   Sat, 12 Nov 2022 17:28:04 +0530
Message-ID: <CAOM0=dbuPP1j7MYkZCxbXQKxUsjeO0QXfE_g-xapFXYSpCAgXw@mail.gmail.com>
Subject: Re: Setting variable NULL after freeing it.
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 5:04 PM Willy Tarreau <w@1wt.eu> wrote:
>
> On Sat, Nov 12, 2022 at 04:18:37PM +0530, A wrote:
> > >
> > > It depends. What's important is not to let a pointer exist to a freed
> > > location, so if you're doing:
> > >
> > >     kfree(card->pool);
> > >
> > > then it's usually important to follow this by:
> > >
> > >     card->pool = NULL;
> > >
> >
> > I checked in kernel but at many places this is not being done. I can
> > change all that code. But, will the patch be accepted?
> >
> > So, if someone is doing -
> >
> > kfree(x)
> > ._some_code_
> > ._some_code_
> > ._some_code_
> >
> > Then I can change it to -
> >
> > kfree(x)
> > x = NULL;
> > ._some_code_
> > ._some_code_
> > ._some_code_
> >
> > But, will the patch be accepted for this change?
>
> I don't think so, for the reasons I explained previously,
> unless you spot real bugs there during your reviews, of
> course. Better focus on your own driver for now in my
> opinion.
>

I was just thinking that when this is good practice (where its usage
is genuine), then why is there not a kernel wide macro that would call
kfree(x) and then set (x) = NULL. So, this will be done automatically
for everyone and the developer will not have to decide whether to do
this or not.

Amit
