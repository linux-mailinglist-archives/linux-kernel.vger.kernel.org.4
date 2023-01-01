Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE965A9BB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 12:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjAALQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 06:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjAALQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 06:16:33 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDA626ED;
        Sun,  1 Jan 2023 03:16:31 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bs20so21773642wrb.3;
        Sun, 01 Jan 2023 03:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DohetCaml00wlk7F6nBCpFTgHCeu68qAGTRRsdfvvGw=;
        b=N2FoHfpC/gYxAhABdvGWZlJw1fzzJLSnVqwQ8pWPZYeUh2WKuKccdODIg3PlAOTpj1
         5z+VAEwa98XZwO9c0keyw8+dfxxr/QHSjoT6knOpjZMO5JUxMSjqdW/QuKLk+fDP0yG7
         l/M5rfXYQWGoLOL4F/q0PRMMm2GnOHYfmUV4WdTMhfFacKgQbGs7lrgR6ENFh3oEdLn+
         ZU1ILrqsSDTodTKl3LPTuxE94EMJ5BCTH4hUa3GVBG4BmumF4XgkkL8s15lyf7wKwWff
         1WV2VubYjPasY3DPNW2L/ZA7Iy36Mph/jaHyRl1/HuRy3e6L6xaz8dqQMNX4MohuDaY4
         Fpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DohetCaml00wlk7F6nBCpFTgHCeu68qAGTRRsdfvvGw=;
        b=fS7ToD28VJBUEzVFCyWGLFq9eMlvo/7c9Ood7IRnze4ekhflh1/gwgYD79AEoYB9Ap
         czHQNXMmLZKnwHY/cl2CBvzOmvqm4t01k5NG7IUsGLjjpaHKK6DS5lEix1K+qZGn5S22
         kCKzt/M4JuFHO3UE2hOkClZ/wa8zOuWPbTClaoJEf4ff4N2mfvPzRFwKMgk+soMlpzPZ
         VWfWCQTXRu0RcEC7YjaW8B+2ARdgqJkQjJXNWzAhaGW76sWYBARLcpXLbRAOlCm/i5jO
         YPCUFW75VwjdAYqw5CoJM4H1WBT7QYlV/76CU+sraAjyZo9MKhrUqAmrLYnQRXzbhwQw
         P93Q==
X-Gm-Message-State: AFqh2kpGe1bdNFHqKnAKxU7sQhsWX+jHkEW/FZQClEu3Gxg66lW7JgO8
        qBD8GVJgP5D2eXud/IE6NcQ=
X-Google-Smtp-Source: AMrXdXvOph/bVkqhHqIsKEGjNzeEWVEJlHkVJc7nl60IGr844j8ILYHbEQdwM183l+rrx99X9HX06g==
X-Received: by 2002:a5d:6d0f:0:b0:28b:456c:1b6d with SMTP id e15-20020a5d6d0f000000b0028b456c1b6dmr12197004wrq.55.1672571790148;
        Sun, 01 Jan 2023 03:16:30 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id r13-20020adfa14d000000b002779dab8d85sm22119553wrr.8.2023.01.01.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 03:16:29 -0800 (PST)
Message-ID: <0f86cf66a14b4d5900ddee68cd7b49807128b7e9.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, nikita.yoush@cogentembedded.com,
        paul@crapouillou.net, rafael.j.wysocki@intel.com,
        robh+dt@kernel.org, ulf.hansson@linaro.org
Date:   Sun, 01 Jan 2023 12:16:28 +0100
In-Reply-To: <20221230182253.45fcfdf4@jic23-huawei>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
         <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
         <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
         <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
         <20221230182253.45fcfdf4@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-30 at 18:22 +0000, Jonathan Cameron wrote:
> On Thu, 29 Dec 2022 19:23:16 +0100
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>=20
> > On Thu, 2022-12-29 at 18:35 +0100, Christophe JAILLET wrote:
> > > Le 26/12/2022 =C3=A0 15:29, Angel Iglesias a =C3=A9crit=C2=A0:=C2=A0=
=20
> > > > Adds compatibility with the new sensor generation, the BMP580.
> > > >=20
> > > > The measurement and initialization codepaths are adapted from
> > > > the device datasheet and the repository from manufacturer at
> > > > https://github.com/boschsensortec/BMP5-Sensor-API.
> > > >=20
> > > > Signed-off-by: Angel Iglesias
> > > > <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > =C2=A0=20
> > >=20
> > > [...]
> > > =C2=A0=20
> > > > diff --git a/drivers/iio/pressure/bmp280.h
> > > > b/drivers/iio/pressure/bmp280.h
> > > > index efc31bc84708..27d2abc17d01 100644
> > > > --- a/drivers/iio/pressure/bmp280.h
> > > > +++ b/drivers/iio/pressure/bmp280.h=C2=A0=20
> > >=20
> > > [...]
> > > =C2=A0=20
> > > > +#define BMP580_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50
> > > > =C2=A0 #define BMP380_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50=C2=A0=20
> > >=20
> > > Hi,
> > >=20
> > > this is maybe correct (I've not been able to find the datasheet to ch=
eck=20
> > > myself), but it looks odd to have the same ID for 2 different chips.=
=C2=A0=20
> >=20
> > Yes, I also couldn't find a datasheet for the BMP580 or a devkit anywhe=
re.
> > I'm
> > developing this using the BMP581, which seems to be a variant almost
> > identical.
> > Something similar happened with the BMP38x; you could find the BMP384 a=
nd
> > the
> > BMP388, but the BMP380 was unavailable everywhere, datasheet included. =
My
> > guess
> > is this is a similar situation. In any case, the datasheet of the BMP58=
1 is
> > available here:
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bmp581-ds004.pdf
> >=20
> > Regarding the chip id being the same between generations is weird, but =
at
> > least
> > the datasheet and the sensor I have uses 0x50 as the chip id. After you
> > mentioned this, I checked back on the reference API repository from Bos=
ch
> > and it
> > has both 0x50 and 0x51 as valid IDs:
> > *
> > https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5_defs=
.h#L198
> > * https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5.c#=
L1444
> https://github.com/boschsensortec/BMP3-Sensor-API/blob/master/bmp3_defs.h
> I was curious on whether we had a wrong value for bmp380, but nope... Sam=
e ID.
>=20
> Huh. As per earlier comment - who wants to moan at Bosch as this is crazy
> situation?
>=20
> Jonathan

Well I'm doing this in my free time beacuse I wanted to setup a meteo stati=
on
and got annoyed needing to patch-up userspace code for reading pressure and
temperature sensors on a very underpowered ARM device when there is a kerne=
l
subsystem for this kind of things. The rest is history on the mailing list.
I don't think I have any leverage to have Bosch listening to my complaints

Angel

>=20
> >=20
> > Angel
> >=20
> > > CJ
> > > =C2=A0=20
> > > > =C2=A0 #define BMP180_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x55
> > > > =C2=A0 #define BMP280_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x58=C2=A0=20
> > > =C2=A0=20
> >=20
>=20

