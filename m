Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6385972EDA8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjFMVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239782AbjFMVJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:09:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E03A19B1;
        Tue, 13 Jun 2023 14:09:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9884C61864;
        Tue, 13 Jun 2023 21:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3A1C433C0;
        Tue, 13 Jun 2023 21:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686690542;
        bh=bqw+fnsWgRC1cIqLeL3ZKw/47X3oSoMsy9jRxd3Knq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cj5rIlkx/y4iVHQ7zIt7rbEzh5Hf0GNRIgAXi9rmE9njCXBEqdRxDbwCXgHWJjimy
         29V9GHM5QwOzENSN1zv2hbgF9kozHmUTY2YfpehJoI+MhAEWM43svmWMJL5MoIUzYN
         CShXm/I8ouQYNJE0++MNG++CCMPPwIkwfJDuiKt3C2oeIfIbUxMy8w8SKuD8qeEKt/
         BVAkPj3Pacnd3UHtLNQuxj/lP3Jz7eDcEhllmwdLU3FaOga84yAsph+hUcDkcDqy5C
         j2pEkSh54i4RV2hiPFg5eupWeTVvOeArPmIqtM8+TnaDKy+i/FDeHW0HMTOa38qhv1
         OIvq6a3tuKfQg==
Date:   Tue, 13 Jun 2023 22:08:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: crypto: fsl,sec-v4.0-mon: Add missing
 type for "linux,keycode"
Message-ID: <20230613-shucking-diving-c6b0cbd08279@spud>
References: <20230613201231.2826352-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWnv3eskVAkn/R37"
Content-Disposition: inline
In-Reply-To: <20230613201231.2826352-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pWnv3eskVAkn/R37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:12:29PM -0600, Rob Herring wrote:
> The "linux,keycode" property is missing a type probably because it was
> confused with the common property "linux,keycodes".
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--pWnv3eskVAkn/R37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIja6QAKCRB4tDGHoIJi
0gPkAP0ev1/+5SIbyQi9nHSb51Hf84udINV5P2MOeiO7kBOygQD/d6hcqnsBZ1X3
ersEc9MPuJjr+oz/46yTf90E4RmltgY=
=Zwtp
-----END PGP SIGNATURE-----

--pWnv3eskVAkn/R37--
