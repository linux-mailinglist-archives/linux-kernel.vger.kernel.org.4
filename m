Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D202B7473CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjGDONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjGDON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:13:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9325E10D5;
        Tue,  4 Jul 2023 07:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208A3611DB;
        Tue,  4 Jul 2023 14:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E98C433C8;
        Tue,  4 Jul 2023 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688480003;
        bh=Nk5zRQ565eWa3r6Bd86j1AJU+hDJ5pUdhSqyH4FS99E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HctInVLn9PWcYJ5WhvvFXsWezBRvc5bRarfoujy6BErf4LVVxPqkU/4CBRX+T8njc
         H8d3k6lSBsCCrZhOLMZvSAMlkL+RnMxbyLWt3Ng5GyfWd32lq9N+rvwcu4TRQnG+Eb
         7Sg7jRLlI4m/qJ445cqtASjKBSV6SLgLfcGD/8W2c8QdvYaCshqZAJVEp6x263tlzU
         1L9yE3PmU/eaVlCXIP9ptrS6SgyQ3KewLWvd2hc3JIMjIRMi0BMAevu89+CEk3CfIB
         nQimzoztuJuII00XmJuYTptsyzPIlRR+kMmFxKs9QgWpVYEMbrxlOJ91YJisnKpKPe
         20fHdfTJlDZZg==
Date:   Tue, 4 Jul 2023 15:13:17 +0100
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
Message-ID: <41c905da-ae3e-4acb-bbfa-d33d3306824d@sirena.org.uk>
References: <20230704092200.85401-1-william.qiu@starfivetech.com>
 <20230704092200.85401-3-william.qiu@starfivetech.com>
 <7f3b600d-d315-22d6-b987-eabfe1b04fdf@linaro.org>
 <eba1e868-6371-42fe-91be-bcbee54d1aff@sirena.org.uk>
 <4afd90d9-f1bd-f40d-1c79-50fef1406ab7@linaro.org>
 <6307c5b2-64d2-405f-b1a5-696d4184f6a0@sirena.org.uk>
 <a8c1a5e7-9938-bf6c-6bb7-6c1e4d8ce08b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8SqqqwgXKD0N3HXB"
Content-Disposition: inline
In-Reply-To: <a8c1a5e7-9938-bf6c-6bb7-6c1e4d8ce08b@linaro.org>
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


--8SqqqwgXKD0N3HXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2023 at 03:21:30PM +0200, Krzysztof Kozlowski wrote:
> On 04/07/2023 15:16, Mark Brown wrote:
> > On Tue, Jul 04, 2023 at 02:27:57PM +0200, Krzysztof Kozlowski wrote:

> >> Also see:
> >> "every Co-developed-by: must be immediately
> >> followed by a Signed-off-by: of the associated co-author."

> >> https://elixir.bootlin.com/linux/v6.4/source/Documentation/process/submitting-patches.rst#L467

> > Oh, that seems unhelpful especially with it not lining up with the DCO.

> I assume the intention was here that if I attribute some co-author with
> Co-developed-by, then I know that author, therefore I expect author to
> explicitly participate in DCO chain.

Why?  They're not the one sending the patch out, nor are they relying on
someone else having certified anything.

> Otherwise, just drop the Co-developed-by.

It seems separately useful.

--8SqqqwgXKD0N3HXB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSkKP0ACgkQJNaLcl1U
h9BUCQf+MakDSushGvfaRHCWXKX9k0RiV5f+NZvtmqvrVE86MgvfZXWos/vS+mTd
KY3WC115btHDG+rP5TdrtREdf/CKBvuZ7f/xb7CuzNrkn9cO4luF7qZKb48jqqQY
+66UT0zca96GKUpT2RQ1HR9sMg6umR7qj2RezJOXLBgHMBwAq6aofIIGVcj1tkzi
wKcOeluQX1g96OJjcxo/Kj42y/5kQdhMj6GmbVRoRiiMX2MiXcLbIMh15gtYgfmU
KaP24Oeb9skgN6X8/1hja6swCSqQD2VRbX+aPSYyVncd9uDMx0Ya+7cP14Ex+W8u
37T11N/kr/NhVOEyHpdjM628LNblHQ==
=+ena
-----END PGP SIGNATURE-----

--8SqqqwgXKD0N3HXB--
