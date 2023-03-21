Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BFD6C2B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCUHkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUHkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:40:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD79399CD;
        Tue, 21 Mar 2023 00:40:05 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id hf2so12710923qtb.3;
        Tue, 21 Mar 2023 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679384404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnIPjLUX4Z510IIWWpC84rJwmT7E/XQS4mQtVQn1qpY=;
        b=a84YNjiDt/ukjiaAMrfaImmA6dl//kFXJyl1tEzAMKAmwAEZOnT8mlIJxmreZCxQGD
         Pg6cU7xcgVnCvbEJRvYuzSiLZW2c2rtaeN3A0Z5AaLwuy0DhQ1rskthn447GR6vOG2wX
         XTy0xC6pmIggXXQ9qVp07/XLNj2tb7QQkRq1rbnMJ1tusCvCGrU+QU/uAo9WuiYyufLk
         LlDtigTyw+ngkIxzqb5h1ML7ZNEdVxq8kuZ3FkrZuIwx4JGs9iqlY2cesSPldLvQossi
         tQU6y/YINoY64htu9OUYOrOOuu1x7bvMVZHxsx06TJt0ZfuBWfmNP5OIwtxCUJn/wF6f
         zmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnIPjLUX4Z510IIWWpC84rJwmT7E/XQS4mQtVQn1qpY=;
        b=lq1ph+EaiutfNbS69kfk5btDn4+uSf7cA639vwSd8EeiVLwJnL55OvXya/BuJyJI0D
         TxzzBoUMYB06Ul1VolVdGsXD06BA+7eoz7DEsNY2Of8e4t8QQlkDfFw2+0LMWx5SIk8+
         aZKeCNB7XyqYCwgm8vU2CJ3IhDXTj3NBou9nIhcqwz9JxmQ6Aec5eGAyaBr/Kn0UCeWf
         SaME2Bo7de8jumCBFMNMb8n7YAXc/q3hl6LHnESteZIHEGaBQuKwY0txttq8iqrePgiq
         nwe5VeXPC0CP1WJMUrc50ll9EflmAx1SvifEPiMrowFSdtjCLTkB7xXNM3Q7MhDpe9ZE
         EFBg==
X-Gm-Message-State: AO0yUKVwD4dUayRHDfoQ1+4UIEfpJ1a0+l5bMmi6Q1sq5fVoLQTnFIlj
        9KzWLVuGaeRQyWutrU6GynSRqNwpAXmrjddyP1Q=
X-Google-Smtp-Source: AK7set+JdDi4nQCqWcqZ+QfR6HDyzcHEPETHG6UZatxhiS8BK8WqbOlmhGsM6+JKmWiYGS1oXBRO8vq3k/tfWwFzlhE=
X-Received: by 2002:a05:622a:189c:b0:3de:fa64:ff2b with SMTP id
 v28-20020a05622a189c00b003defa64ff2bmr697114qtc.0.1679384404132; Tue, 21 Mar
 2023 00:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230320163823.886-1-clin@suse.com> <20230320163823.886-5-clin@suse.com>
 <CAHp75VfFTjPFMQ91yHC4O1enTJqtww7ur8ppwa1rqT_7WNzDTQ@mail.gmail.com> <ZBk7/h4nquwZShv1@linux-8mug>
In-Reply-To: <ZBk7/h4nquwZShv1@linux-8mug>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Mar 2023 09:39:28 +0200
Message-ID: <CAHp75VdbUH6D2drFwpdX06EwqqJhkNm1jq8ABrw5oZw79frziw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pinctrl: s32cc: embed generic struct pingroup and pinfunction
To:     Chester Lin <clin@suse.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        NXP S32 Linux Team <s32@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Radu Pirea <radu-nicolae.pirea@nxp.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 7:09=E2=80=AFAM Chester Lin <clin@suse.com> wrote:
> On Mon, Mar 20, 2023 at 07:10:40PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 20, 2023 at 6:39=E2=80=AFPM Chester Lin <clin@suse.com> wro=
te:

...

> > >         for_each_child_of_node(np, child) {
> > > -               func->groups[i] =3D child->name;
> > > +               groups[i] =3D (char *)child->name;

Here is also questionable casting.

...

> > > +       func->groups =3D (const char **)groups;
> >
> > Hmm... Why is casting needed?
>
> It's used for fulfilling the type checking done by kbuild otherwise an er=
ror will occur:
>
> drivers/pinctrl/nxp/pinctrl-s32cc.c:815:22: error: assignment to 'const c=
har * const*' from incompatible pointer type 'char **' [-Werror=3Dincompati=
ble-pointer-types]
>
> In 'struct pinfunction', the member 'groups' is declared as (const char *=
 const *).

So, please decouple `struct pingroup` change to a separate patch and
hence `struct pinfunction` on its own.

After, consider changing types elsewhere that are following the types
in that data structures.

--=20
With Best Regards,
Andy Shevchenko
