Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6906704853
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjEPI6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjEPI55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:57:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C630C4;
        Tue, 16 May 2023 01:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684227474; x=1715763474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CSTRf/cqcWQ463WIW8qgz8myBeaHEA91KTcTMocyp20=;
  b=ZfpR8hQBS5Lb+wdRXDL6s6I7blIAdEN9BUpEGEBkZp8gTINnQBl4CGcm
   UgLPxIOUKqytbn7gAvnk9dsUdsDGE7HEbKekLhAnLUsWXy79gYx1mCvLM
   6BtFvfOWIWmBc8pkjeHV58r/yYvrUpO+TPm3+u2MKxn6WD71HJrWg1h1k
   aHfXN3UYTWz6oYdKrm3jerQ+OvQdAjdo+qI3/ofF1IkmH1tAjn1Q4/3Dh
   H+9SQsernM48G7CJf4589U2NpXKSy29iIOZnZRJQeatU0vQXcpw8h1ynZ
   datBeZtz8biJ7/KPaLazKvjSlo1U9TSR5NNp8OjrgOwuXo6g7OvWe6PH/
   A==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677567600"; 
   d="asc'?scan'208";a="152279664"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2023 01:57:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 16 May 2023 01:57:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 16 May 2023 01:57:50 -0700
Date:   Tue, 16 May 2023 09:57:29 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Conor Dooley <conor@kernel.org>, <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v1] Documentation/process: add soc maintainer handbook
Message-ID: <20230516-grader-dejected-df65cdc584b3@wendy>
References: <20230515-geometry-olympics-b0556ff8a5f7@spud>
 <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4AsXPhTNlfzE8BRW"
Content-Disposition: inline
In-Reply-To: <cf1c6b8c-8a3f-eca1-948f-e41946d4c34c@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--4AsXPhTNlfzE8BRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 10:31:19AM +0200, Krzysztof Kozlowski wrote:
> On 15/05/2023 21:20, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Arnd suggested that adding maintainer handbook for the SoC "subsystem"
> > would be helpful in trying to bring on board maintainers for the various
> > new platforms cropping up in RISC-V land.
> >=20
> > Add a document briefly describing the role of the SoC subsystem and some
> > basic advice for (new) platform maintainers.
> >=20
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

> > +devicetree ABI stability
> > +~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Perhaps one of the most important things to highlight is that dt-bindi=
ngs
> > +document the ABI between the devicetree and the kernel.  Once dt-bindi=
ngs have
> > +been merged (and appear in a release of the kernel) they are set in st=
one, and
> > +any changes made must be compatible with existing devicetrees.  This m=
eans that,
> > +when changing properties, a "new" kernel must still be able to handle =
an old
> > +devicetree.  For many systems the devicetree is provided by firmware, =
and
> > +upgrading to a newer kernel cannot cause regressions.  Ideally, the in=
verse is
> > +also true, and a new devicetree will also be compatible with an old ke=
rnel,
> > +although this is often not possible.
>=20
> I would prefer to skip it and instead: enhance
> Documentation/devicetree/bindings/ABI.rst and then reference it here.

Sure.

> > +Driver branch dependencies
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +A common problem is synchronizing changes between device drivers and d=
evicetree
> > +files, even if a change is compatible in both directions, this may req=
uire
> > +coordinating how the changes get merged through different maintainer t=
rees.
> > +
> > +Usually the branch that includes a driver change will also include the
> > +corresponding change to the devicetree binding description, to ensure =
they are
> > +in fact compatible.  This means that the devicetree branch can end up =
causing
> > +warnings in the "make dtbs_check" step.  If a devicetree change depend=
s on
> > +missing additions to a header file in include/dt-bindings/, it will fa=
il the
> > +"make dtbs" step and not get merged.
> > +
> > +There are multiple ways to deal with this:
> > +
> > + - Avoid defining custom macros in include/dt-bindings/ for hardware c=
onstants
> > +   that can be derived from a datasheet -- binding macros in header fi=
le should
> > +   only be used as a last resort if there is no natural way to define =
a binding
> > +
> > + - Use literal values in the devicetree file in place of macros even w=
hen a
> > +   header is required, and change them to the named representation in a
> > +   following release
>=20
> I actually prefer such solution:
>=20
>  - Duplicate defines in the devicetree file hidden by #ifndef section
> and remove them later in a following release
>=20
> We can keep both, but mine above leads to cleaner changes in DTS file.

I think all of the options involved are either a bit ugly, or a bit of a
pain in the hole.

> > + - Defer the devicetree changes to a release after the binding and dri=
ver have
> > +   already been merged
> > +
> > + - Change the bindings in a shared immutable branch that is used as th=
e base for
> > +   both the driver change and the devicetree changes
>=20
> The policy told to me some time ago was that no merges from driver
> branch or tree are allowed towards DTS branch, even if they come only
> with binding header change. There are exceptions for this, e.g. [1], but
> that would mean we need to express here rules for cross-tree merges.

I've got away with having an immutable branch for dt-binding headers!
That said, Arnd did actually have a look at this (and suggested some
changes) before I sent it & did not cry fowl about this section. IIRC,
this is actually his wording, not mine.

> > +Branches and Pull Requests
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~

> > +The subject line of a pull request should begin with "[GIT PULL]" and =
made using
> > +a tag, rather than a branch.  This tag should contain a short descript=
ion
>=20
> a signed tag

I initially had that explicit wording, but I dropped it when I added the
ref to the pull requests doc since that talks about signing. It's
probably better to be explicit & re-adding it is trivial.

Thanks,
Conor.

--4AsXPhTNlfzE8BRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGNFeQAKCRB4tDGHoIJi
0pVzAQDd5V7DgF90rg528xBUxStaRxmF6i407yxUeQeYhn6oLAEA3Y5P0rASKrya
rg86ohacmT7OJLEcXa37wLmEIY0TnAI=
=GTpg
-----END PGP SIGNATURE-----

--4AsXPhTNlfzE8BRW--
