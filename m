Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACE709C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjESQlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjESQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:41:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5704DC9;
        Fri, 19 May 2023 09:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E09AB6595A;
        Fri, 19 May 2023 16:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B15C4339B;
        Fri, 19 May 2023 16:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684514492;
        bh=4V3rIZHGewZ37KX/d7iFBjaOSDGIQLkOkH/I0DBDFZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u6nL4Rhap4UrrrT3u3HPKgx6cgMELv6DWFxKMKjmI62T4Qa1rW/g8sOjy/CHgM+P9
         iywesp7c7w0m12ICJqQ/hFY1FfudKuAVfT5qVtEMQ4TI2yhh2kWw/tC+FmKCWNJzUO
         BXCWUzi43kt85w+AxY+kRAv/gg1uQBiLXgRxhjDmwpr8zz8hcQOUKQFb0sHV2+j8Dq
         Q8XLRlg3MHVhrgKkP21yO7gAhgc5D9k8Bn5HWSMXk6wrIRtY+I0gyl2IgbnZzNdfEu
         pYfekqPwpT1DNZ8jtE8fWaJ/bwnErfsiQFxH2h8MgEC7TTL744LsEHGp4PlV0DOM0I
         F7OzTM4Qaibdw==
Date:   Fri, 19 May 2023 17:41:27 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add fannal,c3004
Message-ID: <20230519-emerald-void-066fad80950a@spud>
References: <20230519142456.2588145-1-pavacic.p@gmail.com>
 <20230519142456.2588145-2-pavacic.p@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bSjCdcTTHsR3DWsJ"
Content-Disposition: inline
In-Reply-To: <20230519142456.2588145-2-pavacic.p@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bSjCdcTTHsR3DWsJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Paulo,

On Fri, May 19, 2023 at 04:24:55PM +0200, Paulo Pavacic wrote:
>=20
> Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> DCS initialization sequences with certain delays between certain
> commands.
>=20
> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> ---
> v3 changelog:
>   - renamed yml file
>   - refactored yml file to describe fannal,c3004
>   - added matrix URI to MAINTAINERS
> v2 changelog:
>   - revised driver title, now describes purpose
>   - revised description, now describes hw
>   - revised maintainers, now has only 1 mail
>   - removed diacritics from commit/commit author
>   - properties/compatible is now enum
>   - compatible using only lowercase
>   - revised dts example
>   - modified MAINTAINERS in this commit (instead of driver commit)
>   - dt_bindings_check checked yml
>   - checkpatch warning fixed
> ---
>  .../bindings/display/panel/fannal,c3004.yaml  | 75 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  6 ++
>  3 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/fanna=
l,c3004.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/fannal,c3004=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> new file mode 100644
> index 000000000000..a86b5ce02aa2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/fannal,c3004.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/fannal,c3004.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Fannal C3004 MIPI-DSI
> +
> +maintainers:
> +  - Paulo Pavacic <pavacic.p@gmail.com>
> +
> +description: |
> +  Fannal C3004 is a 480x800 panel which requires DSI DCS
> +  initialization sequences.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: fannal,c3004
> +
> +  reg: true

Are there no restrictions on the number of reg entries?

> +  reset-gpios: true

Can you put a blank line between properties please?

> +
> +  vdd-supply:
> +    description: power supply voltage
> +  vddio-supply:
> +    description: power supply voltage for IO
> +
> +  width-mm:
> +    description: physical panel width [mm]
> +  height-mm:
> +    description: physical panel height [mm]

Here and for the supplies too.

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 82d39ab0231b..f962750f630a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -462,6 +462,8 @@ patternProperties:
>      description: Facebook
>    "^fairphone,.*":
>      description: Fairphone B.V.
> +  "^fannal,.*":
> +    description: Fannal Electronics Co., Ltd

This needs to be split into a commit of its own.

Thanks,
Conor.

>    "^faraday,.*":
>      description: Faraday Technology Corporation
>    "^fastrax,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c22c828ab46..62374c8424b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6427,6 +6427,12 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
>  F:	drivers/gpu/drm/panel/panel-ebbg-ft8719.c
> =20
> +DRM DRIVER FOR FANNAL C3004373132019A
> +M:	Paulo Pavacic <pavacic.p@gmail.com>
> +S:	Maintained
> +C:	matrix:r/mipi-dsi-bringup:matrix.org
> +F:	Documentation/devicetree/bindings/display/panel/panel-fannal,c3004.ya=
ml
> +
>  DRM DRIVER FOR FARADAY TVE200 TV ENCODER
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  S:	Maintained
> --=20
> 2.40.1
>=20

--bSjCdcTTHsR3DWsJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGemtwAKCRB4tDGHoIJi
0m/XAQDFF3Fpkb5sWicHv3R1bHCis6f+XpiBK1wgB2w4wUaEOgD/fSJGDvvhiqd7
7z9NZHNub67JEBgyN6uFviSM0saNjAI=
=hYPC
-----END PGP SIGNATURE-----

--bSjCdcTTHsR3DWsJ--
