Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABCB63984E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 22:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKZVtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 16:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKZVtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 16:49:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F1167CA
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:49:39 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 7so8958585ybp.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 13:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=64rZY6gHcuVaviWfitw7c133Lk1q1wMsjFa4kaG/g+s=;
        b=iP4J6FZzKaMir0+W4S4i3tVRMi0ESzplhJxBU4jXzpD7AquMBJvX0CZteC6hbdh6sz
         Vod09BoB8GrSAWPTQejsBtuqJyKPlM5oTXx9AUoDkVnvz1E2EAX+gzLKARuIL7/MUZ9i
         fO5cdhe78lSAWKQoVLB/DJO0i4g/+/nQEurrSurmpJwDOr54xXq/r5bdTfvuRg+QIMK2
         QTVrh0aV4V00t8m/771s3L5t++xDhj92VgphhnUKOvXCUOsv/Z286yd8hovLVSSjQO5/
         SO0pFAezWkZfB9FB04eKlTnj6vX50JHeqDvXo1HcCQa2/suaaOuMxi0ObrkHV6mzOpfq
         KnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64rZY6gHcuVaviWfitw7c133Lk1q1wMsjFa4kaG/g+s=;
        b=gRxJZw08nV4kYht/ejpA3Qa7cWYAfpwBVdf3KHp3xTkzdBZoCAt3j3My1a/FffGgst
         iQ8ZLVsc+DwEaeOfuVWoZOPZllx3HJgFNCuvcXWMIftK9VT8raTVvGt4rAJTmnfycXy6
         gYYjfpTVJX4ci0CrhE8/eil+Nv3nA+SYnGLSb5VoQZHjYSYFIdjNGV28fbRCk/Jrn5OF
         KRVMF0r3EmcwXt1LDMwxWz+uuTKPCh4tmuPgwSjZWSDMumQtjdpFwscu+yfJgXkb25z/
         Z1DGax2XZWm8ERn2x4N/kS4FoEky22PCHYN94CUrMj8pY+tdHFGHoNqyaYNmmo5pzDab
         Dw8A==
X-Gm-Message-State: ANoB5pnzyChE4HMkOEtcS2Fu8yIDcARSz71ugJH+kbxpqTBu2xX7h3e6
        dG+jNBVxf+dOJPNakVKPYxt5+3LnFrTnrS2lk+fQYA==
X-Google-Smtp-Source: AA0mqf6gdk3XLLJowDZX5ZGc5gTQstM3esNfZxiYvyNeRAMLuMKV5iSVY7uMMAKw8ERGI5Q/odz8aNizpviciL/7GnU=
X-Received: by 2002:a25:c485:0:b0:6be:8e8d:639f with SMTP id
 u127-20020a25c485000000b006be8e8d639fmr40035380ybf.506.1669499378786; Sat, 26
 Nov 2022 13:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-4-dmitry.torokhov@gmail.com> <CACRpkdbARhDuqSiOZM6GZynHsQWau8JhsEa2zcpsPZSLuD07Kg@mail.gmail.com>
 <e4609919-d9be-33c4-1488-352443523b14@xs4all.nl>
In-Reply-To: <e4609919-d9be-33c4-1488-352443523b14@xs4all.nl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 26 Nov 2022 22:49:27 +0100
Message-ID: <CACRpkdaczw75FX17m96s6zS1ng+rp8QXwW2=n8HZ5OKYH6xpsA@mail.gmail.com>
Subject: Re: [PATCH 4/4] media: i2c: s5c73m3: switch to using gpiod API
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 11:34 AM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> On 17/11/2022 10:06, Linus Walleij wrote:
> > On Tue, Nov 15, 2022 at 11:11 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> >
> >> This patch switches the driver away from legacy gpio/of_gpio API to
> >> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> >> make private to gpiolib.
> >>
> >> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> There are now two patches that do this switch to using the gpiod API:
> this one, and one from you:

Ooops we stepped on each others' toes again. Dmitry & I really like
to fix these drivers :D sorry about that.

> https://patchwork.linuxtv.org/project/linux-media/patch/20221108100604.1500909-1-linus.walleij@linaro.org/
>
> Any preference?

Not really, take the one you like best, they look functionally equivalent to me,
just slightly different stylistic choices.

Yours,
Linus Walleij
