Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E64716134
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjE3NMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjE3NMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:12:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D0F0;
        Tue, 30 May 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685452354; x=1716988354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rgP8/DkgE67Jn/btWtUmo2sPLJIt6my6BaVAXky+q5g=;
  b=JHD/9STnT4BRmtc9/w7Fvt0D+wh732N0y8MiQtcKzAYWAZO0HlVkJSqq
   cbGn1BmFy7aOvW5k+VurbtbmgJ/sz7dJahEAVE0R8ZIxxO4GYzz/h8jWc
   Ei14c0Rk7xiEgXzbKz3PazgY88qiPazAHa6Zz6hCXAU5WCSeE6SjHTR0Y
   +GU1+gpE9sPu8tmp2MfThAv/yKbci0ohXoKP+5WXa+P9D5izjD+3IjeEO
   FUiBxk5xFkqsQn7e/ZMTdOVng6BoLN7CAEDwnkzcTCL3KjKlk+EqnbSOP
   umxlGTVNYxKmV+QW3sghNw1ISrlnMzfZcUINfMPjL+WGGDtaB7eBQ42ET
   w==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="asc'?scan'208";a="213720607"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 06:12:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 06:12:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 06:12:30 -0700
Date:   Tue, 30 May 2023 14:12:07 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     <soc@kernel.org>, <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <olof@lixom.net>,
        <palmer@dabbelt.com>, <robh+dt@kernel.org>, <arnd@arndb.de>
Subject: Re: [PATCH v2] Documentation/process: add soc maintainer handbook
Message-ID: <20230530-enviable-poise-183119e695bf@wendy>
References: <20230530-multiple-whooping-ee5706fceb67@wendy>
 <87bki23rbx.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vd/KN9AFeCUUrCcz"
Content-Disposition: inline
In-Reply-To: <87bki23rbx.fsf@meer.lwn.net>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Vd/KN9AFeCUUrCcz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 07:02:26AM -0600, Jonathan Corbet wrote:
> Conor Dooley <conor.dooley@microchip.com> writes:

> > diff --git a/Documentation/devicetree/bindings/ABI.rst b/Documentation/=
devicetree/bindings/ABI.rst
> > index a885713cf184..93ec82f78ae5 100644
> > --- a/Documentation/devicetree/bindings/ABI.rst
> > +++ b/Documentation/devicetree/bindings/ABI.rst
> > @@ -1,5 +1,7 @@
> >  .. SPDX-License-Identifier: GPL-2.0
> > =20
> > +.. _devicetree-abi:
>=20
> Somehow we've developed this habit of putting labels at the top of each
> file; I really think that they just add clutter and are best left out.
> Without the label, this reference:
>=20
> > +Perhaps one of the most important things to highlight is that dt-bindi=
ngs
> > +document the ABI between the devicetree and the kernel. Please see
> > +:ref:`devicetree-abi` more information on the ABI.
>=20
> ...can just be written as "Please see
> Documentation/devicetree/bindings/ABI.rst".  The cross-reference link
> will be generated as expected, and readers of the plain-text docs don't
> have to go grepping to find the reference.

Sure. As someone who does read these things in their editor that sounds
preferable to me. I didn't know that I could do that, as the whole
"building the docs" thing is new to me ;)
I'll wait a bit before resubmitting for obvious reasons.

Cheers,
Conor.

--Vd/KN9AFeCUUrCcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHX2JwAKCRB4tDGHoIJi
0jE3AP9pDjLP9d6RnL00Efrio6ZoaKZjOG0zDOEg+4VAprMwmwEAjpD8+2LaBcMN
FnbPRUS5wn47utSB1NzZVqP8Ep4rLAE=
=VH3D
-----END PGP SIGNATURE-----

--Vd/KN9AFeCUUrCcz--
