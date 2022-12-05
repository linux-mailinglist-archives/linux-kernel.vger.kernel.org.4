Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B33D642AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLEPF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiLEPF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:05:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859413CE3;
        Mon,  5 Dec 2022 07:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670252726; x=1701788726;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zw8dxdg3m3R6zFIw4o03xsSd7j/WCHa3WWnrIy6K6ew=;
  b=XoohWXVoaVCMNYQW0A/WwV1tkJzwHpQENlhFwqezYx99VU2AXtgKITjY
   aGog7egJNGhgDLn6vvLAFfjj3YN6NN7BA+cHltNN5dy+9li1Iy+83/bWp
   6APro6fChV+gnAykwt77sDMD5RDdw2DYZnpRm2HPD81hv16snquUNmzlu
   hfzV3vkce53bY29cPalaUOYB/yjl0gvvX7kHrzmOcXc8i0aEMHBq84gso
   RELxHWQwd9eLNb87KPYQuzZni3oXaLiif80aaHq2lXAJ94xt/FfWEAA6m
   gmyeL86CR0tZO4RdKV5mYSR+MVITDlfciudfT11wIqcjOyU6b0LBWF7vl
   w==;
X-IronPort-AV: E=Sophos;i="5.96,219,1665471600"; 
   d="asc'?scan'208";a="202643683"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 08:05:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 08:05:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Dec 2022 08:05:23 -0700
Date:   Mon, 5 Dec 2022 15:05:04 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Icenowy Zheng <uwu@icenowy.me>
CC:     Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Message-ID: <Y44IoC765yztZ6VF@wendy>
References: <20221121041757.418645-3-uwu@icenowy.me>
 <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
 <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
 <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
 <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
 <20221130181330.GA2544489-robh@kernel.org>
 <Y4j+Gpptk3NAFBNV@spud>
 <4ad56fa249a30167844abcedac53d198606511d8.camel@icenowy.me>
 <Y43Jt3YOSbFyh954@wendy>
 <75a3ef9a175b16c46b57b2829ecbe4f97737de8a.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dsnIWWXsziWEFZwU"
Content-Disposition: inline
In-Reply-To: <75a3ef9a175b16c46b57b2829ecbe4f97737de8a.camel@icenowy.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dsnIWWXsziWEFZwU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 07:03:17PM +0800, Icenowy Zheng wrote:
> =E5=9C=A8 2022-12-05=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:36 +0000=EF=
=BC=8CConor Dooley=E5=86=99=E9=81=93=EF=BC=9A

> > You lot all know the situation here a lot more than I do...
> > I don't think "letting" people use the bare "thead,c900-foo" makes
> > much
> > sense as it gives us no chance to deal with quirks down the line.
>=20
> Well, after rechecking the manual, I found it possible to handle quirks
> -- T-Head has a custom "mcpuid" CSR (@ RISC-V CSR 0xFC0), which can be
> used to retrieve some identification info of the core, including its
> model ID, version, etc; and the T-Head PLIC/CLINT are part of their
> C906 SoC design that there's another "mapbaddr" CSR that could be used
> to retrieve the base address of them.
>=20
> So I think it okay to just use "thead,c900-clint" here, and when
> necessary, try to retrieve mcpuid for dealing with quirks.

I'm not super sure I follow. What's the relevance of "mapbaddr" here?
We've got a reg property, so I don't think we need "mapbaddr"?

For "mcpuid", can you be sure that implementers will not omit setting
that value to something unique? I'd be happier if we were overly clear
now rather than have some headaches later. Have I missed something?

> > I don't think that using "thead,openc906-clint", "thead,c900-clint"
> > makes all that much sense either, in case someone does something
> > wacky
> > with the open-source version of the core.
> >=20
> > That leaves us with either:
> > "vendor,soc-clint", "thead,openc906-clint", "thead,c900-clint"
> > or:
> > "vendor,soc-clint", "thead,c900-clint"
> > right?
> >=20
> > The first one seems like possibly the better option as you'd kinda
> > expect that, in a perfect word, all of the open-source IP
> > implementations would share quirks etc?


--dsnIWWXsziWEFZwU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY44IoAAKCRB4tDGHoIJi
0kD4AQCR4eYQLgineg6X0LMoB3wJa2iav+5X+jNESvGVfuIctQEArogX3y1vXKA/
Car1Dd1C4S5kljZMxWlathZkKWQrVgY=
=Ozbn
-----END PGP SIGNATURE-----

--dsnIWWXsziWEFZwU--
