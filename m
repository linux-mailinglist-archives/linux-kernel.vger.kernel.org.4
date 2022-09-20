Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8E5BE248
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiITJoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiITJoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:44:34 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070625E8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:44:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b35so3071797edf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 02:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=OyCx9Q/YabKJ08RMc2YSISL+trnpKtcuAbGr7WtPKfc=;
        b=AAItVZaAaMgY8eWYbeiDcXrXZFKaspBfiGGtzZWsfSj0KwHXmMmMluUXajKqmfH6cw
         HmZebfGoOHLIHmpNJG+sa8ZfzrQT0PIWtURt5RYjgu9d1LKmuUwimv2+53RfhoKvC2Hf
         O9t0oLT7u+CZ+ukOnUkWVkEcrI7sGtHnp/1OkiL0wMWNIhAeEuChwYoaypnaEoumGpvY
         V2OSwcVdlRsZiR5FP3Oaylvpy05AVH1AT5tRDt2LggtrAzNxH9lQN/gf6uRY3AjRNdkp
         TZg62OTF+zBlDCbgSltRsBpqinQEZ9jRp3dMJh1X4WpybQIHVZxrMtfyw2Dp37wwD6ci
         6vOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=OyCx9Q/YabKJ08RMc2YSISL+trnpKtcuAbGr7WtPKfc=;
        b=Ian7rPrcfjAyLiUofxN31q3tF1XPDi7/GS2zNlXUDOW+yD6lORX+UPQPdNDq9txKf0
         ZJ6AnzbtvkYOfZ+kVpm7DCYJ0uSG87kxJUhmz7VLyrGS7Mls/tHuu1aHvQ99BSIq673d
         Bn/LnxeAAmEDdNVPctFf8zq7ccYbDpxby01/vZGS1297ZYP69LgBdUSoCi5YzhIMHD8o
         l4vwjQ/Zvl5p9D62073hJ/ZBPj1uo16YbulnTm5wT+gTbin37rsdwVCKbL2V+eIM2fTC
         0rqCH/vW9ZwjYf5FYAENKrzQfwTrvb7ouFrd/AxaOb224Pm3sjFydG4Lb1c8AQvzem7k
         m3xQ==
X-Gm-Message-State: ACrzQf26f0PbEYmKDh2qYsDS6+/yYFs+v5Zsd7mV4QYLIiHAVdQuBEAC
        IPABNWTjExBnJwT4ZRxykDhMTo0pfJHBCDV1Bc103Q==
X-Google-Smtp-Source: AMsMyM6InZTkT9FN9zpFRW+4rE1C5opy2tXduGXYOGfiHkGd9ccEMJUItzhCIu0PfXC/9vp1T0doU0xHKC+Lmm6BJjc=
X-Received: by 2002:aa7:d6d9:0:b0:44d:e1b7:d905 with SMTP id
 x25-20020aa7d6d9000000b0044de1b7d905mr19361012edr.32.1663667071339; Tue, 20
 Sep 2022 02:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220728091712.13395-1-m.zatovic1@gmail.com> <CACRpkdbD1qzJujhq-U0UN0tWam9CaoLvVuAQfafq4XNaEdZ2QA@mail.gmail.com>
 <CAPGNi94R6bW80Yc=B5iesW=ihxy_bD1p-iPhLCASh_=82mjT9w@mail.gmail.com>
In-Reply-To: <CAPGNi94R6bW80Yc=B5iesW=ihxy_bD1p-iPhLCASh_=82mjT9w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Sep 2022 11:44:19 +0200
Message-ID: <CACRpkdY2pGOV=PFKEaPAnKpt16HNLomRuQKRgH8A+cKFUotRXw@mail.gmail.com>
Subject: Re: [PATCH RFC v1 1/2] bus: add Wiegand write-only GPIO driver
To:     =?UTF-8?B?TWFydGluIFphxaVvdmnEjQ==?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mani@kernel.org, hemantk@codeaurora.org, elder@linaro.org,
        f.fainelli@gmail.com, Michael.Srba@seznam.cz,
        jeffrey.l.hugo@gmail.com, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, saravanak@google.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 2:57 PM Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.=
com> wrote:

> 1. drivers/bus/wiegand.c
> 2. include/linux/wiegand.h
> 3. drivers/gpio/gpio-wiegand.h
>
> I have looked for drivers with a similar division and tried to figure out=
 what the file drivers/bus/wiegand.c should contain.
> So far I am only sure that it will contain the parity calculation functio=
ns.

That is a question for people who know wiegand... Maybe just yourself!

You also clearly need some bus infrastructure to populate and spawn devices=
.
This mechanism depends on the specifics of the bus.

> The code for sysfs attribute files may also be a part of this file, but I=
 am not sure about it.
> If hypothetically there was another Wiegand driver besides the GPIO one a=
nd a user would
> like to connect both of these Wiegand interfaces, he would loose the abil=
ity to set attributes
> for individual Wiegand interfaces, am I right?

You should spawn individual devices on a wiegand bus (the kernel concept of
bus). Each new device becomes something like a struct wiegand_device that
contains a struct device, and the struct device is the anchor in sysfs.
https://www.kernel.org/doc/html/latest/driver-api/driver-model/bus.html

> Should the drivers/bus/wiegand.c be a full-scale driver or should it just=
 be a file that
> contains the Wiegand-specific functions(such as parity calculation)?

It should be what we call a bus driver, OK a bit self-referential, but anyt=
hing
that is common for the bus and the code to spawn the devices.

Yours,
Linus Walleij
