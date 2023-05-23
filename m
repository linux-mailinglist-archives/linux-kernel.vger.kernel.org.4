Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554870E34C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbjEWRV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbjEWRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DD11A4;
        Tue, 23 May 2023 10:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4E463504;
        Tue, 23 May 2023 17:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E7C4339B;
        Tue, 23 May 2023 17:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862491;
        bh=aT2ocotPlA/nSBH/8PduunTauw9vMBYGyMKMNVT/r+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRnLh7k/CzU1h0jLRsDO67VJxc8vSBtPTmUdaqBNSCE6g7J91jL35JLulOx9C9JYR
         TMQ6Pdk6XSiAAgEgZWIvCVKX8r6uo7WnelJKRjJXopuh4RdfXIdMlUkGQhOolw8xTN
         XcrZV3vZD1uLRNUAwXkfv5ZKpWri+ivpYG5HZDCZPeKk4CaFVGi7HO1G5eUJnSIe1W
         kOvX1qTiJ0TuCBd6rezaZxrEtAwSMr5dDrTprv//m8FUxOmMIZzFCZBnJmmR8gBirF
         iK3pr5wbqwUaDsYcENJl+WOoI3UgfN6nmtHz+aQlRGmuKRpoxdZXhfk6u2sOkVG4ba
         5iq4vCdEoIUqA==
Date:   Tue, 23 May 2023 18:21:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: display: simple: support non-default
 data-mapping
Message-ID: <20230523-jaywalker-modify-500ec1d79223@spud>
References: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
 <20230523-simplepanel_support_nondefault_datamapping-v2-2-87196f0d0b64@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mkHOJIwDJ1jryFTv"
Content-Disposition: inline
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v2-2-87196f0d0b64@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mkHOJIwDJ1jryFTv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 10:19:42AM +0200, Johannes Zink wrote:
> Some Displays support more than just a single default lvds data mapping,
> which can be used to run displays on only 3 LVDS lanes in the jeida-18
> data-mapping mode.
>=20
> Add an optional data-mapping property to allow overriding the default
> data mapping. As it does not generally apply to any display and bus: use
> it selectively on the innolux,g101ice-l01, which supports changing the
> data mapping via a strapping pin.
>=20
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
>=20
> ---
>=20
> Changes:
>=20
> v1 -> v2: - worked in Rob's review findings (thanks for reviewing my
>             work): use extracted common property instead of duplicating
> 	    the property

That looks to be true (and Rob's AFK at the moment, hence unable to reply
to your ping) so,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> 	  - refined commit message
> 	  - add an example dts for automated checking
> ---
>  .../bindings/display/panel/panel-simple.yaml       | 26 ++++++++++++++++=
+++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple=
=2Eyaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index ec50dd268314..698301c8c920 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -21,9 +21,9 @@ description: |
> =20
>  allOf:
>    - $ref: panel-common.yaml#
> +  - $ref: ../lvds-data-mapping.yaml#
> =20
>  properties:
> -
>    compatible:
>      enum:
>      # compatible must be listed in alphabetical order, ordered by compat=
ible.
> @@ -353,6 +353,17 @@ properties:
>    power-supply: true
>    no-hpd: true
>    hpd-gpios: true
> +  data-mapping: true
> +
> +if:
> +  not:
> +    properties:
> +      compatible:
> +        contains:
> +          const: innolux,g101ice-l01
> +then:
> +  properties:
> +    data-mapping: false
> =20
>  additionalProperties: false
> =20
> @@ -372,3 +383,16 @@ examples:
>          };
>        };
>      };
> +  - |
> +    panel_lvds: panel-lvds {
> +      compatible =3D "innolux,g101ice-l01";
> +      power-supply =3D <&vcc_lcd_reg>;
> +
> +      data-mapping =3D "jeida-24";
> +
> +      port {
> +        panel_in_lvds: endpoint {
> +          remote-endpoint =3D <&ltdc_out_lvds>;
> +        };
> +      };
> +    };
>=20
> --=20
> 2.39.2
>=20

--mkHOJIwDJ1jryFTv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGz2FQAKCRB4tDGHoIJi
0kGeAPwK0hvRgZEe5yCs6X2BQm57H3xiCRVe4/ILNn2rSwIImwD+JohV+vtU8PcX
KBG/Gdo4LQ0y4cn44UJBX4oDxTQc9QY=
=EQAo
-----END PGP SIGNATURE-----

--mkHOJIwDJ1jryFTv--
