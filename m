Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ADF679CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbjAXOzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjAXOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:54:59 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD90813D60
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674572096; x=1706108096;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Aqg7OTmodw3SWwmONFkR7fFT/auEU1rbO2adYYQQeo=;
  b=vP3KJjD0QSmJF6yEx6lU3IqEpI3A0Wi3rGJbXTF/cPih062EsaSmz5JY
   r7rz/EecDf8iD6htq9y7PBf+DkqIYhEoKXbGnkMF3d4u0VrWn2cM8WUsL
   SnGr55VqimRol5Pvjj+8exjLxZl4TOXZftwo2iq+lfVVxAYgi3li68fof
   YieNHWO9OQS2FuUnydirB6efHPaFHw8mW09ARwivVOEkfzUkkhOfXl8P6
   dYmcihPC/tugvvT3jjxhRgtiX9qMhfFTmI68Ldewl/IZymHso5q+6hOok
   k2+74GgCFh388lsLTo3gwRBbu7SH0IpqEXTLL88e5QSHe6qC5mqxVFODG
   g==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669100400"; 
   d="asc'?scan'208";a="198078663"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 07:54:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 07:54:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 24 Jan 2023 07:54:52 -0700
Date:   Tue, 24 Jan 2023 14:54:29 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v6.3
Message-ID: <Y8/xJZOourqBvxVR@wendy>
References: <20230120121856.1407369-1-sudeep.holla@arm.com>
 <CAMuHMdUZzLkWvhQ=YeH2KfQ_FRidemfOvbbHf_b1AHROK9HFNA@mail.gmail.com>
 <20230124144245.ddphvqbcxpzrlgek@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WNceExkhTMtKXWOE"
Content-Disposition: inline
In-Reply-To: <20230124144245.ddphvqbcxpzrlgek@bogus>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--WNceExkhTMtKXWOE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 02:42:45PM +0000, Sudeep Holla wrote:
> On Tue, Jan 24, 2023 at 02:44:10PM +0100, Geert Uytterhoeven wrote:
> > Hi Sudeep,
> >=20
> > On Fri, Jan 20, 2023 at 1:22 PM Sudeep Holla <sudeep.holla@arm.com> wro=
te:
> > > It has been tested on RISC-V which is the main users outside of arm64.
> >=20
> > Has it?
> >
>=20
> Hmm, I might have mixed up things then. I was on a vacation for quite some
> time and might have assumed Conor response on the thread with testing.
> Extremely sorry for that. However it was in -next for few days before
> Greg applied to his tree.

Sorry chief! The CI stuff we run on the RISC-V patchwork only provides
build coverage etc & my CI against linux-next doesn't check for this kind
of thing.
I'll put it on my todo-list to add that, both for patchwork and in our
internal CI.
I only reviewed the patch that was moving the code to common group and
not the others unfortunately. Next time I'll be sure to review the lot!

Thanks,
Conor.



--WNceExkhTMtKXWOE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8/xJQAKCRB4tDGHoIJi
0tp/AQCZb4MIIYgEB3TFMu5py4DRir2pfY2mDK/y9ErwoNDKsQD+JjbUCxk+P5TI
GnCI0mjKSnBOpe7Xwz7qxOTETGES7QU=
=LjqK
-----END PGP SIGNATURE-----

--WNceExkhTMtKXWOE--
