Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B015FB08B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 12:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJKKgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKKgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 06:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E35F7C0;
        Tue, 11 Oct 2022 03:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F97061170;
        Tue, 11 Oct 2022 10:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D46C433C1;
        Tue, 11 Oct 2022 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665484577;
        bh=AcvorbeO7IeezbFs7GQqmszANLwT9CFP0PPWa4yQhSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XScz9NDzzIDweBEQWQD6uEatQsLYoKNf0V2UUAz2Ok8Vh+bpNmD5bHaErD5CDQJ0z
         +A8MwfoSbbgfkfVagPurQwVWzBaBDkBr1Po5IklakKfXI7qc2a3O4dRXyfWvke+eZz
         vu+HXDH+Mltm90I8gKbr6jDua8NFm3FQxU5FKz9mgA1+CC3Jy/591280vpYuUb3aee
         l3DAZh3esPC9S+P+5u+hZOnHi1Jf8mGdnImnKZFGH+1K/VCZDwsum4QOIOKICYbp+a
         ChGvxntxgOXD0nEEABwPgkmunMwXZx70XwQYwJDjfvsxqnveR6VRg5XFUfcWRGfbzq
         EK8gnpHkbj2zw==
Date:   Tue, 11 Oct 2022 11:36:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     krzysztof.kozlowski@linaro.org, chen.zhong@mediatek.com,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        fparent@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: regulator: Add binding schema for
 mt6357 regulators
Message-ID: <Y0VHGh/GavvuZY2A@sirena.org.uk>
References: <cdb4e9f7-c7b3-3a1f-bf61-e42bdb021570@linaro.org>
 <972ba839-2fd3-2b45-3477-0c7e3d32f149@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qy+sdSDVmD8xz5a1"
Content-Disposition: inline
In-Reply-To: <972ba839-2fd3-2b45-3477-0c7e3d32f149@baylibre.com>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qy+sdSDVmD8xz5a1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2022 at 11:30:58AM +0200, Alexandre Mergnat wrote:

> > Why enforcing particular name of the regulator?

> The regulator names are forced to match with the datasheet names.

> I think it's a good practice to increase visibility between HW & SW.

> Also, that keep consistency with other Mediatek PMIC schema.

No, this is bad practice which completely misses the point of what the
names are for and the other Mediatek drivers are broken.

--Qy+sdSDVmD8xz5a1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNFRxkACgkQJNaLcl1U
h9DNVAf+IAfeWJtE4IzcYAbU8KiaUeVALAXjWr2ios39H9Rp6rmG3HbUm0Hn4YQ7
z6mOZsA/dxM0GBcC+0E4GaJBb9nPdNcsm5he5cnG53JCzLZEli8b5hd+d4vrhtai
PSNcNlwd5gr4bBnISeOXqsmHy1VvwkGpJuo84sA4Rre//0tocfPmJX8i+tINms4k
MfSgehyBSxsGwFFwxo8sxFrR/mP1zsTe+XQKZ/pPaQHI/2/OfxSuUzn8qtCI3g1X
ySN2o41nmq+Jg7CWmAXQnQuTa5b3CBGW0bCRb6x728A/+VSHaNKp4fU4VcfalpeW
LDQ7MYIWTvgZK3ffGffopei5AOipng==
=QZoS
-----END PGP SIGNATURE-----

--Qy+sdSDVmD8xz5a1--
