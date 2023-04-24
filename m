Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1FA6ED1C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjDXPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDXPwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:52:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6C4220;
        Mon, 24 Apr 2023 08:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB34062668;
        Mon, 24 Apr 2023 15:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2473C433EF;
        Mon, 24 Apr 2023 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682351550;
        bh=tIkBRGVMTb7SoSEWbdlVZsCl/C1uMyGUVJU2BuewQ28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWhZdZ8J34FPm27UazvVbPEWQuXEnnP1brfPwSoaHZtlzt11rJmsXa5YTO9vplouy
         xVSUL41KIoFF/Idogzw6XtdQtHBU+78yvDWie8vWvSJmsGut7EnAe+02b0MDDBKifP
         YU/aToiV35EvUoktgdsbySdPIgxYI6U/nRT2k5pR8fBIcdJ2BQZnKvSuZC0OudsKkE
         hiLiLmHJhZkAd8rv0eL9NuUXmJr7DXPdaSsV1bYOxvjL1IytBd4kVqV3SCrd1ITjUz
         QwQMPbaiJv4y3ykWaso3+oe8W1MjT6ECPtGTNF2k/QFMBp0B/LJHHc9ANCIjXj69Mz
         Kw40TOOh7u/Ng==
Date:   Mon, 24 Apr 2023 16:52:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Li Ningke <lnk_01@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
Message-ID: <ed846afc-7155-4998-9a8d-e9d9e8aaf8e2@sirena.org.uk>
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
 <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
 <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tBkIGv79VjVWVg47"
Content-Disposition: inline
In-Reply-To: <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tBkIGv79VjVWVg47
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 08:03:42PM +0800, Dongliang Mu wrote:
> On 2023/4/24 19:48, Mark Brown wrote:

> > Is that check valid?  0 was a valid interrupt for some architectures...

> We just follow the comments of platform_get_irq().

> =A0* Gets an IRQ for a platform device and prints an error message if fin=
ding
> the
> =A0* IRQ fails. Device drivers should check the return value for errors s=
o as
> to
> =A0* not pass a negative integer value to the request_irq() APIs.

I'm not sure that's universally true yet, though there were some moves
to try to get us there.  arm, where this driver is used, was one of the
platforms with 0 as a valid interrupt.

--tBkIGv79VjVWVg47
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGpbgACgkQJNaLcl1U
h9BKrgf+MzmPQXRI03PbIw/AXJvnq1pmzIhIqF5rxj/MER/k5heQHCXrGVbDSFe0
28ryYegDEM4MUaL3wvTwyNljKdYnovTPzPCxJDXw3lHkDaK8nL9FwC8feNDdvdXH
EmX3xl2huufP+3Gv7ssOcc+QgF3DOd9tPOzQqbm6SvsxnLvTQ/pBWqxeC93R1A5Q
p4PAMpfCUBOQNJ3Qk2DrHCJqZRmLnRUbsh5+8NtC0d6jWsIw3+DCWaEi8JzCT0jc
bvXyR1be46iPOe4MHNPKuW8DMeZN7r2y/u1Si5id9Euz9l8Lk/KLn32CNCdPaQ6U
bBiRLF7fGgKwJmsyckpcqeN9adQXWw==
=Z5Cj
-----END PGP SIGNATURE-----

--tBkIGv79VjVWVg47--
