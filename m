Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE06B04A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjCHKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjCHKg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:36:27 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F6A1FFB;
        Wed,  8 Mar 2023 02:36:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a25so64005375edb.0;
        Wed, 08 Mar 2023 02:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678271765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeODk5Q7NYOS/imm9Czy4q+bgK1nDPxP4eydX/OIrvg=;
        b=pPdmiBlX/sumOapYYZO0+01cOQzl7zjnLzxN4rm4L09iMOW+Zm9xhqYj9Kue8UDL2Q
         XXtjnODtS9Yik++o1x1MW7fxYbFgivspcMMkew38mSrxciJYsdmZWHUsPnyvQX75Ehgd
         5U4fztm38RfaQyuEY8vmKSb+byJNUAfDOafxVoOK+H/PHMJWH6e8X2eyXXTrzYtJUcF6
         +4pneT/JxFNVYyEeDWkipm05OXxRr/9w2XVmKX2Vdq2zNt18fIzSjdqUf2jtVeerZ5N+
         OhMo9AgCNdRxtvJDV3hQX0m0TEiQt4dheKCMnwAsbLS+UguOSBPwGyC409epjmHe9Igg
         QeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeODk5Q7NYOS/imm9Czy4q+bgK1nDPxP4eydX/OIrvg=;
        b=noFIQ5yeXmriH5FCrbiXabY/sUmyJtPcoq1xCWCSf+rKQRqqeAav4mqquLqpM3frMf
         hAtflGTDY2DNllyBmIcYd0MYQaFKvXKHeC6Ek97/Y4LtCHIzEXPJsXb0YotlcDP0JEPS
         fzuxBEdJbRS8ymFUm+3UP4VGhn/WkkwRERMdN/SXvSuAZnk7mhjYnCQBDfUdxwPwUVP6
         zfYyWeQoIuhLAGcCWb3G1CnmhuNFRAqNTZHqDI5nQffQ7lvPFQZ+6O3nbKj2QDBMPJGh
         wnMnujR7WN7qCpUXqmaQM3KGepczpvb6tCeI/TuOXIChjLVblU4dSat8Md0LEydVnBEt
         Kofg==
X-Gm-Message-State: AO0yUKUuFn8StLtrpithw+dU2f8RaSWtq4sGV3IsQUzwCylMjJSM+Vmf
        x+A65fRSUsXnFj0PbMdK5Z0OOyz55hwJN4+Qv2Q=
X-Google-Smtp-Source: AK7set8blTEg594OggQ+WxRJmvfiI3jG1BOskTjflPBcHHxz3kdHd9YSejZ8uxPVjf7U628nkWD1DimQc9rx6fxi7ig=
X-Received: by 2002:a17:906:60f:b0:8dd:70a:3a76 with SMTP id
 s15-20020a170906060f00b008dd070a3a76mr8949463ejb.11.1678271765265; Wed, 08
 Mar 2023 02:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-3-clamor95@gmail.com>
 <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org>
In-Reply-To: <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 12:35:54 +0200
Message-ID: <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 12:25 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
> > Some devices may need a specific supply provided
> > for this sensor to work properly, like p895 does.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/hwmon/ina2xx.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> > index 00fc70305a89..4a3e2b1bbe8b 100644
> > --- a/drivers/hwmon/ina2xx.c
> > +++ b/drivers/hwmon/ina2xx.c
> > @@ -119,6 +119,7 @@ struct ina2xx_data {
> >       long power_lsb_uW;
> >       struct mutex config_lock;
> >       struct regmap *regmap;
> > +     struct regulator *vdd_supply;
> >
> >       const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS]=
;
> >  };
> > @@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *client)
> >               return PTR_ERR(data->regmap);
> >       }
> >
> > +     data->vdd_supply =3D devm_regulator_get_optional(dev, "vdd");
> > +     if (IS_ERR(data->vdd_supply))
> > +             return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> > +                                  "failed to get vdd regulator\n");
> > +
> > +     ret =3D regulator_enable(data->vdd_supply);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to enable vdd power supply\n");
> > +             return ret;
>
> And where is disable? On each error path, removal etc.
>

error path ok, should I create a remove function just to disable the regula=
tor?

> Best regards,
> Krzysztof
>
