Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDE16FE912
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 03:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjEKBLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 21:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEKBLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 21:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982E112B;
        Wed, 10 May 2023 18:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F265F640EF;
        Thu, 11 May 2023 01:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC468C433D2;
        Thu, 11 May 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683767500;
        bh=M9+WbndZqXjkrw+21DO8YKqOQHdc/suzPYKkitzNKlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjtkEhyYGHIKo2TpcTt5re5oaA6f/6cH7RQLUZm9PY5kI6YvvCNnU1eiyAzwO1amW
         KNb3jYOdqygO8hsd1zOEQ7Z8+H1PhCOBC6jQEFOfynZp/hk7mfXL94XwoNyLr7Db/V
         sWOvXboJyR7S6GF3/lmtf2zZsZin/0cZf0XU4x1xtmQW2gWlYXYTO52hy7wR1Zpq1t
         Ukj5M84eN8it2jp3E0Z3q7lU/vxe4sKWqa7Y6Z1gXnaWBxSW0LNu/06Jralk/P5j9B
         d1D4G2k/LS4K8FUCI8dJMXMV3/dhUU7OFdghiXsuiI+Md5tbo9aZE5tUy52tyasFBR
         oVqlTFR/DYBwg==
Date:   Thu, 11 May 2023 10:11:37 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Message-ID: <ZFxAyeOteYo6nGlU@finisterre.sirena.org.uk>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <20230509-marxism-plug-759c99ac601c@spud>
 <f38b984c-e49a-0686-a907-5d86ea93d7bc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dVKFyKievi3KFxqa"
Content-Disposition: inline
In-Reply-To: <f38b984c-e49a-0686-a907-5d86ea93d7bc@linaro.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dVKFyKievi3KFxqa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 09:51:50AM +0200, Krzysztof Kozlowski wrote:
> On 09/05/2023 20:25, Conor Dooley wrote:
> > On Tue, May 09, 2023 at 06:38:27PM +0200, Martin Povi=C5=A1er wrote:

> >> +        00: 8.4 V Full-Scale Gain Mapping
> >> +        01: 12.6 V Full-Scale Gain Mapping
> >> +        10: 14 V Full-Scale Gain Mapping
> >> +        11: 15 V Full-Scale Gain Mapping

> > Putting register values into the DT does not seem correct, although
> > I know nothing about sound and will have to defer to Krzysztof & Co. on
> > that front.

> Depends whether these are really voltages or something else (e.g. gain)
> just related to voltage.

They are configuring the voltage range that the output will generate.

--dVKFyKievi3KFxqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRcQMUACgkQJNaLcl1U
h9Am9gf/eDLq7JsOkXRtURy4HihqO7yPqu3e2S1JEHN+SQ+UjhTk6j7moRz3Ou5V
Jjs+HhwX+qGWzPfogrNZ/ehao/dQ1ztZUdUIAhYVuGLCsWK2cm874fo5Epyk6pNx
Cjyyq3QqMiarq67+1Qb7zTj6IRVkLccKa0NneZG6+6xwJKYNltPuCm0x9gSajE9S
YbGwNzraPv1divCYpxxaJbsM9nxStNqrVh8M7oENo2tBnvxkgE2XdHhhr/Kag2Lr
QV1SPOOvcQJStFp7+jzw91NsmWahwagu3dQd83hk+hfZ/fyBv13jOFbNfJ0iXGAl
EZtXHVCvKXztB9LCPFE5rRk3W4jKKA==
=sDMR
-----END PGP SIGNATURE-----

--dVKFyKievi3KFxqa--
