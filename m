Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AE372EA81
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjFMSHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjFMSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6B919A8;
        Tue, 13 Jun 2023 11:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2E5632AA;
        Tue, 13 Jun 2023 18:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0DC433D9;
        Tue, 13 Jun 2023 18:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679641;
        bh=sVA1SNUHZ25ExbWIX7Us9rw1rc9saLwiqn/s/BIC9r0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kokQUW6pmOVgkyFnx+zjqdNgvL/LY6vxCZ86eP8pKEvLfRxiwUJf48h0eNnaHNLeh
         YsB4VQSZCxGecSjOwXJvjSbmkDg6Xgm+SJ7mKal0ci1Rb57gcChG3ec4nDgYOQHkI3
         cUT+HDEf/pifAXg7XmGhmtcKYHHk0GEGSCFF8OY6OzWlDIAvVUIg09b/tudoJ/PQGO
         7/U7jtp/KsjjtOkFV9HwuPyxb667Ay8/JVMXVh+poYRQSjnWp5C1hdmuAyf5Ee3P5g
         e+Kmzu9VrjXLygeM7Jbq9ozalrIqO/oz8KoybmFuGXIQQBqundQ1lhlaQYueHBq12P
         RTjAHVHIpuNlA==
Date:   Tue, 13 Jun 2023 19:07:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: adc: add max14001
Message-ID: <20230613-stratus-earthling-601ed4588cdf@spud>
References: <20230613093346.60781-1-kimseer.paller@analog.com>
 <168665154072.1311520.12958978545814613109.robh@kernel.org>
 <8998c3d3f3ca4f44a5c99594dcb24cbe@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aXppyU3Eb1ZEUk4b"
Content-Disposition: inline
In-Reply-To: <8998c3d3f3ca4f44a5c99594dcb24cbe@analog.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aXppyU3Eb1ZEUk4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2023 at 02:07:39PM +0000, Paller, Kim Seer wrote:
> > From: Rob Herring <robh@kernel.org>
> > On Tue, 13 Jun 2023 17:33:45 +0800, Kim Seer Paller wrote:

> > >  .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++=
++

> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-
> > ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml:
> > $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Ind=
icates
> > that the pin should be operating in paired mode.'}] is not of type 'obj=
ect',
> > 'boolean'
> > 	from schema $id:
> > https://urldefense.com/v3/__http://devicetree.org/meta-
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!5MOlRhmYJLqPmhR7QmgutQNBKIuJ
> > Tk_FlMbFGnFd4R9dVxnXWk8rY0woqzhv5YcF58DvBLTrc0FLIB-v$
> >=20
> > doc reference errors (make refcheckdocs):
>=20
> Could the doc reference error also be ignored? I cannot reproduce the sam=
e error on my side.

The whole report from the bot looks unrelated & ignorable.

Cheers,
Conor.

--aXppyU3Eb1ZEUk4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIiwUwAKCRB4tDGHoIJi
0hGWAQDBMUQf5fYToyyK2ziK3qKaIBdkfJFtEBFI7svpxbsacwD/QhE8RvgY8+RI
qe0m5iczkEYJQWWYVqo2kyMiCw5qJgo=
=ULmj
-----END PGP SIGNATURE-----

--aXppyU3Eb1ZEUk4b--
