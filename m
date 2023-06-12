Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6428A72CC65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbjFLRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbjFLRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F51739;
        Mon, 12 Jun 2023 10:24:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 833B062C1D;
        Mon, 12 Jun 2023 17:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBDCC4339B;
        Mon, 12 Jun 2023 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686590692;
        bh=ZviscbX9M2rOxWTwPjv7UOibrGDjoVPRxgUStOnIxnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uEC7H107ndGmqemB+0KODTu0C4q45ijuTj7sKRu4oaSo1xO0l33rwXm2x1fe3iUK3
         vaHfGRgRJyXWHIv2ZsCx99VhKk/6qPuoaq0GZJdnKxcyeU+YGAMNYAeuVcF7ye0PrB
         X+VDip1uveaMXMPHC4XX3kbQMjDHVpGpoCPFGmJ+5tbz0v/0Sl3red4JJs8vZYFkXF
         vNWje+yvpj3sCg9CPVUHqn4H8VGXYJ/B19rWgFGEyiwuD019FbQBuSzCBpw4T/Osfy
         vsspcQdaRfJNpT/I9FmBUfVkQ62VcmYVERp0+0grmuMc4Og8MaP1IeYT52xsqyvX+S
         0gOeZorOkFx7w==
Date:   Mon, 12 Jun 2023 18:24:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     YingKun Meng <mengyingkun@loongson.cn>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [ PATCH v2 3/3] ASoC: dt-bindings: Add support for Loongson
 audio card
Message-ID: <20230612-booted-french-186dd95e78a9@spud>
References: <20230612085614.3039498-1-mengyingkun@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6d68HPAgsdFO37XF"
Content-Disposition: inline
In-Reply-To: <20230612085614.3039498-1-mengyingkun@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6d68HPAgsdFO37XF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

On Mon, Jun 12, 2023 at 04:56:14PM +0800, YingKun Meng wrote:
> From: Yingkun Meng <mengyingkun@loongson.cn>
>=20
> The audio card uses loongson I2S controller present in
> 7axxx/2kxxx chips to transfer audio data.
>=20
> On loongson platform, the chip has only one I2S controller.
>=20
> Signed-off-by: Yingkun Meng <mengyingkun@loongson.cn>

I got 2 copies of this patch, but none of the rest of the series appears
to be threaded with it.

>  .../sound/loongson,ls-audio-card.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/loongson,ls-a=
udio-card.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/sound/loongson,ls-audio-ca=
rd.yaml b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.ya=
ml
> new file mode 100644
> index 000000000000..61e8babed402
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/loongson,ls-audio-card.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/loongson,ls-audio-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson 7axxx/2kxxx ASoC audio sound card driver
> +
> +maintainers:
> +  - Yingkun Meng <mengyingkun@loongson.cn>
> +
> +description:
> +  The binding describes the sound card present in loongson
> +  7axxx/2kxxx platform. The sound card is an ASoC component
> +  which uses Loongson I2S controller to transfer the audio data.
> +
> +properties:
> +  compatible:
> +    const: loongson,ls-audio-card

Reviewing sound stuff is beyond my pay grade, so forgive me if I am off
the rails here, but this (and the "x"s in the description) look a bit
odd. Recently, we've noticed quite a few loongson dt-bindings attempting
to use a single compatible for many different chips.
Usually you have individual compatibles for the various SoCs with this
core, which can fall back to a generic one, rather than just adding a
generic compatible for all devices.
As far as I know, there's several SoCs fitting 2kxxx, and the format
being used elsewhere is "loongson,ls2k1000" etc.

Cheers,
Conor.


--6d68HPAgsdFO37XF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIdU4AAKCRB4tDGHoIJi
0pvPAQDLOvIKZkTAaQl0HQVvqkzTD2ZIBpWC2JkPUbpettjwcwD/ScIh+4m599jA
XPMYLPRh5o1a5CxmAICrIt+p4avOIAU=
=D7u/
-----END PGP SIGNATURE-----

--6d68HPAgsdFO37XF--
