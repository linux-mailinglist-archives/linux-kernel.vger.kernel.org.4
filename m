Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D254610B74
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJ1HlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiJ1Hk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:40:56 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0AE8C59
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:40:54 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id k4so46298qkj.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK2gJkk+H9nNRpDLDuVeuznmC5JMgjPaOxjNr5txsvY=;
        b=hhH9+V9EdN9rl+/Gu0CWYbcib/xfCq0soM4RO3p2yi+tnL1097JbI2xSyRWNQ380HC
         i9t5PhvLniRqU2VHSo4X6IAEihYnWU1iEuZNOe0lAaICJz2IRqI5LWoHx05U5mZRlYxC
         IoR9j3lL1iuc7jv3dSfUhKM7zuC6kmyDkF9P9eWmq3L6crW1ZoziL/gUW+R2HBZ3D8gW
         mllIyD1iP4riEk6PYTDwzDiQEnl1SgCV/UHgCCnCMtAN8h1Jay5GKfhRr42OwtRPnOE/
         o1tGZSsKe9TZ3W1hBFbF6smH9Dyy9hCXcKX3xGhyOBJjdx5dInYSvL3yHyA8NqlhLzAi
         FFcg==
X-Gm-Message-State: ACrzQf0Krel94zB2oyDoOPWAtz5YopgWImQaqsEFJvMSDP3oQ0wvw+Os
        2vbQsHQmCDyX4AMFzHEnwaAMDhY9d3Bbig==
X-Google-Smtp-Source: AMsMyM6Hg6BKvZKXnxyEWtp8qGrEh1+QOhZM0jLxXzu0L3fcicunW3E6qfiCFjQ+aRKdP9AnA3RT3g==
X-Received: by 2002:a05:620a:946:b0:6fa:9b0:6756 with SMTP id w6-20020a05620a094600b006fa09b06756mr804216qkw.359.1666942853286;
        Fri, 28 Oct 2022 00:40:53 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d184-20020ae9efc1000000b006ce9e880c6fsm193506qkg.111.2022.10.28.00.40.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 00:40:52 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 187so5284022ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:40:51 -0700 (PDT)
X-Received: by 2002:a5b:34c:0:b0:6cb:b329:e103 with SMTP id
 q12-20020a5b034c000000b006cbb329e103mr10053217ybp.543.1666942851560; Fri, 28
 Oct 2022 00:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <Y1tlgUVWLBRSIt5U@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
In-Reply-To: <Y1tlgUVWLBRSIt5U@dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 09:40:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWawWM0damaJQiXNqkSMCWTs1qh+PLojXeYJFUvW_KXkw@mail.gmail.com>
Message-ID: <CAMuHMdWawWM0damaJQiXNqkSMCWTs1qh+PLojXeYJFUvW_KXkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Change myself to a maintainer
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matt.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 7:21 AM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> After some off-list discussion with Marek Vasut and Geert Uytterhoeven
> and finally a kx022a driver related discussion with Joe Perches
> https://lore.kernel.org/lkml/92c3f72e60bc99bf4a21da259b4d78c1bdca447d.camel@perches.com/
> it seems that my status as a reviewer has been wrong. I do look after
> the ROHM/Kionix drivers I've authored and currently I am also paid to do
> so as is reflected by the 'S: Supported'. According to Joe, the reviewer
> entry in MAINTAINERS do not indicate such level of support and having a
> reviewer supporting an IC is a contradiction.
>
> Switch undersigned from a reviewer to a maintainer for IC drivers I am
> taking care of.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
