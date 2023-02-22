Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3769F72C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjBVOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjBVOy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:54:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7AC27D45
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:54:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0FE2612FC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF78C433D2;
        Wed, 22 Feb 2023 14:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077665;
        bh=eIDCGupW+RO7IwtOHjuLI95Tccz5G1zPwqtw1y8XqzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQdZFYB04u7dD/rUNTAPSMvIfRfvwVUzi/Mc5cUEPnSN6XWQ32Zi8xdBar+aUH6bH
         LyYa+i3bpJHfKeNR/MB8pGOgwIv3ulkvVv9y1VpvlzXchcDGmOBv8nAFgP8FkaIX8I
         BN6reOg2EX30sdLpnu/sS2KaAl5dbmeHoYWkbqan35m6bZ9eB9FoLvzF9CrSvMdZc+
         XRNDHKrT6grkDedO/q6T7tLyEd/YiOvTpojGz9JKDTxjlWUxJYkSKn/idD0qD9OkVC
         qr52Fdk9rTYNpwUgln1bf+8zYK8895r6An4qxLe4nnv0c7OfSXfeG6pG+JRWeYJrEE
         1DWzf6E9Fb3uQ==
Date:   Wed, 22 Feb 2023 14:54:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Doug Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Luca Weiss <luca.weiss@fairphone.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 0/4] Simplify regulator supply resolution code by
 offloading to driver core
Message-ID: <Y/Ysmmv8rfmWBkqG@sirena.org.uk>
References: <CGME20230218083300eucas1p28c7c584877b8914a3b88904690be82f6@eucas1p2.samsung.com>
 <20230218083252.2044423-1-saravanak@google.com>
 <e3814c81-c74d-7087-e87d-12dcb49e6444@samsung.com>
 <CAGETcx-UcVnDw-FJAPeA1mLpPno4OE3AAv4WsfP852zOdKqPCw@mail.gmail.com>
 <Y/VLREM7n+wstHbn@sirena.org.uk>
 <CAGETcx_hp_P09diJWgP7=4QiKJi91oVXie3iddpkTOdO4uuZjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ycJj0z3ShtP8COno"
Content-Disposition: inline
In-Reply-To: <CAGETcx_hp_P09diJWgP7=4QiKJi91oVXie3iddpkTOdO4uuZjg@mail.gmail.com>
X-Cookie: My LESLIE GORE record is BROKEN ...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ycJj0z3ShtP8COno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 21, 2023 at 07:13:39PM -0800, Saravana Kannan wrote:
> On Tue, Feb 21, 2023 at 2:52 PM Mark Brown <broonie@kernel.org> wrote:

> > My main thought right now is that I'm not going to think about it
> > too hard if it doesn't work correctly...

> :( I'm not asking for a thorough code review. Just if you are okay
> with the idea/approach of pushing the ordering logic to driver core to
> avoid reimplementing what's already available and avoiding some races
> in the regulator code (stuff like, checking if some other thread
> resolved a supply while you were working on it). The patch at least
> works on my device and works for most regulators in Marek's devices.
> So, it's not a complete broken mess :)

Well, there's the fact that it's clearly not a bus (not even a virtual
one like virtio) which will doubtless cause problems down the line.
Otherwise the fact that you're so concerned is making me think there's
landmines in here that need a really detailed look.

> On a separate note, I have some questions about setting machine
> constraints during regulator_register(). Why do we even try to set
> machine constraints before a regulator's supply is resolved? None of
> the consumers can make any requests anyway. So what else is going to
> need those constraints? Wouldn't the regulator just be in whatever
> state the bootloader left it at?

If the state we inherit is somehow bad then we want to try to correct
problems as fast as possible, to the extent we can.  The firmware may
not be making any effort to configure the hardware, we can end up with
hard coded defaults from the silicon which might need some fixup so we
want to minimise the amount of time we spend operating out of spec.

> The current logic is something like:

> 1. Try to resolve supply if it's always on or a boot on regulator.
> 2. Set machine constraints -- this might fail for multiple reasons.
> One of them being unresolved supply.
> 3. If it failed due to unresolved supply, but it wasn't resolved in step 1.
> 3. a. Try to resolve supply,
> 3. b. If 3.a. didn't fail, try to set machine constraints.
> 3. c. If 3.b failed, fail registration.

IIRC the goal is to only configure the supply if we really need to so it
doesn't get in the way of anything else.

> Why isn't this just:
> 1. Try to resolve supply (for all regulators).
> 2. If we are able to resolve supply set machine constraints.

Most constraint setting doesn't need the supply.

> 3. If we weren't able to resolve supply, set machine constraints when
> we resolve supply in the future?

This may never happen.

> Or if you need to set machine constraints without waiting for supply,
> then why not at least:

> 1. Try to resolve supply (for all regulators).
> 2. Set machine constraints.
> 3. When we resolve supply in the future, do whatever remaining bits
> that you need to do.

There's also the coupling to deal with.  It's mainly that we don't even
bother trying to resolve the supply until we need it to cut down on
noise from reporting transient errors that'll sort themsleves out later.

--ycJj0z3ShtP8COno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP2LJkACgkQJNaLcl1U
h9DkPgf/dxOe89+OSUbn/Ifa+ZhTD/tcMwg05Ben6e/0Z5VQSIbpFyGyfliGhaVx
sORYFLP8KPUFY2dEhhRiTRPB9v2vBT/O7CPyYRkEhba0TxFlY5hrH/CTLR4nrTYX
Nimzb7+mLoDWVCcL2BleTFYoNDxmhQmSL7TrPrTmDsqsmSN9QDMPfKjLMhsGpkg5
LXCBk9yVEmDcdHGFauyl5zyWD03zACsHQexKk161FV0kfvKIh5SDiRlwEIitVAS1
JpsW6SrilRklgldtfcm4FIJUP0SuHV3Vd8LOaekDeVj6C4f2onaCtl8weOnh3aWm
HS1491REVWMzO6i/ou5/QAA0NvEIwA==
=QJZm
-----END PGP SIGNATURE-----

--ycJj0z3ShtP8COno--
