Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62336EA6D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjDUJWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjDUJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:22:12 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05F10FD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:22:10 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b95c3b869dcso3380203276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682068930; x=1684660930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7SaFiJTAEsvak5AsIp0JTeAjCVOG30D1pD5hNgwQD4=;
        b=nDtIypaowVqF9A9vOIgbBdEoqT6aTyNE8FgTg8cFokzwS4p+5DGwIvYaNanTN3Xg8B
         /rz0Ss3iU5qq1NTn+0ZwE+GlzKrgaLri7HI4Y9qtHn3etZOqclmFRFyXPcSXMHbk5zJf
         N/k+gBlQjheT6MDrDc5LLVyxz/VtavTZM+FTsTRiT7sKntoJ8pDmdHZVREcWcXONJcHb
         1OCiSBErtV5deE2vCObq9dFfbTZDjt6QkRISig3g89DGHBsfIlxKFTbLd9i9CQenAjYl
         /scaD1XVhh/6NVU+6y1KkDE4ehEXUJsiK/rf/7okQ5y+5zqN7MZlPy85Pdns3aSHMUg8
         IgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682068930; x=1684660930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7SaFiJTAEsvak5AsIp0JTeAjCVOG30D1pD5hNgwQD4=;
        b=ikcsZId17g7m28w9+Al+dVtkq7PdgHxjB944VVXw+2OnjZoqtbxIjrwkk+mkniCihl
         6oaumVmv0NE0m3ZF9Qd7/j3u0uHRfz65gE2UKl2I4bbGY3nsh5R07AhwQ2Iwr1zEhl1p
         6rMssVdpl73FBUJ1Owp0LbM3ZMxBx/D/+lpGkFr24DC3Jh0kASlNXhY4F5r0bq88zlvT
         Fof4ygvjGsSLYDemNuwNX9u7XghFR9nGZt8YqcfeUS37/URwqvK6W608pveie01is48K
         NJ+fjyESeRxmZmGHyqZR/W5BG4uQVpI/yBlM6Hq/4+T1sbReLvNx6wHyBa7RbBW6+iTn
         2DbQ==
X-Gm-Message-State: AAQBX9eKacG9PDSQfkNBKBAaOe3OlxqVi397Dna3uKsyoEDwMHxM1Kdd
        KKDoekZmaqzxJ1iQEZNruxp+uUzjcfABb0v8HosBnw==
X-Google-Smtp-Source: AKy350blWasi4kmW5NIL8axIqRZWw/o+JSkhTpxAKF5TM3zl1QT9z1SBQ7HjnUqyMJbsO+wVRvnGE1TSdtWEUr+rfl0=
X-Received: by 2002:a81:6c53:0:b0:54f:4fd:7e5e with SMTP id
 h80-20020a816c53000000b0054f04fd7e5emr1761938ywc.5.1682068929594; Fri, 21 Apr
 2023 02:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230420055131.2048959-1-joychakr@google.com> <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation>
In-Reply-To: <20230421085354.34dwrgr3enlxqhtc@mobilestation>
From:   Joy Chakraborty <joychakr@google.com>
Date:   Fri, 21 Apr 2023 14:51:58 +0530
Message-ID: <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 2:23=E2=80=AFPM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> On Thu, Apr 20, 2023 at 05:51:31AM +0000, Joy Chakraborty wrote:
> > n_bytes variable in the driver represents the number of bytes per word
> > that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
> > bits from the client but in memory they are a power of 2, same is menti=
oned
> > in spi.h header:
> > "
> >  * @bits_per_word: Data transfers involve one or more words; word sizes
> >  *    like eight or 12 bits are common.  In-memory wordsizes are
> >  *    powers of two bytes (e.g. 20 bit samples use 32 bits).
> >  *    This may be changed by the device's driver, or left at the
> >  *    default (0) indicating protocol words are eight bit bytes.
> >  *    The spi_transfer.bits_per_word can override this for each transfe=
r.
> > "
> >
> > Hence, round of n_bytes to a power of 2 to avoid values like 3 which
> > would generate unalligned/odd accesses to memory/fifo.
> >
> > Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > ---
> >  drivers/spi/spi-dw-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index c3bfb6c84cab..a6486db46c61 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -426,7 +426,7 @@ static int dw_spi_transfer_one(struct spi_controlle=
r *master,
> >       int ret;
> >
> >       dws->dma_mapped =3D 0;
>
> > -     dws->n_bytes =3D DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_B=
YTE);
> > +     dws->n_bytes =3D roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_p=
er_word, BITS_PER_BYTE));
>
> Almost 100 symbols looks too bulky. Moreover single-lined nested call
> makes things a bit harder to read. What about formatting it up like
> this?
>
>         dws->n_bytes =3D
>                 roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
>                                                 BITS_PER_BYTE));
>
>         or like this:
>
>         dws->n_bytes =3D roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_p=
er_word,
>                                                        BITS_PER_BYTE));
>
> Splitting the line into chunks will simplify the visual
> differentiation between the outer and inner calls.
>
> * Note even though the 80-char columns limit isn't that strict rule
> now, but it's still preferable unless exceeding the limit significantly
> increases readability. The update you suggest doesn't seem like the case
> which would improve the readability.
>

Sure, I can make the following change in the formatting and send the
patch series:
         dws->n_bytes =3D
                 roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
                                                 BITS_PER_BYTE));

Thanks
Joy
> -Serge(y)
>
> >       dws->tx =3D (void *)transfer->tx_buf;
> >       dws->tx_len =3D transfer->len / dws->n_bytes;
> >       dws->rx =3D transfer->rx_buf;
> > --
> > 2.40.0.634.g4ca3ef3211-goog
> >
