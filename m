Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58392645CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiLGOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLGOqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:46:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B6B5D6B8;
        Wed,  7 Dec 2022 06:46:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A680E61A21;
        Wed,  7 Dec 2022 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6633C433D6;
        Wed,  7 Dec 2022 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670424391;
        bh=PsHVnbFBEihPB3NBp0BJWow6YIbcbhY3sBbqiwuA9vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmnmuFc6Pc5jVPVWs++s8HNLuJr3H+pXoLfMKq1+RnAXtq+pQnOq0itFQnt5SxDuQ
         /KnltwAjDN8CGYC9ul7XN9vUL1syO9N5TQzW6TwemshAv5CjlMJ9UIqkqKDWrQj7lE
         bHjHqqIUgzSKPTR3u/U35anGRXj8CImhRp556r1pMoNerMEXgPycV1JCvkfZaqau5m
         1XXQZzZrlxwsRMHgV5dx1dHANcS9OU1AtGBD4TE5T332op40O1SKc+c+M+7K07rZ63
         /zh+5zrGg3ciYLNCXC9tp9HieLezwx/KQsrDn3/JmBj0DwIrroTk2vXZFlwWQg4Ddj
         gjpEhPEv62sMw==
Date:   Wed, 7 Dec 2022 14:46:26 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
Message-ID: <Y5CnQlYTZJrJNjCf@spud>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-2-william.qiu@starfivetech.com>
 <167042222472.2111911.2050446708831690640.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="15iFjk02Kxw946r4"
Content-Disposition: inline
In-Reply-To: <167042222472.2111911.2050446708831690640.robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--15iFjk02Kxw946r4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 08:19:49AM -0600, Rob Herring wrote:
>=20
> On Wed, 07 Dec 2022 21:17:29 +0800, William Qiu wrote:
> > Add documentation to describe StarFive
> > designware mobile storage host controller driver.
> >=20
> > Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> > ---
> >  .../bindings/mmc/starfive,jh7110-sdio.yaml    | 71 +++++++++++++++++++
> >  1 file changed, 71 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh71=
10-sdio.yaml
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.example.dts:21=
:18: fatal error: dt-bindings/clock/starfive-jh7110.h: No such file or dire=
ctory
>    21 |         #include <dt-bindings/clock/starfive-jh7110.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hello William,
As with the other bindings that StarFive has sent out recently,
including this header in the example creates a dependency on the
clock/reset stuff being merged prior to the drivers for unrelated
subsytems.
To avoid that, you can drop the headers & definitions from these
*examples* & use the numbers themselves instead.

That way, the only thing that depends on the clock binding headers is
the DeviceTree patch & the driver can be merged once it is ready.

Thanks,
Conor.

> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings=
/mmc/starfive,jh7110-sdio.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202212=
07131731.1291517-2-william.qiu@starfivetech.com
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>=20

--15iFjk02Kxw946r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5CnJwAKCRB4tDGHoIJi
0jqRAQCsSx3Ke20VhxNk/Ydi4ewyUPQPytJ6yzxj4xk9pgAeMgD+LIlTVnmUzECN
HBRjjc8AbZ9qq7SwsftQ/3nu/ACeQAI=
=JKRg
-----END PGP SIGNATURE-----

--15iFjk02Kxw946r4--
