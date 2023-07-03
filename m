Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BC5746152
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGCRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCRU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B941A2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49CA660C5D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71A6C433C7;
        Mon,  3 Jul 2023 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688404856;
        bh=y9wEsiZXyMPaTL1dz0sjw4tTNmtFP1iOCMu/WZMYAGg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5kWLy04Vh29pBF15GMTK7VVXipussQgzPetfQjHeO20xmumzR4NpUqShnMI933JV
         XKBQC7oZK0AqKopK6UkhPJp5hpWQMTWlAevajrAL7RkbYLfVSwTjR1i1WBgxX5r9lI
         ryIrrZz0TFpyN7O/tQpIFhwvZ6efHdsxaWD73fGu1Gawr2PUL/SqtuJMhoo6lKIVJG
         gNSh2equqVnL7yINCYDD5HdP+KQhWUXdmSJI4iyrfeHbjMkyfKNetwF+EYOn49Ivqp
         qprxxVTyG1inisDIKQkc/X1MTtAJctew+DyJxLcFWrIVU+DFfs364JbroMwVdfCD0q
         mAliLxNMjk2dg==
Date:   Mon, 3 Jul 2023 18:20:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Marc Zyngier <maz@kernel.org>, lkp <oliver.sang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <20230703-regalia-preachy-136bf396e320@spud>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <20230703-dupe-frying-79ae2ccf94eb@spud>
 <CAHk-=wg+jqA6nt36TxAfoqWskRAzhVfzBejcK6PNYXC+QcwyiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hjaB+7n9azmsAWzn"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg+jqA6nt36TxAfoqWskRAzhVfzBejcK6PNYXC+QcwyiA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjaB+7n9azmsAWzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2023 at 10:07:28AM -0700, Linus Torvalds wrote:
> On Mon, 3 Jul 2023 at 10:00, Conor Dooley <conor@kernel.org> wrote:
> >
> > I'm not entirely sure if it is related, as stuff in the guts of mm like
> > this is beyond me, but I've been seeing similar warnings on RISC-V.
>=20
> No, that RISC-V warning is also about bad RCU usage, but that's a
> different thing.
>=20
> >         RCU used illegally from offline CPU!
> >         rcu_scheduler_active =3D 1, debug_locks =3D 1
> >         1 lock held by swapper/1/0:
> >          #0: ffffffff8169ceb0 (rcu_read_lock){....}-{1:2}, at: rcu_lock=
_acquire+0x0/0x32
> >
> >         stack backtrace:
> >         CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-10173-ga901a356=
8fd2 #1
> >         Hardware name: riscv-virtio,qemu (DT)
> >         Call Trace:
> >         [<ffffffff80006a20>] show_stack+0x2c/0x38
> >         [<ffffffff80af3ee0>] dump_stack_lvl+0x5e/0x80
> >         [<ffffffff80af3f16>] dump_stack+0x14/0x1c
> >         [<ffffffff80083ff0>] lockdep_rcu_suspicious+0x19e/0x232
> >         [<ffffffff80ad4802>] mtree_load+0x18a/0x3b6
> >         [<ffffffff80091632>] __irq_get_desc_lock+0x2c/0x82
> >         [<ffffffff80094722>] enable_percpu_irq+0x36/0x9e
> >         [<ffffffff800087d4>] riscv_ipi_enable+0x32/0x4e
> >         [<ffffffff80008692>] smp_callin+0x24/0x66
>=20
> This is also triggering on the maple tree sanity checks, but it' sa
> different maple tree, and a different code sequence.
>=20
> And a different case of suspicious RCU usage - not a lack of locking,
> but simply using RCU before marking the CPU online.

Ah, I probably should've known from the
         RCU used illegally from offline CPU!
that it was different.

> I suspect the riscv_ipi_enable() in the RISC-V version of smp_callin()
> needs to be moved down to below the
>=20
>         set_cpu_online(curr_cpuid, 1);
>=20
> or was there some reason why it needed to be done quite _that_ early
> in commit 832f15f42646 ("RISC-V: Treat IPIs as normal Linux IRQs")?
>=20
> Added guilty parties to the cc.

Taking the rationale & potential problems out of the equation, that
code movement does suppress the complaints from rcu/maple tree,
thanks.

Cheers,
Conor.

--hjaB+7n9azmsAWzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKMDdAAKCRB4tDGHoIJi
0vOUAQDBe61dBL/6jJbuB/pVGpJGxz/CKpKb4hJOugvgpYOqqQD+KfqWfJ+Mmzq7
JApu5eNi1KLT0/lMstGHqiDDKL5CsQo=
=eiiF
-----END PGP SIGNATURE-----

--hjaB+7n9azmsAWzn--
