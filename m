Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F25E5860
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiIVCIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIVCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:08:00 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498498D1F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:07:58 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id v130so10581077oie.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oFx+HsY7kvI5Lex3d1+0gi4P29rbHEzC8zGsu9GNCOg=;
        b=SUsCkgJIsBTElgdKCeb3MhyA1ss25hmQemd5MhFP0sT8KmLTWsmAgUST8NZjgD037b
         7t6GzzkKbOCXTKOljbgOptrWw9FAj4ogM8K37cNkURElNmbKZDJFnL4IsUtSqV1ZVprS
         QHt0+Iko0sKOXr8U1/736xbd0jESqdMH7PxdeaDhGw87M+MoW9OHgqN7566vD+PGganX
         iz5DZcE1GUE7pWdZMspIZums2z/iZmLZVEW7EDD+QHW/NFiVx1rJCEVbIZyKrn14jhaj
         pNSIN8voLCVziERn92I2A5ZIr3ZJLzieW9N09N/XZk7amb2ucPa2Lst8Plwvpe4gPVT1
         wH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oFx+HsY7kvI5Lex3d1+0gi4P29rbHEzC8zGsu9GNCOg=;
        b=iWv7GU7Bja8T9ff1OeSieURKIcG6bZnpWzSQp6QnoeMG3l9SpLoio9jL6t1GSjVKbf
         aLPv7Zbkfa9+EfrRxXnzYItPCz3ecCGPQQ+wi2gQupBdzrspcQSFqu45OVHqZwn5E6ww
         zQVBTQMNRVCJh4N/rmwt9U35R4J29O8TjQM3G5csEc9cj/TSG+hf82C/vZLqnotunrBY
         mSsDKGKJf/y/jIh0N6DR9sz+ZyUeaXt1Uq0H79UKIo3jkRxU2UtzDCThx8SJW63pzmUk
         41bOlUUGtbYWyJPu1cDlc944YC8jElIqUn6klZZ5D2tKbv594oyUfZRH6Z1PQAx070IO
         doCA==
X-Gm-Message-State: ACrzQf2CpPeWk8Ffi2107af3yKlgbV4ULdOm+eerlDBo2YLfwDYMxDqP
        qaR4ksIUkHLZFIokKqGkQMSxqw==
X-Google-Smtp-Source: AMsMyM7hUmFAqevf8efSZ+qUrwotMzy/7hT4SuKlfx8D2LL0w+WWXW+GX5V7DTQxwahCp87Bxx4oog==
X-Received: by 2002:a05:6808:1a24:b0:350:78b0:9c2c with SMTP id bk36-20020a0568081a2400b0035078b09c2cmr5197313oib.143.1663812477760;
        Wed, 21 Sep 2022 19:07:57 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id w25-20020a9d77d9000000b00656039161b1sm2129577otl.40.2022.09.21.19.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 19:07:56 -0700 (PDT)
Date:   Wed, 21 Sep 2022 22:07:54 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v7 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <YyvDeuHgWPmcrqPR@fedora>
References: <20220921100627.124085-1-jpanis@baylibre.com>
 <20220921100627.124085-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CIfG5Izydz6MDoAL"
Content-Disposition: inline
In-Reply-To: <20220921100627.124085-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CIfG5Izydz6MDoAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 12:06:26PM +0200, Julien Panis wrote:
> ECAP hardware on TI AM62x SoC supports capture feature. It can be used
> to timestamp events (falling/rising edges) detected on input signal.
>=20
> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>=20
> In the ECAP hardware, capture pin can also be configured to be in
> PWM mode. Current implementation only supports capture operating mode.
> Hardware also supports timebase sync between multiple instances, but
> this driver supports simple independent capture functionality.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Hi Julien,

This driver is almost there; some comments follow below.

> +static u8 ecap_cnt_capture_get_evmode(struct counter_device *counter)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	u8 ev_mode =3D 0;
> +	unsigned int regval;
> +	int i;
> +
> +	pm_runtime_get_sync(counter->parent);
> +	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
> +	pm_runtime_put_sync(counter->parent);
> +
> +	for (i =3D 0 ; i < ECAP_NB_CEVT ; i++) {
> +		if (regval & ECAP_CAPPOL_BIT(i))
> +			ev_mode |=3D ECAP_EV_MODE_BIT(i);
> +	}

Looks like this for loop is just remapping the set bits in regval to
ev_mode. You can use bitmap_remap() here instead to simplify this
section of code.

> +static void ecap_cnt_capture_set_evmode(struct counter_device *counter, =
u8 ev_mode)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	unsigned int regval =3D 0;
> +	int i;
> +
> +	for (i =3D 0 ; i < ECAP_NB_CEVT ; i++) {
> +		if (ev_mode & ECAP_EV_MODE_BIT(i))
> +			regval |=3D ECAP_CAPPOL_BIT(i);
> +	}

Use bitmap_remap() here as well (just in the reverse direction).

> +static int ecap_cnt_count_write(struct counter_device *counter,
> +				struct counter_count *count, u64 val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;
> +	if (val > 0)
> +		return -EINVAL;

The ECAP_TSCNT_REG can be set to an arbitrary count value so there's no
need to restrict val here to 0. Instead, check that val is within the
ceiling value (<=3D U32_MAX) and return -ERANGE if it is not.

> +static int ecap_cnt_watch_validate(struct counter_device *counter,
> +				   const struct counter_watch *watch)
> +{
> +	if ((watch->channel <=3D ECAP_CEVT_LAST && watch->event =3D=3D COUNTER_=
EVENT_CAPTURE) ||
> +	    (watch->channel =3D=3D ECAP_CNTOVF && watch->event =3D=3D COUNTER_E=
VENT_OVERFLOW))
> +		return 0;
> +
> +	return -EINVAL;

COUNTER_EVENT_OVERFLOW shouldn't be on a separate channel; I'll explain
why later below in the interrupt handler review.

For this callback, you can separate the channel and event type checks to
their own blocks:

    if (watch->channel > ECAP_CEVT_LAST)
            return -EINVAL;
   =20
    switch (watch->event) {
    case COUNTER_EVENT_CAPTURE:
    case COUNTER_EVENT_OVERFLOW:
            return 0;
    default:
            return -EINVAL;
    }

> +static int ecap_cnt_pol_read(struct counter_device *counter,
> +			     struct counter_signal *signal,
> +			     size_t idx, enum counter_signal_polarity *pol)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	pm_runtime_get_sync(counter->parent);
> +	*pol =3D regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL=
_BIT(idx)) ?
> +	       COUNTER_SIGNAL_POLARITY_NEGATIVE :
> +	       COUNTER_SIGNAL_POLARITY_POSITIVE;

This single line is doing a lot of things so I would rather see it
broken down. Save the regmap_test_bits() to a temporary local variable
first before evaluating to set *pol. This allows you to move the *pol
set operation to outside of the pm runtime syncs, possibly giving you a
marginal improvement in latency as well.

> +static inline int ecap_cnt_cap_read(struct counter_device *counter,
> +				    struct counter_count *count,
> +				    size_t idx, u64 *cap)
> +{
> +	return ecap_cnt_count_get_val(counter, ECAP_CAP_REG(idx), cap);
> +}

I don't remember if we've discussed this before, but if these capture
registers can be set then it'll be useful to provide a corresponding
ecap_cnt_cap_write() function for them as well.

> +static int ecap_cnt_nb_ovf_write(struct counter_device *counter,
> +				 struct counter_count *count, u64 val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;
> +	if (val > 0)
> +		return -EINVAL;

Similar to the count_write() callback, check that val is <=3D U32_MAX and
return -ERANGE otherwise.

> +static DEFINE_COUNTER_ARRAY_U64(ecap_cnt_cap_array, ECAP_NB_CEVT);
> +
> +static struct counter_comp ecap_cnt_count_ext[] =3D {
> +	COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_c=
nt_cap_array),

Use the DEFINE_COUNTER_ARRAY_CAPTURE() and COUNTER_COMP_ARRAY_CAPTURE()
macros.

> +static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
> +{
> +	struct counter_device *counter_dev =3D dev_id;
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +	unsigned int clr =3D 0;
> +	unsigned int flg;
> +	int i;
> +
> +	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
> +
> +	/* Check capture events */
> +	for (i =3D 0 ; i < ECAP_NB_CEVT ; i++) {
> +		if (flg & ECAP_EVT_FLG_BIT(i)) {
> +			counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);
> +			clr |=3D ECAP_EVT_CLR_BIT(i);
> +		}
> +	}
> +
> +	/* Check counter overflow */
> +	if (flg & ECAP_EVT_FLG_BIT(ECAP_CNTOVF)) {
> +		atomic_inc(&ecap_dev->nb_ovf);
> +		counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, ECAP_CNTOVF);

COUNTER_EVENT_OVERFLOW doesn't conflict with COUNTER_EVENT_CAPTURE
(they're different event types) so they can both be pushed on the same
channel; in general, events of different type can share the same event
channels. In this case, you should push COUNTER_EVENT_OVERFLOW to all
four channels whenever you detect an overflow, so that users can receive
those events regardless of which channels they are watching:

    counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, 0);
    counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, 1);
    counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, 2);
    counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, 3);

There's no additional cost to pushing to these channels because events
get dropped by the Counter chrdev code if the user is not watching the
particular event on a channel.

> +static int ecap_cnt_suspend(struct device *dev)
> +{
> +	struct counter_device *counter_dev =3D dev_get_drvdata(dev);
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +
> +	/* If eCAP is running, stop capture then save timestamp counter */
> +	if (ecap_dev->enabled) {
> +		/*
> +		 * Disabling capture has the following effects:
> +		 * - interrupts are disabled
> +		 * - loading of capture registers is disabled
> +		 * - timebase counter is stopped
> +		 */
> +		ecap_cnt_capture_disable(counter_dev);
> +		ecap_cnt_count_get_val(counter_dev, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.=
time_cntr);

I see time_cntr define as u64, but if count value is always <=3D U32_MAX
you could redefine both ecap_cnt_count_get_val()'s val and time_cntr to
u32 instead.

> +static int ecap_cnt_resume(struct device *dev)
> +{
> +	struct counter_device *counter_dev =3D dev_get_drvdata(dev);
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter_dev);
> +
> +	clk_enable(ecap_dev->clk);
> +
> +	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
> +
> +	/* If eCAP was running, restore timestamp counter then run capture */
> +	if (ecap_dev->enabled) {
> +		ecap_cnt_count_set_val(counter_dev, ECAP_TSCNT_REG, ecap_dev->pm_ctx.t=
ime_cntr);

Same as above would apply for ecap_cnt_count_set_val() too I think.

William Breathitt Gray

--CIfG5Izydz6MDoAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYyvDegAKCRC1SFbKvhIj
K9G+AP4xMrC13fuL8/1x33pIHZ2bXzKzLdoRWNe6HFvtfQEt6gD8CIWTic8ORaRY
GpuhxVimnt2gc/D8fuln+Ozm4I4Mcw8=
=pXZN
-----END PGP SIGNATURE-----

--CIfG5Izydz6MDoAL--
