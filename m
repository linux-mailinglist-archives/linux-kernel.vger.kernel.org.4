Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0E6DBA42
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjDHKye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 06:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDHKyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 06:54:13 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4F9113E9;
        Sat,  8 Apr 2023 03:52:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id ECAB33F73C;
        Sat,  8 Apr 2023 12:51:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FbKCcv-IYQbz; Sat,  8 Apr 2023 12:51:34 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 8AFCA3F535;
        Sat,  8 Apr 2023 12:51:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 559DE95ED1;
        Sat,  8 Apr 2023 10:51:32 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6FHNzWLRwJ6Y; Sat,  8 Apr 2023 10:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 36F5F95ECA;
        Sat,  8 Apr 2023 10:51:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 36F5F95ECA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680951088;
        bh=0oqeDMhvTWbWq95q40jTAOlJmUCmAKBDPqsNYH9Nxfs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=b4HlYM631J9LUGGDbHJ2rjI+2mysgx4JRo2CD26ljC0xJEhRKHhnDkiAhPnJxvEvI
         x0ZVN03b0BlJYifPSztNlfs3URTMVfSZf16/78h5iq6UCO6KnVyTJPmk67bxyRkqVE
         5ZKEOIAvl1p0nTOBwGUV0IgmmMc95/757BBzG+uozQu5LdQ22Zc0KvmEDtlj77wPlL
         elsP7tH/AXO8SZ/SH8QhsXxVbJCFbgPFvquTRE7K23qfTZq+6D2RkP9y4LXBwuRPVs
         5IuRfR55vsrjI0Qqv1ezZ8dtF6jpcak5RNtuQ224x6y9vG5kl3gkNR+a1EmXhQzuyI
         31ltXHa3Fpt/Q==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c_KEopmOU3OE; Sat,  8 Apr 2023 10:51:28 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 9B2DA95EC6;
        Sat,  8 Apr 2023 10:51:27 +0000 (UTC)
Date:   Sat, 8 Apr 2023 12:51:26 +0200
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, hns@goldelico.com, lars@metafoo.de,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iio: adc: palmas_gpadc: add iio events
Message-ID: <20230408105126.GA141200@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
 <20230407180435.048a8636@jic23-huawei>
 <20230407180941.2e79469e@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230407180941.2e79469e@jic23-huawei>
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 06:09:41PM +0100, Jonathan Cameron wrote:
> On Fri, 7 Apr 2023 18:04:35 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Wed,  5 Apr 2023 23:22:26 +0200
> > Patrik Dahlstr=F6m <risca@dalakolonin.se> wrote:
> >=20
> > > This series is based on linux-next/master [1] and [2].
> > >=20
> > > The palmas gpadc block has support for monitoring up to 2 ADC chann=
els
> > > and issue an interrupt if they reach past a set threshold. This can=
 be
> > > configured statically with device tree today, but it only gets enab=
led
> > > when reaching sleep mode. Also, it doesn't look like anyone is usin=
g it.
> > >=20
> > > Instead of this one special case, change the code so userspace can
> > > configure the ADC channels to their own needs through the iio event=
s
> > > subsystem. The high and low threshold values can be set for every
> > > channel, but only 2 thresholds can be enabled at a time. Trying to
> > > enable more than 2 thresholds will result in an error.
> > >=20
> > > The configured thresholds will wake up the system from sleep mode i=
f
> > > wakeup is enabled in /sys/devices/.../power/wakeup.
> > >=20
> > > The old platform data was removed.
> > >=20
> > > Thresholds, events, and wakeup were tested on omap5-uevm board. It =
wakes
> > > up from sleep mode when wakeup is enabled and a threshold is passed=
. A
> > > userspace tool for monitoring events and adjusting thresholds can b=
e
> > > found at [3].
> > >=20
> > > V2 -> V3:
> > > * Rebased to linux-next. =20
> >=20
> > As per reply to the earlier thread.  Don't base on linux-next.
> > It can be very unstable though not so much later in a cycle like this=
.
> >=20
> > If there isn't a lot of churn going on in the driver, fine to base on
> > previous release kernel or rc1 (good to say if it is an rc1)
> >=20
> > If there is churn underway (which is true here) then iio/togreg + ext=
ra
> > patches lists that need to be applied listed in this cover letter.
>=20
> Just goes to show I focused on the change log and skipped the rest :)
> As you have it here is fine though change log could have mentioned the
> extra patch as well even if just "Rebased to linux-next + devm patch."
>=20
> In this case linux-next is close enough for this driver to the
> iio/togreg tree that it doesn't matter that it shouldn't be used as a b=
ase
> (no impact in this particular case I think).

I'll rebase to iio/togreg, fix up the cosmetics, and add the devm patch t=
o
the series. Sounds good?

>=20
> Anyhow, all good. I noticed I'd misinterpreted what you'd done here
> when I saw the context in one of the patches.  oops :)

No worries, I'm just glad this is progressing :)

>=20
> Jonathan
>=20
>=20
> >=20
> > I'm also fine with you just adding the devm patch to this series as
> > the first patch.
> >=20
> > Jonathan
> >=20
> >=20
> >=20
> > > * Avoid reconfiguring events on error and when old =3D=3D new value=
.
> > > V1 -> V2:
> > > * Begin by removing adc_wakeupX_data instead of doing it last.
> > > * Split changes in smaller patches
> > >=20
> > > [1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it
> > > [2] https://lore.kernel.org/linux-iio/20230318163039.56115-1-jic23@=
kernel.org/
> > > [3] https://github.com/Risca/pyra_vol_mon
> > >=20
> > > Patrik Dahlstr=F6m (7):
> > >   iio: adc: palmas: remove adc_wakeupX_data
> > >   iio: adc: palmas: replace "wakeup" with "event"
> > >   iio: adc: palmas: use iio_event_direction for threshold polarity
> > >   iio: adc: palmas: move eventX_enable into palmas_adc_event
> > >   iio: adc: palmas: always reset events on unload
> > >   iio: adc: palmas: add support for iio threshold events
> > >   iio: adc: palmas: don't alter event config on suspend/resume
> > >=20
> > >  drivers/iio/adc/palmas_gpadc.c | 559 +++++++++++++++++++++++++++--=
----
> > >  include/linux/mfd/palmas.h     |   8 -
> > >  2 files changed, 464 insertions(+), 103 deletions(-)
> > >=20
> > >=20
> > > base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
> > > prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0 =20
> >=20
>=20
