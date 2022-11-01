Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFB614BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKANop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiKANom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:44:42 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CDA62D2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:44:41 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id z189so13328340vsb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wmlDbxR43p/AVKjp9OWEiUiPO2sb+nmDFWo89vNMtlg=;
        b=xtRaXtRJufi5E55u5VPH6L1vPkaVY/Jjx2qHNusVQQxg4p3/fIJSs4FCm1Elk3Ebwe
         X3m+I2TMPqgEaBf8SHtwhHDhM4/F6H7SoDJ5SQyAp8J1YJm72JF34sTCclU83H8TQlBL
         W6RqZ6Z6IYSgld0lt7BrTTR+BssWEJptn5pkoTmMHGXOOaNTtsMNrKPSswLxIhp7GNKS
         /+TyRssm0BbWHqn9pg8qFets9zKXOVDADiWK7SlU9jYAMJX7sBaaloKZ4s8FEJYDSTNI
         tCdb1Q22k4qBc72CTZ1A7D4kMUEKNjZWOk1PFX6QaJnZ8HqZtBUzL9HxHmosAqosnjaO
         fhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmlDbxR43p/AVKjp9OWEiUiPO2sb+nmDFWo89vNMtlg=;
        b=w+oYClPugdInGpk6Hno4NssBs6qP969W6NhWnUOHWjhSUofCK5RyXT+kx0DR4V9+vY
         p8cNeytDPsZRPPaWvqFMtSvsuNtJbnWy3/s4oAaQp2evkpyxMvFDqq4RJ50dQlG4Ku90
         JF4M6OPpHP110q3DlUEdwVJ/AOvhYN52R7ZrhEd5cAs/DFi5tcah/8rRC37XV6Fedoj7
         nAKc7nyGNf995srL8BkYb2ueZbU3u2sl6MpIWWQ0C11dZ7V0zqWvV32RRbkUmc4EzIlF
         eW+7rntMt00kXs9mJPu3/dAbziVK3pcKkLr6dJvQx7hffEZkvg56mkFeHzNLQMR1aN/X
         OWEw==
X-Gm-Message-State: ACrzQf2/O2oUtGdPqukO/tWeLzU7iSvtvxuzB277LwiIDdZ5ly6waeJT
        knygkcjTXiBaUdth43J9iedX65mR0ZqdCVI5KW3NBQ==
X-Google-Smtp-Source: AMsMyM6dWSMgu33OOYMi6pqhJtdD0hvHbgxTBidAxbGSJKrSQUJ+/zQvT4C+WxuQjurTuoXPI7dmuwFGM+oJm9yuWgo=
X-Received: by 2002:a05:6102:534c:b0:3a7:c31a:a661 with SMTP id
 bq12-20020a056102534c00b003a7c31aa661mr7280950vsb.7.1667310280708; Tue, 01
 Nov 2022 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221024112959.085534368@linuxfoundation.org> <20221024113002.025977656@linuxfoundation.org>
 <CAMSo37XApZ_F5nSQYWFsSqKdMv_gBpfdKG3KN1TDB+QNXqSh0A@mail.gmail.com>
 <Y2C74nuMI3RBroTg@kroah.com> <CAMSo37Vt4BMkY1AJTR5yaWPDaJSQQhbj7xhqnVqDo0Q_Sy6ycg@mail.gmail.com>
 <Y2Egh1LFMvOv6I7m@kroah.com>
In-Reply-To: <Y2Egh1LFMvOv6I7m@kroah.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Tue, 1 Nov 2022 21:44:29 +0800
Message-ID: <CAMSo37XDNfptuK3=MepUUMht4+hqrg8OJMwRTYmu1utW1eJdJA@mail.gmail.com>
Subject: Re: [PATCH 4.19 092/229] once: add DO_ONCE_SLOW() for sleepable contexts
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Eric Dumazet <edumazet@google.com>, Willy Tarreau <w@1wt.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 21:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Nov 01, 2022 at 08:00:03PM +0800, Yongqin Liu wrote:
> > Hi, Greg
> >
> > On Tue, 1 Nov 2022 at 14:26, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Nov 01, 2022 at 02:07:35PM +0800, Yongqin Liu wrote:
> > > > Hello,
> > > >
> > > > As mentioned in the thread for the 5.4 version here[1], it causes a
> > > > crash for the 4.19 kernel too.
> > > > Just paste the log here for reference:
> > >
> > > Can you try this patch please:
> > >
> > >
> > > diff --git a/include/linux/once.h b/include/linux/once.h
> > > index bb58e1c3aa03..3a6671d961b9 100644
> > > --- a/include/linux/once.h
> > > +++ b/include/linux/once.h
> > > @@ -64,7 +64,7 @@ void __do_once_slow_done(bool *done, struct static_key_true *once_key,
> > >  #define DO_ONCE_SLOW(func, ...)                                                     \
> > >         ({                                                                   \
> > >                 bool ___ret = false;                                         \
> > > -               static bool __section(".data.once") ___done = false;         \
> > > +               static bool __section(.data.once) ___done = false;           \
> > >                 static DEFINE_STATIC_KEY_TRUE(___once_key);                  \
> > >                 if (static_branch_unlikely(&___once_key)) {                  \
> > >                         ___ret = __do_once_slow_start(&___done);             \
> >
> >
> > This change works, it does not cause kernel panic again after this
> > change is applied.
>
> Great, thanks!  Can I get a Tested-by: line for the changelog?

Sure, Yongqin Liu <yongqin.liu@linaro.org>

> I'll queue this up in a bit and get it fixed in the next release.

BTW, to be clear, I tested it with one 4.19-q tree based on the latest
ACK android-4.19-q branch[1],
If there is something else I could help test, please let me know.

[1]: https://android.googlesource.com/kernel/common/+/refs/heads/android-4.19-q
-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
