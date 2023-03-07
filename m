Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECC06AE192
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCGOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCGOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A6477C91;
        Tue,  7 Mar 2023 06:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E77D66143A;
        Tue,  7 Mar 2023 14:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D3C433A7;
        Tue,  7 Mar 2023 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678197702;
        bh=2mGQZRLNoz0yS+ALWl4LpTGIySLxfDySlk84qGzNyi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzmLHiAmPX31HQtQOy+HM9KJ9obz6dJTBjrHwwhMPwwIUqF+2zqHRyh2ritZ8WvAU
         nsshCDj8eIGaPsds5IH7p67yqQngPnUBvAQdULwp056/turtof42t/jvR7OltjfwbQ
         d+vxW1UMjwVW2afGzvu2rD9cxjtX801ItzSrsTMC4DrN+PIlC7KAUrSJrNDa+WBVy5
         2LZfKGwj+++PZyKJ9Wq03bInMa44dQiajhRdIQWe8uQjBVANVqBmO02WYMRYqK3eUF
         l90IY3hn36/cl74ms1pVX6x/ilGY7Rur5j86/ZZBMnau4TI+OrLtNug1cU0bBUxb0K
         86AlgkUU1JgrA==
Date:   Tue, 7 Mar 2023 14:01:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
Message-ID: <560c01eb-7166-4b56-b9e0-77cacf83cf69@sirena.org.uk>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
 <1bbda9e6-37fb-195b-fd62-0e437847c636@linaro.org>
 <BN7PR12MB2802992D71DDA252B008AFDADCB79@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f88b7164-881b-5ada-0d52-05fe418f7b85@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+lqAPw/yMTRaWbuS"
Content-Disposition: inline
In-Reply-To: <f88b7164-881b-5ada-0d52-05fe418f7b85@linaro.org>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+lqAPw/yMTRaWbuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 11:47:27AM +0000, Tudor Ambarus wrote:
> On 3/7/23 11:37, Mahapatra, Amit Kumar wrote:

> > > On 3/6/23 17:21, Amit Kumar Mahapatra wrote:=09
> > > > Multi CS support using GPIO is not tested due to unavailability of
> > > > necessary hardware setup.

> > > Please don't add code that is not used or tested.

> > During our discussion on the RFC, Mark had suggested to add multi-cs su=
pport
> > via GPIO as well. We had agreed to add multi-cs support via GPIO, but h=
ad also
> > mentioned that we don't have a hardware setup to test the CS GPIO use c=
ase.
> > https://lore.kernel.org/linux-arm-kernel/BN7PR12MB2802E2A9079E505932832=
270DC979@BN7PR12MB2802.namprd12.prod.outlook.com/

> Ok, his call then.

As well as hopefully working if anyone does need it GPIO implementations
also serve as documentation of what we're expecting hardware to do when
it implements things.

--+lqAPw/yMTRaWbuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHQ8AACgkQJNaLcl1U
h9DWMAf/dqUtzrGMgRBoWLFJUBQD5J+eu4PmFpPDZJETNqwSazPcVa97COLuA/xh
Wxc4iP5Kot8o2WJlHei50Pbxv1iMrEoWbUCCd3y7Rh27gxzdDUNxzESmduZZx3lt
EIw5UhModB6CBqa8J7/0983QxIxDirGnzA63WM5jaNLOZLmQCgvPXXJJSeokTsn4
F8IvC0ECKlKQOYYgsXImnbxoDV1mrNkeVhaJ0+IEwp3var83U5cDWGhoX/b/Ns3l
uQNlkmMIKNty6+tvtzrrBPsxFUnvBbC4VsjxLxk85Jq8JsWTUA3SGvsMoN1jH2JW
5cfkBKfg3YEuyCspeCUoDCL1l9DwIA==
=YbJC
-----END PGP SIGNATURE-----

--+lqAPw/yMTRaWbuS--
