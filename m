Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C8C655AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLXQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiLXQTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:19:39 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D38AE77
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:19:37 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so10778579lfv.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 08:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FslJhWaKW9z5xwJZHpiYxxxEnIH3Sck+9I6M7FUPSoE=;
        b=mcnljUFcAe5KZayeSRFs++9drg3V3uq2kOj5pbTvJSUSFz6XSBlK+O2TBj2bnoekaq
         4db9ykhhPTY5ym91DKfOcHyLH7rkFTxwpeIC4LF0i3X2/wTwHLqClTfq6ERNNSfI/ZYH
         pbb53UVEYZ79dbyfLHssHjp7sA7M57fthItEJalbCCH6eyqRWHTpy/Xf5EfRXXdzCD/S
         Mey/3K+wH8DnobNJxGLTFehNSqawEW0cRrwi1pUd74htDmiJSvu2EQnbfQAFIxehN8bE
         F31NfU6U5wK1X8IcvF8cMOT2loaV9Q/GK8CoNxrmgT7GpQaNHvvqTLCUEX8vCmCsvKhd
         Ok5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FslJhWaKW9z5xwJZHpiYxxxEnIH3Sck+9I6M7FUPSoE=;
        b=lyx9f2ek8oXdhyHuBBA1UJGeRCn+xgQP7qlkXQZBv95EJl9/iffjdmpks3B3bEjtLC
         fU3jIkk/pAwa1zghmT29ntT+mUSHx9GDkpdHryOey9isi7z8XWmbYpKFln5K4Wnozyr6
         QWcN7+rMmW6vKaEa5Os+Yrr0JNTCdt3ZSO5pjlOS7uXTTJG/5gTOyRw4zXDX5y9wRCXd
         tfdbhy+e4aQrxt8/+6kqViIFlmzonaq+hVQZO8/xQ8Qb8co3SoR4r02y0bBgqsDmucV5
         lJrbH4cjJwvJ9aBkQoLabOCtvoI3BWQJUAFqt+zk949/MlzgrZyz9oSXXyeRQiFzBX9h
         GCxQ==
X-Gm-Message-State: AFqh2kr9R5/JzEurS42TjJ047ViX+tlv+0sqoNm/hNWlvW/+SeDUazUv
        /qflZZvWnvya1JxIACd9neNQIzr8rTxaOfuN
X-Google-Smtp-Source: AMrXdXv94BsWqbTejL34QeaaLX+14f+sFMTVy0R4Cj2w2DthPksO8V5wLzTQYMNoYqFXub3hNjPk5A==
X-Received: by 2002:ac2:5f49:0:b0:4b6:ebbc:3d3a with SMTP id 9-20020ac25f49000000b004b6ebbc3d3amr3274090lfz.53.1671898776135;
        Sat, 24 Dec 2022 08:19:36 -0800 (PST)
Received: from [10.0.207.73] ([185.32.8.213])
        by smtp.gmail.com with ESMTPSA id z9-20020a056512370900b004b55c1b5c66sm992326lfr.157.2022.12.24.08.19.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Dec 2022 08:19:31 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide condition 'pin / 8' with 'pin >= 8'
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
X-Mailer: iPhone Mail (16H71)
In-Reply-To: <202212181140.EAWl7FKx-lkp@intel.com>
Date:   Sat, 24 Dec 2022 17:19:27 +0100
Cc:     oe-kbuild@lists.linux.dev, Qingtao Cao <qingtao.cao.au@gmail.com>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D147284-AF8C-4414-9BE1-C83032B6C15D@gmail.com>
References: <202212181140.EAWl7FKx-lkp@intel.com>
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

> Dan Carpenter <error27@gmail.com> kirjoitti 23.12.2022 kello 11.54:
>=20
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
 master
> head:   f9ff5644bcc04221bae56f922122f2b7f5d24d62
> commit: 5134272f9f3f71d4e1f3aa15cb09321af49b3646 gpio: exar: access MPIO r=
egisters on cascaded chips
> config: ia64-randconfig-m031-20221218
> compiler: ia64-linux-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> smatch warnings:
> drivers/gpio/gpio-exar.c:52 exar_offset_to_sel_addr() warn: replace divide=
 condition 'pin / 8' with 'pin >=3D 8'
> drivers/gpio/gpio-exar.c:62 exar_offset_to_lvl_addr() warn: replace divide=
 condition 'pin / 8' with 'pin >=3D 8'
>=20



I don=E2=80=99t think this is a good advice. If we want to limit that, we ne=
ed to check also upper limit. But. The GPIO framework does that. So, changin=
g / to >=3D is bogus.


> vim +52 drivers/gpio/gpio-exar.c
>=20
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  47  static unsigned int
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  48  exar_offset_to_sel_addr=
(struct exar_gpio_chip *exar_gpio, unsigned int offset)
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  49  {
> 5134272f9f3f71 Qingtao Cao         2022-09-02  50      unsigned int pin =3D=
 exar_gpio->first_pin + (offset % 16);
> 5134272f9f3f71 Qingtao Cao         2022-09-02  51      unsigned int cascad=
ed =3D offset / 16;
> 5134272f9f3f71 Qingtao Cao         2022-09-02 @52      unsigned int addr =3D=
 pin / 8 ? EXAR_OFFSET_MPIOSEL_HI : EXAR_OFFSET_MPIOSEL_LO;
>=20
> Why not change this to pin > 8 instead.  Comparisons are faster than
> divide ops.  Way more readable too.
>=20
> 5134272f9f3f71 Qingtao Cao         2022-09-02  53 =20
> 5134272f9f3f71 Qingtao Cao         2022-09-02  54      return addr + (casc=
aded ? exar_gpio->cascaded_offset : 0);
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  55  }
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  56 =20
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  57  static unsigned int
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  58  exar_offset_to_lvl_addr=
(struct exar_gpio_chip *exar_gpio, unsigned int offset)
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  59  {
> 5134272f9f3f71 Qingtao Cao         2022-09-02  60      unsigned int pin =3D=
 exar_gpio->first_pin + (offset % 16);
> 5134272f9f3f71 Qingtao Cao         2022-09-02  61      unsigned int cascad=
ed =3D offset / 16;
> 5134272f9f3f71 Qingtao Cao         2022-09-02 @62      unsigned int addr =3D=
 pin / 8 ? EXAR_OFFSET_MPIOLVL_HI : EXAR_OFFSET_MPIOLVL_LO;
> 5134272f9f3f71 Qingtao Cao         2022-09-02  63 =20
> 5134272f9f3f71 Qingtao Cao         2022-09-02  64      return addr + (casc=
aded ? exar_gpio->cascaded_offset : 0);
> 696868d0a79c21 Bartosz Golaszewski 2020-09-30  65  }
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
>=20
