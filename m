Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125B76140B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 23:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJaWaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJaW3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 18:29:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC7F26E5;
        Mon, 31 Oct 2022 15:29:23 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA6996601E58;
        Mon, 31 Oct 2022 22:29:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667255361;
        bh=y7NHk+x/vkwV4B6bPqXt9h+kTokITc8sWrGBHP8NPNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JYpPB0aO/MMbrQkYic+RHqVrLuAwKNI0ud8uCXdiAarhfFi43aQfo1mwfZPFQUVf1
         ny0VvEs0HTxMMLY6jC+h8BTa+tIf+zvtpag4Qahv2T58+rlZe6DavftrokXx1dQ45a
         ggpyHAZU2BxGnB7SFMT36OeKjqMdvppN807wIfHh8zelXnWvZsFxZIDAKg2pqgFaNc
         OGrFWyudfLmF7+U4U8nZWOcyT1qY9VD8RGV8iJ0jVtx3sOjNFKn5s+NpK0SIqYD4PH
         uU/OKM69U2ewrpSdH5z/VioJ06tLmh5sYzLGfgiv9m4+Z4/xHvepfPU/Vo9pdbOwZF
         pWFhl9HsdzoYg==
Received: by mercury (Postfix, from userid 1000)
        id D6D1E1061C6E; Mon, 31 Oct 2022 23:29:18 +0100 (CET)
Date:   Mon, 31 Oct 2022 23:29:18 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] power: reset: add Odroid Go Ultra poweroff driver
Message-ID: <20221031222918.knzv3lotfn3sp7bl@mercury.elektranox.org>
References: <20221031-b4-odroid-go-ultra-initial-v1-0-42e3dbea86d5@linaro.org>
 <20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eujrc3kuhfvtgn3s"
Content-Disposition: inline
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v1-2-42e3dbea86d5@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eujrc3kuhfvtgn3s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 31, 2022 at 05:47:26PM +0100, Neil Armstrong wrote:
> The Hardkernel Odroid Go Ultra poweroff scheme requires requesting a powe=
roff
> to its two PMICs in order, this represents the poweroff scheme needed to =
complete
> a clean poweroff of the system.
>=20
> This implement this scheme, and overrides the PSCI pm_power_off.

Please use devm_register_power_off_handler() or
devm_register_sys_off_handler() for new drivers.

Thanks,

-- Sebastian

> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> [...]

--eujrc3kuhfvtgn3s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNgTDsACgkQ2O7X88g7
+pq7uA/9H2d0rwb0Y8DB6tj/S2dpXLu4UNe10uTTfw48HwbZ/u9iAZA10IpCLUsN
v1nLjSNKO0KZAV4V8oQaic8k3g3ZW50mt26gDPSCo19q/D3VcIwzFjUV93XDP/ue
z3M1ftw6SWWIByaL7PoB9JSh5NCQsLAofDCCwVrJP8xC6Po59AXNUfYl1oLakV+x
+3+HPE5KnQBH+c2kQwD6RteiSRc9oBj5TzUJGPQJVj3sAns//vRnSAkPnUKj6cSc
1YIxtfuZM+f0lHZ4q0QPP9CZnoZrOZGKBfuk51GzkBCqRqHNlXQyo3IALzARWkzC
ybj5PYeiAtt/9065o4qW8l/5ZkRnBgKtXLo6yEeZ4QWi4v8k+peULZUhj15hYIu1
PFNMbCPYgrdw0zAhYF+ZGalmj7V0Bc2dt/Vdmy8P67G+Z/yFrHPkOPd+8annG1P9
f32huAi+Moe5KUGplibWRdWHivxosVV48HH1Mcl7FD223VSt2HIzIHDEshufM0Wq
BghGc+J2KEs9+dKwxnaZzKco59tjCmw+78inlEeyJreEEGh9vqfWFOJN0At47VPa
cQcqGGXPMOOJHDlTFZVTLmxlZA9tl9FT+7X78IrqFZFSKEJ15VnY3Bfl2BZwwYSs
vdojcitlJoJUU3vfa11ut36Rd2hSFSoaWdmS+mzXnuFcDD7hIqI=
=j9s8
-----END PGP SIGNATURE-----

--eujrc3kuhfvtgn3s--
