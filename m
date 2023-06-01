Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044867196EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjFAJ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAJ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:27:48 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BAB124;
        Thu,  1 Jun 2023 02:27:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so631184e87.1;
        Thu, 01 Jun 2023 02:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685611665; x=1688203665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZirR1WPIJZVNOLvDsPuKt8AD0CB88Nj04n86hhjg6i4=;
        b=bcFdQRt/Wb1QEUUyH/8czxy/qX1tuWNPn16ZkMi/qptS5kWAuWYaxBeIGNmgDz3qbz
         Qg3nQQF/fIkfE4R/n3S8sPvSdn8f2rZ9gT7wLyHP0BY8lgkrkr1CEf9AkVG3YImKSxB/
         Xyf4Jm0advOdKas6jyQj0AVOnHrCR4IqWiX7XB84QGN4SuwKlF6CjMyo1vuJij2L7zmt
         +ICG3wAEYxmG5/ueQIt09FTvsJYZkSzpJir3cIODfnIThrSxNiNwm9zpnX1L6V7EgK+F
         dNheodiIBH5pwSBPyYWcsLnZBfMAU28wm7rgdSZzGXYQ7gdO1asBwYe+5YnYSTcN4Aca
         oC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685611665; x=1688203665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZirR1WPIJZVNOLvDsPuKt8AD0CB88Nj04n86hhjg6i4=;
        b=gzYM81k26RAldjIro03sT6LhfwDMbfVULrpQK+r6gjybgwZhbNArYBdUEHo2NjhEyv
         iByq9NdbO3IWPKAO2Pum+ieyRS5d/Y3T//+j4WFXCZjI1L9AcTGsT4r8FWM1An3f3rag
         lqHd6NDzsQS/cJ94ZH6UrwCUEMTRpPmohjmIizbqX0TzMgDZ+7vccLnJXbf+aKJtZtzk
         XJ79Xu1dt1p5pAQaOiUWvfFbARiKJo4mq1g3VachHfWWEAaOUL/sQrLipw7m+WpHIgZm
         Qzks6ESr8CdMU07MpVa59eonYXiGa5XHQ7JGPX9P5Kac8b4qvoGgCWqp4VrJ8GDrv+qX
         8sUQ==
X-Gm-Message-State: AC+VfDyPhso0GgZf5QGgUk4tjwLoGuMWPgfeR+xEmYZ9kNZeNyRvOa8i
        zs3tux66aXuCJBkLeQwFxedJ06mhzT89Y6wjHpg=
X-Google-Smtp-Source: ACHHUZ7/Ek8dsYRsbGXaINIgFwouECA0acE7aYF3Bt0x3Z5Dc3mGC3JPbOqKTKJ/13SDDQujvXDk1qAnt2/UY7Q7zu0=
X-Received: by 2002:a2e:7215:0:b0:2b0:4c72:98ff with SMTP id
 n21-20020a2e7215000000b002b04c7298ffmr4131381ljc.7.1685611665030; Thu, 01 Jun
 2023 02:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230521143202.155399-1-tmaimon77@gmail.com> <20230521143202.155399-2-tmaimon77@gmail.com>
 <0e72c35f-5d9d-45a7-5f85-3971b8029106@wanadoo.fr> <CAP6Zq1jOSKpzFvto1LMs=JftLK0fxrrg+73Sh34GunuLfcAfEA@mail.gmail.com>
 <fa7a8bc4-d1a1-3b1a-8b9e-618681d281dd@wanadoo.fr> <CAP6Zq1gb8zJc=2QwNbes-AXP25thKsEVJ11pQfX24eWN62zDMQ@mail.gmail.com>
In-Reply-To: <CAP6Zq1gb8zJc=2QwNbes-AXP25thKsEVJ11pQfX24eWN62zDMQ@mail.gmail.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 1 Jun 2023 12:27:33 +0300
Message-ID: <CAP6Zq1g00SVfPjfQLsgz3V+vU4VHq_MYFcoy0Um46NDZZ9iY_w@mail.gmail.com>
Subject: Re: [PATCH v16 1/1] clk: npcm8xx: add clock controller
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Kind reminder regarding the patch, appreciate your comments.

Thanks,

Tomer

On Mon, 29 May 2023 at 18:52, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> On Mon, 22 May 2023 at 20:36, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
> >
> > Le 22/05/2023 =C3=A0 14:56, Tomer Maimon a =C3=A9crit :
> > > Hi Christophe,
> > >
> > > Thanks for your comments
> > >
> >
> > [...]
> >
> > >>> +static struct clk_hw *
> > >>> +npcm8xx_clk_register_pll(struct device *dev, void __iomem *pllcon,
> > >>> +                      const char *name, const struct clk_parent_da=
ta *parent,
> > >>> +                      unsigned long flags)
> > >>> +{
> > >>> +     struct npcm8xx_clk_pll *pll;
> > >>> +     struct clk_init_data init =3D {};
> > >>> +     int ret;
> > >>> +
> > >>> +     pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
> > >>
> > >> Everything looks devm_()'ed in this driver, except this kzalloc.
> > >> Except the one below, there is no kfree to free this memory, and no
> > >> .remove() function.
> > > Also  clk_hw_register_divider_parent_data doesn't use devm_
> > > about free the pll, we use it, return at the end of the function.
> > > about adding remove, we had a dissection about it in V4, since the
> > > clock is a service driver it shouldn't be removed.
> > > https://patchwork.kernel.org/project/linux-watchdog/patch/20220621131=
424.162355-7-tmaimon77@gmail.com/
> >
> > LoL.
> > At least, I'm consistent :).
> >
> > Just to make it clear, what I mean about kfree() is not to add one here=
,
> > but either:
> >     - to use devm_kzalloc() here, to avoid a leak, should loading the
> > driver fails      OR
> >     - have some kfree() where needed (at least in the error handling
> > path of the probe, if the remove function makes no point)
> O.K. Thanks for your clarification.
> >
> > CJ
>
> Best regards,
>
> Tomer
