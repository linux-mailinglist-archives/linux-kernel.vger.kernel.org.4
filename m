Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE6C6A4F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 00:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjB0XPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 18:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjB0XPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 18:15:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE5DBE7;
        Mon, 27 Feb 2023 15:15:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36241B80DCE;
        Mon, 27 Feb 2023 23:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517B4C433EF;
        Mon, 27 Feb 2023 23:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677539703;
        bh=ZBHNECAhstQhQIfVxLmWfx+9U+cYMlGgp/4GCzlwY7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wyz6inJ15Jx6h5dTdXCZ3dH4iI+pz9TdOdJUXWaXHhUonQok4QQcBdUyDzZRKguQM
         TbnM4hZPKpBZ42SfWVuCPW/DEDqpEzxvhj3GDPcnd6qdozMy0xTXJKQKimjclhKPDm
         JQ48flxE+75mOSfDL2jY2l55m9r9cQYXRnfxNQaQ5cwKjKbTclzY83dh7Y/QIxNy7O
         5zehXy/JXEYRr2M1/SX/uEqhlLNVp3mLZ8p+ehelDLnTiZ8en7IwudA+Mvvn8HZeNL
         nxumQjw+SA78S0ueupBRgZf9guvmCsB/M6MUN6YB0SPAykR0xOT4cpO5MeFbNXesBc
         i4IluDXdXUxMA==
Date:   Mon, 27 Feb 2023 23:14:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, heiko@sntech.de,
        slewis@rivosinc.com, vineetg@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 5/7] RISC-V: hwprobe: Support probing of misaligned
 access performance
Message-ID: <Y/05cBMyrYSiaNL5@spud>
References: <20230221190858.3159617-1-evan@rivosinc.com>
 <20230221190858.3159617-6-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SxTha3qIYXZ4YGJ0"
Content-Disposition: inline
In-Reply-To: <20230221190858.3159617-6-evan@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SxTha3qIYXZ4YGJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Evan,

On Tue, Feb 21, 2023 at 11:08:56AM -0800, Evan Green wrote:
> This allows userspace to select various routines to use based on the
> performance of misaligned access on the target hardware.
>=20
> Co-developed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Evan Green <evan@rivosinc.com>
>=20
> ---
>=20
> Changes in v3:
>  - Have hwprobe_misaligned return int instead of long.
>  - Constify cpumask pointer in hwprobe_misaligned()
>  - Fix warnings in _PERF_O list documentation, use :c:macro:.
>  - Move include cpufeature.h to misaligned patch.
>  - Fix documentation mismatch for RISCV_HWPROBE_KEY_CPUPERF_0 (Conor)
>  - Use for_each_possible_cpu() instead of NR_CPUS (Conor)
>  - Break early in misaligned access iteration (Conor)
>  - Increase MISALIGNED_MASK from 2 bits to 3 for possible UNSUPPORTED fut=
ure
>    value (Conor)

I'm not quite sure why we don't just go ahead and plumb this in already?
Whether the specs allow this or not, someone is going to end up doing
it (and it sounds like the specs now do allow it).
Is it wise to plug the hole in the syscall now, rather than leaving the
gap?

Otherwise, this looks fine, modulo Joe's comment about types.

Cheers,
Conor.


--SxTha3qIYXZ4YGJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/05cAAKCRB4tDGHoIJi
0ih+AQDO+TBU5dt3vbjyzYvBj2OYRSRoj+m7fOk3ZiuU/t6iewD+K9qpmYRNlEdh
cLzg0+K2QIc1GWFWHR++hP2QHlQnTAc=
=xn/p
-----END PGP SIGNATURE-----

--SxTha3qIYXZ4YGJ0--
