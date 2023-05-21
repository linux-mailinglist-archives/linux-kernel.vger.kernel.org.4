Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A170AF47
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 19:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjEURN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjEURKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 13:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D159FE74;
        Sun, 21 May 2023 10:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6649960FE3;
        Sun, 21 May 2023 17:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1780AC433D2;
        Sun, 21 May 2023 17:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684688917;
        bh=EA/dMN8uSmBLu0XJzQQrrnI0PyUW/NRfOEu9PpWl6rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P5Be11gQhXTmIpiBfldqTfPjPIpLCHql53dVblRRB+MMAJDOYixcoh3wUOO2c/kto
         6Li2ifUIM10h7J9+0HbhfcE12usA1k5mamV27sG9eQbERsm5upJe9EYH+3qH2oUpvG
         tBlTeoWnOyByQY79USYdL5tZuJrYPqi5QC/HqKTy3P6DbnPd+U9FPSEY27foEyiPGB
         +US7bShnmG+9AmF+fS8sZvT3i+6o45VH0Zi/05lz8OkrHK+IVIZ2pJXqjV+hkysmoM
         pWTa9yx6SYBE0Or3PYDXAYqVK5oiGvZslnkMm39RsGYi4qafAWe9DKjS3uMOHDzBWU
         /t+uJOGSfCojg==
Date:   Sun, 21 May 2023 18:08:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, heiko@sntech.de
Subject: Re: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Message-ID: <20230521-licorice-follicle-2f83e82f8bce@spud>
References: <20230507182304.2934-1-jszhang@kernel.org>
 <20230507182304.2934-4-jszhang@kernel.org>
 <20230507-calamari-gentleman-bbe62af06f92@spud>
 <ZFkiotPacIMUghDP@xhacker>
 <20230508-unmoved-unvocal-9a6c5fc0c629@spud>
 <CAJF2gTSFm32ozEDy_3zvrf05USJ8FxCsaGK-2FbkJQsPUDQXmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8G3irSIrB1WawZQb"
Content-Disposition: inline
In-Reply-To: <CAJF2gTSFm32ozEDy_3zvrf05USJ8FxCsaGK-2FbkJQsPUDQXmA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8G3irSIrB1WawZQb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2023 at 11:37:58PM +0800, Guo Ren wrote:
> On Tue, May 9, 2023 at 12:44=E2=80=AFAM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Tue, May 09, 2023 at 12:26:10AM +0800, Jisheng Zhang wrote:
> > > On Sun, May 07, 2023 at 10:35:12PM +0100, Conor Dooley wrote:
> > > > On Mon, May 08, 2023 at 02:23:02AM +0800, Jisheng Zhang wrote:
> > > >
> > > > > +         c910_0: cpu@0 {
> > > > > +                 compatible =3D "thead,c910", "riscv";
> > > > > +                 device_type =3D "cpu";
> > > > > +                 riscv,isa =3D "rv64imafdc";
> > > >
> > > > Does this support more than "rv64imafdc"?
> > > > I assume there's some _xtheadfoo extensions that it does support,
> > > > although I am not sure how we are proceeding with those - Heiko mig=
ht
> > > > have a more nuanced take.
> > > >
> > > > > +         reset: reset-sample {
> > > > > +                 compatible =3D "thead,reset-sample";
> > > >
> > > > What is a "reset-sample"?
> > >
> > > This node is only for opensbi. The compatible string is already in
> > > opensbi. Do we also need to add dt-binding for it in linux?
> >
> > If it's to be included in the kernel's dts, then yes, you do need a
> > dt-binding. If you remove it, then you don't :)
> >
> > That said, "thead,reset-sample" is a strangely named compatible, so if
> > you do keep it it may end up needing a rename!

> How about compatible =3D "thead,reset-th1520" ?

"vendor,soc-function" is more typical, but "reset" is usually used for
reset controllers of which this isn't as far as I can tell.
I commented on the v2, hoping that you might actually know what the IP
block' full/proper name is:
https://lore.kernel.org/all/20230518-driving-secluding-793b3192776e@spud/

Do you?

Cheers,
Conor.

--8G3irSIrB1WawZQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGpQEAAKCRB4tDGHoIJi
0kCCAP9n2k/2fmZwxGGppz0pZC0qiT6h8lZ8vMVzSsmZd2NsAQD+J2Tr7Hxg2Bgt
tnCER3gtzOoAHhHn+MwFUX4Oy4EtugU=
=DDuI
-----END PGP SIGNATURE-----

--8G3irSIrB1WawZQb--
