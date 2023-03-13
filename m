Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34646B8052
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjCMSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCMSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC87C97E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 11:20:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51B2C61476
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 18:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B98C433EF;
        Mon, 13 Mar 2023 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678731638;
        bh=hWZMAojXtdkUk6KFcyUE0Rz28e+UOMEvZEJ96F+azlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knALUTadtrScx9Y9mKwpTpov9X7zeATC4Joo8OUk0+vUJfvIBwRf6fGxEDeFWEDsv
         KGadp18xHvxd7l6SQ8+bPK9WPuJb8fL5PpnkCPhpmZjLiQQAPWZUKZanqAOwGLh2WV
         cmMiDuSMrtGob+DSXw96C6WOh2eBAJecnFemtOHkUJ7JaRD8dwtuOVi/RxcQkQtWfb
         MOjXHJ/NuLcycZc38YO+xqjqJJ/awT86FlmD52x3ig9WdIw7P8DYXADcS5C5Pjzvmy
         sBGeLqNSWoPUkAwrBU1WzeSngkKyNKI/yIY5s5Gpv+Tm/y6VSLRJFTVMqIRQzaRBXh
         HgIZ7Q05tozJw==
Date:   Mon, 13 Mar 2023 18:20:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, pierre.gondois@arm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "riscv: Set more data to cacheinfo"
Message-ID: <b9138aac-9f53-4e75-9377-660c5a6c9e25@spud>
References: <20230308064734.512457-1-suagrfillet@gmail.com>
 <20230308113510.fb6y2xhylavkrgtl@bogus>
 <CAAYs2=jFe_ejN9O26AMCZqDtnVkt1bpyMUw2nx1Q9t=SBWj79A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZOtQIau5vhqWU/6/"
Content-Disposition: inline
In-Reply-To: <CAAYs2=jFe_ejN9O26AMCZqDtnVkt1bpyMUw2nx1Q9t=SBWj79A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZOtQIau5vhqWU/6/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 07:54:45AM +0000, Song Shuai wrote:
> Hi, Conor & Sudeep :
>=20
> Sudeep Holla <sudeep.holla@arm.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=89 11:35=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Wed, Mar 08, 2023 at 02:47:34PM +0800, Song Shuai wrote:
> > > This reverts commit baf7cbd94b5688f167443a2cc3dcea3300132099.
> > >
> > > There are some duplicate cache attributes populations executed
> > > in both ci_leaf_init() and later cache_setup_properties().
> > >
> > > Revert the commit baf7cbd94b56 ("riscv: Set more data to cacheinfo")
> > > to setup only the level and type attributes at this early place.
> > >
> >
> > I had noticed the same and had something similar when we did some rework
> > around for v6.1 merge window. But there were lot of other issues to be
> > addressed at the moment and hence deferred this.
> >
> > So for the change in general, but as Conor responded, it would be good
> > to do some checking to ensure nothing breaks and all the requirements
> > this patch(baf7cbd94b56) addressed are already handled in the core.
>=20
> As you suggested, commit (da29dbcda49d "riscv: Add cache information
> in AUX vector")
> in the "Get cache information from userland" series should be checked.
>=20
> The commit da29dbcda49d adds the cacheinfo (read from
> ci_cacheinfo(cpu)) in ELF auxiliary vectors,
> so process can fetch the cacheinfo through glibc sysconf() after ELF load=
ing.
> At the same time, the glibc related support was enabled by its commit
> (15b38ffc10 "riscv: Get cache information through sysconf")
>=20
> With this reverting patch applied, the output of `getconf -a` looks good
> in Qemu sifive_u machine and rootfs image with glibc-2.35.

If, as I think you're implying, it is unchanged before/after:
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--ZOtQIau5vhqWU/6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZA9pVQAKCRB4tDGHoIJi
0om5AP4iccnul9cT0OrpPO01ZCjDIOxZ78jM8HFJl3V76uGWoAD8DL+ICgZ6Bb0w
SzWLYX3+MYIrd1PDzPDzuSA7odXTaAg=
=kkO8
-----END PGP SIGNATURE-----

--ZOtQIau5vhqWU/6/--
