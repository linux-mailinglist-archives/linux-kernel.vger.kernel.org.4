Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D03712DD3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEZTqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEZTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:46:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F09B6;
        Fri, 26 May 2023 12:46:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4625465300;
        Fri, 26 May 2023 19:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F0CC433EF;
        Fri, 26 May 2023 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685130374;
        bh=HXsQb8OTNsgkJnd1fl608LKgHplT+hhrh89UYaD87Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nirNaDI1awCONOmsX+vCTz6UYlNgLRVjjGbqThGHfDpj7l+c8utdYi7ucRpgLf7ju
         2qDXOGkon1BQSUjYhrPs6uBgD+HmIFPd9iv8vQYCnlBwKI6s8WMTBGMYxXh7pbt0wo
         KZspfv0bWJfc9vdb3t6sGfK9YjxADg4OsvY7Zbg7DCTP/UJMo5Lz/74W96o+4PSXb2
         XPAeEYdLjL6Ui14MFTnfEfIBxgrUdTcSP3tf1wrsP4NraiTbjlz43juMhkMb/d7viU
         LaMLkrPj9ElqNXbO5etcYDwmsWjqA6J6s2o9Yb9BFUkcc0jvcfrEYtvAsS+cnembd1
         43YxktP77VdcA==
Date:   Fri, 26 May 2023 20:46:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss:
 Add CAMSS power domain
Message-ID: <20230526-obstruct-venus-5833511a58af@spud>
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Uk9rvZ9fwek1OCj4"
Content-Disposition: inline
In-Reply-To: <20230526180712.8481-2-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Uk9rvZ9fwek1OCj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo Yassine,

On Fri, May 26, 2023 at 09:07:10PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Add the CAMSS power domain which is needed for the proper operation of
> CAMSS, and add power-domain-names to ease fetching it as well as the other
> power domains.
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../bindings/media/qcom,msm8996-camss.yaml          | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.y=
aml b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> index 8a10aa1cafc5..27c9a11f0df9 100644
> --- a/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> +++ b/Documentation/devicetree/bindings/media/qcom,msm8996-camss.yaml
> @@ -85,6 +85,13 @@ properties:
>      items:
>        - description: VFE0 GDSC - Video Front End, Global Distributed Swi=
tch Controller.
>        - description: VFE1 GDSC - Video Front End, Global Distributed Swi=
tch Controller.
> +      - description: CAMSS GDSC - Camera Subsystem, Global Distributed S=
witch Controller.
> +
> +  power-domain-names:
> +    items:
> +      - const: vfe0
> +      - const: vfe1
> +      - const: camss
> =20
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> @@ -209,6 +216,7 @@ required:
>    - interrupts
>    - iommus
>    - power-domains
> +  - power-domain-names

Why is this now required?

Thanks,
Conor.

>    - reg
>    - reg-names
>    - vdda-supply
> @@ -326,7 +334,10 @@ examples:
>           <&vfe_smmu 3>;
> =20
>        power-domains =3D <&mmcc VFE0_GDSC>,
> -        <&mmcc VFE1_GDSC>;
> +        <&mmcc VFE1_GDSC>,
> +        <&mmcc CAMSS_GDSC>;
> +
> +      power-domain-names =3D "vfe0", "vfe1", "camss";
> =20
>        reg =3D <0x00a34000 0x1000>,
>          <0x00a00030 0x4>,
> --=20
> 2.40.1
>=20

--Uk9rvZ9fwek1OCj4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHEMgAAKCRB4tDGHoIJi
0mqGAQDnSs0kFgIjPFo7PgHn8Y5SILvoeUHvW3dbMPU5/SfohgD+MLqmFsqafGIP
XDQJpXUjsm0aicwi1Tj3LbvTvLbf6gM=
=d7a5
-----END PGP SIGNATURE-----

--Uk9rvZ9fwek1OCj4--
