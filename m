Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E5689F03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjBCQWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBCQWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:22:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C48A641F;
        Fri,  3 Feb 2023 08:22:18 -0800 (PST)
Received: from mercury (unknown [37.81.76.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1084D6602F11;
        Fri,  3 Feb 2023 16:22:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675441337;
        bh=RuY5iusY+NWNJyjFIpLuOk+R0feDymEetOVTrgygBxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lb+LKL5cJpzJKtEdiCgkURg63v6dHETpZe0Gj0QFSMzBndU7alMynFq5Vh1+toZsU
         YZ988LQbNW2N+0fMNdCcYd3rM9z7L2H2/fBSPZPcUCEFAs21ZBVEUhHBRrUPN2kPuW
         7omBBABfsVOKvPAMHlsrCPXIFdx2uQeTRgrrWZKlC5HW+Z1rkCHy108Q4LgSQlSBSJ
         VU2gW0Ug/+9levFz/r6aeWG3oMAtAY7SF2GRyusjYpy7LEBc6IMyzfY6rDBFEsS6pM
         UglA3200xsMe+fWi2IHdlu7aD5h/rlEg1lxamW/UVsi+jGTVDeYympZS+/8r636awq
         58wfu8mVahf2w==
Received: by mercury (Postfix, from userid 1000)
        id 985E81060930; Fri,  3 Feb 2023 17:22:13 +0100 (CET)
Date:   Fri, 3 Feb 2023 17:22:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 0/3] Add Richtek RT9467 5A Battery Charger
 support
Message-ID: <20230203162213.7kisugbsza4suds5@mercury.elektranox.org>
References: <cover.1672730839.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rdxpduh6xl6np7d5"
Content-Disposition: inline
In-Reply-To: <cover.1672730839.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rdxpduh6xl6np7d5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 03, 2023 at 03:29:55PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>=20
> This patch set is to add Richtek RT9467 5A Battery Charger support.
>=20
> RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
> for portable applications.
>=20
> It integrates a synchronous PWM controller, power MOSFETs,
> input current sensing and regulation, high-accuracy voltage regulation,
> and charge termination. The charge current is regulated through
> integrated sensing resistors.
>=20
> The RT9467 also features USB On-The-Go (OTG) support. It also integrates
> D+/D- pin for USB host/charging port detection.
>=20
> Thank you,
> ChiaEn Wu
> ---

Thanks, queued.

-- Sebastian

--rdxpduh6xl6np7d5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdNLIACgkQ2O7X88g7
+poMdRAAkBj9DK3QoW2SJymVljr0kaa3LI2X7whMKaIyIs8uoz8EsRago9/d9Sav
fytuiTa4/amZ+mUXZOsvRyN0h/KHvutfUwtotRx7z7zsKkZFlnZG/sKgjQuMQqwJ
ln0U/A9Oh2o275tYm73OeCQDQWUktq768Zf/w0qtfPDqtpbX1bHi9XikiowlMWq/
7WzfVV1K5LHHqfT4oZZ2vkngx2eGC6pxNU/X+paUjNM9JEBd28UTuOaGBYH755KG
k1h5cfrhHWaiuAZp6jvlTTgBChcwebUzBXL2MRgV4GQASnr9ucX1hyyIXsDaNCI0
kFgy80q54pIWuZe3mWA52FD2ASSy8aNSelf6ku4MKW+nvPotJIsdQxS5BiI7NceJ
4AZmw00NA4yFwYKYOFl6BpPM1i4XLFCPLB++qrRQS/dx9FMp4eyOuNaEdZRIeEFT
vXppjoHC8wz5diWDU58rFM455qbHeyZgZwrfV0ktCxJKx7nDR5EChwEGfN2qmNLw
SAx14fTUhVvsmNsgzOY5yc+jQYS5z55ZRHzvqN54myS0wxcx2uemO2bjXgm6K23S
bAmBMTTk1mGGLJYfATVTX5Fo5egbDOtoZI+2Mam7l7KT0rGJX+7lWXCKh3/DZcfD
fL/8dKHZ6Birh14zIJmXJnBmFXps/2z3QLAEZBLPozL0WMgI2ZE=
=cMRA
-----END PGP SIGNATURE-----

--rdxpduh6xl6np7d5--
