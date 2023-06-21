Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142A97390AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFUUWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFUUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770F199A;
        Wed, 21 Jun 2023 13:22:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 533996152D;
        Wed, 21 Jun 2023 20:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99A0C433C8;
        Wed, 21 Jun 2023 20:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687378963;
        bh=djs+xCtfLdvZ5xRRJQ0iKCl4Mvu1eYRMxlG5EP5Txtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8Md08Xxr8ljFhh0KNeV/z+de15Z/aY/WY8Dtvcivrj1PiBpKJJzMekq3ejhtWrN+
         j08S7V72Ii46jTHKgvLTcIxYQ5ktOH21SuRM7ohETkGIxCc6L61imYk6x28AYkzLNk
         lGO/u6KS3X3x7S9OuanFSW5W5lMTg84OyHAYTX5so7c3UgK69Si8KIE8wr9+qYQ9E3
         jSfisNxAxH4WaCmj1HtrV7Bc4f/uADPJRGYfnYD1ro0CK3SgqxqML7CvvRaCducEOo
         XJfZ6VZnCC1En+JzdqpKu/7rUFM6RJztzCHCv3B8WDTnq3MnadKFlSb4xwBebjyg5/
         VNpZdkTfO2yOQ==
Date:   Wed, 21 Jun 2023 21:22:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Furkan Kardame <f.kardame@manjaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, heiko@sntech.de, broonie@kernel.org,
        deller@gmx.de, dsterba@suse.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 1/2] dt-bindings: arm: rockchip: Add Firefly Station P2
Message-ID: <20230621-quake-waltz-99b921c46ee2@spud>
References: <66d5a117-abc7-e147-f416-5366706b5f26@linaro.org>
 <1687352320815.1257416493.3087155415@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xigKtBkKFoam8HdE"
Content-Disposition: inline
In-Reply-To: <1687352320815.1257416493.3087155415@manjaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xigKtBkKFoam8HdE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 01:00:05PM +0000, Furkan Kardame wrote:
> On Wednesday 21 June 2023 09:22:31 (+03:00), Krzysztof Kozlowski wrote:
>=20
> > On 20/06/2023 20:47, Furkan Kardame wrote:
> > > Station P2 is a single board computer by firefly based
> > > on rk3568 soc
> > > > > Signed-off-by: Furkan Kardame > > ---
> > > This is a friendly reminder during the review process.
> > > It looks like you received a tag and forgot to add it.
> > > If you do not know the process, here is a short explanation:
> > Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> > versions. However, there's no need to repost patches *only* to add the
> > tags. The upstream maintainer will do that for acks received on the
> > version they apply.

> Noted, will take care of this in the future.

Since it was missed,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--xigKtBkKFoam8HdE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNcDgAKCRB4tDGHoIJi
0nMSAP91rpdpBiG89agHMyu2P6bMkggqrS8XGDbaXIeQSMH5pQD/QuY9jHSPdSHJ
S2KugIZYvQyPzvKwPMHLlXpfR4co+Aw=
=WZlF
-----END PGP SIGNATURE-----

--xigKtBkKFoam8HdE--
