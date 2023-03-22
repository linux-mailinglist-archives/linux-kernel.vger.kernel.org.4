Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418B6C4448
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCVHpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCVHpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:45:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00D457C5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679471110; x=1711007110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RYefIU0H1tV7oRs3iK9qN/VFbE6LPVzSiwMg5YgkybQ=;
  b=IeiaYArwuHY1pwiwDRsgq0ID00TQFcUq+xkMuOUH1zgHlLJ9bLzGlI9A
   THdfjl8nCg0wdGUQywK4X/WaQAk4p8gnGNCHfQqcRbegOpcPi6qC5f92a
   FE8nEimxBUTv2we8edrD1S5c1AHEO87VOCwoSrLyRlDFtIQ9iDVoSRbun
   apDros7z4eo65/3LgOmVDjkocDIAizLUWB2pRSXKnzAWk3G9x0awk5B8h
   rommvkrWOhdZvpWv7rmFdksUen0NSMIyrrhpPCkgoWrcavMV1DMfnsbFY
   sqzT5A5N49n1Zx7RpcZx/u8PT9zGPydqzMTJRj5tMfr9Q+SCW8rQbbUDw
   A==;
X-IronPort-AV: E=Sophos;i="5.98,281,1673938800"; 
   d="asc'?scan'208";a="202832350"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Mar 2023 00:45:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 00:45:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 22 Mar 2023 00:45:06 -0700
Date:   Wed, 22 Mar 2023 07:56:18 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
Message-ID: <76e39a0e-1ca9-435a-82b5-6655579cef9a@spud>
References: <20230318080059.1109286-1-leobras@redhat.com>
 <8f698f49-135a-4263-8471-96f406919cb1@spud>
 <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
 <18e07d0a-7e21-46d0-9166-6ee07817352a@spud>
 <CAJ6HWG5zHMB1-vVsuQ+nG3EC12JAi2MP5o8GbSQ9QJfgLEQNnw@mail.gmail.com>
 <4d9770c7-3cb6-42d6-891f-1247a02742e9@spud>
 <CAJ6HWG5+5f_z7HaVb70w4wxtTbyMMxwTAwpk5gv4C4JiSve5iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zA6GcOdC/jSQ4LTZ"
Content-Disposition: inline
In-Reply-To: <CAJ6HWG5+5f_z7HaVb70w4wxtTbyMMxwTAwpk5gv4C4JiSve5iA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--zA6GcOdC/jSQ4LTZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 12:42:56AM -0300, Leonardo Bras Soares Passos wrote:
> On Tue, Mar 21, 2023 at 4:48=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, Mar 21, 2023 at 02:01:59PM -0300, Leonardo Bras Soares Passos w=
rote:
> > > On Tue, Mar 21, 2023 at 4:49=E2=80=AFAM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Tue, Mar 21, 2023 at 03:30:35AM -0300, Leonardo Br=C3=A1s wrote:

> > > > > For patch 5/6 it actually adds many more lines, but tracking (som=
e of) the
> > > > > errors gave me no idea why.
> > > >
> > > > Probably just sparse being unhappy with some way the macros were
> > > > changed - but some of it ("Should it be static?" bits) look very mu=
ch
> > > > like the patch causing things to be rebuilt only for the "after the
> > > > patch" build, but somehow not for the "before" build.
> > >
> > > Humm, not sure I could understand that last part:
> > > What I get is that the patch 5/6 is causing things to be rebuilt, and
> > > it was not like that on 1-4/6.
> > > Is that what you said?
> > > If so, and you are doing it as an incremental build, changing the
> > > macros in 5/6 should be triggering rebuilds, but it does not make
> > > sense to not be rebuilt in 1-4/6 as they change the same macros.
> >
> > Right, it is an incremental build.
> > First it builds the tree with a patch applied, then it checks out HEAD~1
> > and builds that tree. Then it goes back to the tree with the patch
> > applied and builds it again. The output from builds 2 & 3 are compared
> > to see if any errors snuck in.
> > In theory, that should ensure that, as builds 2 & 3 have had the same
> > diff to the previous one just in opposite directions, the same files get
> > rebuilt - but I am a little worried that ccache gets involved sometimes
> > and leads to the before/after builds not being exactly the same.
>=20
> Makes sense to me.

Oh, the other thing that I didn't notice until now is that, if, as
in your case, HEAD~1 for the patch currently being tested does not build
but the HEAD build does, the HEAD build will have more sparse coverage
than the HEAD~1 one. Cos of that, sparse is likely to find more issues in
the after build, and you end up with +1000 error count like patch 5 in
the v1.
If you look at your most recent version, that doesn't have build issues,
patch 5 gets the all-clear:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D732217

Not sure why I didn't notice that before, I completely forgot that 4/6
had build issues and it should've been immediately obvious to me why 5/6
had a bunch of extra sparse warnings...


--zA6GcOdC/jSQ4LTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBq0ngAKCRB4tDGHoIJi
0glZAQCLTV6fmIThzea60AfrZGhW2ChbeyHWwHwcml5KyOItzwEAt6XoV0kTQhDk
ocbElrRZ1d8ZR65TbcjJCvk3ur1adgU=
=u33Y
-----END PGP SIGNATURE-----

--zA6GcOdC/jSQ4LTZ--
