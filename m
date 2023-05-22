Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0944A70B7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjEVIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEVIpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:45:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E83B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:45:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3095b1b6e02so1599591f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684745104; x=1687337104;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx/yHMnjVgWF4QcF/HJeTU6OliuvijvBL2Kqd+0E4e8=;
        b=1UDYjGh+BPZr2LEsSh3RQXEFzaHhqBaP1+FsoGcNjDbS4uZXZi9F2KyQryNpg7pETT
         6k02A5SKqgyKKCDVoJL55gYIoY4N22aUXcW47uzYv+9g3+2fdBRKT1/pJW+WqVKPqaTd
         mqqHO+4A4ijOEzV3M/vu/DhYAbFIHVkbhYry2pIOKE09IIcMvWJDTgeYtLE2fL+7clN1
         vRWXZP0PcRI8fje/hRD7cz4CsOmkuCliCGWwfsDbzz14XJQZRcBg6qo8q7UzcPmhxoWg
         6cK2JAdANkgRMLu4lmMRJ65lWS9lGM0z3FqGwtNub4koooLVr37assjeS8FCZiBHgyaV
         7FOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684745104; x=1687337104;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xx/yHMnjVgWF4QcF/HJeTU6OliuvijvBL2Kqd+0E4e8=;
        b=fLdQDMZWSbhMLj6McpWb4vCMBqlOM2tJY25gM86rqTqYZG81TRWe1F6vH8+9R/rfW/
         UKNFkXvNoakI72c7jJHhGpbSf5vZGESu4N3/m4KxDIE48ZQOyvtZgK1rtINsegELBwv2
         V/fDtaUymXFf6CaJ0opBHxMb4wA2A4O25da6NE0V12TvRkTlSrRoY3sF1KN2Fn8Kv+w7
         FwIXNYviTVhjyv2lcaqKFyTQI2kocwsqF8peVRCrR7FqHZlzxHRpdgxwLMQm5yNNjHfy
         Xi69p37Bosubj+VBCOr4LP0+BtEnvG8RiTEvj/GjcvRV4u1tGKe8yWQ+88xYzW9D7Bk7
         RUxg==
X-Gm-Message-State: AC+VfDwTbPd0rdRhKPghFswzKBwqCzmxCCX5bRP2xn8e0q0N6HLd8oGm
        RVytX3smvLsyTQxtU0lueZkhpA==
X-Google-Smtp-Source: ACHHUZ7BDGQPkYzVpmgbmhFfKupu4EBCiwWLCV9C3ObjST1s1V08/DvUXG+k8JTERV+zaCiVUb/vrA==
X-Received: by 2002:a5d:568d:0:b0:306:4239:4cd with SMTP id f13-20020a5d568d000000b00306423904cdmr6026365wrv.31.1684745104189;
        Mon, 22 May 2023 01:45:04 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:bdef:c8a1:3699:6b83])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d4001000000b003062ad45243sm7016080wrp.14.2023.05.22.01.45.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 01:45:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 22 May 2023 10:45:02 +0200
Message-Id: <CSSOANIQ2JQR.9JFPM92KNQX9@burritosblues>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <sterzik@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-3-eblanc@baylibre.com>
 <ZF5yb4DbVDbfxVU4@surfacebook> <CSNQ2RRG7XDC.164H6P357UHSR@burritosblues>
 <CAHp75VdNgBv5yVTXzDpY3rrF31p=p99cfXdEs0q7m8VmLLJwbg@mail.gmail.com>
 <CSOGQIRNP61G.1Q2A4ZXB43YYQ@burritosblues>
 <CAHp75Vc-c=VU5Bfy5097z4wm43=bZ4LG83QBYV19YOrC7zSGag@mail.gmail.com>
 <CSOMS0W9MIUG.2MN43QZO9EX7Q@burritosblues>
 <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
In-Reply-To: <CAHp75VeNvfDqkQZq_ghiv8vb2NaogKqkiFi9i0N3yLgA=ZTDbA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 17, 2023 at 5:04 PM CEST, Andy Shevchenko wrote:
> On Wed, May 17, 2023 at 5:43=E2=80=AFPM Esteban Blanc <eblanc@baylibre.co=
m> wrote:
> > On Wed May 17, 2023 at 3:51 PM CEST, Andy Shevchenko wrote:
> > > On Wed, May 17, 2023 at 12:58=E2=80=AFPM Esteban Blanc <eblanc@baylib=
re.com> wrote:
> > > > On Tue May 16, 2023 at 6:48 PM CEST, Andy Shevchenko wrote:
> > > > > On Tue, May 16, 2023 at 4:05=E2=80=AFPM Esteban Blanc <eblanc@bay=
libre.com> wrote:
> > > > > > On Fri May 12, 2023 at 7:07 PM CEST,  wrote:
> > > > > > > Fri, May 12, 2023 at 04:17:54PM +0200, Esteban Blanc kirjoitt=
i:
>
> ...
>
> > > > > > > > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)          (0x31 +=
 (gpio_inst))
> > > > > > > > +#define TPS6594_REG_GPIO1_CONF                            =
 0x31
> > > > > > > > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)  (TPS6594_REG_GP=
IO1_CONF + (gpio_inst))
> > > > > > >
> > > > > > > Why? The original code with parameter 0 will issue the same.
> > > > > >
> > > > > > I felt that replacing 0x31 with a constant would make the compu=
tation
> > > > > > in TPS6594_REG_GPIOX_CONFIG more understandable. What do you th=
ink?
> > > > >
> > > > > The question is why that register is so special that you need to =
have
> > > > > it as a constant explicitly?
> > > >
> > > > It is not special, it's just the first one of the serie of config
> > > > registers. I felt like just having 0x31 without context was a bit w=
eird
> > >
> > > I'm not sure I understand what 'context' you are talking about.
> > I was trying to convey the fact that 0x31 was representing
> > TPS6594_REG_GPIO1_CONF address. This way when looking at
> > TPS6594_REG_GPIOX_CONF(...), one will better understand that this macro
> > is just about offsetting from the first GPIO_CONF register.
>
> You can add a comment on top of the macro, so anybody can read and see
> what this macro is doing.

Ok I will do that then. Thanks :)

> > > This is pretty normal to have two kind of definitions (depending on t=
he case):
> > > 1/
> > >
> > >   #define FOO_1 ...
> > >   #define FOO_2 ...
> > >
> > > and so on
> > >
> > > 2/
> > >
> > >   #define FOO(x)  (... (x) ...)
> > >
> > > Having a mix of them seems quite unusual.
> > I did not know that. I will revert this change for next version then.
>
> Don't get me wrong, it's possible to have, but since it's unusual it
> needs to be well justified. In the change you proposed you have
> changed that, but I haven't seen where the new definition is used  (in
> *.c files).

GPIO1_CONF is only used by the GPIOX_CONF macro in the header.

Best regards,

--=20
Esteban Blanc
BayLibre
