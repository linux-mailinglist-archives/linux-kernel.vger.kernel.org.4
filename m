Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731296D83D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjDEQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDEQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:38:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743AA4C31;
        Wed,  5 Apr 2023 09:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6FDA629BE;
        Wed,  5 Apr 2023 16:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCB3C43443;
        Wed,  5 Apr 2023 16:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680712692;
        bh=syKhDH18sc1NcY1/ySSVPv2qM6XNI1spR3GACAOsNJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBNtu1Pr52mhp899qkiRAQ3jV6O5ZfF7agoRgDSfE2Kov/aUqK7ByJkK10TOdw+0X
         3WCXsxvRS43Z9Lyz2xY9BnQKKVTRIKzEr0FgrLu2MU8LYBrhazoPa55y5z8bI5WkR+
         YwSQAMOiAhxm282qCVUe1Y1cNJvZQhpBqkqcEYC/swER81ncPq3WNN1br3XCS9klTf
         T4F1g/Cab+mZbp1h5rPIys/HbGY0wqQ8feM7ryyu5WBcX0QZsD1r3NV6ay0UWmai08
         psHGP5jshPyXILDcFR39tHCWgW05oHtBCZvCvRF4cKAun42UDKb6omKeU7L/Mo6QwE
         IH0DbsmV6DXog==
Date:   Wed, 5 Apr 2023 17:38:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Message-ID: <20230405-bullseye-handsaw-5c2e4dab772f@spud>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
 <850bc37e-c6d1-2381-a851-965a4cbee8a0@linaro.org>
 <e38efd81-9c79-553b-7556-7aff30f6ec50@starfivetech.com>
 <f25cc55e-3405-4b17-fb45-5ae5eb36a404@linaro.org>
 <d0b1d44e-6d6e-536c-046e-be6a53f1d240@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l1+mDrVx6go5Y/WQ"
Content-Disposition: inline
In-Reply-To: <d0b1d44e-6d6e-536c-046e-be6a53f1d240@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l1+mDrVx6go5Y/WQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 03:32:14PM +0800, William Qiu wrote:

> >>> Does not look like you tested the bindings. Please run `make
> >>> dt_binding_check` (see
> >>> Documentation/devicetree/bindings/writing-schema.rst for instructions=
).
> >>>
> >>> ... or your PLL clock controller was not tested.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >> Hi Krzysztof,
> >>=20
> >> I've already done`make dt_binding_check`, and get no error. So maybe P=
LL clock controller
> >> was not tested which I didn't add in this patch series. And PLL clock =
controller belongs
> >> to Xingyu Wu, I would tell him.
> >=20
> > What's confusing you do not allow here clock controller.

> I'll add it then.

What's the plan here William?
Can you sort something out with Xingyu Wu so that the dt-binding is
added in a complete manner?
In the meantime, gonna drop this series as "Changes Requested" from
patchwork.

Cheers,
Conor.

--l1+mDrVx6go5Y/WQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC2j7wAKCRB4tDGHoIJi
0k+4AQCdBamxHmK76N715U1XwXpOgMU26jEqAcw7pKiI/4fH4gD9GXFxFJgrDOfu
irkLH3kj2KloYVZ/9eNvQHp19BK9NQ4=
=bLQ4
-----END PGP SIGNATURE-----

--l1+mDrVx6go5Y/WQ--
