Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560E37040D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245541AbjEOWRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240909AbjEOWRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:17:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5249830E8;
        Mon, 15 May 2023 15:17:17 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 041A266031CE;
        Mon, 15 May 2023 23:17:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684189036;
        bh=Poy+wtaWYf9GDOq/ot+oI5x8t5ldZp8lzSTkQfYQHkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5rAly5QqApyomEA33ZZtCXgcChgClTuXF+SPqTEz51nrJNcX9qm5rraP25XKHAIh
         N2B9im3G1D5iJfLx42K0d7bvtxtIcqmlKFEfoy9Q5q4e7FddN88nIsbrV8qggySeOv
         u/QT9W005TBTGQUNWh2kfwq9QQhm1FLT0+e1e0fp2ePaWDmBpg7M6BxTU5vdVpgnIh
         vhjoffgx9oaGBV48utICgnCp5TOLRgZW0rLFGlQhjKxqUYdLGnmA/nyhBlDffu4krt
         CjfIAo8JGi7XAYrXr7SdlcxXgumK959XhVm00/s8w9KVlWkL/hQuCHFOGzcAYWsVQP
         jM086vMrDX6VA==
Received: by mercury (Postfix, from userid 1000)
        id 4C88C106138C; Tue, 16 May 2023 00:17:13 +0200 (CEST)
Date:   Tue, 16 May 2023 00:17:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: power: supply: maxim,max17040:
 update properties
Message-ID: <20230515221713.oatxpsfvqcjwsuux@mercury.elektranox.org>
References: <20230308084419.11934-1-clamor95@gmail.com>
 <20230308084419.11934-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3aena5x5ifgdhepq"
Content-Disposition: inline
In-Reply-To: <20230308084419.11934-2-clamor95@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3aena5x5ifgdhepq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 08, 2023 at 10:44:16AM +0200, Svyatoslav Ryhel wrote:
> Add simple cell, status, health and temperature properties.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/power/supply/maxim,max17040.yaml | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max1704=
0.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> index 3a529326ecbd..6f1c25b4729f 100644
> --- a/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/maxim,max17040.yaml
> @@ -55,6 +55,20 @@ properties:
>    interrupts:
>      maxItems: 1
> =20
> +  monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle to the battery node being monitored
> +
> +  power-supplies: true

The above two should not be needed, since the binding inherits them:

```
allOf:
  - $ref: power-supply.yaml#

unevaluatedProperties: false
```

Otherwise LGTM.

-- Sebastian

> +
> +  io-channels:
> +    items:
> +      - description: battery temperature
> +
> +  io-channel-names:
> +    items:
> +      - const: temp
> +
>    wakeup-source:
>      type: boolean
>      description: |
> @@ -95,3 +109,26 @@ examples:
>          wakeup-source;
>        };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      fuel-gauge@36 {
> +        compatible =3D "maxim,max17043";
> +        reg =3D <0x36>;
> +
> +        interrupt-parent =3D <&gpio>;
> +        interrupts =3D <144 IRQ_TYPE_EDGE_FALLING>;
> +
> +        monitored-battery =3D <&battery>;
> +        power-supplies =3D <&charger>;
> +
> +        io-channels =3D <&adc 8>;
> +        io-channel-names =3D "temp";
> +
> +        maxim,alert-low-soc-level =3D <10>;
> +        wakeup-source;
> +      };
> +    };
> --=20
> 2.37.2
>=20

--3aena5x5ifgdhepq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRir2UACgkQ2O7X88g7
+pomyxAAhwG0eUxHeP9GtV1b5iuoRP4GRT72EHjs/CifNKYeaUPS42F4BP18yPnC
TVOYXU19DkthvmfCs1HmfKSZvJGp3eMDECjBAWteLMHPUduPOC/+x0a2UZrnTkAY
g5R/zIhY1aRpfUfH08aVcEKhK8VbWn25zjlK6Jx0NAeOyw89Qv4UELw9TS+hOQRc
B8ZTZpeTRwXX4+sYxt3SbiVmOg73ttyXwzrQWpYwTNyHbja2JLtGfe3uumihwF4N
xIbNNyd3AvgN5rBxdKgw10xV2XsbooNDj6KcOsimtnyrRh1Q2nai7ZYlSt7/2+B9
PT40jnc4kGuR4Zg+eAN/YRgSMXOfNfCljWlPUVw1NM/GOf8o1AhZD4OqInzxUo4e
A7nDthnGGyxw54M6gVC1pVVJyt1vBu6K5zjlaoB/OWVL/2edi88pCqNdlibyGPF5
JiCeQvTAKRx1fuycyEeUjhr9OQLqu4hTUOz07u/Q2Xgkp+w1ZYOFBdSkLYfRLAOq
JrZFzVJS/SiQhwQ21vIWCE2btXo+5dsgRoAjoCDp/w083Q315k2Ylm86cQMQQVH+
L7HO+Lms07fJnCJoBmrq2hUzMv2nEdiBCefkt2VPbp2hinWGufibTB/4XtFeQMez
T5pNUSZB/30X027knuSluhJHKzgBWWMNrwDLwNt3ZYQYXEcbcrU=
=qiL/
-----END PGP SIGNATURE-----

--3aena5x5ifgdhepq--
