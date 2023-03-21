Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038626C3C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCUUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjCUUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:41:01 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DDF4B814;
        Tue, 21 Mar 2023 13:40:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1679431207; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BR3y7OjJeuhpOG2tVOuPlnR439buQ0FvpK8gC74HBrNS1ZlmOg/6aTWUl0CDDQT38Z
    VbNa4dwf436iL0CbPI+3OGMQacqu53I/IbPyTKswA810FWWsk32/mnCXE8J/FM3QB5W0
    L8+NWqY5hyFteuSvBpVduYVTT3DLkKL67yzeOcxdGwzb+3P2NyHUFh1Wh153Bm3bm48i
    ZKUZpbETi6AfYjEwobOPLfzPdkyMlo3ePKIpubTmbfG6U0usOzpgbzs/pVmvjmW4qPWs
    23BuFPuNRUR/9HHy6zWtrBzrUQfM9p4qgqDcF8dWCfcaPJ7yZMvAWj0V3ZcETKr7TNVx
    n/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431207;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VOCaAmfmgYifkoyFHlUTFWIjE4/f2bdszMEEpgktszw=;
    b=d/Nlny75VvADt4kOr4csgbNkbKI+cufmyc1aM2Obd4LSCyhad0nW/eXliQTtduYlVa
    I10cj4nhJkFwGhstmgVvXiXUm7cv1rBw6dqpsVnI4+ggxyzMZew9jAtW6VTcUrSN1aE1
    mIuVbqNqlzcOxEDDsboa5h8HE07uDZ2E7T85JAUw64XRXny7d//L8MF5SpNxyEwmqHTt
    fdmx0z9FrHsZnX73VxgwppW4JwY2MCrR4LrcZ1fDOHQCNyqFMPV0hnyWE7CQzhSUJqHY
    h5SqOYdozPJTCJaZSzDpsXK4b/WJ5XS43O2kIOiQVh8nPWyBJzewteLxQ5hRnXJ18jGu
    S61w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1679431207;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=VOCaAmfmgYifkoyFHlUTFWIjE4/f2bdszMEEpgktszw=;
    b=nYiSs3kDPjKVI/kPh0Cvm31c0VfpH1xcwPCPrf8uHxTovyVy3wnyXOguVlCul9o2gb
    lubpotnBPAIfeZCp5DelMUvXHOXIPC1Hkyfm7MtZH+FbnujYenhScYkm8LvJMzWX0LrU
    f+N6lq5v8YkksxVObjedj/2Dk45hDiRnPKjAbQ3BVn64NWgx5T8r3d5oybHDMSzMX1aU
    FQ0mNHm8NhAT+jXvk7YRWHzuMJjKqR6AgXvbl955eFo9AcWYz9In1EBBjZiXUVzrga7Q
    7zUZFUTlF+0D5NDV1RFC1XReFhnCeqcfei0ReHRcYp3qgCSdgPDfJXMkxGCiCItg19vK
    gqSw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGZizY="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.3.1 DYNA|AUTH)
    with ESMTPSA id R24ce1z2LKe7KrX
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 21 Mar 2023 21:40:07 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH 1/3] iio: adc: palmas_gpadc: add support for iio threshold
 events
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230319223908.108540-2-risca@dalakolonin.se>
Date:   Tue, 21 Mar 2023 21:40:07 +0100
Cc:     linux-iio@vger.kernel.org,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, jic23@kernel.org, lars@metafoo.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D0EF51A-CED1-44E6-8B6E-8CFFDEAC8077@goldelico.com>
References: <20230319223908.108540-1-risca@dalakolonin.se>
 <20230319223908.108540-2-risca@dalakolonin.se>
To:     =?utf-8?Q?Patrik_Dahlstr=C3=B6m?= <risca@dalakolonin.se>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrik,

> Am 19.03.2023 um 23:39 schrieb Patrik Dahlstr=C3=B6m =
<risca@dalakolonin.se>:
>=20
> The palmas gpadc block has support for monitoring up to 2 ADC channels
> and issue an interrupt if they reach past a set threshold. The gpadc
> driver had limited support for this through the adc_wakeup{1,2}_data
> platform data. This however only allow a fixed threshold to be set at
> boot, and would only enable it when entering sleep mode.
>=20
> This change hooks into the IIO events system and exposes to userspace
> the ability to configure threshold values for each channel =
individually,
> but only allow up to 2 such thresholds to be enabled at any given =
time.
>=20
> The logic around suspend and resume had to be adjusted so that user
> space configuration don't get reset on resume. Instead, any configured
> adc auto wakeup gets enabled during probe.
>=20
> Enabling a threshold from userspace will overwrite the adc wakeup
> configuration set during probe. Depending on how you look at it, this
> could also mean we allow userspace to update the adc wakeup =
thresholds.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> ---
> drivers/iio/adc/palmas_gpadc.c | 495 +++++++++++++++++++++++++++++----
> 1 file changed, 438 insertions(+), 57 deletions(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c =
b/drivers/iio/adc/palmas_gpadc.c
> index 24d7c096e4b8..84c6e3b66205 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -20,6 +20,7 @@
> #include <linux/completion.h>
> #include <linux/of.h>
> #include <linux/of_device.h>
> +#include <linux/iio/events.h>
> #include <linux/iio/iio.h>
> #include <linux/iio/machine.h>
> #include <linux/iio/driver.h>
> @@ -76,6 +77,16 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =
=3D {
> 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> };
>=20
> +struct palmas_gpadc_thresholds {
> +	int high_thresh;
> +	int low_thresh;
> +};
> +
> +struct palmas_adc_event {
> +	int channel;
> +	enum iio_event_direction direction;
> +};
> +
> /*
>  * struct palmas_gpadc - the palmas_gpadc structure
>  * @ch0_current:	channel 0 current source setting
> @@ -117,8 +128,30 @@ struct palmas_gpadc {
> 	bool				wakeup2_enable;
> 	int				auto_conversion_period;
> 	struct mutex			lock;
> +	struct palmas_adc_event		event0;
> +	struct palmas_adc_event		event1;
> +	struct palmas_gpadc_thresholds	thresh_data[PALMAS_ADC_CH_MAX];
> };
>=20
> +static struct palmas_adc_event *palmas_gpadc_get_event_channel(
> +	struct palmas_gpadc *adc, int adc_chan, enum iio_event_direction =
dir)
> +{
> +	if (adc_chan =3D=3D adc->event0.channel && dir =3D=3D =
adc->event0.direction)
> +		return &adc->event0;
> +
> +	if (adc_chan =3D=3D adc->event1.channel && dir =3D=3D =
adc->event1.direction)
> +		return &adc->event1;
> +
> +	return NULL;
> +}
> +
> +static bool palmas_gpadc_channel_is_freerunning(struct palmas_gpadc =
*adc,
> +						int adc_chan)
> +{
> +	return palmas_gpadc_get_event_channel(adc, adc_chan, =
IIO_EV_DIR_RISING) ||
> +		palmas_gpadc_get_event_channel(adc, adc_chan, =
IIO_EV_DIR_FALLING);
> +}
> +
> /*
>  * GPADC lock issue in AUTO mode.
>  * Impact: In AUTO mode, GPADC conversion can be locked after =
disabling AUTO
> @@ -188,11 +221,24 @@ static irqreturn_t palmas_gpadc_irq(int irq, =
void *data)
>=20
> static irqreturn_t palmas_gpadc_irq_auto(int irq, void *data)
> {
> -	struct palmas_gpadc *adc =3D data;
> +	struct iio_dev *indio_dev =3D data;
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	struct palmas_adc_event *ev;
>=20
> 	dev_dbg(adc->dev, "Threshold interrupt %d occurs\n", irq);
> 	palmas_disable_auto_conversion(adc);
>=20
> +	ev =3D (irq =3D=3D adc->irq_auto_0) ? &adc->event0 : =
&adc->event1;
> +	if (ev->channel !=3D -1) {
> +		enum iio_event_direction dir;
> +		u64 code;
> +
> +		dir =3D ev->direction;
> +		code =3D IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, ev->channel,
> +					    IIO_EV_TYPE_THRESH, dir);
> +		iio_push_event(indio_dev, code, =
iio_get_time_ns(indio_dev));
> +	}
> +
> 	return IRQ_HANDLED;
> }
>=20
> @@ -280,6 +326,9 @@ static int palmas_gpadc_read_prepare(struct =
palmas_gpadc *adc, int adc_chan)
> {
> 	int ret;
>=20
> +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan))
> +		return 0; // ADC already running
> +
> 	ret =3D palmas_gpadc_enable(adc, adc_chan, true);
> 	if (ret < 0)
> 		return ret;
> @@ -339,28 +388,44 @@ static int palmas_gpadc_start_conversion(struct =
palmas_gpadc *adc, int adc_chan)
> 	unsigned int val;
> 	int ret;
>=20
> -	init_completion(&adc->conv_completion);
> -	ret =3D palmas_update_bits(adc->palmas, PALMAS_GPADC_BASE,
> -				PALMAS_GPADC_SW_SELECT,
> -				PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
> -				PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
> -	if (ret < 0) {
> -		dev_err(adc->dev, "SELECT_SW_START write failed: %d\n", =
ret);
> -		return ret;
> -	}
> +	if (palmas_gpadc_channel_is_freerunning(adc, adc_chan)) {
> +		int event =3D (adc_chan =3D=3D adc->event0.channel) ? 0 =
: 1;
> +		unsigned int reg =3D (event =3D=3D 0) ?
> +			PALMAS_GPADC_AUTO_CONV0_LSB :
> +			PALMAS_GPADC_AUTO_CONV1_LSB;
>=20
> -	ret =3D wait_for_completion_timeout(&adc->conv_completion,
> -				PALMAS_ADC_CONVERSION_TIMEOUT);
> -	if (ret =3D=3D 0) {
> -		dev_err(adc->dev, "conversion not completed\n");
> -		return -ETIMEDOUT;
> +		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> +					reg, &val, 2);
> +		if (ret < 0) {
> +			dev_err(adc->dev, "AUTO_CONV%x_LSB read failed: =
%d\n",
> +				event, ret);
> +			return ret;
> +		}
> 	}
> +	else {
> +		init_completion(&adc->conv_completion);
> +		ret =3D palmas_update_bits(adc->palmas, =
PALMAS_GPADC_BASE,
> +					PALMAS_GPADC_SW_SELECT,
> +					=
PALMAS_GPADC_SW_SELECT_SW_START_CONV0,
> +					=
PALMAS_GPADC_SW_SELECT_SW_START_CONV0);
> +		if (ret < 0) {
> +			dev_err(adc->dev, "SELECT_SW_START write failed: =
%d\n", ret);
> +			return ret;
> +		}
>=20
> -	ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> -				PALMAS_GPADC_SW_CONV0_LSB, &val, 2);
> -	if (ret < 0) {
> -		dev_err(adc->dev, "SW_CONV0_LSB read failed: %d\n", =
ret);
> -		return ret;
> +		ret =3D =
wait_for_completion_timeout(&adc->conv_completion,
> +					PALMAS_ADC_CONVERSION_TIMEOUT);
> +		if (ret =3D=3D 0) {
> +			dev_err(adc->dev, "conversion not completed\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		ret =3D palmas_bulk_read(adc->palmas, PALMAS_GPADC_BASE,
> +					PALMAS_GPADC_SW_CONV0_LSB, &val, =
2);
> +		if (ret < 0) {
> +			dev_err(adc->dev, "SW_CONV0_LSB read failed: =
%d\n", ret);
> +			return ret;
> +		}
> 	}
>=20
> 	ret =3D val & 0xFFF;
> @@ -385,6 +450,80 @@ static int =
palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
> 	return val;
> }
>=20
> +static int palmas_gpadc_get_high_threshold_raw(struct palmas_gpadc =
*adc,
> +					       struct palmas_adc_event =
*ev)
> +{
> +	const int INL =3D 2;
> +	const int adc_chan =3D ev->channel;
> +	const int orig =3D adc->thresh_data[adc_chan].high_thresh;
> +	int val =3D orig;
> +	int gain_drift;
> +	int offset_drift;
> +
> +	if (!val)
> +		return 0;

What is the reason to make val =3D 0 a special handling?
IMHO this makes the threshold levels discontinuous.

> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +	if (!adc->adc_info[adc_chan].is_uncalibrated) {
> +		val =3D (val * adc->adc_info[adc_chan].gain_error +
> +		       adc->adc_info[adc_chan].offset) /

here it would make a difference for val =3D=3D 0 and offset !=3D 0

> +			1000;
> +		gain_drift =3D 1002;
> +		offset_drift =3D 2;

where do these magic constants come from?

> +	}
> +	else {
> +		gain_drift =3D 1022;
> +		offset_drift =3D 36;

same here.

> +	}
> +
> +	// add tolerance to threshold
> +	val =3D ((val + INL) * gain_drift) / 1000 + offset_drift;

here it would make a difference for val =3D=3D 0.

> +
> +	// clamp to max possible value
> +	if (val > 0xFFF)
> +		val =3D 0xFFF;
> +
> +	return val;
> +}
> +
> +static int palmas_gpadc_get_low_threshold_raw(struct palmas_gpadc =
*adc,
> +					      struct palmas_adc_event =
*ev)
> +{
> +	const int INL =3D 2;
> +	const int adc_chan =3D ev->channel;
> +	const int orig =3D adc->thresh_data[adc_chan].low_thresh;
> +	int val =3D orig;
> +	int gain_drift;
> +	int offset_drift;
> +
> +	if (!val)
> +		return val;

same here. And why return val and not 0 as above?

> +
> +	val =3D (val * 1000) / adc->adc_info[adc_chan].gain;
> +
> +        if (!adc->adc_info[adc_chan].is_uncalibrated) {
> +            val =3D (val * adc->adc_info[adc_chan].gain_error -
> +		   adc->adc_info[adc_chan].offset) /
> +		    1000;
> +            gain_drift =3D 998;
> +            offset_drift =3D 2;
> +        }
> +        else {
> +            gain_drift =3D 978;
> +            offset_drift =3D 36;

same here - how are they related to the constants in=20
palmas_gpadc_get_high_threshold_raw() ?

> +        }
> +
> +	// calculate tolerances
> +	val =3D ((val - INL) * gain_drift) / 1000 - offset_drift;
> +
> +	// clamp to minimum 0
> +	if (val < 0)
> +		val =3D 0;
> +
> +	return val;
> +}
> +
> static int palmas_gpadc_read_raw(struct iio_dev *indio_dev,
> 	struct iio_chan_spec const *chan, int *val, int *val2, long =
mask)
> {
> @@ -431,8 +570,239 @@ static int palmas_gpadc_read_raw(struct iio_dev =
*indio_dev,
> 	return ret;
> }
>=20
> +static int palmas_gpadc_read_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D =
IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir)) {
> +		ret =3D 1;
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static void palmas_adc_event_to_wakeup(struct palmas_gpadc *adc,
> +				       struct palmas_adc_event *ev,
> +				       struct palmas_adc_wakeup_property =
*wakeup)
> +{
> +	wakeup->adc_channel_number =3D ev->channel;
> +	if (ev->direction =3D=3D IIO_EV_DIR_RISING) {
> +		wakeup->adc_low_threshold =3D 0;
> +		wakeup->adc_high_threshold =3D
> +			palmas_gpadc_get_high_threshold_raw(adc, =
&adc->event0);
> +	}
> +	else {
> +		wakeup->adc_low_threshold =3D
> +			palmas_gpadc_get_low_threshold_raw(adc, =
&adc->event0);
> +		wakeup->adc_high_threshold =3D 0;
> +	}
> +}
> +
> +static int palmas_adc_wakeup_configure(struct palmas_gpadc *adc);
> +static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc);
> +
> +static int palmas_gpadc_reconfigure_event_channels(struct =
palmas_gpadc *adc)
> +{
> +	bool was_enabled =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	bool enable;
> +
> +	adc->wakeup1_enable =3D adc->event0.channel =3D=3D -1 ? false : =
true;
> +	adc->wakeup2_enable =3D adc->event1.channel =3D=3D -1 ? false : =
true;
> +
> +	enable =3D adc->wakeup1_enable || adc->wakeup2_enable;
> +	if (!was_enabled && enable)
> +		device_wakeup_enable(adc->dev);
> +	else if (was_enabled && !enable)
> +		device_wakeup_disable(adc->dev);
> +
> +	if (!enable)
> +		return palmas_adc_wakeup_reset(adc);
> +
> +	// adjust levels
> +	if (adc->wakeup1_enable)
> +		palmas_adc_event_to_wakeup(adc, &adc->event0, =
&adc->wakeup1_data);
> +	if (adc->wakeup2_enable)
> +		palmas_adc_event_to_wakeup(adc, &adc->event1, =
&adc->wakeup2_data);
> +
> +	return palmas_adc_wakeup_configure(adc);
> +}
> +
> +static int palmas_gpadc_enable_event_config(struct palmas_gpadc *adc,
> +	const struct iio_chan_spec *chan, enum iio_event_direction dir)
> +{
> +	struct palmas_adc_event *ev;
> +	int adc_chan =3D chan->channel;
> +
> +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
> +		/* already enabled */
> +		return 0;
> +
> +	if (adc->event0.channel =3D=3D -1)
> +		ev =3D &adc->event0;
> +	else if (adc->event1.channel =3D=3D -1) {
> +		/* event0 has to be the lowest channel */
> +		if (adc_chan < adc->event0.channel) {
> +			adc->event1 =3D adc->event0;
> +			ev =3D &adc->event0;
> +		}
> +		else
> +			ev =3D &adc->event1;
> +	}
> +	else /* both AUTO channels already in use */ {
> +		dev_warn(adc->dev, "event0 - %d, event1 - %d\n",
> +			 adc->event0.channel, adc->event1.channel);
> +		return -EBUSY;
> +	}
> +
> +	ev->channel =3D adc_chan;
> +	ev->direction =3D dir;
> +
> +	return palmas_gpadc_reconfigure_event_channels(adc);
> +}
> +
> +static int palmas_gpadc_disable_event_config(struct palmas_gpadc =
*adc,
> +	const struct iio_chan_spec *chan, enum iio_event_direction dir)
> +{
> +	int adc_chan =3D chan->channel;
> +	struct palmas_adc_event *ev =3D
> +		palmas_gpadc_get_event_channel(adc, adc_chan, dir);
> +
> +	if (!ev)
> +		return 0;
> +
> +	if (ev =3D=3D &adc->event0) {
> +		adc->event0 =3D adc->event1;
> +		ev =3D &adc->event1;
> +	}
> +
> +	ev->channel =3D -1;
> +	ev->direction =3D IIO_EV_DIR_NONE;
> +
> +	return palmas_gpadc_reconfigure_event_channels(adc);
> +}
> +
> +static int palmas_gpadc_write_event_config(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, int state)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D =
IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (state)
> +		ret =3D palmas_gpadc_enable_event_config(adc, chan, =
dir);
> +	else
> +		ret =3D palmas_gpadc_disable_event_config(adc, chan, =
dir);
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int palmas_gpadc_read_event_value(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int =
*val,
> +	int *val2)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D =
IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		*val =3D (dir =3D=3D IIO_EV_DIR_RISING) ?
> +			adc->thresh_data[adc_chan].high_thresh :
> +			adc->thresh_data[adc_chan].low_thresh;
> +		ret =3D IIO_VAL_INT;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> +static int palmas_gpadc_write_event_value(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, enum iio_event_type type,
> +	enum iio_event_direction dir, enum iio_event_info info, int val,
> +	int val2)
> +{
> +	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> +	int adc_chan =3D chan->channel;
> +	int ret =3D 0;
> +
> +	if (adc_chan > PALMAS_ADC_CH_MAX || type !=3D =
IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	mutex_lock(&adc->lock);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (val < 0 || val > 0xFFF) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +		if (dir =3D=3D IIO_EV_DIR_RISING)
> +			adc->thresh_data[adc_chan].high_thresh =3D val;
> +		else
> +			adc->thresh_data[adc_chan].low_thresh =3D val;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	if (palmas_gpadc_get_event_channel(adc, adc_chan, dir))
> +		ret =3D palmas_gpadc_reconfigure_event_channels(adc);
> +
> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}
> +
> static const struct iio_info palmas_gpadc_iio_info =3D {
> 	.read_raw =3D palmas_gpadc_read_raw,
> +	.read_event_config =3D palmas_gpadc_read_event_config,
> +	.write_event_config =3D palmas_gpadc_write_event_config,
> +	.read_event_value =3D palmas_gpadc_read_event_value,
> +	.write_event_value =3D palmas_gpadc_write_event_value,
> +};
> +
> +static const struct iio_event_spec palmas_gpadc_events[] =3D {
> +	{
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_RISING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				BIT(IIO_EV_INFO_ENABLE),
> +	}, {
> +		.type =3D IIO_EV_TYPE_THRESH,
> +		.dir =3D IIO_EV_DIR_FALLING,
> +		.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +				BIT(IIO_EV_INFO_ENABLE),
> +	},
> };
>=20
> #define PALMAS_ADC_CHAN_IIO(chan, _type, chan_info)	\
> @@ -443,6 +813,8 @@ static const struct iio_info palmas_gpadc_iio_info =
=3D {
> 			BIT(chan_info),			\
> 	.indexed =3D 1,					\
> 	.channel =3D PALMAS_ADC_CH_##chan,		\
> +	.event_spec =3D palmas_gpadc_events,		\
> +	.num_event_specs =3D ARRAY_SIZE(palmas_gpadc_events)	\
> }
>=20
> static const struct iio_chan_spec palmas_gpadc_iio_channel[] =3D {
> @@ -492,9 +864,12 @@ static int palmas_gpadc_get_adc_dt_data(struct =
platform_device *pdev,
> 	return 0;
> }
>=20
> -static void palmas_disable_wakeup(void *dev)
> +static void palmas_disable_wakeup(void *data)
> {
> -	device_wakeup_disable(dev);
> +	struct palmas_gpadc *adc =3D data;
> +
> +	if (adc->wakeup1_enable || adc->wakeup2_enable)
> +		device_wakeup_disable(adc->dev);
> }
>=20
> static int palmas_gpadc_probe(struct platform_device *pdev)
> @@ -547,36 +922,49 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
> 		return dev_err_probe(adc->dev, ret,
> 				     "request irq %d failed\n", =
adc->irq);
>=20
> +	adc->irq_auto_0 =3D platform_get_irq(pdev, 1);
> +	if (adc->irq_auto_0 < 0)
> +		return dev_err_probe(adc->dev, adc->irq_auto_0,
> +				     "get auto0 irq failed\n");
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0, =
NULL,
> +					palmas_gpadc_irq_auto, =
IRQF_ONESHOT,
> +					"palmas-adc-auto-0", indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(adc->dev, ret,
> +				     "request auto0 irq %d failed\n",
> +				     adc->irq_auto_0);
> +
> +	adc->irq_auto_1 =3D platform_get_irq(pdev, 2);
> +	if (adc->irq_auto_1 < 0)
> +		return dev_err_probe(adc->dev, adc->irq_auto_1,
> +				     "get auto1 irq failed\n");
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1, =
NULL,
> +					palmas_gpadc_irq_auto, =
IRQF_ONESHOT,
> +					"palmas-adc-auto-1", indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(adc->dev, ret,
> +				     "request auto1 irq %d failed\n",
> +				     adc->irq_auto_1);
> +
> 	if (gpadc_pdata->adc_wakeup1_data) {
> 		memcpy(&adc->wakeup1_data, =
gpadc_pdata->adc_wakeup1_data,
> 			sizeof(adc->wakeup1_data));
> 		adc->wakeup1_enable =3D true;
> -		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> -		ret =3D devm_request_threaded_irq(&pdev->dev, =
adc->irq_auto_0,
> -						NULL, =
palmas_gpadc_irq_auto,
> -						IRQF_ONESHOT,
> -						"palmas-adc-auto-0", =
adc);
> -		if (ret < 0)
> -			return dev_err_probe(adc->dev, ret,
> -					     "request auto0 irq %d =
failed\n",
> -					     adc->irq_auto_0);
> 	}
>=20
> 	if (gpadc_pdata->adc_wakeup2_data) {
> 		memcpy(&adc->wakeup2_data, =
gpadc_pdata->adc_wakeup2_data,
> 				sizeof(adc->wakeup2_data));
> 		adc->wakeup2_enable =3D true;
> -		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> -		ret =3D devm_request_threaded_irq(&pdev->dev, =
adc->irq_auto_1,
> -						NULL, =
palmas_gpadc_irq_auto,
> -						IRQF_ONESHOT,
> -						"palmas-adc-auto-1", =
adc);
> -		if (ret < 0)
> -			return dev_err_probe(adc->dev, ret,
> -					     "request auto1 irq %d =
failed\n",
> -					     adc->irq_auto_1);
> 	}
>=20
> +	adc->event0.channel =3D -1;
> +	adc->event0.direction =3D IIO_EV_DIR_NONE;
> +	adc->event1.channel =3D -1;
> +	adc->event1.direction =3D IIO_EV_DIR_NONE;
> +
> 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> 	if (gpadc_pdata->ch0_current <=3D 1)
> 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> @@ -610,20 +998,23 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
> 		return dev_err_probe(adc->dev, ret,
> 				     "iio_device_register() failed\n");
>=20
> -	device_set_wakeup_capable(&pdev->dev, 1);
> 	for (i =3D 0; i < PALMAS_ADC_CH_MAX; i++) {
> 		if (!(adc->adc_info[i].is_uncalibrated))
> 			palmas_gpadc_calibrate(adc, i);
> 	}
>=20
> +	device_set_wakeup_capable(&pdev->dev, 1);
> 	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> -		device_wakeup_enable(&pdev->dev);
> -		ret =3D devm_add_action_or_reset(&pdev->dev,
> -					       palmas_disable_wakeup,
> -					       &pdev->dev);
> +		ret =3D palmas_adc_wakeup_configure(adc);
> 		if (ret)
> 			return ret;
> +		device_wakeup_enable(&pdev->dev);
> 	}
> +	ret =3D devm_add_action_or_reset(&pdev->dev,
> +				       palmas_disable_wakeup,
> +				       adc);
> +	if (ret)
> +		return ret;
>=20
> 	return 0;
> }
> @@ -755,16 +1146,11 @@ static int palmas_gpadc_suspend(struct device =
*dev)
> {
> 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> 	int ret;
>=20
> -	if (!device_may_wakeup(dev) || !wakeup)
> +	if (!device_may_wakeup(dev))
> 		return 0;
>=20
> -	ret =3D palmas_adc_wakeup_configure(adc);
> -	if (ret < 0)
> -		return ret;
> -
> 	if (adc->wakeup1_enable)
> 		enable_irq_wake(adc->irq_auto_0);
>=20
> @@ -778,16 +1164,11 @@ static int palmas_gpadc_resume(struct device =
*dev)
> {
> 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
> -	int wakeup =3D adc->wakeup1_enable || adc->wakeup2_enable;
> 	int ret;
>=20
> -	if (!device_may_wakeup(dev) || !wakeup)
> +	if (!device_may_wakeup(dev))
> 		return 0;
>=20
> -	ret =3D palmas_adc_wakeup_reset(adc);
> -	if (ret < 0)
> -		return ret;
> -
> 	if (adc->wakeup1_enable)
> 		disable_irq_wake(adc->irq_auto_0);
>=20
> --=20
> 2.25.1
>=20

