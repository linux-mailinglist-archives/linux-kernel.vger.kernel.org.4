Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBF5BB551
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 03:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiIQBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIQBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 21:19:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCEB11A05;
        Fri, 16 Sep 2022 18:19:36 -0700 (PDT)
Received: from mercury (dyndsl-095-033-170-064.ewe-ip-backbone.de [95.33.170.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB262660204E;
        Sat, 17 Sep 2022 02:19:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663377575;
        bh=7ulxphpAxSCT98j4ooUK7PzyLXch2k+kjO357sfOvVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrJhp6BlrL4sp10ZGaHYG8L11/HZhni5MnRegbRZeamtZdvqT0ipAf8riAFYixGKB
         akpBgyx8dfz7+neFmwxI/ZPUuSj8pmiIqB3f3jg/OjuFfRXDp85PfCaEA6d16Fi/X9
         e8mn6nKFtoaTUWTO+2Beq2Chc4hBF48tSlPF467KggAj/Wssu2jU3l9h9y1ukK2oaj
         6ytrbENVkPq4nHQxYkDUSGqS+uezd73w9ahDKZ45gvUdcUKC/KpGojLiO/k34HEWmi
         9Hpf+mPnqb6dab0+GwMS9v4ItYTRTOOvzC7ttFCGZoA9qmYybj0QhpgPoAtyKt9oI4
         zekgpBaxifKTQ==
Received: by mercury (Postfix, from userid 1000)
        id 89EE7106084A; Fri, 16 Sep 2022 20:10:50 +0200 (CEST)
Date:   Fri, 16 Sep 2022 20:10:50 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] power: supply: rt9471: Add Richtek RT9471 charger
 driver
Message-ID: <20220916181050.7cwu36euz4hvfkem@mercury.elektranox.org>
References: <1663173015-7934-1-git-send-email-u0084500@gmail.com>
 <1663173015-7934-3-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h6nwvvqw4xktx7ws"
Content-Disposition: inline
In-Reply-To: <1663173015-7934-3-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h6nwvvqw4xktx7ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2022 at 12:30:14AM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
>=20
> Add support for the RT9471 3A 1-Cell Li+ battery charger.
>=20
> The RT9471 is a highly-integrated 3A switch mode battery charger with
> low impedance power path to better optimize the charging efficiency.
>=20
> Co-developed-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> [...]
> +static DEVICE_ATTR_RW(sysoff_enable);
> +static DEVICE_ATTR_RW(port_detect_enable);
> +
> +static struct attribute *rt9471_sysfs_entries[] =3D {
> +	&dev_attr_sysoff_enable.attr,
> +	&dev_attr_port_detect_enable.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group rt9471_attr_group =3D {
> +	.attrs	=3D rt9471_sysfs_entries,
> +};
> +
> +static const struct attribute_group *rt9471_attr_groups[] =3D {
> +	&rt9471_attr_group,
> +	NULL
> +};

Iff these custom properties are required (see response to the last
patch), then 'ATTRIBUTE_GROUPS()' can be used to simplify this part
a bit.

-- Sebastian

--h6nwvvqw4xktx7ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMkvCoACgkQ2O7X88g7
+prijg/+JRFp7kmC5ANGIe8K/TUE4HXk+7SLzOb9A/FBYMgh7WCvJZjzsnI4aYIN
lbCpQqf6N1YQ9SL1IjgUHR3y/qO5a0aJe+gA5K351bwjbjMgTiAiS0DK/U+NAomM
o/vHlyEb+NB8GHCb7uTS4WP6eftd6QLnARNpMVEaxOZWtI06/HjM6Rub2JkdGVFd
ZNHMq+t9dZ1h70XyVsKlpD1zj+Lo6pK7MiuH0ztskmzb7m9O/vsrlPzSECDG0H7+
MtuAOyQxmVicQKiuKOeTaL91rW19dUxvE6vTRebiCuJmMWLx2E4qWp3lxWHL+8K4
dDijLDb9SmsEb4p1cSmDoXTqcBytR95zoOsWtdCevaxagaRVA+E9FuxwJMrMmDYc
OcO2Jc7TR8QJ5prqzjJA5wuMexbRertPU2hwnPa1QHv8wbFibiTGSZuirjy5/AH7
PZWvbbqzD3sT5IBOW8Fuyr10ksGB2SW/Cj38C9tEQAxYsQhnNUEnisY6nLyN+Hfh
AlIS8IZdC48rfZWmIlMUfuxs+cURHRg4fd5dV89oowbkfmfqNWvLyq5lLSAGUJDR
YDph1h39EAMAUPGR/kC9L/1lNvLrnuuVqe4/gBKLrJuV+1P2Iq5BxlkTcsuE2Mb+
e0py58YXrS1ZRnyCmZfuToe/jt4QCwZK7CPOLY2wbqsA+8p+A1c=
=4g7T
-----END PGP SIGNATURE-----

--h6nwvvqw4xktx7ws--
