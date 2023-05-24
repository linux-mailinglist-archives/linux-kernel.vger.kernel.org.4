Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D8C70FFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 23:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjEXVKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 17:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXVKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 17:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9067C1;
        Wed, 24 May 2023 14:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 568A963B6C;
        Wed, 24 May 2023 21:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19329C433D2;
        Wed, 24 May 2023 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684962611;
        bh=Rm7aa8jCsnayHnH8S+h7edpVvvWiw8Tnd4kn30CW0rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTrkFd4LgZgFeHiv/kwY9Irz5GLXBgKptccu0OWya7Ove0pCcBH8VBPNCbmafIAAe
         DBZ/r/5ZFKwDDbe5PGAdj0fOtiRjdkQ2md7KJ2G/rPtHgO3VLOnU8hiMTsusBuUA5K
         r+h5U4mMvFzWwqoTzb8nqIG3OWVpd0LHcgwwcmBRqzPUbAeDmT2R+dTSXoZ0cneLNd
         bUGTYXakBvMxaT08uLDvV+a5bGrN+3Mn/ckp4TTZZGk+GjoBBinjEGARrNIZTANbMJ
         F8TNnirGUyDFNqzItNASn92JR2Hlc4qVnLyBepZxJIxSL6RELiG4AnUWBHRUCSajk2
         xf3h0PgZ+7yMg==
Date:   Wed, 24 May 2023 22:10:06 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Runyang Chen <runyang.chen@mediatek.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: mt8188: add thermal reset
 control bit
Message-ID: <20230524-lividly-bodacious-5247a32ad1ab@spud>
References: <20230524133439.20659-1-runyang.chen@mediatek.com>
 <20230524133439.20659-2-runyang.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ooNPdgsX4foSndKs"
Content-Disposition: inline
In-Reply-To: <20230524133439.20659-2-runyang.chen@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ooNPdgsX4foSndKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 09:34:38PM +0800, Runyang Chen wrote:
> To support reset of infra_ao, add the index of infra_ao reset of thermal
> for MT8188.
>=20
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ooNPdgsX4foSndKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG59LgAKCRB4tDGHoIJi
0q8eAP92XtJeKUaN47himswTBp0HfGAhr8Hue4pXLR1m8cHM6wEA/JsiXDLCWwuW
wPc3e8ewZElnbmlA6QPKkjuWy4BJQAM=
=HPDT
-----END PGP SIGNATURE-----

--ooNPdgsX4foSndKs--
