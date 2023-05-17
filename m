Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF824706F6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 19:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEQR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEQR3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 13:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A8D9037;
        Wed, 17 May 2023 10:28:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2B7A6498B;
        Wed, 17 May 2023 17:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3619C4339B;
        Wed, 17 May 2023 17:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684344523;
        bh=C3rhU6ql3cfx2nqHQAamUs5eDbPSPa+ws3rxF+aWa1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RD5m7lY8p7R/XOcqyBVFFZfqAIWQot+4Wz9y1pVEPguZz2/zJZLnuJutREWwZWyNY
         8dvbV1paGoF2P0cxi6Uhrp5PFkO1JcmumAbu0u+pR+SmGiC96WQYfYVph3FNqAyNJO
         g8+KA1tA0og4KZkEz20nLQ6lUA4RKKJ6JKWYCuSSoKkLOb7jU/skUjv2Sq9R7JC12Y
         k6wrrngs03G61v7aIAMQsOHNgQxLFr/Av1eu2qQt6F99nsjB89kk8KazKnTkI3+bzA
         0ttHn01LOdkGQ/rvn9VobAo0bcVV9/GLcaQWQ0AhBh8CG/27P16Ji+ywYPDyAASVPX
         W5hLvuK5Yeb2w==
Date:   Wed, 17 May 2023 18:28:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Alexandre Bailon <abailon@baylibre.com>, airlied@gmail.com,
        daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, sumit.semwal@linaro.org,
        christian.koenig@amd.com, jstephan@baylibre.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, khilman@baylibre.com,
        nbelin@baylibre.com, bero@baylibre.com
Subject: Re: [PATCH 7/7] dt-bindings: Add bidings for mtk,apu-drm
Message-ID: <20230517-deceptive-filtrate-9acd07071371@spud>
References: <20230517145237.295461-1-abailon@baylibre.com>
 <20230517145237.295461-8-abailon@baylibre.com>
 <c32f0c3f-b43a-7045-38cc-2c11c7bb571e@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DPep3TX9ZmccIKnm"
Content-Disposition: inline
In-Reply-To: <c32f0c3f-b43a-7045-38cc-2c11c7bb571e@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DPep3TX9ZmccIKnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 05:04:00PM +0200, AngeloGioacchino Del Regno wrote:
> Il 17/05/23 16:52, Alexandre Bailon ha scritto:
> > This adds the device tree bindings for the APU DRM driver.
> >=20
> > Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> > Reviewed-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >   .../devicetree/bindings/gpu/mtk,apu-drm.yaml  | 38 +++++++++++++++++++
>=20
> mediatek,mt(model)-apu.yaml
>=20
> >   1 file changed, 38 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/gpu/mtk,apu-drm.=
yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml b/D=
ocumentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> > new file mode 100644
> > index 000000000000..6f432d3ea478
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/gpu/mtk,apu-drm.yaml
> > @@ -0,0 +1,38 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/gpu/mediatek,apu-drm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AI Processor Unit DRM
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,apu-drm
>=20
> const: mediatek,mt8195-apu (or whatever else).

Aye, and drop the references to DRM in the title field too (and add the
vendor name?).

>=20
> ...besides, I don't think that this patch even belongs to this series? :-)
> Spoiler alert! :-)

Well, I do not know what this means - but if it is being respun as part
of some other work, a description field should be added to the binding.

Cheers,
Conor.


--DPep3TX9ZmccIKnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGUOxAAKCRB4tDGHoIJi
0tq/AQCEx0ykFfDTB4Fn6jIhxnkBk2YlIWinWZykIWz+PlyIaQD7B+GkFiVdN1GH
F6vvIFXtMcll02nyunl0Xx5gYXvbzAQ=
=+2H9
-----END PGP SIGNATURE-----

--DPep3TX9ZmccIKnm--
