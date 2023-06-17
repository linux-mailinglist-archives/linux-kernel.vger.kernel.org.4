Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6967341A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjFQOZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbjFQOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:25:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE21BF0;
        Sat, 17 Jun 2023 07:25:23 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76238f9fa19so123596285a.3;
        Sat, 17 Jun 2023 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687011922; x=1689603922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/hW4KrzlulcIit7yOnqhzpsxVw/HtKrLUEkP+c5o+0=;
        b=STZQ0UtUqsqcQoYRs5+e6p13UGsIcu4y9cnmZD9Cigc96PRDs4kQayzr0GGvEfP4Ak
         uxuewRFMRN7OuvxNTEfXgXwD8k2mqozRkw6yEE/0/pivEVvecTwfcKkTkMM6GK0XXRaQ
         XAl+GwYy3A7KAKIjg7gbfc7T4Rw67pxuzfqQpUrXoaZ0M1PzH7t4SkiSh/vhzgVvTsAV
         CEsAP3gs0VhCMFp0oj10Vom0ETWoxiPxlLzyXwCJS3H9iNwDWexc5XmZ+F6vpfnAd+/7
         x6QCbLvn7vk2iXKHDIM5aR6a4f1UjnsZm251pOCRiicx3KEd7fAPMG+Uj3FyZTYX7nev
         x3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687011922; x=1689603922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/hW4KrzlulcIit7yOnqhzpsxVw/HtKrLUEkP+c5o+0=;
        b=Pm05UoJqgkeSyrNjoqPQGxgC14aY6nP0G02DhHFBkHelWLi91pwX1OuB+a40jsZRRO
         Q7CmQRjISc4Y2YPaTVkxm7yXEETk+GGYD2ntSLk3jhF67iek86NXVcg/mR8e77J190lc
         tYbcza4u0q8hXEnWZPRlOcWhAMc5x1jtKOyHVZumFFwbMNCsoNNP83POcGP0knz/EYFK
         eat13YMwS0tie1Ht9QJCRd7yGM5+6j8mx876tFfbdF0q5JwQMCTdvlzbCHhfqT5MGJKi
         vDedOEu9JfmO1XtroNISs4FUcbwBp+Syh5VTnEQssqZti3PVe8vtpVfb25VuiUMnt0lb
         /pfw==
X-Gm-Message-State: AC+VfDwyB/isxenhxlbZ/mIjAWDv8Gki/9L17g1qVx2ZzP+y37gvSOJN
        yqM78K055deYMOYJk8Bujsl6JmkMZrCKgROPLgzfpI8BDqg=
X-Google-Smtp-Source: ACHHUZ7fhx/qRuEbZx4DH9s3pO2OCJ7PMQcbZHGZ6W0bEjdi1+0whZNmPbHN1lBZ4l0jzT9MT9nqmQEb8ROE76mJMYs=
X-Received: by 2002:ad4:5c68:0:b0:62f:fc16:4037 with SMTP id
 i8-20020ad45c68000000b0062ffc164037mr6628152qvh.14.1687011922617; Sat, 17 Jun
 2023 07:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
 <ZIxuExRypHsUejFI@smile.fi.intel.com> <4b55afe91d2a704c0229340c5ea4885e@walle.cc>
In-Reply-To: <4b55afe91d2a704c0229340c5ea4885e@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Jun 2023 17:24:46 +0300
Message-ID: <CAHp75VfJ4vB2yWY6rFQrRh3Sbz9bg-fgKXXH-_-YFHMHuM=ZLw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiawen Wu <jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 9:02=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
> Am 2023-06-16 16:13, schrieb Andy Shevchenko:
> > On Fri, Jun 16, 2023 at 09:30:06AM +0200, Michael Walle wrote:

...

> >>      /* Remove all IRQ mappings and delete the domain */
> >> -    if (gc->irq.domain) {
> >> +    if (!gc->irq.domain_is_ext && gc->irq.domain) {
> >
> > Looking at this, perhaps positive about allocation?
> >
> >       domain_is_allocated?
>
> I mean all domains are allocated ;)
>
> domain_is_allocated_externally? I'm bad with short and concise
> names..

Naming is one of the hardest problems in software...
Your variant is long, but conscious. I dunno. Bart, Linus, do you have
any ideas?

--=20
With Best Regards,
Andy Shevchenko
