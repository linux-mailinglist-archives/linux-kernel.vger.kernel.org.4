Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD271502D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 22:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjE2UEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 16:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2UEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 16:04:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE8CF;
        Mon, 29 May 2023 13:04:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96fe2a1db26so663764566b.0;
        Mon, 29 May 2023 13:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685390669; x=1687982669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoZf/xczibXYDWG/6Mc7Wi2iq3Itvt6yL1vaRCC+K6M=;
        b=axcRkrFkcmKzt054fs7v1UwB2jVBAxH4IyCUC/7o6SFdnJxyzj/vr0+Kv/JJ3jUhWU
         0w7Bol+SfZeFjGzVCN5RLNROdzpPH9bxkLEC3lSWwPDHWhGTsDDEdkFh/PbXbzhS3NWq
         bc+Mo50fliHAsdS1POTT1C0o/ecVuZ9Du47v1vaG1WJbXvKZuhK1x7//E+wTKkW1vqLw
         tPIjejJ4UwL6h9hhj0c2orH3jl4cLuYJSI0qnNEYfF2WuQXBQLrvdg2htLb7KB6It+8o
         Sm98KoIp6AGtOIi2rbn3M29x214f4iu/zgX+fgdeCG0ybSLEvBvcBdywGuxHn/kuvrIO
         whjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685390669; x=1687982669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoZf/xczibXYDWG/6Mc7Wi2iq3Itvt6yL1vaRCC+K6M=;
        b=IxDK2aTKFfJFIO9ads5GySXQGlSug8JOn6+pIOMNQMtgZLDAFBTNk4s1tisGLY4F4T
         ngF4eUCHiYVvZiRTv13JHnIN76WFsNZe5sQfvgLzLOK+80jLjHUk2d14J0EisNY3/3WI
         Avf0uUJvnsQGcuQQJ6933F0dJVuOjGPs5E59eNzdqVYJwHTFW6ulXKCNQj3kruw8gYtg
         pwgquZOOQU89yLtUm4IhIwRT7kNbStZHWEXKUcJ0NAm1cl3KNISFhQZz1Fnz6q6dAONc
         Pj1/D5JSathgGTETC6mX1kqtupxkZtFdtv6xCUoo06vG8eRjs4A7ECtxhGWpeRU/W2KJ
         IBJw==
X-Gm-Message-State: AC+VfDyFNKr5uUSxvXP/T+CbXC9zEhRKrTj+v9c5TQpSuWFPsxDkNkR6
        GRNcCiL+9uEumFsAJiEiPapF47GfKP83VT48/LE=
X-Google-Smtp-Source: ACHHUZ6fBnoUW8s7bD4kr2wc2YaDUbTsjPJ7jdxI4pWyyE579kh7lZB5GhSLucvdDMRNz6QURt0vaLwWmjwmMpa1mlI=
X-Received: by 2002:a17:907:2daa:b0:96a:6723:da48 with SMTP id
 gt42-20020a1709072daa00b0096a6723da48mr209616ejc.75.1685390669261; Mon, 29
 May 2023 13:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230527214854.126517-1-gnstark@sberdevices.ru>
 <20230528161117.197f7e61@jic23-huawei> <4d5a7691-68ac-6626-5502-383fad3a9436@sberdevices.ru>
In-Reply-To: <4d5a7691-68ac-6626-5502-383fad3a9436@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 29 May 2023 22:04:18 +0200
Message-ID: <CAFBinCA=earf119bN7ohmTQGDzSMeV9qcL8RU9DUYe0195H5=Q@mail.gmail.com>
Subject: Re: [PATCH v2] meson saradc: add iio device attrib to switch channel
 7 mux
To:     George Stark <GNStark@sberdevices.ru>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>, kernel <kernel@sberdevices.ru>
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

Hi George,

On Sun, May 28, 2023 at 11:52=E2=80=AFPM George Stark <GNStark@sberdevices.=
ru> wrote:
[...]
> > Based on the limited description we have here, I'm not understanding wh=
y
> > you don't just express this as a set of channels. One channel per mux
> > setting, with the in_voltageX_label providing the information on what t=
he
> > channel is connected to.
> >
> > This is an interesting facility, so good to enable for high precision c=
alibration
> > but we still want to map it to standards signals.  Userspace doesn't
> > care that these are all being measured via the same input 7 - which
> > is itself probably an input to a MUX.
> >
> > Jonathan
>
> Hello Jonathan
>
> Thanks for the review.
>
> Your idea of exposing the mux setting as iio channels is very
> interesting and at least worth trying.
> The sysfs approach was chosen because of the code changes are simple and
> neat (compare to channels approach).
> Also calibration by using those mux inputs are already supported in the
> driver (performed at probe stage) so I expect very special usecases for
> those mux settings like debug or device production stage tests. In those
> usescases hardware specific knowledge is required anyway.
Another downside to the debugfs approach is user support:
If someone reports odd values on ADC channel 7 then we need to make
sure to double check if the mux has been altered from userspace (the
calibration during initialization ensures to leave channel 7 in a
consistent state, while a user may change the mux, forget about it and
then complain that values are wrong).


Best regards,
Martin
