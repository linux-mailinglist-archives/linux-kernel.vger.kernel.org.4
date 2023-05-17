Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA6B706A37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjEQNwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEQNwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:52:01 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9198DFC;
        Wed, 17 May 2023 06:52:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-759219bed84so45514685a.0;
        Wed, 17 May 2023 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684331519; x=1686923519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezYf5IVfbVTCbEX5g86Cn6xuAKYKN/qRPzWXKbKvo2o=;
        b=WeUhl4LBKzduD22xO2R0081ed064xsO9ugJ8ZrnRB7xlpbbnJF4fTuEpo58H/kZac1
         3lk5IiJiFcBAi43kYl06BIeiguHnagX+Y7MPeEyeYbzpoN3YcRuQp3zKJz6m1J6XhJhg
         G+MhM6yPo1GEBxEC96l3Zrk9a1a4f+5JfF6sLpoCd5sDqHYaeyYQMtMXLQLH+RHzj4p5
         c8NfABSIr/AJKe7DY4p2PTpxs41QpaKTh4QGh20YX3qlJADTGuBPKd42Lp6xq482keTC
         Y5ZyXirgHHkXBzqJimcLCleTdbD04M6uES76dabaGVmhagKC+1i1vYmaVCdiD1JA3hgK
         IcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684331519; x=1686923519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezYf5IVfbVTCbEX5g86Cn6xuAKYKN/qRPzWXKbKvo2o=;
        b=Bz6tC6e6jrC7X/htvw/vMZEwgpvschynHNkE9RH2nh9H2XNiSEKhdRNioCs+ZtY9YM
         zjqBEIBX42hxTsTVtWNjmjq+bTkn5Tda2q2qef6aErz3OIdRS/1Yx77cNlsyw7BYtqH2
         /rcHSr8UMbWrb5PAxaeZnz0BRmrL37Whvw0OSV/ttH7ju51OZxtL7pMaCjJLG1olFFAX
         OYI47lpXY7HJiGPiDwP3kQ37SX83pXTPCd+7jxpmJxmseNrEKK/eW+pgHRMoeqZJkFs6
         lxZQ05r92V50gp2aJFrMIXyqNaKMZZx+vKbzoD1/eTNxGJ0O/ryC8IvUNl8culDE2Bw1
         diyA==
X-Gm-Message-State: AC+VfDxg0AuabVlnB1jcrXRotoQ/L770l41IrquHcy7yfhN7Dnzk0fOk
        OU0+cQPPk003MJYc1Co7LQmhXD5B6/i+bolMvIY=
X-Google-Smtp-Source: ACHHUZ5A1vF0iMFZI92bdSvrqfDdCd/qvml5Miyj0FM1UfLesAbUIoG8oLNvNUuXscoT1oHyfpiqtdRGD0KtBcdCPwc=
X-Received: by 2002:a05:6214:628:b0:621:42c8:9bdd with SMTP id
 a8-20020a056214062800b0062142c89bddmr46799995qvx.29.1684331519668; Wed, 17
 May 2023 06:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230512141755.1712358-1-eblanc@baylibre.com> <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
 <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com> <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues>
In-Reply-To: <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 17 May 2023 16:51:23 +0300
Message-ID: <CAHp75Vc-c=VU5Bfy5097z4wm43=bZ4LG83QBYV19YOrC7zSGag@mail.gmail.com>
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

On Wed, May 17, 2023 at 12:58=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com=
> wrote:
> On Tue May 16, 2023 at 6:48 PM CEST, Andy Shevchenko wrote:
> > On Tue, May 16, 2023 at 4:05=E2=80=AFPM Esteban Blanc <eblanc@baylibre.=
com> wrote:
> > > On Fri May 12, 2023 at 7:07 PM CEST,  wrote:
> > > > Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitti:

...

> > > > > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)          (0x31 + (gpio=
_inst))
> > > > > +#define TPS6594_REG_GPIO1_CONF                             0x31
> > > > > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)  (TPS6594_REG_GPIO1_CO=
NF + (gpio_inst))
> > > >
> > > > Why? The original code with parameter 0 will issue the same.
> > >
> > > I felt that replacing 0x31 with a constant would make the computation
> > > in TPS6594_REG_GPIOX_CONFIG more understandable. What do you think?
> >
> > The question is why that register is so special that you need to have
> > it as a constant explicitly?
>
> It is not special, it's just the first one of the serie of config
> registers. I felt like just having 0x31 without context was a bit weird

I'm not sure I understand what 'context' you are talking about.
This is pretty normal to have two kind of definitions (depending on the cas=
e):
1/

  #define FOO_1 ...
  #define FOO_2 ...

and so on

2/

  #define FOO(x)  (... (x) ...)


Having a mix of them seems quite unusual.

--=20
With Best Regards,
Andy Shevchenko
