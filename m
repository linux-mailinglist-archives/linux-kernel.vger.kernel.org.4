Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181306FE2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjEJQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEJQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581EFE4C;
        Wed, 10 May 2023 09:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCECF639C1;
        Wed, 10 May 2023 16:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83420C433EF;
        Wed, 10 May 2023 16:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683736803;
        bh=iIjY05MJDxb4YGVapwMatlpjavNhv7TxmUelXD6rsYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdtjRXXdH1PuvJW5JHcdNukjpnpFkoykoEVj+JxYdhzHsv2mFkwCutsPYcfntDCZK
         yNqHh4uLUtxmUgTIDIIwSqEFsIPT38NAthMI270nisStniq2/cZ+Ebp1YSkNcrmv9w
         U6uVYh4ahbufC0Dgjaer1w94z0FrwiPGn1Vh0po+ecQIujHcwUEyr9AfgB+Lyb3kVZ
         2i37Biuod1HpqX1IrB0MKbPKPejH+Uh8jw7k98T34GYvaKc4hyJdLqHWBZuHy1n4bJ
         nKCSas+jhWkTqkTmm6WxLMea2ZPjT7/MUrkIooVlV5ufQxWIja1E2UgIYpdQzPVhzP
         8784VUdWgVFkQ==
Date:   Wed, 10 May 2023 17:39:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: mfd: add bindings for AXP192 MFD
 device
Message-ID: <20230510-rage-amazingly-d090d1e838f0@spud>
References: <20230510151542.312588-1-aidanmacdonald.0x0@gmail.com>
 <20230510151542.312588-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QLYvXStqnogFz2C7"
Content-Disposition: inline
In-Reply-To: <20230510151542.312588-2-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QLYvXStqnogFz2C7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 04:15:42PM +0100, Aidan MacDonald wrote:
> The AXP192 is another X-Powers PMIC similar to the existing ones.

In the driver patch the commit message says:
| The AXP192 PMIC is similar to the AXP202/AXP209, but with different
| regulators, additional GPIOs, and a different IRQ register layout.

That'd be nice to have in the commit message here too, to explain why
you're adding to the enum rather than listing a fallback.
Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b=
/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index f7f0f2c0421a..9ad55746133b 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -90,6 +90,7 @@ properties:
>      oneOf:
>        - enum:
>            - x-powers,axp152
> +          - x-powers,axp192
>            - x-powers,axp202
>            - x-powers,axp209
>            - x-powers,axp221
> --=20
> 2.39.2
>=20

--QLYvXStqnogFz2C7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFvI3gAKCRB4tDGHoIJi
0n8PAP9fNkh8u2UdkP4PFZmusgp4d0W3u+5Xyt6N4s1FbPVBKwEAu748aE6aAPZ+
71lHhWp4o3bXDXC5SDGJWLBnAUBReQQ=
=rCPv
-----END PGP SIGNATURE-----

--QLYvXStqnogFz2C7--
