Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6F6D330E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDASQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:16:00 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250C1A460;
        Sat,  1 Apr 2023 11:15:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 1D7913F4DA;
        Sat,  1 Apr 2023 20:15:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id q9RBkAbrPeBh; Sat,  1 Apr 2023 20:15:51 +0200 (CEST)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6F6213F46B;
        Sat,  1 Apr 2023 20:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id ED9C593033;
        Sat,  1 Apr 2023 18:15:47 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zbg7ScPULHvP; Sat,  1 Apr 2023 18:15:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id A364A93030;
        Sat,  1 Apr 2023 18:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se A364A93030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680372944;
        bh=lxhqU9CcULyH4ujVlEwKshkIgzwkRuFIA6Ux9pda21Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=iXM3FXHxpmJatFz/oyHWsDQog6ZH4F3c51+sDlK1v3WlT8nfueLgTbCHF00adgHOr
         zglMEhtsnfr9Xg+2ipxYq2wC/wfo0q8VewOx0Rle87lTjOi1v32p78ghLxnfDiE05S
         JWbEaashEnKcjZAvFR+wh6PwdLMY9FENl8fXihxfjGGMdj7sGjCruGggcfL91lE9RW
         3LGUr+FXpVZWuI91+Hvtq0iF+8Qav1/bmhFwB/f5LgvsDAeJi2WASgLXwOEuQrnG2z
         wB26zH7ZABsEwa6xE9nBS40h/9qmW26iM8ykn3fSW679bmPPsCrqz2ouvVmKw+sy5P
         K7tLqDlxFW0Dg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rxxCtUHXdOEp; Sat,  1 Apr 2023 18:15:44 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 4865D9302B;
        Sat,  1 Apr 2023 18:15:44 +0000 (UTC)
Date:   Sat, 1 Apr 2023 20:15:43 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     linux-iio@vger.kernel.org,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, jic23@kernel.org, lars@metafoo.de
Subject: Re: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio
 threshold events
Message-ID: <20230401181543.GA2403322@dalakolonin.se>
References: <20230319223908.108540-1-risca@dalakolonin.se>
 <20230319223908.108540-2-risca@dalakolonin.se>
 <7D0EF51A-CED1-44E6-8B6E-8CFFDEAC8077@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7D0EF51A-CED1-44E6-8B6E-8CFFDEAC8077@goldelico.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:40:07PM +0100, H. Nikolaus Schaller wrote:
> Hi Patrik,
>=20
> > Am 19.03.2023 um 23:39 schrieb Patrik Dahlstr=F6m <risca@dalakolonin.=
se>:
> >=20
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
> >=20
> > Signed-off-by: Patrik Dahlstr=F6m <risca@dalakolonin.se>
> > ---
> > drivers/iio/adc/palmas_gpadc.c | 495 +++++++++++++++++++++++++++++---=
-
> > 1 file changed, 438 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_=
gpadc.c
> > index 24d7c096e4b8..84c6e3b66205 100644
> > --- a/drivers/iio/adc/palmas_gpadc.c
> > +++ b/drivers/iio/adc/palmas_gpadc.c
> > @@ -20,6 +20,7 @@
> > #include <linux/completion.h>
> > #include <linux/of.h>
> > #include <linux/of_device.h>
> > +#include <linux/iio/events.h>
> > #include <linux/iio/iio.h>
> > #include <linux/iio/machine.h>
> > #include <linux/iio/driver.h>
> > @@ -76,6 +77,16 @@ static struct palmas_gpadc_info palmas_gpadc_info[=
] =3D {
> > 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> > };
> >=20
> > +struct palmas_gpadc_thresholds {
> > +	int high_thresh;
> > +	int low_thresh;
> > +};
> > +
> > +struct palmas_adc_event {
> > +	int channel;
> > +	enum iio_event_direction direction;
> > +};
> > +
> > /*
> >  * struct palmas_gpadc - the palmas_gpadc structure
> >  * @ch0_current:	channel 0 current source setting
> > @@ -117,8 +128,30 @@ struct palmas_gpadc {
> > 	bool				wakeup2_enable;
> > 	int				auto_conversion_period;
> > 	struct mutex			lock;
> > +	struct palmas_adc_event		event0;
> > +	struct palmas_adc_event		event1;
> > +	struct palmas_gpadc_thresholds	thresh_data[PALMAS_ADC_CH_MAX];
> > };
> >=20
> > +static struct palmas_adc_event *palmas_gpadc_get_event_channel(
> > +	struct palmas_gpadc *adc, int adc_chan, enum iio_event_direction di=
r)
> > +{
> > +	if (adc_chan =3D=3D adc->event0.channel && dir =3D=3D adc->event0.d=
irection)
> > +		return &adc->event0;
> > +
> > +	if (adc_chan =3D=3D adc->event1.channel && dir =3D=3D adc->event1.d=
irection)
> > +		return &adc->event1;
> > +
> > +	return NULL;
> > +}
> > +
> > +static bool palmas_gpadc_channel_is_freerunning(struct palmas_gpadc =
*adc,
> > +						int adc_chan)
> > +{
> > +	return palmas_gpadc_get_event_channel(adc, adc_chan, IIO_EV_DIR_RIS=
ING) ||
> > +		palmas_gpadc_get_event_channel(adc, adc_chan, IIO_EV_DIR_FALLING);
> > +}
> > +
> > /*
> >  * GPADC lock issue in AUTO mode.
> >  * Impact: In AUTO mode, GPADC conversion can be locked after disabli=
ng AUTO
> > @@ -188,11 +221,24 @@ static irqreturn_t palmas_gpadc_irq(int irq, vo=
id *data)
> >=20
> > static irqreturn_t palmas_gpadc_irq_auto(int irq, void *data)
> > {
> > -	struct palmas_gpadc *adc =3D data;
> > +	struct iio_dev *indio_dev =3D data;
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	struct palmas_adc_event *ev;
> >=20
> > 	dev_dbg(adc->dev, "Threshold interrupt %d occurs\n", irq);
> > 	palmas_disable_auto_conversion(adc);
> >=20
> > +	ev =3D (irq =3D=3D adc->irq_auto_0) ? &adc->event0 : &adc->event1;
> > +	if (ev->channel !=3D -1) {
> > +		enum iio_event_direction dir;
> > +		u64 code;
> > +
> > +		dir =3D ev->direction;
> > +		code =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, ev->channel,
> > +					    IIO_EV_TYPE_THRESH, dir);
> > +		iio_push_event(indio_dev, code, iio_get_time_ns(indio_dev));
> > +	}
> > +
> > 	return IRQ_HANDLED;
> > }
> >=20
> > @@ -280,6 +326,9 @@ static int palmas_gpadc_read_prepare(struct palma=
s_gpadc *adc, int adc_chan)
> > {
> > 	int ret;
> >=20
> > +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
> > +		return 0; // ADC already running
> > +
> > 	ret =3D palmas_gpadc_enable(adc, adc_chan, true);
> > 	if (ret < 0)
> > 		return ret;
> > @@ -339,28 +388,44 @@ static int palmas_gpadc_start_conversion(struct=
 palmas_gpadc *adc, int adc_chan)
> > 	unsigned int val;
> > 	int ret;
> >=20
> > -	init_completion(&adc->conv_completion);
> > -	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > -				PALMAS_GPADC_SW_SELECT,
> > -				PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
> > -				PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
> > -	if (ret < 0) {
> > -		dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
> > -		return ret;
> > -	}
> > +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan)) {
> > +		int event =3D (adc_chan =3D=3D adc->event0.channel) ? 0 : 1;
> > +		unsigned int reg =3D (event =3D=3D 0) ?
> > +			PALMAS_GPADC_AUTO_CONV0_LSB :
> > +			PALMAS_GPADC_AUTO_CONV1_LSB;
> >=20
> > -	ret =3D wait_for_completion_timeout(&adc->conv_completion,
> > -				PALMAS_ADC_CONVERSION_TIMEOUT);
> > -	if (ret =3D=3D 0) {
> > -		dev_err(adc->dev, "conversion not completed\n");
> > -		return -ETIMEDOUT;
> > +		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> > +					reg, &val, 2);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "AUTO_CONV%x_LSB read failed: %d\n",
> > +				event, ret);
> > +			return ret;
> > +		}
> > 	}
> > +	else {
> > +		init_completion(&adc->conv_completion);
> > +		ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> > +					PALMAS_GPADC_SW_SELECT,
> > +					PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
> > +					PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", ret);
> > +			return ret;
> > +		}
> >=20
> > -	ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> > -				PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
> > -	if (ret < 0) {
> > -		dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
> > -		return ret;
> > +		ret =3D wait_for_completion_timeout(&adc->conv_completion,
> > +					PALMAS_ADC_CONVERSION_TIMEOUT);
> > +		if (ret =3D=3D 0) {
> > +			dev_err(adc->dev, "conversion not completed\n");
> > +			return -ETIMEDOUT;
> > +		}
> > +
> > +		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> > +					PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
> > +		if (ret < 0) {
> > +			dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", ret);
> > +			return ret;
> > +		}
> > 	}
> >=20
> > 	ret =3D val & 0xFFF;
> > @@ -385,6 +450,80 @@ static int palmas_gpadc_get_calibrated_code(stru=
ct palmas_gpadc *adc,
> > 	return val;
> > }
> >=20
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
>=20
> What is the reason to make val =3D 0 a special handling?
> IMHO this makes the threshold levels discontinuous.

These patches has gone through a couple of internal revisions already, an=
d
one of the early versions used threshold =3D=3D 0 to mean that the event =
was
disabled.

I will re-visit the threshold calculations and update for v2.
>=20
> > +
> > +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> > +
> > +	if (!adc->adc_info[adc_chan].is_uncalibrated) {
> > +		val =3D (val * adc->adc_info[adc_chan].gain_error +
> > +		       adc->adc_info[adc_chan].offset) /
>=20
> here it would make a difference for val =3D=3D 0 and offset !=3D 0
>=20
> > +			1000;
> > +		gain_drift =3D 1002;
> > +		offset_drift =3D 2;
>=20
> where do these magic constants come from?

If I remember correctly, they where taken from one of the many datasheets
that had fractions of information available for this chip. I will documen=
t
the variables and add references in v2.

>=20
> > +	}
> > +	else {
> > +		gain_drift =3D 1022;
> > +		offset_drift =3D 36;
>=20
> same here.
>=20
> > +	}
> > +
> > +	// add tolerance to threshold
> > +	val =3D ((val + INL) * gain_drift) / 1000 + offset_drift;
>=20
> here it would make a difference for val =3D=3D 0.
>=20
> > +
> > +	// clamp to max possible value
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
>=20
> same here. And why return val and not 0 as above?

Yes, that indeed seem odd.

>=20
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
>=20
> same here - how are they related to the constants in=20
> palmas_gpadc_get_high_threshold_raw() ?
>=20
> > +        }
> > +
> > +	// calculate tolerances
> > +	val =3D ((val - INL) * gain_drift) / 1000 - offset_drift;
> > +
> > +	// clamp to minimum 0
> > +	if (val < 0)
> > +		val =3D 0;
> > +
> > +	return val;
> > +}
> > +
> > static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
> > 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
> > {
> > @@ -431,8 +570,239 @@ static int palmas_gpadc_read_raw(struct iio_dev=
 *indio_dev,
> > 	return ret;
> > }
> >=20
> > +static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, enum iio_event_type type,
> > +	enum iio_event_direction dir)
> > +{
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int adc_chan =3D chan->channel;
> > +	int ret =3D 0;
> > +
> > +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +
> > +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir)) {
> > +		ret =3D 1;
> > +	}
> > +
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
> > +				       struct palmas_adc_event *ev,
> > +				       struct palmas_adc_wakeup_property *wakeup)
> > +{
> > +	wakeup->adc_channel_number =3D ev->channel;
> > +	if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> > +		wakeup->adc_low_threshold =3D 0;
> > +		wakeup->adc_high_threshold =3D
> > +			palmas_gpadc_get_high_threshold_raw(adc, &adc->event0);
> > +	}
> > +	else {
> > +		wakeup->adc_low_threshold =3D
> > +			palmas_gpadc_get_low_threshold_raw(adc, &adc->event0);
> > +		wakeup->adc_high_threshold =3D 0;
> > +	}
> > +}
> > +
> > +static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
> > +static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
> > +
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
> > +
> > +static int palmas_gpadc_disable_event_config(struct palmas_gpadc *ad=
c,
> > +	const struct iio_chan_spec *chan, enum iio_event_direction dir)
> > +{
> > +	int adc_chan =3D chan->channel;
> > +	struct palmas_adc_event *ev =3D
> > +		palmas_gpadc_get_event_channel(adc, adc_chan, dir);
> > +
> > +	if (!ev)
> > +		return 0;
> > +
> > +	if (ev =3D=3D &adc->event0) {
> > +		adc->event0 =3D adc->event1;
> > +		ev =3D &adc->event1;
> > +	}
> > +
> > +	ev->channel =3D -1;
> > +	ev->direction =3D IIO_EV_DIR_NONE;
> > +
> > +	return palmas_gpadc_reconfigure_event_channels(adc);
> > +}
> > +
> > +static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev=
,
> > +	const struct iio_chan_spec *chan, enum iio_event_type type,
> > +	enum iio_event_direction dir, int state)
> > +{
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int adc_chan =3D chan->channel;
> > +	int ret =3D 0;
> > +
> > +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +
> > +	if (state)
> > +		ret =3D palmas_gpadc_enable_event_config(adc, chan, dir);
> > +	else
> > +		ret =3D palmas_gpadc_disable_event_config(adc, chan, dir);
> > +
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, enum iio_event_type type,
> > +	enum iio_event_direction dir, enum iio_event_info info, int *val,
> > +	int *val2)
> > +{
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int adc_chan =3D chan->channel;
> > +	int ret =3D 0;
> > +
> > +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		*val =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
> > +			adc->thresh_data[adc_chan].high_thresh :
> > +			adc->thresh_data[adc_chan].low_thresh;
> > +		ret =3D IIO_VAL_INT;
> > +		break;
> > +	default:
> > +		ret =3D -EINVAL;
> > +		break;
> > +	}
> > +
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > +static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> > +	const struct iio_chan_spec *chan, enum iio_event_type type,
> > +	enum iio_event_direction dir, enum iio_event_info info, int val,
> > +	int val2)
> > +{
> > +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > +	int adc_chan =3D chan->channel;
> > +	int ret =3D 0;
> > +
> > +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&adc->lock);
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		if (val < 0 || val > 0xFFF) {
> > +			ret =3D -EINVAL;
> > +			break;
> > +		}
> > +		if (dir =3D=3D IIO_EV_DIR_RISING)
> > +			adc->thresh_data[adc_chan].high_thresh =3D val;
> > +		else
> > +			adc->thresh_data[adc_chan].low_thresh =3D val;
> > +		break;
> > +	default:
> > +		ret =3D -EINVAL;
> > +		break;
> > +	}
> > +
> > +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
> > +		ret =3D palmas_gpadc_reconfigure_event_channels(adc);
> > +
> > +	mutex_unlock(&adc->lock);
> > +
> > +	return ret;
> > +}
> > +
> > static const struct iio_info palmas_gpadc_iio_info =3D {
> > 	.read_raw =3D palmas_gpadc_read_raw,
> > +	.read_event_config =3D palmas_gpadc_read_event_config,
> > +	.write_event_config =3D palmas_gpadc_write_event_config,
> > +	.read_event_value =3D palmas_gpadc_read_event_value,
> > +	.write_event_value =3D palmas_gpadc_write_event_value,
> > +};
> > +
> > +static const struct iio_event_spec palmas_gpadc_events[] =3D {
> > +	{
> > +		.type =3D IIO_EV_TYPE_THRESH,
> > +		.dir =3D IIO_EV_DIR_RISING,
> > +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> > +				BIT(IIO_EV_INFO_ENABLE),
> > +	}, {
> > +		.type =3D IIO_EV_TYPE_THRESH,
> > +		.dir =3D IIO_EV_DIR_FALLING,
> > +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> > +				BIT(IIO_EV_INFO_ENABLE),
> > +	},
> > };
> >=20
> > #define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
> > @@ -443,6 +813,8 @@ static const struct iio_info palmas_gpadc_iio_inf=
o =3D {
> > 			BIT(chan_info),			\
> > 	.indexed =3D 1,					\
> > 	.channel =3D PALMAS_ADC_CH_##chan,		\
> > +	.event_spec =3D palmas_gpadc_events,		\
> > +	.num_event_specs =3D ARRAY_SIZE(palmas_gpadc_events)	\
> > }
> >=20
> > static const struct iio_chan_spec palmas_gpadc_iio_channel[] =3D {
> > @@ -492,9 +864,12 @@ static int palmas_gpadc_get_adc_dt_data(struct p=
latform_device *pdev,
> > 	return 0;
> > }
> >=20
> > -static void palmas_disable_wakeup(void *dev)
> > +static void palmas_disable_wakeup(void *data)
> > {
> > -	device_wakeup_disable(dev);
> > +	struct palmas_gpadc *adc =3D data;
> > +
> > +	if (adc->wakeup1_enable || adc->wakeup2_enable)
> > +		device_wakeup_disable(adc->dev);
> > }
> >=20
> > static int palmas_gpadc_probe(struct platform_device *pdev)
> > @@ -547,36 +922,49 @@ static int palmas_gpadc_probe(struct platform_d=
evice *pdev)
> > 		return dev_err_probe(adc->dev, ret,
> > 				     "request irq %d failed\n", adc->irq);
> >=20
> > +	adc->irq_auto_0 =3D platform_get_irq(pdev, 1);
> > +	if (adc->irq_auto_0 < 0)
> > +		return dev_err_probe(adc->dev, adc->irq_auto_0,
> > +				     "get auto0 irq failed\n");
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0, NULL=
,
> > +					palmas_gpadc_irq_auto, IRQF_ONESHOT,
> > +					"palmas-adc-auto-0", indio_dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(adc->dev, ret,
> > +				     "request auto0 irq %d failed\n",
> > +				     adc->irq_auto_0);
> > +
> > +	adc->irq_auto_1 =3D platform_get_irq(pdev, 2);
> > +	if (adc->irq_auto_1 < 0)
> > +		return dev_err_probe(adc->dev, adc->irq_auto_1,
> > +				     "get auto1 irq failed\n");
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1, NULL=
,
> > +					palmas_gpadc_irq_auto, IRQF_ONESHOT,
> > +					"palmas-adc-auto-1", indio_dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(adc->dev, ret,
> > +				     "request auto1 irq %d failed\n",
> > +				     adc->irq_auto_1);
> > +
> > 	if (gpadc_pdata->adc_wakeup1_data) {
> > 		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
> > 			sizeof(adc->wakeup1_data));
> > 		adc->wakeup1_enable =3D true;
> > -		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
> > -						NULL, palmas_gpadc_irq_auto,
> > -						IRQF_ONESHOT,
> > -						"palmas-adc-auto-0", adc);
> > -		if (ret < 0)
> > -			return dev_err_probe(adc->dev, ret,
> > -					     "request auto0 irq %d failed\n",
> > -					     adc->irq_auto_0);
> > 	}
> >=20
> > 	if (gpadc_pdata->adc_wakeup2_data) {
> > 		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
> > 				sizeof(adc->wakeup2_data));
> > 		adc->wakeup2_enable =3D true;
> > -		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> > -		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
> > -						NULL, palmas_gpadc_irq_auto,
> > -						IRQF_ONESHOT,
> > -						"palmas-adc-auto-1", adc);
> > -		if (ret < 0)
> > -			return dev_err_probe(adc->dev, ret,
> > -					     "request auto1 irq %d failed\n",
> > -					     adc->irq_auto_1);
> > 	}
> >=20
> > +	adc->event0.channel =3D -1;
> > +	adc->event0.direction =3D IIO_EV_DIR_NONE;
> > +	adc->event1.channel =3D -1;
> > +	adc->event1.direction =3D IIO_EV_DIR_NONE;
> > +
> > 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> > 	if (gpadc_pdata->ch0_current <=3D 1)
> > 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> > @@ -610,20 +998,23 @@ static int palmas_gpadc_probe(struct platform_d=
evice *pdev)
> > 		return dev_err_probe(adc->dev, ret,
> > 				     "iio_device_register() failed\n");
> >=20
> > -	device_set_wakeup_capable(&pdev->dev, 1);
> > 	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
> > 		if (!(adc->adc_info[i].is_uncalibrated))
> > 			palmas_gpadc_calibrate(adc, i);
> > 	}
> >=20
> > +	device_set_wakeup_capable(&pdev->dev, 1);
> > 	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> > -		device_wakeup_enable(&pdev->dev);
> > -		ret =3D devm_add_action_or_reset(&pdev->dev,
> > -					       palmas_disable_wakeup,
> > -					       &pdev->dev);
> > +		ret =3D palmas_adc_wakeup_configure(adc);
> > 		if (ret)
> > 			return ret;
> > +		device_wakeup_enable(&pdev->dev);
> > 	}
> > +	ret =3D devm_add_action_or_reset(&pdev->dev,
> > +				       palmas_disable_wakeup,
> > +				       adc);
> > +	if (ret)
> > +		return ret;
> >=20
> > 	return 0;
> > }
> > @@ -755,16 +1146,11 @@ static int palmas_gpadc_suspend(struct device =
*dev)
> > {
> > 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > -	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > 	int ret;
> >=20
> > -	if (!device_may_wakeup(dev) || !wakeup)
> > +	if (!device_may_wakeup(dev))
> > 		return 0;
> >=20
> > -	ret =3D palmas_adc_wakeup_configure(adc);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > 	if (adc->wakeup1_enable)
> > 		enable_irq_wake(adc->irq_auto_0);
> >=20
> > @@ -778,16 +1164,11 @@ static int palmas_gpadc_resume(struct device *=
dev)
> > {
> > 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> > 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> > -	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> > 	int ret;
> >=20
> > -	if (!device_may_wakeup(dev) || !wakeup)
> > +	if (!device_may_wakeup(dev))
> > 		return 0;
> >=20
> > -	ret =3D palmas_adc_wakeup_reset(adc);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > 	if (adc->wakeup1_enable)
> > 		disable_irq_wake(adc->irq_auto_0);
> >=20
> > --=20
> > 2.25.1
> >=20
>=20
>=20
>=20
