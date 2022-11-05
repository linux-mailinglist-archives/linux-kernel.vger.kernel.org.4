Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99461DDF7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKEUU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 16:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiKEUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 16:20:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CDB12771;
        Sat,  5 Nov 2022 13:20:53 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E2FC6602366;
        Sat,  5 Nov 2022 20:20:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667679651;
        bh=mN8RRJhsexrMmxXRD/OzjLCD+e45Cf3A7xewzxMAk7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nv146gyy87JZaKTwIPg8oDriZSgQJQenM6vsHMddgUvVjiSGRwV/aKmaGjx2qJcUi
         C8etKDyd2rnoHpVcQXTVpN/gTJd9+Y4IIn8FAtd8zGj3TAHDHYsJoXk0BKrQqPUHoo
         0/NSU+poYDHh7iQwskYKWSTf7fxhhaofeDllWnbZUUng+bff3LxWFpgie6jYnUDpTj
         RlknxyhGBRcHPDWWx7kL7MPh9JSXllx1vAjcqBEFjZT93Z0H+nxAtUQPV0BDyohYdf
         G1qznt7Vq8zvei0IlHP4qTCX60eTdZC0+lIBR5YqJ5XpMe5mkaoo3QrA1imtd4kjVy
         FaMAkc5v/WlsA==
Received: by mercury (Postfix, from userid 1000)
        id 6AE111062C1F; Sat,  5 Nov 2022 21:20:49 +0100 (CET)
Date:   Sat, 5 Nov 2022 21:20:49 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Chris Zhong <zyw@rock-chips.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        linux-kernel@vger.kernel.org,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Osipenko <digetx@gmail.com>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: power: supply: define
 monitored-battery in common place
Message-ID: <20221105202049.2m2mbn3n4mhx7ppt@mercury.elektranox.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
 <166759887101.2893866.8476609318769745646.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b4bt64bo4i7jwi3n"
Content-Disposition: inline
In-Reply-To: <166759887101.2893866.8476609318769745646.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b4bt64bo4i7jwi3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 04, 2022 at 04:54:31PM -0500, Rob Herring wrote:
> On Wed, 02 Nov 2022 14:44:59 -0400, Krzysztof Kozlowski wrote:
> > Define the type of monitored-battery in power-supply.yaml common schema.
> > Reference the schema where applicable to enforce the above in bindings
> > which have monitored-battery property.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Changes since v1:
> > 1. Re-work the patch - define the type in power-supply.yaml.
> > ---
> >  Documentation/devicetree/bindings/mfd/ene-kb930.yaml        | 6 +++---
> >  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml   | 2 ++
> >  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 2 --
> >  .../devicetree/bindings/power/supply/ingenic,battery.yaml   | 4 ++--
> >  .../devicetree/bindings/power/supply/power-supply.yaml      | 6 ++++++
> >  .../devicetree/bindings/power/supply/rohm,bd99954.yaml      | 1 +
> >  .../devicetree/bindings/power/supply/sc2731-charger.yaml    | 1 -
> >  7 files changed, 14 insertions(+), 8 deletions(-)

Thanks, queued.

-- Sebastian

--b4bt64bo4i7jwi3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNmxZoACgkQ2O7X88g7
+prHnBAAoPZTWzrs6l6hUkEYVyqFlmO+8R2RwkF+0vpSS/vXtrs6KFN0L3im5zh3
zj7BN0D9SJHSwYtl7bbJCAizZ9dzwLS8EFZq+6gKoh8wRQ+Y4WJCVeUhCwUMFzGI
7rHzct8qpnjxkjwGCjb9Oip3dP2CE6YAad0QurUb/5xKQMZJhevi8xy19bURb9NS
fqyuwHP4B41pVl/nosS8ssEyeiF6Wg0ypsXi+0nyiKHVHw/8ZOzSAM60crPVdFpi
XGxv06qabil3Y9TmwxDHdSwKBzi37PK8QtMK2KvSQRb/lwVDw+ZsVuWQrOCoDYLI
r/Rwy1YZmrQYYvcAMKaSZyQ0oTz9uv7SgIvfa+Yp/i/dCno9Z4NNgKh/ao84AHSk
rPEQkaxHc6kNZ94H3dGBVaEW/kW+opU1IRk6ozA879KRPd8d4XWhakpigJ195jgd
vzvOdmTTaW6sU1wiOeKSzTKUaCUFTTrVjO7F+ahqZtxTWv3rukR0vswbubPV2ors
TaGUZtPJo1TM4yk12IOtXJcBKp1W/HFEGqOHvSI71fmF3zYguoht067emWduslH/
1r4CvY2LI+oRMm6FR0yNx6GmPXhXRkmqh5tbV2zDaAlJ4/wYI2YaVumrYkjFEQWu
zMMcrlBhLsDm/sPnMNirjWaBfUhm6e5i/IWzAsM9+vtBgtYkwQc=
=d/iP
-----END PGP SIGNATURE-----

--b4bt64bo4i7jwi3n--
