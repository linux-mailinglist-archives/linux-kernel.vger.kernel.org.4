Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F90270DB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjEWLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEWLEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:04:16 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B757CFF;
        Tue, 23 May 2023 04:04:15 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6238ce8d8f9so28838616d6.3;
        Tue, 23 May 2023 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684839855; x=1687431855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXMwnso8L8unmlIkrr+yf2Yivk4laMnvZ8fMrZ3hAJc=;
        b=KpYOs0z1OHQqghPCIWQVL12WwTIjRvxS/NDFTmbI/5UuXDj1s3BCGbCd6HWj9SYoXt
         e1T12N2/teDP4BBCWWnEMc2aQUbq7sY9eLaGLtfDbH6CUVv9GpkxCYWocTefAjLZZygs
         82RSdX0CmfYiKf1j/gjG7RXWJNnsRfv5bItzPLTV6Pf59DjZBjXxgPhOKCXXCxTNFbRQ
         0thLh7shQdb5qPq+c+r6DGbnbqW9izKTtxpSJH6gHc/uu9GtxdeBy/fkUOPRk6p9Hw5m
         K/fPNtFGNVPorL7V2d+xUtc94SLLsmGxSyisQUAp5y+gvOmNJuZ4wGvvbqXwf6WVaDiM
         LnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684839855; x=1687431855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXMwnso8L8unmlIkrr+yf2Yivk4laMnvZ8fMrZ3hAJc=;
        b=PGqsDx29CHjov6vJGH/AfO2P1ZNsEAOwYrJ8Opfvo2nlUzGLrcUFpRdUdvH2O50/Eh
         FdgQkyJeB+N13lkm6P1PDgAiK90AdLNuxHchDcGvTihMbWOszvtKASh9eKKj8jxQHISQ
         615ITx/dfQ2oQchHO+15JnJkqBW/1BELAr1zZ+DFjGHUFd1CcQm196jC6+kzAI4Gx31t
         zjith7T/tzCGaYjwGDVrFPmG1LAGiRzW0rY8VJgapUjc48VhojgU/XKoQLgB1J3Al7Tn
         F7LfgsEd4uPyIx2VndEDQKLmefzOPPw+6m/s7d4Pj+C7qeLIr/xhHCX7tmv6pwrTP7k+
         NFTg==
X-Gm-Message-State: AC+VfDw+R7TO037mLrVc714fliUxMj/OspKYxSpWl4VMafGDzaUo5HDv
        xJWUusrogtObYFjwRkDYgZHRdnizFNglDbkTgwo=
X-Google-Smtp-Source: ACHHUZ4RRckTxpimu0N0xhrk/QzQW4gN3w9Z3IlDdR4RIh4arrLrdckcA4S14k3B4ey/5JydJcCdt4XGTDREx+hWfy0=
X-Received: by 2002:a05:6214:130b:b0:5a3:79cd:8ef7 with SMTP id
 pn11-20020a056214130b00b005a379cd8ef7mr26118904qvb.23.1684839854772; Tue, 23
 May 2023 04:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230512141755.1712358-1-eblanc@baylibre.com> <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
 <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com>
 <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues> <CAHp75Vc-c=VU5Bfy5097z4wm43=bZ4LG83QBYV19YOrC7zSGag@mail.gmail.com>
 <CSOMS0W9MIUG.2MN43QZO9EX7Q@burritosblues> <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
 <CSTJSWD0ZQGE.2XVJAULQKQTRM@burritosblues>
In-Reply-To: <CSTJSWD0ZQGE.2XVJAULQKQTRM@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 May 2023 14:03:38 +0300
Message-ID: <CAHp75Vch5h8SRdLvFc=T_1C0ncj6Ti2KtN76RfZQSL0v22GXLA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
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

On Tue, May 23, 2023 at 12:26=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com=
> wrote:
> On Wed May 17, 2023 at 5:04 PM CEST, Andy Shevchenko wrote:
> > On Wed, May 17, 2023 at 5:43=E2=80=AFPM Esteban Blanc <eblanc@baylibre.=
com> wrote:

...

> > Don't get me wrong, it's possible to have, but since it's unusual it
> > needs to be well justified. In the change you proposed you have
> > changed that, but I haven't seen where the new definition is used  (in
> > *.c files).
>
> Actualy it used in 2 places:
> - In the switch case of `tps6594_gpio_regmap_xlate`
> - In `tps6594_pinctrl_probe` when setting `reg_dir_out_base`
>
> I already sent a v5 with this change but I managed to fail my .config
> and this driver was not compiled... and it is not compiling... I feel so
> stupid.

People are prone to making mistakes. :-)

> I need to send a v6 now anyway. Should I convert all
> TPS6594_REG_GPIO1_CONF to TPS6594_REG_GPIOX_CONF(0)?

Again, if you want to leave that definition you need to well justify
why it's so special that code needs it. Easiest way is to use the
macro with 0 as an argument.

--=20
With Best Regards,
Andy Shevchenko
