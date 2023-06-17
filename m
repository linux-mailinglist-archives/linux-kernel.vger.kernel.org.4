Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC273425E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjFQRC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjFQRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:02:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4038E1999;
        Sat, 17 Jun 2023 10:02:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A349260B71;
        Sat, 17 Jun 2023 17:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16437C433C8;
        Sat, 17 Jun 2023 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687021346;
        bh=HhqB2RY9efd76qcAsgi7cGT467uqDZhSpGD92blYzms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gnhCUxwmbUvEb5WjMewm6hENoEPWOkrThinQgyx6WgkE7gO2Oc9m6MXp68Uv/yf3y
         ebzdkFJJzoefvBQIwQeE++ju45UMw0orrhUQ4UCFSkyn5OKX5O8InmJD6FFzWb1aCl
         l4EAp69JVm/472UQ9PFd04A23FvmzH+GMD9gq1YQ7mLyCXkUeX1uoPsJilC7Bu5DoQ
         UeKQH9pnVgLlpJP+7HZq/XSz8CL+TIR0+QpvlDHqL/nUFOYEfi5qRayFbxZ46SWzzm
         WoMMRwBMQcGMdtd8kIX7tDlheVeYjTX6N+Wjat9jdAC+uD9es2SUktJVsvXmb+TW5k
         byBJaRCIWtV/Q==
Date:   Sat, 17 Jun 2023 18:02:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 0/8] Add Sipeed Lichee Pi 4A RISC-V board support
Message-ID: <20230617-preppy-eggbeater-a256e963bcc6@spud>
References: <20230617161529.2092-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fxrxQ84gH98yJtRL"
Content-Disposition: inline
In-Reply-To: <20230617161529.2092-1-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fxrxQ84gH98yJtRL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jisheng,

On Sun, Jun 18, 2023 at 12:15:21AM +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
>=20
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
>=20
> NOTE: the thead cpu reset dt-binding and DT node are removed in v3. This
> makes secondary CPUs unable to be online.

The kernel doesn't do anything with that node though, so if you were to
load a fitImage in U-Boot containing this DT, having booted with
whatever the factory provided OpenSBI has, that limitation doesn't
apply, right?

> However, minimal th1520
> support is better than nothing. And the community has been working on
> and will work on the cpu reset dt-binding, for example, Conor, Guo and
> Jessica are discussing about it, I have seen valuable comments and
> inputs from them. I believe we can add back cpu reset in next
> development window.

I'll go take a look through this, if it's good I'll apply it and send it
on to Arnd for 6.5? Although I assume it is fine since v2 was nearly
fine!

Cheers,
Conor.

--fxrxQ84gH98yJtRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZI3nHAAKCRB4tDGHoIJi
0l7tAP9lUn7WHWRx5cRx/2EpyeAdyw2Ru72Z/Uik6knltXelDAD/SHiezqyBzt8i
gtY6/8gwAP8+m8RQ75a2w8agc/eqQA8=
=HOax
-----END PGP SIGNATURE-----

--fxrxQ84gH98yJtRL--
