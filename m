Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05446D970F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbjDFMda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjDFMd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:33:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC452697;
        Thu,  6 Apr 2023 05:33:26 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3317766031C4;
        Thu,  6 Apr 2023 13:33:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680784404;
        bh=/0LDjXRCwHEymatIRCAZ3ulYIdFCSC40zOqX6BI+96c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HxlFYhs3UcETCWycpd60jL1Fs//b9O6aBZWsuQz0ra7skWQlL9kA7JZktJYrnpc4T
         uHeRhV0XfxERK8yWcFaqtR5YduWn2sXQ5K3SliVzm2etolqIbqpC3uDUl5Eh3HO+Cc
         lYkLevP5fHPrkvJMW04sqXTjp7Y2SctlCB4QfpvWpT2GpOBBWpXS8OSMmR4zGGrjQ5
         XcLj8PAp3O9tI982K0FaUUlo5Sus1xNtgLyCi3lnJEp11HQpGvB5XYIUnXSbfTOZ/u
         txAa0BpwWp2bwo0tgzNeDefjJGpNWvGPKcjqQOn71CuXWHi/n8CSqmyx5QgbaIrkme
         GhpzRW3PS1oxg==
Received: by mercury (Postfix, from userid 1000)
        id CD85A1062B1F; Thu,  6 Apr 2023 14:33:21 +0200 (CEST)
Date:   Thu, 6 Apr 2023 14:33:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Message-ID: <20230406123321.vs64ff2i7xplovoo@mercury.elektranox.org>
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <20230404145350.45388-2-sebastian.reichel@collabora.com>
 <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
 <20230406105129.nuv3jcmwl7ugql3q@mercury.elektranox.org>
 <0f671b8a-fbc4-a7c0-1469-a9e3f180e776@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xawuiqwpi7td5n6n"
Content-Disposition: inline
In-Reply-To: <0f671b8a-fbc4-a7c0-1469-a9e3f180e776@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xawuiqwpi7td5n6n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 06, 2023 at 01:02:44PM +0200, Krzysztof Kozlowski wrote:
> On 06/04/2023 12:51, Sebastian Reichel wrote:
> >>>    clocks:
> >>> -    minItems: 1
> >>> -    maxItems: 3
> >>
> >> The constraints here should stay.
> >=20
> > dtbs_check complained about the 4 RK3588 clock entries if this
> > stays. That's why I moved them to the condition down below into
> > the else branch.
>=20
> Which is not what we want. We want the constraints here (the widest).

So it should look like this?

clocks:
    minItems: 1
    maxItems: 4

=2E..

if rk3588:
    clocks:
        minItems: 4
        maxItems: 4
else:
    clocks:
        minItems: 1
        maxItems: 3

-- Sebastian

--xawuiqwpi7td5n6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQuvAYACgkQ2O7X88g7
+popzhAAjrro7g4U+NWfFSwlIqXng7QEYRqHPBrtNrmNs+zVozWgVv0/GF29ffIO
38ZvHrvHrAyRf1RlOWgP7vI0DyKHw8KUL/TKZnkmf5Bu0cxZvjUMavlk85zjmkiH
OFhLG1LB//gyk5SRU8Cq26Nc4ojhIRJ0wKWb1wO0KfAn50gK5ejErSU/1wktJbUX
jhNu6V5AX/lIvSm77urfG+m/9a03W7gSw8e5w3rL17thI4lqnDTGBVWnoFACbgQg
iRskI1NzETp1JfzXHr5MHZRlMkSTFlKcQQEAQeLIhZTGPcCqdu6hhYAN7z9dxQ7Z
+YmQtCcNSl8qEEcNzKI6wOUJCdBCpGffy9GXTHYITS3f5Z+I6TKYdwMqchO3Lxfy
Odsf0tmochdULgQU8tZ8kZ7bNv9BDvvAzDr1+YKW1k+x+aQLRWqVWVAsiPE3Wwkk
EfVmPyqvdWWZBUnlEZrHHjKjWelcrkm6BxRDzWrR7IJh2SiNJ1HZvdRRliRp7S05
P7p4E0W0hyB7f8INKk5hQFBqzVZ+I1O3DB0BdzIxHcCCL9tqjhEdgHVEOs26sQ7h
Dpguak+wBIK+HTL4ofrfXX3yeFlmax9SBF9kAoofazpKmQXm4dE+B82rWEI3AVSi
9ay36m5oqS5nfxOqaOHPL3ji4dSqk7KLgqRypt5XyZ7S8RcpGks=
=51KG
-----END PGP SIGNATURE-----

--xawuiqwpi7td5n6n--
