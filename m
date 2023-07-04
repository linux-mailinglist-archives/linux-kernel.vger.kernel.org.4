Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F82B74727F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGDNRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76F1727;
        Tue,  4 Jul 2023 06:17:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F04E6125F;
        Tue,  4 Jul 2023 13:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4678BC433C7;
        Tue,  4 Jul 2023 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688476578;
        bh=9OfNHl2CO4ROmH3NF/2N3isOj60W98pvOXJYsArljSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ud24Fpvc23yw0jB69LVc1U7yb9UrxAvp/lHgt+t8ji497SVTdEwl+qC4OLtrFszRe
         P+n/mzaNsKgQl/86HJ2Yy5LM9JaO2Jt4eIguPh8zzRHbNeaWf4uGW8YrEs2t98YAgO
         Iv5zTFgpNAB70CuEZzwIpD6C0XVXMJTDlnvAphg6yTOI79tTTqwmoqkr8CR6f4plqv
         DPU3MMjuJczDzz9pTZxp38Ziv+z9GOeQ2e3AswbQx7GqXaiEYq2Zdt5CZBMpo1C+KX
         qcBPmHX3wADJoFjoTfBwca3x8HJsy4BaZQMQL92THTO8Qv9JIEymBGJJnonIkXg6KO
         ANTAVVDkVkbxA==
Date:   Tue, 4 Jul 2023 14:16:13 +0100
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
Message-ID: <6307c5b2-64d2-405f-b1a5-696d4184f6a0@sirena.org.uk>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-3-william.qiu@starfivetech.com>
 <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
 <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
 <4afd90d9-f1bd-f40d-1c79-50fef1406ab7@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aFA/yWSMzb/vdMUW"
Content-Disposition: inline
In-Reply-To: <4afd90d9-f1bd-f40d-1c79-50fef1406ab7@linaro.org>
X-Cookie: Memory fault - where am I?
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aFA/yWSMzb/vdMUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 02:27:57PM +0200, Krzysztof Kozlowski wrote:

> Also see:
> "every Co-developed-by: must be immediately
> followed by a Signed-off-by: of the associated co-author."

> https://elixir.bootlin.com/linux/v6.4/source/Documentation/process/submitting-patches.rst#L467

Oh, that seems unhelpful especially with it not lining up with the DCO.

--aFA/yWSMzb/vdMUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSkG5wACgkQJNaLcl1U
h9CdRgf/YT9C89atfxGy/SpvZXN6BNT9anIKzi+r5u287IcAy7tL5fpweh4KpQH5
I7TRVjyJJiiOAtb1BLxRzPip/o5TEa9QK4zrGJDyQOwpymt9xSjwNhzfsjr+J4dY
yKjbkq5+0s+te5MjqgdSFDjaeofXB5MO6T0YpB5CMhTUnvAyDv63+97PrVnJ/ILH
jHD3a/xvC8lTXEz6N0Tc2QjsRJoJhlYk47zaqqnlTI+Eei8P/NobfTFpUW6b2BJF
kGvTIwJkGuDuVNjjDydp+/m4yKLYeeTettfawSdSDsXGwzA03eAR+Oui4YY3rEoy
6wWtGofRbywYyPDWxHR1zUPgqlUFDg==
=sSlP
-----END PGP SIGNATURE-----

--aFA/yWSMzb/vdMUW--
