Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61CE709BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjESP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjESP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53AB2;
        Fri, 19 May 2023 08:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5194960B89;
        Fri, 19 May 2023 15:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FAEC433D2;
        Fri, 19 May 2023 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684511766;
        bh=qBWFq4Bx+YMgoGo+t+ko1dR8Ws+9DAUxuYULgMcKNIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2vHJ4uHASusVRTsD9Tz4NylL6/bc4c5RXt8Tg//Oh76bMSZX/SnPj3XYwMPhkqrp
         GD7jiG3Clwpqz2c2MS/bnp/v/OUVKqWLxnxf29lMUleds/pByh0ReJfJUMUVvQkvDO
         8ZgXjH1y5OU7Wi3t33vLYGwkhcyspMJMaeHMbyY67HqQRDJIG/8YXK2WpFHQ+WtTNa
         QcCswX14IfzhK5bGR0hIyvwfPQAICFwxNC6pbLWu9CEyRHGeHUYZ9jYpBei2eY0Yja
         Vf0HPZpywtD7c0Q3+PLvEKPazJHCy6t53F5/DYb/bRs3GdIFPRcSEMdrBFi3lF332y
         4iVk2ROeelfRg==
Date:   Fri, 19 May 2023 16:56:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the
 QDU1000/QRU1000 compatible
Message-ID: <20230519-overbid-unholy-bc5404a494bb@spud>
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-2-quic_kbajaj@quicinc.com>
 <94e1e91d-e36a-215e-2395-6212c1694dd3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BdZwo11bf1TuM+Fu"
Content-Disposition: inline
In-Reply-To: <94e1e91d-e36a-215e-2395-6212c1694dd3@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BdZwo11bf1TuM+Fu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 03:37:09PM +0530, Bhupesh Sharma wrote:
>=20
> On 5/19/23 2:21 PM, Komal Bajaj wrote:
> > Document the compatible for SDHCI on QDU1000 and QRU1000 SoCs.
> >=20
> > Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> > ---
> >   Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Doc=
umentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > index 4f2d9e8127dd..f51a38b12d6f 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> > @@ -55,6 +55,7 @@ properties:
> >                 - qcom,sm8350-sdhci
> >                 - qcom,sm8450-sdhci
> >                 - qcom,sm8550-sdhci
> > +              - qcom,qdu1000-sdhci
>=20
> Please add new entries in alphabetical order.

With this done,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BdZwo11bf1TuM+Fu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGecEQAKCRB4tDGHoIJi
0lV3AP9u42Xap6bdzZc0n7eLe6XKtdYOCODxe8NYB3wJIftyAAEAyHx4Bb/Iz3SX
TWVPYgLFr3Q2bklCaW5OS6nXiR5qYQc=
=tzhh
-----END PGP SIGNATURE-----

--BdZwo11bf1TuM+Fu--
