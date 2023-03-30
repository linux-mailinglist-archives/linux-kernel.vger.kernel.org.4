Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508936CFD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC3Hnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC3Hnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:43:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716546E93;
        Thu, 30 Mar 2023 00:43:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id t10so72809259edd.12;
        Thu, 30 Mar 2023 00:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680162214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/5McHHU9pEkMitY9q9hIhM5uXbKy/aKadv++MdbkcNI=;
        b=GypdNq1aOu9V+5qSsEhe/jbUnH4w6UiVyCT9o3OcNLfy1Ra2Cb5FW9Yi7/Qnk5C/Km
         fk/cVm9eJB/YaSXtPYI9AthOTMeVmrPupWUH+v2UMx9ji6BUU95DQTQfTeQ+A1xQkG7O
         fQmxUS4sUEQiYfMYMzIrue4lI49VcU2EkIS/Ady0wArj9l4W/haYwEqM5zVFibzwNHjg
         gmhYvyK/fhXRZCieXhVTtx8eBqIIHFOGcfWL+zrWlOhs66rZp8lthAkO2RUJpcIdlnJT
         ZgbBm+RTz32HBuYSXv8IZzKJduzt8Dlf5eeZRigAX78x3zKPFqhyc/WtKGYpflV58jbt
         Zpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162214;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/5McHHU9pEkMitY9q9hIhM5uXbKy/aKadv++MdbkcNI=;
        b=Cw3aXmKFWPhSQaa/RZZDPBXK2dGgkLIQmLUrNefgK8YEWpTmkQa686c3ZyFJqMu64D
         kheEXgPZ6hDtB6HufqHiOOEwSoPtK4YrhG2hJWuNpLYOeXdECBe7TMd5m9gg53Kzq2Jm
         LRSwzWGEmlb/azupW+H5hssIjLrEAx10Adk7dd8jjxXZgGPs+zHUe4YqlC6w4YgL04Ux
         YVpbGhnDdbBEKKjZ9xFpOKYIAQzWiYYGobyGKB3aPu9uvmRjCm4mx9z7FcDy019IZXXr
         V5bgrAxMbcbCTzRCil81A0Rn5PjiNQKHX7a3LRtbL9FGezpfVEZ9vs0Q/O9Y2DsaQlmQ
         CumQ==
X-Gm-Message-State: AAQBX9fwwHpC7kBZo0L8VGB3EfwZdqygLswZCkPWjZ1El58YnZ8fhJnk
        Q7GcAlK2Iz/pRjHtvmtA0CEyCv4PkmNOhQwb5Jk=
X-Google-Smtp-Source: AKy350bgP8iVheLUfsfUMKas/NP5UKRrs/yRXoj8E3n1XC+ufUtJhoSIhdBAXxpzmpRuitYHzaFUmQ==
X-Received: by 2002:a17:907:6d24:b0:947:40e6:fde3 with SMTP id sa36-20020a1709076d2400b0094740e6fde3mr2587054ejc.35.1680162213707;
        Thu, 30 Mar 2023 00:43:33 -0700 (PDT)
Received: from ?IPv6:2001:a61:2b4b:9d01:5416:2b94:da5d:3156? ([2001:a61:2b4b:9d01:5416:2b94:da5d:3156])
        by smtp.gmail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm17850126edi.45.2023.03.30.00.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 00:43:33 -0700 (PDT)
Message-ID: <be16ef0f88e74e3dc25d6ba08f384eb182ddd240.camel@gmail.com>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Sahin, Okan" <Okan.Sahin@analog.com>
Cc:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
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
Date:   Thu, 30 Mar 2023 09:43:32 +0200
In-Reply-To: <ZCRG9uilzFjkAtsJ@smile.fi.intel.com>
References: <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCLi6MB/aHIf4lMr@smile.fi.intel.com>
         <cdd53e29ca3d8dbfdfa1a2520935e2bf9418313d.camel@gmail.com>
         <d2bed74b-9eb9-45af-8f45-ad2c2889024a@sirena.org.uk>
         <fc07de9af0b691fbd3a5915c8293f0c7ad4c4e06.camel@gmail.com>
         <ZCL7J5a7UZVayQVS@smile.fi.intel.com>
         <60bbad1b38b8e3c9c3efefb0fb7b8d3cad7fa98c.camel@gmail.com>
         <ZCMMHl5ENSuCstFV@smile.fi.intel.com>
         <MN2PR03MB51688CAF5DDF0628ED6B0B06E7889@MN2PR03MB5168.namprd03.prod.outlook.com>
         <ZCRGa76BqswH7Bez@smile.fi.intel.com> <ZCRG9uilzFjkAtsJ@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
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

On Wed, 2023-03-29 at 17:11 +0300, Andy Shevchenko wrote:
> On Wed, Mar 29, 2023 at 05:08:44PM +0300, Andy Shevchenko wrote:
> > On Tue, Mar 28, 2023 at 04:01:21PM +0000, Sahin, Okan wrote:
> > > > On Tue, Mar 28, 2023 at 04:51:18PM +0200, Nuno S=C3=A1 wrote:
> > > > > On Tue, 2023-03-28 at 17:35 +0300, Andy Shevchenko wrote:
> > > > > > On Tue, Mar 28, 2023 at 04:18:30PM +0200, Nuno S=C3=A1 wrote:
> > > > > > > On Tue, 2023-03-28 at 14:46 +0100, Mark Brown wrote:
> > > > > > > > On Tue, Mar 28, 2023 at 03:26:44PM +0200, Nuno S=C3=A1
> > > > > > > > wrote:
> > > > > > > >=20
> > > > > > > > > IIRC, regmap_read() is not really reentrant and it is
> > > > > > > > > used in
> > > > > > > > > the IIO driver on the sysfs interface. So, yeah, I
> > > > > > > > > think you
> > > > > > > > > need the regmap lock and better just leave the config
> > > > > > > > > as is.
> > > > > > > > > Yes, the lock is
> > > > > > > > > opt-
> > > > > > > > > out
> > > > > > > > > so let's not disable it :)
> > > > > > > >=20
> > > > > > > > All the regmap operations are fully thread safe.
> > > > > > >=20
> > > > > > > Even if 'config->disable_locking' is set? I think that is
> > > > > > > what's
> > > > > > > being discussed in here...
> > > > > >=20
> > > > > > In case the driver has its own lock to serialize IO how on
> > > > > > earth the
> > > > > > regmap lock is needed. That's what I asked the author of
> > > > > > the driver.
> > > > > > He told the code
> > > > >=20
> > > > > Well, if the driver has it's own locking, then sure we do not
> > > > > need
> > > > > regmap's lock...
> > > > >=20
> > > > > > doesn't require the regmap lock, and I tend to believe the
> > > > > > author.
> > > > > > So, why to
> > > > > > keep it?
> > > > >=20
> > > > > However, if you look at the adc driver, I can see plain
> > > > > regmap_read()
> > > > > calls without any "outside" locking.
> > > >=20
> > > > Then author of the code should know what they are doing. Right?
> >=20
> > > Actually, I do not want to disable regmap lock that's why I did
> > > not update it.
> >=20
> > If you have something like=20
> >=20
> > func1()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_read(reg1)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0regmap_read/write(reg2)
> >=20

I would also add that as soon as you have more than one access to
regmap (or spi, or i2c...) in one func and that function is accessible
through sysfs (and likely any other userspace interface), then you
should already take care. So, it might be even the case that func1()
and func2() don't have to run in parallel.

- Nuno S=C3=A1
>=20
