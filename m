Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA68744284
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjF3Ssc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjF3Ss3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9057E4F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 11:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7777E617EA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 18:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FB7C433C0;
        Fri, 30 Jun 2023 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688150907;
        bh=iuRNxaXfE0hUWrCc8jY/81IkxCwuytrd8/XvpwaVu6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSJFSftluH4KmiUDWiOewcAUukuOlg3ZaBy+fEu+ERsPmoQ7HwqsUuuYQQwtrpEfM
         9xoYylr1alx5yEcQuEZngcKqPOqjGb4mua0CpzzQWdPjrr/v91o73OyG1ekO+hdltO
         34WfGqdxbR910l37Q6oOCToZ/ZZc8fNok8+IO0nyb4YKQpourdOpRjC7ub6bKSOqoA
         ixYRE2FEuj1RhDEjkuqZrLvFe+A70VijEZ1QmbBx7p3BCAScW4avRblxU+WJTL5+mU
         Hi3HWMB8eypHeo3RIa22CYfgABMW1+TDKl1nNAAFPa0CzWJYCO2DNBHknVOyD+y090
         ycA9304ka+mMA==
Date:   Fri, 30 Jun 2023 19:48:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] riscv: KCFI support
Message-ID: <20230630-phrasing-strung-12e53988ad81@spud>
References: <20230629234244.1752366-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KeUX9Ea1q/FPEBvY"
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KeUX9Ea1q/FPEBvY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Sami,

On Thu, Jun 29, 2023 at 11:42:45PM +0000, Sami Tolvanen wrote:
> This series adds KCFI support for RISC-V. KCFI is a fine-grained
> forward-edge control-flow integrity scheme supported in Clang >=16,
> which ensures indirect calls in instrumented code can only branch to
> functions whose type matches the function pointer type, thus making
> code reuse attacks more difficult.

> base-commit: c6b0271053e7a5ae57511363213777f706b60489

Could you please rebase this on top of v6.5-rc1 when that comes out?
This base-commit is some random commit from Linus' tree, that because we
are currently in the merge window has is not in the RISC-V trees yet,
and means the series wasn't applied by our CI stuff.

Cheers,
Conor.

--KeUX9Ea1q/FPEBvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8jdwAKCRB4tDGHoIJi
0nEcAP0SWfLV19tIw/6zGm0BC+jgnl2WaOsvVsv9zVtGh5HT+wD/bgxhWiw2uj+3
wv6NCmZKlo3MNdMi7qK+Q07sMmgBKwg=
=3kM+
-----END PGP SIGNATURE-----

--KeUX9Ea1q/FPEBvY--
