Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB44645F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiLGQkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGQkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:40:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9565B0;
        Wed,  7 Dec 2022 08:40:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6839ECE1AFE;
        Wed,  7 Dec 2022 16:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A02C433C1;
        Wed,  7 Dec 2022 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670431210;
        bh=g5fGGrWSIRqwNSexjwtqPOCti3BgIlEU85pKTBf8T0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo5QBkISEd5C93re2xC0MAd5GbmcJS0EQqCFX92m+ZL2Nnj+W+l6Aa8NisLDN8s2+
         T/59VugOVhDKZk6+JfIq19yMgs9W72I7zpqEoVvLjqhwYaGveEsjBalrCI/i9FYgpi
         GRSSZt4wnoHmFdjJya2qZ2v6WPaiqIAOgtedaL1X6wHhznVa3upGa5A4T7yrYIH67B
         E4KovPtFNabXUFMrqkNctQza7wTDUZlfNqI0Y0kN7wBNdJAqcQgul/ISBt0ja9HSUx
         24oqNM/bS5VlKbyeAGSVDrOv390/2jSLOD5C3VBU1dHcR9zdD6AcLhueUri6w+Obo/
         RZQPBhowOylmw==
Date:   Wed, 7 Dec 2022 16:40:05 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Bin Meng <bmeng@tinylab.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 2/3] riscv: Implement semihost.h for earlycon semihost
 driver
Message-ID: <Y5DB5c7O4oAMkTa/@spud>
References: <20221207135352.592556-1-bmeng@tinylab.org>
 <20221207135352.592556-2-bmeng@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P16++YdENF2wGyvg"
Content-Disposition: inline
In-Reply-To: <20221207135352.592556-2-bmeng@tinylab.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P16++YdENF2wGyvg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Two tiny nits for whenever other comments require a v3.

On Wed, Dec 07, 2022 at 09:53:51PM +0800, Bin Meng wrote:
> Per RISC-V semihosting spec [1], implement semihost.h for the existing
> Arm semihosting earlycon driver to work on RISC-V.
>=20
> [1] https://github.com/riscv/riscv-semihosting-spec/blob/main/riscv-semih=
osting-spec.adoc

Could you please use regular Link: tags? Also, for a multi-patch series
please send a cover letter :)

Thanks,
Conor.


--P16++YdENF2wGyvg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY5DB5QAKCRB4tDGHoIJi
0pZKAQCwhsweZT35rE6Qa9nOrzhd5VKjCEPMMwbXWCfug86MmAEAmCRVZoYRpUvE
E1k+9d6yojCvx8N+tjKoPiR/Bzb88w4=
=64rp
-----END PGP SIGNATURE-----

--P16++YdENF2wGyvg--
