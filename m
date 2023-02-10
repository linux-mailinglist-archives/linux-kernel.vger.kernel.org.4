Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A392A691F00
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBJMUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBJMUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:20:53 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F62595D;
        Fri, 10 Feb 2023 04:20:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so9644103pjq.0;
        Fri, 10 Feb 2023 04:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCTvu0a6wjUcbYhCc56Bv6cmIy8USHw9Y3nQMvihJyA=;
        b=loZIz7P9g19yyWNOaOqhhert3n89gsLEw7u9lgkxEbOlKNA3uEL5OmWIIKM/eQNLxN
         HhfnOnuwzqAKtmYjYym1eF+kJGKRAZnTlvOQEswjTwxq0/Dzqe9i5ae4ChFSOJ6n3Ha0
         +xci1JfNQsnVW5DFGZWQeAec5N1dEjbdD5G/uWeEqPksK8Fb3prv8Prp6qLJb6iwNjwt
         QzommCgDcCxE2w1m2NBpbH0Q6lmNsXukWWY0Gwa3KYdr9IHTuW4wSmWWtqciA19JmXO9
         B0LlaYdfXTahkklclYDlJl1n/bb85TEE4vtHZx8V+QImwSIhVAuZcwi/vkf4Ym9KumLJ
         XMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCTvu0a6wjUcbYhCc56Bv6cmIy8USHw9Y3nQMvihJyA=;
        b=TQiSqWzEe8qWAPMGtYuZkRhTAn+B3If/dgBQiQH8kgpaBSvVoMiwWzfnUjfW57btoJ
         d363VgCKZi0U/nGdt1XDy2bX4RYTR15wNfIM8Sa0yHM6JXLRHKyho+a2JFBJh1RTQYYw
         EnOZAOocQ6PYkK1+3mewfKJdDR5wmU/E8rPZU0UkMIWcpQcgusU9iblat6p3EUtj3wEX
         YeHILaiAqylQWdMc8+KhIYF+ShzjGmPZWdI1SX1OxZKs9BheZlDDbH2uNPJbo4sgvsaf
         rxctIPaZ61Ml+Bh2gy58Jr7e3R9F5Cy4ksF/WFjHoRF/D+VMRRJdoFqjEwq8Npg02guG
         Q9Pw==
X-Gm-Message-State: AO0yUKXh9qEPk2AwK/T0eQPqYf0FaCqbdxvdwG7fcpznRUjtOMWW9vpd
        xUwnSvSpbN3m3o9NeLkenLs=
X-Google-Smtp-Source: AK7set/oizdOeWlu58ZoA4nucT77ymE1cQ9Egy5hUKlJt6b046LD4vcGa3qe0pLjYjcyMJKxERr0UA==
X-Received: by 2002:a17:902:ec90:b0:199:12d5:5b9b with SMTP id x16-20020a170902ec9000b0019912d55b9bmr17001775plg.25.1676031652119;
        Fri, 10 Feb 2023 04:20:52 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b0019a688446edsm2118176plo.78.2023.02.10.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:20:51 -0800 (PST)
Date:   Fri, 10 Feb 2023 23:20:43 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas@t-8ch.de>,
        Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver
 for T1 chip.
Message-ID: <20230210232043.18483401@redecorated-mbp>
In-Reply-To: <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
        <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
        <20230210045624.cjxroikmmvm3liij@t-8ch.de>
        <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Fri, 10 Feb 2023 12:05:13 +0000
Aditya Garg <gargaditya08@live.com> wrote:

> > On 10-Feb-2023, at 10:26 AM, Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> > wrote:
> >=20
> > Hi,
> >=20
> > some comments inline.
> >=20
> > On Fri, Feb 10, 2023 at 03:43:24AM +0000, Aditya Garg wrote:
> >  =20
> >> +
> >> +static struct {
> >> + unsigned int usage;
> >> + struct hid_device_id *dev_id;
> >> +} appleib_usage_map[] =3D {
> >> + /* Default iBridge configuration, key inputs and mode settings */
> >> + { 0x00010006, &appleib_sub_hid_ids[0] },
> >> + /* OS X iBridge configuration, digitizer inputs */
> >> + { 0x000D0005, &appleib_sub_hid_ids[0] },
> >> + /* All iBridge configurations, display/DFR settings */
> >> + { 0xFF120001, &appleib_sub_hid_ids[0] },
> >> + /* All iBridge configurations, ALS */
> >> + { 0x00200041, &appleib_sub_hid_ids[1] },
> >> +}; =20
> >=20
> > const
> >  =20
>=20
> Constantifying this results in compiler giving warnings
>=20
> drivers/hid/apple-ibridge.c:78:23: warning: initialization discards
> 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> 78 |         { 0x00200041, &appleib_sub_hid_ids[1] }, |
>         ^ drivers/hid/apple-ibridge.c: In function
> 'appleib_add_sub_dev': drivers/hid/apple-ibridge.c:363:29: warning:
> assignment discards 'const' qualifier from pointer target type
> [-Wdiscarded-qualifiers] 363 |         sub_hdev->ll_driver =3D
> &appleib_ll_driver; |                             ^
> drivers/hid/apple-ibridge.c: In function 'appleib_hid_probe':
> drivers/hid/apple-ibridge.c:436:12: error: expected '(' before
> 'hid_is_usb' 436 |         if hid_is_usb(hdev) |            ^~~~~~~~~~
>       |            (
> In file included from drivers/hid/apple-ibridge.c:48:
> drivers/hid/apple-ibridge.c: In function 'appleib_probe':
> drivers/hid/apple-ibridge.c:544:35: warning: passing argument 1 of
> '__hid_register_driver' discards 'const' qualifier from pointer
> target type [-Wdiscarded-qualifiers] 544 |         ret =3D
> hid_register_driver(&appleib_hid_driver); |
>         ^~~~~~~~~~~~~~~~~~~ ./include/linux/hid.h:898:31: note: in
> definition of macro 'hid_register_driver' 898 |
> __hid_register_driver(driver, THIS_MODULE, KBUILD_MODNAME) |
>                      ^~~~~~ ./include/linux/hid.h:893:47: note:
> expected 'struct hid_driver *' but argument is of type 'const struct
> hid_driver *' 893 | extern int __must_check
> __hid_register_driver(struct hid_driver *, |
>                      ^~~~~~~~~~~~~~~~~~~ drivers/hid/apple-ibridge.c:
> In function 'appleib_remove': drivers/hid/apple-ibridge.c:558:31:
> warning: passing argument 1 of 'hid_unregister_driver' discards
> 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> 558 |         hid_unregister_driver(&appleib_hid_driver); |
>                     ^~~~~~~~~~~~~~~~~~~ ./include/linux/hid.h:900:35:
> note: expected 'struct hid_driver *' but argument is of type 'const
> struct hid_driver *' 900 | extern void hid_unregister_driver(struct
> hid_driver *); |
> ^~~~~~~~~~~~~~~~~~~ make[6]: *** [scripts/Makefile.build:250:
> drivers/hid/apple-ibridge.o] Error 1 make[5]: ***
> [scripts/Makefile.build:500: drivers/hid] Error 2 make[5]: ***
> Waiting for unfinished jobs=E2=80=A6.
>=20
> Some warnings are also due to a typo in if and constantifying `static
> struct hid_driver`, although they probably can be fixed.
>=20
> In short, Thomas, do you really want me to constantify the structure
> I am talking about in this email, as well `static struct hid_driver`?
>=20

Were the changes needed for these structs to be const in the
linux-input tree for 6.3? If so then if you're applying the patches
onto linus' tree that might be why there are errors about consts.
