Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BE72CCF3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjFLRf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbjFLRfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE27C297E;
        Mon, 12 Jun 2023 10:34:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B800612A5;
        Mon, 12 Jun 2023 17:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82225C433D2;
        Mon, 12 Jun 2023 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686591283;
        bh=krvfK0/q6PmPdvzX+Hdeinv7nYJ3LKMoC434Ebw/YGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daEMvXEFNX5MsuOFcFsYRewvi2fCkfEzBJe5grsXSO+Dhu0/nUfssYuOBxn3KagFc
         D3YdhRxV/+KL9OoY4uscICNCiWsQ1vJ+2t8w4K9EQS9KHFW6mEPiLr+t4McjDdm4jo
         px0VI7+MLXCfb/06ZasT0YlPEoVUxu1xrI1t8Hvk/fdfHEiY8UStLOefgCjl/iAs5e
         QG1CDnSUmhLOvmdIXGlEQQTY+4jGKThYmXzzQfhWBhcV8RChk2LKRgBddjMlxKaMvn
         RbAhJmtM7TuNbFz8RYkH3s5CnGDErhO1sZHsfgozlCOgavCjjZ80xT/osG2uQRt5GZ
         gydN/i3jNJASA==
Date:   Mon, 12 Jun 2023 18:34:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
Message-ID: <20230612-ardently-undertow-5060562a6c7a@spud>
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-4-wenst@chromium.org>
 <20230609-unpaved-propeller-b361fba89913@spud>
 <20230610-bucket-rebuttal-c7c44c5b0a66@spud>
 <CAGXv+5EcXW8P-EuWZp4MFUFAjaNTzEtRP_d8bkrFyPdq2k2Bqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sGt7s4jlNXh0bRiH"
Content-Disposition: inline
In-Reply-To: <CAGXv+5EcXW8P-EuWZp4MFUFAjaNTzEtRP_d8bkrFyPdq2k2Bqw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sGt7s4jlNXh0bRiH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 12:19:01PM +0800, Chen-Yu Tsai wrote:
> On Sat, Jun 10, 2023 at 11:28=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:

> > Ah, I see in the binding commit there's a "Luckily no device tree actua=
lly
> > uses them." Does that just cover the kernel, or does it consider other
> > operating systems/bootloaders?
>=20
> That comment covers the upstream kernel and the downstream ChromeOS kernel
> specifically. The bootloader that ChromeOS uses (coreboot) doesn't use
> device trees. I don't know what MediaTek uses for their phones though.
>=20
> AFAIK MediaTek only supports the Linux kernel, be it for Android or Chrom=
eOS.
> There's not a large community around it, unlike some of the other ARM SoC=
s.
>=20
> I did find an old v4.4 Android kernel [1] for the MediaTek Helio P60
> (MT6771) that is also paired with MT6358. There are no device tree
> references to the VCN33 regulator either. Only the definition exists
> in the mt6358.dtsi file, much like what we have upstream.
>=20
> As far as the regulator driver goes, if it can't find a matching regulator
> node, it's the same as if the node doesn't exist, and therefore the given
> constraints are not ingested. If no constraints are ingested that can
> turn it on, and no consumer references to enable it either, we can say
> that the regulator is effectively unused.

Okay, that sounds reasonable. Seems like you've done your research,
so thanks for that!


--sGt7s4jlNXh0bRiH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIdXLQAKCRB4tDGHoIJi
0rA9AQDwMUmhZfjdCs786HEk1DGNkXy1ugjH0Nc6pP0ntHEGHgEAupMpRQXYl1g0
kmfIm+oR6urnbBisNHxTkzBCjokx4g4=
=BCFa
-----END PGP SIGNATURE-----

--sGt7s4jlNXh0bRiH--
