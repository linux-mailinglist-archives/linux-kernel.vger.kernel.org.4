Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530DB747149
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGDM1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjGDM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291442114;
        Tue,  4 Jul 2023 05:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD3856122F;
        Tue,  4 Jul 2023 12:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DB6C433C7;
        Tue,  4 Jul 2023 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688473570;
        bh=w5Afb4XWjxOhR3PdDC5/dWU4ESSRpE7tbnpWTqpze6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LmBK1ZxKi3vPvuNJFPWoXidDeHkATevaFIYAYB8Exj12AB7CguWsstOl+K5xSR4kE
         kxrJAdfzquoJKGKtFtOa5eweKL+VfDGeMRJOqsC9YX54GEoSmAf3mS4jBIPGJNa84Y
         xU2W+aE/AALQmXi56RJvXv+EHsKNmiUc0KS3f4Q0wLBW43h9S/3g+39kEun9DlhCZ4
         /hDfwrd9rVV1Jz+2zxX3E/kiJ3wBFd9ISxMvaBpsPhLvKzNPBQpoP6653vBmiC+ujY
         EFcCf3SjsHA2spkeqylbJb8UK7qycznK64MZ/dqQvW2QakxmEe1m+uwTdvxqPIOusA
         D/L2bRftQkJUA==
Date:   Tue, 4 Jul 2023 13:26:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RESEND v1 2/2] riscv: dts: starfive: Add spi node for JH7110 SoC
Message-ID: <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-3-william.qiu@starfivetech.com>
 <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OO8jAjJ1e96WJdbG"
Content-Disposition: inline
In-Reply-To: <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
X-Cookie: Memory fault - where am I?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OO8jAjJ1e96WJdbG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 11:39:29AM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2023 11:22, William Qiu wrote:
> > Add spi node for JH7110 SoC.
> >=20
> > Co-developed-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>=20
> Missing SoB.

It's fine not to have a signoff for the codeveloper of codeveloped
patches, see case (a) for the DCO.

--OO8jAjJ1e96WJdbG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSkD9wACgkQJNaLcl1U
h9BTigf+LfNH/CBAYdHfe3VZllj07Uk+C8zJO27te847iom4iGuhCC+jcGSITT+r
u4PaSovtoVAJjyknu8Ns2AuKQDJocuR0qa65kY9Q38AcZhWEDchiZP93cbb/ukN+
9LfbJdhX/H4V2mcsb1m5qX0mmgDm7TFdiwYXn43mamyeV2S9t6mgMAXcs7emO4Q/
ZvKpAAVWi77lhHDqU5vCu7vywRdUIXWcDxHMzzvRySIKeqlPwHZpVxRfASMhy7ty
OggCESMVtDcJRCG5x9EO7HbLAuDfNX5KDAcDlGZWYgNMu3FpTe4zkPknDWhN9Bm7
gQPUvZVzPu0+Q3YvijgMyNP5VfM4mQ==
=5CMq
-----END PGP SIGNATURE-----

--OO8jAjJ1e96WJdbG--
