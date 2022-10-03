Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1691D5F2C22
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJCIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJCIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:39:22 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045875A14C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:14:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id u26so6842445lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protocubo.io; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tS2WhQfDTQ5XRI83dZZXEjLfz+Bdzbu6tgG4oPFfDXY=;
        b=jyNfGU+c4IyLm9QAFKv3OU1MJPCyo4I3vRtTlIOMRwlvx5mS3CF+e2Vf/H5xsWEZGW
         dY0d14uf8BVR3Fkk9TgVcRy/hJKJjHarzJq2DP09BLPpcOkZo1cpy1hvhpYXzI0HJgeQ
         4+fRqdg6E/IeBDi4fVlwfxdEkDyxkFhKn5Rc+KnMg2V75Js1rc02Ej8ZOlyiHFLgDk4y
         JuxLuODXz2n6I1RK9LzGMpHeawVjw5XBFBfHKxfBvmwThixTbcoKpNv7Ffnwfm4OM2df
         CJ3nKVD3ayhp1pfBkdjOcRBJkYgSe7fuEWWcdfxTj3D1MBHkb/rwDugh34hfpN0yl0li
         ppqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tS2WhQfDTQ5XRI83dZZXEjLfz+Bdzbu6tgG4oPFfDXY=;
        b=YJ+j4xlEvgLsiLJq7AqVTXP3vArQGBdWaybnlZ00CsbY29Jg0GFOAL6qXmDBvutHMr
         hzdRSZCI54ZXji/13wBZhS2rHjuGlOD28a05G3pRLCsTj0doK/wHd58a9+ncK5JTFZj0
         U1mvyrUt85qfZlbPO8nQeknMQu7WckooR7pgakTzmHDtdpW+nhVhqdWEXYlgW6WTerMR
         i/zqo7U/cIfrmN5x4E5+lvzhLgXTuR/YTeF+ZLCNdP73qNIbiBkCo2MkYTpmJStaCNpI
         Jw7T2bDzZLshYhUw240Hqf7PVD9BE6SuCZ2F29pjVVhQzyLa9kdx13ms/DPhZ32Rwytf
         abZw==
X-Gm-Message-State: ACrzQf2zDL74ZT3W6vFMgAsP0PDwGb8Ml7e2+5JTW4PcL2YrDM/+LNzI
        PDUVMvVH4zdd7P48MRvXux/rThs3fIJQ2YwiP9KzpipIqFk=
X-Google-Smtp-Source: AMsMyM5aNnON8tY8jJc9Xq/aAamvtgglftZh4nNm54jS+VeuXs9Tv9dTN6Xx0dCiXtfpB+XJAWYYxqIqzw/tHoIxAeo=
X-Received: by 2002:a19:7003:0:b0:4a2:40b9:dea8 with SMTP id
 h3-20020a197003000000b004a240b9dea8mr907848lfc.688.1664784843457; Mon, 03 Oct
 2022 01:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <YznOUQ7Pijedu0NW@monster.localdomain>
In-Reply-To: <YznOUQ7Pijedu0NW@monster.localdomain>
From:   Jonas Malaco <jonas@protocubo.io>
Date:   Mon, 3 Oct 2022 05:13:27 -0300
Message-ID: <CANS_-EOai0-4=oDvNgHCUjhnNz_AmAtKx_sOPxF9Z88TsJv7FA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: corsair-psu: add USB id of new revision of the
 HX1000i psu
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 2, 2022 at 2:46 PM Wilken Gottwalt
<wilken.gottwalt@posteo.net> wrote:
>
> Also updates the documentation accordingly.
>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
>  Documentation/hwmon/corsair-psu.rst | 2 +-
>  drivers/hwmon/corsair-psu.c         | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index c3a76305c587..3c1b164eb3c0 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -15,7 +15,7 @@ Supported devices:
>
>    Corsair HX850i
>
> -  Corsair HX1000i
> +  Corsair HX1000i (revision 1 and 2)
>
>    Corsair HX1200i
>
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index c99e4c6afc2d..345d883ab044 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -813,13 +813,14 @@ static const struct hid_device_id corsairpsu_idtable[] = {
>         { HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> -       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> +       { HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i revision 1 */
>         { HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
>         { HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> +       { HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsaur HX1000i revision 2 */

Wilken,

A small typo has creeped in: s/Corsaur/Corsair/.

P.S. Sorry if this reply arrives somewhat mangled, I'm away from my
regular setup.

>         { },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
> --
> 2.37.3
>
