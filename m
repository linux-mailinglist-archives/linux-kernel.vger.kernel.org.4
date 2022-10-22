Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4D608EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJVSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJVSTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:19:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F5ED980;
        Sat, 22 Oct 2022 11:18:59 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 828AD660237E;
        Sat, 22 Oct 2022 19:18:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666462737;
        bh=aVRfa05Pe4xu8Oy3Hd7CQnA76p8LS2W9iGhPGMnw+qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MK/yeP8c8W918ZegSCk1eMlJ+VPS+K8YHfpnvuq768Vo87AGYTqpFPvlaG/EFFDLS
         dPUKr7VN+Ybw342XFy2hBe4RnwxWXA5cHsyL1/1qVxnNj5W+7jusYh3RF/fpQrm8Hk
         SQ0dzvr9yStrJfsR5W1o7RzRpPi9mdj+LK06OfAJLzOxxqJ0W0FPRlUuKtp29+ael/
         BmIEp/r+bHo/J3W7hNRw4kO5VXQMjvS+IPzWcj6E8WS1S6vacIJE/g1SDoXeMRVLAQ
         Ur419A1T2KfXpJlhhXar9CFC0kXibYQgz3rGcx/1vx8RVeA+Q53TqPOxIqJs1hOPdl
         VDxh07PGeyGBQ==
Received: by mercury (Postfix, from userid 1000)
        id C0F3210607E8; Sat, 22 Oct 2022 20:18:54 +0200 (CEST)
Date:   Sat, 22 Oct 2022 20:18:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com
Subject: Re: [PATCH 1/2] thermal: rockchip: Support RK3588 SoC in the thermal
 driver
Message-ID: <20221022181854.znel4pizx3gemz7q@mercury.elektranox.org>
References: <20221021174721.92468-1-sebastian.reichel@collabora.com>
 <20221021174721.92468-2-sebastian.reichel@collabora.com>
 <2aafa6cc-a7de-0b7a-571f-04593ad53787@linaro.org>
 <7276280.TLKafQO6qx@archbook>
 <2b0fe8c2-674a-3b44-16aa-d3008b1271c3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3ipl5tfxboahj42"
Content-Disposition: inline
In-Reply-To: <2b0fe8c2-674a-3b44-16aa-d3008b1271c3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3ipl5tfxboahj42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 22, 2022 at 01:12:22PM +0200, Daniel Lezcano wrote:
> > If you have access to the TRM, it contains the following line in
> > part 1 on page 1372:
>=20
> Unfortunately no, I don't have access to the TRM. But I'll be happy if I =
can
> ;)

The RK3588 TRM is available under datasheets on this page:

https://wiki.radxa.com/Rock5/hardware

> > 	Support to 7 channel TS-ADC (near chip center, A76_0/1, A76_2/3,
> > 	DSU and A55_0/1/2/3, PD_CENTER, NPU, GPU)
> >=20
> > I assume one of "TOP" and "CENTER" is "near chip center", the other is
> > PD_CENTER, whatever that means (PD =3D power domain maybe?)
>=20
> Yes certainly.
>=20
> I take the opportunity to let you know there is a new tool in the linux
> tools directory called 'thermometer'. You can capture the temperature and
> use the data to create graphics.

nice :)

-- Sebastian

--r3ipl5tfxboahj42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNUNAsACgkQ2O7X88g7
+pqiABAAoegMIjcvD0MMzIGy5tJXZrbTiRiXnecAxm52JAWAFUOguaq/9eHHfUTA
txSchjmuzrZf41rhF1nM+6gbb3EEgZyNlkVfcmY+I++jWpA4labqb/fj+j7Ct2aF
TCixCcJT7RgPyF/MvrQ5zAlPPk0loikk3OBZwLIs5zDULIurjwu9hHLNYHi0S5nT
taiaHtfvdzlOidmbb7yc0TdvC5bYKnIjeMCQ49Vs7OsltnzUJvztSCEtRHj2flvq
GvFZavp3VB3ZZl3FaRO4AzmHGM9zxTMsbLXMBqMO6pplUKCHEliOKh6svRwbrEza
MqNHl4cNl9KWI7hqdB1kXPtRF3s6kcTZsH8+LK0wkh2po1oV9jkVloFxApy0kjo3
EDpuRmUKOeWdX0iO+88ehK6k31heZInEjTYJivgCII52OrwN7ryDkYj5s/WoZE+i
KqkozthBLI9dM7yojZ97fYO2MqxO4IF+63j9kmgcjhDEF3PQjs/5gMlpMyEY+Ab0
rR6zN1X8t12EDUfm1tmPtFSJ9YfbWoi18CkBid8BB0YFYl9rCfl7BNlCp35B2uBo
fwgHnDefq3llRKK+5NX+Imk+z3DiMisEeLjEicORXERweAzkuG6CaMQwK2GboMK9
e32ANTH6AUcf9knUFSKqFGckFVkdpne5N+pDgIrrL4NHaSOCVoQ=
=oMve
-----END PGP SIGNATURE-----

--r3ipl5tfxboahj42--
