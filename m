Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42825706B44
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEQOgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjEQOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:36:07 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D35B76B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:36:01 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-783f7e82f2aso251491241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684334160; x=1686926160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz5kmzNsavtOXsUzx7dQc9M1tds+op6IxOA3B91Azz0=;
        b=kEBnaf/eeVqzJkmoxSwK6peHNyQN+nMavdMcPVNxoA/YtqRfVXI/YUM+PZ/Lvc3wNS
         hVXtRBeuIU5EbJ1IMZzDkXNA5Oj4TgcaVDqrKTk4D5ExVb5yRgqQ/jSYVuORgpdNcL6L
         MriRQTXYJ8djpALImFTsuGEERsEO4WzcksyUR6fxdgxGap7urYQGvCNJxX7QRwxbsw+9
         CNxiIV+lxfAGTWT5IwcQzOQ/8Hhblhdo+QASH2ZeFU+nrCllHccOnGK1VQ2yeXaau2sS
         +BjDsLgVzY373Lyi1WQ836Uz40dDJMKhdT4MnLExI/q5+fS+Yabqba2a2LP/n9KgdFVz
         u7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334160; x=1686926160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz5kmzNsavtOXsUzx7dQc9M1tds+op6IxOA3B91Azz0=;
        b=gHLPFtKk9MR+2YYgj3WOrcA97l/awOns/TjIsAd+x5WWo7nzem5EBgAE+v+4DIzVtW
         0ITAb9HwndrJkKj6RagNgCJOjc5AtrRLDs7NwutARl6BuPB3LFJdJs57WhDMidMRaSGV
         wNTAX54ETFYYiLamqpQXlY/hiWEx+y6s0dfBkdVwbvXTFrfHFi8cVkXWpRPgB6oGVVgh
         NHQZSrdaxhOWoTV3SpYEivxG3jX2ZTo+4gwUbIifGG2hnO5DUqLIkxVEhQppjnswyS1C
         VmiR0/He75CctRETeIsMLtHf6jDUJuVmdSbXEykVARfW1JqaOj060snnum5K7h/nK7O4
         v5EQ==
X-Gm-Message-State: AC+VfDy11UTHXwt3IjbV0rmXH3KoaY4eXQHJaHut+koY4Jh0cRkb2a/W
        F4/mGU0UXhf9iswfpD0SqyddhNGVG0MQWBEijvNbsscL6bFECslF
X-Google-Smtp-Source: ACHHUZ7gScw3B7Blt8hgcjoSXltzPzfmqUmn74kB2d3RJD7T7Duv8dW/jaqi0ljwaYfG+jzVNghYLuUgSJkSi7F/H3g=
X-Received: by 2002:a05:6102:2ed:b0:434:6f77:4f62 with SMTP id
 j13-20020a05610202ed00b004346f774f62mr15827147vsj.1.1684334160192; Wed, 17
 May 2023 07:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681665189.git.william.gray@linaro.org> <dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org>
In-Reply-To: <dc4d0d5ca6ea28eda18815df114ecb21226cb345.1681665189.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 16:35:49 +0200
Message-ID: <CAMRc=Mc7JTvakp4fD4kfoFOAv_yd81MsDiEOGB1tUjPZ9e7zxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: 104-dio-48e: Add Counter/Timer support
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 7:37=E2=80=AFPM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> The 104-DIO-48E features an 8254 Counter/Timer chip providing three
> counter/timers which can be used for frequency measurement, frequency
> output, pulse width modulation, pulse width measurement, event count,
> etc. The counter/timers use the same addresses as PPI 0 (addresses 0x0
> to 0x3), so a raw_spinlock_t is used to synchronize operations between
> the two regmap mappings to prevent clobbering.
>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>

Looks good to me. Let me know when you have an immutable tag to pull.

Bart
