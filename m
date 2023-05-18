Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70713707EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjERK6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 06:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjERK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 06:58:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5F31BFC;
        Thu, 18 May 2023 03:58:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75774360e46so95994085a.2;
        Thu, 18 May 2023 03:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684407486; x=1686999486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a577LY7A2uHvmqRNQWIgZaEpX7tSIO73eW80DF91flM=;
        b=s5ijOOMbULc3W4XmEOzGUjw/J9dXzFP3HahO+s6kJUwixCffiUjibQN8/haQT6z6Uy
         ENVniZgvUL/CmWcXFVGIMainGW6YTw0T6bkD3CR9Laam9WFMbLSTr/5a3UEt3OIsT3aA
         3d8kKRzOc1Kz6snmw125sy8UNDw2d0QKMfcsKu1L4rFXQr6KchyvkHjbOEragdTqdu6u
         Wk1ccC7O1OUnHiCLucBdqo/4Fc2ekuJtVLyZE7xQ/uUqcsnYsnVYHYXG1LdmtjYgk4t/
         rkh0/7GdIerX0kdb4o80S0AoFHQpXJK7T0oh9ylQSe7m2zPtAyGS1wmPBFVlwnNyl4Ql
         KU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684407486; x=1686999486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a577LY7A2uHvmqRNQWIgZaEpX7tSIO73eW80DF91flM=;
        b=bSnrkol/vhA3YyWUs+6wgRXhFe4w9srKwqtR4tu4LUusElqsgdDCGecO4Uo0qLj1MV
         AQ5jvM8lDG5YNv0h+Coe7I7C3qbUw3p0alLGFUG9TwrLuxi/o9o0Opyc9ZkJXMkYUeg8
         suDBk6l4tbqOWo9lxCP8/uvI2E1x9BwRv4s72eqsgIXavDUbj9SfqpFdVtrQ7yYrzcu/
         ZeNppVXE/tOb0S6NxvLBhBlW3GlFEuS4ckzKy5vFPzbKP9Oua4ghFSLI9Wo34C8oRUd/
         MK5EqUWPetoA3beyE/C2xhpLh/JGEzstrbCbKcRQt2Ue1jUSe5Z31kbJt1N/QSm2S03x
         2mQg==
X-Gm-Message-State: AC+VfDysLUiyvwLZYykxu4lCsFoPAe1IPtQ+KqiqC8B0+7dWo+zi7XN9
        LAEtfO+WpW8Ou5KDeWKPDtn021NQw7IFd5+vku0=
X-Google-Smtp-Source: ACHHUZ5pDu9wRQ1ggalDohbvPtW4L8OMglakh23ju3FpnWe0ybBnb2shAQRSij03K9b9A/cTo2Vw7mKU48AD+Yt586A=
X-Received: by 2002:a05:6214:518b:b0:621:64c7:235f with SMTP id
 kl11-20020a056214518b00b0062164c7235fmr4272502qvb.27.1684407486519; Thu, 18
 May 2023 03:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230517223007.178432-1-boerge.struempfel@gmail.com>
 <CAOMZO5CqMMCCOsAB3YgJUUampE=iZru57d=qoX13-GkSaaC5gg@mail.gmail.com>
 <CAEktqcuMrqiwDfGM=SAoHiKPY-hupS+jipt=6Tasr1q8VUvRQQ@mail.gmail.com>
 <CAOMZO5CJwwKmDYRxnny2JOrwucGn=q7+9xKqk_NSvZ_wyNSHEQ@mail.gmail.com> <CAEktqcue7gFk9fXMsNPxwUsUVRxpa6GE5wCHZqU2p2dDz8WYqg@mail.gmail.com>
In-Reply-To: <CAEktqcue7gFk9fXMsNPxwUsUVRxpa6GE5wCHZqU2p2dDz8WYqg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 May 2023 13:57:30 +0300
Message-ID: <CAHp75VcP78MhmjzOCiGwfEwWwVxCHhy3qmZet0HqjPeLTc9h-A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] spi: add SPI_MOSI_IDLE_LOW mode bit
To:     =?UTF-8?B?QsO2cmdlIFN0csO8bXBmZWw=?= <boerge.struempfel@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>, bstruempfel@ultratronik.de,
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

On Thu, May 18, 2023 at 3:27=E2=80=AFAM B=C3=B6rge Str=C3=BCmpfel
<boerge.struempfel@gmail.com> wrote:
> Am Do., 18. Mai 2023 um 01:53 Uhr schrieb Fabio Estevam <festevam@gmail.c=
om>:

...


> Okay. I have begun to implement this. During this, I noticed, that if
> I called the new option
> "--mosi-idle-low", the alignment of the help-lines (and in the c code
> itself) would break.
> Should I therefore shorten the option name by using an abbreviation
> like "--mil", which is
> probably not very helpful as a "full option name", or should I touch
> all the other lines and
> insert necessary spaces, such that they are aligned once more? (And if
> so, should I do
> this in a seperate patch, preparing the addition of the new options?)

It's a user space tool where not so strict rules of commit splitting
apply (as far as I know), I would go with indention fixes in the same
patch that adds the option.

...

> > > While looking through the code, I noticed, that the latest two
> > > additions to the spi->mode
> > > (SPI_3WIRE_HIZ and SPI_RX_CPHA_FLIP) are also missing from this tool.=
 Is this
> > > by design, or should they then be included as well?
> >
> > Looks like these two are missing and would be good to get them included=
 as well.
>
> Okay. Should this be a separate patch, or should I add the support for
> all 3 mode bits in
> one commit?

Split them logically. Are they from the same group of bits? No? then split.

--=20
With Best Regards,
Andy Shevchenko
