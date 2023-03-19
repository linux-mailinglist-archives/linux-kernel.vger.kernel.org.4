Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B756C04D7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjCSUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCSUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:35:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0A1C33F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:35:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C13361188
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44A3C433EF;
        Sun, 19 Mar 2023 20:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679258153;
        bh=oBzUoRkpx/go/ZawYxCRsU86baGLsAHa0Txax9W8KqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luRWW0dHoUE/2rUL4ZCxeguM5z1iit9HIyzRSjQqUkK3nWIcpW6HC5UgDku5JlyPj
         CLm8cDCMTK0S1aTVFRxzb/VmGKkAKwARGsyyqPr2sFEUSUIo6jya14E3+ruYmAbdGt
         1bNFn17GZLK4p/wY7GgCdkkzAN293rbzdHd2d0//1OlByl2TvnpDBzNmcTRGzY4d4C
         XB+uM2rre3J3+EkbObgFz7h2yMoYLVSoVEqrRH6VW8K80/jkm/CgUSP+FfMTFrMSd4
         b4FmfDOHqcyRql3ciEFqFKruEmKbFX7501746HWxiA6gPre0rSZLJsPcLRI8kk/BWv
         CdCqKFtjGkP6g==
Date:   Sun, 19 Mar 2023 20:35:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
Message-ID: <8f698f49-135a-4263-8471-96f406919cb1@spud>
References: <20230318080059.1109286-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BecIu+WbbGwYTZ29"
Content-Disposition: inline
In-Reply-To: <20230318080059.1109286-1-leobras@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BecIu+WbbGwYTZ29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> While studying riscv's cmpxchg.h file, I got really interested in=20
> understanding how RISCV asm implemented the different versions of=20
> {cmp,}xchg.
>=20
> When I understood the pattern, it made sense for me to remove the=20
> duplications and create macros to make it easier to understand what exact=
ly=20
> changes between the versions: Instruction sufixes & barriers.
>=20
> I split those changes in 3 levels for each cmpxchg and xchg, resulting a=
=20
> total of 6 patches. I did this so it becomes easier to review and remove=
=20
> the last levels if desired, but I have no issue squashing them if it's=20
> better.
>=20
> Please provide comments.
>=20
> Thanks!
> Leo
>=20
> Leonardo Bras (6):
>   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
>   riscv/cmpxchg: Deduplicate cmpxchg() macros
>   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros

>   riscv/cmpxchg: Deduplicate xchg() asm functions

FWIW, this patch seems to break the build pretty badly:
https://patchwork.kernel.org/project/linux-riscv/patch/20230318080059.11092=
86-5-leobras@redhat.com/

Patches 1 & 5 also add quite a lot of sparse issues (like 1000), but I
think that may be more of an artifact of the testing process as opposed
to something caused by this patchset.

Cheers,
Conor.

>   riscv/cmpxchg: Deduplicate xchg() macros
>   riscv/cmpxchg: Deduplicate arch_xchg() macros

--BecIu+WbbGwYTZ29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBdyIwAKCRB4tDGHoIJi
0rdbAQCqvm6guH3G65uxvUHg0E/NyKWtgv9gftrjH+Q18u8kgQEA0MUQWh1LcD+a
0yfx5MSukvisMIZ3mflqcCYnhg2skw8=
=+os8
-----END PGP SIGNATURE-----

--BecIu+WbbGwYTZ29--
