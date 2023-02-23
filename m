Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671146A12C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 23:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBWWWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 17:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBWWWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 17:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2214560123;
        Thu, 23 Feb 2023 14:21:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEE66179B;
        Thu, 23 Feb 2023 22:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242CDC433EF;
        Thu, 23 Feb 2023 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677190832;
        bh=/RlH+uTaquKSn6/TiMh8xypzok73Zt8sPG8pAcmRmTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqvoO2IVOtcWr342wVoa8dpa33bpVLtuRSUYfEPcNnBl2AVduvoZmVu7l/xjE073r
         7agFjiIId/cqkG1fHGZ/+aWjvkI57OT4L6wkVbP6cC7gt5j/fN+iTzEMjoyfIfNM19
         wkEuxsSU5mPVRQtXCK5GY9NQnQ3NhGZU0/itVdkSlh0ZnZkIMVD8ZZgtjT0j8UCkiW
         PN+0ECz8fyhhRN5pd7gxZxwLEawkUL7+DYpSLCVocr1fLoyk1wbkR9Ho0BRjy+xi8+
         PRNHezUHVBpoqeJ8ZwIsVEZDEZ9D/VQlNFZafspIKpVpK/oQqLCB7NbAO+ei6lffjK
         rPt63LArumsZg==
Date:   Thu, 23 Feb 2023 22:20:27 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tsbogend@alpha.franken.de,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 4/5] riscv: Select ARCH_DMA_DEFAULT_COHERENT
Message-ID: <Y/fmqwboOv/JhWf/@spud>
References: <20230223113644.23356-1-jiaxun.yang@flygoat.com>
 <20230223113644.23356-5-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTYFjkFK/Dt5/rMq"
Content-Disposition: inline
In-Reply-To: <20230223113644.23356-5-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QTYFjkFK/Dt5/rMq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 11:36:43AM +0000, Jiaxun Yang wrote:
> For riscv our assumption is unless a device states it is non-coherent,
> we take it to be DMA coherent.
>=20
> Select ARCH_DMA_DEFAULT_COHERENT to ensure dma_default_coherent
> is always initialized to true.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d46a268ce16..b71ce992c0c0 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -233,6 +233,7 @@ config LOCKDEP_SUPPORT
> =20
>  config RISCV_DMA_NONCOHERENT
>  	bool
> +	select ARCH_DMA_DEFAULT_COHERENT

Since we are always coherent by default, I feel like you should put this
in the main "config RISCV" section, where OF_DMA_DEFAULT_COHERENT
currently is, no?

Wouldn't bother respinning for that unless the dma folk have comments
for you.

>  	select ARCH_HAS_DMA_PREP_COHERENT
>  	select ARCH_HAS_SETUP_DMA_OPS
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
> --=20
> 2.37.1 (Apple Git-137.1)
>=20

--QTYFjkFK/Dt5/rMq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/fmqwAKCRB4tDGHoIJi
0leFAP9uQuy0NP1f84CZIhkE/FTxQbCtqVp7mJK2gG8h1AzO+AD+I8qU90iT/HH9
zh/cOUlKSuqIp7B4dD2guraiIpMV2gc=
=YsJz
-----END PGP SIGNATURE-----

--QTYFjkFK/Dt5/rMq--
