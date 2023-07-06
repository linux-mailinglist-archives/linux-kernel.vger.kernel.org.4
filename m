Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66127495DE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGFGpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGFGpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:45:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957B19B;
        Wed,  5 Jul 2023 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688625927; x=1720161927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YI3foU5MblPQyUbd2sUSOe4Ngn7M7sWkAvN3y52gY9Y=;
  b=T1jftbJBn64zlkLFks64NHNSeWJTdCmyCU9nEKysMRcUWpuZWN4LN/Vz
   3szOQn1QlNksiXPgYDPqEcwBIocU9MfOlrB2x8ZFlPkaAHBZ4MlDDjzrf
   PGH+r02nNsXSqTOeXLKxtZIDNg0OlpTf6FXKCVD6GZ/GA4MgdOkMLXyoq
   NPeOoZwXxtV2bh7sPJ9MMFX5tjS4R6W/0FP7MsXU6d+Mh0GwN8iUGdTDg
   hSi8Ew+DSYs71BSngc0CYJ5k5kXLSrJdeCKG8O9idqWuD5tvAnRKa5P7/
   rouv52p/E/WVj0AyKArK5T4ZoB+HLbRs7WD9W2ep7GfYJFlKDDoko1su7
   w==;
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="asc'?scan'208";a="219119976"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Jul 2023 23:45:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Jul 2023 23:45:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 5 Jul 2023 23:45:12 -0700
Date:   Thu, 6 Jul 2023 07:44:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sunilvl@ventanamicro.com>,
        <ardb@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <rminnich@gmail.com>,
        <mark.rutland@arm.com>, <lpieralisi@kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <jdelvare@suse.com>,
        <yc.hung@mediatek.com>, <angelogioacchino.delregno@collabora.com>,
        <allen-kh.cheng@mediatek.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <tinghan.shen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <geshijian@bytedance.com>,
        <weidong.wd@bytedance.com>
Subject: Re: [External] Re: [PATCH v3 4/4] dt-bindings: firmware: Document
 ffitbl binding
Message-ID: <20230706-syndrome-wise-c1097518f2c6@wendy>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
 <20230705114251.661-5-cuiyunhui@bytedance.com>
 <20230705-oblivious-unstuffed-8e028a5b243c@spud>
 <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UxRv2D6dZld+dL4w"
Content-Disposition: inline
In-Reply-To: <CAEEQ3wmG1OiE3GFqQp9SP+oKUbTfuTPx=rNGd-sjKsW7vv3bew@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UxRv2D6dZld+dL4w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2023 at 11:43:55AM +0800, =E8=BF=90=E8=BE=89=E5=B4=94 wrote:
> On Wed, Jul 5, 2023 at 11:07=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Wed, Jul 05, 2023 at 07:42:51PM +0800, Yunhui Cui wrote:
> > > Add the description for ffitbl subnode.
> > >
> > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > ---
> > >  .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  1 +
> > >  2 files changed, 28 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl=
=2Etxt
> > >
> > > diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/=
Documentation/devicetree/bindings/firmware/ffitbl.txt
> > > new file mode 100644
> > > index 000000000000..c42368626199
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
> >
> > Firstly, new dt-bindings need to be done in yaml, not in text form.
> > Secondly, you didn't re-run get_maintainer.pl after adding this binding,
> > so you have not CCed any of the other dt-binding maintainers nor the
> > devicetree mailing list.
>=20
> Re-run get_maintainer.pl and added maintainers into the maillist.
> emm.. There is some *txt in
> Documentation/devicetree/bindings/firmware/, isn't it?

There might be, but that's not an excuse for adding _new_ ones, sorry.

> > > +FFI(FDT FIRMWARE INTERFACE) driver
> > > +
> > > +Required properties:
> > > + - entry             : acpi or smbios root pointer, u64
> > > + - reg                       : acpi or smbios version, u32
> >
> > Please go look at any other dt-binding (or the example schema) as to how
> > these properties should be used. A "reg" certainly should not be being
> > used to store the revision...
>=20
> Okay, If so=EF=BC=8CI'll add a property "version" into the dts instead of
> "reg", just like, WDYT?
> ffitbl {

Firstly, I'd much rather you spelt this out, like "ffi-table".

>     smbios {
>         entry =3D "";

I still don't understand why "entry", which is an address, is being
represented by an empty string.
I also don't really get why you have not used "reg" to describe its
start address and size.

>         version =3D < 0x02 >;

Probably missing a vendor prefix, and the spaces are unusual, but better
than it was, yes.

>     }
>    acpi {
>          entry =3D "";
>          version =3D < 0x06 >;
>   }
> }

Thanks,
Conor.

--UxRv2D6dZld+dL4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKZi1gAKCRB4tDGHoIJi
0kPBAQC+/8gAglhv+DsGHS+G2SMUClIIP7J58SEWQ7XovHEq5AEA011nqKPb8Sr9
/KtHr/6v6qHXYUtkKGNwJwxU8cRl8A0=
=cxHv
-----END PGP SIGNATURE-----

--UxRv2D6dZld+dL4w--
