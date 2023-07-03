Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE774610C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjGCRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCRAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:00:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05FDE59
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DC8760FE2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F33FC433C8;
        Mon,  3 Jul 2023 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688403611;
        bh=//yrLXOg5TqYrAFmFL24fVBml9kYTjoKzuUZX6y5S6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mpwNyCjd+rRiQGr5kZBzM9s7A9Jb7xNRlCiNinnKOGvlQqME2gi6Xev7vBLHESaa0
         nrsjU+qtJxAKZkOp11kDkNeocZQPjidRG5fRRFwPwKSMJdjiFtbBhj8353/cVTzmWw
         ZIpNCgr4/phED4JxzkDAm1Zn3kK0T46SA2P66PQaLZ+lB6y9R9zIb/zwxd9nKE4u7H
         WUEVTqGPUKDrhqHFEXGygC0GdhfJeA8+q6KAHdQ3QZ8E+kp3IrcQr0gezbg+ns3mqn
         +t9M2gl7NfDv/0tJOFMp6X3oz8pX/YOZq4f6AfF2P/Y3x1XRciEub3szLd/xAdCWEm
         HAiGkK0ffQqRQ==
Date:   Mon, 3 Jul 2023 18:00:08 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     lkp <oliver.sang@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <20230703-dupe-frying-79ae2ccf94eb@spud>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JjwO+J+xFJKXPHGH"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JjwO+J+xFJKXPHGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

On Sun, Jul 02, 2023 at 09:34:35PM -0700, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 19:04, kernel test robot <oliver.sang@intel.com> wr=
ote:
> >
> > commit: 408579cd627a15bd703fe3eeb8485fd02726e9d3 ("mm: Update do_vmi_al=
ign_munmap() return semantics")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> >
> > in testcase: boot
> >
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2=
 -m 16G
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>

I'm not entirely sure if it is related, as stuff in the guts of mm like
this is beyond me, but I've been seeing similar warnings on RISC-V. This
is the only hit on lore for "lib/maple_tree.c:{860,816} suspicious
rcu_dereference_check() usage!", so I figured it might be. Apologies if
not!

	Running RCU synchronous self tests
	Running RCU synchronous self tests
	RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=3D1.
	RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=3D1.
	Running RCU-tasks wait API self tests
	riscv: ELF compat mode supported
	ASID allocator using 16 bits (65536 entries)
	rcu: Hierarchical SRCU implementation.
	rcu:     Max phase no-delay instances is 1000.
	EFI services will not be available.
	Callback from call_rcu_tasks_trace() invoked.
	smp: Bringing up secondary CPUs ...
=09
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
	WARNING: suspicious RCU usage
	6.4.0-10173-ga901a3568fd2 #1 Not tainted
	-----------------------------
	lib/maple_tree.c:860 suspicious rcu_dereference_check() usage!
=09
	other info that might help us debug this:
=09
=09
	RCU used illegally from offline CPU!
	rcu_scheduler_active =3D 1, debug_locks =3D 1
	1 lock held by swapper/1/0:
	 #0: ffffffff8169ceb0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x=
0/0x32
=09
	stack backtrace:
	CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-10173-ga901a3568fd2 #1
	Hardware name: riscv-virtio,qemu (DT)
	Call Trace:
	[<ffffffff80006a20>] show_stack+0x2c/0x38
	[<ffffffff80af3ee0>] dump_stack_lvl+0x5e/0x80
	[<ffffffff80af3f16>] dump_stack+0x14/0x1c
	[<ffffffff80083ff0>] lockdep_rcu_suspicious+0x19e/0x232
	[<ffffffff80ad4802>] mtree_load+0x18a/0x3b6
	[<ffffffff80091632>] __irq_get_desc_lock+0x2c/0x82
	[<ffffffff80094722>] enable_percpu_irq+0x36/0x9e
	[<ffffffff800087d4>] riscv_ipi_enable+0x32/0x4e
	[<ffffffff80008692>] smp_callin+0x24/0x66
=09
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
	WARNING: suspicious RCU usage
	6.4.0-10173-ga901a3568fd2 #1 Not tainted
	-----------------------------
	lib/maple_tree.c:816 suspicious rcu_dereference_check() usage!
=09
	other info that might help us debug this:
=09
=09
	RCU used illegally from offline CPU!
	rcu_scheduler_active =3D 1, debug_locks =3D 1
	1 lock held by swapper/1/0:
	 #0: ffffffff8169ceb0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x=
0/0x32
=09
	stack backtrace:
	CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.4.0-10173-ga901a3568fd2 #1
	Hardware name: riscv-virtio,qemu (DT)
	Call Trace:
	[<ffffffff80006a20>] show_stack+0x2c/0x38
	[<ffffffff80af3ee0>] dump_stack_lvl+0x5e/0x80
	[<ffffffff80af3f16>] dump_stack+0x14/0x1c
	[<ffffffff80083ff0>] lockdep_rcu_suspicious+0x19e/0x232
	[<ffffffff80ad4932>] mtree_load+0x2ba/0x3b6
	[<ffffffff80091632>] __irq_get_desc_lock+0x2c/0x82
	[<ffffffff80094722>] enable_percpu_irq+0x36/0x9e
	[<ffffffff800087d4>] riscv_ipi_enable+0x32/0x4e
	[<ffffffff80008692>] smp_callin+0x24/0x66
	smp: Brought up 1 node, 16 CPUs

> > [  215.088258][    T1] WARNING: suspicious RCU usage
>=20
> I think the
>=20
>         validate_mm(mm);
>=20
> call (mm/mmap.c:2561) needs to be moved up to before the
>=20
>         if (unlock)
>                 mmap_read_unlock(mm);
>=20
> that is just a couple of lines earlier.
>=20
> Can you verify that that fixes the warning?

I can't speak for Oliver & LKP, but that change didn't fix it for me,
although my issue could be different of course.

Cheers,
Conor.


--JjwO+J+xFJKXPHGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKL+mAAKCRB4tDGHoIJi
0qKKAQDqS6I7F37/NzWIj4jIr022FOr5u7VJilRRoqh6o9rLrAEAmsXFUU/acvWF
mPKHEcxWheXwpH3t1MFFYptFjMf4RQI=
=HGhi
-----END PGP SIGNATURE-----

--JjwO+J+xFJKXPHGH--
