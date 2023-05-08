Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DED6FB9AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjEHV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjEHV2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:28:37 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972DE4C3E
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:28:24 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-55a8e9e2c53so47865907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683581304; x=1686173304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wX39yT2wbPEXqhXbtvNDzhgN+Xs4H/C0OIhg+3hztTI=;
        b=m/CYRgdq2dBkpFW4z/bT+o2LoBRNAVnnUYugDPgWvmTxdepuXvA4jJOimRupVQcFL2
         G8gZlt2+PPHd5gJJjR2xAZ1SYTEELx+AM5ZM2UzpEIUnP/nwGu/qSnqQ6Qe82+gd55py
         OywnDgCGIqUZE6yc3BDUpDPvFSo/ZNIFDFN65pc2dI1kVo0NVuMZp42uEwA60ncQUbN/
         Jy/w3whm5r+6gbxqk4h52P/jiNFwngAT5MpT1rqU/WQ8ErLHogo06zxPZr3PBoDp+BRP
         AqZZxJhHoAFvqvWV3X+FqqPYj+98CpsyNOOasrjll8yOi5IAC9vdzMgvchUT0Y8NqDlF
         R6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581304; x=1686173304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wX39yT2wbPEXqhXbtvNDzhgN+Xs4H/C0OIhg+3hztTI=;
        b=bZUS2Ak81GL4ssjMr0MDKdOeMaBtqvbVTDanhxwAop8w9+etl7EiKgRFWoRWApevmD
         id1FJqCeQlFYInw9ihXUGrhZ3bEx87fgKqcyqQyv5LLy3YkTsCKu4Zthlq0k98qRb7xB
         IuXngPkDG4i8xZO0daQyOMW7CjCe7GdSHdJa8T1fj6jcHocPXpc6Oz/AeFzZoPpO0vcp
         lmI3ZKJCTajqQAFdUdLRZm7jaPHHd3QeliPolqB+EV9z9YTXr8cIrwCmToME5R6g/3Q7
         CeJu/75b9RHp+v2EKsRwHeCFAKsSddNd8Cc0p6GMVXADZYEW+Z63zazZbCX+jkRijjxF
         CNUQ==
X-Gm-Message-State: AC+VfDx5xOR+Uew7dSZ/kfCNE7s7p/OhomVeyF1ZVlH6wcvTpbxZ+IHX
        KzJPDtA/dEFg9vySywbbQ39PDBPDrrjhqEhz4SyPIg==
X-Google-Smtp-Source: ACHHUZ66w4x3Oj+W//CdKVXHR1RfBdoq9r0l7en1E+lsaBczgPEck7bAPv7q2ndrw1oeCZN0a1tiKTRdU1k/NFqyLGU=
X-Received: by 2002:a81:84d0:0:b0:55a:1f2:ef6 with SMTP id u199-20020a8184d0000000b0055a01f20ef6mr12314719ywf.9.1683581303797;
 Mon, 08 May 2023 14:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-3-a6d0a89ffa8b@linaro.org> <ZFkSiM9GRfN5n7n4@surfacebook>
In-Reply-To: <ZFkSiM9GRfN5n7n4@surfacebook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 23:28:12 +0200
Message-ID: <CACRpkdbk0b8e7M4DNjAnF3c466suLHeiRp9L3zDnbCUB=J8=FA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: omap1: Fix up the Nokia 770 board device IRQs
To:     andy.shevchenko@gmail.com
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 5:17=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:

> > +             GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
> > +                         GPIO_ACTIVE_HIGH),
>
> Missing terminator.

Darn I missed this comment in v4, I have fixed it in my tree, I will see if
there are more comments for v4 before I resend.

Yours,
Linus Walleij
