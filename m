Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA2B7055A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEPSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjEPSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B783F6;
        Tue, 16 May 2023 11:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31CB463D99;
        Tue, 16 May 2023 18:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD6C433A4;
        Tue, 16 May 2023 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684260399;
        bh=TIF6e415h0FVUlyHXv4z4fyHq2xBc6qwAIKs2u9GF0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jw7r4wJOSlfyAPtUVCNAXSw5AUeGy9gz3fKSm1lCMEYWdm5B2bwv+/UptcTQCF6pY
         /ITRmKpcboiSxeLuwpQwtnudpTPD7S1vXkN8NHSpLdgkViLSBhzIcYub2G/svoGBIg
         0DBn/3+ca3xmLsfdInw1Cw+aLvNnXHPlYmvsBQo1tgW/lpKLEcbNKOfr3tSIhkiE/7
         BUlwie/MOnHfTxO9VYW4JcTNKBWSEgEpQM1V3kmnUszUzEt7tNCYdB1eWbr6bvaKvx
         1BtMX463aNh3cWZZ6RrJH/KX9uMxeW7H58v8X9zYw7Nt3SSVYMveuuHWEZ/uvxWwJR
         UfbBcqe+g1hew==
Date:   Tue, 16 May 2023 19:06:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     robh+dt@kernel.org, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        pascal Paillet <p.paillet@foss.st.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: stpmic1: add fsl,pmic-poweroff
 property
Message-ID: <20230516-footprint-handoff-bcd553ff6146@spud>
References: <20230516132225.3012541-1-sean@geanix.com>
 <20230516132225.3012541-3-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rd5ceYlXksEiZAx+"
Content-Disposition: inline
In-Reply-To: <20230516132225.3012541-3-sean@geanix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rd5ceYlXksEiZAx+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Sean,

On Tue, May 16, 2023 at 03:22:24PM +0200, Sean Nyekjaer wrote:
> Document the new optional "fsl,pmic-poweroff" property.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  Documentation/devicetree/bindings/mfd/st,stpmic1.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml b/Docu=
mentation/devicetree/bindings/mfd/st,stpmic1.yaml
> index 9573e4af949e..5183a7c660d2 100644
> --- a/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> +++ b/Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
> @@ -26,6 +26,14 @@ properties:
> =20
>    interrupt-controller: true
> =20
> +  st,pmic-poweroff:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      if present, configure the PMIC to shutdown all power rails when
> +      power off sequence have finished.
> +      Use this option if the SoC should be powered off by external power=
 management
> +      IC (PMIC).

Just reading this description, this is sounding quite like a "software
behaviour" type of property, which are not permitted, rather than
describing some element of the hardware. Clearly you are trying to solve
an actual problem though, so try re-phrasing the description (and
property name) to focus on what exact hardware configuration it is that
you are trying to special-case.
Krzysztof suggested that the samsung,s2mps11-acokb-ground property in
samsung,s2mps11.yaml is addressing a similar problem, so that could be
good to look at.

Also, the dt-binding patch should go before the patch adding the
property to the driver.

Thanks,
Conor.

--rd5ceYlXksEiZAx+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGPGKwAKCRB4tDGHoIJi
0ttYAP4vmjFXsrbhAGKA/cInxDWCIs7qIGH8rMylmv4NU7JE/QD+JKoAFQtxI767
s7vlXlr+/HE9UNGBhgpC3D2EEqFYewE=
=1soC
-----END PGP SIGNATURE-----

--rd5ceYlXksEiZAx+--
