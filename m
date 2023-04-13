Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575566E0BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjDMK7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjDMK7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:59:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FF6186;
        Thu, 13 Apr 2023 03:59:46 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 534171C0AB2; Thu, 13 Apr 2023 12:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681383585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRSK3E8Kl5/8z1piUAcGPRfayyNOWbZ+bT6QSdYKONg=;
        b=LjeTjTTVcnrJJlQRfPyGyFD/CUImjye9iew8VUm3ePym5yz99qw+obRZLFlyh4mV4w8KxK
        Ajry4pl2Kay9ICKw1TpYRIwjuemkQ3d5A2C86OF5uwiHn12G5+CUlya9dBjfXqg47Zg+mb
        2UDu1yOBggVVuYp9i2+eXHKtIEzZnlQ=
Date:   Thu, 13 Apr 2023 12:59:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 5/7] leds: leds-mt6323: Drop MT6323_ prefix from
 macros and defines
Message-ID: <ZDfgoDERkoQhb8cO@duo.ucw.cz>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
 <20230412153310.241046-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nSL+mJlc+nVyvJtD"
Content-Disposition: inline
In-Reply-To: <20230412153310.241046-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nSL+mJlc+nVyvJtD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2023-04-12 17:33:08, AngeloGioacchino Del Regno wrote:
> This renames all definitions and macros to drop the MT6323_ prefix,
> since it is now possible to easily add support to more PMICs in
> this driver.
> While at it, also fix related formatting where possible.
>=20
> This commit brings no functional changes.
>=20
> Signed-off-by: AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com>

4,5: Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--nSL+mJlc+nVyvJtD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDfgoAAKCRAw5/Bqldv6
8ne3AJ0b6283xdNW8QUAldXKyT4W2792EACfbzA/yFwIaU6k8PWKzRoapKW1eBQ=
=3u/N
-----END PGP SIGNATURE-----

--nSL+mJlc+nVyvJtD--
