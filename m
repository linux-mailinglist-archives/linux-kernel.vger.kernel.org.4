Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA59D5B9DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiIOPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIOO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 10:59:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A908D1CFCD;
        Thu, 15 Sep 2022 07:59:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o5so10032697wms.1;
        Thu, 15 Sep 2022 07:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=SLj4byBV3WVQVgcAW5mpJH/l8HvInhYjH0o9lYmfDsY=;
        b=XYX+CfBp76F+YkSL3D3OQvLViMBOdJ4Xq4sb/rPm/mU5YHCJ28kONV329vecPbMw7k
         1AELZ7BDHWKyVO1AtSLGm6Lpe336iA9jfZgdhO6kIQGjQcqB4m55JuFZTlXN8SShYZal
         imIPpma3oz1/37sHd5QTcA01ZdhtUxFuDsPwAIFj5trd3XOlB/2mNt8fHwfUAPCKPN/C
         LqNeUEv50ECZTFY72rVsH7EKL7QAetxH19vMGAmiJ29suQ6KS5Fb+zFzQWnzXbsR7BWc
         RjB7UJIxABsKrq1zmeAgOhJIcTZfBbtvOyMr3EQk1FwiuIx2Pjagt+BFSR4IkRz4b26n
         FFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SLj4byBV3WVQVgcAW5mpJH/l8HvInhYjH0o9lYmfDsY=;
        b=es0ASV3njvUnFAEVM4UwxgrR2iIyOedXSdHj3HgPQf8dfJnmMhMJxurkwnoaUOUGgR
         CaOEG0DukPnls7TAQhxyAcJEabuQrSAP8reo5MVxIv9K26K6D9zstZ7vu7ZsL2quJ3ER
         0QbVOPNH6VYOOhlcgqwISSV51P2wQhSxStTzk7oEN94ZqeoAiT2KHg43atZkdY1FHyPq
         79N74WnFe5JAcv9jSfNmbAsZyiJeJVSixkiwgI7FE5G8qqux3N5Xws7QaGVperXyNn6/
         kFoKsCPqAOZuTtts+LTcLZVPuJaQzhYPiQs2qmdi4wAj9zHV9IiQnt7Hwez4shk089zs
         NMsg==
X-Gm-Message-State: ACrzQf0j9zrFfBJ6StynSA1vN+IQ8q8vJATnWRFRj2wJhhBlco1b9Gls
        mlNaVbUyJJUUc+v5rsqfvsU=
X-Google-Smtp-Source: AMsMyM7h3SnNT5CWfFv+iCZVvQwjh/GrurUHcqfxJ01wyYwNzcsRxxRX45svRTsUVKcAlAAbej+4RQ==
X-Received: by 2002:a05:600c:35c6:b0:3b4:9a9e:464a with SMTP id r6-20020a05600c35c600b003b49a9e464amr149831wmq.206.1663253996124;
        Thu, 15 Sep 2022 07:59:56 -0700 (PDT)
Received: from [192.168.1.123] (68.201.26.77.dynamic.reverse-mundo-r.com. [77.26.201.68])
        by smtp.gmail.com with ESMTPSA id o34-20020a05600c512200b003a5b6086381sm3899427wms.48.2022.09.15.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 07:59:55 -0700 (PDT)
Message-ID: <9b8736f0cc3c68bbec52aab503aeaec74e60ae87.camel@gmail.com>
Subject: Re: [PATCH v2] iio: pressure: bmp280: fix datasheet links
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Sep 2022 16:59:54 +0200
In-Reply-To: <20220915143944.79348ecb@jic23-huawei>
References: <CAHp75VeSsVD8rMz-Cj6kFovqdQQPjbH7rUXWS6paRtsBaB-Kww@mail.gmail.com>
         <20220912222645.377874-1-ang.iglesiasg@gmail.com>
         <20220915143944.79348ecb@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.module_f36+15386+a24ad1a3) 
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

On jue, 2022-09-15 at 14:39 +0100, Jonathan Cameron wrote:
> On Tue, 13 Sep 2022 00:26:44 +0200
> Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>=20
> > Updated links for BMP280 and BME280 datasheets on Bosch website.
> > Datasheet of BMP180 is no longer available on the manufacturer's websit=
e,
> > changed the link to a copy hosted by a third party.
> >=20
> > Changelog in v2:
> > * Added a notice about the situation with bmp180 datasheet and list
> > =C2=A0 missing changes from newer versions.
> Change log needs to be below the ---
>=20
> We don't want that level of detail in the git logs.
>=20
> I tidied that up whilst applying.=20
>=20
> Also, it's not a good idea to have new versions as replies
> to older ones.=C2=A0 Leads to very deep nesting in email threads
> and generally makes things less readable.=C2=A0 Just post
> a fresh series each time.
>=20
> Applied to the togreg branch of iio.git and pushed out as testing=20
> for 0-day to see if it can find anything (rather unlikely on this
> patch!)
>=20
> Jonathan
>=20

OK, I'll keep it on my mind for future contributions. Thanks for your help =
and
patience!

Kind regards,
Angel

>=20
> >=20
> > Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
> > ---
> > =C2=A0drivers/iio/pressure/bmp280-core.c | 12 +++++++++---
> > =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/pressure/bmp280-core.c
> > b/drivers/iio/pressure/bmp280-core.c
> > index fe7aa81e7cc9..01cd32003ca8 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -9,9 +9,15 @@
> > =C2=A0 * Driver for Bosch Sensortec BMP180 and BMP280 digital pressure =
sensor.
> > =C2=A0 *
> > =C2=A0 * Datasheet:
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP1=
80-DS000-121.pdf
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BMP2=
80-DS001-12.pdf
> > - *
> > https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME2=
80_DS001-11.pdf
> > + * https://cdn-shop.adafruit.com/datasheets/BST-BMP180-DS000-09.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bmp280-ds001.pdf
> > + *
> > https://www.bosch-sensortec.com/media/boschsensortec/downloads/datashee=
ts/bst-bme280-ds002.pdf
> > + *
> > + * Notice:
> > + * The link to the bmp180 datasheet points to an outdated version miss=
ing
> > these changes:
> > + * - Changed document referral from ANP015 to BST-MPS-AN004-00 on page=
 26
> > + * - Updated equation for B3 param on section 3.5 to ((((long)AC1 * 4 =
+ X3)
> > << oss) + 2) / 4
> > + * - Updated RoHS directive to 2011/65/EU effective 8 June 2011 on pag=
e 26
> > =C2=A0 */
> > =C2=A0
> > =C2=A0#define pr_fmt(fmt) "bmp280: " fmt
> >=20
> > base-commit: 2f61ff8272967c9bdcba810aa978170814b08f7c
>=20

