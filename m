Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5E6EA70F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjDUJfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjDUJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:35:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE757A27B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682069704; x=1713605704;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NV8VuiK+tse/d3eCoBhWoB+mn1ohvI8raF4dIfXPw7Q=;
  b=wNF1B0O3ixSIjG+0fHgltYKTdVUlYa5uDPuiE2IbsxjGD9E2OICdf3tH
   jEWB8NMndAZ27jAk62XhJoLAisH8qm3WEBLulH7pNlY2SsTQKcK+H+kr6
   UVuoga21H3SBxIS985+Ww1QA/WyAXs7f1eYAFErDG1VyIYzI20snvtY4o
   hIwxsMD5KtLwwyVSGZLoVUjEGMuZSPiGoMbItmm7ui+OJR13O0dZLb5RF
   vjyCsjmNs0m3vEeutcCK8sclnq2Oh5tc8U+xHc2OgRI9UcFz7SSKHjOBF
   SVmgEmQR+yCI/FoQty6EEPKjIbLxI2My0OgGDizIK4lDNe0rVy4OklL0p
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,214,1677567600"; 
   d="asc'?scan'208";a="210571253"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2023 02:35:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 21 Apr 2023 02:35:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 21 Apr 2023 02:35:01 -0700
Date:   Fri, 21 Apr 2023 10:34:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Drew Fustini <dfustini@baylibre.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Subject: Re: [RFC PATCH 2/2] RISC-V: Add support for sqoscfg CSR
Message-ID: <20230421-radio-pampers-182af9ea859d@wendy>
References: <20230410043646.3138446-1-dfustini@baylibre.com>
 <20230410043646.3138446-3-dfustini@baylibre.com>
 <20230417-culinary-capillary-4f1efd496691@spud>
 <ZD2mO/2BH9Zo3iqO@x1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="93JrebvIW3f6S90/"
Content-Disposition: inline
In-Reply-To: <ZD2mO/2BH9Zo3iqO@x1>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--93JrebvIW3f6S90/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 17, 2023 at 01:04:11PM -0700, Drew Fustini wrote:
> On Mon, Apr 17, 2023 at 08:10:20PM +0100, Conor Dooley wrote:
> > On Sun, Apr 09, 2023 at 09:36:46PM -0700, Drew Fustini wrote:

> > >  #ifdef CONFIG_FPU
> > >  extern void __fstate_save(struct task_struct *save_to);
> > > @@ -79,6 +80,7 @@ do {							\
> > >  	if (has_fpu())					\
> > >  		__switch_to_aux(__prev, __next);	\
> > >  	((last) =3D __switch_to(__prev, __next));		\
> > > +	qos_sched_in(__next);				\
> >=20
> > Both FPU and vector do:
> > |	if (has_fpu())					\
> > |		__switch_to_fpu(__prev, __next);	\
> > |	if (has_vector())				\
> > |		__switch_to_vector(__prev, __next);	\
> >=20
> > Is it just my OCD that wants ssqosid to be the same?
>=20
> Thanks, I had not noticed those changes from the vector patch series [1]
> until you pointed it out. The handling of sqoscfg could be converted to
> that pattern too.
>=20
> > It'd also do away with that seems a bit weird to me: having
> > qos_sched_in() and __qos_sched_in().
> > Even if you don't make them similar, what's the rationale behind not
> > inverting the extension check & returning early from a single function.
>=20
> The goal was so the inline qos_sched_in() would turn into a nop when
> Ssqosid extensions not present. If Ssqosid was present, then the "real"
> function __qos_sched_in() would be called.
>=20
> However, having looked at the handling of fpu and vector in the vector
> series, I think will redo the sqoscfg handling to follow that pattern.

Aye. With the way they do it, if !CONFIG_..._SSQOSID, DCE should
remove the function call entirely & the has_extension_[un]likely() stuff
will give you your nop for kernels with CONFIG_..._SSQOSID but no
hardware support.

I think it looks "nicer"/more obvious if you copy what the fpu/vector
stuff does /shrug

Cheers,
Conor.

--93JrebvIW3f6S90/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEJYtAAKCRB4tDGHoIJi
0koqAP9JSTnE1ituL4i8GxzmCkIFr4W2t/O2GE/Ovpu/VESQygEA2SxnDL+DnpGW
tNkEQiBeE+EYDnbfMEXNxjPF2aYelg8=
=64pG
-----END PGP SIGNATURE-----

--93JrebvIW3f6S90/--
