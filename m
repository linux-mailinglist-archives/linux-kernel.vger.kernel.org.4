Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2359264D75F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLOHkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLOHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:40:12 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E76230F6D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=MXbGZi/uT236kTlDo/a7an6Zgc9j
        j3vGUMDH7t/LADA=; b=NC7nWVv6RWI3U1eApcT+54ZynNQXYEgXlKVQ/3SNNsLt
        hig76LkqBM78+BElQycqYB3XWnoZhqPCPs+wG29f5o3yef5ynQ/YEKg0xCgzh80u
        MhhkJkO6hfcaron+Nhx4La68lWsVZovpG2+msxcQTO9YmzQX7D4PIMkzH5FczSA=
Received: (qmail 2279799 invoked from network); 15 Dec 2022 08:40:08 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 15 Dec 2022 08:40:08 +0100
X-UD-Smtp-Session: l3s3148p1@vr1R9tjvOo4ujnt8
Date:   Thu, 15 Dec 2022 08:40:07 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: Re: [PATCH 3/4] mmc: renesas_sdhi: Add RZ/V2M compatible string
Message-ID: <Y5rPV0m5+8Dh6Bfe@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
References: <20221213230129.549968-1-fabrizio.castro.jz@renesas.com>
 <20221213230129.549968-4-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IfgYU8RXIPQ3Ptmi"
Content-Disposition: inline
In-Reply-To: <20221213230129.549968-4-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IfgYU8RXIPQ3Ptmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2022 at 11:01:28PM +0000, Fabrizio Castro wrote:
> The SDHI/eMMC IPs found with the RZ/V2M (a.k.a. r9a09g011), are
> very similar to the ones found in R-Car Gen3, but they are not
> exactly the same, and as a result need an SoC specific compatible
> string for fine tuning driver support.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 =3D {
> +	.fixed_addr_mode =3D true,
> +	.hs400_disabled =3D true,
> +};

Cool, seems like our quirk abstraction works reasonably well :)


--IfgYU8RXIPQ3Ptmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmOaz1cACgkQFA3kzBSg
Kbaw2RAAgL3RbR6t3/4u7yW4JYFKMjdthimKC9C2pKEy5N0poM/F/cTzTfFn+FTO
qTkPwmcPKEUSNa0QUwGQ3wFDpFEEm4MV/86p+uaYzQV7XLp5Xcbx3g7de15FC8mf
kU9UrLeWZg9ut62WaV9TVxo5lsiml1iGuG1/LsFkNy49OHqHY1ZHr7+NwcQDwAst
toexiP4n2F47ZpW/JGubvZvbmuac+6Df6VzNaggfRj+q68hqjOmC42uQ3timJe7w
Ts7/TgETLtSFMSHN5CKBUeNVzdumKIHX3DwHn/vSC8c+0SvW5QAu0/JiUc5ievx/
jRvEr3t3WoHh7E3S9EUmQFI5MMOwob4atl7aGM887Ic8Fkhd2w9rcyJsqFV9aDlE
C6TvVi5dwTC5wh5iOM5HroqnrXaf4btXMirULevey6pkM6nh93v20RRdJg1zNAFh
Mz7d2/gJolSpNlkyhsOj3Ot4JxydIRtHfV9VsujzBYbTgrnW8IGsnjxTneg4J+Xf
bwHGWjz1yqAjlbAf4P0dOgvjOqbRybWI0/2JW2JLseqOHBVOn2iiS1Oi4RogYNaf
RwiCa+Bre4li1HVU1/WzD9ZrQdzG6Mj3a2bnj0Dam4HpuW507b+SjevZmeQHN2lz
3s/8jJbWUgLEZMMo7QReNMB+TbspE3I81CZgeNTUpOT/qBz1EOA=
=J7AR
-----END PGP SIGNATURE-----

--IfgYU8RXIPQ3Ptmi--
