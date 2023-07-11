Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2572B74F7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGKSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGKSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88651716;
        Tue, 11 Jul 2023 11:05:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6851A615B6;
        Tue, 11 Jul 2023 18:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE81EC433C8;
        Tue, 11 Jul 2023 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689098754;
        bh=xIq4UPJc5cJM6QesWCRibpmblqZYNDtcrH7yYHl3oK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWaDSgMdD4UzMmzKqW6Lxv4GAHzx73ct8iijKJbB5W+gmcZcf1g4mTyEDxU/WBCFx
         +3cqk+Xk6nCGHIj7hPMbJUxa8tfoGcg3xZFAJge3mW7Lo1N2kHmbPm74BHmTapWjNs
         R5XXG4mwhC4C5ANrfJAmAFGEM3LVVGldL8dhjsbYnCY9FsHLoO9YO42nnzmI6QwrNf
         CbOqf2IDC9lRytEtWxsvGP7/qhOCKvtB1Tp9c4svbUctXaYy8lf6xtzqYjSeF6BVr6
         0gcweyNJH3KuERy2BcMiB93WaQycOJiT80L9nBBl9/ZsbU+AUw//GzBg9lgaeHVl/5
         l2r+UBmUfbppw==
Date:   Tue, 11 Jul 2023 19:05:49 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Huqiang Qin <huqiang.qin@amlogic.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] dt-bindings: gpio: Add a header file for Amlogic
 C3 SoCs
Message-ID: <20230711-monthly-return-8792ce346c26@spud>
References: <20230710042812.2007928-1-huqiang.qin@amlogic.com>
 <20230710042812.2007928-2-huqiang.qin@amlogic.com>
 <20230710-maybe-mantis-e647d94fd13a@spud>
 <424cb61a-9102-9a43-c999-36939e8d6cc0@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BB6EK5uDa3jar4Xq"
Content-Disposition: inline
In-Reply-To: <424cb61a-9102-9a43-c999-36939e8d6cc0@amlogic.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BB6EK5uDa3jar4Xq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:55:40AM +0800, Huqiang Qin wrote:
> Hi Conor,
>=20
> On 2023/7/11 0:38, Conor Dooley wrote:
> >> diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-p=
inctrl-a1.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pi=
nctrl-a1.yaml
> >> index 99080c9eaac3..e019b6aa6ca3 100644
> >> --- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-=
a1.yaml
> >> +++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-=
a1.yaml
> >> @@ -17,6 +17,7 @@ properties:
> >>      enum:
> >>        - amlogic,meson-a1-periphs-pinctrl
> >>        - amlogic,meson-s4-periphs-pinctrl
> >> +      - amlogic,c3-periphs-pinctrl
> > Alphanumerical order here perhaps?
>=20
> Okay
>=20
> >=20
> >> +++ b/include/dt-bindings/gpio/amlogic-c3-gpio.h
> >> @@ -0,0 +1,72 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
> > Any reason to deviate from the usual license terms for bindings, which =
is
> > "GPL-2.0-only OR BSD-2-Clause"?
>=20
> I initially used the license commonly used by Amlogic (reference: meson-s=
4-gpio.h):
> ```
> /* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> ```
>=20
> But when I checked the patch, some warnings appeared:
> ```
> WARNING: DT binding headers should be licensed (GPL-2.0-only OR .*)
> #37: FILE: include/dt-bindings/gpio/amlogic-c3-gpio.h:1:
> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
> ```
> So I followed the prompts and changed the license.
>=20
> Can I ignore this warning and use the (GPL-2.0+ OR MIT) license?

If the tools are happy then I suppose you are okay.. I'll leave that to
Rob or Krzysztof, but if you have a reason for diverging that seems fine
to me.

Thanks,
Conor.

--BB6EK5uDa3jar4Xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZK2Z/QAKCRB4tDGHoIJi
0gtfAP9/EXCGxkNjEP4so+mvz8Kfk7PRNhgkTxX9QnngeOPp1AD/XndZ8ks4QCwV
IXXaGza3r7f0IgKHFv0erzhbfM1q7gY=
=JIPw
-----END PGP SIGNATURE-----

--BB6EK5uDa3jar4Xq--
