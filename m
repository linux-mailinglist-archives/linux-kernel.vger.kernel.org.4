Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71A66EC27A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 23:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDWVaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjDWVaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 17:30:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799C1132;
        Sun, 23 Apr 2023 14:30:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94f32588c13so511160466b.2;
        Sun, 23 Apr 2023 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682285450; x=1684877450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18byURsd69WE5YM1Kosl1na2iTLaVqec0Q8hqzElXCQ=;
        b=UpMUVMIcZYwgzlBgNfqGwLaGTQ8LBZpckrkTP8co4uaVRiioXyYKodDl4UM1opzsCR
         FwjKYa6zIDlqL8JlsMdEtfFfuuoil92uNwnlO7WErAKHAiWAuScXiPNCvXkhH8WC0C1Q
         LH102yESfPCFKqSlANYmth5TTctAP1PKpO9WJy+XEvumJlhs8cXlib5QpowvbWRO6Fm7
         oNsE6IEyqwK12t8ssFWtQnIM7xJ8iXyKNKch4H02mKofeI/sH1lXFvUb9D9/l2qlg9+Z
         Gtm3lNCy0k6ArmuDxI2ngSJVv12OSM617rUDxAdvwGjcjhGZWLvREkrw+Aobp5sdLsX8
         zWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682285450; x=1684877450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18byURsd69WE5YM1Kosl1na2iTLaVqec0Q8hqzElXCQ=;
        b=gRJhwZ3gNueXpaz5m+MumHTuirGKLxHXXqSTG0IPaUbeqXmR0vDi7uHu1rcIN935ld
         G8WLCZPgyFhditngzFlAxWPQmtxz+lm6F7Uffsfguan+BbwEHv8YuJo+DxUvfp4TbS5R
         2DJY4PGSJL+nXkoaeEWu6YPdG0W87zU17CeXqgpAN1NBbkhs1kB/+FLwVe1r6mXN4QHy
         Oa75Ab0/w+1XyRRdBuSKiTLGbC6ssIQIpUUGhrT+HUTvSzqlFwCsUGVK6WOk9tSqjHjE
         dJRCsYnV+6a6+9T1rrKGuNiEo2YUNjX2fsp7WxUWkAn1L7wQHAx1zHzYIy2sY8KmYwOc
         qL3w==
X-Gm-Message-State: AAQBX9ePvWhVJIIIuFofcBeW7bOP5jrMiqJkPDPF0JenV9Av92xrlyA4
        5V5OINbRcvhOFVYeJhbc3+S8tOV1Ybf3H87vyaA=
X-Google-Smtp-Source: AKy350biznEeVdPR+IKziz5Mo9fGNq2BckRGQcSOldDmB9sxfrWldGkWu2J4s9qdYYEN8VS1dRs5YAeA8QzTRjhqeh4=
X-Received: by 2002:a17:906:7d6:b0:957:2d2a:e8a2 with SMTP id
 m22-20020a17090607d600b009572d2ae8a2mr7535957ejc.27.1682285449823; Sun, 23
 Apr 2023 14:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230405195927.13487-1-ddrokosov@sberdevices.ru> <20230405195927.13487-7-ddrokosov@sberdevices.ru>
In-Reply-To: <20230405195927.13487-7-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 23:30:38 +0200
Message-ID: <CAFBinCBGWOB2XLb6su=R3W684rKdK3pOgPFsCGx+Oyo_pgdeBg@mail.gmail.com>
Subject: Re: [PATCH v13 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Apr 5, 2023 at 9:59=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevice=
s.ru> wrote:
[...]
> +static const struct of_device_id a1_periphs_clkc_match_table[] =3D {
> +       { .compatible =3D "amlogic,a1-clkc", },
> +       {},
nit-pick: please remove the comma after the sentinel

> +MODULE_DEVICE_TABLE(of, a1_periphs_clkc_match_table);
> +
> +static struct platform_driver a1_periphs_clkc_driver =3D {
> +       .probe =3D meson_a1_periphs_probe,
> +       .driver =3D {
> +               .name =3D "a1-clkc",
> +               .of_match_table =3D of_match_ptr(a1_periphs_clkc_match_ta=
ble),
I wonder if we should drop of_match_ptr() here as no other meson clock
driver uses it.
Also there's commits like 00cb754ac622 ("clk: imx8mq: drop
of_match_ptr from of_device_id table") which explicitly remove it from
other drivers.

Apart form these two this patch looks great to me.


Best regards,
Martin
