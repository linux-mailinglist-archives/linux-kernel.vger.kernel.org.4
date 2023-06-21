Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4B1738B95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjFUQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjFUQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:38:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732721BD0;
        Wed, 21 Jun 2023 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OdFzun0L0/e6r02A+DrKv3kwszx3coOMwNXnVWRuYqM=;
        t=1687365488; x=1688575088; b=m9p8LdGGk7MFyOmWI+LHZkM2E7doe5Xb/ok4iwGgsLroHFp
        3JdDqhm9aA5ijUA8EM+AJkyHRFvPxBxeD7+0EZ6nMifeVeK97GlCFZX33Rq+IBdR7OS77Hjo/+Meo
        OPoKxA/wCkmtOAk8AZ4wPsd2HNUECr55nSCrUuGH9g0jWBUUHrP6+xy+WT4hL43hehPMUzM60ZUcc
        kf0XGBPIuQpijgY2nlj6zOI3rw/PLukL+FOtnvOq7XhAaTVyOM/0l3YWNgV2cG32uZLsP8EtxCex1
        Y6dsPJCz5OaPYzyeoRNh/Z0PnRdxkSFEApfF2RXCvns+gyoBe4oSI76w3TuVxdCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qC0pt-00Dltw-2s;
        Wed, 21 Jun 2023 18:37:38 +0200
Message-ID: <aca10d753183508672739e8b6668d41ce2cdaf80.camel@sipsolutions.net>
Subject: Re: [PATCH V4 1/8] drivers/acpi: Add support for Wifi band RF
 mitigations
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Evan Quan <evan.quan@amd.com>, rafael@kernel.org, lenb@kernel.org,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mario.limonciello@amd.com, mdaenzer@redhat.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        hdegoede@redhat.com, jingyuwang_vip@163.com, lijo.lazar@amd.com,
        jim.cromie@gmail.com, bellosilicio@gmail.com,
        andrealmeid@igalia.com, trix@redhat.com, jsg@jsg.id.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Date:   Wed, 21 Jun 2023 18:37:36 +0200
In-Reply-To: <d2dba04d-36bf-4d07-bf2b-dd06671c45c6@lunn.ch>
References: <20230621054603.1262299-1-evan.quan@amd.com>
         <20230621054603.1262299-2-evan.quan@amd.com>
         <3a7c8ffa-de43-4795-ae76-5cd9b00c52b5@lunn.ch>
         <216f3c5aa1299100a0009ddf4e95b019855a32be.camel@sipsolutions.net>
         <d2dba04d-36bf-4d07-bf2b-dd06671c45c6@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-06-21 at 18:14 +0200, Andrew Lunn wrote:
> > > Do only ACPI based systems have:
> > >=20
> > > =C2=A0=C2=A0=C2=A0interference of relatively high-powered harmonics o=
f the (G-)DDR
> > > =C2=A0=C2=A0=C2=A0memory clocks with local radio module frequency ban=
ds used by
> > > =C2=A0=C2=A0=C2=A0Wifi 6/6e/7."
> > >=20
> > > Could Device Tree based systems not experience this problem?
> >=20
> > They could, of course, but they'd need some other driver to change
> > _something_ in the system? I don't even know what this is doing
> > precisely under the hood in the ACPI BIOS
>=20
> If you don't know what it is actually doing, it suggests the API is
> not very well defined.

I wouldn't say that. At the level it's defined now, the API is very
clear: the wifi subsystem tells the other side what channels it's
operating on right now.

> Is there even enough details that ARM64 ACPI
> BIOS could implement this?=20

This, in itself? No. You'd have to know about the physical
characteristics of the system, what is actually causing interference and
at what frequencies and of course what you can actually do to mitigate
(such as adjusting clock frequencies.)

But as an API? I'd think yes, since WiFi can't really move off a
frequency, other than disconnect, anyway.


> > > > +bool wbrf_supported_producer(struct acpi_device *adev);
> > > > +int wbrf_add_exclusion(struct acpi_device *adev,
> > > > +		       struct wbrf_ranges_in *in);
> > > > +int wbrf_remove_exclusion(struct acpi_device *adev,
> > > > +			  struct wbrf_ranges_in *in);
> > >=20
> > > Could struct device be used here, to make the API agnostic to where
> > > the information is coming from? That would then allow somebody in the
> > > future to implement a device tree based information provider.
> >=20
> > That does make sense, and it wouldn't even be that much harder if we
> > assume in a given platform there's only one provider
>=20
> That seems like a very reasonable assumption. It is theoretically
> possible to build an ACPI + DT hybrid, but i've never seen it actually
> done.

OK.

> If an ARM64 ACPI BIOS could implement this, then i would guess the low
> level bits would be solved, i guess jumping into the EL1
> firmware. Putting DT on top instead should not be too hard.

Right.


Maybe then this really shouldn't be called "wbrf", but maybe naming
doesn't matter that much :)

johannes
