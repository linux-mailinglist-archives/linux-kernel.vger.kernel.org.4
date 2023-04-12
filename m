Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE76DF618
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDLMuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDLMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:49:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED367A87
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681303750; x=1712839750;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fZVuhf+4L5nnMWg4MOZqeSNE0R5ZaLEsjp8xfZsQoYc=;
  b=iEM3AAtUHj5vZFDHYSHOZswOekbAKjY6jPoUNbGEmCRJF+XlEglMW1JT
   4DtLcQys6pOwIfl8RqYOzCXf8F+DQM/VPj7gutltdxWJpyCz/QKpuXlEU
   eaRc5Zn7ij8YsNVr8Lt6tJaWJOEYCPOUn5DI3bEchvfx44YOtSDPdlaeI
   OSTkb3J9sgIJnc6ddIyLpDStAEOU5y2q+Z1slzRfktPTLICHg6eXvZ5Zr
   mt+vv0WzCiUVx54SLaEVbJvIyThW5yMOLjJyBtrC4gjciKBVF4MJuh5LI
   iM8j9nvViETPshFriJI/moEPvPNqYtuPDkgl+e77hjkks+yNJhQY94v0u
   A==;
X-IronPort-AV: E=Sophos;i="5.98,339,1673938800"; 
   d="asc'?scan'208";a="209218019"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Apr 2023 05:47:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 12 Apr 2023 05:47:56 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 12 Apr 2023 05:47:54 -0700
Date:   Wed, 12 Apr 2023 13:47:39 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH v2 1/3] cacheinfo: Check sib_leaf in
 cache_leaves_are_shared()
Message-ID: <20230412-hut-unused-21d683fcb8b0@wendy>
References: <20230412071809.12670-1-pierre.gondois@arm.com>
 <20230412071809.12670-2-pierre.gondois@arm.com>
 <20230412-viewpoint-refutable-a31f3657093c@wendy>
 <d7a36615-896b-0f13-a1f6-761715ce460f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oLQO1TaK6ViWJelZ"
Content-Disposition: inline
In-Reply-To: <d7a36615-896b-0f13-a1f6-761715ce460f@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--oLQO1TaK6ViWJelZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 02:34:11PM +0200, Pierre Gondois wrote:
> Hello Conor,
>=20
> On 4/12/23 13:27, Conor Dooley wrote:
> > On Wed, Apr 12, 2023 at 09:18:04AM +0200, Pierre Gondois wrote:
> > > If 'this_leaf' is a L2 cache (or higher) and 'sib_leaf' is a L1 cache,
> > > the caches are detected as shared. Indeed, cache_leaves_are_shared()
> > > only checks the cache level of 'this_leaf' when 'sib_leaf''s cache
> > > level should also be checked.
> >=20
> > I have to say, I'm a wee bit confused reading this patch - although it's
> > likely that I have just confused myself here.
> >=20
> > The comment reads "For non DT/ACPI systems, assume unique level 1 cache=
s,
> > system-wide shared caches for all other levels".
> > Does this mean all level 1 caches are unique & all level N caches are
> > shared with all other level N caches, but not with level M caches?
> > (M !=3D N; M, N > 1)
>=20
> I think the real answer to your question is in the last paragraph,
> but just in case:
>=20
> Each CPU manages the list of cacheinfo struct it has access to,
> and this list is per-CPU.
> cache_shared_cpu_map_setup() checks whether two cacheinfo struct are
> representing the same cache (for 2 CPU lists). If yes, their
> shared_cpu_map is updated.
>=20
> If there is DT/ACPI information, a cacheid/fw_token is associated
> with each cacheinfo struct. This allows to easily check when two
> struct are representing the same cache.
>=20
> Otherwise it is assumed here that L1 caches are private (so not shared)
> and other L2-N caches are shared, i.e. the interface below advertise the
> cache as available from other CPUs.
> /sys/devices/system/cpu/cpu0/cache/indexX/shared_cpu_list

Another silly question:
For two caches of level M & N; M !=3D N; M, N > 1 should they be detected
as shared in the absence of any information in DT/ACPI?
The comment (to me) reads as if they should not, but it is rather vague.

>=20
> >=20
> > Is this patches goal to make sure that if this_leaf is level 2 and
> > sib_leaf is level 1 that these are not detected as shared, since level
> > one caches are meant to be unique?
>=20
> Yes exact.
>=20
> >=20
> > The previous logic checked only this_leaf's level, and declared things
> > shared if this_leaf is not a level 1 cache.
> > What happens here if this_leaf->level =3D=3D 1 and sib_leaf->level =3D=
=3D 2?
> > That'll be detected as shared, in a contradiction of the comment above
> > it, no?
>=20
> Yes, there is a contradiction. The condition should be '&&':
>   (this_leaf->level !=3D 1) && (sib_leaf->level !=3D 1)
> I made a bad rebase and the corrected code ended up in PATCH 3/3.
> Sorry for that. I ll correct it in the v3.

Good to know I am not losing my marbles, I was trying to reconcile the
intent with the patch & without the explicit statement of what was wrong
in the commit message I found it hard!

> Thanks for the review,

nw chief.

--oLQO1TaK6ViWJelZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDaoawAKCRB4tDGHoIJi
0hyeAPj39Sa1sga0eipXhsdbCWKA9HqpCkFqTOKBXtDdlLi4AQCsogwzFxJOiAZL
ENvb7+be3Jd5sudn9OHPO2TedRCLDg==
=jwas
-----END PGP SIGNATURE-----

--oLQO1TaK6ViWJelZ--
