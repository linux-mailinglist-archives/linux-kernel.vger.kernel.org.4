Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EB374EFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjGKNK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGKNKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:10:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C9F7;
        Tue, 11 Jul 2023 06:10:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991da766865so717070966b.0;
        Tue, 11 Jul 2023 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689081052; x=1691673052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRZ9gjmw87g4brURnBpYdWp0aYueIrOdUQ52IUQwaEM=;
        b=cl3zLznOWKZlQ4FhQ4x9jVeFgq49i98IJvZ5DzdrnsEHtyTjAG3YAYm9ZCG79BqkE3
         PpW6MoOehui8YuNMfi8PIM7BEK/XXpGx8gO/mCl4KtxFQBb3OrEG9G+gtJz8Ao6xqWb4
         w7fgHoggn6rdQ7bBRh7FTNCl4iqXbBReeINgUwtwy/lLQvfYeCx5KGUI259XGPKXqn7u
         H8bTGZuVjpEeuibFOQR7ddYDIb3d1JxNNfPDBxa/hjr8C7aNL8jxkxQjVUFoPTucbX2L
         QDLUaJ1/q89+lKUJIEW1Pqpn4XeSfFG/lwnE7ytlKUkOFjBoausDyn9l8jZxOkypjZH3
         3/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689081052; x=1691673052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRZ9gjmw87g4brURnBpYdWp0aYueIrOdUQ52IUQwaEM=;
        b=bQ4BCzwEirIjlNuKhPubiBdWObPVLvhYT7ntYX7fni6u6PVfA4n+l8ZrBmjfZM5YWm
         wiJQXeXTYVIolH6dqn/FvC1oE7PMkoeF0XYdPTkQm3HXma5iErPWruwqM+adNNKTbAqe
         odtpdHR10o38X8bmAg3vLkfqUjohrOvZfclXZ5XzSV8Y4DA9LtAIUKHtluu74YIcYM0r
         t7MvMirQtYdEY4LNZBsGBwW7dXgQ1FgHavbZ46gqvvztgsMX6z0LHDoI8akBIfrDa74o
         5S1vuZZMiqkpbKlfLr09SkbfNpPb3mCMmy539vLb6d0kEwGy2JJ6jVIoD0VnxVJPeeHG
         Nlhg==
X-Gm-Message-State: ABy/qLaDMQGWAYUX12chuyTG7+rb6oe0cOSCwK4RgtdyBclr8j2jegdA
        HYyRo0bxf5d+EBKLMdqvfRFRwxStlN5/mCyBwbs=
X-Google-Smtp-Source: APBJJlH9JgkV6PLxfAvmProv9EI7zKZRqCSvA3fW+TyrlhKR/oqWJq9RZBKui/jrAuP21xvOz/Goq7zDAi5DI+1NDBA=
X-Received: by 2002:a17:906:196:b0:994:17e3:2754 with SMTP id
 22-20020a170906019600b0099417e32754mr2009930ejb.17.1689081052199; Tue, 11 Jul
 2023 06:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230710215023.679-1-asmaa@nvidia.com> <CAHp75Ve87oHP4P-=xHZgHuWyJJnpuARH+qzXO_vJRhUeovXMWQ@mail.gmail.com>
 <CH2PR12MB38958A4ABF8397A53D68F41AD731A@CH2PR12MB3895.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB38958A4ABF8397A53D68F41AD731A@CH2PR12MB3895.namprd12.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jul 2023 16:10:16 +0300
Message-ID: <CAHp75VcJ0x2Bv9afALWsxB3EWWB7YEfo+rzZpKiafdm74z_aWQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mmio: fix calculation of bgpio_bits
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 3:23=E2=80=AFPM Asmaa Mnebhi <asmaa@nvidia.com> wro=
te:
>
> > > If the "ngpios" property is specified, bgpio_bits is calculated as th=
e
> > > round up value of ngpio. At the moment, the only requirement specifie=
d
> > > is that the round up value must be a multiple of 8 but it should also
> > > be a power of 2 because we provide accessors based on the bank size i=
n
> > > bgpio_setup_accessors().
> >
> > Is this a fixup for the other patch? If so, then why did you split them=
 again?
> >
> Apologies, I might have misunderstood your previous comment. I thought yo=
u asked me to split it again so that it is a rebased continuation of the ap=
proved old patches.

No, I asked to move the changelog section to be not a part of the
commit message and asked what happened to the tags, because you
dropped them.

> To avoid any further misunderstandings on my part , could you please conf=
irm the following:
> 1) I will create one patch combining both

_If_ I understood the patch flow correctly, and it means that one is
the fix to the other one, then yes, otherwise no, keep them split with
appropriate Fixes tag added.

> 2) The tag for this one patch will be "[PATCH v2] gpio: mmio: handle "ngp=
ios" properly in bgpio_init()"
> And Reviewed-By Andy and Linus.

What do you mean by "tag" in this context? Do you mean "Subject" or
title? Otherwise it's very confusing.
For the Rb tag by me, yes, please keep it. As for Linus' one I think
you should drop it and add a changelog entry to explain why, because
that tag is only for the "fix" part. Do not forget to Cc Linus.

> 3) I will add in the commit message , a changelog section as shown below:
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>

It's mandatory according to the Submitting Patches documentation. Read
it for clarification on how to use and when the tags.

> ---
> V1->v2:
> - rebase + combination of the 2 patches.

I believe this needs more entries. Since it's not part of the commit
message, you may use free wording to explain what exactly had happened
to the patches, with links, references, etc.

--=20
With Best Regards,
Andy Shevchenko
