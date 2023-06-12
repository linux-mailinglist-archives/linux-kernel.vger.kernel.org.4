Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9651072D341
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbjFLV0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjFLVZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:25:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088551985;
        Mon, 12 Jun 2023 14:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F9256209A;
        Mon, 12 Jun 2023 21:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFFEC433EF;
        Mon, 12 Jun 2023 21:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605037;
        bh=Le3gA2ClE6ECL6WF9fV8Q54wWv/RXKwEzvYFXFKgqDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzaWBe097VzKJvl0oBZkVur7A0DKcS4yn5zcvAcJUhnuXNZhfYLv/fpjG1HqJ246k
         o9uvOq5NK6Ex58+pRdpTgDveEEWcqjdmHkPe6soCi+7qyCcs+cx+2z1njQCFAHPRoU
         uffrFY/Oljmq0iF23XmmYHHfJ9J8Nty98dYeJ9625mRzqe3s5pz0DsaoNt3q/Y4T5G
         L1LiDsOYM5vsrmS/jqTEF8Us+X4Xh4w4kkmMTxu5JiMiDLlkNCngJ/+MceOMvDfZVU
         wW9cEVA6nRM2bb8GDSGcdWu10UuDOcdpScFsrgAfLatrZd9q4tLV8mt/oYAR+R7WtJ
         SXMsqLe0lhR2A==
Date:   Mon, 12 Jun 2023 22:23:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230612-relic-fetal-1beeae3455aa@spud>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud>
 <20230530-duller-reset-a34ae111f207@wendy>
 <20230608191537.GA3233857-robh@kernel.org>
 <20230608-cobbler-giving-e0fac2185e11@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnjcFuwrw0FxHlVc"
Content-Disposition: inline
In-Reply-To: <20230608-cobbler-giving-e0fac2185e11@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnjcFuwrw0FxHlVc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rob,
Before I press on with more versions...

On Thu, Jun 08, 2023 at 08:30:28PM +0100, Conor Dooley wrote:
> On Thu, Jun 08, 2023 at 01:15:37PM -0600, Rob Herring wrote:
> > On Tue, May 30, 2023 at 03:12:12PM +0100, Conor Dooley wrote:
> > > On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> > > > On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:
> > >=20
> > > > >=20
> > > > > Why not just have something like
> > > > >=20
> > > > > mycpu {
> > > > > 	...
> > > > > 	riscv,isa {
> > > > > 		i;
> > > > > 		m;
> > > > > 		a;
> > > > > 		zicsr;
> > > > > 		...
> >=20
> > I prefer property names be globally unique. The tools are geared toward=
s=20
> > that too. That's largely a symptom of having 0 type information in the=
=20
> > DT.
> >=20
> > For example if you had an extension called 'reg', it would be a problem.
>=20
> Per the current ISA rules, that'd not be valid. But then again, I do
> have trust issues & it's not like "reg" is the only property name in DT
> land.

=2E..you say "prefer" here. Is that a NAK, or a "you keep the pieces"?

--RnjcFuwrw0FxHlVc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIeM5gAKCRB4tDGHoIJi
0uzcAQDu/tJVEgDQEG2BFIFoTPaZznrjs1Il4oaLCWo/dTGTigEAtYV2jXPQafdF
DrSPBnySqez+fzXzA9+5KTRu5WWsKg8=
=Olcx
-----END PGP SIGNATURE-----

--RnjcFuwrw0FxHlVc--
