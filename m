Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953E45F56DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiJEO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJEO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:56:53 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D30644A;
        Wed,  5 Oct 2022 07:56:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a25so1070752qtw.10;
        Wed, 05 Oct 2022 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL0rszw+X7VH9Vs2enoudeRpBA9RJgrDEJBIgJDq1Ms=;
        b=BBHGKXQ/s4dOW1mA1++ZBqxzDyAiMLmeKzCtMSr/doDO7E11bceDzRdNLmsi9LE5Oq
         qwEPuiYF6Mr4AKw18d4eTre2AUrjbToWoT4Q/TG81YvRgKKrclhtkwyAyzRVEnz1HQn0
         VuRh6OQeauJiB2ZGy9nUMT2ZhLghHTNi+KtWvYkruNPoqnUrkdCZkd4hB4fu6z10ABJe
         d9Ra7Z6w08KOopAibqTsO7uRjcSb1nqb8CMJc9UjSrV+ODJJ820ElsmOB3PJK2DekGgy
         l3u1zxgDE26i+GgM5Qt2HMkXJw/BFKCPZQiEMFYnneREGCCGUO6an33YBPMU6NKxgfQX
         6kGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VL0rszw+X7VH9Vs2enoudeRpBA9RJgrDEJBIgJDq1Ms=;
        b=z94kpWxItuAEdCteYNRTdLYHZhgRr6v8eG113GjW1DfnhUVRAY5pA8LLntoiiLG0tw
         32nGEjxfwTnKfj1aGlgfvFqoZI+bxYss6r8SM4H8PwN4bm4rPc0nNjcOeEtJp0SBTJfQ
         cKKH+CgPZ6AvQB5ZXQMnrQw7xze0jBJ0XqUKmlcQyWbGDLVvbrb8p6CCLkFunoLzW4KG
         xyRFkyF5RtzFrEYttE1lgIcCZ8RaMoZ9GbTljmyRFSqv/LFuk41yJ35MxX2gXsHDB6jF
         WRqWrdxihzBBaF/MyKMCFedvvFZi+EZeyok6ppwUbTwkaxrc+v4XYOFoWmNRPMz2Y9mB
         WZZA==
X-Gm-Message-State: ACrzQf1tQUOTYcxJAbT0gy8Ej4+rMxqcBXvo3hzUeDbu4U26kEAiYcUq
        3mDLEAGwhXwtZwdRVI027QdtnVD++GFyCrx5zD4=
X-Google-Smtp-Source: AMsMyM4vVpwYW06RqZEG0YuRwm5ipuue7su59HIMb3pS7vj47CR5mMNY0KOZKzJlEodWLd10zi+UF1IaVTPJ3uisQlo=
X-Received: by 2002:ac8:5e07:0:b0:35c:e7fd:1e94 with SMTP id
 h7-20020ac85e07000000b0035ce7fd1e94mr24098816qtx.384.1664981811333; Wed, 05
 Oct 2022 07:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221005133120.50483-1-olivier.moysan@foss.st.com> <20221005133120.50483-4-olivier.moysan@foss.st.com>
In-Reply-To: <20221005133120.50483-4-olivier.moysan@foss.st.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Oct 2022 17:56:15 +0300
Message-ID: <CAHp75VffeeP+_nX86faEbnJFH51kGA2fUcJgqp1_U8EsbRrD9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] iio: adc: stm32-adc: add stm32mp13 support
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        nuno.sa@analog.com, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 4:36 PM Olivier Moysan
<olivier.moysan@foss.st.com> wrote:
>
> Add STM32 ADC support for STM32MP13x SOCs family.
>
> On STM32MP13x, each ADC peripheral has a single ADC block.
> These ADC peripherals, ADC1 and ADC2, are fully independent.
> This introduces changes in common registers handling.
>
> Some features such as boost mode, channel preselection and
> linear calibration are not supported by the STM32MP13x ADC.
> Add diversity management for these features.
>
> The STM32MP13x ADC introduces registers and bitfield variants
> on existing features such as calibration factors and internal
> channels. Add register diversity management.
>
> Add also support of new internal channels VDDCPU and VDDQ_DDR.

for new

I have a d=C3=A9j=C3=A0-vu that I have pointed out all these...

...

>         struct stm32_adc *adc =3D iio_priv(indio_dev);
>         int ret;
> -       u32 val;
> +       u32 val, msk =3D STM32H7_ADCALDIF;

It's better to split and reorder like

       struct stm32_adc *adc =3D iio_priv(indio_dev);
       u32 msk =3D STM32H7_ADCALDIF;
       u32 val;
       int ret;

...

>  static const struct of_device_id stm32_adc_of_match[] =3D {
>         { .compatible =3D "st,stm32f4-adc", .data =3D (void *)&stm32f4_ad=
c_cfg },
>         { .compatible =3D "st,stm32h7-adc", .data =3D (void *)&stm32h7_ad=
c_cfg },
>         { .compatible =3D "st,stm32mp1-adc", .data =3D (void *)&stm32mp1_=
adc_cfg },

> +       { .compatible =3D "st,stm32mp13-adc",
> +         .data =3D (void *)&stm32mp13_adc_cfg },

For the sake of consistent style I would put this on a single line.

>         {},
>  };


--=20
With Best Regards,
Andy Shevchenko
