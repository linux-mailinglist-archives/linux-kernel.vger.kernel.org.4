Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4E87403F5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjF0TS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjF0TS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 15:18:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA3E6C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 12:18:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB8FF6120E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 19:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C5C433C8;
        Tue, 27 Jun 2023 19:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687893504;
        bh=uwzZUjZSCfj7+frIlsvFzZuiym3U7S7pNMgIXSdtB4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p89b6LX3hLunHjDY3X4M9F1r/ot+U5G1vIelARlufBDGrahv2EeW1K5E8jShoR0AL
         Eez//ApvuP6lQfl3ln4QNkBjQhNSDVWrwdof9FiWWZvyDQcakaDKVJA+UVcHyjlMXY
         YMW6xbMP08W82OGPQjLBSh2KQWfQyOIqfSxBig3nipuLY596mkuHKAGwISc2hYjVLA
         OdnOnfHZa9J1YBGX5z22QUlqdD+zT23S4rAaeaVq+CrmkWCa4r8SXrJfe0Mph63Mqf
         2E1BB7jDdM9AHEVw4jm8CHIdFxwaMHSbXyR2hHHRG8tv/IuAhKiagovj0DGDn+WIqA
         DdlKQQ7zq/mew==
Date:   Tue, 27 Jun 2023 20:18:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Hongren (Zenithal) Zheng" <i@zenithal.me>
Cc:     Evan Green <evan@rivosinc.com>, Samuel Ortiz <sameo@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Jiatai He <jiatai2021@iscas.ac.cn>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Message-ID: <20230627-projector-rockband-cac4bd138338@spud>
References: <20230627143747.1599218-1-sameo@rivosinc.com>
 <20230627143747.1599218-2-sameo@rivosinc.com>
 <CALs-HssMkVikspnEi-Ek2t=ABvFvgptAhsBjk1+aLuVjiP7P7w@mail.gmail.com>
 <20230627-debating-twelve-da2c1ed60948@spud>
 <ZJsyntnQ/FDXgNPk@Sun>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3UzS4ywJFe4Sz/og"
Content-Disposition: inline
In-Reply-To: <ZJsyntnQ/FDXgNPk@Sun>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3UzS4ywJFe4Sz/og
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2023 at 03:03:58AM +0800, Hongren (Zenithal) Zheng wrote:
> On Tue, Jun 27, 2023 at 07:48:15PM +0100, Conor Dooley wrote:
> > On Tue, Jun 27, 2023 at 11:14:30AM -0700, Evan Green wrote:
> > > On Tue, Jun 27, 2023 at 7:38=E2=80=AFAM Samuel Ortiz <sameo@rivosinc.=
com> wrote:
> > > >
> > > > From: "Hongren (Zenithal) Zheng" <i@zenithal.me>
> > > >
> > > > This patch parses Zb/Zk related string from DT and
> >=20
> > %s/This patch//
> >=20
> > > > output them in cpuinfo
> > > >
> > > > One thing worth noting is that if DT provides zk,
> > > > all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> >=20
> > Please explain why this is okay.
>=20
> From riscv scalar crypto spec, zk is a shorthand
> for zkn, zkr and zkt and zkn also includes zbkb, zbkc
> and zbkx.

Hmm, seems you misunderstood, sorry about that.
What I was looking for is an explanation of this in the commit message.

Hope that helps,
Conor.

--3UzS4ywJFe4Sz/og
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJs1+gAKCRB4tDGHoIJi
0sEhAP4gjuEYPLur3H8NK87xQ6PWeP9nG9Wm91xRu6Yk/PC/VAEA42C+FQ5GUpKv
Bf/0pPRGWuoqFLtpo0WEjUWORA7hKAk=
=ZW5q
-----END PGP SIGNATURE-----

--3UzS4ywJFe4Sz/og--
