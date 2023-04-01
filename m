Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9706D334F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDATCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDATB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 15:01:56 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938C0FF;
        Sat,  1 Apr 2023 12:01:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id E5A763F59B;
        Sat,  1 Apr 2023 21:01:52 +0200 (CEST)
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
        with ESMTP id As8fSJ2NU94Y; Sat,  1 Apr 2023 21:01:52 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C4DB63F55F;
        Sat,  1 Apr 2023 21:01:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 1FC9E93074;
        Sat,  1 Apr 2023 19:01:51 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RuK9Eq3gxX-2; Sat,  1 Apr 2023 19:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 6519D93071;
        Sat,  1 Apr 2023 19:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 6519D93071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680375706;
        bh=sm8C11+8ErjSqrxa12aF+9WUbL/MLUtzIW1cAw8s+5E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WOhRIqrvMYuf/twhSPI+KOgVVZu2LdAn5bjJjD7OFXAGdARNPbywNCbdCuP6aJMoB
         XvquWZOuzyxCp/0NQU6IP54ZPnVOxRHOyAMbQI21NqQ6deVs6xBKp4Gk3+Clppakpo
         ZUHhh/x+BOJVciahl+nwNBL3r4xf3bGMlH+7GIqzCXSGi4UFaDzKm4BrHyabL2Ssr6
         Ul9loMU5esa4rIYFIGtpLarHpmDrOnvfO/2XcoPwm6V5UswmxQ+gX3CpyxyseXU6ns
         9+BiiV/dLDRWkE1DSZNbisDSepT1nvhEikcIIr51Z2psoEJGEEiZrsEtPYEtONxMKb
         x7LEMPxNVRSOA==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bVCiIYYtF0LA; Sat,  1 Apr 2023 19:01:46 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 1BF629306C;
        Sat,  1 Apr 2023 19:01:46 +0000 (UTC)
Date:   Sat, 1 Apr 2023 21:01:44 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 3/3] iio: adc: palmas_gpadc: remove
 palmas_adc_wakeup_property
Message-ID: <20230401190144.GC2403322@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
 <20230319223908.108540-4-risca@dalakolonin.se>
 <20230326175928.0dc26a4f@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230326175928.0dc26a4f@jic23-huawei>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:59:28PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Mar 2023 23:39:08 +0100
> Patrik Dahlstr=F6m <risca@dalakolonin.se> wrote:
>=20
> > This struct contain essentially the same information as
> > palmas_adc_event and palmas_gpadc_thresholds combined, but with more
> > ambiguity: the code decided whether to trigger on rising or falling e=
dge
> > based on the high threshold being non-zero.
> >=20
> > Since its use in platform data has now been removed, we can remove it
> > entirely.
> >=20
> > Lastly, the use case for waking up the cpu from sleep mode when a
> > threshold has been passed is no longer the primary use for events so =
all
> > code is changed to say "event" instead of "wakeup".
> Good. I nearly pointed this out in the earlier patch.  The wakeup namin=
g
> was confusing. However, I'd prefer that was done in a separate patch to
> any other changes.  It's hard to spot the meaningful stuff when there
> is a lot of renaming going on.

Since I was doing this patch last, it made little sense to keep the wakeu=
p
naming when removing the wakeup property. However, as you pointed out in
your review of the previous patches, it would be better to first remove t=
he
wakeup property and then add iio events support.
>=20
> A few questions / comments inline.
>=20
> Jonathan
>=20
> >=20
> > Signed-off-by: Patrik Dahlstr=F6m <risca@dalakolonin.se>
> > ---
> >  drivers/iio/adc/palmas_gpadc.c | 94 +++++++++++++-------------------=
--
> >  include/linux/mfd/palmas.h     |  6 ---
> >  2 files changed, 36 insertions(+), 64 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > index 419d7db51345..042b68f29444 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -122,10 +122,8 @@ struct palmas_gpadc {
> >  	int				irq_auto_1;
> >  	struct palmas_gpadc_info	*adc_info;
> >  	struct completion		conv_completion;
> > -	struct palmas_adc_wakeup_property wakeup1_data;
> > -	struct palmas_adc_wakeup_property wakeup2_data;
> > -	bool				wakeup1_enable;
> > -	bool				wakeup2_enable;
> > +	bool				event0_enable;
> > +	bool				event1_enable;
> >  	int				auto_conversion_period;
> >  	struct mutex			lock;
> >  	struct palmas_adc_event		event0;
> > @@ -592,50 +590,26 @@ static int palmas_gpadc_read_event_config(struc=
t iio_dev *indio_dev,
> >  	return ret;
> >  }
> > =20
> > -static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
> > -				       struct palmas_adc_event *ev,
> > -				       struct palmas_adc_wakeup_property *wakeup)
> > -{
> > -	wakeup->adc_channel_number =3D ev->channel;
> > -	if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> > -		wakeup->adc_low_threshold =3D 0;
> > -		wakeup->adc_high_threshold =3D
> > -			palmas_gpadc_get_high_threshold_raw(adc, &adc->event0);
> > -	}
> > -	else {
> > -		wakeup->adc_low_threshold =3D
> > -			palmas_gpadc_get_low_threshold_raw(adc, &adc->event0);
> > -		wakeup->adc_high_threshold =3D 0;
> > -	}
> > -}
> > -
> > -static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
> > -static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
> > +static int palmas_adc_events_configure(struct palmas_gpadc *adc);
> > +static int palmas_adc_events_reset(struct palmas_gpadc *adc);
> > =20
> >  static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpa=
dc *adc)
> >  {
> > -	bool was_enabled =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	bool was_enabled =3D adc->event0_enable || adc->event1_enable;
> >  	bool enable;
> > =20
> > -	adc->wakeup1_enable =3D adc->event0.channel =3D=3D -1 ? false : tru=
e;
> > -	adc->wakeup2_enable =3D adc->event1.channel =3D=3D -1 ? false : tru=
e;
> > +	adc->event0_enable =3D adc->event0.channel =3D=3D -1 ? false : true=
;
> > +	adc->event1_enable =3D adc->event1.channel =3D=3D -1 ? false : true=
;
> > =20
> > -	enable =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	enable =3D adc->event0_enable || adc->event1_enable;
> >  	if (!was_enabled && enable)
> >  		device_wakeup_enable(adc->dev);
> >  	else if (was_enabled && !enable)
> >  		device_wakeup_disable(adc->dev);
> > =20
> > -	if (!enable)
> > -		return palmas_adc_wakeup_reset(adc);
> > -
> > -	// adjust levels
> > -	if (adc->wakeup1_enable)
> > -		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
> > -	if (adc->wakeup2_enable)
> > -		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
> > -
> > -	return palmas_adc_wakeup_configure(adc);
> > +	return enable ?
> > +		palmas_adc_events_configure(adc) :
> > +		palmas_adc_events_reset(adc);
> >  }
> > =20
> >  static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc=
,
> > @@ -864,12 +838,14 @@ static int palmas_gpadc_get_adc_dt_data(struct =
platform_device *pdev,
> >  	return 0;
> >  }
> > =20
> > -static void palmas_disable_wakeup(void *data)
> > +static void palmas_disable_events(void *data)
> >  {
> >  	struct palmas_gpadc *adc =3D data;
> > =20
> > -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > +	if (adc->event0_enable || adc->event1_enable) {
> > +		palmas_adc_events_reset(adc);
>=20
> I can't immediately follow why this reset is needed when it wasn't befo=
re.
> Perhaps that will be clearer once the renames aren't in the same patch.

The original code would only enable adc events when entering any kind of
sleep mode and then reset when resuming, hence the name wakeupX_enable. T=
he
new code allow adc events to be enabled at any time. palmas_disable_event=
s
is run when unloading the module and as such it makes sense to also reset
the adc.

>=20
> >  		device_wakeup_disable(adc->dev);
> > +	}
> >  }
> > =20
> >  static int palmas_gpadc_probe(struct platform_device *pdev)
> > @@ -993,7 +969,7 @@ static int palmas_gpadc_probe(struct platform_dev=
ice *pdev)
> > =20
> >  	device_set_wakeup_capable(&pdev->dev, 1);
> >  	ret =3D devm_add_action_or_reset(&pdev->dev,
> > -				       palmas_disable_wakeup,
> > +				       palmas_disable_events,
> >  				       adc);
> >  	if (ret)
> >  		return ret;
> > @@ -1001,7 +977,7 @@ static int palmas_gpadc_probe(struct platform_de=
vice *pdev)
> >  	return 0;
> >  }
> > =20
> > -static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc)
> > +static int palmas_adc_events_configure(struct palmas_gpadc *adc)
> >  {
> >  	int adc_period, conv;
> >  	int i;
> > @@ -1027,16 +1003,18 @@ static int palmas_adc_wakeup_configure(struct=
 palmas_gpadc *adc)
> >  	}
> > =20
> >  	conv =3D 0;
> > -	if (adc->wakeup1_enable) {
> > +	if (adc->event0_enable) {
> > +		struct palmas_adc_event *ev =3D &adc->event0;
> >  		int polarity;
> > =20
> > -		ch0 =3D adc->wakeup1_data.adc_channel_number;
> > +		ch0 =3D ev->channel;
> >  		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
> > -		if (adc->wakeup1_data.adc_high_threshold > 0) {
> > -			thres =3D adc->wakeup1_data.adc_high_threshold;
> > +
> > +		if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> > +			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
> >  			polarity =3D 0;
> >  		} else {
> > -			thres =3D adc->wakeup1_data.adc_low_threshold;
> > +			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
> >  			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
> >  		}
> > =20
> > @@ -1058,16 +1036,18 @@ static int palmas_adc_wakeup_configure(struct=
 palmas_gpadc *adc)
> >  		}
> >  	}
> > =20
> > -	if (adc->wakeup2_enable) {
> > +	if (adc->event1_enable) {
> > +		struct palmas_adc_event *ev =3D &adc->event1;
> >  		int polarity;
> > =20
> > -		ch1 =3D adc->wakeup2_data.adc_channel_number;
> > +		ch1 =3D ev->channel;
> >  		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
> > -		if (adc->wakeup2_data.adc_high_threshold > 0) {
> > -			thres =3D adc->wakeup2_data.adc_high_threshold;
> > +
> > +		if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> > +			thres =3D palmas_gpadc_get_high_threshold_raw(adc, ev);
> >  			polarity =3D 0;
> >  		} else {
> > -			thres =3D adc->wakeup2_data.adc_low_threshold;
> > +			thres =3D palmas_gpadc_get_low_threshold_raw(adc, ev);
> >  			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
> >  		}
> > =20
> > @@ -1106,7 +1086,7 @@ static int palmas_adc_wakeup_configure(struct p=
almas_gpadc *adc)
> >  	return ret;
> >  }
> > =20
> > -static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
> > +static int palmas_adc_events_reset(struct palmas_gpadc *adc)
> >  {
> >  	int ret;
> > =20
> > @@ -1128,15 +1108,14 @@ static int palmas_gpadc_suspend(struct device=
 *dev)
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > -	int ret;
>=20
> ?  Seems unrelated - perhaps should be in earlier patch.

You're right. I'll look into it.

>=20
> > =20
> >  	if (!device_may_wakeup(dev))
> >  		return 0;
> > =20
> > -	if (adc->wakeup1_enable)
> > +	if (adc->event0_enable)
> >  		enable_irq_wake(adc->irq_auto_0);
> > =20
> > -	if (adc->wakeup2_enable)
> > +	if (adc->event1_enable)
> >  		enable_irq_wake(adc->irq_auto_1);
> > =20
> >  	return 0;
> > @@ -1146,15 +1125,14 @@ static int palmas_gpadc_resume(struct device =
*dev)
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > -	int ret;
>=20
> ?
>=20
> > =20
> >  	if (!device_may_wakeup(dev))
> >  		return 0;
> > =20
> > -	if (adc->wakeup1_enable)
> > +	if (adc->event0_enable)
> >  		disable_irq_wake(adc->irq_auto_0);
> > =20
> > -	if (adc->wakeup2_enable)
> > +	if (adc->event1_enable)
> >  		disable_irq_wake(adc->irq_auto_1);
> > =20
> >  	return 0;
>=20
>=20
