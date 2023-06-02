Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE51720278
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235119AbjFBM7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjFBM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:59:21 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8577B180;
        Fri,  2 Jun 2023 05:59:20 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6260a2522d9so17539346d6.3;
        Fri, 02 Jun 2023 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685710759; x=1688302759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3QUfce8qvCYzZvATTACM5GanFIR9TxGWV5NW5fx1Uc=;
        b=doJ3dcsc9mWKT8YTAuerxjrr8h3c0tz3RzYoCZP252gI1cbb59iwC1PrSlqWfd+ZLd
         wu8X1MayospFP4NQJcezwwmUgbwpTuQVGxppnuJl4g9zaZrnl9FL/3bD62qnXWfvHAER
         ixdYF0QsoJ3YqMDc2KE0DdS0asKF9/SORqCEvBvXt+4lqaNyWBFNY4HoNt41XyLF+H4i
         CSQJV/I+2eNuFZF5v0EYw7Gbt4PoFNCG+voH2ApX1j9PL+JbjkBd6YgY8RRN+9ZjnUH8
         cflzCihvBmxoDXFgZuy+AzNp+9jdvO+NnvPTJKuIiimECms6jUxYo2c7BhOGTZD2OjRe
         YZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685710759; x=1688302759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3QUfce8qvCYzZvATTACM5GanFIR9TxGWV5NW5fx1Uc=;
        b=SgLEKQTI8T6eV0Pcnx+aCLx/vKv64Kuar04XI3la5wRJM0V6XrZrTtv20OVhHu2sON
         jwDbqMKXLqOi/Kog/mhze4V/wWMxWQc0++g5XUVShTyQ624unW6C0e02eDvAOHNG7RuE
         PP9LdSselQskeA2v42TSTNfaUDcQJfzJU4F93w8dunDi/dzeWCoACU2Bfq9dzZFfaT+O
         IgqrzmljDh/JUyOeljlZnjqR2lspqoMkzTLINMfhxsMFBtKd6hYpeM7K594BmSWrPscR
         9eT+HilX5XqdFChbzL+4ELjWBlk/qFidBXvTyNhLcuUDnbolNIPN20ev13TgBry7EPtc
         MTrw==
X-Gm-Message-State: AC+VfDylYtfpL6gZCQSZxE0EbVhhi3ZJFEOnPY3KWpRnEuiDOHEsoiTb
        0uqgK7TzCX6eKHaik/x0yo0YRpgvwa5TLiox9USUK3TAXEvX5g==
X-Google-Smtp-Source: ACHHUZ56t5eDsg4Bk5FefwJatBcex4lr70jUToJngwCOnFYsrPpb472scmS1PBD5ipf40wgvCRRYtHVogx+HNCtfYi8=
X-Received: by 2002:ad4:5ae4:0:b0:625:aa1a:9384 with SMTP id
 c4-20020ad45ae4000000b00625aa1a9384mr15516313qvh.64.1685710759620; Fri, 02
 Jun 2023 05:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230601201844.3739926-1-hugo@hugovil.com> <20230601201844.3739926-6-hugo@hugovil.com>
 <ZHkN5kEa6yqHdDeL@surfacebook> <20230601204140.3b45c9b97efb36431d058ba7@hugovil.com>
 <20230601212514.28914aee77ae9a513904ee6b@hugovil.com>
In-Reply-To: <20230601212514.28914aee77ae9a513904ee6b@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jun 2023 15:58:43 +0300
Message-ID: <CAHp75VcLNRQyeo4H-auDvk+CxZ0hz+2pysqP3bBgW-uZB_2vPw@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
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

On Fri, Jun 2, 2023 at 4:25=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> w=
rote:
> On Thu, 1 Jun 2023 20:41:40 -0400
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Fri, 2 Jun 2023 00:30:14 +0300
> > andy.shevchenko@gmail.com wrote:
> > > Thu, Jun 01, 2023 at 04:18:40PM -0400, Hugo Villeneuve kirjoitti:

...

> > > Maybe positive one?
> > >     if (mctrl_mask)
> > >             regmap_update_bits(...);
> >
> > I used negative to save on indentation, but it also fits by converting =
it to positive, so done.

I understand, but in this case it is slightly more weird to have
negative conditional and in either case return the value of the local
variable.

...

> Greg did not yet respond to my email about the proposed tags, but if the =
new order of the patches and the stable tags I added seems ok to you, I wil=
l resend V7. It will then probably easier for Greg to comment directly on V=
7 for the stable tags (Cc:).

They look fine to me, but Greg is the maintainer, he decides if it's
really okay or not.

--=20
With Best Regards,
Andy Shevchenko
