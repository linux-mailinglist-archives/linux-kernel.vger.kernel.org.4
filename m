Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F215F3BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 05:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiJDD3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 23:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJDD3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 23:29:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE1830567;
        Mon,  3 Oct 2022 20:29:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MhNTz4JWvz4x1D;
        Tue,  4 Oct 2022 14:29:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1664854151;
        bh=9KO1MZF4XBWtjiHb7L8GFZTtgLpsZKcu6qvUWUOcKY4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ARqTKrQNjskmr3mXGqvQ17gjwq0jXh4Q2JDrZVZ9s8SePl8jItj0bwn0QL7/sr9+1
         DS0nfsy7MjUw0PRHFzUECaoxRrWdp5rIHhIvHvTdhWQ/B6pA2z2Z4xIdAKbKHl16cL
         S7TqS8Jc3m/UrTTC5cPJj/VvY0cIklnpeHCJdU9znyO/N0QS3oqwAqHpoJFy4pG8DT
         nf8qTcqpTjD0+qR+kwmAaPMVWLV+QWFQH359Z9CSg78z/DtQlqWKFVkF7zHjdo4IjY
         x+EIAS8J+8azneTHeuquIy/qa04sba9sFUB3z9+4wXRqF0GwJiEAifSW67q5kub0M2
         U5EIgP+69ze9A==
Date:   Tue, 4 Oct 2022 14:29:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     broonie@kernel.org, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mfd tree with the qcom tree
Message-ID: <20221004142909.52b6c288@canb.auug.org.au>
In-Reply-To: <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
References: <20220930115816.128513-1-broonie@kernel.org>
        <1e9a21a3-d6c3-3f76-18dc-ff14e8609846@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wq5GflbkYZdcDVCo0NkNgr/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wq5GflbkYZdcDVCo0NkNgr/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 30 Sep 2022 14:06:28 +0200 Krzysztof Kozlowski <krzysztof.kozlowski=
@linaro.org> wrote:
>
> On 30/09/2022 13:58, broonie@kernel.org wrote:
> >=20
> > Today's linux-next merge of the mfd tree got a conflict in:
> >=20
> >   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
>=20
> Thanks Mark.
>=20
> > between commit:
> >=20
> >   4f2e28b2cc2e0 ("dt-bindings: mfd: qcom,tcsr: add several devices") =20
>=20
> It seems this commit was picked by both Bjorn/qcom and Lee/MFD.
>=20
> > from the qcom tree and commits:
> >=20
> >   f8c1940165bea ("dt-bindings: mfd: qcom,tcsr: Add several devices")
> >   a328ae8504dbc ("dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ=
6018") =20
>=20
> This commit depends on the duplicated one (on "Add several devices"), so
> I think all set can stay in MFD and instead Bjorn could drop his copy of
> the commit.
>=20
> If not, please propagate the merge conflict resolution, but not the one
> from Mark.
>=20
> Instead result should look like a328ae8504dbc (from MFD tree).

OK, in linux-next, the resolution is now to take the mfd tree version.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wq5GflbkYZdcDVCo0NkNgr/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmM7qIUACgkQAVBC80lX
0Gza5QgAhv/QIgSs/Zp9nKVsOjcwa4mWdAAEueeJhOUFkEKUupwJyDxkqeH1s28u
x69B9xaO06gcHZnpYRZmrlKqId6fJhtjG2W2Vk7zsjSQn4Hqedl6eXcX4yStv/fY
4AC53he3xPnPPQ3Sw53BWaI958GQOMn8Ey1FiBb8MFS93YbUJLOOWmRE6iZNmXzU
z4GnvI94rgjPn4kTA7F5tzMEjOUFG+/GKh9VcbZwkHu7VN1wSctq7sKl6nkzhFFP
7vuJEaDz4q0z+fPSuSI6eupSpoTlz9Q1FCwp9YNJ31/32MjaGCMjJYVRTIAJP1Ww
MXYP/F19MHfWaIULWADVBUEjlvx9hg==
=4bnP
-----END PGP SIGNATURE-----

--Sig_/Wq5GflbkYZdcDVCo0NkNgr/--
