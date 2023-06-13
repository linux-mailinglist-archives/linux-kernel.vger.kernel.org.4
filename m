Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BFC72E8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbjFMQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjFMQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:54:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FF6123;
        Tue, 13 Jun 2023 09:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F032162DA0;
        Tue, 13 Jun 2023 16:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DDEC433D9;
        Tue, 13 Jun 2023 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686675296;
        bh=/WwbLC4AYxFlsMo/0xwNj7aKWItsTMJMTTrgt7suMLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiDZIQ9DvrTSHXBmlvlE3hmk08fcHHeb5fntXdJ2f/c7ZnPOdQO/cQRioloCJtqxp
         masgstRdkhyb21iyTv17RA13o9TVNYDTfZa8asW9g3/dnpp+PLiDBD7sAUR2LJbxIA
         lpZqNW8a6eCNYwM4s1gj+aoNM99MXc5rfDc0xRbWFnuSpX1RovPc9MQyPg37bF1xst
         RwGGR5lSRUMWyJPqD1rpvqVTnfYyUQ8sUjFWYEAzfHyFIazYPzFFgRAecm/0TfB5eC
         EMbMej55yC8eGLUVWxr5Gm7NuER+zKAUXa9nIsnSImx/xjK21ZjXFmf3nl+UnzO3H7
         9jooWAaWxBJCw==
Date:   Tue, 13 Jun 2023 17:54:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v5 3/4] RISC-V: hook new crypto subdir into build-system
Message-ID: <20230613-wasp-energy-20e2cd8618b4@spud>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-4-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1pvydtWQC18RdlEG"
Content-Disposition: inline
In-Reply-To: <20230612210442.1805962-4-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1pvydtWQC18RdlEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 11:04:41PM +0200, Heiko Stuebner wrote:
> diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
> new file mode 100644
> index 000000000000..b3b6332c9f6d
> --- /dev/null
> +++ b/arch/riscv/crypto/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# linux/arch/riscv/crypto/Makefile

This comment looks weird, why is the filename here w/ a "linux/" prefix?

> +#


--1pvydtWQC18RdlEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIifWwAKCRB4tDGHoIJi
0k6XAP433CxHzezw6/n4IfsT2X7Tbsyw+MwsKbUyuc2LIAc9GAEAhu/lSLKbiPyM
AUAtE5YU+LKaAdvAEttlqL/eAj4tyw0=
=g3s1
-----END PGP SIGNATURE-----

--1pvydtWQC18RdlEG--
