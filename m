Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37956BAC0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCOJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjCOJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:23:05 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88137233FE;
        Wed, 15 Mar 2023 02:23:04 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 97so2605340qvb.6;
        Wed, 15 Mar 2023 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI8+SZdZGTfMjh40WQniyR0RGVqLdMP+WWCFapsHzyE=;
        b=hXtoEBTpdWVu5PhHp7XdS8adDNmxmbzIjyylNE4fzdY25t6FaI6zlEwE4Qef469Ioq
         Il8KTH/xBgUecDyB5Zt2gSkeqgNpNdpFRPH8uoJMWjrfr4KdsVRl459tElfFrmNLe/cT
         sY6ACG2NpPSnqWKCSMGp91+G5Nx/ppm/FmOdDdVbMMjXZS0WNaELZtsE3ISceb0IC4rW
         m+bdwE4M1boLijHTjZ/EEF6LYKYe9In/FoEKMP8FRIm9T5hP3lJwKJhmMIOqnNREvZjU
         aO1mebsQlQ0KhvD1tEp8qQCqUttLTyFus/AbEzjDesE0f/+UziFlOyjnTxlcydrnz7WS
         e41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xI8+SZdZGTfMjh40WQniyR0RGVqLdMP+WWCFapsHzyE=;
        b=OTVPoOKBx7ENt/UusfdKLz310TdHK9X5rEYziwNz/PVmbe26udyTAzxBniDzlDJJ2Y
         ZVwWw9g2rfGIWhm4+3FfBypXWG81I4t+oRcPpthdAlFlYaaNhxgLH7jmvSLOgDuKVJjL
         9XP9mi5zEYK72zrlDXIkSpKb16eQvo1koaXfIHmpWEX/SWRV1KHbFScPibIMccOc7sXy
         8XYm5F6Lkd0iNfuJhMOtpsDm16NLcq1o3I2OxnJUjd2OMQsd33U7PQk6637bafHubv+N
         YEckVNX4uw9AlcAqNPiBwXEaN7GxM8CxG7Py/NgmTZXbhuvFWqCBvIfen8hR3smxEOf9
         aH9g==
X-Gm-Message-State: AO0yUKXQjX9nxSmuBCv9TEUdm4bAr56ZB8/L4Y+SWOdOSyEvT7uOuCJQ
        IUKnQrUAQ9KYsezsN+D5ZP1pU2KjLEUzr1+nv0KrgeBUbPQ=
X-Google-Smtp-Source: AK7set+kY+opVMNHIGgJ/3whVcS7+M1lO4e5/zTAEnbRmWkCwMS5We1BCfiBcA/DtsfKcmkahE8td9rCIy0wYGEq8/E=
X-Received: by 2002:ad4:48c8:0:b0:56e:fbbe:515f with SMTP id
 v8-20020ad448c8000000b0056efbbe515fmr3539335qvx.10.1678872183697; Wed, 15 Mar
 2023 02:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230314221609.22433-1-asmaa@nvidia.com>
In-Reply-To: <20230314221609.22433-1-asmaa@nvidia.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Mar 2023 11:22:27 +0200
Message-ID: <CAHp75VcDR88K0snx_DJa4NX1GYjbMda8ALmmuDoCQCHqEYbX_g@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Support Nvidia BlueField-3 GPIO driver and pin controller
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
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

On Wed, Mar 15, 2023 at 12:16=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> wr=
ote:
>
> Support the BlueField-3 SoC GPIO driver for handling interrupts and
> providing the option to change the direction and value of a GPIO.
> Support the BlueField-3 SoC pin controller driver for allowing a
> select number of GPIO pins to be manipulated from userspace or
> the kernel.
>
> The gpio-mlxbf3.c driver handles hardware registers and logic
> that are different from gpio-mlxbf.c and gpio-mlxbf2.c.
> For that reason, we have separate drivers for each generation.

This one is in pretty good shape, a few minor things to be addressed
and the v6 I believe will be ready to go.

--=20
With Best Regards,
Andy Shevchenko
