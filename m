Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD8374DB49
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjGJQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGJQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:41:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AD793;
        Mon, 10 Jul 2023 09:41:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C937B6112C;
        Mon, 10 Jul 2023 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4932AC433C8;
        Mon, 10 Jul 2023 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007276;
        bh=BklOa+pPKx6unr8IyAuyGhh7uFZFgnSkVkf6qlGHnAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PInj/CefJW6G0t6ImrUTddulyxavfXgH5IsG3VLk4AWrOuJSoqOjdAzKXwYKmmO9+
         TpH8uMhQ+NEHXZkBkP9/E/lPxdyKgDL+eyDXS+gqft4HVdmnjyjH6PbUnm6/NZs9Bu
         r9ef3qEtXslV49T1zzzbJt5bp36OJ07JvRxmL8NERABHTTvvE/Ocj7BxwGAm9rr5e6
         gmG+HRchwacb9T9ZJ7npTesYRYHZvpm+A3BArDifgwRYwgpkkf4Ro2tIx8zbmK3MHI
         O18F7oZVF04V9d45m1+fc0aBurdqjBPaJYnNPNhPoDlRgG1WUDf42dslI1A3YaOt1Q
         INgpXraznkmIw==
Date:   Mon, 10 Jul 2023 17:41:10 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Piyush Mehta <piyush.mehta@amd.com>, nava.kishore.manne@amd.com,
        linux-kernel@vger.kernel.org, git@amd.com, wsa@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, dlemoal@kernel.org,
        michal.simek@amd.com, sebastian.reichel@collabora.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: add reset-controller property
Message-ID: <20230710-hatchery-pesky-6f837788e576@spud>
References: <20230709172542.1393828-1-piyush.mehta@amd.com>
 <168892849854.136160.7620779203584875736.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hXqBLkZYbGg49ffb"
Content-Disposition: inline
In-Reply-To: <168892849854.136160.7620779203584875736.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hXqBLkZYbGg49ffb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 09, 2023 at 12:48:18PM -0600, Rob Herring wrote:
>=20
> On Sun, 09 Jul 2023 22:55:42 +0530, Piyush Mehta wrote:
> > The reset controller is responsible for managing both device-level rese=
ts
> > and individual PMC (Power Management Controller) block resets.
> >=20
> > To facilitate this functionality reset-controller property is added to =
the
> > firmware device tree binding.
> >=20
> > Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.yaml         | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/f=
irmware/xilinx/xlnx,zynqmp-firmware.yaml:
> Error in referenced schema matching $id: http://devicetree.org/schemas/re=
set/xlnx,zynqmp-reset.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/f=
irmware/xilinx/xlnx,zynqmp-firmware.example.dtb: versal-firmware: reset-con=
troller: False schema does not allow {'compatible': ['xlnx,zynqmp-reset'], =
'#reset-cells': [[1]]}
> 	from schema $id: http://devicetree.org/schemas/firmware/xilinx/xlnx,zynq=
mp-firmware.yaml#
> Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.ex=
ample.dtb: /example-0/versal-firmware/reset-controller: failed to match any=
 schema with compatible: ['xlnx,zynqmp-reset']
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202307=
09172542.1393828-1-piyush.mehta@amd.com
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

When you fix this error, please add an indication of the platform in
question to $subject, "dt-bindings: firmware: add reset-controller property"
sounds like it applies to all firmware bindings..

Cheers,
Conor.

--hXqBLkZYbGg49ffb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKw0pgAKCRB4tDGHoIJi
0rnMAP4vUl3fJNAP7YMUJwwBkLCd2p+d2m74MMytBGPmwWImRQD8DfhzqqPCDxxX
PPaFDCUfBf0If2C2+cGKd2pO2kPGJAc=
=gMVg
-----END PGP SIGNATURE-----

--hXqBLkZYbGg49ffb--
