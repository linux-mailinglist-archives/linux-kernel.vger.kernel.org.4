Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569506D5D92
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjDDKdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjDDKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:33:39 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2F41713;
        Tue,  4 Apr 2023 03:33:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id AF7F63F4F7;
        Tue,  4 Apr 2023 12:33:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7v9jF2qnx6hJ; Tue,  4 Apr 2023 12:33:32 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D22683F462;
        Tue,  4 Apr 2023 12:33:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 6CE9A9441E;
        Tue,  4 Apr 2023 10:33:31 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ArcmOD99wZcW; Tue,  4 Apr 2023 10:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id C53999441B;
        Tue,  4 Apr 2023 10:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se C53999441B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680604409;
        bh=3CdfL+g8jYqfBGZVji9bGfsXzXTHIklsS2W/mc7CNXg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=j/BD9kF7UAGmhCcFf/B8Ycfh4JC1+4L9IrVCdwDtxPYceWT2Bev0fWE4pKNJBfHKN
         Ot5VslcxDr/PbSPXFBPKot2WZoKOId6NUBmt7Fja867C9q8hKxy3jNXx/aKvXKalF6
         TqWCbdzaiJhgIhega2dyZQyK8mQTE5pFNZ8rIezGtthXZbc8JjkmE3WzXzUOITt8A1
         3ZudvhLntwrAciPRIh4+Eh8/ZVnBeCnvxw4FJge8YBT15pgf76DgJmIXm7IdYTXdLq
         se4l4EdM3x5YHOO4LKdclHOEcH9fO/ZnBg0teVeLJsFY6cJ64lGCgU0I2hhfZhthS/
         ReDxVVyKQjk5g==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rZWjrWUB--dI; Tue,  4 Apr 2023 10:33:29 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 7A52594416;
        Tue,  4 Apr 2023 10:33:29 +0000 (UTC)
Date:   Tue, 4 Apr 2023 12:33:28 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v2 1/7] iio: adc: palmas: remove adc_wakeupX_data
Message-ID: <20230404103328.GD2403322@dalakolonin.se>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
 <20230402164247.3089146-2-risca@dalakolonin.se>
 <ED6919A6-CE57-4C31-9AE5-2C31D288A810@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ED6919A6-CE57-4C31-9AE5-2C31D288A810@goldelico.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 06:49:36PM +0200, H. Nikolaus Schaller wrote:
> Hi Patrik,
>=20
> > Am 02.04.2023 um 18:42 schrieb Patrik Dahlstr=F6m <risca@dalakolonin.=
se>:
> >=20
> > It does not seem to be used by anyone and later patches in this serie=
s
> > are made simpler by first removing this. There is now a lot of dead c=
ode
> > that cannot be reached, until later patches revive it. Arguably, this=
 is
> > preferred over removing the code only to add it again.
> >=20
> > Signed-off-by: Patrik Dahlstr=F6m <risca@dalakolonin.se>
> > ---
> > drivers/iio/adc/palmas_gpadc.c | 50 ++++-----------------------------=
-
> > include/linux/mfd/palmas.h     |  8 ------
> > 2 files changed, 6 insertions(+), 52 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > index 24d7c096e4b8..943ac579eb1f 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -76,6 +76,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[=
] =3D {
> > 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> > };
> >=20
> > +struct palmas_adc_wakeup_property {
> > +	int adc_channel_number;
> > +	int adc_high_threshold;
> > +	int adc_low_threshold;
> > +};
> > +
> > /*
> >  * struct palmas_gpadc - the palmas_gpadc structure
> >  * @ch0_current:	channel 0 current source setting
> > @@ -492,11 +498,6 @@ static int palmas_gpadc_get_adc_dt_data(struct p=
latform_device *pdev,
> > 	return 0;
> > }
> >=20
> > -static void palmas_disable_wakeup(void *dev)
>=20
> something seems to be mixed up here.
>=20
> There is no palmas_disable_wakeup() upstream that can be removed. So th=
is patch
> can not be applied as 1/7 to any upstream kernel.
>=20
> Please rebase your series on either linus/master or linux-next/master.

I'm sorry for the confusion. I should have been more clear in the cover
letter.

This series is based on Jonathan Cameron's iio tree[1], plus the patches =
at
[2] and [3]. The first patch is already part of linux-next and I was unde=
r
the impression that [3] would be soon too.

Would it be best to rebase this series on linux-next instead?

[1] git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
[2] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1=
881745-1-risca@dalakolonin.se/
[3] https://patchwork.kernel.org/project/linux-iio/patch/20230318163039.5=
6115-1-jic23@kernel.org/

>=20
> BR,
> Nikolaus
>=20
> > -{
> > -	device_wakeup_disable(dev);
> > -}
> > -
> > static int palmas_gpadc_probe(struct platform_device *pdev)
> > {
> > 	struct palmas_gpadc *adc;
> > @@ -547,36 +548,6 @@ static int palmas_gpadc_probe(struct platform_de=
vice *pdev)
> > 		return dev_err_probe(adc->dev, ret,
> > 				     "request irq %d failed\n", adc->irq);
> >=20
> > -	if (gpadc_pdata->adc_wakeup1_data) {
> > -		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> > -			sizeof(adc->wakeup1_data));
> > -		adc->wakeup1_enable =3D true;
> > -		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
> > -						NULL, palmas_gpadc_irq_auto,
> > -						IRQF_ONESHOT,
> > -						"palmas-adc-auto-0", adc);
> > -		if (ret < 0)
> > -			return dev_err_probe(adc->dev, ret,
> > -					     "request auto0 irq %d failed\n",
> > -					     adc->irq_auto_0);
> > -	}
> > -
> > -	if (gpadc_pdata->adc_wakeup2_data) {
> > -		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> > -				sizeof(adc->wakeup2_data));
> > -		adc->wakeup2_enable =3D true;
> > -		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
> > -						NULL, palmas_gpadc_irq_auto,
> > -						IRQF_ONESHOT,
> > -						"palmas-adc-auto-1", adc);
> > -		if (ret < 0)
> > -			return dev_err_probe(adc->dev, ret,
> > -					     "request auto1 irq %d failed\n",
> > -					     adc->irq_auto_1);
> > -	}
> > -
> > 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> > 	if (gpadc_pdata->ch0_current <=3D 1)
> > 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> > @@ -616,15 +587,6 @@ static int palmas_gpadc_probe(struct platform_de=
vice *pdev)
> > 			palmas_gpadc_calibrate(adc, i);
> > 	}
> >=20
> > -	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> > -		device_wakeup_enable(&pdev->dev);
> > -		ret =3D devm_add_action_or_reset(&pdev->dev,
> > -					       palmas_disable_wakeup,
> > -					       &pdev->dev);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> > 	return 0;
> > }
> >=20
> > diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> > index 1e61c7e9f50d..55f22adb1a9e 100644
> > --- a/include/linux/mfd/palmas.h
> > +++ b/include/linux/mfd/palmas.h
> > @@ -129,12 +129,6 @@ struct palmas_pmic_driver_data {
> > 			    struct regulator_config config);
> > };
> >=20
> > -struct palmas_adc_wakeup_property {
> > -	int adc_channel_number;
> > -	int adc_high_threshold;
> > -	int adc_low_threshold;
> > -};
> > -
> > struct palmas_gpadc_platform_data {
> > 	/* Channel 3 current source is only enabled during conversion */
> > 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
> > @@ -153,8 +147,6 @@ struct palmas_gpadc_platform_data {
> > 	int start_polarity;
> >=20
> > 	int auto_conversion_period_ms;
> > -	struct palmas_adc_wakeup_property *adc_wakeup1_data;
> > -	struct palmas_adc_wakeup_property *adc_wakeup2_data;
> > };
> >=20
> > struct palmas_reg_init {
> > --=20
> > 2.25.1
> >=20
>=20
