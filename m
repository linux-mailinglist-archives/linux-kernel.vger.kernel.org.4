Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8F6E6E84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjDRVpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjDRVpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:45:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1904B49FD;
        Tue, 18 Apr 2023 14:44:58 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6BE9D6603217;
        Tue, 18 Apr 2023 22:44:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681854297;
        bh=sdgXZWB61ikcdoR6k+DOEhzGhE10wgrKBIzUUFMlXMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIQAGMUCzN7JKN6FIKofs07efe157XyVCT0+2FpttWZsPrC789sJpi5y/Ghr3/Raw
         8Yl7znactE6Epm4o0O7eXb2emquphikOgt1FR/d2evggCQmNXvfCtWzRtRnm7/tiEB
         pUrS1yPfIrZVDzJGEzdH2fwqX2i1Q40Z7ek/+vSCzK8dueHfpw97/4yP1BnSOm2OPD
         5a4IsV8GypyuTPi3R/f4EgAsAxBh8/p9+uN5EVhOgM+NZiqwzBCxFdvGJvd1F/ZT8Z
         uFAPRLNgDIq54KLvBKFF2FFnYnhAG/Ql1TDRUdNlLGInyvDvLhFPznWQEwWBPP+lIE
         rP/rYgDesrySQ==
Received: by mercury (Postfix, from userid 1000)
        id D9F201066F5D; Tue, 18 Apr 2023 23:44:54 +0200 (CEST)
Date:   Tue, 18 Apr 2023 23:44:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 3/5] dt-bindings: phy: rockchip: rk3588 has two reset
 lines
Message-ID: <20230418214454.m24t2s3lnsukwppn@mercury.elektranox.org>
References: <20230413182345.92557-1-sebastian.reichel@collabora.com>
 <20230413182345.92557-4-sebastian.reichel@collabora.com>
 <20230418204136.GA2299798-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s6ptsftpn4p7qth6"
Content-Disposition: inline
In-Reply-To: <20230418204136.GA2299798-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s6ptsftpn4p7qth6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Tue, Apr 18, 2023 at 03:41:36PM -0500, Rob Herring wrote:
> On Thu, Apr 13, 2023 at 08:23:43PM +0200, Sebastian Reichel wrote:
> > The RK3588 has two reset lines for the combphy. One for the
> > APB interface and one for the actual PHY.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/phy/phy-rockchip-naneng-combphy.yaml          | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-=
combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-co=
mbphy.yaml
> > index 9ae514fa7533..bac1aae07555 100644
> > --- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy=
=2Eyaml
> > +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy=
=2Eyaml
> > @@ -31,8 +31,13 @@ properties:
> >        - const: pipe
> > =20
> >    resets:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reset-names:
> >      items:
> > -      - description: exclusive PHY reset line
> > +      - const: phy
> > +      - const: apb
>=20
> This will fail on any existing users with single entry. You need to add=
=20
> 'minItems: 1' here.
>=20
> It also fails if they didn't use 'phy' as the name, but names should be=
=20
> defined.

My understanding is, there there currently are users with one entry
and no reset-names. I suppose its sensible not to provide a
reset-name, iff there is only one line. As far as I can tell that
should still work after my changes.

-- Sebastian

--s6ptsftpn4p7qth6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQ/D00ACgkQ2O7X88g7
+pq29w//Q5Slb98DCTi7eVp+a3iZCQ7kw1XvBK/cvgJLcPFl2ZT79eUY7JQon9pq
DJs/ln/d65z4AmEX4MNqJU7k3lnv6cX2P2CtjR9oS32WPgxxkmT/kyY/d9yz/Ext
kD5/QnZ30czThOPar6MWXMHhpXPnzFLBNjHexWU3mU0Qztdf3l8F5dwEhaG3hhnP
yyuoolfYUHZRoOqCKF83Y/jCUOlpdLt1OB781DuxzVXqFO3r1dvbHTa2gH6vyr38
clLOSRJ941nMNGxsT5h1QuEd91btcjcuAyPXLAiWfC8ofx9gx2GEApSBIMwlesKm
/B2OYA2H2u/nKF/+uOld39p2Kf7fvSxZr+WDlc2rUqhMnBhTAMa+loOVfi0ENNOp
DK+ya0xnJWalRn6v2qYz4vj8yu7nj20njNVgfotw2X2cPfufHOF4HWB19qNmpZmA
H78RJJrmvZHBdrqwkyufscTaUsJKUjlNk1X1MflBFrl3LzuaIzO2AJ3sbC4q6pXV
FeOp2ozw9ovlgj0RMUKEb/K62jGwM4RaufZAlzps3FRX35mJ1QhHH4Ro+bd+eja+
kBAI6Ra69Tz+vn/FAN5zc39IKBZUtJ0tM9uZgwLbHZD/IAx0SicHYtKNYhLD2Cm0
yc4EQhaCRQKo8k4BgCvxfShpyxJyHBrDQVA5IfWHz31ZP7vg2lM=
=vQoE
-----END PGP SIGNATURE-----

--s6ptsftpn4p7qth6--
