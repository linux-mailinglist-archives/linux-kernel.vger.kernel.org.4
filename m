Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F666AD997
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjCGIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCGIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:52:26 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709B92CFF1;
        Tue,  7 Mar 2023 00:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678179142; x=1709715142;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GBiPeesd8xFReVcLee1l9cVo8XbRI4la4GvpsLYlT8=;
  b=elavBS9zHOL8roNB80cIoVwNG2htbeKOBy/b3afssyXzunOoEtcLL+UF
   l7YJthb4RHDsfBseXZIW5uoTR2YWLf3cyzdTttXNavpLmS/5vqZaUqCRX
   3O+/Z5ExYNtKLarpy9kvVhz3PXZfP2xtLAYfz/5rd83mxubusASo7nD6L
   RSVtuJTyH1Iw7fBXCW4BlkpVs5vMtz2T0p2je+wIHQwcRmAFGUehMI4Yj
   jxqSYCwnfZxaQzSVlthZpNHTVMSGscqe86Su+OAi9DpAjMMUrO6kY99PK
   JLuFTW3oPtBNsR0/gOnrXkJIiiKvLPYTUAnwer4M17ilQSTKAFEa1rIkC
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,240,1673938800"; 
   d="asc'?scan'208";a="204037593"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2023 01:52:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Mar 2023 01:52:20 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 7 Mar 2023 01:52:17 -0700
Date:   Tue, 7 Mar 2023 08:51:49 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Hal Feng <hal.feng@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <ZAb7JVghuiwZF1Q5@wendy>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BPAAyqVe2vfLu2rd"
Content-Disposition: inline
In-Reply-To: <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--BPAAyqVe2vfLu2rd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 04:36:41PM +0800, Hal Feng wrote:
> On Tue, 21 Feb 2023 10:46:26 +0800, Hal Feng wrote:
> > This patch series adds basic clock, reset & DT support for StarFive
> > JH7110 SoC. Patch 17 depends on series [1] which provides pinctrl
> > dt-bindings. Patch 19 depends on series [2] which provides dt-bindings
> > of VisionFive 2 board and JH7110 SoC.
> >=20
> > You can simply review or test the patches at the link [3].
> >=20
> > [1]: https://lore.kernel.org/all/20230209143702.44408-1-hal.feng@starfi=
vetech.com/
> > [2]: https://lore.kernel.org/all/20230216131511.3327943-1-conor.dooley@=
microchip.com/
> > [3]: https://github.com/hal-feng/linux/commits/visionfive2-minimal
>=20
> Hi Conor,
>=20
> When I tried to rebase these patches on v6.3-rc1, I found the kernel
> would crash on the VisionFive 2 board during startup. The logs are as
> below. I checkout the branch to the mainline and found that the kernel
> would also crash on the VisionFive board which is equipped with JH7100
> SoC.
>=20
> --------------------------------
> Unable to handle kernel paging request at virtual address 0000004cccccccd4
> Oops [#1]
> Modules linked in:
> CPU: 3 PID: 87 Comm: udevd Not tainted 6.3.0-rc1-00019-g239e7809f291 #305
> Hardware name: StarFive VisionFive 2 v1.3B (DT)
> epc : enqueue_timer+0x18/0x90
>  ra : internal_add_timer+0x2c/0x38
> epc : ffffffff8006a714 ra : ffffffff8006a7b8 sp : ffffffc80443bc80
>  gp : ffffffff80eb5100 tp : ffffffd8c01db200 t0 : 0000000000000000
>  t1 : 000000000000000f t2 : 0000000038b3ea28 s0 : ffffffc80443bcb0
>  s1 : ffffffff80813940 a0 : ffffffff80813940 a1 : ffffffc80443bd48
>  a2 : 000000000000020b a3 : cccccccd0b000000 a4 : cccccccccccccccc
>  a5 : 000000000000020b a6 : ffffffff80814a08 a7 : 0000000000000001
>  s2 : ffffffc80443bd48 s3 : 0000000008400040 s4 : ffffffff80813940
>  s5 : ffffffff80eea0b8 s6 : ffffffff80eb7220 s7 : 0000000000000040
>  s8 : ffffffff80eb61e0 s9 : 0000002ac84a2548 s10: 0000002ad53e92c0
>  s11: 0000000000000001 t3 : 000000000000003f t4 : 0000000000000000
>  t5 : 0000000000000004 t6 : 0000000000000003
> status: 0000000200000100 badaddr: 0000004cccccccd4 cause: 000000000000000f
> [<ffffffff8006a714>] enqueue_timer+0x18/0x90
> [<ffffffff8006aa64>] add_timer_on+0xf0/0x134
> [<ffffffff80500f18>] try_to_generate_entropy+0x1ec/0x232
> [<ffffffff8035a636>] urandom_read_iter+0x42/0xc2
> [<ffffffff800fff16>] vfs_read+0x17c/0x1e4
> [<ffffffff801005b6>] ksys_read+0x78/0x98
> [<ffffffff801005e4>] sys_read+0xe/0x16
> [<ffffffff800035dc>] ret_from_syscall+0x0/0x2
> Code: 9381 9713 0037 0813 0705 983a 3703 0008 e198 c311 (e70c) d713=20
> ---[ end trace 0000000000000000 ]---
> note: udevd[87] exited with irqs disabled
> Segmentation fault
> FAIL
> Saving random seed:=20
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> rcu: 	1-...0: (0 ticks this GP) idle=3D19c4/1/0x4000000000000000 softirq=
=3D42/42 fqs=3D7474
> rcu: 	(detected by 2, t=3D15005 jiffies, g=3D-195, q=3D35 ncpus=3D4)
> Task dump for CPU 1:
> task:dd              state:R  running task     stack:0     pid:92    ppid=
:88     flags:0x00000008
> Call Trace:
> [<ffffffff80003764>] ret_from_fork+0x0/0xc
> rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> rcu: 	1-...0: (0 ticks this GP) idle=3D19c4/1/0x4000000000000000 softirq=
=3D42/42 fqs=3D29814
> rcu: 	(detected by 2, t=3D60018 jiffies, g=3D-195, q=3D35 ncpus=3D4)
> Task dump for CPU 1:
> task:dd              state:R  running task     stack:0     pid:92    ppid=
:88     flags:0x00000008
> Call Trace:
> [<ffffffff80003764>] ret_from_fork+0x0/0xc
> ...
> --------------------------------
>=20
> I used 'git bisect' and found out the commit 9493e6f3ce02 is the
> cause. I tried to revert this commit on the tag v6.3-rc1, but it
> seems there is no improvement.

Hmm, I'm not entirely sure that that is a good bisect.
This is a fix for my stupidity in the commit you mention:
https://lore.kernel.org/linux-riscv/20230302174154.970746-1-conor@kernel.or=
g/

But the main backtrace there is not from that patch at all, I think it
is Linus' fault.
The HEAD of Linus' tree is currently 8ca09d5fa3549 ("cpumask: fix
incorrect cpumask scanning result checks") should be a fix for the
backtrace that you are seeing above.

> Any options I am missing? Could you please give me some suggestions
> to adapt to the new changes between 6.2 and 6.3? Thank you in
> advance.

LMK if the above two things don't fix it for you & I'll go digging
tonight.

Cheers,
Conor.

--BPAAyqVe2vfLu2rd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAb7FQAKCRB4tDGHoIJi
0qVTAPsHSMwYMcrmOSnP3im30f+2vZGSFqHJchJxrpjd09D3+AD/W49wo6JYEE0K
54n79wuFUj4pxEaLUIJptbE2s62iGQU=
=7ad+
-----END PGP SIGNATURE-----

--BPAAyqVe2vfLu2rd--
