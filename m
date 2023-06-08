Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C6F7285BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjFHQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjFHQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:48:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF01FFA;
        Thu,  8 Jun 2023 09:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 720A264F84;
        Thu,  8 Jun 2023 16:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87307C433EF;
        Thu,  8 Jun 2023 16:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686242917;
        bh=NItZle+oTrePZjmBVAT27mVwVfGQfOUwmTs+qmzGn6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuOb+jLe1WtbWqLUUym3QtQf1tvdlFkuQfkXMyt7i0SeMBl4Z5PMy/JBo/3J7StOa
         z13cXGwocgTkgqyZgejt0LSDiFJsSOlThO+7ClDdUklpU8a7ZdYDirSE1H56uiEfQt
         /44/2dX0GDtyh//EgAJRFSLbhXfGUYmEjy1HeV14GEaRd9tJ0mFC+FIWAzKQiW+FkK
         FsKUIo2Yx8vrLWVxJYbaRGLw2Xn5y+2XBhv2JvajneWwp2jVcF/oXznmkX7wCCrDFH
         NP3Otfho+XBrV6YQV8JoN2PDCovVIB2Ij1BdnNlHf7CUrBvaekN5RuTCZgzSmCqmcr
         PYDrrXuIM9eSg==
Date:   Thu, 8 Jun 2023 17:48:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/5] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Message-ID: <20230608-helping-regally-3ce781f6d8ec@spud>
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqm2BrX9NmqPaHSz"
Content-Disposition: inline
In-Reply-To: <20230607205714.510012-3-nfraprado@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqm2BrX9NmqPaHSz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 04:53:39PM -0400, N=EDcolas F. R. A. Prado wrote:
> The binding expects the first register space to be VDEC_SYS. But on
> mt8183, which uses the stateless decoders, this space is used only for
> controlling clocks and resets, which are better described as separate
> clock-controller and reset-controller nodes.
>=20
> In fact, in mt8173's devicetree there are already such separate
> clock-controller nodes, which cause duplicate addresses between the
> vdecsys node and the vcodec node. But for this SoC, since the stateful
> decoder code makes other uses of the VDEC_SYS register space, it's not
> straightforward to remove it.
>=20
> In order to avoid the same address conflict to happen on mt8183,
> since the only current use of the VDEC_SYS register space in
> the driver is to read the status of a clock that indicates the hardware
> is active, remove the VDEC_SYS register space from the binding and
> describe an extra clock that will be used to directly check the hardware
> status.
>=20
> While adding the active clock, split the mt8183 clocks since there are
> less of them than in mt8173. This is done in this same commit to avoid
> changing the number of clocks twice.
>=20
> Also add reg-names to be able to tell that this new register schema is
> used, so the driver can keep backward compatibility.

Rationale here seems to make sense to me & seems like whatever
functionality, or lack thereof, for the mt8183 will be preserved w/ the
old devicetree.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--bqm2BrX9NmqPaHSz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIIGXwAKCRB4tDGHoIJi
0l6GAP9Fj0Yzci2QZFnKHVu1ULZFD8JnPf07oxRvnEiMYMGg6gEAhC1nbdxyRxKx
aw9kQMvf0BpeAZuX8VEoKUTSBCMZAwQ=
=K2/N
-----END PGP SIGNATURE-----

--bqm2BrX9NmqPaHSz--
