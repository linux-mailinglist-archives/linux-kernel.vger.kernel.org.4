Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBFE659048
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiL2SX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiL2SXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:23:23 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6047613FAF;
        Thu, 29 Dec 2022 10:23:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso3546641wmq.1;
        Thu, 29 Dec 2022 10:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/MTMhs2bRE0tnfF4cPhkn8pKgJ/TVN539Wzurs/nPN4=;
        b=kMKQXk6elGJ/w8abYvDklu3L3ZbUyVez6w9S3r23QALsFhY7YewVKy2hU73hSTAyPg
         nBSI0Kil9UDQeZH0uBw4imxDBMnf6SmJLb3G/iG0eqoIwNkOc6i9CA9KYoDfocJ3CCHt
         mMeS4m6KCY+K80jq810lthGtoVojAdmHfMyppVvE8JKuwN+nJd16pLAbQPnvpMRRb4m+
         PynzmH4gIQ7h6v81xU5Jy9rYdBTEyG1FRH7riYLQKa2GntkzJBCVWlqqMkfF6iH+/tlu
         tsjHDhFdJu1sa4vLHIzTB1NcG16ost13lx3hoVEvHfyVli4jivPQN9SQmPkZaP8dU2rR
         zeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MTMhs2bRE0tnfF4cPhkn8pKgJ/TVN539Wzurs/nPN4=;
        b=YhfGnl+uvMm5gUZABGdoLQaiZktLy478pmj/ALDCiSKAOcbctq97EM9cRc9Y+supex
         qDvkIZQiywbQEto/lWkJYTfJ2OlG0eZC3mC2aU6IOa71RadUoWhz3ZUdEB4abyv0ZgeC
         IDxUE7p/7vwd1O8wKyVM/HIV03l0JsiLQG8cpCz1iMldM1ENo3mHonhny4Yg2IGomgLE
         dPqM9RqJqhVp+rOZ7usHwqeHIeMRCB88JTSmPmVBuVARTm73nQj+09W4/Jjzevc9B+FV
         IBhF4bHItxJ1JjlkwfhkMHfkRzqc3LZtjb3ZJENloAItqjM7TMn51XK4ywRHST5kGkA7
         y1Hg==
X-Gm-Message-State: AFqh2kpsRJZWciAKNXZ1Qy9wb/jIQKDx0aNgNR3UzknsKzZVQkapPDb1
        borwRBxBWaFwkvRnb4eCdyVr27Hv9z0=
X-Google-Smtp-Source: AMrXdXtl1SqJ3LnxKAN/sV2iFfa1Rj2w5UqgI4vLFh+ROL9mNpn5r1tEtPqpPTgeMUvY9GknHMrj+Q==
X-Received: by 2002:a05:600c:2207:b0:3d2:24d2:d02b with SMTP id z7-20020a05600c220700b003d224d2d02bmr21127467wml.29.1672338197784;
        Thu, 29 Dec 2022 10:23:17 -0800 (PST)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003d23928b654sm33523421wms.11.2022.12.29.10.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 10:23:17 -0800 (PST)
Message-ID: <8c4826ea5698e4e1b2910f5b01e66a41970a8053.camel@gmail.com>
Subject: Re: [PATCH v2 3/5] iio: pressure: bmp280: Add support for new
 sensor BMP580
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        nikita.yoush@cogentembedded.com, paul@crapouillou.net,
        rafael.j.wysocki@intel.com, robh+dt@kernel.org,
        ulf.hansson@linaro.org
Date:   Thu, 29 Dec 2022 19:23:16 +0100
In-Reply-To: <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
         <c053976f56c3810915ca2ead6c358b5997b782e5.1672062380.git.ang.iglesiasg@gmail.com>
         <d0e98b2d-1c00-b7cc-d0b3-4477e27cf822@wanadoo.fr>
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

On Thu, 2022-12-29 at 18:35 +0100, Christophe JAILLET wrote:
> Le 26/12/2022 =C3=A0 15:29, Angel Iglesias a =C3=A9crit=C2=A0:
> > Adds compatibility with the new sensor generation, the BMP580.
> >=20
> > The measurement and initialization codepaths are adapted from
> > the device datasheet and the repository from manufacturer at
> > https://github.com/boschsensortec/BMP5-Sensor-API.
> >=20
> > Signed-off-by: Angel Iglesias
> > <ang.iglesiasg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >=20
>=20
> [...]
>=20
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp28=
0.h
> > index efc31bc84708..27d2abc17d01 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
>=20
> [...]
>=20
> > +#define BMP580_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x50
> > =C2=A0 #define BMP380_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00x50
>=20
> Hi,
>=20
> this is maybe correct (I've not been able to find the datasheet to check=
=20
> myself), but it looks odd to have the same ID for 2 different chips.

Yes, I also couldn't find a datasheet for the BMP580 or a devkit anywhere. =
I'm
developing this using the BMP581, which seems to be a variant almost identi=
cal.
Something similar happened with the BMP38x; you could find the BMP384 and t=
he
BMP388, but the BMP380 was unavailable everywhere, datasheet included. My g=
uess
is this is a similar situation. In any case, the datasheet of the BMP581 is
available here:
https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/b=
st-bmp581-ds004.pdf

Regarding the chip id being the same between generations is weird, but at l=
east
the datasheet and the sensor I have uses 0x50 as the chip id. After you
mentioned this, I checked back on the reference API repository from Bosch a=
nd it
has both 0x50 and 0x51 as valid IDs:
* https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5_defs.h=
#L198
* https://github.com/boschsensortec/BMP5-Sensor-API/blob/master/bmp5.c#L144=
4

Angel

> CJ
>=20
> > =C2=A0 #define BMP180_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00x55
> > =C2=A0 #define BMP280_CHIP_ID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A00x58
>=20

