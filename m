Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0C06E0BBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjDMKsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbjDMKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:48:22 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6AA25C;
        Thu, 13 Apr 2023 03:47:56 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1C4611C0AB2; Thu, 13 Apr 2023 12:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681382871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GaICdUhTrdW8msGc/teUrPPVU5nEdQr+/RnX/1kxoqg=;
        b=OrM1r28tp3q+WpY2mygdm6kfgJmi3iLfNFh08tehdsqY2l+I7F2/frwWb7bBLfjeycSe15
        eR+H9PD0sBp9c/KqOkCRXbuWdydiItsyCK1yMi+cEAc9f/8dmptUVDl8nh8Le3INaPqpUn
        v/KDmhVkTXh/15LG6F1mENWJTv3MH4s=
Date:   Thu, 13 Apr 2023 12:47:50 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/7] dt-bindings: leds: leds-mt6323: Document mt6332
 compatible
Message-ID: <ZDfd1jutBeuJhk/R@duo.ucw.cz>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JsiLXC6MGPwjPQAP"
Content-Disposition: inline
In-Reply-To: <20230412153310.241046-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JsiLXC6MGPwjPQAP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-04-12 17:33:05, AngeloGioacchino Del Regno wrote:
> Add support for MT6332 LEDs/WLEDs with compatible "mediatek,mt6332-led".
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

1,2: I'd not mind them merged into single patch.

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,
									Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--JsiLXC6MGPwjPQAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfd1gAKCRAw5/Bqldv6
8t9nAJ9acR9003RcdeYoSBiGIuiGoFEn/wCeN2Ei2RynFMkjHD+HdevILECr/ps=
=hAqz
-----END PGP SIGNATURE-----

--JsiLXC6MGPwjPQAP--
