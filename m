Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B6F5B59AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiILLww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiILLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:52:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680921DA54;
        Mon, 12 Sep 2022 04:52:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 037DB611CF;
        Mon, 12 Sep 2022 11:52:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA9C433C1;
        Mon, 12 Sep 2022 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983566;
        bh=AvA6TgPUAVeyXLqYp+8Bg4Oa2Z6Als9d4E+bEmPak0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZM0/drk+x0laRAb59LlFYkv6q5lTomulnBKT1HsEcB43LFDNJwPfNPbDjWnHDPzi
         RwDZABlj4xgXfi7MmWA0qn92sumOh3IAcLL0RN+7OnntmFElFj990/TZKbnj9K9Dv5
         wfnoTx9yc33qw8zzeNakcZWiLEvV5ytVS2LNmvJfCLu8NjCuw9DWT/Nsd8vUhylkLa
         LuZCtQtHZwlrxuN8SSMfWy62JPnha2LPZa++3+hRjac2Un6MP0v7umWZXq+73g0qDR
         WcCGg6S+ssMSKy3GhN2mTtpp8aZBPhmEANjBKGUJynRwNRGF7VPaGEwgWSQ3OFsQjf
         JMq/0PxULG+mw==
Date:   Mon, 12 Sep 2022 12:52:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, chin-ting_kuo@aspeedtech.com,
        clg@kaod.org, joel@jms.id.au, andrew@aj.id.au,
        kdasu.kdev@gmail.com, fancer.lancer@gmail.com, han.xu@nxp.com,
        john.garry@huawei.com, matthias.bgg@gmail.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        haibo.chen@nxp.com, yogeshgaur.83@gmail.com, heiko@sntech.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        michal.simek@xilinx.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
Message-ID: <Yx8didL1aFc4XxGa@sirena.org.uk>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tsMpd7wbAJx2xcTL"
Content-Disposition: inline
In-Reply-To: <20220911174551.653599-1-sergiu.moga@microchip.com>
X-Cookie: One FISHWICH coming up!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tsMpd7wbAJx2xcTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 11, 2022 at 08:45:53PM +0300, Sergiu Moga wrote:
> In order to properly represent the hardware functionality
> in the core, avoid reconverting the number of dummy cycles
> to the number of bytes and only work with the former.
> Instead, let the drivers that do need this conversion do
> it themselves.

Acked-by: Mark Brown <broonie@kernel.org>

If this gets applied it might be good to have a tag in case we
need it for any SPI updates.

--tsMpd7wbAJx2xcTL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMfHYUACgkQJNaLcl1U
h9BR0ggAgkV1J8/o/vgLngoRQlQriv74OFxhNN5+lL+Ue4so/rZcuKbaX7fW6yVN
5WwRPm0joSHJslzR37N/Q1ajnX5ZooQm33WIVzToQBU0liUpwIC9pn84Em0ebD1T
yRd21CVYYsPcwrRr3STSzjZpMq+CRQMfe4hvBOHirS+hQqQ9gnfpQ6NJyhkF4w6P
rUiOb9TYvfLqi8usgPC20TbdPjQxz+a3LoKzZokU2CgnnjSTUTRHf9BfCfuyOqZE
18MRkCDY7zUwO7D580ojgXe0kAAIQIxaN4QAZSG6e/hC9BziHeHJOMua0S56E4Xw
WIP/Lcq6BWueOZUfZglx7aACizALEA==
=BL9e
-----END PGP SIGNATURE-----

--tsMpd7wbAJx2xcTL--
