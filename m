Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26E6FB97C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEHVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEHVX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:23:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4F7268A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:23:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9a6d9dcbebso4491625276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683581035; x=1686173035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jGQCX8Vl6J+teZGmxFzw1k6uuzeGq3x6M1Mg+KmvWU=;
        b=I88Y+UwW/ecdrdJYEYRQu84hQHEaAlwkBoqcY2OuiSC/fZd9XNJTetBoDsbTnL/mhS
         ZuE4HjGiHTZs634+rfTp1iWzyZKxHdtSgv1t0C8ngfs2JYKt0bUVW/j15pBp6NAhiKGR
         YKmwGJJP8/qagETAIGdZY8zpYZupX+SXkHtE5vyFWjBqJto4kUrgIwRuXcz+TO0lUGq8
         jMoSb6nX6bsJ4RBVQ5uYeqbPfz4tAm1FZBC0TrKwbGYr/DvRxfNR9D2rEu/sfehNSTkM
         zB4rT2OYkz5xjtBQkWRiDNoPPlQrctV8Ddiw1tEWVD53tZvZTnDKuAro4Tcxf0urL0Ic
         bzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683581035; x=1686173035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jGQCX8Vl6J+teZGmxFzw1k6uuzeGq3x6M1Mg+KmvWU=;
        b=H+ZnlOPyZnJHT8CsXKxo+geiamcxCcV710VxOknhXURwP+rcQcU6bKgwMUiovX8dip
         Q23u57xuvZFTu4bhT0c3oVjQdBUdSSd6GZM0FCVNIlpOoiBAVm9q47Al5O7RTmvQpa6M
         6J82OTypAPJUXdg2YKvY4uLeK5Wk5JOD6VIsXcqQyuqwEOdTos2ZTFThLGMsXT6wIAEN
         I7JGkYarGDmD/G3Yyd1VTF2qj8kiB3FVMUI5vmYz91OTpzDq5M5RmhgbGdNkQBxYozIx
         D/lce83Op3y2kqKtd5e7DzCM9Ylwbb2ZsTNoPFVE4ZFDHr7H29FlyYY5o1KubdMj3xQX
         ri5Q==
X-Gm-Message-State: AC+VfDxrx/BDUFlJldHcwNe3WYZpmAbpi5hKE4NQrYLULoz94CgcTdur
        Ck8ZAateOUb7+I31E7pPwotFVqRMCNf6R+/bd7Surw==
X-Google-Smtp-Source: ACHHUZ7rm8jz+s02nlAbnve92YjRuDz/1QELgf4UleY+8kKnTxtAJt2R2YQqJHyvz+tJndbn/SLgLqnkCbtBYasX8ws=
X-Received: by 2002:a25:215:0:b0:ba2:77e:e5f8 with SMTP id 21-20020a250215000000b00ba2077ee5f8mr12026435ybc.1.1683581035348;
 Mon, 08 May 2023 14:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org> <ZFVGMiuRT+e2eVXw@google.com>
In-Reply-To: <ZFVGMiuRT+e2eVXw@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 23:23:44 +0200
Message-ID: <CACRpkdZUXOTOK9CObdXuHQx4PMD3ykMKco8X5ijchkZ8cEmQvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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

On Fri, May 5, 2023 at 8:08=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> > -     return !gpio_get_value(ts->gpio_pendown);
> > +     return !gpiod_get_value(ts->gpio_pendown);
>
> This needs to be
>
>         return !gpiod_get_value_raw(ts->gpio_pendown);

There is no such function. The gpio descriptor runpath simply assumes that
device trees can be trusted.

> I looked at various DTSes we have and they use a mix of active high and
> active low annotations, so we have to go with the "raw" variant for now,
> and then update to normal one once we update bad DTSes.

I just sighed and fixed all the device trees :D

Yours,
Linus Walleij
