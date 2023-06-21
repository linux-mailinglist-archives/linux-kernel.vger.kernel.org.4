Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9449273907D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFUUAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUUAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:00:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35CC186
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F54A616BF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC82C433C8;
        Wed, 21 Jun 2023 20:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687377642;
        bh=SQ+imObWS14cP10Y18MziYIjmjUYYcXFjwdTr8wPsuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nr6TOo8PAYzuw3GXwltDcFDKVqzjhvGdLJZuz9zdI8UsBS1iU4pTVQBkrwCA2JP5y
         9N7e/63kEYmBs3uQ5eQoxktyv+Srdd1fVzuswsIXSS3NSlHSnTsIIaCZX60YO/NAJe
         tHmpF1EreigRcCcTbM2n7sgB+DpVdqgVopfMZTqQgwmO5YVX2rgHzuBeCF1/F8xCBu
         +6Qw5s3gPToZ3u/Ivb87p2VF22RBk06iG7BH0Qo12FQ1W2OdjsRhoDiV+DyfNSAfxN
         276t6WAJgPNAyiSwO5kZcJoXPEsbB0UDTabwDwdARQmx4vk1S+C4VA8qWGRM+n1XYP
         ZD0B9e2ZqYnQA==
Date:   Wed, 21 Jun 2023 21:00:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        rdunlap@infradead.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, jszhang@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] RISC-V: make ARCH_THEAD preclude XIP_KERNEL
Message-ID: <20230621-grass-pregame-8fa7cd7bdb96@spud>
References: <20230621-panorama-stuffing-f24b26546972@spud>
 <mhng-2c7ad1c9-cba1-4501-ae38-0ffb3d5bf487@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ajf8h57HmhRtTFF7"
Content-Disposition: inline
In-Reply-To: <mhng-2c7ad1c9-cba1-4501-ae38-0ffb3d5bf487@palmer-ri-x1c9a>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ajf8h57HmhRtTFF7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 12:57:02PM -0700, Palmer Dabbelt wrote:

> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> I don't have an ARCH_THEAD, though, so not sure where this is aimed at.

I need to take it, I applied the patches.
Sorry, probably should have said it below the --- line.


--Ajf8h57HmhRtTFF7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNW5gAKCRB4tDGHoIJi
0nn8AP9dbp+MsPmGU4vtjULuvQ3gNxenRtrKDk993yQwQOrLuAEA433XyDsXuAvS
iC2ighoEnR8mC9vnFlomU51Xu5oPoA4=
=JUGI
-----END PGP SIGNATURE-----

--Ajf8h57HmhRtTFF7--
