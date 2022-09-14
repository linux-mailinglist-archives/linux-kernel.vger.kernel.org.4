Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D288B5B8BAF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiINPWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:22:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570F12F02D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:22:47 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id bj12so35460302ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KH8Dj08mG5rKjlmcghool6K7gceokPRFB+a5vuX9abM=;
        b=S1yVSGr7CQ8HTrcYaFVaPTstEehf/ZSFvoQH+yOLJzZGPcIU3vC0fke0nWkNHlwpL+
         hVE/b/JhFOBWk+rtjXaL+eO1u2jB1urpM8pUN6nRJWvttUsvh9c4Zh8iQmtbJyKTrBqz
         WP6Zcl83/G6taGRFeMdv7p8chPsZLNtNpNk2U1zoslTm2E9g/UXc55JVUlcN40CMXQqT
         3tCY/OK2DC0bTYMZ03v7yIBRKk5BQ7EI6JBVQawlmgBZtWkWuxPyuPNmPUXgblTVSPEE
         il7BUdBG4IZaajTlLrkoAHxtsrHW0ETqoaiktQUgLodeVZT3Z0u9Gw5vy4Jw9E+fUcpM
         goRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KH8Dj08mG5rKjlmcghool6K7gceokPRFB+a5vuX9abM=;
        b=oqNbnr1WVpKCbRb4bq/uAni763DsqKi/N/xM1Dirvh4gfYNCR8BVVjF+8L8B2z/sJa
         nkOZE/BNselejt0yf6QrQ734fsYsj0TU6sfzBvk4ShfSEoRUFnn+5womzzdwIBlmFFdI
         QVdk1y1g1pBSy/6hm8SmWbkruZ2FAPdc3rEai60dDZ0XF/Zug5XE1Orb1botU9c2LhpX
         Kl43wP7KiszYq0jh/md1loBiC+TfHLH2T9noC+4+/DzDopEOojCoiuPpu4VaSQT4Z9B8
         eiQUhJuaOoVnhXTZPjpJG5JXkJsRGSgE3UqX22O43WfHyjHQ4uJoGqXaay068gp9Uzyj
         Zl1A==
X-Gm-Message-State: ACgBeo0pc7b47ZLJHjogy/utvjWuox6AvmFYKNWYLQEMX+bQdO9Wz2Xu
        nECIkPTre/ja41dcmoPRvsnD/4I7etfc/FUM1DxreQ==
X-Google-Smtp-Source: AA6agR7+Nntxp/kqDoMvWVUsubuxF7Ih4a1CtVd4sIFTsPIZIjs4U4Tj4i7x7CfwW8C/miOxVz21uHAp4Sq6PX5XF2s=
X-Received: by 2002:a17:907:3e07:b0:774:53ba:6b27 with SMTP id
 hp7-20020a1709073e0700b0077453ba6b27mr21202699ejc.286.1663168965960; Wed, 14
 Sep 2022 08:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220914151145.73253-1-brgl@bgdev.pl> <CAMuHMdV7__tOo1waXCg7ayKG9XLxKWZfqZX56vXPH6oPEmPj9g@mail.gmail.com>
In-Reply-To: <CAMuHMdV7__tOo1waXCg7ayKG9XLxKWZfqZX56vXPH6oPEmPj9g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 14 Sep 2022 17:22:35 +0200
Message-ID: <CAMRc=MeVA6-SgVumPoA_593K=-+zF3mF_HSkdjBtK+ymR2-2Ew@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: TODO: add an item about GPIO safe-state
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 5:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Bartosz,
>
> On Wed, Sep 14, 2022 at 4:11 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > This adds a new TODO item for gpiolib and can also be used to start
> > a discussion about the need for it and implementation details.
> >
> > Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> > --- a/drivers/gpio/TODO
> > +++ b/drivers/gpio/TODO
>
> > +This item is about proposing a solution, most likely in the form of a new device
> > +property called "safe-state" that would define the safe states of specific lines
> > +(e.g. output-high) but not block the line from being requested by users who
> > +could then modify that default state. Once released the GPIO core would then
> > +put the line back into the "safe-state".
>
> #bikeshedding
>
> If this state is the "safe" state, would that imply that any other state is
> "unsafe"? I guess not, as the idea is that a knowledgeable driver can
> still change it (else a hog would be sufficient).
> Hence I think "idle-state" would reflect this better. Any other thoughts?
>

No, you're right, you even mentioned the name "idle-state" during the
BoF session.

Bart
