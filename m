Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C601639912
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 01:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiK0AXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 19:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiK0AXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 19:23:39 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14311801
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 16:23:38 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id k2so4939245qkk.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 16:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KQZdCAn1wLe1ma6euNf1AeZGjQ191Yciz8w43AMTgto=;
        b=GF8VeJpmoLIxiroVs0Cy+IsfnoPUK2b9qisZX4FRmmXiXuJI042pRRoqcRSc/vXbXl
         iS9XY/ZIvMjRmQvbnY8Te9sK8B/eYC+OLO9MeznyE84rqlS8l1S/61Vw/J6e8Y2b3qY9
         oib5FVc7uB1tn2QIja/57qaBHSV11gDYCuUPjBs+ezHAfbhJBdCmCO3a5waR8QleyLmi
         n5aRHKMDzpQnjtxKq9SNPpdTHyEux4xjwZe2am3RnIuPZvccL+Rx/zdtSOvvUhlbRNL9
         pXHTJO3LvLMRZ903F0yzcUt4kxVfAYpJxcitDU9MQyMoGD05f3OA/gG8vvI7DiC9XTcU
         rJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQZdCAn1wLe1ma6euNf1AeZGjQ191Yciz8w43AMTgto=;
        b=h0pms1/Q4Fdgf7lX89TEmAzYzKgs7YJA/pqpBrC9xcZQKT7LH3AiRT+tGXBiVCZpfp
         CcxMYIn3edQacxO9cX4KUAA1SYBfraJGSOI+sPfzuADub0vK5d+WpW0VdSGbZ3zmShOq
         5TYqgVawzXCtNFXAavsvNfAb+3+hi6MknldbvUyuyiglK3uXjlaIoGJiDKb9VzdX/Pz+
         +LFXLTYdnpDVhO/X/TPdHwLw/U7hQT45SUgrhao8PGleS5RNlhZZWNZXox4UdbHBFz5N
         316uRBhFd7AcOP1NJkI2YGm3JJO1NZL9QEgl8P5VSh2fjr15VfhbmQOFEdeJuQEfq8VB
         00XA==
X-Gm-Message-State: ANoB5pmgOhY1uaTl3/nSu0po+LmRop8K76US4fb5e114FmwcZ/kyMDKP
        9c/vY5oySbAJoWE7QyAtgudNMA==
X-Google-Smtp-Source: AA0mqf6gHqi4FO//fWDEHPPmkkyz01Lh3ag0c10ukil2kaNdWtS8PwvlG9AAMPfTyiKH4bkqr5XVJA==
X-Received: by 2002:a37:486:0:b0:6fb:c2b7:bd0f with SMTP id 128-20020a370486000000b006fbc2b7bd0fmr40277246qke.69.1669508617473;
        Sat, 26 Nov 2022 16:23:37 -0800 (PST)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id u6-20020a37ab06000000b006eeca296c00sm5395369qke.104.2022.11.26.16.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 16:23:36 -0800 (PST)
Date:   Sat, 26 Nov 2022 19:23:34 -0500
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     jic23@kernel.org, lars@metafoo.de, benjamin.gaignard@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Removing the last of IIO_COUNT (stm32-timer-trigger)
Message-ID: <Y4KuBicVeRAsfqxq@fedora>
References: <Y0vzlOmFrVCQVXMq@fedora>
 <ec6b8983-1567-92c8-f1cd-baf970ca4046@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pol7eQrzyh+2cjLY"
Content-Disposition: inline
In-Reply-To: <ec6b8983-1567-92c8-f1cd-baf970ca4046@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pol7eQrzyh+2cjLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 27, 2022 at 11:41:18AM +0200, Fabrice Gasnier wrote:
> On 10/16/22 14:05, William Breathitt Gray wrote:
> > Hi all,
> >=20
> > The drivers/iio/trigger/stm32-timer-trigger.c file remains the last
> > consumer if the IIO_COUNT type. The IIO_COUNT type was deprecated some
> > time ago with the introduction of the Counter subsystem. Most of the
> > previous IIO_COUNT consumers were migrated successfully to the Counter
> > subsystem, but the stm32-timer-trigger driver remains as the sole module
> > preventing the final removal of IIO_COUNT.
> >=20
> > At the time we deprecated IIO_COUNT, the Counter subsystem was nascent
> > and lacked some of the functionality we have nowadays such as a
> > character device interface, timestamping, hardware buffer support, etc.
> > If I recall correctly, the decision to delay the migration of
> > stm32-timer-trigger to the Counter subsystem was a lack of some
> > functionality the Counter subsystem could not provide at the time.
> >=20
>=20
> Hi William,
>=20
> As far as I remember, initial work on stm32-timer-counter focused only
> on porting the quadrature interface away from stm32-timer-trigger.
> Unfortunately, I've followed from afar all the progress you did in the
> framework since then.
> From the infrastructure point of view, there's probably not much to add
> to be able to move away the IIO_COUNT channel (and the IIO device) part
> of stm32-timer-trigger driver.
> Let's focus only on the modes implemented here.

Hi Fabrice,

Sorry for the delay in my response; it took me a while to think through
all this, but I believe you have the right approach in your suggestions.

>=20
> Besides this, I may have further questions on the "hardware buffer
> support" (could you point this as I miss it for now), and also the
> capture interface.
> There has been a separate discussion here ("pwm: Make capture support
> optional"):
> https://lore.kernel.org/linux-pwm/Yz%2F4V0gH%2FvrWSS8U@orome/T/#u
> I'd be glad to get your opinion, on possibly moving the PWM input
> capture feature to the counter framework too.

I replied to the PWM discussion to provide some context about the
Counter events (capture) interface. You can find out more about the
Counter hardware buffer support in the Counter array components support
introduction patch series:
https://lore.kernel.org/all/cover.1664204990.git.william.gray@linaro.org/

Essentially Counter arrays are a convenience tool to allow drivers to
group and handle multiple components of the same type. Hardware buffers
are thus supported by exposing each buffer element as an individual
component to the user; those components are handled by the Counter
driver via a callback with the index for the particular element passed
in as an argument.

>=20
> > I hoping someone can evaluate stm32-timer-trigger to see if we are able
> > transition now to the Counter subsystem, or if that necessary
> > functionality is still missing today. Even if it turns out that we are
> > unable to migrate, it'll be useful to know what's left to implement in
> > the Counter subsystem to support stm32-timer-trigger or similar devices
> > in the future.
>=20
> As you're asking, I just tried to narrow down specific things in this
> driver, and assess possible impacts. Please find some details here after
> and first as an introduction:
>=20
> The IIO device registered in this driver has two specific extensions, to
> manage specific ("slave") modes: "always", "gated", "triggered".
> E.g the *enable_mode*.
>=20
> The last 2 modes depends on specific hardware *triggers* being
> associated in IIO sysfs, to select the trigger (e.g. echo the source
> trigger name > trigger/current_trigger # the destination timer to trig).
> The list of triggers is specific to each timer instance in STM32.
> In other words, some timers outputs can be used as input on other
> timers. Here comes the *trigger_mode* attribute (see after).
>=20
> --- enable_mode ---
> In Documentation/ABI/testing/sysfs-bus-iio-timer-stm32, this correspond t=
o:
> - /sys/bus/iio/devices/iio:deviceX/in_count0_enable_mode
> - /sys/bus/iio/devices/iio:deviceX/in_count_enable_mode_available
> always:
> 	Counter is always ON.
> gated:
> 	Counting is enabled when connected trigger signal
> 	level is high else counting is disabled.
> triggered:
> 	Counting is enabled on rising edge of the connected
> 	trigger, and remains enabled for the duration of this
> 	selected mode.

Okay, we need to support these three modes. The "always" mode seems
straight-forward to support, but "gated" and "triggered" are what need
special consideration for this driver.

>=20
> Basically, the "always" mode is already used by default in
> stm32-timer-cnt driver, and matches: COUNTER_COUNT_MODE_NORMAL, By
> referring to:
> Documentation/ABI/testing/sysfs-bus-counter
> 		normal:
> 			Counting is continuous in either direction.
>=20
> Please find some thoughts/proposal here:
> - This could lead to add two counter modes to the list of "range limit",
> "non-recycle" and "modulo-n". The STM32 timer trigger inputs could be
> described as signals (list being specific for each timer instance, see
> valids_table[] arrays in stm32-timer-trigger).

It makes sense to represent these inputs as Signals because they can
directly affect the value change of the respective Count, so I think we
should organize this as such. However, "count_mode" wouldn't be the
correct place for configuration of the "gated" and "triggered" modes.
"count_mode" is for configuring how the Count value updates once a
Synapse action triggers, but "gated" and "triggered" are rather more so
determining whether those Synapse actions should trigger in the first
place.

>=20
> - OR, maybe the 2 modes could be described as a specific synapse action,
> (trigger input also being described as a signal)? In both "gated" and
> "triggered" modes, the timer counts on its internal clock input (but not
> continuously). But it doesn't really match the "normal" mode.

Yes, I think this is the approach to take. Synapse actions represent
when the Count function is evaluated to update the respective Count;
"gated" and "triggered" represent modes where a trigger input serves to
determine when that update occurs, so those are naturally Synapse action
modes.

To add support for these, you would just need to introduce to
include/uapi/linux/counter.h two new enum counter_synapse_action
constants: COUNTER_SYNAPSE_ACTION_GATED and
COUNTER_SYNAPSE_ACTION_TRIGGERED. You can then use those new enums in
your action_read() callbacks.

>=20
> - Last, maybe a mix of a new "trigger" count mode, and synapse action
> (gated/triggered) could be used ?
> Note: The last one may open the door to other modes that aren't
> implemented in current stm32-timer-trigger driver, by extending the
> synapse actions (like reset the counter upon trigger signal... and other
> combined modes specified in the STM32 timer spec).

Instead of "count_mode", a new Count component should be introduced to
handle this configuration. Maybe we could call it "gate_mode" (or
perhaps your might have a better name) and it can be implemented using
the COUNTER_COMP_COUNT_ENUM() macro to allow for selection between
"always", "gated", and "triggered".

>=20
> --- trigger_mode ---
> In Documentation/ABI/testing/sysfs-bus-iio-timer-stm32, this correspond t=
o:
> - /sys/bus/iio/devices/iio:deviceX/in_count_trigger_mode_available
> - /sys/bus/iio/devices/iio:deviceX/in_count0_trigger_mode
> In the STM32 timer spec this is: External Clock Mode 1 - Rising edges of
> the selected trigger (TRGI) clock the counter.

This can be implemented as a COUNTER_COMP_COUNT_ENUM() to select the
particular trigger input.

>=20
> In this configuration, IMHO, this matches the "normal" counter mode.
> This lead also here to define trigger inputs as a signals. Then the
> standard increase/decrease functions suffice.
>=20
> --- dt-bindings ---
> This could be a tight part. Listing/probing the triggers relies on the
> reg property defined in the trigger node:
> - Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
>=20
> timers2: timer@40000000 {
>   timer@1 {
>     compatible =3D "st,stm32-timer-trigger";
>     reg =3D <1>;
>   }
>   counter {
>     compatible =3D "st,stm32-timer-counter";
>   };
> }
>=20
> Ideally... adding the reg property to the counter node could have
> helped. But we need to enforce the backward compatibility with existing
> DT binaries. So I think that there's no choice to keep the current bindin=
gs.
>=20
> This could lead to add some code to parse the trigger node for probing,
> looking for the "reg" property either from:
> - the MFD driver part drivers/mfd/stm32-timers.c
> - the counter driver, although it seems non-standard way to parse aside
> nodes.
> I have no strong opinion and I'm open to suggestions.

I don't have much of a strong opinion either, but I'd consider the MFD
driver to be the more natural location to place this. However, I'm also
open to suggestions if someone thinks it better somewhere else.

>=20
> ---
> To conclude, there some open items here, but hopefully nothing blocking.
> In case we sort all these, this will allow to remove the IIO_COUNT
> channel (along with the IIO device) being registered.

I'm certain Jonathan will want some sort of deprecation schedule first
to make sure any existing users have time to migrate to the Counter
interface before we remove the IIO one, but it will give me a nice
feeling of completion to see the last of IIO_COUNT superceded by the
Counter interface. ;-)

William Breathitt Gray

>=20
> There will still remain some specific attributes in the
> stm32-timer-trigger driver, related to the trigger device:
> - /sys/bus/iio/devices/triggerX/master_mode
> - /sys/bus/iio/devices/triggerX/master_mode_available
> But this shouldn't be an issue as it isn't related to the IIO_COUNT part
> of the driver.
>=20
> Please advise,
> Best Regards,
> Fabrice
>=20
> >=20
> > Thanks,
> >=20
> > William Breathitt Gray

--pol7eQrzyh+2cjLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCY4KuBgAKCRC1SFbKvhIj
K3VJAP40p/2Ow8pzpVLrWihMamfoeI6BpbnX5DrPRO/vt/XwJAD9EAfb1NZan6hQ
adtzdvNZCrhyig+k3jwO3+AXM51TVgw=
=j5H7
-----END PGP SIGNATURE-----

--pol7eQrzyh+2cjLY--
