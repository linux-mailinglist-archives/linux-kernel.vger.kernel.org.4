Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19437370D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjFTPqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFTPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:46:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2829197;
        Tue, 20 Jun 2023 08:46:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-982a0232bdcso757745566b.1;
        Tue, 20 Jun 2023 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275988; x=1689867988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/RW3JooPHXhGkbyA94yMT3Iw5yY/0I6MyTT7xjBS5I=;
        b=DMscuMJX1SgH/ZMDaay/ucX0Dt22ZRlsDF2WiTjEGqRL6Rh35yuWu2lwqw1EbEroJu
         kHvDKSyxpzML7Rod8yHxHsRj1YG2+Ql+t2/bFTjezJ+uwdHw983wYOjhdt/NpigZBxjQ
         4uqH/nEa+j2ynZFBmZ5gtse4I8Cu/I2eBNkOEFX9K0JI4120XoomphK/4VP4+DkSQ/Qe
         DgfoqQvyJO+DcmcvTuunmqVZU2rx9neu7GVSb5qP+mg4DyBkVvgP0me9JgPZw0zfjbyG
         l4oeqEWZAab+MhqHJfLTatdnH1BWgOTNc5OUQyrPSbKZ/kjTxQKUWP+117/UrY2KI8lb
         yEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275988; x=1689867988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/RW3JooPHXhGkbyA94yMT3Iw5yY/0I6MyTT7xjBS5I=;
        b=a23GDIqlBEaV5N1E8T4Xqd9jkuPpzxOiCLcoUqnJ2OHPy0rBwxeolhu2C4KeUIF+5M
         Cjsbw9SLpROXMoNDLmLfsoOhZ7vU61zxUvlgdJoZzd1PyrgqTvzdOB/uodGsC+d9cMnO
         QCOt3pkgq0b4vWtkoplCG153QiAaFS+bQKHIEvR3LH4HlQupKc7OL5ediqI61dbxBOY2
         9PZqJuW05/PMsZxXO/ec56Ih+iOofP3ScdoqqBV0p79qvynInHD58CDuMOiiSBQ/dooD
         lb01IR0mVN7jU+SQzTa89GYDW9NvjoBVN2f3zzGoHh+QJTDeVMEitYWCXZfyOnqgSgCA
         ZOuQ==
X-Gm-Message-State: AC+VfDzYQ1WhYSx4Yo50cBApNO+I4Kx+YbVuFkS7/ke03GPZ3zjMAX0G
        hz2JaO4xqwNhZSKYPb7zj1m/IWgdxKY0vdgWnSQ=
X-Google-Smtp-Source: ACHHUZ6C/gu2jGagJ+kXr36/3xOOzDbuha8PHdogLOBTdzGkn/ZSZEHPqGTwjJo4zlCLCLyzblv41yYzqroYhJWoBao=
X-Received: by 2002:a17:907:968c:b0:988:a779:cc6e with SMTP id
 hd12-20020a170907968c00b00988a779cc6emr6047920ejc.51.1687275987989; Tue, 20
 Jun 2023 08:46:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230602152626.284324-1-hugo@hugovil.com> <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh> <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
 <20230604134459.3c3844012e9714fa2a61e642@hugovil.com> <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
 <20230620100846.d58436efc061fb91074fa7e5@hugovil.com> <CAHp75VcWSVgA8LFLo0-b5TfKWdHb2GfLpXV-V3PZvthTv1Xc4A@mail.gmail.com>
 <20230620113312.882d8f0c7d5603b1c93f33fb@hugovil.com> <CAHp75VfGm6=ULW6kMjsg2OgB1z1T0YdmzvCTa3DFXXX-q_RnfA@mail.gmail.com>
 <20230620114209.fb5272ad8cf5c5e2895d68b1@hugovil.com>
In-Reply-To: <20230620114209.fb5272ad8cf5c5e2895d68b1@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jun 2023 18:45:51 +0300
Message-ID: <CAHp75VcieuYqxWrO7rknx2ROYz=rnWnKV6s9eXZ5Zd1BKc6YMg@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
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

On Tue, Jun 20, 2023 at 6:42=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Tue, 20 Jun 2023 18:35:48 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 20, 2023 at 6:33=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.c=
om> wrote:
> > > On Tue, 20 Jun 2023 18:18:12 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Jun 20, 2023 at 5:08=E2=80=AFPM Hugo Villeneuve <hugo@hugov=
il.com> wrote:
> > > > > On Sun, 4 Jun 2023 22:31:04 +0300
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > > > did you have a chance to look at V8 (sent two weks ago) which fix=
ed all
> > > > > of what we discussed?
> > > >
> > > > The patch 6 already has my tag, anything specific you want me to do=
?
> > >
> > > Hi Andy,
> > > I forgot to remove your "Reviewed-by: Andy..." tag before sending V8
> > > since there were some changes involved in patch 6 and I wanted you to
> > > review them. Can you confirm if the changes are correct?
> > >
> > > I also added a new patch "remove obsolete out_thread label". It has n=
o
> > > real impact on the code generation itself, but maybe you can review a=
nd
> > > confirm if tags are ok or not, based on commit message and also
> > > additional commit message.
> >
> > Both are fine to me.
>
> Hi,
> Ok, thank you for reviewing this.
>
> I guess now we are good to go with this series if the stable tags and
> patches order are good after Greg's review?

Taking into account that we are at rc7, and even with Fixes tags in
your series I think Greg might take this after v6.5-0rc1 is out. It's
up to him how to proceed with that. Note, he usually has thousands of
patches in backlog, you might need to respin it after the above
mentioned rc1.


--=20
With Best Regards,
Andy Shevchenko
