Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583FC60BEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJXXt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiJXXsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:48:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC94BA49;
        Mon, 24 Oct 2022 15:06:42 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C7AF5660239F;
        Mon, 24 Oct 2022 23:06:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666649161;
        bh=0DZREBkMejpNRqf8Nqk2/WVBPsg4sk2w69lAt8niLSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPyx+sZXh9qqFB/rX4k4sH3V+SoGANcR+dIjR5pq8JVS3XCR0Aq7Hl8UZqdSg3vNQ
         GbEfkx68nhYD0mYnTF0D2S6uMAxEud2M/vCXdhGyfLDXbiGACdmEOQmlvxRxbaI0SG
         8JsYuchohy3bMXpx/O/lMDZuRm87THXp7Zldd635HksRrRem9Y6N1dH/7t+uQhS3zw
         vmw54iYJyTrx19p3wFTFRtEbgZlmkmkCbiQEIOpgjjC8hXiWc46RbvE4k6Vv3XC8P8
         Hr4nb4RjTn0zPDV9ONphGsj8xMdqz8AsK/1uZ9CP6E3Eq4azgujx6F7mPypMupAbPF
         IO96eRbMgH6YQ==
Received: by mercury (Postfix, from userid 1000)
        id BA81210607D6; Tue, 25 Oct 2022 00:05:59 +0200 (CEST)
Date:   Tue, 25 Oct 2022 00:05:59 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 1/1] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Message-ID: <20221024220559.dddihmq4xg55h26w@mercury.elektranox.org>
References: <20221021170605.85163-1-sebastian.reichel@collabora.com>
 <a5db8a34-acd0-e262-36f0-0b904468bd1f@linaro.org>
 <20221024185049.GA2034297-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="omachftlzphorltz"
Content-Disposition: inline
In-Reply-To: <20221024185049.GA2034297-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omachftlzphorltz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 24, 2022 at 01:50:49PM -0500, Rob Herring wrote:
> On Fri, Oct 21, 2022 at 07:59:26PM -0400, Krzysztof Kozlowski wrote:
> > On 21/10/2022 13:06, Sebastian Reichel wrote:
> > > Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> > > Schema format.
> > >=20
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > > ---
> > >  .../devicetree/bindings/rtc/haoyu,hym8563.txt | 30 ----------
> > >  .../bindings/rtc/haoyu,hym8563.yaml           | 55 +++++++++++++++++=
++
> > >  2 files changed, 55 insertions(+), 30 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym85=
63.txt
> > >  create mode 100644 Documentation/devicetree/bindings/rtc/haoyu,hym85=
63.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt =
b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> > > deleted file mode 100644
> > > index a8934fe2ab4c..000000000000
> > > --- a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.txt
> > > +++ /dev/null
> > > @@ -1,30 +0,0 @@
> > > -Haoyu Microelectronics HYM8563 Real Time Clock
> > > -
> > > -The HYM8563 provides basic rtc and alarm functionality
> > > -as well as a clock output of up to 32kHz.
> > > -
> > > -Required properties:
> > > -- compatible: should be: "haoyu,hym8563"
> > > -- reg: i2c address
> > > -- #clock-cells: the value should be 0
> > > -
> > > -Optional properties:
> > > -- clock-output-names: From common clock binding
> > > -- interrupts: rtc alarm/event interrupt
> > > -
> > > -Example:
> > > -
> > > -hym8563: hym8563@51 {
> > > -	compatible =3D "haoyu,hym8563";
> > > -	reg =3D <0x51>;
> > > -
> > > -	interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> > > -
> > > -	#clock-cells =3D <0>;
> > > -};
> > > -
> > > -device {
> > > -...
> > > -	clocks =3D <&hym8563>;
> > > -...
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml=
 b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> > > new file mode 100644
> > > index 000000000000..b0b6126b12dd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/rtc/haoyu,hym8563.yaml
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> >=20
> > Dual license please. I don't think you copied any content from original
> > bindings... unless the example?
> >=20
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/rtc/haoyu,hym8563.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Haoyu Microelectronics HYM8563 RTC
> > > +
> > > +maintainers:
> > > +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: haoyu,hym8563
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  "#clock-cells":
> > > +    const: 0
> > > +
> > > +  clock-output-names:
> > > +    description: From common clock binding to override the default o=
utput clock name.
> >=20
> > You need maxItems for this.
> >=20
> > > +
> > > +  wakeup-source:
> > > +    description: Enables wake up of host system on alarm.
> > > +
> > > +allOf:
> > > +  - $ref: rtc.yaml
> > > +
> > > +unevaluatedProperties: false
> > > +
> >=20
> > Would be great if you could also correct DTS using these bindings (see
> > warning from Rob).
>=20
> It looked to me like 'clock-frequency' should be added to the schema.

I've sent PATCHv2, which removes clock-frequency from all hym8563
users. My reasoning is, that the old txt binding does not describe
it and the current Linux driver does not handle it as far as I can
see.

https://lore.kernel.org/all/20221024165549.74574-1-sebastian.reichel@collab=
ora.com/

-- Sebastian

--omachftlzphorltz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNXDEAACgkQ2O7X88g7
+ppQbhAAqQfruhqqJn348vOyNGJBus/9pu1vnLc38D5XA7rI2GPjifPpwuDCJOl2
dnqnIet6jQo06lPOLeTM+EB06/Z19wmjnNXj3I8q+UQcST5ndxZE8j59RDbcV0KK
+Y7w2JLshRHZOs4iYiyKb1M9kF0whxMViqiHxA4Oba2pMyNqTyL9TWdluB6EV6Z0
1s61QlzhD58nWmewfYobxlFmJBvVgEoRAETxYeYrW6cbE30KesVx76TkypMipOQf
S7/Qn7d80rU37bedjScwPVRa9W1E8AmfICrJ2ZCVEnhIH5WvsxB+h+om740UyETp
0KQQZgmsY76l2YIArW6t8gQWyGWtPgUeNt3x4VP/3qyZ5rfnR/AvdDpY6KOqPunY
cYpvUp5wE+hzgOvp0dG69ItQP7Xc6zizKew1j/8J2SydYDXprN7joB9ejWqcBSdp
nVa6FSGTplhiTt/hPEeigs3VXIkvyP+XEptIVjmmg7xjVb+hCD1MnLsl3imIiei9
pOnpxh7ty+IAcjv2fHzXPhNm7JCf3KMuDAh48IgEdsQYlPnCN//rqrPWGC14V2z7
pWrFrHW/8i0bxptnguv0dtuaut+c+FzaWKUm6WeRkl3yqvkOc55S7/UTAgwbgSj0
0ZdY1+WndR8L+ZJPqFF7+77jj7Zhqyu1sTtl9X0ua+EIWeQcr9k=
=GlDT
-----END PGP SIGNATURE-----

--omachftlzphorltz--
