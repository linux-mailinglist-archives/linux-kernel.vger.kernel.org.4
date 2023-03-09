Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C06F6B2C61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCIRxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCIRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:53:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6712863;
        Thu,  9 Mar 2023 09:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A992B8203F;
        Thu,  9 Mar 2023 17:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4134DC433EF;
        Thu,  9 Mar 2023 17:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678384376;
        bh=tSnYD5TKu07sh4hOMBDMyiXJ+PlHpoDk7TYI6ItZI/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pgc/USXonPVwpeSHvHbZrCSzEHEHzSjEmTPK+QJzU72d4gZ3kvE3xWy8OYAcyUhGD
         NH0RFUtapIvISHlJFlZ4fqKQMzFSLfWdjGBcJKvIzQUkSFN7lrvKFhJTWVIMvZOUCi
         KvrcSHIJh8Oy1qtXlQguNImHdOLU9edcPyDhb5cpRCUJgdJ4Bwtt+r5zJAStXkzG8E
         DgOrXzhutO7M1Y/D5JYAquB2crngTr9x+fy21vMDuguJYPLeJnUrpAU0KDePWgaVhn
         ZGbHTWUoa0gAh6HDGlOuMuQx9lOI2Vd3aywnK6yq4LDoGjWrL6RCi6Ri8tCjr8/3Oj
         KwjhPFPMTqlYA==
Date:   Thu, 9 Mar 2023 17:52:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <09630acb-f1ae-4dbd-9c9c-9adb1743bfe4@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
 <ZAb7JVghuiwZF1Q5@wendy>
 <2f03dfb2-5cf8-e954-913c-f0c27db6bcf5@starfivetech.com>
 <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <4c071642-e3c8-4716-a580-5b42e25efb1c@spud>
 <ZAoOLIERMYI8UVlA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ftganqtRBXwbLJs2"
Content-Disposition: inline
In-Reply-To: <ZAoOLIERMYI8UVlA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftganqtRBXwbLJs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 09, 2023 at 05:49:48PM +0100, Tommaso Merciai wrote:
> On Wed, Mar 08, 2023 at 01:36:41PM +0000, Conor Dooley wrote:
> > On Wed, Mar 08, 2023 at 01:28:01PM +0100, Tommaso Merciai wrote:
> > > On Tue, Mar 07, 2023 at 06:08:53PM +0800, Hal Feng wrote:
> >=20
> > > > The above two methods can fix the problem. Here are my test results.
> > > > The VisionFive board can boot up successfully if and only if all ab=
ove
> > > > two applied.
> > > > The VisionFive 2 board can boot up successfully if I merge Linus's =
new
> > > > changes.
> > >=20
> > > Tested also on my side. Hope this can be helpfull.
> > >=20
> > > > Hope your fix will be merged in rc2. Thank you for your reply.
> > >=20
> > > Fully agree.
> >=20
> > If you only have a VisionFive 2, it shouldn't matter to you, as you
> > don't need to fix up any SiFive errata (at the moment at least).
> > Linus' fix is already in his tree, so should be in -rc2!
> > The fix for the VisionFive was applied to Palmer's RISC-V fixes tree
> > last night:
> > https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/=
?h=3Dfixes&id=3Dbf89b7ee52af5a5944fa3539e86089f72475055b
> >=20
> > Thanks,
> > Conor.
>=20
>=20
> Hi Conor,
> Thanks for the info.
> Playing with this series I got the following error:
>=20
> [    6.278182] BUG: spinlock bad magic on CPU#0, udevd/136
> [    6.283414]  lock: 0xffffffd84135e6c0, .magic: ffffffff, .owner: <none=
>/-1, .owner_cpu: -1
> [    6.291677] CPU: 0 PID: 136 Comm: udevd Not tainted 6.3.0-rc1-g9256990=
1a7f9-dirty #14
> [    6.299502] Hardware name: StarFive VisionFive 2 v1.3B (DT)
> [    6.305069] Call Trace:
> [    6.307517] [<ffffffff80005530>] dump_backtrace+0x1c/0x24
> [    6.312921] [<ffffffff80844b4e>] show_stack+0x2c/0x38
> [    6.317976] [<ffffffff8085032c>] dump_stack_lvl+0x3c/0x54
> [    6.323377] [<ffffffff80850358>] dump_stack+0x14/0x1c
> [    6.328429] [<ffffffff80845668>] spin_dump+0x64/0x70
> [    6.333394] [<ffffffff80058f26>] do_raw_spin_lock+0xb4/0xf2
> [    6.338970] [<ffffffff80857d04>] _raw_spin_lock+0x1a/0x22
> [    6.344370] [<ffffffff8008153c>] add_timer_on+0x8a/0x132
> [    6.349684] [<ffffffff8084b9fa>] try_to_generate_entropy+0x216/0x278
> [    6.356037] [<ffffffff804ebfdc>] urandom_read_iter+0x40/0xb8
> [    6.361697] [<ffffffff801a1216>] vfs_read+0x17e/0x1f8
> [    6.366752] [<ffffffff801a1986>] ksys_read+0x5e/0xc8
> [    6.371710] [<ffffffff801a19fe>] sys_read+0xe/0x16
> [    6.376503] [<ffffffff8000357a>] ret_from_syscall+0x0/0x2
> [    6.381905] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000007
> [    6.390683] Oops [#1]
> [    6.392956] Modules linked in:
> [    6.396011] CPU: 0 PID: 136 Comm: udevd Not tainted 6.3.0-rc1-g9256990=
1a7f9-dirty #14
> [    6.403835] Hardware name: StarFive VisionFive 2 v1.3B (DT)
> [    6.409401] epc : enqueue_timer+0x1a/0x90
> [    6.413414]  ra : add_timer_on+0xe2/0x132
> [    6.417425] epc : ffffffff80080c60 ra : ffffffff80081594 sp : ffffffc8=
044dbc60
> [    6.424640]  gp : ffffffff814ffe50 tp : ffffffd8c171ad00 t0 : 66666666=
66663c5b
> [    6.431855]  t1 : 000000000000005b t2 : 666666666666663c s0 : ffffffc8=
044dbcc0
> [    6.439070]  s1 : ffffffc8044dbd08 a0 : ffffffd84135e6c0 a1 : ffffffc8=
044dbd08
> [    6.446284]  a2 : ffffffffffffffff a3 : 000000003e000000 a4 : 00000000=
0000023e
> [    6.453498]  a5 : 000000000000023e a6 : ffffffd84135f930 a7 : 00000000=
00000038
> [    6.460712]  s2 : ffffffd84135e6c0 s3 : 0000000000000040 s4 : ffffffff=
81501080
> [    6.467926]  s5 : ffffffd84135e6c0 s6 : ffffffff815011b8 s7 : ffffffff=
ffffffff
> [    6.475141]  s8 : ffffffff81502820 s9 : 0000000000000040 s10: 0000002a=
b0a49320
> [    6.482355]  s11: 0000000000000001 t3 : ffffffff81512e97 t4 : ffffffff=
81512e97
> [    6.489569]  t5 : ffffffff81512e98 t6 : ffffffc8044db948
> [    6.494875] status: 0000000200000100 badaddr: 0000000000000007 cause: =
000000000000000f
> [    6.502783] [<ffffffff80080c60>] enqueue_timer+0x1a/0x90
> [    6.508095] [<ffffffff8084b9fa>] try_to_generate_entropy+0x216/0x278
> [    6.514448] [<ffffffff804ebfdc>] urandom_read_iter+0x40/0xb8
> [    6.520107] [<ffffffff801a1216>] vfs_read+0x17e/0x1f8
> [    6.525160] [<ffffffff801a1986>] ksys_read+0x5e/0xc8
> [    6.530126] [<ffffffff801a19fe>] sys_read+0xe/0x16
> [    6.534918] [<ffffffff8000357a>] ret_from_syscall+0x0/0x2
> [    6.540322] Code: 87b2 0813 0805 1613 0037 9832 3603 0008 e190 c211 (e=
60c) 5613
> [    6.547711] ---[ end trace 0000000000000000 ]---
> [    6.552325] note: udevd[136] exited with irqs disabled
> [    6.557531] note: udevd[136] exited with preempt_count 2
>=20
>=20
> I'm working on top of Linux version 6.3.0-rc1-g92569901a7f.

Unfortunately, this g<sha> bit doesn't mean anything outside of your
repo so it's hard to infer anything from that.
This looks exactly like a bug is in v6.3-rc1, but Linus fixed in like
the second commit *after* -rc1.

What branch/commit/tag did you apply the series on top of?

Cheers,
Conor.

--ftganqtRBXwbLJs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAoc7gAKCRB4tDGHoIJi
0hqoAP9Q/Y807Ff1Ehl18kMUcI74l4ooj6GxDNovwBXX6FhNDgD/XAKgS/j7V8GF
IRtvWI8/M3LWtKucwI2uVqt1YzTxwws=
=YnEf
-----END PGP SIGNATURE-----

--ftganqtRBXwbLJs2--
