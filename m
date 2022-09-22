Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA05E6DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 23:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiIVVOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 17:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIVVOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 17:14:09 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC38ADDDBA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=EC05pt9zmG4/8UJJui2h2xqvEJmD
        uZx3ATVSlZERjTY=; b=BbsKkzr1Pf86q809dZtf+5ICSexBfcF18KBiSw15Xlkm
        CGIG7BA5eaNErPygsCwozA95kT8KkeVUGKvqxkw29ifH4a+uBf/NP/b/extI8kpv
        /pJUy9MJBcPMqLtAPPEu7Lhi0GUhWpAZPTGJTOAV1rfUJZTavgiM4hvTn73fzAw=
Received: (qmail 1784186 invoked from network); 22 Sep 2022 23:14:02 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2022 23:14:02 +0200
X-UD-Smtp-Session: l3s3148p1@Ez8yikrp5uUgAwDtxwncAPgJb5TsabMI
Date:   Thu, 22 Sep 2022 23:13:58 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: renesas,tmu: Add r8a779f0 support
Message-ID: <YyzQFheOv2Lg0t6F@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220830104921.7532-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2h2rjwr6S8Iuje0Q"
Content-Disposition: inline
In-Reply-To: <20220830104921.7532-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2h2rjwr6S8Iuje0Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 30, 2022 at 12:49:21PM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Can we have this simple patch in 6.1 please? Otherwise DT build warnings
will show up. Or is there something I could help with?

>=20
> Change since v1: added tags
>=20
>  Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/D=
ocumentation/devicetree/bindings/timer/renesas,tmu.yaml
> index c57169118b68..60f4c059bcff 100644
> --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> @@ -37,6 +37,7 @@ properties:
>            - renesas,tmu-r8a77990 # R-Car E3
>            - renesas,tmu-r8a77995 # R-Car D3
>            - renesas,tmu-r8a779a0 # R-Car V3U
> +          - renesas,tmu-r8a779f0 # R-Car S4-8
>        - const: renesas,tmu
> =20
>    reg:
> --=20
> 2.35.1
>=20

--2h2rjwr6S8Iuje0Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmMs0BEACgkQFA3kzBSg
KbYhHxAApKB5ESn8IEeajJ3288k7/7FZayqH6oOk4dPuUytQajJs6TKugSR4agWA
fUTJ46GB6JxK1i/hkgdnzgpPw/ImWDcJ4MiH+t2Z+TOVMI0MY/7AlIWZtC8i1oel
oIOqNRMK1+KdTGPwUw5bnxFXpfJpBg9L/VmPdHflTktyn3f8OcRfQNKH5IOL2bUz
FxglC4+suePuR7dB5vmH2Oj9qZn+dGJVYq6YbdASl9LjsUgjFy4cYmJp0E6RFxg6
KUBEeFASLk3YkM/BEbxbcYpI3BpICYbocQkrFVCLtVRfCGyldmlKWOS7sCLKviKj
YJL1Tce4KIJv4nhszI4HqcypSiECoVeanUD9CJKw7I0WpgaIwg53KghuaCjD+d9w
BT5KeZtBtjr85oGjVSadmAybvQy3C57lPzpag9Mhb8EAqL/uqTliLxc72pZ2l5M5
Xy38EezZ1NGedeUHgWDRnfYvYytv8jFkl2ldAlyw/Kgh6a9bjv5uecLwrq+bcjO4
xoT2+kTGPup1wPTRUn2RGhIo4Zwh3omcGAOGkQj9BThT4Kmt2tfyBYEd6e5JeDnV
9amW7rCo0FeIUXl629SJNPJZbQSmPaoJIqPlgntH5iG0X0S8JkXWLtcsa7tAXb28
wdSE2GSzfSicXk/povUfq3ESAF5u4LLKpYpGEBF7od8R0TStRUs=
=n+45
-----END PGP SIGNATURE-----

--2h2rjwr6S8Iuje0Q--
