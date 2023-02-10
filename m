Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1F691C98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjBJKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjBJKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:19:25 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044066D8E6;
        Fri, 10 Feb 2023 02:19:24 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id h24so5250006qtr.0;
        Fri, 10 Feb 2023 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCZqd00XLcn3H5BBn1Pzxmkx7XJk9fwg6p5ZnvuseLk=;
        b=kCi2bTLuVJnUSE0d2dpQiJWGvGnc+OIZu/v4tYQBHP9T3ZKA/693e8JfBItJa+hWvj
         D9FfO9lZL2M9HejH/zh5knsSvAOqefM/MN8amCdoHowC8M+9C1+IefITJyfIHo2awLQR
         dUdtjCUbEoQ0Mox83L9OM1M2xXlNdQC4oIBYz2KnoCO8tydSUHonXgZIEz0U/BaZHsBF
         fMkr+lk+9laZwIR/kMwZw+C8dgux5BwwnlH8Tjz8ksDmWIJDFE7NvoWBEEr7vfovGIfu
         YbDOIj7sAqJ4HrDS3FwyEPMxkGJ9A/rkmxR5iyQuTtAJFNxlnqv68MA1ZAIembc94Cv4
         4JnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCZqd00XLcn3H5BBn1Pzxmkx7XJk9fwg6p5ZnvuseLk=;
        b=ra/DrnAABPx44VBYUeyS0nNgmuwmmklV9493b1yY7UpEUUdz38RUVB8HlXrlyDR05S
         qxv3e0ZEzXezZX0wKwqZMshvnItI7SGMfyJ7lw4x32ewVWmgyPRByaOSRMvJkUXhq+YY
         wiELYrwO80HyMsV1Y0SfZj7dsiDelSORWBuqXgAv4+mJfPR4KT+cD0NO59nUAdvWhTkF
         UjU5a9o8l6ILar5xYoiuUY5yF5BlT2z5367FCCmfnfKURSpbMIl1287QiY2mlqSrTx0J
         Sc3mZaK1YLKB/AITQj/YgO7FzoOk/2UcAM9CIAZfxssWcaJkTfqZ2sDwFXfXLArwZ0JU
         f/Og==
X-Gm-Message-State: AO0yUKVH/sivWE9+ol5yw8+4wHtgP5P2sW/KVJ+IDGHn8u211TrqQXpk
        g5glEhgMkkgWzwJDSeRc8UnKLyI8wRiT8i3JToY=
X-Google-Smtp-Source: AK7set8bR0KQF+vsQVgkUBdqSNVcDf1IYvUkD7ceRkYWWdLBF1IJ25xJLfofrYsjGbTVN8paTJOWLl2PV1rzkrFnJ9s=
X-Received: by 2002:ac8:5dce:0:b0:3b8:6cef:4345 with SMTP id
 e14-20020ac85dce000000b003b86cef4345mr3028572qtx.106.1676024363085; Fri, 10
 Feb 2023 02:19:23 -0800 (PST)
MIME-Version: 1.0
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
In-Reply-To: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Feb 2023 12:18:47 +0200
Message-ID: <CAHp75VcPPDTmpx9jpu3ZoaVH_xBgtaEbDQcJJdqcaXi1J+_q0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel Macs
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
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

On Fri, Feb 10, 2023 at 5:41 AM Aditya Garg <gargaditya08@live.com> wrote:
>
> Greetings from t2linux!
>
> 2 years ago an attempt was made to send the driver for the Touch Bar on
> MacBook Pros by Ronald Tschal=C3=A4r [1].
>
> Due to some issues pointed out by the maintainers upstream, unfortunately
> it didn't make it upstream. Now we at t2linux [2] have addressed those
> issues in this patchset and also improved the touchbar driver for the T2
> Macs. We also have added a new driver for keyboard backlight support on
> T2 MacBooks with Magic Keyboard.
>
> The first 2 patches of this patchset are the ones sent by Ronald before,
> with the issues addressed as pointed out in [1].
>
> The third patch introduces a new driver, apple-magic-backlight, which add=
s
> support for keyboard backlight on T2 MacBooks with the Magic Keyboard.
>
> Note: Apart from these drivers, for the T2 Macs, an additional driver
> shall be required to communicate with the T2 Security Chip, as the Touch
> Bar, the internal keyboard, trackpad, camera, ambient light sensor,
> headphone controls, and NCM Ethernet are accessed through a USB VHCI
> created with DMA channels to the "T2 Bridge Controller" 106b:1801 PCI
> device. A work in progress linux driver called apple-bce [3], or USB
> device passthrough to a Linux VM guest on a Windows host with Apple
> Bootcamp drivers can be used to get Linux these USB devices working and
> test these patches.
>
> [1] https://lore.kernel.org/lkml/20210228012643.69944-1-ronald@innovation=
.ch/
> [2] https://t2linux.org/
> [3] https://github.com/t2linux/apple-bce-drv

Quick observation. Do you miss the Co-developed-by: tags in the patches?

--=20
With Best Regards,
Andy Shevchenko
