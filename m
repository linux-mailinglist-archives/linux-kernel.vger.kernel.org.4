Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5791655CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLYLpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLYLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:45:20 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C79C63B0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:45:19 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id g14so9327476ljh.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNBdokWVuXQlx6FNiZ+Zj44DcO3NL7lCH80r7XQkshY=;
        b=D5p5Krd752aMQt20o6QtLehHIMPjwAZOflmOgfY+41tBdmydbbGJtZNCIJLtPOxypa
         Z7tgkrS1mS5PxgrwsYrrL8jynlBvDXhrJrv+hlClZmkmDGmk2paF1RomZtqr//Qout87
         MlBRLR0D6OJP3yIpgA+NxKc9JpTSORODvuMOKRyBmIWA7Ms5s0YxqXzyEcRJYB91qWde
         Cbw3/uoguWPMbnjA9MCWHAvscP0iorU369X4hnrW6hFP/mvdNbtJ7lSkYnjw5b4OhTW6
         A9oIBHZ0zKeOZryA/P1QkyluFUfPvkBGBh62MLRR+R9mwyzkgP1OfoWDnUZ9Yn+Hblbe
         DN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNBdokWVuXQlx6FNiZ+Zj44DcO3NL7lCH80r7XQkshY=;
        b=yArOE1flwVpTiKQYMWQrjRpjKbIZ3s0F+51kSenkCQXClfU8Hre7TwB8i0la862Fi7
         pdy+KeEh1upDI+dbStEa7CCpxgXy8F4B72zy2U0tGxYNJgY3zOy/0vZtQyLId+HbCUZ8
         46aq38llqX/ehzDTXGvg0AGtMXwMLwRuBaZOXXEPBXE6xFH4dUKe2H+vLg4S8dXV7dtI
         Gmnyp5oej2K7R+jBmUt/S0ixAbR48ehUgA8gThpgC7zk3VGHykSIzx5V7jI6Gwy85JOS
         uqcF8srT9xF9Fe0zCSjO3Q7QyrmOv9rHrUlcCyah4DbFSXUMwnWfVJIZfOx1GS70MNRT
         Qh8Q==
X-Gm-Message-State: AFqh2kp06hWgeOk1NpXDSvsEwj05ha404zQ5cqMgmZme03cW8IcbKI5F
        5201pCeRi3J9YTkbb7NqD94=
X-Google-Smtp-Source: AMrXdXtzX40wVw87LHtyKDiS4tRL70JbSjbYr/1TvYLItLW8xORf4YKejZP41bfV01zWekXxDgKCqQ==
X-Received: by 2002:a2e:a402:0:b0:279:daf5:f24c with SMTP id p2-20020a2ea402000000b00279daf5f24cmr3832998ljn.24.1671968717643;
        Sun, 25 Dec 2022 03:45:17 -0800 (PST)
Received: from [10.0.207.73] ([185.32.8.213])
        by smtp.gmail.com with ESMTPSA id q185-20020a2e2ac2000000b00279a7266874sm1009451ljq.98.2022.12.25.03.45.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:45:16 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: iPhone Mail (16H71)
In-Reply-To: <Y6dTX2wx/SXlswGC@kadam>
Date:   Sun, 25 Dec 2022 12:45:12 +0100
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F701A496-22A6-4E3B-B3CB-E5BCF4C30502@gmail.com>
References: <202212181140.EAWl7FKx-lkp@intel.com> <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com> <Y6dTX2wx/SXlswGC@kadam>
To:     Dan Carpenter <error27@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_QP_LONG_LINE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



L=C3=A4hetetty iPhonesta

> Dan Carpenter <error27@gmail.com> kirjoitti 24.12.2022 kello 20.30:
>=20
>> On Sat, Dec 24, 2022 at 05:19:27PM +0100, Andy Shevchenko wrote:
>>=20
>>=20
>> L=C3=A4hetetty iPhonesta
>>=20
>>> Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
>>>=20
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it master
>>> head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
>>> commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO=
 registers on cascaded chips
>>> config: ia64-randconfig-m031-20221218
>>> compiler: ia64-linux-gcc (GCC) 12.1.0
>>>=20
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Reported-by: Dan Carpenter <error27@gmail.com>
>>>=20
>>> smatch warnings:
>>> drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divi=
de condition 'pin / 8' with 'pin >=3D 8'
>>> drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divi=
de condition 'pin / 8' with 'pin >=3D 8'
>>>=20
>>=20
>>=20
>>=20
>> I don=E2=80=99t think this is a good advice. If we want to limit that, we=
 need
>> to check also upper limit. But. The GPIO framework does that. So,
>> changing / to >=3D is bogus.
>=20
>=20
> How is checking pin / 8 not mathematically equivalent to pin >=3D 8?

The point is that semantically the / is better in case this code will ever s=
upport more than two banks of pins.


> I don't understand this code at all.  The divide is inscrutable  Is it
> storing something in in the lower 3 bits and something in bit 4?  In
> that case it might be nicer to just check (pin & BIT(4)).
>=20
> regards,
> dan carpenter
>=20
>>=20
>>=20
>>> vim +52 drivers/gpio/gpio-exar.c
>>>=20
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  47  static unsigned int
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  48  exar_offset_to_sel_ad=
dr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  49  {
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  50      unsigned int pin =3D=
 exar_gpio->first_pin + (offset % 16);
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  51      unsigned int casc=
aded =3D offset / 16;
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02 @52      unsigned int addr=
 =3D pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
>>>=20
>>> Why not change this to pin > 8 instead.  Comparisons are faster than
>>> divide ops.  Way more readable too.
>>>=20
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  53 =20
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  54      return addr + (ca=
scaded ? exar_gpio->cascaded_offset : 0);
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  55  }
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  56 =20
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  57  static unsigned int
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  58  exar_offset_to_lvl_ad=
dr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  59  {
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  60      unsigned int pin =3D=
 exar_gpio->first_pin + (offset % 16);
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  61      unsigned int casc=
aded =3D offset / 16;
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02 @62      unsigned int addr=
 =3D pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  63 =20
>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  64      return addr + (ca=
scaded ? exar_gpio->cascaded_offset : 0);
>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  65  }
>>>=20
>>> --=20
>>> 0-DAY CI Kernel Test Service
>>> https://01.org/lkp
>>>=20
