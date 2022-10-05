Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD985F5721
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJEPJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJEPJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:09:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF2E6555C;
        Wed,  5 Oct 2022 08:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4FBB81E05;
        Wed,  5 Oct 2022 15:09:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D912C433D7;
        Wed,  5 Oct 2022 15:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664982569;
        bh=t+Sxcbjds/CH5MY19al2gz2FR5p9mkdz/6BYz2fXlU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GEkW8fKbRTjT2keR2zgUqFVMVniZajgccILAJDNGPN9q1zLxzeoJyXaM2GIYjdARI
         Ozed+h8b5er4/cHkEcb795e1xmsc9XDtHevgs0ue8OSaKwGLM8cA5/JpFzdJxbmXy0
         9Bc7kbL6nYDMWWatiSpq6tJ+5ULIn+oG0rPpHF+vrJU+BpC6bFPYVGrbsTYSwiHapL
         vGhSmvbXtZbOhghP1YDe1rdxdUkO70YFxGM3tvXLWKktvgPTRlr79XAL0wRbrXM+IP
         knxKwhSWILClq9WetEPyGBjaH4geInJdsonp7TW36QptFF8/jgWrcjhX+vyb2BS6Xo
         uBOSEsIkk1kJg==
Date:   Wed, 5 Oct 2022 16:09:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
Subject: Re: [PATCH v2 4/5] regulator: add mt6357 regulator
Message-ID: <Yz2eIslwcXKNaOfi@sirena.org.uk>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-4-f17ba2d2d0a9@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ePzzjg1bOlGADoWy"
Content-Disposition: inline
In-Reply-To: <20221005-mt6357-support-v2-4-f17ba2d2d0a9@baylibre.com>
X-Cookie: Poland has gun control.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ePzzjg1bOlGADoWy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2022 at 04:57:24PM +0200, Alexandre Mergnat wrote:

> +static int mt6357_set_voltage_sel(struct regulator_dev *rdev,
> +				  unsigned int selector)
> +{
> +	int idx, ret;
> +	const u32 *pvol;
> +	struct mt6357_regulator_info *info = rdev_get_drvdata(rdev);
> +
> +	pvol = info->index_table;
> +
> +	idx = pvol[selector];
> +	ret = regmap_update_bits(rdev->regmap, info->desc.vsel_reg,
> +				 info->desc.vsel_mask,
> +				 idx << 8);
> +
> +	return ret;
> +}

There's a bunch of other Mediatek drivers doing this and multiple
instances in this driver, the helper should really be factored out.

--ePzzjg1bOlGADoWy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM9niIACgkQJNaLcl1U
h9Dhhwf9EYMAixn0Ds9CE5Jhseu04EmZqy92PGrOBlm9jhRXA4+ZGnFamrEUyk6k
4LfHqEtFGXX7XUsH4OHsp2pJ19RHvzMMPGUAIyKf5IX8wbliO/8HnGy3L/K6a3Bs
mQqG+YisFR1zOlyvZNklAyNXUrGM+uXOniZPpVxH2TOpWUb1rRdEVn4wmsMNZscp
L3dMjRwyW+sqipIIkhInS1IqM7DCy82Kf4cYR4HFUPtD/MDRlY5fCyk65WErjZme
l2jebnqqmEvrWJNrJVN7SJU3LLBr8bdZtLCeLnIwsihBxvRdYTPOPzTllmFr10ZH
wddR1vLT2rhRPqblO03xX3vjGckx5A==
=Y+8N
-----END PGP SIGNATURE-----

--ePzzjg1bOlGADoWy--
