Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B62A6D333F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDASxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDASxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:53:18 -0400
X-Greylist: delayed 478 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 01 Apr 2023 11:53:15 PDT
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6D7B763
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:53:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 8C77B3F4C8;
        Sat,  1 Apr 2023 20:45:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F4gAwZKkJC6h; Sat,  1 Apr 2023 20:45:13 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5BAF03F468;
        Sat,  1 Apr 2023 20:45:12 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (2048-bit key; unprotected) header.d=dalakolonin.se header.i=@dalakolonin.se header.b="C38Ho4ej";
        dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id EE3B193057;
        Sat,  1 Apr 2023 18:45:11 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qf9yfS-UmghS; Sat,  1 Apr 2023 18:45:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 5857493054;
        Sat,  1 Apr 2023 18:45:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 5857493054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680374709;
        bh=xI8PDsY7vWgEfxc6/1Pav5lMDphx3ss3aPKQetrT2eM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=C38Ho4ejJAJ4urwW2WK5TI6ZYqkdePv361JafqdTop1lMRJaV4bzwjV5sccvuvVEv
         Kz6ZC1bGedqzz2FlOxTqQWF5IdHQk9rEtzhqDpbqrf9LBOaXgUhPAd93uaPwcwJjSh
         Lwc7IGw8k67oTzyaKnPTtr0XQbKtWMXdba5Wmh9rAV+0yvxd/u36NzXusIK3kwIWAP
         KWt96yR93bxXz9q8ml1JXVWdv8hNSZXo7EfzuPdHUXx+JKiEfPXyy1/jl9ZqwzSdxN
         T4IrjlJz6a1Fvsl1pxm09LWGp9LeUGLdHUMtq38CBIgVVdHX0wn7dA2jPfBUbOGa0p
         zgUuVATyFolnw==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5fGVd1bJ6xGG; Sat,  1 Apr 2023 18:45:09 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id EFDEB9304F;
        Sat,  1 Apr 2023 18:45:08 +0000 (UTC)
Date:   Sat, 1 Apr 2023 20:45:07 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de
Subject: Re: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio
 threshold events
Message-ID: <20230401184507.GB2403322@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
 <20230319223908.108540-2-risca@dalakolonin.se>
 <20230326175101.0ef2d6ae@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230326175101.0ef2d6ae@jic23-huawei>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:51:01PM +0100, Jonathan Cameron wrote:
> On Sun, 19 Mar 2023 23:39:06 +0100
> Patrik Dahlstr=F6m <risca@dalakolonin.se> wrote:
>=20
> > The palmas gpadc block has support for monitoring up to 2 ADC channel=
s
> > and issue an interrupt if they reach past a set threshold. The gpadc
> > driver had limited support for this through the adc_wakeup{1,2}_data
> > platform data. This however only allow a fixed threshold to be set at
> > boot, and would only enable it when entering sleep mode.
> >=20
> > This change hooks into the IIO events system and exposes to userspace
> > the ability to configure threshold values for each channel individual=
ly,
> > but only allow up to 2 such thresholds to be enabled at any given tim=
e.
>=20
> Add a comment here on what happens if userspace tries to set more than =
two.
> It's not as obvious as you'd think as we have some drivers that use a f=
ifo
> approach so on setting the third event they push the oldest one out.

Will do!

Is there any preference to any one approach?

>=20
> >=20
> > The logic around suspend and resume had to be adjusted so that user
> > space configuration don't get reset on resume. Instead, any configure=
d
> > adc auto wakeup gets enabled during probe.
> >=20
> > Enabling a threshold from userspace will overwrite the adc wakeup
> > configuration set during probe. Depending on how you look at it, this
> > could also mean we allow userspace to update the adc wakeup threshold=
s.
>=20
> I'm not sure I read the code right, but can you end up enabling a wakeu=
p
> that wasn't previously present?  That seems likely something we should
> not be doing after boot.
>=20
> One option here would be to make it either wakeup is supported, or even=
ts
> are supported.  I suspect no one uses the wakeup anyway so that shouldn=
't
> matter much (+ you remove it in next patch - do that first and this cod=
e
> becomes more obvious).
>=20

My use case is for monitoring a volume wheel connected to one of the ADC
inputs of the palmas chip. By off-loading the monitoring to a separate
chip, the SoC can go to sleep and only wake up when the wheel is moved.

It made sense for my use case, but I see your point. IIO events and wakeu=
p
triggers should be treated as separate things. I will look into defining
the dev_pm_info of the device. Then userspace should be able to control
wakeup from /sys/devices/.../power/wakeup.

However, suspend and resume is a bit flaky on my board so testing might b=
e
too. If the board reacts and at least tries to resume should indicate tha=
t
the code works, no?

In any case, I will remove the old wakeup code first in v2.

>=20
> A few trivial comments inline.

I will adress them in v2. They all made perfect sense.

> >=20
> > Signed-off-by: Patrik Dahlstr=F6m <risca@dalakolonin.se>
>=20
> > =20
> > @@ -280,6 +326,9 @@ static int palmas_gpadc_read_prepare(struct palma=
s_gpadc *adc, int adc_chan)
> >  {
> >  	int ret;
> > =20
> > +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
> > +		return 0; // ADC already running
>=20
> /* */
>=20
> ...
>=20
> > =20
> > +static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc *=
adc,
> > +					       struct palmas_adc_event *ev)
> > +{
> > +	const int INL =3D 2;
> > +	const int adc_chan =3D ev->channel;
> > +	const int orig =3D adc->thresh_data[adc_chan].high_thresh;
> > +	int val =3D orig;
> > +	int gain_drift;
> > +	int offset_drift;
> > +
> > +	if (!val)
> > +		return 0;
> > +
> > +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> > +
> > +	if (!adc->adc_info[adc_chan].is_uncalibrated) {
> > +		val =3D (val * adc->adc_info[adc_chan].gain_error +
> > +		       adc->adc_info[adc_chan].offset) /
> > +			1000;
> > +		gain_drift =3D 1002;
> > +		offset_drift =3D 2;
> > +	}
> > +	else {
> > +		gain_drift =3D 1022;
> > +		offset_drift =3D 36;
> > +	}
> > +
> > +	// add tolerance to threshold
> > +	val =3D ((val + INL) * gain_drift) / 1000 + offset_drift;
> > +
> > +	// clamp to max possible value
> /* clamp .. */
> val =3D min(val, 0xFFF);
>=20
>=20
> > +	if (val > 0xFFF)
> > +		val =3D 0xFFF;
> > +
> > +	return val;
> > +}
> > +
> > +static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc *a=
dc,
> > +					      struct palmas_adc_event *ev)
> > +{
> > +	const int INL =3D 2;
> > +	const int adc_chan =3D ev->channel;
> > +	const int orig =3D adc->thresh_data[adc_chan].low_thresh;
> > +	int val =3D orig;
> > +	int gain_drift;
> > +	int offset_drift;
> > +
> > +	if (!val)
> > +		return val;
> > +
> > +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> > +
> > +        if (!adc->adc_info[adc_chan].is_uncalibrated) {
> > +            val =3D (val * adc->adc_info[adc_chan].gain_error -
> > +		   adc->adc_info[adc_chan].offset) /
> > +		    1000;
> > +            gain_drift =3D 998;
> > +            offset_drift =3D 2;
> > +        }
> > +        else {
> > +            gain_drift =3D 978;
> > +            offset_drift =3D 36;
> > +        }
> > +
> > +	// calculate tolerances
> /* */
>=20
> + I think this could do with more information on why a tweak is needed.
>=20
> > +	val =3D ((val - INL) * gain_drift) / 1000 - offset_drift;
> > +
> > +	// clamp to minimum 0
>=20
> /* */ for all comments.=20
>=20
> val =3D max(0, val); then comment may not be needed.
>=20
> > +	if (val < 0)
> > +		val =3D 0;
> > +
> > +	return val;
> > +}
>=20
> > +static int palmas_gpadc_reconfigure_event_channels(struct palmas_gpa=
dc *adc)
> > +{
> > +	bool was_enabled =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	bool enable;
> > +
> > +	adc->wakeup1_enable =3D adc->event0.channel =3D=3D -1 ? false : tru=
e;
> > +	adc->wakeup2_enable =3D adc->event1.channel =3D=3D -1 ? false : tru=
e;
> > +
> > +	enable =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > +	if (!was_enabled && enable)
> > +		device_wakeup_enable(adc->dev);
> > +	else if (was_enabled && !enable)
> > +		device_wakeup_disable(adc->dev);
> > +
> > +	if (!enable)
> > +		return palmas_adc_wakeup_reset(adc);
> > +
> > +	// adjust levels
>=20
> /* adjust levels */=20
>=20
> > +	if (adc->wakeup1_enable)
> > +		palmas_adc_event_to_wakeup(adc, &adc->event0, &adc->wakeup1_data);
> > +	if (adc->wakeup2_enable)
> > +		palmas_adc_event_to_wakeup(adc, &adc->event1, &adc->wakeup2_data);
> > +
> > +	return palmas_adc_wakeup_configure(adc);
> > +}
> > +
> > +static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc=
,
> > +	const struct iio_chan_spec *chan, enum iio_event_direction dir)
> > +{
> > +	struct palmas_adc_event *ev;
> > +	int adc_chan =3D chan->channel;
> > +
> > +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
> > +		/* already enabled */
> > +		return 0;
> > +
> > +	if (adc->event0.channel =3D=3D -1)
>=20
> I'd add brackets for all legs of this if / else once one of them needs
> it. Tends to end up more readable.
>=20
> > +		ev =3D &adc->event0;
> > +	else if (adc->event1.channel =3D=3D -1) {
> > +		/* event0 has to be the lowest channel */
> > +		if (adc_chan < adc->event0.channel) {
> > +			adc->event1 =3D adc->event0;
> > +			ev =3D &adc->event0;
> > +		}
> > +		else
> > +			ev =3D &adc->event1;
> > +	}
>=20
> } else /*...
>=20
> > +	else /* both AUTO channels already in use */ {
> > +		dev_warn(adc->dev, "event0 - %d, event1 - %d\n",
> > +			 adc->event0.channel, adc->event1.channel);
> > +		return -EBUSY;
> > +	}
> > +
> > +	ev->channel =3D adc_chan;
> > +	ev->direction =3D dir;
> > +
> > +	return palmas_gpadc_reconfigure_event_channels(adc);
> > +}
>=20
> > +
> > +static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, enum iio_event_type type,
> > +	enum iio_event_direction dir, enum iio_event_info info, int val,
> > +	int val2)
>=20
> Prefer parameters aligned just after (
>=20
> > +{
> ...
>=20
>=20
> > =20
> >  static int palmas_gpadc_probe(struct platform_device *pdev)
>=20
> ...
>=20
> >  	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> >  	if (gpadc_pdata->ch0_current <=3D 1)
> >  		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> > @@ -610,20 +998,23 @@ static int palmas_gpadc_probe(struct platform_d=
evice *pdev)
> >  		return dev_err_probe(adc->dev, ret,
> >  				     "iio_device_register() failed\n");
> > =20
> > -	device_set_wakeup_capable(&pdev->dev, 1);
> >  	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
> >  		if (!(adc->adc_info[i].is_uncalibrated))
> >  			palmas_gpadc_calibrate(adc, i);
> >  	}
> > =20
> > +	device_set_wakeup_capable(&pdev->dev, 1);
> >  	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> > -		device_wakeup_enable(&pdev->dev);
> > -		ret =3D devm_add_action_or_reset(&pdev->dev,
> > -					       palmas_disable_wakeup,
> > -					       &pdev->dev);
> > +		ret =3D palmas_adc_wakeup_configure(adc);
> >  		if (ret)
> >  			return ret;
> > +		device_wakeup_enable(&pdev->dev);
>=20
> >  	}
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
>=20
> Add a comment for this to explain why it might need disabling even if
> it wasn't enabled above.  I think if you just drop wakeup support in
> general that will be fine given we have no known users.
>=20

I'm one such user.

>=20
> > +				       palmas_disable_wakeup,
> > +				       adc);
> > +	if (ret)
> > +		return ret;
> > =20
> >  	return 0;
> >  }
>=20
>=20
>=20
