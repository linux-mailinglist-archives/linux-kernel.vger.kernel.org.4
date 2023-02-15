Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C942698718
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBOVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBOVKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 16:10:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC420051;
        Wed, 15 Feb 2023 13:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6E561D94;
        Wed, 15 Feb 2023 21:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD239C433EF;
        Wed, 15 Feb 2023 21:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676495430;
        bh=LXv5NbdP319xIVX/V4C8aNo/sUcwxbNvU0xc1wh5zxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J6/UocltX37EVuikcnvQ48hV2zPcy0xUrU+46pgSsk2UdjyXM2V8YXO120VReCWdC
         pgyhGeAQFGp/zpUVm+AgdSIqSrHclqUmtV1NiCgT3Mzmj2WqgrRnNddGIit5E5/GCX
         eEHZVEzYOHLMb27wxeB7qEB1217sehEHwbdxiyDbsg9TtMk+a3NjDxZ//HzBlhmq8b
         Vil6sn2EblzVsPq9nmx8H8j1bRHLN9+dl7kPqmHDgqfNN3bvxSW29mAfMUJVs2D5rn
         idJOaqa6w9l9XYKJpVlrbXFcqxrGh3qZA9ZQciXUwLoAXJb75IMyFm9NvWIXm5OHs/
         FneqLuUc6mcXg==
Date:   Wed, 15 Feb 2023 21:10:23 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>, vineetg@rivosinc.com,
        heiko@sntech.de, slewis@rivosinc.com,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Bresticker <abrestic@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atishp@rivosinc.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] RISC-V: Add a syscall for HW probing
Message-ID: <Y+1KPzh9xnyKXf0W@spud>
References: <20230206201455.1790329-1-evan@rivosinc.com>
 <20230206201455.1790329-3-evan@rivosinc.com>
 <Y+wedUsNEfWsKU5I@spud>
 <CALs-HssScpGxAN+TBA8PtaVHwJvmudqmXUaSZDFBiu3k4Tb3nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zwbBbfnbfySmFPq0"
Content-Disposition: inline
In-Reply-To: <CALs-HssScpGxAN+TBA8PtaVHwJvmudqmXUaSZDFBiu3k4Tb3nw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zwbBbfnbfySmFPq0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

heh, this came in right as I went to check out by branch with this on it
and look at the rest of the series.

On Wed, Feb 15, 2023 at 12:49:35PM -0800, Evan Green wrote:
> On Tue, Feb 14, 2023 at 3:51 PM Conor Dooley <conor@kernel.org> wrote:
> > On Mon, Feb 06, 2023 at 12:14:51PM -0800, Evan Green wrote:

> > > +On success 0 is returned, on failure a negative error code is return=
ed.
> > > +
> > > +The following keys are defined:
> > > +
> > > +* :RISCV_HWPROBE_KEY_MVENDORID:: Contains the value of :mvendorid:, =
as per the
> > > +  ISA specifications.
> >
> > "per the ISA specifications" sounds like dangerous wording to me! ;)
>=20
> I can replace "per the ISA specifications" with "as defined by the
> RISC-V privileged architecture specification" to try and make that
> more crisp.

Meh was a comment about not trusting the ISA specs, not an attempt to
be a pedant!

> > > +#define RISCV_HWPROBE_KEY_MVENDORID  0
> > > +#define RISCV_HWPROBE_KEY_MARCHID    1
> > > +#define RISCV_HWPROBE_KEY_MIMPID     2
> > > +/* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
> >
> > Can't wait for that to get forgotten!
>=20
> I know. I could add an if (pair->key > RISCV_HWPROBE_MAX_KEY) goto
> unrecognized_key, with a label at the default switch case, which would
> effectively be a runtime guard against it. I opted not to as it's
> aesthetically harsh, but anyone can holler if they want it.

The other question to ask is, do we need RISCV_HWPROBE_MAX_KEY?
What's it for?

> > > diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/includ=
e/uapi/asm/unistd.h
> > > index 73d7cdd2ec49..37d47302322a 100644
> > > --- a/arch/riscv/include/uapi/asm/unistd.h
> > > +++ b/arch/riscv/include/uapi/asm/unistd.h
> > > @@ -43,3 +43,11 @@
> > >  #define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
> > >  #endif
> > >  __SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
> > > +
> > > +/*
> > > + * Allows userspace to probe
> >
> > That comment looks chopped off midway through.
>=20
> Whoops yes I

If you could flesh it

--zwbBbfnbfySmFPq0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+1KPwAKCRB4tDGHoIJi
0l4jAQC5f22UHoBH9B38kKxuqJs2n7jbwpZ1NT72Yf+ICx9A3wEAjuni8MRfDtah
gewzRaPArS9ppGWzmN05UCl5coAFeA0=
=izTC
-----END PGP SIGNATURE-----

--zwbBbfnbfySmFPq0--
