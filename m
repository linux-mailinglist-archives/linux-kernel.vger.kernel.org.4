Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73773B68A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 13:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjFWLpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjFWLpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 07:45:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DCE269F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687520717; x=1719056717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F5ArTWbF/LdP4e4VJCrc8bszzrQN73ij9SDqo5h2rA4=;
  b=tiURw+DomN2ZpklZC4w735gh6dsoOPuJR3EjDZuXmfnjFS0y+fHNNWm1
   Nuv/CmyOTfNzQEQgV4W/t83gvMkcZxZ79J+Tb4nY5jw5yc6U8Mn/fStLR
   UYhPhkE0itEZz4AbOIezHAKKgheIkagdgVwhUzmkcSHZ+0cnvrDOk9Yw7
   yzV+iy+x9x9/u/csFRh1FKQvqoTj3ilz5Y9Eh+u1aiX5rFGZSHevnnwnQ
   6oXX9fqud4GuCuESduzK+cIrTD1wz0iHwZySGE89d9rFvyCaJ8kcMAMEO
   QzThrwXBOdSEE22SsqHfrVPNlI1PHkzeMJMt+j2KraMHJ6BzXlrxzGvKs
   g==;
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="asc'?scan'208";a="221619829"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2023 04:45:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 04:44:39 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 23 Jun 2023 04:44:38 -0700
Date:   Fri, 23 Jun 2023 12:44:11 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
CC:     <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <samuel@sholland.org>,
        <guoren@kernel.org>, <christoph.muellner@vrull.eu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] RISC-V: add T-Head vector errata handling
Message-ID: <20230623-divisive-java-3cbb7172b8d8@wendy>
References: <20230622231305.631331-1-heiko@sntech.de>
 <20230622231305.631331-4-heiko@sntech.de>
 <20230623-excluding-sprint-aea9cca0cb02@wendy>
 <1908808.taCxCBeP46@diego>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r3osZw/jhAPvPKj5"
Content-Disposition: inline
In-Reply-To: <1908808.taCxCBeP46@diego>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--r3osZw/jhAPvPKj5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 12:40:43PM +0200, Heiko St=FCbner wrote:
> Am Freitag, 23. Juni 2023, 11:49:41 CEST schrieb Conor Dooley:
> > On Fri, Jun 23, 2023 at 01:13:05AM +0200, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@vrull.eu>

> > I'm also _really_ unconvinced that turning on extensions that were not
> > indicated in the DT or via ACPI is something we should be doing. Have I
> > missed something here that'd make that assessment inaccurate?
>=20
> Hmm, DT (and ACPI) is a (static) hardware-description, not a configuration
> space (sermon of DT maintainers for years), so the ISA string in DT will
> simply describe _all_ extensions the hardware supports. So there _should_
> never be a case of "I want to disable vectors and will remove the letter
> from the ISA string".

I think I pointed it out previously, on the thread about using the isa
string in hwcap that you proposed, but it was things like hypervisors
that modify the DT that they pass to guests that I was talking about
here, rather than an end-user. Obviously this doesn't apply to things
that do not have hypervisor support, but if/when those do exist you'd be
relying on them not having the empty arch/impl ids.

> We're also turning on the t-head equivalent of svpbmt and zicbom with
> probably the same reasoning.

I'd argue that we should describe these things in whatever a non isa
string DT property ends up looking like, even if we missed the boat on
putting them in riscv,isa.

Maybe this is a self-serving interpretation, but I see the svpbmt and
zicbom equivalents somewhat differently. They're done under the hood,
ostensibly to make the thing spec compliant (it still claims to be
rv64gc). This one is "turn on a new, user-visible, feature", rather
than "we implement a standard thing, but it is broken, so silently fix
it up". I would probably feel differently about this aspect of things if
there was no intention to actually communicate the presence of the
extension to userspace.

> For T-Head we _know_ from vendor-id and friends that the core supports
> this special brand of vectors.

If we _know_ on Foobar SoC that it supports xyz extension based on
vendor_id etc, should we add detection for that that too, using those
as a basis? I really don't want to have a precedent for T-Head getting
to use this method (will the same logic apply to their bitmanip stuff?),
that is not going to be applied to other vendors.

Hopefully that better explains where I am coming from, lmk if I am
overlooking something that should be obvious.

Cheers,
Conor.


--r3osZw/jhAPvPKj5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJWFiwAKCRB4tDGHoIJi
0hWkAQDKMA8vp5aOMDByG6HvdeXGrVCOYG/SzdOGbN8mRpy+MwEA43fAmtj8A2mU
05gSaz2c5N8OcML/ICEuo7FNehS5dAo=
=L4ZW
-----END PGP SIGNATURE-----

--r3osZw/jhAPvPKj5--
