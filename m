Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5259F74107F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjF1LzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjF1Lyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:54:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D12D58;
        Wed, 28 Jun 2023 04:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80DFA612A5;
        Wed, 28 Jun 2023 11:54:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0578C433C8;
        Wed, 28 Jun 2023 11:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687953291;
        bh=q1YOv3qNdA94MZ7eXuxfh/I9kDvs9oI0q4Kqi3B5xWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IXeRQ+EPmw8uIVJUyixWgarA31XTlKMjJjTq1xQdcH04jBwiX0bkTjk0LqFT2zHw4
         s0alkDEocQ1d9Y6/L64SJjXvqgfdG2DR2ikXVQoYngEkLjjG5cQve3pNsKQSYfcBKZ
         4czkWI19C1UkfT/KHIBZhpyZqc2eHlvpDS55peDl0mwQieUmlpFQaO53Kqq+jyhfB7
         dCD/VfSi1sDx6xjOP4Kqd8qb8SUsZ2LURYnDYFMTW1onfxSPTq2J2ICN0DK97iAove
         2FLmu4425Fzy/lEFGsF/pV8LrRqGIggSEvhhKb5h+H8ppzNsLCj2WSZgQosuXgaNGE
         P75NH4inn4DUQ==
Date:   Wed, 28 Jun 2023 12:54:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     shawnguo@kernel.org,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, "festevam@gmail.com" <festevam@gmail.com>,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer
 length
Message-ID: <d1227506-e9b0-4f75-a63b-e25e0c621c48@sirena.org.uk>
References: <CAB3BuKAVzXWNNiYDceNCpBqBmKyEykKA3rX=cfTyz+gWaJcnkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wUyQV1ZJoE1X237c"
Content-Disposition: inline
In-Reply-To: <CAB3BuKAVzXWNNiYDceNCpBqBmKyEykKA3rX=cfTyz+gWaJcnkA@mail.gmail.com>
X-Cookie: HELLO, everybody, I'm a HUMAN!!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wUyQV1ZJoE1X237c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 10:41:27AM +0200, Stefan Moring wrote:

>   ctrl |= (spi_imx->slave_burst * 8 - 1)
>   << MX51_ECSPI_CTRL_BL_OFFSET;
> - else
> - ctrl |= (spi_imx->bits_per_word - 1)
> - << MX51_ECSPI_CTRL_BL_OFFSET;
> + else {
> + if (spi_imx->count >= 512)
> + ctrl |= 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;

Your patch is completely mangled and so can't be applied - please check
your setup for sending things.

--wUyQV1ZJoE1X237c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmScH4IACgkQJNaLcl1U
h9DQzgf/dC5AgapiZMe29pBNUzhmKQsw7kc3rOFRxfBEJ07hsg00h7TdWqyZZ9hu
xrNYElw/ImbNHoNnaErxnIeaFBnhq0tJg4djq30Ts9JPuDOayd9xU5fj9/nXfTv6
r3pawqDMqM+IGSS0kJmg+Phwo7ABMfenLhvmMafDmcoWNpPZ8CWe2/yfaPrLUPVM
nDtXFysFrUPfdMeppniTkz3wuukGQIi52gD7nUoOYjQlV/1s0Xhbsi3crvFLVwdt
t32htz7tzbj8YMUbpv3HB014aNRUxyQ7sVB9wAxcQ+A4B5h0QiQvdP3V2OEhSYtE
cuByQrnsb5Mv+mBCjQ7pVl23/S9FgQ==
=6ueh
-----END PGP SIGNATURE-----

--wUyQV1ZJoE1X237c--
