Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D0716352
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjE3ONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjE3ON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:13:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDA1A8;
        Tue, 30 May 2023 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685455971; x=1716991971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WEVu+mlvG0A1jNh0gMO3FS1zwOln0/CKg69F1Wt0HZ4=;
  b=uSI2073EMpI6UpRAYMz/GdViDIDiTvwHYHPPp8W00IPxMqU3UjRM8ul1
   haZksZhJckEHnneTFjwlSDPFoym5+fG0dX6g39FM51Wy6Ydr6ZgEefByZ
   4yDGhAPDNEJuEKxE7pXZitaWp9/W5DMs8XX04Ziq5JTsr4pYcqdBgOnqy
   H2jM9vgIOHcmKaCBcBJa7TK2Sr8rzN8hs3yc3nTpNFCzyBnO2Mz+xN5NY
   p2qs3YU9+/S1WyfF+fzm+e8MmTIicgh5p3SXhsymHmt8xrFUlp6/qP9q6
   +TcpIoGdOLu2zYBIAsuDuyXBLDIVvMaCvHODvmyVuKLVi69HE+S7Ojwqx
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="asc'?scan'208";a="213732970"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 07:12:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 07:12:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 07:12:35 -0700
Date:   Tue, 30 May 2023 15:12:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230530-duller-reset-a34ae111f207@wendy>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ljjWyKcHLn9dJQRC"
Content-Disposition: inline
In-Reply-To: <20230518-monkhood-dispersal-6749b1228b0d@spud>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ljjWyKcHLn9dJQRC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:

> >=20
> > Why not just have something like
> >=20
> > mycpu {
> > 	...
> > 	riscv,isa {
> > 		i;
> > 		m;
> > 		a;
> > 		zicsr;
> > 		...
> > 	};
> > };
>
> Naming of the node aside (perhaps that could be riscv,isa-extensions)
> there's not something hitting me immediately as to why that is a no-no.
> If the size is a concern, this would certainly be more efficient & not
> like the probing would be anything other than trivial more difficult
> what I have in my proposal.

Having started messing around with this, one of the main advantages, to
me, of this approach is proper validation.
cpus.yaml has additionalProperties: true in it, which would have had to
be sorted out, or worked around, but creating a child-node with the
properties in it allows setting additionalProperties: false.

> Rob's AFK at the moment, and I was hoping that he would take a look at
> the idea, so I won't respin til he is back, but I'll give this a go in
> the interim.

Mechanically, the conversion of the patch isn't difficult, but I'll still
wait for Rob to come back before sending a v2. But that v2 will more
than likely implement your suggestion.

Cheers,
Conor.

--ljjWyKcHLn9dJQRC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHYEPAAKCRB4tDGHoIJi
0gU0AQC4+rB11CsvWYlWy1TRnq5jU9IikN+9XHIPda7SYYnZMQEAo6jPRTwwWFo7
hJxgKpYYRrcYOdotg5wYkneWq4yBCQs=
=BG8u
-----END PGP SIGNATURE-----

--ljjWyKcHLn9dJQRC--
