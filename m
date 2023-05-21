Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB74370AD0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEUJAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEUJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:00:28 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D7DC1;
        Sun, 21 May 2023 02:00:27 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75b015c0508so33827985a.1;
        Sun, 21 May 2023 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684659627; x=1687251627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WN4/lzvxl1Ebzgu3SVp8xV1TqWzNCIheq8hiw1uOKw=;
        b=Ucy+XCvczVyKnzGM6KGFKZq7AjGBHCCveVfJvDcnryfYlRb0mgejf6f6rV1CqUkW7L
         +G5OIqUmMZd2wFmY3NZcA+tZ+l7m5/aB+33S1I/nz/HBsxxs9LvqpuUL4SzMyXWH9fRA
         CCk8lC4+McaOjO/FV/x+e+p/jD6HSsB8+9nbT9gm9YvwdYFeaJC77IeZOg9cm2oALs03
         VOyFvUW2vjKTKDE8FeQyCMKuRbxpi2g+TPmI7TqJDT89BaTXDS3Z4xDlpnNA0Ru5X19r
         LysZhccNo/tPH3GLOocfHhhtq2vPcccDk1Ser1q5joejX+KdobZIJuS2JjXEe51Pq/ZN
         cs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684659627; x=1687251627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WN4/lzvxl1Ebzgu3SVp8xV1TqWzNCIheq8hiw1uOKw=;
        b=UmGS0RUUHLwbHi5FVIvro4ImszS6DRFvTnRgemJhFkC6KGnO6Ba4+ZClXKsTJAyqpv
         SJwUh4j/yOga1nsWaaFjlrPxXAUsem+BbaQeJYBv9kqKnFJB/+KY6vwO+G8gpSL4RqWx
         cfE2tDszXdzJ++EI7hal0+9TsAjb/9qtHGHez8XWpzQ6wDB/v+mDSJOJa0sVFXYTHAfu
         4oknKX6suhgs27OgAEGfDzIiO1QNVhHKwvoPWmmRBEzS1KlrWfe7kJl/fNdaYlYRRrSI
         iL/SGJwrUJRHiAv8Dp8ETO9l3Au3VU93NziCmHbQmKNP9sx+mfzUjzqkzP9MAegsaUml
         cDOQ==
X-Gm-Message-State: AC+VfDy8V9HRObjeYZoJSAIJI32oSv8ThbEam3jsk8r1Ix/W1ps12Rv2
        UvjIGMpJHVTPMAQXXYptRnVVNFt1X+wGXwY2onrloLxcWgI=
X-Google-Smtp-Source: ACHHUZ6m0tqP6zRAityAd/c4P/TPpO7vEkHiObYcwWtR1yQ4s7C3kLgQxF/vCMm4CSNJqnxIB+l7gQgwhCWsAQBNM+8=
X-Received: by 2002:ac8:5a4c:0:b0:3f3:8ddc:d760 with SMTP id
 o12-20020ac85a4c000000b003f38ddcd760mr10760699qta.12.1684659626980; Sun, 21
 May 2023 02:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230520190856.34720-1-boerge.struempfel@gmail.com> <20230520190856.34720-5-boerge.struempfel@gmail.com>
In-Reply-To: <20230520190856.34720-5-boerge.struempfel@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 May 2023 11:59:50 +0300
Message-ID: <CAHp75VeR724n7C8hXs_7+TfvXANPZ7man3Znns8O+mBc113fYw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] spi: spidev_test Add three missing spi mode bits
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, festevam@gmail.com,
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

On Sat, May 20, 2023 at 10:09=E2=80=AFPM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> Added the three missing spi mode bits SPI_3WIRE_HIZ, SPI_RX_CPHA_FLIP,
> and SPI_MOSI_IDLE_LOW. Due to the length of the new options, the
> indentation of the options in the help message was also adjusted for all
> other options.

Actually since you are touching all of them in the user-visible
output, you may also reshuffle them to be grouped logically. I'm not
sure if the switch-case ordering would be nice to have shuffled as
well. If so, in this case it might be better to have it as a
preparatory patch before you adding new options (and hence take care
of indentation in the first patch). That said, just think about it,
I'm not insisting.


--=20
With Best Regards,
Andy Shevchenko
