Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00F572FD66
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244194AbjFNLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjFNLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:52:23 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCFA1BF3;
        Wed, 14 Jun 2023 04:52:22 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62fe6773c4fso3198736d6.2;
        Wed, 14 Jun 2023 04:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686743540; x=1689335540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQzjvB2/E4BuxnxzFWq+E7kZcQfXoFct1LFCiMktZS8=;
        b=GzP9YZc9Nxf4T2AW8Q8hO76zBgh47xmFmED4h1Fc+HXSmpVx+n8NbbKB2L00mXY2D7
         G4ulS0Fpiuqz0WY+8wH1wsgkFbuNdfQ2ulDnusGqCbV3RraiFcyANdBqb7TVJYDTP2Hh
         S1cEqXDhvbaD9uV96baRdkaLQWi9xfsyiqhyvz7l1jTEdfQ9Pwab1jk2msXSlX8Hc199
         2S0aakpOrtNRhyMozwoon/6l++5u39dKLlAblh5zXGdqVHZ012xuNilUvE12WOw8lyjL
         fWuFEGHzvWaEK0HZsCmjAIm2/ALSZwFhurgI9x3AlBOru0TaKvQaUd+JMvDy4NHIERl8
         x2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686743540; x=1689335540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQzjvB2/E4BuxnxzFWq+E7kZcQfXoFct1LFCiMktZS8=;
        b=XS0xOB87r6IzpASLSm+PjzZaxLa3ZGiGtzMefj6nU1AMm/uuiICTSQqcMjey0xF9GO
         fVcb9pAiSMqJK8iUF5Lrs6XsOjs/of8q5wB/8C/c2qm4YPgCOdRsAZz+/VZhuI6bOxQf
         iHF5l01IjpUxtETbcuTY4C3mRM6CL1UGCMt9LdiKjh9rDGmzv0cF2zmRnDOFtWMe8wyx
         etwpUwN+7FWOODlPyVHtmyKjqtopaChij8HrcW5eDAkaK+tXcc7Pxs9SHxNVxBt+pMSj
         0vwlbj++36PKc2tJGs8TPOELbblILDT9TBx1DoEmO7cYw90vhFKzuqqNfe2kqwuGjSx7
         AqWA==
X-Gm-Message-State: AC+VfDyr4OQJ3skkkjYBbs8JR7kvKoKOi+JKwNRM/KI06YMfl+ySOO4u
        ZB6jco1viZQOGtUhPcowvz0+qrNziAIzS92xA1I=
X-Google-Smtp-Source: ACHHUZ7jeIS46iA9kp2IDTdw+Yv6lPjFxYeU5SPJjDwY7dxraYGEZszXvUcZ4Ee61amfJMfv0nnVUgEVzshrVjaiU9Y=
X-Received: by 2002:a05:6214:4018:b0:629:78ae:80f8 with SMTP id
 kd24-20020a056214401800b0062978ae80f8mr16092327qvb.10.1686743540056; Wed, 14
 Jun 2023 04:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com>
 <20230614074904.29085-8-herve.codina@bootlin.com> <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
 <20230614114214.1371485e@bootlin.com>
In-Reply-To: <20230614114214.1371485e@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jun 2023 14:51:43 +0300
Message-ID: <CAHp75VcmW2StPqb_LtKFyNyJ2+jz3c19zNRDiSuGs06Bseq04w@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Wed, Jun 14, 2023 at 12:42=E2=80=AFPM Herve Codina <herve.codina@bootlin=
.com> wrote:
> On Wed, 14 Jun 2023 12:02:57 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 14, 2023 at 10:49=E2=80=AFAM Herve Codina <herve.codina@boo=
tlin.com> wrote:

...

> > > +       typeof(__array[0] + 0) __element =3D __array[--__len];    \
> >
> > Do we need the ' + 0' part?
>
> Yes.
>
> __array can be an array of const items and it is legitimate to get the
> minimum value from const items.
>
> typeof(__array[0]) keeps the const qualifier but we need to assign __elem=
ent
> in the loop.
> One way to drop the const qualifier is to get the type from a rvalue comp=
uted
> from __array[0]. This rvalue has to have the exact same type with only th=
e const
> dropped.
> '__array[0] + 0' was a perfect canditate.

Seems like this also deserves a comment. But if the series is accepted
as is, it may be done as a follow up.

--=20
With Best Regards,
Andy Shevchenko
