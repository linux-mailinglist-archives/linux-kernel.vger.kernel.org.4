Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4636E1491
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjDMSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjDMSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:47:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71019ECC;
        Thu, 13 Apr 2023 11:47:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E867F640D3;
        Thu, 13 Apr 2023 18:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C38BC433EF;
        Thu, 13 Apr 2023 18:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681411614;
        bh=kpBt1oADqsJQfllY+Qo57AhJLFESQkTG4UlYkQR4en4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfp53RmC1TwHvchqmC/oiL/Xba5CWW+WrxvxeFHGhR39zNRMtiUsXIdQy59ylyeZU
         SkfnGxheTzNkclITWDjRgGAYdTNK2GSPd1MW9gnj6i1MVMjxULhyPKe11Z3bhgx8JK
         fMwQ76F9Z1jkOuvLh9qyVD/1StqfmY1HTlkCJxhLf4hFidkwv3ShV7mPt9h9tGB4Rj
         SZqkRdIbUgugqt6tcHgmMZYfLCbqCQ/nOOB90RAGxT/PHdEew0oE0FUMqV9SwzHmbh
         rxEEO/EBs4czK+ECfSJTHKUBJVEiQ+9Fimsw/cr57ynN9BRsDkederI/k7NNq5Vtkf
         lzAmgKi8E+EXQ==
Date:   Thu, 13 Apr 2023 19:46:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 5/7] cache: Add L2 cache management for Andes AX45MP
 RISC-V core
Message-ID: <20230413-staunch-superman-e71fd3303176@spud>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412-cheddar-prune-5ce03ccf5581@spud>
 <20230413-aorta-unheated-c9bb35411fb2@wendy>
 <CA+V-a8uksWMihUadYc_dCoef7vaC5ncOicX0oGpSP9HRnHgScw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6bszEhgICHV8EU9d"
Content-Disposition: inline
In-Reply-To: <CA+V-a8uksWMihUadYc_dCoef7vaC5ncOicX0oGpSP9HRnHgScw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6bszEhgICHV8EU9d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 13, 2023 at 07:26:02PM +0100, Lad, Prabhakar wrote:

> > The simplest solution may to just be making the erratum depend on 64BIT?
> >
> I dont think this will work, as pmem.c is compiled unconditionally.

That'll teach me to write things like this first thing in the morning.
I somehow got it in my head that the alternative would be removed by the
preprocessor if it was not enabled. After testing it, that's not what
happened.
My excuse is being tired from the gym and insufficiently caffeinated,
sorry!

> Is
> dma-noncoherent.c also valid for RISCV-32? If not then we can make
> pmem.c compile conditionally if DMA non-coherenet is enabled and we
> make DMA non-coherent depend on 64bit.

Could you drop the {s,l}d in exchange for {s,l}w instead, or am I
progressing even further into braino territory?

--6bszEhgICHV8EU9d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDhOFwAKCRB4tDGHoIJi
0tHLAPwMAkpigYtBeE6Huhop+HfVeqFO0LwF/DytZT0oSBXxCQEAmalXMvPCM79U
C5gBqaKtslyS+cqEkubCtYILczu9sA0=
=Ri/X
-----END PGP SIGNATURE-----

--6bszEhgICHV8EU9d--
