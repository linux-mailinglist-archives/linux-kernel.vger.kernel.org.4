Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8A0717BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjEaJ0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjEaJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:26:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26538BE;
        Wed, 31 May 2023 02:26:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE1AF62CF3;
        Wed, 31 May 2023 09:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524B6C433EF;
        Wed, 31 May 2023 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685525179;
        bh=kCngoFLY3lyAAH4tsRcdWI7tJBxXdBmSNlRrvULPxEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cN57/V1H77acTm/qT6l3T6VdkNRu0nkljtAkksa/ldX/AzR4pvcJmVYON5karjEuv
         +OEPWvftye3sDhNO47XR2IpW8C2rIqyBYJuLmJVD1x7EWTTacoTRZtSPKtDWNmSeL5
         ID/4jLdzuFb/q4pDcmWRvmf0OzJ761lDkB/2t7r0ndHmkDO6cNFYUvTQdMEKkKFIbu
         1A8kjIWEIeW4nvfOCSaszPVUn9Ey5B5W5Oi18ZqwVvAdeynzZk5QnTQBxsi2/jSW8H
         tCKkXMbShumUPNSa4KkssEOxcdr1CZbNRXqV3gza5xN4q0owe8BUmF5F+e6o9kksrR
         NPWQ4uuPVvQ4A==
Date:   Wed, 31 May 2023 10:26:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo
 error message if -ENOENT
Message-ID: <20230531-anatomy-rectified-6ed3555c5f16@spud>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
 <20230530-basically-wildly-84415a94171d@spud>
 <72d84100-55cf-566d-8301-7147ce14b1e9@broadcom.com>
 <20230531085356.ru4fmtawyxo5cq5s@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qnb73kesuk0hpnPs"
Content-Disposition: inline
In-Reply-To: <20230531085356.ru4fmtawyxo5cq5s@bogus>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qnb73kesuk0hpnPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 09:53:56AM +0100, Sudeep Holla wrote:
> On Tue, May 30, 2023 at 03:42:45PM -0700, Florian Fainelli wrote:
> > Hi Conor,
> >=20
> > On 5/30/23 14:39, Conor Dooley wrote:
> > > Yo Florian,
> > >=20
> > > On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
> > > > From: Pierre Gondois <pierre.gondois@arm.com>
> > > >=20
> > > > commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream
> > > >=20
> > > > fetch_cache_info() tries to get the number of cache leaves/levels
> > > > for each CPU in order to pre-allocate memory for cacheinfo struct.
> > > > Allocating this memory later triggers a:
> > > >    'BUG: sleeping function called from invalid context'
> > > > in PREEMPT_RT kernels.
> > > >=20
> > > > If there is no cache related information available in DT or ACPI,
> > > > fetch_cache_info() fails and an error message is printed:
> > > >    'Early cacheinfo failed, ret =3D ...'
> > > >=20
> > > > Not having cache information should be a valid configuration.
> > > > Remove the error message if fetch_cache_info() fails with -ENOENT.
> > > >=20
> > > > Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b=
57a@spud/
> > > > Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Link: https://lore.kernel.org/r/20230414081453.244787-4-pierre.gond=
ois@arm.com
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > >=20
> > > How come this now needs a backport? Did the rest of the series get
> > > backported, but not this one since it has no fixes tag?
> >=20
> > Humm, indeed, this has been present in v6.3.2 since I requested it to be
> > included. The error that I saw this morning was not -ENOENT, but -EINVA=
L.
> >=20
> > With those patches applied, no more -EINVAL:
> >=20
> > cacheinfo: Allow early level detection when DT/ACPI info is missing/bro=
ken
> > cacheinfo: Add arm64 early level initializer implementation
> > cacheinfo: Add arch specific early level initializer
> > cacheinfo: Add use_arch[|_cache]_info field/function
> >=20
> > I will submit those shortly unless we think they better not be in 6.3, =
in
> > which case it would be nice to silence those -EINVAL errors.
>=20
> I prefer this option instead of back porting all the above 4 as there are
> some pending fixes for the issues found in those patches. I am fine if Gr=
eg
> is happy with the backport, so no strong rejection from my side :).

Just to be clear, I was not objecting, just curious!

--Qnb73kesuk0hpnPs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHcStgAKCRB4tDGHoIJi
0vIEAQDdpFgU4o/G3Uwvv77EtTUObcme8oZvNeuRkgayXb63kAEAgdawFvzSpDJL
Um0VmT9jcTispriQLw1RK4h2YSIliQo=
=l1hc
-----END PGP SIGNATURE-----

--Qnb73kesuk0hpnPs--
