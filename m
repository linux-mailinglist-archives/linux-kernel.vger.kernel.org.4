Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13C6FB54C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbjEHQhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjEHQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4904A468A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 09:37:35 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 597EA66032CF;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=fZR9OZcycfoyPy54qJlp1D01Wq51p+r2jf23MQ0mgQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izyfWit6mCt78a9kXNb9KZFxoLHsocIIuVuN40oPiTgBqQgywvAZisnFBlDPRhhfl
         UKYMlpi+O7m8m+edI+s1ceJyOYWxr09JiUpCbkm+Esq4ebtiVrNXGaQQ3IkSNruQ+3
         SQvdij0Nw1TVhC8SswHw17coKuDqnlDNgKGEhVQZhMDz8cEWqzT5B7peqSLkqpkGko
         R+nW/breIB55XOQP8bgAJ/HiGuxy5SCn/uSsOBJs/Dueb0Q0ixI4dixHoWF9BLmzbF
         uUnrmMbyiFbqyHdBkVhJzJjS+euKZ8JkSeH+5bCHAHBANvBJjQDtiYLKAPIl410ozT
         87gAPl3F4wDNg==
Received: by mercury (Postfix, from userid 1000)
        id 4EBDA1066FB5; Mon,  8 May 2023 14:18:57 +0200 (CEST)
Date:   Mon, 8 May 2023 14:18:57 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v5 0/2] Add new ti,no-thermistor property
Message-ID: <20230508121857.byvuevcx56q4u5ym@mercury.elektranox.org>
References: <20230504093037.2056146-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwzwssze2r7sm6ml"
Content-Disposition: inline
In-Reply-To: <20230504093037.2056146-1-chenhuiz@axis.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwzwssze2r7sm6ml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 04, 2023 at 05:30:35PM +0800, Hermes Zhang wrote:
> The TS pin is used to detect the temperature and suspend the charging
> when it's voltage out of range. If the NTC is not connect in HW, the
> TS_IGNORE bit need to be set to 1 to make charge work. The new
> "ti,no-thermistor" is used to set TS_IGNORE to 1 when HW doesn't work
> with NTC.
>=20
> Description from datasheet:
> Battery temperature qualification voltage input. Connect a negative tempe=
rature
> coefficient thermistor (NTC). Program temperature window with a resistor =
divider
> from REGN to TS to GND. Charge and Boost mode suspend when TS pin voltage=
 is
> out of range. When TS pin is not used, connect a 10-k=CE=A9 resistor from=
 REGN to TS
> and a 10-k=CE=A9 resistor from TS to GND or set TS_IGNORE to HIGH to igno=
re TS pin.
> It is recommended to use a 103AT-2 thermistor.
>=20
> Notes:
>     v2: change property name to ti,no-thermistor
>=20
>     v3: drop "|" in property description
>=20
>     v4: rebase bq256xx_charger.c
>=20
>     v5: add Reviewed-by tag from Krzysztof Kozlowski
>=20
> Hermes Zhang (2):
>   dt-bindings: power: supply: bq256xx: Add ti,no-thermistor property
>   power: supply: bq256xx: Apply TS_IGNORE from devicetree
>=20
>  .../bindings/power/supply/bq256xx.yaml        | 18 ++++++++++++
>  drivers/power/supply/bq256xx_charger.c        | 28 +++++++++++++++++++
>  2 files changed, 46 insertions(+)

Thanks, queued.

-- Sebastian

--fwzwssze2r7sm6ml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY6LAACgkQ2O7X88g7
+prXOQ//eReCXqJhRiRa5F6UXNsYNs4qkLfXJT23rJRXiWM8ugQfXKCc72WjoA5Z
9Ot7/zqmde4iX01bi2MS9nF+8oceSqZbgvaw/cceUA2EReKtdTdil0sziuls8C47
QC9jBNgzVBjhLQi9bpwYbznjIAmCM2i3tiwfTGOltwWeXRMHd131hx5Q6awXqd2G
do/czwrfBQLp2K9bNDhPHynPnV5DOE3qY8mcRE+8q4PuqLdlfFSrGX3HrJ8nNSUh
SgDE5zhPN6HhxZP/012K5LXGSqv7tBoi5GaxBfdsqy96K5YL9cGLGEMrfwKKJ3Hh
miT9l2aVOjTqZ89A4gzjY6MqE1B+MkcBzthePDwYKrwFLKS4Wwp15riPXOjk8I/F
BRMai0eum31/MAC41JOXC6ZPbQVzWDn429lwoEUJEoI435Chz9pSLH4smEnMguY/
kbvZ9aHr6fAUsvWorP9RbRxXCO2EB0VPMRC/dzTLMFiOHXBBH+s7I3op6uELKT/r
slHpXMzCDrPu7o4dgR3sAlsCaygfVdTuWBB1irYpvqB7qswNGKrjcoSEradls9cy
kEV+HJC10cUfKNiej635OYJj7HbX2dcfWiB+tsy44h3qtAelVXvrvvy6J5YWse7N
oMPUdDgOlgwBMlJ9c4tbCMEa4ydTqWavT5/6tYoSx40HQfwLoNQ=
=bJ7w
-----END PGP SIGNATURE-----

--fwzwssze2r7sm6ml--
