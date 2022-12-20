Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEC6529B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiLTXQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiLTXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:16:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016A0140CA;
        Tue, 20 Dec 2022 15:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917606160D;
        Tue, 20 Dec 2022 23:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89318C433D2;
        Tue, 20 Dec 2022 23:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671578204;
        bh=S2yB6QVUy+DI02cvsnJRJN1BJTKDb8OD04gO/nAdPSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ct+iSgbCvbMczqt/dL0+pl8OTJOs+cWhg5BpysQyODv73pwN/SkDHHzVFGA57BjTg
         HkZQrB50VWmKYdj3ZtJ/EPFLtwOefFPo1OKpMQS8tY0KCVk7dICC/T3ZCrbn/D7nCc
         t8zmB726IQITCrC6oiTd7EohXLCAbyvQC4/xIFXzr3C63wIUheWNzfGY7lsz7hFBjM
         yDzy7pO4ILfBuGzIC63uB+6MFCmeURuG2cpSVy1lFnrS1RsKgk9rKZCMvklPn5srz/
         esH6HS0F0q6NbSYFlQn0OY4weqwLlL9LoxF2k5eqTOMEkcKhxVAiVzrt6uFsgk6KeN
         1MnbOl+7hW0ow==
Date:   Tue, 20 Dec 2022 23:16:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/11] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Message-ID: <Y6JCVn2nsUi4nTeX@spud>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-8-hal.feng@starfivetech.com>
 <Y6JB37Pd5TZoGMy4@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KBoiHggTc0xQlLEN"
Content-Disposition: inline
In-Reply-To: <Y6JB37Pd5TZoGMy4@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KBoiHggTc0xQlLEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 20, 2022 at 11:14:44PM +0000, Conor Dooley wrote:
> On Tue, Dec 20, 2022 at 08:50:50AM +0800, Hal Feng wrote:
> > +    clock-controller@13020000 {
> > +        compatible =3D "starfive,jh7110-syscrg";
> > +        reg =3D <0x13020000 0x10000>;
> > +        clocks =3D <&osc>, <&gmac1_rmii_refin>,
> > +                 <&gmac1_rgmii_rxin>,
> > +                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> > +                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> > +                 <&tdm_ext>, <&mclk_ext>;
> > +        clock-names =3D "osc", "gmac1_rmii_refin",
> > +                      "gmac1_rgmii_rxin",
> > +                      "i2stx_bclk_ext", "i2stx_lrck_ext",
> > +                      "i2srx_bclk_ext", "i2srx_lrck_ext",
> > +                      "tdm_ext", "mclk_ext";
> > +        #clock-cells =3D <1>;
> > +        #reset-cells =3D <1>;
> > +    };
>=20
> Also, whatever happened to GMAC0? It has fixed-clocks defined in the DTS
> but doesn't appear in the binding or driver?

Ah, I should have looked at the next patch...

D'oh.


--KBoiHggTc0xQlLEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6JCVgAKCRB4tDGHoIJi
0td2AP9qG5gfg6Ob/N5kAJ8ZjKIE8zJu2TvxPdAOzRTiZWkKRgEA/l0KFau1Ph7E
XZQhhG9nYqDTXbh2i/793XGDS4PdcQg=
=A5iT
-----END PGP SIGNATURE-----

--KBoiHggTc0xQlLEN--
