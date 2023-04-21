Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449E26EB122
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjDURtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjDURsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:48:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C6A526A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B40F629FA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 17:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA67C4339B;
        Fri, 21 Apr 2023 17:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682099319;
        bh=Ii+umwiPLgHoqPjWpVsscc+8uzYEd6xFhrolQQm/Ak8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXAcwdQ02eP9WM94jFJIStkVwvRoVn12l3/Io2y38uhwsw+tNWbH4bNgCYFKEh25l
         qZ8FWbQt7DAwviohxha0vPtzUfrl7RIfUJ/LqBIMwEvZW8WwMiLPAGCLAPo6P8beN5
         +wR15BdwtJtgCaO7tp9lGGeA1O3OWGcKRPRSDmHERG+H5otPnykPSYxqXGiSlJv++g
         5+DHYuK3epfiIGN3eWjSBfKLzPz/L4aTy6CeIOZmV+fvGPibtvyBYPTnpacP9ODO5P
         eDrTjm9oxC1q3+7td1u/XZimFrB0cJs+hbzzhRHWOyygItlvwxnvzyQMQL0ibIxqza
         /4yfpIY/6Vqow==
Date:   Fri, 21 Apr 2023 18:48:34 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: hwprobe: Remove __init on probe_vendor_features()
Message-ID: <20230421-humpback-thesis-052993278582@spud>
References: <20230420194934.1871356-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aRxAucu+VMU5sivz"
Content-Disposition: inline
In-Reply-To: <20230420194934.1871356-1-evan@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aRxAucu+VMU5sivz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo Evan,

On Thu, Apr 20, 2023 at 12:49:34PM -0700, Evan Green wrote:
> probe_vendor_features() is now called from smp_callin(), which is not
> __init code and runs during cpu hotplug events. Remove the
> __init_or_module decoration from it and the functions it calls to avoid
> walking into outer space.
>=20
> Fixes: 62a31d6e38bd ("RISC-V: hwprobe: Support probing of misaligned acce=
ss performance")
>

BTW, in the future, no empty line between trailers.

> Signed-off-by: Evan Green <evan@rivosinc.com>

Otherwise,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--aRxAucu+VMU5sivz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZELMcgAKCRB4tDGHoIJi
0r4oAP9MpkA95QmPfsVGArIe3XYGzsfJ9qessAghtLLA7WxNPQEA7mgwhKGzi3dJ
ox2EWtciEAdDRS5RDGNln4ou3RSMWwo=
=JmiQ
-----END PGP SIGNATURE-----

--aRxAucu+VMU5sivz--
