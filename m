Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A56A8405
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCBORo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:17:43 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CECA3402F;
        Thu,  2 Mar 2023 06:17:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h14so16681913wru.4;
        Thu, 02 Mar 2023 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BjohpdSIx4yaxuaDVY5TpnPa4luLE8HDX4jbWDHwIPc=;
        b=K5p8NGxOe6DelD8nhXPy5T3e7evSJ+gBT1HgUA/ObGto9qjv+/k/4gM0+PkTk9E5uy
         Ejwe2usdR6ovFl081nwdhE/kPKUv3TF7C8BpJ0KhgPN6XV13WAconCTfOs1TZoCqVPc+
         KAQz3hi5c5PDaDYt2H1fvJvCr/MqRfunIatU2d5rOfMZFkKJftPAWf5jlkSNDQw/br4H
         yjfncFyd53a8DG7JZZpkgdZFUYxmxnTzqFdMCNI/xs2kgDQT+OOiU6nQgjZ5PIY6B7Hp
         o0XZLVITFavn1XR98sQStlGhjIWg3xYMm14173jzEDBSfZX18sT784XEyD8itvPQQgpI
         OlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjohpdSIx4yaxuaDVY5TpnPa4luLE8HDX4jbWDHwIPc=;
        b=Jw8A8hjZXu67lhvbg6nQX+92c7xyA/gPo/ap9NUTNFCyVxrfaVF6zlYqhEIQBTC92d
         tt8ugCQITH1+1+6V7m74Dtaa5aXoq3Gv473+Osl2Had//JehBHnq4xCa/NtUA5ROXf3i
         bpITgwoOsa43i0sy0cbxjlUUALslMgB7CQ7a57I/rpUP/nQefhNrY2R5BTrB0V+vLCp7
         amV86rTulA9uv2BVVe/OkDl/ugoxox/3Vsk1nSsSEWNkH7ISv4VVeeZI+OtYPkKd+rds
         ggMJKB7DGa8XtKw5t/B/JlTs79qqL843S0ir6qwh6NyJYhI6OhO3u2/OgdrsFkWt5023
         b5vA==
X-Gm-Message-State: AO0yUKV3T3CwcnsG+vr7qClPED/RDJYpLmhMBKsiojFf4oeDKSS+5K9S
        KH1F0Li+KgE5i8ucI2ajl12ap7WFJp42Af7thf+r/VUsYMc=
X-Google-Smtp-Source: AK7set/geGmdqqs74xRrdi+v0+/yQAYstdadBC5jK4HV+Z3RCoYO9Pvxt4kecOzcNGIrIsno1/5f+Rr/gE9wPUIdkes=
X-Received: by 2002:adf:ea52:0:b0:2c4:80a:e849 with SMTP id
 j18-20020adfea52000000b002c4080ae849mr2069931wrn.1.1677766659703; Thu, 02 Mar
 2023 06:17:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677750859.git.mazziesaccount@gmail.com> <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
In-Reply-To: <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 2 Mar 2023 16:17:28 +0200
Message-ID: <CANhJrGOnG0r+t02wGHfbwqJh6k7xVE=1ah=w4m0s9JjqAGV-9w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to 2. maalisk. 2023 klo 12.59 Matti Vaittinen
(mazziesaccount@gmail.com) kirjoitti:
>
> ROHM BU27034 is an ambient light sesnor with 3 channels and 3 photo diodes
> capable of detecting a very wide range of illuminance. Typical application
> is adjusting LCD and backlight power of TVs and mobile phones.
>
> Add initial  support for the ROHM BU27034 ambient light sensor.
>
> NOTE:
>         - Driver exposes 4 channels. One IIO_LIGHT channel providing the
>           calculated lux values based on measured data from diodes #0 and
>           #1. Additionally 3 IIO_INTENSITY channels are emitting the raw
>           register data from all diodes for more intense user-space
>           computations.
>         - Sensor has adjustible GAIN values ranging from 1x to 4096x.
>         - Sensor has adjustible measurement times 5, 55, 100, 200 and
>           400 mS. Driver does not support 5 mS which has special
>           limitations.
>         - Driver exposes standard 'scale' adjustment which is
>           implemented by:
>                 1) Trying to adjust only the GAIN
>                 2) If GAIN adjustment only can't provide requested
>                    scale, adjusting both the time and the gain is
>                    attempted.
>         - Driver exposes writable INT_TIME property which can be used
>           for adjusting the measurement time. Time adjustment will also
>           cause the driver to adjust the GAIN so that the overall scale
>           is not changed.
>         - Runtime PM is not implemented.
>         - Driver starts the measurement on the background when it is
>           probed. This improves the respnse time to read-requests

Seems like I forgot to update the commit message. Note to self: change
this when preparing the v3

,,,

> +config ROHM_BU27034
> +       tristate "ROHM BU27034 ambient light sensor"
> +       depends on I2C
> +       select REGMAP_I2C
> +       select IIO_GTS_HELPER

And, judging some other fixes - it seems this one would also need the
select IIO_BUFFER and IIO_KFIFO_BUF now...


-- 

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
