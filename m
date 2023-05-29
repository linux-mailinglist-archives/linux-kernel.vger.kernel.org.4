Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0037146CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjE2JDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjE2JCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:02:55 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82225E8;
        Mon, 29 May 2023 02:02:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-75cbd6f9577so144149985a.2;
        Mon, 29 May 2023 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685350972; x=1687942972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlbILOfGwHHcm72NT7ycsjpiiLYUdGgHDOJzvZ5rU00=;
        b=kQ81YS55kmtiXc3ilGdE12xEke0hqdJ+vjl4WQsyB9kGFpuVPgk2/s+NiLOgH4p3Rg
         v9115wpuN5uL5QLLTPTu8T5S7x/kCp0ZNg4oXHH9xHLzWDhJklw9RWYe/sDw33JA9ARo
         40xwQWc9HD3G8kkBffg3ktKQqbmxmZwaaDnxAYjlKrI4Qb5AIoadWB0GYex9dMvn4l4m
         CHNatENoSKI4PfDGfd4JEXYH8sh5VvexOePOSYQuaDvgJ5RTScymOrzXR9XNq05OFRc1
         /gvFOv3p31Hrk/v2xSjCaFDBlvoHQt1ItAbdHv4R/jL8HE4ReIjfhhIN9oS6YwjqY6v1
         QG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685350972; x=1687942972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlbILOfGwHHcm72NT7ycsjpiiLYUdGgHDOJzvZ5rU00=;
        b=YI0LMvz6bzrfCs+odblmOgSSwK79aaR39MswSXiWPhbBeNd4HJr2eVxyGeOGbumqAm
         /q22jqWAB1C526vLSF93NdMMeZfCA3IBFdfTYa/Twn0tpjlZEE6anOs4sdl7b8Kmh/LS
         754Q+TWXCUPr7HLofUzQCJMLBhe1U+0dh8dTKcV+dGVIxS2RmTAZ0K2AF7XPL6xYS6g/
         vEjmHr0zgy/S4hNFlPW9ozETkPomVG66zSn3f3zzvVI6T/94HrFkFtRKpFPFtmoKwKvE
         UqsOYkgqhZKjWKrLH5b4g1AB2p2+QYQgC7Dor818ur+zynqZgq+Ow3kFxWGkxWYA7hTS
         RJYg==
X-Gm-Message-State: AC+VfDxbdjcq/nBSr/HQuPyHcgkuADoWR/K6/H1SLRVMZWFz+HG5SFXr
        NRC8i2Vg5VysNVjszmB+t15K1mzcgyPeQi1cA74=
X-Google-Smtp-Source: ACHHUZ4ay/oKD4J+lYY0OdaVXdsz7oc126FLvXOCQWwRoF5VO207cVZepKbQ82I9EZUsEaMQpvDL9yFjHIB2hLTaD70=
X-Received: by 2002:a05:6214:ac7:b0:621:4669:c806 with SMTP id
 g7-20020a0562140ac700b006214669c806mr13088784qvi.37.1685350972503; Mon, 29
 May 2023 02:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230522142621.1680563-1-astrid.rost@axis.com>
 <20230522142621.1680563-5-astrid.rost@axis.com> <ZHPZlA5LM5h4xmp3@surfacebook>
 <ca146ce1-d3d3-e5eb-ac44-3afaec8ca6cc@axis.com>
In-Reply-To: <ca146ce1-d3d3-e5eb-ac44-3afaec8ca6cc@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 May 2023 12:02:16 +0300
Message-ID: <CAHp75VdZAGhrXgYf5EOE6MQ4DiseaxOqkjUs+X9jROB1aonD_g@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] iio: light: vcnl4000: add illuminance irq vcnl4040/4200
To:     Astrid Rost <astridr@axis.com>
Cc:     Astrid Rost <astrid.rost@axis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 10:41=E2=80=AFAM Astrid Rost <astridr@axis.com> wro=
te:
> Thanks for reviewing.
> I can change this. But this is how it gets formatted by .clang-format.

I would suggest to report the bug (in case it's not configurable) or
configure to avoid such a misindentation.

> On 5/29/23 00:45, andy.shevchenko@gmail.com wrote:
> > Mon, May 22, 2023 at 04:26:18PM +0200, Astrid Rost kirjoitti:
> >> Add support to configure ambient light sensor interrupts and threshold
> >> limits for vcnl4040 and vcnl4200. If an interrupt is detected an event
> >> will be pushed to the event interface.
> >
> > ...
> >
> >> +            case IIO_EV_DIR_RISING:
> >> +                    ret =3D i2c_smbus_write_word_data(
> >> +                            data->client, VCNL4040_ALS_THDH_LM, val);
> >
> > Strange indentation.
> >
> >> +                    break;
> >> +            case IIO_EV_DIR_FALLING:
> >> +                    ret =3D i2c_smbus_write_word_data(
> >> +                            data->client, VCNL4040_ALS_THDL_LM, val);
> >
> > Same.
> >
> >> +                    break;
> >
> > ...
> >
> >> +    case IIO_PROXIMITY:
> >> +            switch (dir) {
> >> +            case IIO_EV_DIR_RISING:
> >> +                    ret =3D i2c_smbus_write_word_data(
> >> +                            data->client, VCNL4040_PS_THDH_LM, val);
> >
> > Same.
> >
> >> +                    break;
> >> +            case IIO_EV_DIR_FALLING:
> >> +                    ret =3D i2c_smbus_write_word_data(
> >> +                            data->client, VCNL4040_PS_THDL_LM, val);
> >
> > Same.

--=20
With Best Regards,
Andy Shevchenko
