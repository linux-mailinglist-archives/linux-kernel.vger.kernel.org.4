Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658A863C176
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiK2NwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiK2NwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:52:19 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2731EDB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:52:15 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id s17so5658530vka.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QoB0zSkTK/9CzXcpMRCnSPpmfyOcbVIIYP6Tcrl6Zw=;
        b=CSlVn8lfM6dFKGc5OaO+5icorEg3mJiRHKkvW3ehGIunnbofgU7hWSMZUvEOuokQBF
         LHzs2FVw5e6ZTtmfVkgbcYF1Cd/AWFiD77LaLn5uiC10FEH20WQNcnznG3Ni8o6RknUE
         Wj4+yBAu5SVoTZ5YMH67hXUHAt6jfiJaFRiCpECydfhwikyIVWW0LlYoA63d4w+zqVf7
         E1MZYGo0hGJ0Oi+B0q8f9IsngHr3ztETS6tue/YpkU4100wDzm8a70dCVeMrdPr/JRB/
         H1fgm5+ornGKfjZqI6vqGA+KrA624tHSREjBpua8RLceAAEAgthJ7Ub5tWMniOK3Hg33
         x13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QoB0zSkTK/9CzXcpMRCnSPpmfyOcbVIIYP6Tcrl6Zw=;
        b=zGC6CR35cAlo4u4UX4AVhgz8QUdY4Zumyq/vvmn0Dntv3EKd72vMchNltqPx95O3Uk
         dUT7BmoyxaQYScIX3qJ9sjjPc6Jy7B/Z3gMnJ5u0lvAxNYEjW/PvKm0U1oN+GbYnhSNA
         D9R9VY2lGK1ZWHDU3KcWvBOk2JvbccanQBPui8K9c7G8ZHfDtS+G1/TxyHkmTL6SO85V
         KglMc67CuvtL+heJOdfjk5XUHfbgoW2c8q+Ixw3cB7itC/4ZqLGHQGCJ5MAro3mSV9Y1
         hrl05xenKfd2OC+X33KHsqvTe+W7B63Yl7BRruf8XQ9VsQjP2eQOBGfTTSFcmBWMqhab
         tkBg==
X-Gm-Message-State: ANoB5pn+gIppstvclHGmonbtVHQ3sG6aZwnn9cRvHJ192LQWQ4uD/A7/
        fR2qZtyqu2JdMkWEo1V2A0epfEDNk9drd1964jL+6Q==
X-Google-Smtp-Source: AA0mqf6XvxQU0ZLVEPXfuPfjqjZD3/4eg0CqPxgPF8qjYVU/NbaJqwOL3T7T9kVQYBjymdmXn/FIMogx8QPc8uvnFto=
X-Received: by 2002:a1f:16ca:0:b0:3bd:8e1:26c4 with SMTP id
 193-20020a1f16ca000000b003bd08e126c4mr751031vkw.3.1669729934175; Tue, 29 Nov
 2022 05:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20221128190055.6350-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mcfy7HjA0DvFgkgJUZ8LVF4Nnrq39jDr82UUVQ6xsmH8w@mail.gmail.com> <Y4YNOd0pBUfqxvmC@smile.fi.intel.com>
In-Reply-To: <Y4YNOd0pBUfqxvmC@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 29 Nov 2022 14:52:03 +0100
Message-ID: <CAMRc=MeLnuxoiUrKqRvUkcL0trsvauLwDEXva3pJuqcRN2Qa=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Provide to_gpio_device() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 2:46 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 29, 2022 at 01:50:51PM +0100, Bartosz Golaszewski wrote:
> > On Mon, Nov 28, 2022 at 8:00 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > > While at it, make sure it becomes no-op at compilation time.
>
> ^^^
>
> > > -       int                     id;
> >
> > Sorry I didn't notice it before but why the churn? This is not needed
> > for container_of to work.
>
> > > +       int                     id;
>
> I hope this explains and can be accepted.
>

Ah, alright makes sense. Applying.

Bart
