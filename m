Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178FC69E737
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjBUSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjBUSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:14:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE92310B;
        Tue, 21 Feb 2023 10:14:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCB1B81041;
        Tue, 21 Feb 2023 18:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD83C433D2;
        Tue, 21 Feb 2023 18:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677003257;
        bh=55vQ4vuxqdLPNMXiH9FXteJ4euOmT3++dnRzIZaARe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZPoSp5eHfpgZRYQttW5kJy+js0VmUfuZoxSK5m5Z6RScU276XD7MWyUyhxCeSF8Me
         tKqn8RRWnfk9YiWB8nUCV7M0ul56zBisyhhHJ/r7b6LI1nSDfoAQ0sl1D0VC8Otv2q
         3Tv0rS8q92u3vMIGX37NZA3xLUhn7F5zhL/GY8Lz0rpJFhcBrsAeKNn1fSTo3RS5V5
         mI3lybp+0tu55n1F6Z2QbQQxY1eQ+w3aLyZSp2KjoZq4ngNwqVa6D+3WXbeuxaLIcj
         WmT9ZNQIYmuxPV6vqx3vl1F2bla59DuSz22FCZO9yHH/o9UO/yuMU4QvTIoEy95q7i
         bPCXB4fy/sVHQ==
Date:   Tue, 21 Feb 2023 18:14:12 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com
Subject: Re: [PATCH 6/7] riscv: Select ARCH_DMA_DEFAULT_COHERENT
Message-ID: <Y/UJ9HowQdsNN+Cz@spud>
References: <20230221124613.2859-1-jiaxun.yang@flygoat.com>
 <20230221124613.2859-7-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TIgg2EDZf/IvKi42"
Content-Disposition: inline
In-Reply-To: <20230221124613.2859-7-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TIgg2EDZf/IvKi42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2023 at 12:46:12PM +0000, Jiaxun Yang wrote:
> For RISCV we always assume devices are DMA coherent.

"Always assume", I'm not keen on that wording as it is unclear as to
whether you are suggesting that a) we always take devices to be DMA
coherent, or b) unless a device states it is non-coherent, we take it to
be DMA coherent.
I think you mean b, but being exact would be appreciated, thanks.

> Select ARCH_DMA_DEFAULT_COHERENT to ensure dev->dma_conherent
> is always initialized to true.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Why was this not sent to the riscv list?
When (or if) you send v2, can you please make sure that you do cc it?

Thanks,
Conor.

--TIgg2EDZf/IvKi42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/UJ9AAKCRB4tDGHoIJi
0qtpAP4zXrtuR5siMLRREVaH2TGuvEhGXZZpZVhpdzUNaoIqSQEA9ULHD7KQZrTa
XHUgsMZMeKC10SwAyT/1oU+qjITTOQU=
=swU7
-----END PGP SIGNATURE-----

--TIgg2EDZf/IvKi42--
