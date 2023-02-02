Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DA68878C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjBBTgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:36:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEDB2C64B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80A8AB827E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5003CC4339B;
        Thu,  2 Feb 2023 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675366607;
        bh=dKxC1/aDb9Kf4MWrvVY68hvT5wNWoEkjvF8SjH+2a8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J0wzoo7SEliOAAS/MwTXNi+kSwMV6sHTD/Q1RjnpWYWEHIpwHYg8WfqMHhZHCvo7v
         gcNGS3Dp4EkGEYxxXoqu7DuT/g32emYCpYVny+BxgJBzOXCuzHv5MjQXHgRyzWvMRp
         hJh/w9bYmuX8ij0aKHM4T4ErrjO2AVba0FphVDewSmNAI1g7WyIEBcMa8FvlKD57a+
         RdrwGYBNbzFm/5hVv7zvnvfj53BqJXxGQ2pOzyNriJgHLoxdMIRpl4KtokjpkKOkCM
         h43CS3AWNEYT4EKRJkyDFHNTpCeyPwMvaKiJ1qyTjZgnBRcKg4r7XtNPus/0H5mPa/
         nPuQde+FLksmw==
Date:   Thu, 2 Feb 2023 19:36:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <Y9wQygzbFyOWl54r@sirena.org.uk>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk>
 <20230202155101.GB1373010@roeck-us.net>
 <Y9vtIISfmpICi+9u@sirena.org.uk>
 <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xVNftv7fOUYdi/3y"
Content-Disposition: inline
In-Reply-To: <8f89eeac-b3ef-4137-80df-6cf044873b05@roeck-us.net>
X-Cookie: Swim at your own risk.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xVNftv7fOUYdi/3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2023 at 10:39:51AM -0800, Guenter Roeck wrote:
> On 2/2/23 09:04, Mark Brown wrote:

> > It's definitely unclear, there's a datasheet at [1] which does appear to
> > explicitly call for a 512ms delay though (see figure 20 on page 50).  It
> > does look like it should only be applied in the case where an inserted
> > jack is detected (ie, when identifying an accessory or button press) and
> > not when removal is detected though.

> The datasheet doesn't really suggest that a delay shall be applied using
> msleep (ie in the code). The chip presumably debounces internally (see

Obviously it doesn't call for an explicit implementation in the host.

> jackdet_debounce and jackdet_rem_deb), and there is also jack_detect_rate
> to configure the detection rate. The table seems to suggest (to me) that
> there is an e_jack_insertion event, which would then be followed 64-512 ms
> later with an e_jack_detect_complete event.

Right, I think what I was looking at was that in combination of the fact
that there's a *much* longer window before the host clears the interrupt
shown on the first JACK_IN.  It could be spurious and possibly just due
to the host type check thing in the diagram but it smells real bad, like
the hardware state machine has robustness issues or something.  The
diagram currently doesn't quite correspond to the code since we have the
delay applied unconditionally, and there's that undocumented
register for the ground switch being managed.

> Whatever is done in software is on top of that, or at least that is my
> understanding, and not explained by anything in the datasheet.

> Given that the chip itself supports debouncing internally, it is not clear
> to me what the delay is actually supposed to accomplish. Soft debounce
> on top of chip debounce ? I don't see that explained anywhere, though of
> course I might be missing it.

That's what it looks like it's trying to accomplish but as you say it's
not exactly explicit.  I *suspect* it's trying to debounce in more cases
than is needed.

> > > is not conceivable (or explained) why the ground switch is enabled only
> > > to be disabled immediately afterwards if a jack was removed.

> > It smells like there's a power benefit to leaving it disabled when
> > unplugged (which seems plausible), and possibly like the detection is
> > more stable with the ground switch enabled.  The ground switch is not
> > documented AFAICT (it's in register 0xfb which isn't named and doesn't
> > appear to appear in the datsheet from a quick search).  The code is
> > leaving the switch enabled so long as an accessory is plugged.

> I understand. What I don't understand is that it is always enabled
> in the interrupt handler, no matter if a jack was inserted or not,
> only to be disabled immediately if the jack was disabled or after
> insertion detection work is complete.

My guess was that it was making the detection more stable, it's
surprising that it'd help with simple presence detection though.

> > Are you saying this is actually crashing, or just that you're getting
> > warnings about threads being blocked for too long (that was what was
> > posted earlier in the thread)?  The only things I can see that look like

> ChromeOS is configured to crash after stalled threads are detected (ie
> after 120 seconds), so this is actually causing crashes.

Ah, that's much more serious than I'd understood from the log you
posted.

> > they have the potential to actually lock up are the cancel_work_sync()
> > calls but they were unchanged and the backtrace you showed was showing
> > the thread in the msleep().  My guess would be that you've got systems
> > where there are very frequent jack detection events (potentiallly with
> > broken accessories, or possibly due to the ground switch putting things
> > into the wrong priority) and that the interrupt is firing again as soon
> > as the thread unmasks the primary interrupt which means it never
> > actually stops running.

> That is what I strongly suspect is happening. I don't know why exactly
> the interrupt is firing continuously, but the hang is always in msleep().
> One possibility might be that the event is actually a disconnect event,
> and that enabling and immediately disabling the ground switch causes
> another interrupt, which is then handled immediately, causing the hang.

Could be.  I'd be willing to guess that it's not just one event but
rather a stream of events of some kind.  Possibly if it's due to the
ground switch it's spuriously detecting a constant stream of button
presses for the affected systems, which don't produce any UI visible
result which would cause users to pull the accessory for whatever
reason?  Whatever's going on I bet it's broken accessories triggering it.

> > My other guess would be that moving the delay that's been added to a
> > delayed work would avoid the warnings, though you might want to manually
> > keep the physical interrupt disabled while that's running which is fun.

> I am not sure if that would fix anything. The current code sleeps, then
> enables the ground switch and does the rest of the detection. I'd somewhat
> understand the code if it would enable the ground switch after an "insertion
> detected" interrupt, then wait for some amount of time and handle the rest
> of the detection after waiting (even though that should really be handled by
> the "detection complete" interrupt). But that isn't what it does.
> If we were to implement the above, I suspect the result would be that the
> interrupt still happens all the time, and the only difference would be that
> it would be "silenced" while the delayed work is waiting to be scheduled.
> That doesn't really fix the problem, it only works around it. But, sure,
> it would be much better than the current situation.

Yes, exactly - I was just looking at a refactoring in the code which
would mitigate the immediate problem while keeping the current partially
documented algorithm in place.

> My "wild shot" fix would be to enable the ground switch after an insertion
> event and to drop the software sleep entirely.

That's entirely plausible to me, either together or possibly just one of
those is actually needed.  Do you want to send a patch?

> However, it is really impossible to know what the delay is for in the
> first place. Looking into the code further, the sleep time actually matches
> the configured jack detection rate. I have no idea why it would make sense
> to wait for a detection cycle after an event, then enable the ground switch
> and actually handle the event (which by then probably reports that jack
> detection is complete after an insertion). I really don't understand
> the logic behind that.

This all smells like there's either a race condition in a state machine
somewhere or the button detection needs a bit of help (though if it's
the latter then it'd be conditional on a microphone having been
detected).

Hopefully David will get back to us with some explanation and ideally
fix.

--xVNftv7fOUYdi/3y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPcEMkACgkQJNaLcl1U
h9BX8Qf+PrDNAOJFzWqrttDu9oAgYQJuDykPUqiH5b3Niw/t4PUQvsuMbTcozyYs
QOnZEctgIKRLMfwvtTMxi4SwtvG7+74uTb+o/mbkZPOOxIOEbwSRSUQIvjD19riu
PWHWDkiWDxQmXnLCUL07v4LJA5Rk3t1Jyaqu+jeD9bd9lk4qW72bJiDsKvVJBW1d
M5LjDLMmODEJONHzNYoUBX6CJABY7jlzS41txrXeHXqASIIauHizti3DRhS9d5ty
/+YJzwB1Qj+S7DgBHZR/U1I5LBuVFGq7AIHHMNnH7I/1XyJ4Y2xfSRDTc4jaoUUT
CcmqpVi4btxYCZjq84qiu3BuVfPhmg==
=tzH8
-----END PGP SIGNATURE-----

--xVNftv7fOUYdi/3y--
