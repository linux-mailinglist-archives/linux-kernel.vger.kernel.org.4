Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED5E7321E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjFOVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjFOVqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA5E2965;
        Thu, 15 Jun 2023 14:46:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBFE2611CE;
        Thu, 15 Jun 2023 21:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B6FC433C0;
        Thu, 15 Jun 2023 21:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686865600;
        bh=xXSkfXFERZnKNqske+k/AdvxTmRqwqQpRSs6xsjXVDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrzMOuZ3gpUbncz8nzTNvdKmysp1NRykfCJezNwkgVYRHPeDM34hkjkB3BIobNuje
         kkdyA80V808TLi9m04t7RBrPRJOIFav+8Z075KJTTKhB/xq2VNdOcOC0sfy9FCKqc4
         aCLrDxPw5q6lCE2KwRs87aK3MJZ3JGLfx5XRORGcZuIVY/8059tMPB1MKbFLmWWCGW
         R+f6OTwP+52gvGp6TM18H4d+6hb3w2ULfF7WGs3SHn4zyJFROW94xjHPdqbPNuh3m4
         KF67gSfPay2cONip0Rl09ATrOiDOOcHSFw8zHeimmIlmiBj9sS4Cg9PJTmPHlGgCDZ
         gIeauNLFd3eNw==
Date:   Thu, 15 Jun 2023 22:46:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] dt-bindings: riscv: cpus: switch to
 unevaluatedProperties: false
Message-ID: <20230615-dash-synopsis-da1c582baf06@spud>
References: <20230610-snaking-version-81ae5abb7573@spud>
 <20230615174734.GA1240678-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fG7s579iV3JYZUpt"
Content-Disposition: inline
In-Reply-To: <20230615174734.GA1240678-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fG7s579iV3JYZUpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 11:47:34AM -0600, Rob Herring wrote:
> On Sat, Jun 10, 2023 at 06:24:47PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Do the various bits needed to drop the additionalProperties: true that
> > we currently have in riscv/cpu.yaml, to permit actually enforcing what
> > people put in cpus nodes.
>=20
> Arm needs pretty much all the same properties. I started on adding them=
=20
> to cpu.yaml a while back. Let me finish that up.

Cool, I see you've already updated dt-schema. I'll go update mine & cull
whatever is no longer needed here.

> > CC: Rob Herring <robh+dt@kernel.org>
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > CC: Paul Walmsley <paul.walmsley@sifive.com>
> > CC: Palmer Dabbelt <palmer@dabbelt.com>
> > CC: linux-riscv@lists.infradead.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> >=20
> > Conor Dooley (6):
> >   dt-bindings: riscv: cpus: add a ref the common cpu schema
> >   dt-bindings: riscv: cpus: allow clocks property
>=20
> I just have 'clocks: true', so if you want to keep this setting it to 1=
=20
> clock that's fine. But I imagine that it's just a matter of time until=20
> someone wants more clocks.

Yeah, I said something to that affect in the commit message. I don't
doubt that it'll show up at some point, was just enabling the minimum
that I know of SoCs requiring at the moment. "clocks: true" WFM.

Cheers,
Conor.

> >   dt-bindings: riscv: cpus: add a ref to thermal-cooling-cells
> >   dt-bindings: riscv: cpus: permit operating-points-v2
> >   dt-bindings: riscv: cpus: document cpu-supply
> >   dt-bindings: riscv: cpus: switch to unevaluatedProperties: false
> >=20
> >  .../devicetree/bindings/riscv/cpus.yaml         | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > --=20
> > 2.39.2
> >=20

--fG7s579iV3JYZUpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIuGuwAKCRB4tDGHoIJi
0tc9APwI3Clev2UmhlaKWdIH8qLbQuqSTzJdMHlBPWOydvIw6wEAn9cwAuuB64n8
2qZ2LtMA3NLR2NDSZBq+etrXjcoyMQs=
=9Bxm
-----END PGP SIGNATURE-----

--fG7s579iV3JYZUpt--
