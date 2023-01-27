Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13167E80F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:21:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjA0OVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjA0OU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:20:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1287C739;
        Fri, 27 Jan 2023 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674829256; x=1706365256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qRi/ydqT7NbsVpsX89s+hti2aWqBktbxWkTgajSS8xY=;
  b=FeG/zE7WJyVbwuB4ducl9U96sROcEXTKEhn2gCzc1GRuQWXrpnFmC1Wk
   wlYIkMZjVhdsVbpmjpwF8ATL1EpmahQitQVWL4+GqMkB1B102YoIy/L1M
   ar0VgwA+2Cky/HROxQFGQh0awojlJSWD5E2QX15rqjf/hMiJAPkb6I4K9
   ENgLX6/celO/c4wiWOCyyhSIfrFgRWjUj3KkqkmBbqpa4o82f3rS449vY
   rw2YPLTGdQ4bBcAQ0HXfn/hvhZHJ3N54LYoA5Q1op6rP3v1MK0ZVtTo6U
   vmsn4VgiCPWyixjCcozXxnbOJaw2NA0GN7LgTEC/R3ieB1BkXnpo4MzlV
   w==;
X-IronPort-AV: E=Sophos;i="5.97,251,1669100400"; 
   d="asc'?scan'208";a="198299614"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jan 2023 07:20:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 07:20:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 27 Jan 2023 07:20:52 -0700
Date:   Fri, 27 Jan 2023 14:20:28 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/9] RISC-V: Add AIA related CSR defines
Message-ID: <Y9PdrOvb8bYXpgVw@wendy>
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-2-apatel@ventanamicro.com>
 <Y7YGp/7ufyRPhkwg@spud>
 <CAAhSdy2YKJfuxhBmsx9v-OMyxKQjys+J-z_ZqoPJF7q=YrE4Zw@mail.gmail.com>
 <Y8cIG6gKSlkTh5AF@spud>
 <CAK9=C2VzJvpQLPedc+ruUnw8xDDDaC6_Vmj6qg1nXv+iqU-AfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q5G9sbwHy4TPVN/e"
Content-Disposition: inline
In-Reply-To: <CAK9=C2VzJvpQLPedc+ruUnw8xDDDaC6_Vmj6qg1nXv+iqU-AfQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Q5G9sbwHy4TPVN/e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 05:28:57PM +0530, Anup Patel wrote:
> On Wed, Jan 18, 2023 at 2:12 AM Conor Dooley <conor@kernel.org> wrote:

> > > > > +/* AIA CSR bits */
> > > > > +#define TOPI_IID_SHIFT               16
> > > > > +#define TOPI_IID_MASK                0xfff
> >
> > While I think of it, it'd be worth noting that these are generic across
> > all of topi, mtopi etc. Initially I thought that this mask was wrong as
> > the topi section says:
> >         bits 25:16 Interrupt identity (source number)
> >         bits 7:0 Interrupt priority
>=20
> These defines are for the AIA CSRs and not AIA APLIC IDC registers.
>=20
> As per the latest frozen spec, the mtopi/stopi/vstopi has following bits:
>     bits: 27:16 IID
>     bits: 7:0 IPRIO

I know, that those ones use those bits, hence leaving an R-b for the
patch - but your define says TOPI, which it is *not* accurate for.
That is confusing and should be noted.

> > What I was advocating for was picking one style and sticking to it.
> > These copy-paste from docs things are tedious and error prone to review,
> > and I don't think having multiple styles is helpful.
>=20
> On the other hand, I think we should let developers choose a style
> which is better suited for a particular register field instead enforcing
> it here. The best we can do is follow a naming convention for defines.

Well shall have to agree to disagree I suppose!

> > Tedious as it was, I did check all the numbers though, so in that
> > respect:
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> BTW, this patch is shared with KVM AIA CSR series so most likely
> I will take this patch through that series.

Since the path which it gets applied is between you and Palmer to
decide, feel free to add the R-b whichever way the patch ends up going!

Thanks,
Conor.


--Q5G9sbwHy4TPVN/e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9PdrAAKCRB4tDGHoIJi
0hKXAQCV41cEz/0+TALwgNAhpxgpr/x9in2qmKvIyEVcmTybHgEA/fTEeQ8D3ipy
4nLYxkY/iE4Orn6/f5tKcQ1ydfXq3QE=
=1kNL
-----END PGP SIGNATURE-----

--Q5G9sbwHy4TPVN/e--
