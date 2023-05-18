Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12CA7076E9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjERA1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:27:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C39212F;
        Wed, 17 May 2023 17:27:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25344113e9bso1058583a91.3;
        Wed, 17 May 2023 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684369667; x=1686961667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6TuSq6N4Ik07SdPtfy50jQBhSsVtsVbqdpHx3gygEM=;
        b=Wrh2MEf4S3uodC6iY/NhQp26vdHjhRVTb4bWxrzC701t//m5uIlIEA1xNUsMmIjIHm
         XGkwiIi1CL+Df32ywGLR/HHePrHogAyI3HGWiiogd/bOf0gGUIL0ij3o1M1WPPksX8NM
         NpmA4tfmxH03RCk5qVJDADaudLJu8YgQQapx8PNsPYVmM+rKVntluAeyltkPLw95jlI3
         J+hX2xQTtAwGFpaeDLANyDp5/lzduLrThfwLh3cn90yBi1u79fpmXRh7kkP/77deVaRW
         1+ZnTPL3F1xWQikoMvmy8pNtuUyj1VPQWksC7wtrZWov0dlFAtdsggCBvz60/rPk735O
         xN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684369667; x=1686961667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6TuSq6N4Ik07SdPtfy50jQBhSsVtsVbqdpHx3gygEM=;
        b=RUGnj+UhlUBGFSsmC9TrZgyogsoPna2nUpF8glqyCrLoPNFjn4PPgb22AGi9KtoFUL
         ps5t1/PidJ3e4jYeN936mL5IP7pg0PC4HhoPXIE37dPHxhXhkbmwgf35kwGu1KGf0t96
         il+BZtGuQzxipXiRbKTnZ7iFCa/1XWp2Nka0TeuGKbv2UzkoDi1N9pudgMXOAf5yeF7s
         IAf9bgfZT4Ar4+HvPurnUkWufuPhXtJ8kNe8oB3UQOwy/oYO6hEBE7DN7V7OXjv697HH
         SGKnzf0NbMwXSrbTGkSSSYtSSgxYHbq2F7O+p8g7zlnVJZ8je5qx+PWQG8vSebpLYt3j
         Y1gA==
X-Gm-Message-State: AC+VfDzw+NPGUFJz1zQwpNnTb1rCadnv5KffjqLnosnxIG1UAkdHu9Bw
        X8qmVA08e3XwfOpX+hCtV9jiBFqHiKseMGE+IME=
X-Google-Smtp-Source: ACHHUZ6n9yAfim0C7Hg43I2JYLCV74uzeButE50fjo2hAJ73OC/j8dQUCmV5kt+RT35MZoJE96vjue3uCnihuGFmCBY=
X-Received: by 2002:a17:90a:c981:b0:24b:8480:39d6 with SMTP id
 w1-20020a17090ac98100b0024b848039d6mr710810pjt.0.1684369667491; Wed, 17 May
 2023 17:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
 <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
 <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com> <CAOMZO5CJwwKmDYRxnny2JOrwucGn=q7+9xKqk_NSvZ_wyNSHEQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CJwwKmDYRxnny2JOrwucGn=q7+9xKqk_NSvZ_wyNSHEQ@mail.gmail.com>
From:   =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Date:   Thu, 18 May 2023 02:27:36 +0200
Message-ID: <CAEktqcue7gFk9fXMsNPxwUsUVRxpa6GE5wCHZqU2p2dDz8WYqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     Fabio Estevam <festevam@gmail.com>
Cc:     bstruempfel@ultratronik.de, andy.shevchenko@gmail.com,
        amit.kumar-mahapatra@amd.com, broonie@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

Am Do., 18. Mai 2023 um 01:53 Uhr schrieb Fabio Estevam <festevam@gmail.com=
>:
>
> On Wed, May 17, 2023 at 8:20=E2=80=AFPM B=C3=B6rge Str=C3=BCmpfel
> <boerge.struempfel@gmail.com> wrote:
>
> > My bad. Thanks for letting me know. Just to clarify: I put the
> > changelog directly below
> > the first ---? And do I then put another --- between the changelog and
> > the following
> > include/uapi/linux/spi/spi.h | 3 ++- line?  or is there just a
> > new-line seperating them.
>
> It should look like this:
>
> Commit log line 1
> Commit log line 2
> ...
> Commit log line n
>
> Signed-off-by: Your name <your@email.com>
> ---
> Changes since v3:
> - Bla bla bla
>

Thank you for taking the time to explain this!

> > And if you don't mind my trivial questions, am I supposed to write a
> > cover letter for
> > the patch-stack? I seem to find contradictory answers to this question =
online.
>
> Yes, for a patch series having a cover letter is helpful.
>

I will add one for the next version.

> > > Should tools/spi/spidev_test.c be changed to include this new
> > > mosi-idle-low option?
> >
> > Until now I actually wasn't aware of this tool. However on first
> > glance, it seems
> > reasonable to add this mode bit. I can certainly add this mode bit to
> > the spidev_test
> > if desired.
>
> Yes, that would be great.
>

Okay. I have begun to implement this. During this, I noticed, that if
I called the new option
"--mosi-idle-low", the alignment of the help-lines (and in the c code
itself) would break.
Should I therefore shorten the option name by using an abbreviation
like "--mil", which is
probably not very helpful as a "full option name", or should I touch
all the other lines and
insert necessary spaces, such that they are aligned once more? (And if
so, should I do
this in a seperate patch, preparing the addition of the new options?)

> > While looking through the code, I noticed, that the latest two
> > additions to the spi->mode
> > (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) are also missing from this tool. I=
s this
> > by design, or should they then be included as well?
>
> Looks like these two are missing and would be good to get them included a=
s well.

Okay. Should this be a separate patch, or should I add the support for
all 3 mode bits in
one commit?
