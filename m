Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35362658764
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiL1Wuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiL1Wug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:50:36 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A50140E9;
        Wed, 28 Dec 2022 14:50:35 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id q3so3052312uao.2;
        Wed, 28 Dec 2022 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXS0WTkQS796wH+169yPGp3Qy/IBZ8bIc/3/txwl1TU=;
        b=D4dNC0LMGYdzYCOsJT1n2E7i/egbcnTZfkyivV/mdZAa/UWiaAXemdGimbhvLfSV6/
         F+IXZhKfxufhAM+1VbxOO/rjOYDC6q7TVxhxmb8eRVYhc27PLrVO/JL/xeoClJdYHOPi
         zNhRfHybfZapjyxiTmZUOZVgzVt6+DMjGGD9k1ziu7UpxCJPr6Ra266nDw97RG5M39Fb
         yFdIHABl6ijhPPOTXl2fUu8gQk08jz7A6aRkNKCKuJh+NvHHEOojY7ODgMeRmUTzTHUH
         vo1XcPltVZndKurUwrYL/FUEQDIvw8UHy5RVg7s33gouIXJ4rya1eGbZ52TtqtfBV+p0
         vxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXS0WTkQS796wH+169yPGp3Qy/IBZ8bIc/3/txwl1TU=;
        b=XIF0u76uzuCBHrcTYEVJ3k8AHTFcF3eGLAOZqvz/kDWGRmG5UXaLYEZcoL4PHYVaQw
         0ESeRRrkOlZn5/8QpIQotSX9gB0t2d2cW9Xq80qFibDS0AQyeKHZv09PK4dDJTaFf38M
         aWlxSgqPQLcV5Awa6R4mqeGWY75PFgHINXN2xyp77p5HzyxwQ4mlZHcWp4S/UR8XLcTU
         8eBmwpfEQUSf0z1sCw6JgCQBNC5J4PEqQW6vQxBKf2Fvo+1gO3OaaaIuO/GjXX8teZln
         gdW6t3pMclliLFIsHxcmS8QqB5o9olAWc1yUlDRnJGnMm7s8qw8oEVzSOu0boGrgtYlc
         x4bA==
X-Gm-Message-State: AFqh2kptZrIYUVx3D3CRvODo/M40GXwV73vRN5sLUOIXfFk3tZnbsT9h
        QlTcisYdsEPXRDTDUoB0OwyyFHHumEddvqCtyN0=
X-Google-Smtp-Source: AMrXdXsGzFIdAzhOfKdOYCkzaOB3A9f7se7KWmm8nehxEkpwJXMiXcBNIbYpThf6q3UTlYt/z+E13d7JDdB6LSOetaQ=
X-Received: by 2002:ab0:2b0f:0:b0:40c:caeb:5130 with SMTP id
 e15-20020ab02b0f000000b0040ccaeb5130mr2605937uar.24.1672267834723; Wed, 28
 Dec 2022 14:50:34 -0800 (PST)
MIME-Version: 1.0
References: <Y5lBue87IXkhNs42@debian.me> <20221214154713.100648-1-derekjohn.clark@gmail.com>
 <20221228155542.GA3964987@roeck-us.net>
In-Reply-To: <20221228155542.GA3964987@roeck-us.net>
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Wed, 28 Dec 2022 14:50:23 -0800
Message-ID: <CAFqHKT=OO6367zfbEGmghahCUkV4ECLvCH+A_WLhBQyZf4k_jw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

> > ---
> >  Documentation/hwmon/oxp-sensors.rst | 19 ++++++----
> >  MAINTAINERS                         |  1 +
> >  drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
> >  3 files changed, 59 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/=
oxp-sensors.rst
> > index 39c588ec5c50..a53c961065b2 100644
> > --- a/Documentation/hwmon/oxp-sensors.rst
> > +++ b/Documentation/hwmon/oxp-sensors.rst
> > @@ -3,18 +3,21 @@
> >  Kernel driver oxp-sensors
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > -Author:
> > +Authors:
> > +    - Derek John Clark <derekjohn.clark@gmail.com>
> >      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
> >
> > -Description:
> > +Description
> >  ------------
>
> Why drop ":" here ?
To match the style of the rest of the Documentation section titles.
Per Bagas Sanjaya previously:

>> -Author:
>> +Authors:
>> +    - Derek John Clark <derekjohn.clark@gmail.com>
>>      - Joaqu=C3=ADn Ignacio Aramend=C3=ADa <samsagax@gmail.com>
>>
>>  Description:
>>  ------------

>Trim the trailing colon as it is not needed for section title.

Additional changes forthcoming. Thanks.
