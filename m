Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02577600483
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJQAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJQAXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:23:46 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765C4A467
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 17:23:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 58A5732000E5;
        Sun, 16 Oct 2022 20:23:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 16 Oct 2022 20:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665966220; x=
        1666052620; bh=ZIUfdLEJM0ESSCfpLb2R/9KS4n4WMO0lvEA3/NHP6A8=; b=T
        hYdeYXKl560bjMe3OlyucaVWmv/AjIGzk4nkOTXEmwX8LK47QAvg1q7VsMu3oVPG
        1dG9xwZCpCbfm9MPZ5ug0p41OPKOnWDOqc6o+qZVOfbO/woQyVOx5Z6QzKO0ipX0
        qQZ8+bo0V5O8GbHbAcM0I2m+cBp8Ne7FoAXZ1Dm+FpIDonoRJ++7jdPQ+watgM9w
        F1W/ZWcIPXoNhrBFDHd+1eat1KDXCAxDCZWa008F5atJopgjh3qBda6Fi+7si1ly
        lEJhqh+CopaNdnyoVy5ngOEMKLZfP+3Z3Z9giaW2WoHwYulQ9A6VXwex9NZQhImv
        thW9R3PBviY0LqPwcfI+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665966220; x=1666052620; bh=ZIUfdLEJM0ESSCfpLb2R/9KS4n4W
        MO0lvEA3/NHP6A8=; b=Ro0CozzNteOPB+Mq8IJ+ZTYksRC3E2G+n6a6PMxe4uSO
        KfQXUJ6V4WuTrPBbZsoHwOK7g+JvaE/18u3CTtqH3iufAPgCkB7G3eIlKiIdOu9G
        4gO1aOW1gMfUzZDMHGQ5S4U65otiychfYTsDfS9hY57C1yfLyQ6z+cs61otqAXPF
        GDO4YPIrtDDPtDxmWZxvUqQduSUf4g+jJWRDncnrlVWYWz7P/rnAu/3SPThX7HWw
        VIBOjD+BZD9YPF9cfMIBifB4eASZIO2q7P3WT6BVFpxSM8gW9rXZ/PTcdJ8y0RYb
        EQRc/zERa8HPhfPHeIoBQc5kR9Kgb6OdM7mxQR5JVA==
X-ME-Sender: <xms:jKBMY-6xzOUCJS1IE-LTLb1klukxYROoQ9mtJ7HTdU82P4h_4q6S7Q>
    <xme:jKBMY36yYXN7akIQ8XvO_os_rjvtyoKnzSliZBU6_qEUb16k5WEQpkwrPIou5qGwA
    EoqOcFUw86IEA>
X-ME-Received: <xmr:jKBMY9eLfq7jbZll3ZpX2YUIsAh5aZi3O29bbkJnQKq7sUyJFA9twxNh5FCTR824csfnQdSGtRziPbV7q028Ts72WVQaKY6qe2El>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfff
    vdduieefueeiteeuleefhefhhffhheefvefhleekheevgfeludefuddvgfehnecuffhomh
    grihhnpehorhhgrdgrshdpkhgvrhhnvghlrdhorhhgpdigvghnrdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghkse
    hinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:jKBMY7IgnJ4npWQSoElk5FtBjNQLce4vm74SBBY6K7-EotlepdWa0Q>
    <xmx:jKBMYyKcNYrsYdIAUQUYaO_QWrSXmyxVNw6Q1GWedF8c4qkdRDVD0g>
    <xmx:jKBMY8yiWO8Z-XYp8zrhrjgOJ22JfyvyP4E87IG6He_DWDu0SAnO6g>
    <xmx:jKBMY3Hj4a5HlIiejK0FiLP2UfCQgvLU-kBabu-fL2OsA3_om_3lnw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Oct 2022 20:23:39 -0400 (EDT)
Date:   Mon, 17 Oct 2022 02:23:35 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Denis Chancogne <denis.chancogne@free.fr>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: Bug 216581 - Kernel panic on /init as busybox symbolic link with
 xen efi
Message-ID: <Y0ygiO3kuazXWSfZ@mail-itl>
References: <e2cf3207-e9e9-5585-1a6e-9b39d96b4b54@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dkVdQrOLWpDCDP3c"
Content-Disposition: inline
In-Reply-To: <e2cf3207-e9e9-5585-1a6e-9b39d96b4b54@leemhuis.info>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dkVdQrOLWpDCDP3c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Oct 2022 02:23:35 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Denis Chancogne <denis.chancogne@free.fr>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: Bug 216581 - Kernel panic on /init as busybox symbolic link with
 xen efi

On Sun, Oct 16, 2022 at 01:08:53PM +0200, Thorsten Leemhuis wrote:
> Hi, this is your Linux kernel regression tracker speaking.
>=20
> I noticed a regression report in bugzilla.kernel.org. As many (most?)
> kernel developer don't keep an eye on it, I decided to forward it by
> mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D216581 :
>=20
> >  Denis Chancogne 2022-10-13 22:00:19 UTC
> >=20
> > Created attachment 302995 [details]
> > /proc/cpuinfo, .config
> >=20
> > Hi,
> >=20
> > when I start Xen 4.15.3 in efi with kernel 5.18.19, all works well;
> > but since kernel 5.19, I have a kernel panic on my /init process as
> > busybox symbolic link inside initramfs.
> >=20
> > This is the kernel log :
> > ...
> > [    6.265122] Run /init as init process
> > [    6.266027] traps: init[1] trap invalid opcode ip:5855d1 sp:7ffe5ced=
deb0 error:0 in busybox[401000+1db000]
> > [    6.266553] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000004
> > [    6.267039] CPU: 3 PID: 1 Comm: init Tainted: G        W         5.1=
9.0-dch #1
> > [    6.267522] Hardware name: Micro-Star International Co., Ltd. MS-7B8=
4/B450M PRO-M2 (MS-7B84), BIOS 2.E0 06/12/2020
> > [    6.268010] Call Trace:
> > [    6.268495]  <TASK>
> > [    6.268974]  dump_stack_lvl+0x45/0x5e
> > [    6.269455]  panic+0x107/0x285
> > [    6.269923]  do_exit.cold+0x15/0x45
> > [    6.270389]  do_group_exit+0x28/0x90
> > [    6.270852]  get_signal+0x9f1/0xa40
> > [    6.271313]  arch_do_signal_or_restart+0x57/0x7b0
> > [    6.271771]  ? _raw_spin_unlock+0x10/0x30
> > [    6.272223]  ? finish_task_switch.isra.0+0x8e/0x270
> > [    6.272674]  ? __switch_to+0x186/0x400
> > [    6.273118]  exit_to_user_mode_prepare+0xc8/0x150
> > [    6.273564]  irqentry_exit_to_user_mode+0x5/0x20
> > [    6.274003]  asm_exc_invalid_op+0x16/0x20
> > [    6.274441] RIP: 0033:0x5855d1
> > [    6.274877] Code: f6 48 89 ef e8 90 79 03 00 48 c7 05 cd 2e 0c 00 01=
 00 00 00 48 89 2d 26 a2 0c 00 4c 8d 74 24 20 4c 8d 6c 24 40 4c 8d 64 24 18=
 <c5> f9 ef c0 48 b8 f6 75 ae 03 01 00 00 00 4c 8d 3d 8c 02 0a 00 c5
> > [    6.275776] RSP: 002b:00007ffe5ceddeb0 EFLAGS: 00010202
> > [    6.276221] RAX: 0000000000000000 RBX: 00000000004006c8 RCX: 0000000=
000000001
> > [    6.276670] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000=
000648400
> > [    6.277116] RBP: 00000000009e0060 R08: 00007ffe5cfdf178 R09: 0000000=
0effffef5
> > [    6.277561] R10: 0000000070000022 R11: 0000000000000032 R12: 00007ff=
e5ceddec8
> > [    6.278003] R13: 00007ffe5ceddef0 R14: 00007ffe5cedded0 R15: 0000000=
06ffffeff
> > [    6.278442]  </TASK>
> > [    6.278903] Kernel Offset: disabled
> >=20
> > I try to decode it :
> >=20
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   f6 48 89 ef             testb  $0xef,-0x77(%rax)
> >    4:   e8 90 79 03 00          call   0x37999
> >    9:   48 c7 05 cd 2e 0c 00    movq   $0x1,0xc2ecd(%rip)        # 0xc2=
ee1
> >   10:   01 00 00 00=20
> >   14:   48 89 2d 26 a2 0c 00    mov    %rbp,0xca226(%rip)        # 0xca=
241
> >   1b:   4c 8d 74 24 20          lea    0x20(%rsp),%r14
> >   20:   4c 8d 6c 24 40          lea    0x40(%rsp),%r13
> >   25:   4c 8d 64 24 18          lea    0x18(%rsp),%r12
> >   2a:*  c5 f9 ef c0             vpxor  %xmm0,%xmm0,%xmm0               =
 <-- trapping instruction
> >   2e:   48 b8 f6 75 ae 03 01    movabs $0x103ae75f6,%rax
> >   35:   00 00 00=20
> >   38:   4c 8d 3d 8c 02 0a 00    lea    0xa028c(%rip),%r15        # 0xa0=
2cb
> >   3f:   c5                      .byte 0xc5
> >=20
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0:   c5 f9 ef c0             vpxor  %xmm0,%xmm0,%xmm0
> >    4:   48 b8 f6 75 ae 03 01    movabs $0x103ae75f6,%rax
> >    b:   00 00 00=20
> >    e:   4c 8d 3d 8c 02 0a 00    lea    0xa028c(%rip),%r15        # 0xa0=
2a1
> >   15:   c5                      .byte 0xc5
> >=20
> > Regards,
> > Denis
> > PS:
> >    denis@srv2 ~ $ gcc --version
> >    gcc (Gentoo 11.3.0 p4) 11.3.0
>=20
> See the ticket for more details.

Thanks for forwarding.

This is already fixed on the Xen side: https://xenbits.xen.org/gitweb/?p=3D=
xen.git;a=3Dcommit;h=3Dc3bd0b83ea5b7c0da6542687436042eeea1e7909
The commit is also in 4.15 branch already:
https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D7923ea47e578bca3=
0a6e45951a9da09e827ff028,
to be included in 4.15.4 rather soon.

> BTW, let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>=20
> #regzbot introduced: v5.18..v5.19
> #regzbot ignore-activity
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>=20
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
>=20

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--dkVdQrOLWpDCDP3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmNMoIgACgkQ24/THMrX
1yzOPwgAmgb1Jv7o6emM9Sph12uByVIwpSzX34Ssad33eaHD4V2AtdeZoT4ZN321
znX7WcK/ThI+lHkfPGdyKnNHrSNMLL/NXbT25XJ6UKduSPmky633Zb8JbN+lSKIE
kQpFs3FwJ3Oen/78ct0FjhkpCgsIvXNvEz6yXlQ42qn5KBT0R+p4e+XQRMr/WSFu
FyRziMOe4e3zhGbpmZCd2SEKZk5i2EiiqOeF+bI2KS6yyx9HztpTYKn1WdafqjYo
fWdH32ZvSA5K53B1TiWFmB+qbvjsyS97U88cxiFEcQrqK0QNF5dvZEQhtZSac/7y
KTwLUTIY8ad6uBSxPJgFQpW532aIoQ==
=MEPX
-----END PGP SIGNATURE-----

--dkVdQrOLWpDCDP3c--
