Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FF372B0B3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 10:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjFKICW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 04:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFKICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 04:02:12 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD4F2D4B;
        Sun, 11 Jun 2023 01:02:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso5703757a12.3;
        Sun, 11 Jun 2023 01:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686470529; x=1689062529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKObufiJaJTeq7fGpjaIRGbwXaTH9GVmjYgQdGAz6pk=;
        b=QOMnm1A0pEkSVJI0SrtwyUDPwz/GuPP+G3hnOTHQpF3CuucjlNN/HqGM7Flr1GpDBX
         4okirRSt4FqCzNBTHdy2/0tDoIwQ8sLKg9M01pq6T2Wd4IEmdtqyGDRqPEImct/mSd8j
         2jRPLNfsdsCi/0NubYx18UwVtNsZKMHSi29Puw6Prf7CyiWaH7W5pEJtShO3L4LAZXyk
         dbgEhwlJaIRWKC+V5G/HPnCH8httnbg6sbV6rYmUWk1hxLlYJp2nker1CX+cYbe+sndZ
         K18KKX4tax+gNolkhAYjqv8f39hXLeRW/bYfY8eSaoQbWTHOH28tbXCwacUQ7BiYOBrF
         nHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686470529; x=1689062529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKObufiJaJTeq7fGpjaIRGbwXaTH9GVmjYgQdGAz6pk=;
        b=AQCv37jv93cBjQZLN1hZdeKxGI9SIxbc2d0r08P+zrlsKu4i8Ks70ut006IdqXOCGJ
         dxgElTxUGj9NsyObGk3tZ/3l8hQQo88dHX0SJB5lNx/+/IC37ZRIVPH0w6qCqS7/Z+ae
         3XhWAND8mXCQEuzF7WzP7UU6nz3g5gpU1aPWH8hhoS9Bumat+rCVFyMeRRPDUgXDBKA1
         HEFtNZAp4fbPKCOdrwIg3RaPhUiMh0KHuI+WM1esSN/PXu+pQQ/aBp2B13tt3GAqbWNc
         5+2ZJEU1o3pHMHIRqGpySK2kJk7J+YE77ZvOrewIs6UPBY9I6YY3Hpn62ZC8EUFlIBgk
         UW3Q==
X-Gm-Message-State: AC+VfDz13WJf/vYCbR1OqQ9BemADT73RxEu97YczI4Jf+EQRRoDWGMar
        1tOZq//fUJoTdQ7ms8zQF8PpY1Pf3aXoE9A7Iw8=
X-Google-Smtp-Source: ACHHUZ6NjQzgb76bcbhBYj8nK9a65jeRLHSFzppdF5FKxr8dY54Z+i7w+9LyA079iQisCTQ2sCwWWevYb7QwyN5bDhA=
X-Received: by 2002:a17:907:7244:b0:974:55a2:cb0b with SMTP id
 ds4-20020a170907724400b0097455a2cb0bmr6593282ejc.55.1686470528985; Sun, 11
 Jun 2023 01:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230610202005.1118049-1-bigunclemax@gmail.com>
 <20230610202005.1118049-3-bigunclemax@gmail.com> <20230610-thinner-sector-795141d97f40@spud>
In-Reply-To: <20230610-thinner-sector-795141d97f40@spud>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 11 Jun 2023 11:01:56 +0300
Message-ID: <CALHCpMhnVOt_H0VXNcbrt+53SkWsR6ZMNsmWyGw47JGUgePKzg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

=D0=B2=D1=81, 11 =D0=B8=D1=8E=D0=BD. 2023=E2=80=AF=D0=B3. =D0=B2 01:17, Con=
or Dooley <conor@kernel.org>:

...

> btw, do you intend coming along later and adding some of the other ones,
> or do you only have the d1 yourself?

At the moment I have only the T113s, which shares most of the periphery and=
,
accordingly, devicetree with the D1.
