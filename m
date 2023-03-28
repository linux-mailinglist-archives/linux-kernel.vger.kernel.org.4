Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9A6CC0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjC1NY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjC1NYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:24:48 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D222C162;
        Tue, 28 Mar 2023 06:24:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so49629438edb.7;
        Tue, 28 Mar 2023 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KWs/7qE29dhX0C1aUgCVlOHp1vpOTI4G8XwllRUWlQ=;
        b=nPcmCxPpuEGMnayu2JBOM6USR1geb8exzybI185mDnxflIoyxplHa1lzYQPRfOO8Fa
         NQ+r3o9Fq5EkxdgNiNdySxaCd22UnNvuRvqcWGCUkl0OJCfjBc0XHQaLlA/jBa7RUFKY
         d/4zktWvdMSztnZK6kO1mZnfMUwDx2Wkry5Bcdi8Sd45+E5Aaxf9L1wcOCnurHm3Ddal
         hiM0LX2JdLAddy8zFVZ1OSp40JiW+0yWsPefkhyggyI0cj4i9YpeKAhonKRhso1T07ZR
         gJFVuMAG/nnh5bTRPuFrzj/vqrp7raPLVYBD/4s4B/nNLDYY/lpOJ4Ry7GbNwcuAiu96
         X0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KWs/7qE29dhX0C1aUgCVlOHp1vpOTI4G8XwllRUWlQ=;
        b=rytMxc6nRNSZ4d3eyNreOnaJ4B7qkDCHxvJTrZe3AvNfJM5kQ9J2oe8atc0UcTZf3l
         fSzAZ/PGe1YbuapOGLjZfbdDKsJrhbTGMc58FdOsZ9t45eHbwSFs5XnVP0AGNoq/TQHJ
         NmEqno54VpDb3BXxk1Ki2J+vHu+/pFVPZAYodw2wpjBzx6I1RiASW1knWI9U0afEiaHR
         yMgtVI3tAsXP32vQpS7NzxtfiZ5r/+G+o+QX1RhtKPFxrR9c0My3Ij2d7/Wq20ly14dM
         D3k5ZOeowHJP6WIjm7CO9Krzn+9Ep1S46i4MVFp1m5KkkKTJ1uMY7mX6f3LcT9ShrXtS
         iZqw==
X-Gm-Message-State: AAQBX9ezvpDo7RHRaT64q6+n7N1YQE658wPi36KZzPIc/CaEfNU8EZuj
        9abcplZfD8jC3lgmJDcl6R8=
X-Google-Smtp-Source: AKy350ZMjyewdCvMumQJ9VaaGx0l2rpgx1eEAcfy90fSQ2qGqG5DS1yACXK+4keMTCWil9yR8e8YyQ==
X-Received: by 2002:aa7:d885:0:b0:4fd:2155:74ef with SMTP id u5-20020aa7d885000000b004fd215574efmr15750497edq.19.1680009880722;
        Tue, 28 Mar 2023 06:24:40 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef05:8700:853c:3ba5:d710:3c1d? (p200300f6ef058700853c3ba5d7103c1d.dip0.t-ipconnect.de. [2003:f6:ef05:8700:853c:3ba5:d710:3c1d])
        by smtp.gmail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm15674860edf.63.2023.03.28.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:24:40 -0700 (PDT)
Message-ID: <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date:   Tue, 28 Mar 2023 15:26:44 +0200
In-Reply-To: <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
         <20230307112835.81886-6-okan.sahin@analog.com>
         <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
         <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-28 at 15:51 +0300, Andy Shevchenko wrote:
> On Tue, Mar 28, 2023 at 08:26:41AM +0000, Sahin, Okan wrote:
> > > On Wed, 15 Mar 2023, Lee Jones wrote:
> > > > On Tue, 07 Mar 2023, Okan Sahin wrote:
>=20
> ...
>=20
> > For previous patch(v5), There was feedback from Andy. I did not fix
> > them.=20
>=20
> Why not? :-)
>=20
> > 1)=20
> > > They have same regmap except for ADC part of MAX77541.
> >=20
> > Extra space in the Subject.
> >=20
> > ...
> >=20
> > > +#include <linux/of_device.h
> >=20
> > This is my fault, I missed this comment. I will fix in following
> > patch(v7).
> >=20
> > 2)
> > ...
> >=20
> > > +static const struct regmap_config max77541_regmap_config =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.reg_bits=C2=A0=C2=A0 =3D =
8,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.val_bits=C2=A0=C2=A0 =3D =
8,
> >=20
> > Do you need lock of regmap?
> >=20
> > > +};
> >=20
> > ...
> >=20
> > Since I do not need lock of regmap, I did not change anything in
> > regmap_config (v6). Do I need to answer this question even if I
> > don't need
> > lock of regmap?
>=20
> IIRC the lock is opt-out. You need to explicitly disable it if not
> needed.
>=20

IIRC, regmap_read() is not really reentrant and it is used in the IIO
driver on the sysfs interface. So, yeah, I think you need the regmap
lock and better just leave the config as is. Yes, the lock is opt-out
so let's not disable it :)

- Nuno S=C3=A1
