Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E43655CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 12:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiLYLvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 06:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLYLu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 06:50:58 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EA4B3E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:50:52 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id s22so9351368ljp.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 03:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlnLyJ2BHwOq0v6YM5eXS65npGm8qINlxvZC0I9lVgQ=;
        b=KOqteYkKtgJyR7TLsHd/wtr0yFSNfCI7LJtbi9Wlvv5KF6a0t/eXNn1I7Roio0Scku
         zNS2DGEaTz8AGBPLyxNItIrD8GNHNd0DlMWT74LWYXLYXVycJOljbXNDdj9LkpjVgrlr
         AuWUuhzEas2Y1VMrEgLemv5neOV+jEkICHzacQ7nYrTx8pN61PMr41cSQY7iq3mNjaxn
         qg91Dl4xt7E/+E7VL/mNEYIQIo7AVoG+4MoA5pD09aLogjvZdqFj1C/9JtMUyZvuym1T
         L56tniLHtEPckCPXgBMqzCp6qWO096my1InWmhbPOfsO2AuyCIEOV3232g//OfmPzhHr
         YMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlnLyJ2BHwOq0v6YM5eXS65npGm8qINlxvZC0I9lVgQ=;
        b=qOqLOip2pn6d76IQtCpvpRPhlKuwTJIo3XGn9bOI6HyvblUAmaZ1vzK00/evcyKhZ1
         9aynU/NF/cicY2iLX6uypTzRceIN4yj7qt2BoGopvWFWIGUcasuAUOzHF3Mv7myoAAAK
         /P9qnHd8M8z22NNPPpm7ElN37eoaWcAoEy0IdAizpAJD307Ajublbr7VtsUU1L3uBuWt
         ZWKJWNvJpbLwrCo+i8Xf7vAPtyDGlWqXk2kxR0dPTdq3W2E3tHk/Y7mPk7IDubiUwt9t
         BpYgHhk9nDkgm8DzII8T07LF2QxedQDBraidZcFZ/jjm/R0OBEoG/BUS4zyyijTVbSno
         RhEw==
X-Gm-Message-State: AFqh2kqCmBZAZuSIH2hHY8H/aKwPT9qN07mgN3jqpSuWA+qXWRGUl9I6
        gYS+YCI3SCpH5KBZq0IooAyo4B/uThCp+Q==
X-Google-Smtp-Source: AMrXdXtpqOE8xzMIpqCUQKOF5Tiwvjms5Ci7tnoMpNH9CEC1oMyD5hsNVBnD033CgGolSrP4plkqHg==
X-Received: by 2002:a2e:8244:0:b0:276:dc01:8058 with SMTP id j4-20020a2e8244000000b00276dc018058mr4260997ljh.1.1671969050971;
        Sun, 25 Dec 2022 03:50:50 -0800 (PST)
Received: from [10.0.207.73] ([185.32.8.213])
        by smtp.gmail.com with ESMTPSA id bj31-20020a2eaa9f000000b0027facd123a0sm959608ljb.106.2022.12.25.03.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Dec 2022 03:50:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: iPhone Mail (16H71)
In-Reply-To: <F701A496-22A6-4E3B-B3CB-E5BCF4C30502@gmail.com>
Date:   Sun, 25 Dec 2022 12:50:46 +0100
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C430F7E6-723B-4EA8-BA87-00C84676BD4F@gmail.com>
References: <202212181140.EAWl7FKx-lkp@intel.com> <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com> <Y6dTX2wx/SXlswGC@kadam> <F701A496-22A6-4E3B-B3CB-E5BCF4C30502@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



L=C3=A4hetetty iPhonesta

> Andy Shevchenko <andy.shevchenko@gmail.com> kirjoitti 25.12.2022 kello 12.=
45:
>=20
>=20
>=20
> L=C3=A4hetetty iPhonesta
>=20
>>> Dan Carpenter <error27@gmail.com> kirjoitti 24.12.2022 kello 20.30:
>>>=20
>>> On Sat, Dec 24, 2022 at 05:19:27PM +0100, Andy Shevchenko wrote:
>>>=20
>>>=20
>>> L=C3=A4hetetty iPhonesta
>>>=20
>>>> Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
>>>>=20
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
>>>> head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
>>>> commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPI=
O registers on cascaded chips
>>>> config: ia64-randconfig-m031-20221218
>>>> compiler: ia64-linux-gcc (GCC) 12.1.0
>>>>=20
>>>> If you fix the issue, kindly add following tag where applicable
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>> | Reported-by: Dan Carpenter <error27@gmail.com>
>>>>=20
>>>> smatch warnings:
>>>> drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace div=
ide condition 'pin / 8' with 'pin >=3D 8'
>>>> drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace div=
ide condition 'pin / 8' with 'pin >=3D 8'
>>>>=20
>>>=20
>>>=20
>>>=20
>>> I don=E2=80=99t think this is a good advice. If we want to limit that, w=
e need
>>> to check also upper limit. But. The GPIO framework does that. So,
>>> changing / to >=3D is bogus.
>>=20
>>=20
>> How is checking pin / 8 not mathematically equivalent to pin >=3D 8?
>=20
> The point is that semantically the / is better in case this code will ever=
 support more than two banks of pins.

On top of that it=E2=80=99s paired with pin % 8.


>=20
>> I don't understand this code at all.  The divide is inscrutable  Is it
>> storing something in in the lower 3 bits and something in bit 4?  In
>> that case it might be nicer to just check (pin & BIT(4)).
>>=20
>> regards,
>> dan carpenter
>>=20
>>>=20
>>>=20
>>>> vim +52 drivers/gpio/gpio-exar.c
>>>>=20
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  47  static unsigned int
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  48  exar_offset_to_sel_a=
ddr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  49  {
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  50      unsigned int pin=
 =3D exar_gpio->first_pin + (offset % 16);
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  51      unsigned int cas=
caded =3D offset / 16;
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02 @52      unsigned int add=
r =3D pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
>>>>=20
>>>> Why not change this to pin > 8 instead.  Comparisons are faster than
>>>> divide ops.  Way more readable too.
>>>>=20
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  53 =20
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  54      return addr + (c=
ascaded ? exar_gpio->cascaded_offset : 0);
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  55  }
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  56 =20
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  57  static unsigned int
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  58  exar_offset_to_lvl_a=
ddr(struct exar_gpio_chip *exar_gpio, unsigned int offset)
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  59  {
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  60      unsigned int pin=
 =3D exar_gpio->first_pin + (offset % 16);
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  61      unsigned int cas=
caded =3D offset / 16;
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02 @62      unsigned int add=
r =3D pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  63 =20
>>>> 5134272f9f3f71 Qingtao Cao         2022-09-02  64      return addr + (c=
ascaded ? exar_gpio->cascaded_offset : 0);
>>>> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  65  }
>>>>=20
>>>> --=20
>>>> 0-DAY CI Kernel Test Service
>>>> https://01.org/lkp
>>>>=20
