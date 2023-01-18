Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583CB671FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjAROdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjAROdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:33:19 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E1B86B3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:22:02 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id c21so8292444vkn.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PreMjGjZsF7lqhLbxV3OStzpsSafhCzhHjI8R0DjNkM=;
        b=v3rwYmnDD3cCLb4ZrOWkFTw+CBFHk9zfZUwlVu15qeNhhgM+i37Tx0dnfjC84/f95p
         A+8yPCnVIKgufF5mW+p1URRGcP6txjBEyCNcs87aoJ/DyxKx4eJ8zOixI4d1o64jK1FR
         XisbvryIzII5BWWe8wm4HUNODaYJL1SLl9c/t4LDVtu8RDIfpInMPlF6uP/z5Vck84Wx
         ela+DkGvwqN2MrHai9QjGvNypZTm3/eMK+Dzr3sdYYAgka4/NMbfJTbK/WeC3VBg2Jr9
         Z2IWJpnh3kEt9N0DRswCPmHxl17DR+U4oVgTq8NrLgqAwcm0wmgeFtuP0LaWzIFzHS7M
         ej/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PreMjGjZsF7lqhLbxV3OStzpsSafhCzhHjI8R0DjNkM=;
        b=dXiZlt8/imOp5jmvxO1c9zU3RBGCuCFAn5tAAMvvFaF04YgA/yawq4lTmwRFHV9xmu
         7QSn1wp5TsK7Ml4ybvHqwLYSipHviGKTtmSQFrpcFMGJOvYon5w7lRPxg7s2z+m1PWkf
         w/6CMFlqdwPS9ufQ7R3WxbufaFguCZ7x7zUpPzIclO8hbwZWvScXQhZutiP6QZ5nCSp4
         +lr8LYZyn3EGyoM4Hsgwm6i51QeI2ZFU+Ne8tI48DIiU6CefRrs3dQ+vhIAqiECFYxbY
         3Uvob/cPBy8dix0MshTtOgY8lI67xHND9oHDdLv17BzJ2E3/coGG1T62m1vD81DJvwJk
         /4tg==
X-Gm-Message-State: AFqh2kpahsPyVfAoiad83QIalrGBhr3mp6R8LAEIYKlD+laxmiRU1YrB
        ROqFdRuzslOvL9jl5NUGFC+TsTvTyhE9OBt+7J0Xqw==
X-Google-Smtp-Source: AMrXdXuKjBdbHYRlIePfa3qvBKsJAzAwpG3MeDFWDARe8ewUWeS4KyCpdruXxdyakIFQjNyQKIjPz2hSeG7alzhMHcA=
X-Received: by 2002:a1f:3283:0:b0:3dd:f7cf:e67e with SMTP id
 y125-20020a1f3283000000b003ddf7cfe67emr876393vky.33.1674051721920; Wed, 18
 Jan 2023 06:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
 <CAMRc=MfeQ_92Vb6inv-1_h=kc1d2as6LLPqJHHtbNk1pK1xRuA@mail.gmail.com> <AM6PR08MB437640AB4B959DD356162F2BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB437640AB4B959DD356162F2BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 18 Jan 2023 15:21:51 +0100
Message-ID: <CAMRc=MfN5o32AminWbjHVh_OBy-uAOJZyvb-1zhn7zs6EVyhMw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 11:17 AM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:
>
> On Tue, Jan 17, 2023 at 10:36 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Mon, Jan 16, 2023 at 3:08 PM Pierluigi Passaro
> > <pierluigi.p@variscite.com> wrote:
> > >
> > > Both the functions gpiochip_request_own_desc and
> > > gpiochip_free_own_desc are exported from
> > >     drivers/gpio/gpiolib.c
> > > but this file is compiled only when CONFIG_GPIOLIB is enabled.
> > > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
> > > reasonable definitions in the "#else" branch.
> > >
> > > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Please add a Fixes tag.
> >
> I beg your pardon for the question: how can I "add a Fixes tag" ?
> Can you point me to any reference documentation / instructions ?
> Thanks
> >

Look at the output of `git blame` on the file in question and see who
added the changes that introduced the problem. Then, before your
Sign-off in the git message add: Fixes: <12 chars of the commit hash>
("<commit subject>"). See Existing commits with fixes for reference.

Bart
