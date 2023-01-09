Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F473663031
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjAITTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjAITTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:19:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40486111C;
        Mon,  9 Jan 2023 11:19:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD5D2610AA;
        Mon,  9 Jan 2023 19:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E782C433EF;
        Mon,  9 Jan 2023 19:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673291961;
        bh=I9vhhoMs3WFpRtM3ZAfcVlbwKo9qXFT3gHzyMFQGbpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ik95PrWuMaaoqHh+hzhd4DXDCynr1Zbrf7mpaj0QRYp41ZN8NwgXUXGaUKREWpIu3
         jXZn4EZwon9Xao8ZDYi0Brum/mHx0x169//r3s186LRW8fT+ydJmr7gNDvenSISijc
         AS/I9BRmf+2zNHoDNbZfdta5E1+CJ0m7RcVVedYux1HUmiF8Vp8Bwud6OB5rvpsiDL
         dgMe5kzoRfMQEftgW+PIC+h6OkQMS1Qjm306yInoz1973ls2ZyjCzun4qYHpuilQlm
         gSI8sS2J9oIPxZd6+dbYCHkRTlDjYUXZyoM1lFy1f0VT14T7rRZmSCri/fuAGq45iB
         N3SGWLrcRUG5g==
Date:   Mon, 9 Jan 2023 19:19:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/16] dt-bindings: spi: Add spi peripheral specific
 property
Message-ID: <Y7xosoZMJEwRi1ok@sirena.org.uk>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-4-william.zhang@broadcom.com>
 <Y7iPS48viBg0QRok@sirena.org.uk>
 <3ff9a7fa-25dd-701c-078e-03e47bd3c08b@broadcom.com>
 <CAL_JsqJ7kr-6xs53NYJufem=wXnXVRnj3-1t1rG+W6g09kJ3ew@mail.gmail.com>
 <6720e3a4-dbbb-f490-98db-511a52b9a2ab@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lmcZn8x/tmKJQ3ye"
Content-Disposition: inline
In-Reply-To: <6720e3a4-dbbb-f490-98db-511a52b9a2ab@broadcom.com>
X-Cookie: Editing is a rewording activity.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lmcZn8x/tmKJQ3ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 09, 2023 at 12:06:13AM -0800, William Zhang wrote:
> > On Fri, Jan 6, 2023 at 9:27 PM William Zhang <william.zhang@broadcom.com> wrote:

> > Keeping the clock on or not would affect all devices unless you have a
> > per device clock you can gate, so making this a per device flag
> > doesn't make sense.

> This applies only to each chip select. There is only one device under each
> chip select.  So won't impact any other devices under other cs.

I don't understand how this would work - usually a SPI controller has a
single set of clock, MOSI and MISO lines with the only per device thing
being the chip select.  If the clock line is used by all devices then it
must be kept on for all of them if it's to be kept on for one of them.

--lmcZn8x/tmKJQ3ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmO8aLIACgkQJNaLcl1U
h9DqAQf8CYCqNr+Diaohf358fnuLfnlMbJCW8n2slDDq0RjrhBRy8QpuXKsw6ug1
hd7C56/d+UUDBgj0PtsQEcSRl1092xgblNfUTQPAeEltcRogkKwOuLxtP6Z0dlka
T4mDP8iJOmREbLaN2P6oyS6DlXfnnEUMm0bjgeUCdqOLF0dBgNtcAkDTb7VH8nPO
ZRUBnlcihawhrHZKfiwIYyhWqel4XylYCok+JURDvqVvTVbHQpC0epNk/zJJH3fg
zQyZykohWUty87j+sTmYkhsLWiPZAC0nUlCJaoae4GDw7mc3V0gZNxP/zS6XqR4K
qcs6uYpSzKkCGloysSZMs6UrfaZE/Q==
=x6ap
-----END PGP SIGNATURE-----

--lmcZn8x/tmKJQ3ye--
