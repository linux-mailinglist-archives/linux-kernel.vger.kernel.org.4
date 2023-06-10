Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374D772ACAA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjFJPo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjFJPoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:44:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41413A9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1A8560BBA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 15:44:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F872C433EF;
        Sat, 10 Jun 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686411863;
        bh=/d0aPoZrtu5RnKE0NB858Rjj6Plv6oc8XWir1e+Z0OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tzc+aW9U+5W1DD0JHawm+1C7ABCtr0K7hHNw3f+PaNOaGBFFZtZyySMGRE9lFmr1J
         8TY+Zn+wiYlwQfsH2znwsp/5R6/cWfpWw0IOn/j/pJu+hawmtJKeIe4Bm7g+mdlAy4
         MA2JJ91Gzj61NZhIs8VroSha5XY5hw7APoMO4schlS9tYXmeSeO7q6rX6PSt68eTvu
         O6W/K9WV5BXLhvSJ66O9twll9+gArNyUjC3ouWODl7gHsiwZn44BMDo+gN/iLJlNCb
         mzsgbRJtD/rgt/SqimhRlHrPHWCgxDeh3TAix1gtVF5QOWM5NilWA/qDyxZRzVQJmP
         VstojO26hwG8A==
Date:   Sat, 10 Jun 2023 16:44:19 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Woody Zhang <woodylab@foxmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: move memblock_allow_resize() after lm is ready
Message-ID: <20230610-ultimate-moisture-630c7672358b@spud>
References: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ktqcJ4plNqwb0t69"
Content-Disposition: inline
In-Reply-To: <tencent_D656D683705F41324657ED3393C3384C7408@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktqcJ4plNqwb0t69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 10, 2023 at 07:43:20AM +0800, Woody Zhang wrote:
$subject: "riscv: move memblock_allow_resize() after lm is ready"

s/lm/linear map/ if you resubmit, please.

> The initial memblock metadata is accessed from kernel image mapping. The
> regions arrays need to "reallocated" from memblock and accessed through
> linear mapping to cover more memblock regions. So the resizing should
> not be allowed until linear mapping is ready. Note that there are
> memblock allocations when building linear mapping.
>=20
> Signed-off-by: Woody Zhang <woodylab@foxmail.com>

What commit does this fix?

Cheers,
Conor.

--ktqcJ4plNqwb0t69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISaUgAKCRB4tDGHoIJi
0laWAP4z2lkAoDmsLz77dp1mJR+bLMchM0rK0Ts2lt7Tph8YogEA9p/sz+WuUouz
GEVID6D/Inc6RxHIbBNY3VziLdR0ZgI=
=w7Ug
-----END PGP SIGNATURE-----

--ktqcJ4plNqwb0t69--
