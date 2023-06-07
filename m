Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087F6726606
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFGQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjFGQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D08C2703;
        Wed,  7 Jun 2023 09:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF58B64170;
        Wed,  7 Jun 2023 16:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA13C433D2;
        Wed,  7 Jun 2023 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686155485;
        bh=qEuYvnmPZzVd5kfR7QpaDptDCacZpuG18/vGuqCAZf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFdxdU+EQCXUyr8WtsjzyeO9sYKicu1J5jaOVvOvLMe+AmyxXLT7t40QFtcg+hSu9
         M0CnTqmx2+gH1vwbZartAmPOQQ4MsD14Gx0ZQY6IWZ0OGz7Yrnt6ddnxh1WLG39tTW
         3UVyCOjuSl0HtVHEywIoZsu/0WaWA0jHz/hYqh96lvRwOSolemjhUTI8gaBBV0t3bW
         77vwaZCLIqm32LMPAjZGHTJVmPi3sMmaGrkxEwzfV5MoEXn8+Tws/4Jqsdw5aXQFeS
         ynXneK2BOW032S2ZIhNPtnzhvzHRz/QNMjUZHdHtItUGvSmPKhjhj1NeFC9YzyMHEe
         kTHr9LcVGQC8w==
Date:   Wed, 7 Jun 2023 17:31:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini
 GW7905-0x board
Message-ID: <20230607-decorator-cage-a823b3a0e2f7@spud>
References: <20230607162438.2009738-1-tharvey@gateworks.com>
 <4bee93d7-0613-3b15-d34d-c62cbb367547@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iq31Jfdk2MC6P9Xi"
Content-Disposition: inline
In-Reply-To: <4bee93d7-0613-3b15-d34d-c62cbb367547@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iq31Jfdk2MC6P9Xi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 06:27:28PM +0200, Krzysztof Kozlowski wrote:
> On 07/06/2023 18:24, Tim Harvey wrote:
> > Add DT compatible string for a Gateworks GW7905-0x board based on
> > the i.MX8M Mini from NXP.
> >=20
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documenta=
tion/devicetree/bindings/arm/fsl.yaml
> > index 2510eaa8906d..b19444dc23da 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -915,6 +915,7 @@ properties:
> >                - gw,imx8mm-gw7901          # i.MX8MM Gateworks Board
> >                - gw,imx8mm-gw7902          # i.MX8MM Gateworks Board
> >                - gw,imx8mm-gw7903          # i.MX8MM Gateworks Board
> > +              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
>=20
> Are you sure you are using correct prefix? Anyway, keep alphabetical
> order, so before "gw".

  "^gw,.*":
    description: Gateworks Corporation
                 use "gateworks" vendor prefix
    deprecated: true

 ;)

 I'd be more interested in whether that -0x is a wildcard!

--iq31Jfdk2MC6P9Xi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZICw2AAKCRB4tDGHoIJi
0ijTAQCd5ZnC4ndOe4bDOSr8uCC4yD6/HAZTELJZY2416OwoGQEA84EqH1G3+iFI
S3g2mbaXsy3GZDVTfLICZT2rrIiaawc=
=liCW
-----END PGP SIGNATURE-----

--iq31Jfdk2MC6P9Xi--
