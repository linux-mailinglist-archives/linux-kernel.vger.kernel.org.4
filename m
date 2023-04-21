Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2516EA8F2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjDULRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDULRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:17:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AC2B442;
        Fri, 21 Apr 2023 04:17:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a8bae45579so13994201fa.0;
        Fri, 21 Apr 2023 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682075824; x=1684667824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7smVzolvmuXjKYHquqsWt5Blfp2EklwJ1O9Q+DVvQpo=;
        b=oWhloOpnZkyb7vjNIUp91/AvMUH6OR9USH0nHGo/cDolwn3hd0r4Yq9qCXxcn8Xoba
         kWwu3CaARkDXqxTMl8fYnMMKKmyuMsjTO25HA3ZvUuUdSswmTLsCxXwDyFNwQIDD4ws9
         MpnE/rujLD6qyqBcjPsOy5bse6u8yA95HxIxPae+KRGJmpQURbxwmua9xao/90oYj5Gz
         qnpOx2oxxb4ffBTvwnDowuX2vYpgS0MPvBI/YaWh8JPc0+WvId7oAxKvPo6ljvZWgeFU
         5P20E7BpWigwZauXDywvITNTxLl1OglHJcD3lTdfeYC9xCfw63YnYRuuZOLM9BuRyWTy
         zi5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682075824; x=1684667824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7smVzolvmuXjKYHquqsWt5Blfp2EklwJ1O9Q+DVvQpo=;
        b=K1Th/ZesTiLqauSsfEBSR++EOKsekS53qIYeO7kBkoiJnAQK2nZRe8UmcqGJQQKjWr
         q6Mzx/tET/3R2bi/9J15pDTqF0utqhZc8eqrYkPup7klz7baTKH+Xr6hegXmvKaFOvzd
         hkANMjk8vX/rHxNBo48mbwkr/8lbk8oKsRjnucXIJGkRiuF4r9TB7K7IJz0yYu4rupSI
         VlIU+U06W7sjK2I/wnBRcKAinKxvYLhGUkj88nZeLndrERBnMb/Uaz5Vq5ANqRNUNmZV
         Ivll1HNQSE7PBRGt2rk+1l6AKxv8eVATwGRBFsSJ9ibzXgB5oapfhBksIkQmVQEhAh/H
         FUig==
X-Gm-Message-State: AAQBX9feYZedPAgrbl0+ufFNKuwUic8+nZ9inxiQw0TxwGQMAle7Xkji
        o33AYlUsddt/Miibe6sUfdFXKAi6VUI=
X-Google-Smtp-Source: AKy350Zo1onIpBXq/ZJpowspPX9kOVBC3lUAc4i3kAlBZ4iVrdfBRJ8R01TXn75UK+LwT3wL7vZjXQ==
X-Received: by 2002:a2e:8802:0:b0:299:ac26:f781 with SMTP id x2-20020a2e8802000000b00299ac26f781mr634058ljh.18.1682075823533;
        Fri, 21 Apr 2023 04:17:03 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e730e000000b002a8d41c8ebdsm585220ljc.122.2023.04.21.04.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 04:17:03 -0700 (PDT)
Date:   Fri, 21 Apr 2023 14:17:01 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Joy Chakraborty <joychakr@google.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manugautam@google.com, rohitner@google.com
Subject: Re: [PATCH v8 5/5] spi: dw: Round of n_bytes to power of 2
Message-ID: <20230421111701.cutsclcc5uhputeh@mobilestation>
References: <20230420055131.2048959-1-joychakr@google.com>
 <20230420055131.2048959-6-joychakr@google.com>
 <20230421085354.34dwrgr3enlxqhtc@mobilestation>
 <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF1aK2EdgeUbNN4Bpp8hjPHTzBwt-q6+-Wb24VSsUOtSqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:51:58PM +0530, Joy Chakraborty wrote:
> On Fri, Apr 21, 2023 at 2:23 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Thu, Apr 20, 2023 at 05:51:31AM +0000, Joy Chakraborty wrote:
> > > n_bytes variable in the driver represents the number of bytes per word
> > > that needs to be sent/copied to fifo. Bits/word can be between 8 and 32
> > > bits from the client but in memory they are a power of 2, same is mentioned
> > > in spi.h header:
> > > "
> > >  * @bits_per_word: Data transfers involve one or more words; word sizes
> > >  *    like eight or 12 bits are common.  In-memory wordsizes are
> > >  *    powers of two bytes (e.g. 20 bit samples use 32 bits).
> > >  *    This may be changed by the device's driver, or left at the
> > >  *    default (0) indicating protocol words are eight bit bytes.
> > >  *    The spi_transfer.bits_per_word can override this for each transfer.
> > > "
> > >
> > > Hence, round of n_bytes to a power of 2 to avoid values like 3 which
> > > would generate unalligned/odd accesses to memory/fifo.
> > >
> > > Fixes: a51acc2400d4 ("spi: dw: Add support for 32-bits max xfer size")
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Signed-off-by: Joy Chakraborty <joychakr@google.com>
> > > ---
> > >  drivers/spi/spi-dw-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > > index c3bfb6c84cab..a6486db46c61 100644
> > > --- a/drivers/spi/spi-dw-core.c
> > > +++ b/drivers/spi/spi-dw-core.c
> > > @@ -426,7 +426,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
> > >       int ret;
> > >
> > >       dws->dma_mapped = 0;
> >
> > > -     dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
> > > +     dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE));
> >
> > Almost 100 symbols looks too bulky. Moreover single-lined nested call
> > makes things a bit harder to read. What about formatting it up like
> > this?
> >
> >         dws->n_bytes =
> >                 roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
> >                                                 BITS_PER_BYTE));
> >
> >         or like this:
> >
> >         dws->n_bytes = roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
> >                                                        BITS_PER_BYTE));
> >
> > Splitting the line into chunks will simplify the visual
> > differentiation between the outer and inner calls.
> >
> > * Note even though the 80-char columns limit isn't that strict rule
> > now, but it's still preferable unless exceeding the limit significantly
> > increases readability. The update you suggest doesn't seem like the case
> > which would improve the readability.
> >
> 
> Sure, I can make the following change in the formatting and send the
> patch series:
>          dws->n_bytes =
>                  roundup_pow_of_two(DIV_ROUND_UP(transfer->bits_per_word,
>                                                  BITS_PER_BYTE));

Ok. Thanks in advance.

-Serge(y)

> 
> Thanks
> Joy
> > -Serge(y)
> >
> > >       dws->tx = (void *)transfer->tx_buf;
> > >       dws->tx_len = transfer->len / dws->n_bytes;
> > >       dws->rx = transfer->rx_buf;
> > > --
> > > 2.40.0.634.g4ca3ef3211-goog
> > >
