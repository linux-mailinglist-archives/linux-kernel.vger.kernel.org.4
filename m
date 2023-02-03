Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A536689F09
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjBCQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBCQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:22:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3368CA6C24;
        Fri,  3 Feb 2023 08:22:42 -0800 (PST)
Received: from mercury (unknown [37.81.76.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C4CE86602F11;
        Fri,  3 Feb 2023 16:22:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675441360;
        bh=8/iOl1JkoX4qzoBl5tfa+91+8Fdoznk/0+WMSVeGStI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrCWBebtElx6IbYQfwqbuUc70cojJ8u5yErG8ybQ+bUFTnhAEh4O6SePQ02LozJBc
         0yy7g0mEhDw2d6MQSMW48Skyl8TESqk1J7KnhGM6jWKlTIFO5wvm3JAqeVbnt0EQpt
         LRLgxyN8+MMCUefhS/ZHisEEE/mhnMAwczg0PB3VGRSq3WdLL1847zVyd5yDy2hV0Q
         tEW+LAiw7Q+o7ynuAzfrCigyUcsOW3AI2omULNdkRlq8kg561Lfspb51dNNaouaw1F
         KkErLtYuC0S2PWP3j9o1uKtmEQfWSo81sxjqzy7j34/4JDyaIm8ajxLnhhSjKBOgD9
         BXtG5oyE7qHaQ==
Received: by mercury (Postfix, from userid 1000)
        id 7BBA51060930; Fri,  3 Feb 2023 17:22:38 +0100 (CET)
Date:   Fri, 3 Feb 2023 17:22:38 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang@richtek.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alina_yu@richtek.com, u0084500@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v8 0/3] Add Richtek RT9471 3A battery charger
 support
Message-ID: <20230203162238.sbc7gemv6tqzdnka@mercury.elektranox.org>
References: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lriez7o432fxn5yb"
Content-Disposition: inline
In-Reply-To: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lriez7o432fxn5yb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 13, 2023 at 02:17:43PM +0800, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> This patch set is to add Richtek RT9471 charger support.
>=20
> The RT9471/D is a highly-integrated 3A switch mode battery charge managem=
ent
> and system power path management device for single cell Li-Ion and Li-pol=
ymer
> battery. The low impedance power path optimizes switch-mode operation
> efficiency, reduces battery charging time and extends battery life during
> discharging phase.

Thanks, queued.

-- Sebastian

--lriez7o432fxn5yb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPdNM4ACgkQ2O7X88g7
+ppU3g//UHXAjrO5UO2/uND/9xYdTMPt93sY2oPu1e80jedO8H/2LLzas2TpDJeQ
Mb1FqzJoJRyVTqFBJpnA/RaQA6evZoLsp/ch2Va1jX4MqbtkIK0tIoBGtwBDnRQ8
u/jZptJLSJ2MpHcqUNXenuCpPQs9Nr7KNaLbd+YnBbrdCxzbMod58wGtSH6yjJrL
btVvkGkG7dO7xGkFOoFTgSpa7KtgP3rToH1sNcTPQnJ9PJJwXiXXIesm6iymYXhR
ae4NtuWHFZKT/UPsBSOue7sVu/bKGM03mlaEy11lCUk9kDvkCamna/NmdyU07kCx
cWfomG0Gk8D+RkXTOYi8lOsR7CgRTxsP+ef1tZBXHIGdLZ6pLbjOcdA2yxFemvGl
ssl4XoWZp/At1+sjhErJS4uZ4GWg8sZ4xpR15+uoMfxHB4uNO2psFGDBIEhc09C8
xyX/WdTPqtUNi7zymFdQsiREzX3Y/Cqa+QyON2lsDpcXO2TEdHX5nAdswuQJsBnN
A7UZfqq+zra9KQo0Lz8ujCjEQvtwgJZLDLZJo4cVTdhtbfyXgLDSOmVOj5u8RT6A
k1fJSHELuSxBlJbJxQMVRVVTO0+KuzFRDOQpLfQUjBgrY8Wb38vn8kENthCnRgiq
dyWyvG1yYDA+nyJX8lCZ+TJcp7yK2F7PG2F6NZKEwsU83Je1FTs=
=8trH
-----END PGP SIGNATURE-----

--lriez7o432fxn5yb--
