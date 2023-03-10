Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C0B6B398B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjCJJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjCJJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:02:41 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC5DB4BF;
        Fri, 10 Mar 2023 00:59:07 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0AD00100011;
        Fri, 10 Mar 2023 08:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678438746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IyndsoiQFOncX8WsCxAkagCwxLtYB8QsiuBmAd+5WnY=;
        b=K9pEhGWl8DkuIfGx7DhmC5ge2265UV9NfJzxuUfoK/5djbLOa+6pOTcT+VNjuQtrtd+Lv1
        Zzd+WXYzrcs/ZiANgdbrJJUKk/PxM0N9NgVj4zqTlc38BIMiaMotIuqapF6+0ZXWQbV1ul
        DxNb/0znC/C3P76kKAlMi6Pscimq14jUZ4bT3Qz2oneU3V8PuKbBDvjJL8rrab9+5kV0GD
        zx1Xr/+OFUI/JP+tj4udxJI0ITaYTFvKa5s0/pQZPpvYiySto3ZsuEvaCm9ObjLDBLoz0h
        tRScHTUaWViOH0YQ53x8GK4CxY0CoXPLxYWRvqMobpJ2z8Nu1SaB5FNVgWjqYQ==
Date:   Fri, 10 Mar 2023 09:59:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFm?= =?UTF-8?B?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3] dt-bindings: nvmem: convert base example to use
 "nvmem-layout" node
Message-ID: <20230310095902.33b1d314@xps-13>
In-Reply-To: <20230310075145.3996-2-zajec5@gmail.com>
References: <20230310075145.3996-1-zajec5@gmail.com>
        <20230310075145.3996-2-zajec5@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafa=C5=82,

zajec5@gmail.com wrote on Fri, 10 Mar 2023 08:51:45 +0100:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>=20
> With support for "fixed-layout" binding we can use now "nvmem-layout"
> even for fixed NVMEM cells. Use that in the base example as it should be
> preferred over placing cells directly in the device node.
>=20
> New and other bindings should follow as old binding will get deprecated
> at some point.
>=20
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 42 +++++++++++--------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documen=
tation/devicetree/bindings/nvmem/nvmem.yaml
> index 732162e9d13e..c77be1c20e47 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -67,24 +67,30 @@ examples:
> =20
>            /* ... */
> =20
> -          /* Data cells */
> -          tsens_calibration: calib@404 {
> -              reg =3D <0x404 0x10>;
> -          };
> -
> -          tsens_calibration_bckp: calib_bckp@504 {
> -              reg =3D <0x504 0x11>;
> -              bits =3D <6 128>;
> -          };
> -
> -          pvs_version: pvs-version@6 {
> -              reg =3D <0x6 0x2>;
> -              bits =3D <7 2>;
> -          };
> -
> -          speed_bin: speed-bin@c{
> -              reg =3D <0xc 0x1>;
> -              bits =3D <2 3>;
> +          nvmem-layout {

I believe we should not introduce "intermediate state" bindings when
this is not strictly required, in order to avoid confusion with what is
backward and what is transitory. So I would expect this to only apply
after the switch to:

	nvmem-layout@xxx {
		reg =3D <xxx>;

I don't care who will take care of it, but I think it would be better
to have everything in one series.

Other than the "order" problematic which I think is important here, I
agree with this series.

> +              compatible =3D "fixed-layout";
> +              #address-cells =3D <1>;
> +              #size-cells =3D <1>;
> +
> +              /* Data cells */
> +              tsens_calibration: calib@404 {
> +                  reg =3D <0x404 0x10>;
> +              };
> +
> +              tsens_calibration_bckp: calib_bckp@504 {
> +                  reg =3D <0x504 0x11>;
> +                  bits =3D <6 128>;
> +              };
> +
> +              pvs_version: pvs-version@6 {
> +                  reg =3D <0x6 0x2>;
> +                  bits =3D <7 2>;
> +              };
> +
> +              speed_bin: speed-bin@c{
> +                  reg =3D <0xc 0x1>;
> +                  bits =3D <2 3>;
> +              };
>            };
>        };
> =20


Thanks,
Miqu=C3=A8l
