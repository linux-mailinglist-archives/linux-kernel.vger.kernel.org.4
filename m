Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE1073A110
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 14:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjFVMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 08:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjFVMhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 08:37:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4791BD3;
        Thu, 22 Jun 2023 05:37:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9830C6182E;
        Thu, 22 Jun 2023 12:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FDAC433C0;
        Thu, 22 Jun 2023 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687437445;
        bh=9XaDF2RthAQmdrdmCFkOGNNhCvKsp8J7wQuzuY1Xzo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3iA/PY3K0c6DyMFWt2N6acw8dbrWe9b/FUCoSWn4IOy2pW78FRVUT+p5lRksAhy/
         WGPLppGW/kvP9UIxIljb4+YKWK9tDkBu+Pjr1JxFuBh5f5bDxDRdStXNdWxJxGYR9R
         2R2psweZ+UruqniqSldMKCtuHpnsb7ILxh66sytQB4wsvKpbAxt9+voBe3++hkvVE7
         NIVHExjtdRq0EqvHD047wxTz8hqEmtQP55UNdeTuwB1OxBpbDgzky/xfr4bpGOGGaR
         wwIZQH/WpU2I1oA4Yg443+zJoYYiC0Se7HpZG4h5hfxmtULzRUoYa1YYIrNOl+Vxm6
         QQ3cH0sGUwkvg==
Date:   Thu, 22 Jun 2023 13:37:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 07/13] minmax: Introduce {min,max}_array()
Message-ID: <16fd9b2e-bb57-4833-a79f-e2cec3b8635a@sirena.org.uk>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-8-herve.codina@bootlin.com>
 <70697b976107473b8779eea7d6c8a189@AcuMS.aculab.com>
 <20230622143233.7300a813@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gEIzLdQpVdT262K/"
Content-Disposition: inline
In-Reply-To: <20230622143233.7300a813@bootlin.com>
X-Cookie: Please ignore previous fortune.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gEIzLdQpVdT262K/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 22, 2023 at 02:32:33PM +0200, Herve Codina wrote:

> Is it ok for you if we keep as it ?

I think any issues here can be addressed incrementally rather than
holding up the rest of the series.

--gEIzLdQpVdT262K/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSUQH0ACgkQJNaLcl1U
h9D77gf/WZKuHeud9npCKNm315R9EOMXA2ffWN2OykjOoq74ujmcoqY53KEBaRWp
PJQarOs2YWJvoFTo4xqTNy1nkSxEjgw+aYk8jq21txGWU36YzQwuDAQZRvdkVxlJ
gwxzRvrGlJf9i1G3peKn4SWSoSmuyz974T4YiOcs1tqrPi1BVRHjRJmDgdyysDWk
rVY4DaBH+TzMR30K621RWC/8PUY2AG9LhMcO1g5TUmmkx7uNaOb1/U9hwXWTAaUP
MzURE0Map8d4wYa9li6pCSPhQ0egfE5gX9URMon5APX+ai6MAm1rkyr+2x/5MyDx
6lZDCohWYdGVRtQRDVL03GUIdONLwg==
=FIdM
-----END PGP SIGNATURE-----

--gEIzLdQpVdT262K/--
