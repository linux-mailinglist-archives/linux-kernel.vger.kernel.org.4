Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AE774429B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 21:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF3TIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjF3TIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 15:08:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971D3C17
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 12:08:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDE5617E8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 19:08:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7867BC433C0;
        Fri, 30 Jun 2023 19:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688152080;
        bh=17MXOGeiI3F3FBpWaJtF9ruFS/NqAZ5ZllRZXut7AOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgwsTvAvkh4gCPbOx2sT1SZmELaQ8AlxcMn4Y4vR8uravryYhFKtVaqyfFatd3Lwg
         h1qs8GsBfu/X4timESeOK4csKXK9w/vwGrB897jXL9Amps+ksxBuk1KYs3h9u1sVhG
         MVBpTiVVoBxaiQdXxwF5LjBu76UmBa9oLcg4ZBm9K6w3Y/6m9dIQebsRcZ/06IjzPk
         9uj+dIc5E+uzQFUjp0sBWv9d9nQeobGBaPX+DQTbyYZSs3e5HDrQzaKEkSM8HCI1ZG
         83tvDErk8o04Xe7qWN+IucnZRL0w6neppqbWb7BfYai4eERz/HBtfnTSeaHKSo7apR
         odtwAbfzF6tLw==
Date:   Fri, 30 Jun 2023 20:07:56 +0100
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
Subject: Re: [PATCH 6/6] riscv: Allow CONFIG_CFI_CLANG to be selected
Message-ID: <20230630-rake-clubbed-bba8a9c27219@spud>
References: <20230629234244.1752366-8-samitolvanen@google.com>
 <20230629234244.1752366-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nIytQ0cE4OI/O9o2"
Content-Disposition: inline
In-Reply-To: <20230629234244.1752366-14-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nIytQ0cE4OI/O9o2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 11:42:51PM +0000, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI_CLANG to be selected
> on riscv.
>=20
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 20a40927175e..2699e1f8fe33 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -44,6 +44,7 @@ config RISCV
>  	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
>  	select ARCH_SUPPORTS_PAGE_TABLE_CHECK if MMU
> +	select ARCH_SUPPORTS_CFI_CLANG

Please add new entries in alphanumerical order, thanks.

>  	select ARCH_USES_CFI_TRAPS if CFI_CLANG
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
> --=20
> 2.41.0.255.g8b1d071c50-goog
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--nIytQ0cE4OI/O9o2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8oDAAKCRB4tDGHoIJi
0tBQAPjbTVlYsXsyPEXbChKm896xE4tK0LzcWglSDjocpk2uAQCf4jf8R7g7Veb7
13b70HROD+koWjNEGZd6gmiTTxBFDQ==
=/P/0
-----END PGP SIGNATURE-----

--nIytQ0cE4OI/O9o2--
