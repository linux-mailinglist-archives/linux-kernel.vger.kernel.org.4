Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CFC724CD4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238339AbjFFTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239792AbjFFTPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:15:21 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99384E54
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:15:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565aa2cc428so60644857b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686078919; x=1688670919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5L89tB8wkQBFqziHGie36QGbrdPo8qwmA+HXjQV+vM=;
        b=Oubagn6lNYCvFolZHgBbvAxTse+fxYO7QOc8PsA9iZP9e2t8ETUtUWYpW1X4aol5Pp
         py6kevZaycKSmSBo4Z6ISBISiqD/7iIAwBWyBerIW3RreJJ9HEAvuTJFC1L1gIxClE8B
         Zo1Jho7S8zqD4w+aESDk8wwKPZczPNjCqaahODZegcGR0bAXcfGkhfpy0GiU9nZoxYH5
         3tSmdOg9aItl0cd9p5EIa1kuQY2vPS7IZIU1+jsUKFLETbT+lwkEGP2w54vB26myg4Sn
         aFZsKajhIoQKKCk8+V/q1rcIuw5atboBqOS6WM8DoES2EgCSQ+vS7fzVbSeDtG9bQjao
         +WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078919; x=1688670919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5L89tB8wkQBFqziHGie36QGbrdPo8qwmA+HXjQV+vM=;
        b=SUbYaNw/0vEllS4yqyfGtFzr7XmiSH1oqkwaM75X6jyvg/D4o+x0Wqc1VmMeAKuZTE
         G2Lu8oE6XaqszUxyAJomwMUyxtyRafE9+rh/4RjFViASsfpigJIZ/jKVE6eibCtmayFu
         MFZtJHKcMhFNGmKt4uaeyyUp0mAATCcebLsn6WUnMl/7N6cCl+6WkNRIdWHCH/IM7zNp
         ljdvqu6bMM8KBc6Y2g5VWAPa+HRfNsBaJpxFJJqE6DP2ZwP87H6glaOJ7Nhb46jprLpo
         HkXQZeQN/vxRTQmEP38NRhZiSaabwYnw7etpbmjZ72PR4ShpUu2KWKxQTqP23LHwN211
         VL3w==
X-Gm-Message-State: AC+VfDyALDMl0HDIpC6mT+aV2MrYS2AULDxgg8yDmHa5HHBPVlx9zamZ
        vS+Ig4za2SiNdvMLT5qx0z8ABkGnhKeUQ1Ydiwl2nw==
X-Google-Smtp-Source: ACHHUZ7lY+3AI76qpzpoSr0j2ZD5ERQQbLahw7zOYjKWi6Cuk/Te9kSx2WMaK6q/Ss77uvK92hSSK8RRBBpnLOmJ/uE=
X-Received: by 2002:a81:52d3:0:b0:561:e565:3678 with SMTP id
 g202-20020a8152d3000000b00561e5653678mr2718930ywb.11.1686078918837; Tue, 06
 Jun 2023 12:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-1-9b6dc5536b17@linaro.org> <ac6ef7f2-0d7a-ba43-4b63-0a23d899230f@wanadoo.fr>
In-Reply-To: <ac6ef7f2-0d7a-ba43-4b63-0a23d899230f@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 6 Jun 2023 21:15:07 +0200
Message-ID: <CACRpkdYObM_rv2xDhvfNs9Wn-iZoZjY7HpB1hWdc15XgtkA-HA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] Input: ads7846 - Convert to use software nodes
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 4, 2023 at 5:44=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> > +     /* Asserts RESET */
> > +     gpiod_set_value(md->reset, 1);
>
> Hi,
>
> should this also be done in the probe if mipid_detect() fails?

It's a nice bonus but surely not urgent or necessary.

> If yes, please also look at [1], that I've just sent, which introduces
> an error handling path in the probe.

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
