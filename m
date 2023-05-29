Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED32B714F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjE2SSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjE2SSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:18:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B0CF;
        Mon, 29 May 2023 11:18:03 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-75ce1196bd7so68074685a.3;
        Mon, 29 May 2023 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685384283; x=1687976283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtgddjKUKdX/u1ElO6qJQhjwCsTb7fJh8vFO+8kczvM=;
        b=jdzcOMW6uVCBWZadyZJ14Sbyy/loYrdajjBFc3IlGOOGu1oTHO0CpJ446eycYbvabl
         T6mDGBkhty3QkwOTHrMC2wBczFpQ1DVGtfd+XQE5TMlVR8HLOPaSESLVRXVc7485ZH5e
         a3L5IEO3KPVBArQu1KAvMnNoI2jPQ9bOI2qKblIlMtS/lFJnokMI3ZczaWHhaU4PvDsn
         yCq3jn4HiIzuU2IRqBMfT357DRjmDzREbZ76gWVN06SHkm4lFyt3bVH08IOS1YCmM/Lx
         lPKETdFx/Glw5IcnbRzeMSaYljI/xt2fmdzkmFAjJOMUFOZW8lPpswIlMBn3hhUo3xNC
         iSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685384283; x=1687976283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtgddjKUKdX/u1ElO6qJQhjwCsTb7fJh8vFO+8kczvM=;
        b=MOOFUarltu71b+8QfgXG82UZ3k2l60FDkJ0fmV2dGO4EAaukrwddAfEEQ9LMPpQ0rY
         aIOYESAiiWNju/XAcoXn7YPe6NZU0kKhwKisdr0mj2Uuf+tf2+nINWokg6Cyt56xKTuX
         eFR/35gWFSV+OZj4QgWUL6wGy37/7+avOBZk+4esahIxZJMMJ1LHxmzbDetIurVI6Zoa
         gk0X66WWzExDkKA8e94hW0LlE5hZ0opZFCR8fI7vVWcriEP4/XXCfLgvtz59d24it3RM
         acoCx8hWqnvt6eJd0VztxDq1lNuzGLE7FYod2Be5W0jFQuV/Yklbe6IIm0jOwhMC+Sw2
         /wmw==
X-Gm-Message-State: AC+VfDzQWzIYdItYSHvi0v+Lzn+a/Vk4e++JaYYikbrpjRk+is6/fGZM
        2L2ZffAlb9DwCZCCTzUC8MBA+wdQTkvblRy0MlM=
X-Google-Smtp-Source: ACHHUZ45MhHLmjxdYf4ApIgrlmpGNe4YL0/wmcXOVOFWHYL6uVD7sXlEYUG1baU85uQPaGvAq2zjMxJF6rc5gpn4fFk=
X-Received: by 2002:a05:6214:624:b0:626:16a7:6e41 with SMTP id
 a4-20020a056214062400b0062616a76e41mr7713328qvx.63.1685384282983; Mon, 29 May
 2023 11:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230511-tps65219-add-gpio-support-v3-0-19837a34d820@baylibre.com>
 <20230511-tps65219-add-gpio-support-v3-1-19837a34d820@baylibre.com>
 <ZHD3VtFDYUyy_Std@surfacebook> <2c970ea3-e927-4ea1-f378-a600e834cc9d@baylibre.com>
In-Reply-To: <2c970ea3-e927-4ea1-f378-a600e834cc9d@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 May 2023 21:17:27 +0300
Message-ID: <CAHp75VfNeC=i96-_Pgez1RKTH1_NYX03iYObDk2+hCwtzdpKHg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: tps65219: add GPIO support for TPS65219 PMIC
To:     jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
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

On Mon, May 29, 2023 at 6:21=E2=80=AFPM jerome Neanne <jneanne@baylibre.com=
> wrote:
> On 26/05/2023 20:15, andy.shevchenko@gmail.com wrote:

...

> > Missing bits.h
> >
>
> Thanks for your review.Just to be sure on this particular point:
> Your recommendation here it to include explicitly bits.h.
>
> I can see BIT_MASK(n) defined in linux/bits.h
> BIT(n) is defined in vdso/bits.h
>  From what I can see, BIT(n) is broadly used across kernel but
> BIT_MASK(n) sounds to be the Linux strict way...
>
> In current version I'm using BIT(n) macro not BIT_MASK(n).
> Do you recommend to replace every BIT(n) currently used with BIT_MASK(n)?

The semantics (if you look into implementations of those two) are different=
.

BIT() is for a single word (your case), while BIT_MASK() is for an
array of words.

* word in case of Linux kernel means element of unsigned long type.

> Sorry for asking dumb questions. Just trying to make sure I
> correctly/fully understand your feedback... And do it all right for the
> next iteration.

No problem.

--=20
With Best Regards,
Andy Shevchenko
