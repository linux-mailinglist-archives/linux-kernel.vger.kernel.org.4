Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01216D09A3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjC3PcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjC3Pb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:31:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B207B7EC4;
        Thu, 30 Mar 2023 08:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29088620BE;
        Thu, 30 Mar 2023 15:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9F6C433A0;
        Thu, 30 Mar 2023 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680190295;
        bh=zWpYYIuYTJgHtpRIFKGjq97qGd3ak9fMCXilbjSs6k8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CeZlAwWxbJ/bSZ4un7FNN3IwfDFkF57yLnYL5VB3GqWTc+RtBL1ZbCJKgkCiCyhCe
         W9bxnsrfYa3nY8YragtJajwGpLOlNq8xCJ1l6N5NW+wggEG2DHJN+mIHJi4BYBgAKi
         X+3u/R3OTq8wo6QU2I82zI6SaRv2we2sUxJkjfTHyldFPo0uefwu6seN2mMgB/LWTN
         lZ2HHx84EA4CQrTwxkVnV2r6HHpn4QGib1M01Jyr8EQTyF+xGTfknYGoRuej3EV4v4
         CM90jK5JiAUGUPj40gfJQsD/wZjyqbdCQ7dOed1fdDTIvoUVFSQYUscQs+BAtuLdYh
         xmrs4ZPpbL+TQ==
Date:   Thu, 30 Mar 2023 16:31:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 3/3] riscv: dts: starfive: add tdm node and sound card
Message-ID: <0d108d6c-e892-418b-b9af-6c2dd133dd71@spud>
References: <20230329153320.31390-1-walker.chen@starfivetech.com>
 <20230329153320.31390-4-walker.chen@starfivetech.com>
 <d455a90a-7e63-2254-75cb-70cb26ae7483@linaro.org>
 <af015701-f1ff-4b1e-9b1b-c635fc684ce6@spud>
 <2d5a8dae-73fd-b1f8-089e-041637d66b0d@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="524gvXDbAwMwRBbT"
Content-Disposition: inline
In-Reply-To: <2d5a8dae-73fd-b1f8-089e-041637d66b0d@starfivetech.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--524gvXDbAwMwRBbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2023 at 11:16:08PM +0800, Walker Chen wrote:
> On 2023/3/30 15:58, Conor Dooley wrote:

> > Excuse me for not following here, but Walker, could you point me at
> > where in the schematic for the VisionFive 2 that this wm8960 actually
> > is?
> > I know ~nothing about audio, but good old Google tells me that this is a
> > dedicated codec chip and I was looking at [1] and could not easily find
> > it on the schematic.

> > 1 https://doc-en.rvspace.org/VisionFive2/PDF/SCH_RV002_V1.2A_20221216.p=
df

> The TDM need work together with external codec WM8960 by plugging the ras=
pberry pie
>  audio board into the 40-pin, which is found in sheet 21 of the schematic=
=2E Because the
>  40-pin of VisionFive2 is fully compatible with the pins of Raspberry pie=
 audio board.=20
>=20
> For more information of the audio board, you can take a look at the follo=
wing webpage:
> https://wiki.seeedstudio.com/ReSpeaker_2_Mics_Pi_HAT/
>=20
> The schematic of audio board:
> https://files.seeedstudio.com/wiki/MIC_HATv1.0_for_raspberrypi/src/ReSpea=
ker%202-Mics%20Pi%20HAT_SCH.pdf

Ahh, I feared that this was the case. If it's not on the board, then it
shouldn't be in the dts (and certainly nothing should be in
jh7110.dtsi!).
I suppose this should be a dt-overlay, but I don't know anything about
the upstream infrastructure for those. Nor do I know what is permitted
in terms of overlays.

Thanks,
Conor.

--524gvXDbAwMwRBbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCWrTgAKCRB4tDGHoIJi
0thyAP9IOF81Os1a6pA5/JU5Af3gbxCn4Cc3tX9CYpHYnbRm9gD/VG+H1kKtvfr1
pLpzYaEOOfN3raDJEzVDTJIcLmCSJwg=
=ORTa
-----END PGP SIGNATURE-----

--524gvXDbAwMwRBbT--
