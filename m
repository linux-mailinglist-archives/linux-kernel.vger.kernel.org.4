Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E815969DEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjBULWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjBULWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:22:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1E23849;
        Tue, 21 Feb 2023 03:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676978561; x=1708514561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xnVKZ8JYLPRVBwZVLXPtUJF2QZfME0M6oxa6WpSevws=;
  b=wPVRFHvNZm8U+BzACWO1KzdPjrpDVSBNjCQYNWciLvR/QdKLdXQARr+o
   EaL1d2YP5j8n4i6W+btiOcMkS06GmwfbJFmLfTmzdhslFWIdNcUstH3Vt
   E2wW9uFhvN7TO7gjJvYm7cnsEDpKWqRB+rmTNd7ex1WJnhQyjBP3rHAYs
   oX5CEQBCniyeTrAZ16i5AYHm1LFMrj5rm76KGEG9dhqKR/V9KMiAeFRh0
   1M6vpWh0A84OjQDSwsKdiq41TSQOMf+69IxB95UVQvlneOWjWJV7XOIbH
   vc3ewAYGAjOkTIl+69v91gw6myWSLn4cKmCmaVMkpub8UoAzWMx7CR/6X
   w==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="asc'?scan'208";a="201608555"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 04:22:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 04:22:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 21 Feb 2023 04:22:38 -0700
Date:   Tue, 21 Feb 2023 11:22:12 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>
CC:     Jessica Clarke <jrtc27@jrtc27.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <apatel@ventanamicro.com>, <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] RISC-V: Detect AIA CSRs from ISA string
Message-ID: <Y/SpZHRdUXCiV4KT@wendy>
References: <20230128072737.2995881-3-apatel@ventanamicro.com>
 <mhng-0f9bdf58-5289-4db4-8fd7-38898824c44f@palmer-ri-x1c9>
 <CAEg0e7hrQFu+cdZy+3QO1ML9FNTPBehZwOOBnr1F-5ABYDnkGg@mail.gmail.com>
 <CAEg0e7hRjMSgYZbPTQztbQ3bGZf-r8wAfCK5ZnDXOcx27HcTCA@mail.gmail.com>
 <Y/Sfpb2c/LS0LCiA@wendy>
 <F80EBB4C-29C4-472D-B213-EFD220EF9B1F@jrtc27.com>
 <Y/SkES28TNBz02wM@wendy>
 <CAEg0e7i3=Zg5pxG4HCEfFkzpot5-u6yHoTSFKPBuCGU+djZ5uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HQ7FIfEfxxoLIcym"
Content-Disposition: inline
In-Reply-To: <CAEg0e7i3=Zg5pxG4HCEfFkzpot5-u6yHoTSFKPBuCGU+djZ5uw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--HQ7FIfEfxxoLIcym
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 12:03:45PM +0100, Christoph M=FCllner wrote:
> On Tue, Feb 21, 2023 at 12:00 PM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > On Tue, Feb 21, 2023 at 10:51:13AM +0000, Jessica Clarke wrote:
> > > On 21 Feb 2023, at 10:40, Conor Dooley <conor.dooley@microchip.com> w=
rote:
> > > > On Tue, Feb 21, 2023 at 08:12:58AM +0100, Christoph M=FCllner wrote:
> > > >> The full meeting minutes can be found here:
> > > >>  https://lists.riscv.org/g/tech-chairs/message/1381
> > > >
> > > > This link is non functional unfortunately :/
> > >
> > > tech-chairs is private, for (co-)chairs only... not sure why it went
> > > there rather than tech-privileged.
> >
> > Yah, that's what I was getting at.. This is a conversation on a public
> > ML, so it'd be annoying enough for some readers if it was gated around
> > RVI membership, but gating on membership of the inner circle makes it
> > kinda useless!
>=20
> The mail was forwarded there as well (and to tech-unprivileged):
>   https://lists.riscv.org/g/tech-privileged/message/1294
>   https://lists.riscv.org/g/tech-unprivileged/message/430

Great, those I can actually read. Thanks for sharing with the unwashed!

Conor.


--HQ7FIfEfxxoLIcym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/SpZAAKCRB4tDGHoIJi
0gOxAP449GebNOGwifeFqectIA3BJ265MzeJAYp+PoMgGSZ96wEA+vF3amkYJJTt
36jS+BUDlwbiv7F/Px3wiehR/0FmNAU=
=LI0o
-----END PGP SIGNATURE-----

--HQ7FIfEfxxoLIcym--
