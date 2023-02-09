Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6876D6902C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjBIJEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIJEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:04:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291BEC4B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675933458; x=1707469458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B22J8C980OM1Kvqfd4PEL6BBxLh6LNsp47XsaCW9fb4=;
  b=hIRQJJGDUfw9/NreacGx+h/dayyQKhxiGt29GqjlcrANcFKDAwWSpDJ/
   uGqIt93/tY9inztrr/lGlofKPi56pK0AWzVl0tS+2odg3fNN7uLYsP4L3
   cBkIM7n4oa0I/nVp81pvs0X5IaxcP4Qso8mIu3Ps1g5gt3CWyGr1pg6RR
   eYkcM4EK0soBbfTvnl7nilwv/iwVNNjARnxcj2hQ6JvkKGTMsbq4ckfdR
   Oixka0MDKhLDda/GOVJFXze/ix1/43/84O4QAWF7WmdW2SBbr7o7NxFdW
   qoPs1+VjmyQ684NhsIvTnbaXJbLLGC+SH/5bzKHgBHzSlbGhMEcdkKdhm
   g==;
X-IronPort-AV: E=Sophos;i="5.97,283,1669100400"; 
   d="asc'?scan'208";a="211236035"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2023 02:04:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 02:04:17 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 9 Feb 2023 02:04:15 -0700
Date:   Thu, 9 Feb 2023 09:03:50 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        <palmer@rivosinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <christoph.muellner@vrull.eu>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH 1/2] RISC-V: fix ordering of Zbb extension
Message-ID: <Y+S29qPN6jmMwvi3@wendy>
References: <20230208225328.1636017-1-heiko@sntech.de>
 <20230208225328.1636017-2-heiko@sntech.de>
 <C32D5495-F772-4887-9CAD-66206ECCFC3F@kernel.org>
 <20230209082520.solukez3jrshv3qo@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hNr57WA66Fc7v39A"
Content-Disposition: inline
In-Reply-To: <20230209082520.solukez3jrshv3qo@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--hNr57WA66Fc7v39A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2023 at 09:25:20AM +0100, Andrew Jones wrote:
> On Wed, Feb 08, 2023 at 11:20:10PM +0000, Conor Dooley wrote:
> > Hey Heiko,
> >=20
> > On 8 February 2023 22:53:27 GMT, Heiko Stuebner <heiko@sntech.de> wrote:
> > >From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> > >
> > >As Andrew reported,
> > >    Zb* comes after Zi* according 27.11 "Subset Naming Convention"
> > >so fix the ordering accordingly.
> > >
> > >Reported-by: Andrew Jones <ajones@ventanamicro.com>
> > >Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> >=20
> > The whole "getting it wrong immediately after fixing it up" ;)
>=20
> Hi Conor,
>=20
> Do you know any patchwork savvy people that could whip up a check
> for this array? :-)

Maybe that is more of a checkpatch type thing?

Either way, I'll put it on the todo list I suppose!

--hNr57WA66Fc7v39A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+S29gAKCRB4tDGHoIJi
0g7fAP9oVUIeufGJdmfpCNWTvatLD+qZqM6xhguUpuIizocYtQEAlN4fj4zu3jTO
ex8o2+z+i3+9g/A71DmaXbiPPOIrGQA=
=581v
-----END PGP SIGNATURE-----

--hNr57WA66Fc7v39A--
