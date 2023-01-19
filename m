Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F12674C07
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjATFUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjATFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB57DF85
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:09:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 769ABB826F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 18:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D760C433D2;
        Thu, 19 Jan 2023 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153136;
        bh=G2dlcSrpAd5WYQ2pF9B2zYjqocrarlO2vwEZAG98/+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqUxNns1Mx/u/m/jBytaYR3d/Gv7QQ4/+CVwoOuOn8wVI0CO8/RmhAFm4NR87Vw1A
         zQ0NgY0Qyi2xUrueRD/VnTUmjnUOawe2lGANV4sCd7abggh8esYjezQT8SPbhbLEEp
         dxYqnLMKqVhfs0fiiOuMd0vN6OS62l+omxr8ROi9vJ/gaXvnA7AQnzNBQnZOnWpcGV
         L2KiL0ZMjXPt2M0gBRbhGLWzcJ4jgIDYt8wttu/QLljznvc8vQTQXJXLMr09YCrLnM
         OXZmuCJ8hH5eDWIRWDxjNpOFIAJnM5tB34RXOv6IutV/yburvhn1QBzcS7Dr+1XMGb
         QWhFjaLTc4I0w==
Date:   Thu, 19 Jan 2023 18:32:11 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] riscv: lds: define RUNTIME_DISCARD_EXIT
Message-ID: <Y8mMqxqegQ5XThKv@spud>
References: <20230119155417.2600-1-jszhang@kernel.org>
 <20230119155417.2600-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SsobklzoJrra3VXj"
Content-Disposition: inline
In-Reply-To: <20230119155417.2600-2-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SsobklzoJrra3VXj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 11:54:13PM +0800, Jisheng Zhang wrote:
> riscv discards .exit.* sections at run-time but doesn't define
> RUNTIME_DISCARD_EXIT. However, the .exit.* sections are still allocated
> and kept even if the generic DISCARDS would discard the sections due
> to missing RUNTIME_DISCARD_EXIT, because the DISCARD sits at the end of
> the linker script. Add the missing RUNTIME_DISCARD_EXIT define so that
> it still works if we move DISCARD up or even at the beginning of the
> linker script.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>

Thought I left one of these against v1, either way:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--SsobklzoJrra3VXj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8mMqwAKCRB4tDGHoIJi
0rczAQCp6WYGe/TWmVUyy+TKfW2nJC1Gow59p8y+l0hJK9E5YwEA2upUxo9SWD5m
ieU1BPJlB1yIQBwHj73xUFLqxKvCSgM=
=YSh+
-----END PGP SIGNATURE-----

--SsobklzoJrra3VXj--
