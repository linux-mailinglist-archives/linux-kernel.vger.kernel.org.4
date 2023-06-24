Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E3D73CA65
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 12:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjFXKIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 06:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFXKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:08:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060DB1736;
        Sat, 24 Jun 2023 03:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3752160C79;
        Sat, 24 Jun 2023 10:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DBFC433C8;
        Sat, 24 Jun 2023 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687601291;
        bh=GdUhQ/g4lPVcmdlC7sNHfy+iEXwSg6y5+1Nd/kQQHps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tWV3l3lqlD3rVQfTQrPUCyVfmA4U9rtFYdjB90hPr0H6Fdo9KOjJgf4UxXoNNn7ma
         Q+GG50HuUlj+M70iF1Zy8TpfFvmS0TSssLPLnI4Kk0FgJ6kAFO6Mr2mLNrO9MK0Opu
         L5d0ua6si1tf2ST3kll2MK5rT57vD/wf1J0WmBm+IHeXNpd67uxo6Vm8jpfTOnFWYK
         +oSprWci/L6oWZb+Z5rHo3hPzfRgvTgGei06bxDf8ESyA0lE/V6t40YwYeyuisnWJX
         6EIrXvw7zZbagvLDb8U1RQd6acpUvZ+dDhYu4LPq9qMlONHov1DTgxJgcKOk0jR0xO
         0VWKlAbW23PpQ==
Date:   Sat, 24 Jun 2023 11:08:03 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Samuel Holland <samuel@sholland.org>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/2] RISC-V: Probe for misaligned access speed
Message-ID: <20230624-tycoon-pliable-325806e73a11@spud>
References: <20230623222016.3742145-1-evan@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="03eh9c7zzQjeRTOG"
Content-Disposition: inline
In-Reply-To: <20230623222016.3742145-1-evan@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--03eh9c7zzQjeRTOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 23, 2023 at 03:20:14PM -0700, Evan Green wrote:
>=20
> The current setting for the hwprobe bit indicating misaligned access
> speed is controlled by a vendor-specific feature probe function. This is
> essentially a per-SoC table we have to maintain on behalf of each vendor
> going forward. Let's convert that instead to something we detect at
> runtime.
>=20
> We have two assembly routines at the heart of our probe: one that
> does a bunch of word-sized accesses (without aligning its input buffer),
> and the other that does byte accesses. If we can move a larger number of
> bytes using misaligned word accesses than we can with the same amount of
> time doing byte accesses, then we can declare misaligned accesses as
> "fast".
>=20
> The tradeoff of reducing this maintenance burden is boot time. We spend
> 4-6 jiffies per core doing this measurement (0-2 on jiffie edge
> alignment, and 4 on measurement). The timing loop was based on
> raid6_choose_gen(), which uses (16+1)*N jiffies (where N is the number
> of algorithms). On my THead C906, I found measurements to be stable
> across several reboots, and looked like this:
>=20
> [    0.047582] cpu0: Unaligned word copy 1728 MB/s, byte copy 402 MB/s, m=
isaligned accesses are fast
>=20
> I don't have a machine where misaligned accesses are slow, but I'd be
> interested to see the results of booting this series if someone did.

Can you elaborate on "results" please? Otherwise,

[    0.333110] smp: Bringing up secondary CPUs ...
[    0.370794] cpu1: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misali=
gned accesses are slow
[    0.411368] cpu2: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misali=
gned accesses are slow
[    0.451947] cpu3: Unaligned word copy 2 MB/s, byte copy 231 MB/s, misali=
gned accesses are slow
[    0.462628] smp: Brought up 1 node, 4 CPUs

[    0.631464] cpu0: Unaligned word copy 2 MB/s, byte copy 229 MB/s, misali=
gned accesses are slow

btw, why the mixed usage of "unaligned" and misaligned"?

Cheers,
Conor.

--03eh9c7zzQjeRTOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJbAgwAKCRB4tDGHoIJi
0pUuAP9Oi0aUUS8IeaeAx0/UgKLo9vsBt3gvCL2XYFVBWKvb+AEAw7x52zBY7Urs
R8n/7yymgPKxI6BEor3Iirixfy983w0=
=VE2p
-----END PGP SIGNATURE-----

--03eh9c7zzQjeRTOG--
