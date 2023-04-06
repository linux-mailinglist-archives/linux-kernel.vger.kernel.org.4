Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AF06D9929
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbjDFOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbjDFOJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:09:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB8AF0D;
        Thu,  6 Apr 2023 07:09:20 -0700 (PDT)
Received: from mercury (dyndsl-091-248-189-216.ewe-ip-backbone.de [91.248.189.216])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD03466031A4;
        Thu,  6 Apr 2023 15:09:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680790158;
        bh=TEzIUtJIn05p8FEXoeRkKwxXxwXBOUTZUXxhT6ryUhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TK7jBdmJJWV7c2V6QnOZSQTk8YhCo7RqQGYeMFVjob0NfEiKRir/dyC8kSo4zOfHY
         xzsACe5jFteAfiKbme2QcVZe5K7wW4fV6R8/RhHMixJ4j0mS5+X2VCFHDCaGkCDKXh
         IYFI+bVx+ui0hgB9vp/ePCoJhn8V5BVHcY492Wzprq5J7nVX2eWN/CXwhkjOI5F4/e
         bhsWJDNQvz8WZtcCnAwCWLKajNV/ApxKTkXNV5rzZtTTpmsx1EiRP40wXb6XMqpbuZ
         y4EZMJTHDZKlwkyAZILsOVxRp2TfSejQU4C9HNDznmzRE+EHtilfyjUrms51NI4805
         ZvBtK+5qUHC9g==
Received: by mercury (Postfix, from userid 1000)
        id B8E7C1062B1F; Thu,  6 Apr 2023 16:09:16 +0200 (CEST)
Date:   Thu, 6 Apr 2023 16:09:16 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv1 0/3] generic-ohci/ehci: add RK3588 support
Message-ID: <20230406140916.gdp5bb2bjp5hmhlp@mercury.elektranox.org>
References: <20230406135552.23980-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6n4466ayebpzy7rz"
Content-Disposition: inline
In-Reply-To: <20230406135552.23980-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6n4466ayebpzy7rz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 06, 2023 at 03:55:49PM +0200, Sebastian Reichel wrote:
> This increases the max. allowed clocks for generic-ohci from 3 to 4.
> On RK3588 a total of 4 clocks is required to access the OHCI registers.
> EHCI already supports 4 clocks.
>=20
> Changes since PATCHv2:
>  * https://lore.kernel.org/all/20230404145350.45388-1-sebastian.reichel@c=
ollabora.com/
>  * Added Krzysztof's Ack to the EHCI binding update
>  * Changed OHCI binding update according to Krzysztof's feedback
>=20
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20230331163148.5863-1-sebastian.reichel@co=
llabora.com/
>  * changed cover-letter subject
>  * Add Alan's Acked-by to the driver patch increasing the clock count
>  * Update bindings, adding rockchip,rk3588-ohci and rockchip,rk3588-ehci =
compatibles

Sorry, this is PATCHv3. I somehow missed the point from Greg last
time (and thought it was about the subject) and even forgot to
increase the patch version yet another time :(

I will give some time for DT people to review the OHCI binding patch
and then send it again with version increased to v4, so that it can
easily be applied with b4. Sorry for the confusion.

-- Sebastian

--6n4466ayebpzy7rz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQu0oMACgkQ2O7X88g7
+pqRLw/+IZ83kY3HErkIuDqkBVrqakkCa5XgN4hh6+oT5tbiQVyyLjFUGzQC+8eb
tx9Oz2DkTk/oyTh72GJhIetKeevTF85AhbeSeWgC3dQObJ8PDFeXio5MzxDL7kKc
+CblCxxsfz29bWurBKKNtqXReRxDlsW3ZJhTs5wvw5G3v1JAJLFUagtqDI/CVNkH
VqIGD4z9+UOhWpotrYx/t1ORKZdrqceh0mM786Y8bbXhNQmdo0zt7vGVcgKPS3Uh
a8amx4JQuqCNb0PQARSvlDai2nv+cnO21cqrhpDc5VqI4mxEkDCg3LJCN6cc5J6X
PYq2PGOqVSheVRIKgwvs8C56Yvnt7G9fILs5RkhqOj6OsAfVRYr9ROT11uWBWSY5
Cgh13nygaFro8QxXqYalq0IJhWUDlGzXs6dy7R6oOZJEqayYL3QUTna/cSbyYEqU
N9ZXUIeDmwUhffZtWCXm8wSaSykCrO2oTdZMQH4XjdkuGROL0h+KDIDE+Hcw8dD4
WmnSVP1lFrtDK1JFuScavjZp472KFq+fP1qPvMHxr1UZj7j/TnbqGgufBYd+Ogma
e4WMieSxCImucuWY4X25ITtAZK/uVvMdjsW2zc9nOYb2hAMU31t9WGq5kVfC6Ksm
Dz0BKZWoKKbMBKfKLZxGZLvKQbY1dKLQkRj/9SbG+BMwKrhaA3U=
=Fmfs
-----END PGP SIGNATURE-----

--6n4466ayebpzy7rz--
