Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36B45F234F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJBNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiJBNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:19:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD9459B4
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 06:19:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id rk17so17451314ejb.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 06:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=j5VIVRriTeMDEX6uw2Y4xbQwFPhK4bKzLdrKvFJvgWY=;
        b=eD/dIrkrEXHvc6HN3YLNoYEkOWq089SFWTiGMpQW+NmuNbxs8b0sWgmUdIpFvqLBPo
         4RhQPeYXGWkqL1N4TDA2cYcj3cRwX3euqIMvKVb17pn2rZBNFezeAtTJV4GnFQeDFaR8
         LO5IiLsc4XuDQn7jL7c+FIOGOO7fNGBKZtEKrLOpjqyWi3/obHGDjr+skM3tDOdCgA3b
         /bGmYcOJY1VqunFv9y3Q3Re+j5Y1e3nyZ6PVy3MvQ9Jm6UIVo5miBkOQn0GAIRPv+9cX
         qasPpzvU6HiOXbzeWfWikuRG6ZNOB26FymdDuZw/NewlyX3YibeMWJmKN+TvwW5vUUAl
         HHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=j5VIVRriTeMDEX6uw2Y4xbQwFPhK4bKzLdrKvFJvgWY=;
        b=LUjIUSWaL9MlrSOwo2qQmxn0zwy7BSgB6b/jTOg0eRgFzRqHiqtEO9CSDTZSliO8Kr
         JO9h6ljjjP57PQ5gDTmueviQpaZsTPJGir2tfEQONN9DqM1V+IP6+opD+8148F2695W/
         M9Ra6nl4NnwYLbnGXpSmWDaASstgREntYIork9k1qTS30LO6hcWs6TPFpLiu03XNQ/YF
         wfq+0N4Z3H6lKkj/rqT4NMihN1d7nCV9tJkvOB8tmN9v7wXQe2i8GQ2+MKnNQFihJD4U
         InO0eI7W7VlDOxCZD62KylVu9csuEmWVmnOSu/iDdOv8VyzL9of+l//WXgJBbQ9p4Dhg
         UNqg==
X-Gm-Message-State: ACrzQf0tUViDGUOT6OZs1etFLYLyJ0zh0MMqPnZYMrXUihAErvrqN9E4
        Yj5phcgh06dXDUodJYh/NZeegj2z5oaM+lzHbDhiqA==
X-Google-Smtp-Source: AMsMyM6iABEfAOs5DtiWbQTwYgEPjrgjh3sVpQ1UOTEoRS7Z3axNDaneB55QeVHNVhkv9tJs8L5HL/ahTxM5gVH2O38=
X-Received: by 2002:a17:907:843:b0:73a:5b0e:8352 with SMTP id
 ww3-20020a170907084300b0073a5b0e8352mr12396036ejb.438.1664716760535; Sun, 02
 Oct 2022 06:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com> <20221002122859.75525-5-matti.lehtimaki@gmail.com>
In-Reply-To: <20221002122859.75525-5-matti.lehtimaki@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Sun, 2 Oct 2022 15:18:44 +0200
Message-ID: <CAMZdPi99qiCagqehoTyCuE19CeP-WvvePgHaSqGku-qBHg0xvQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] i2c: qcom-cci: Add MSM8226 compatible
To:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        Robert Foss <robert.foss@linaro.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2022 at 14:29, Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.co=
m> wrote:
>
> From: Rayyan Ansari <rayyan@ansari.sh>
>
> Add a compatible for MSM8226's Camera Control Interface, which is
> similar to the one used on MSM8916.
>
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> Signed-off-by: Matti Lehtim=C3=A4ki <matti.lehtimaki@gmail.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>  drivers/i2c/busses/i2c-qcom-cci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index ea48e6a9cfca..87739fb4388b 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -807,6 +807,7 @@ static const struct cci_data cci_v2_data =3D {
>  };
>
>  static const struct of_device_id cci_dt_match[] =3D {
> +       { .compatible =3D "qcom,msm8226-cci", .data =3D &cci_v1_data},
>         { .compatible =3D "qcom,msm8916-cci", .data =3D &cci_v1_data},
>         { .compatible =3D "qcom,msm8974-cci", .data =3D &cci_v1_5_data},
>         { .compatible =3D "qcom,msm8996-cci", .data =3D &cci_v2_data},
> --
> 2.34.1
>
