Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ED3655A28
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 13:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiLXMnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 07:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 07:43:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AE3B848
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:43:20 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so9328927pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 04:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hku3trGz8x4JXrmOHI8NFJ1bCCPcWV/c0fRyuHQ+QbI=;
        b=brEQNuy8dUoV4T2nzqlhHgh9O/toBGWE33wVpTv35fO3kUX9tYqJ7gNoQLW/RJ0A1p
         zLqS21XURtAlB+ZAfKJiLLGTesl5zCWBOV1mta8jNZapMAcQHrdMI9tXV2wvuuM5+jZ0
         WXAxcZMfe9ue2iltsVOsVSTkmNzhsn5URZH6Z1h+5wcqzcbqbJak2omvjz61EoJapRPJ
         VKyo+C33ceI6gld7912RkkLRTDkUyYao2nKLiM/rGWVBarrXLE7wFYnbd0DNV/HlPCjL
         oeo8TslIR9R31Ag9ltolKEXGRiS9SEfITCyJ+FRgvSB80G6UOq1rRr1uY1df+IAjc20C
         BKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hku3trGz8x4JXrmOHI8NFJ1bCCPcWV/c0fRyuHQ+QbI=;
        b=X2Q0w2Ixv6nRjdEqmPy8++1DrZjlkKQnxr2AORRIBgVqU1eRtyk6kIr/f3Kzyw00kW
         7fSxlIgEDeF5r30l/5ppjlDybU4k/bVzgGLOV8ucoon/QlfmwXCufGTizY3JHSUxT3/+
         /6NBEF3Dw3NtBIXG2fiCu9nBngXuZxJcrKzSi8HpWHiV2xrj+7/HAmmVjY2Xt4vMZY/v
         fdjl46ZIqjrS4ggonnbuE5VaphKdUjmvdPPcriB+8Ce58sPxjDnL4PWsUkD7soW8FifH
         VbYs+tlDmipu0U1kAUCAkxyK5gztKm4ZWUp1cs1/8dN/KO/DidRSARZbrWLmwQOmQqgT
         NLAQ==
X-Gm-Message-State: AFqh2kol8sTQeXYAUjkZjOKxdXRtMJ/ox3BbUgkA1n+Hs3IPzVBujcGT
        vp42rT5IIXkZH2QXUhFwugA=
X-Google-Smtp-Source: AMrXdXsLbN964DC73bKkCFHB9NpvSSBc7/OcD9P/Bzd0q7V3Xd7gQBPkhgxvPPrXzmBAKsd1NNgPHw==
X-Received: by 2002:a17:902:6b4b:b0:189:8790:73b1 with SMTP id g11-20020a1709026b4b00b00189879073b1mr23597014plt.65.1671885799706;
        Sat, 24 Dec 2022 04:43:19 -0800 (PST)
Received: from debian.me (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b00186b7443082sm4013786plb.195.2022.12.24.04.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Dec 2022 04:43:19 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5029010056A; Sat, 24 Dec 2022 19:43:15 +0700 (WIB)
Date:   Sat, 24 Dec 2022 19:43:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs write error Linux v6.2
Message-ID: <Y6bz4wOC0nwu2yGU@debian.me>
References: <CAAJw_Ztzyh-GNTJYpXbA0CeJv2Rz=fLZKE6_Q=7JMmM+s9yHXQ@mail.gmail.com>
 <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="73V9cWVAnlvQOfAi"
Content-Disposition: inline
In-Reply-To: <CAAJw_Ztb0mJVkHtBhryf=9g8CA0fZZRa8HVio8GCGUSLOvqa7A@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--73V9cWVAnlvQOfAi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 24, 2022 at 01:48:55PM +0800, Jeff Chua wrote:
> Got the following error in latest linux-6.2-git with just vim (:w
> file1). No problem with linux-6.1.1
>=20
> 2022-12-22T14:09:51.419409+08:00 [localhost] kernel: BUG: kernel NULL
> pointer dereference, address: 0000000000000024
> 2022-12-22T14:09:51.419422+08:00 [localhost] kernel: #PF: supervisor
> write access in kernel mode
> 2022-12-22T14:09:51.419423+08:00 [localhost] kernel: #PF:
> error_code(0x0002) - not-present page
> 2022-12-22T14:09:51.419424+08:00 [localhost] kernel: PGD 147b63067 P4D
> 147b63067 PUD 177d5c067 PMD 0
> 2022-12-22T14:09:51.419424+08:00 [localhost] kernel: Oops: 0002 [#7] PREE=
MPT SMP
> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: CPU: 6 PID: 22891
> Comm: vi Tainted: G     UD            6.1.0 #11
> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: Hardware name:
> LENOVO 21CCS1GL00/21CCS1GL00, BIOS N3AET69W (1.34 ) 12/05/2022
> 2022-12-22T14:09:51.419428+08:00 [localhost] kernel: RIP:
> 0010:f2fs_issue_flush+0x10e/0x180
> 2022-12-22T14:09:51.419429+08:00 [localhost] kernel: Code: ba 01 00 00
> 00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
> 84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
> ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
> 2022-12-22T14:09:51.419429+08:00 [localhost] kernel: RSP:
> 0018:ffffc90000b13df0 EFLAGS: 00010246
> 2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RAX:
> ffff888101caccc0 RBX: 0000000000000000 RCX: 0000000000000000
> 2022-12-22T14:09:51.419430+08:00 [localhost] kernel: RDX:
> 0000000010000088 RSI: 000000000005a844 RDI: ffff8881027bf000
> 2022-12-22T14:09:51.419431+08:00 [localhost] kernel: RBP:
> ffff8881027bf000 R08: 0000000000000000 R09: ffff8881027bf2a8
> 2022-12-22T14:09:51.419431+08:00 [localhost] kernel: R10:
> 0000000000000000 R11: 0000000000000000 R12: 0000000000000024
> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: R13:
> 000000000005a844 R14: 000000000005a844 R15: 0000000000000000
> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: FS:
> 00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
> knlGS:0000000000000000
> 2022-12-22T14:09:51.419432+08:00 [localhost] kernel: CS:  0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> 2022-12-22T14:09:51.419433+08:00 [localhost] kernel: CR2:
> 0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
> 2022-12-22T14:09:51.419433+08:00 [localhost] kernel: PKRU: 55555554
> 2022-12-22T14:09:51.419434+08:00 [localhost] kernel: Call Trace:
> 2022-12-22T14:09:51.419434+08:00 [localhost] kernel: <TASK>
> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
> preempt_count_add+0x63/0x90
> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
> preempt_count_add+0x63/0x90
> 2022-12-22T14:09:51.419435+08:00 [localhost] kernel: ?
> preempt_count_add+0x63/0x90
> 2022-12-22T14:09:51.419436+08:00 [localhost] kernel:
> f2fs_do_sync_file+0x489/0x650
> 2022-12-22T14:09:51.419436+08:00 [localhost] kernel: __x64_sys_fsync+0x2f=
/0x60
> 2022-12-22T14:09:51.419437+08:00 [localhost] kernel: do_syscall_64+0x35/0=
x80
> 2022-12-22T14:09:51.419437+08:00 [localhost] kernel:
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RIP: 0033:0x7ff03fee=
f20b
> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: Code: 3d 00 f0 ff
> ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 a3 a2 f8
> ff 8b 7c 24 0c 41 89 c0 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35
> 44 89 c7 89 44 24 0c e8 01 a3 f8 ff 8b 44
> 2022-12-22T14:09:51.419438+08:00 [localhost] kernel: RSP:
> 002b:00007ffe6ecca530 EFLAGS: 00000293 ORIG_RAX: 000000000000004a
> 2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RAX:
> ffffffffffffffda RBX: 0000000000000001 RCX: 00007ff03feef20b
> 2022-12-22T14:09:51.419439+08:00 [localhost] kernel: RDX:
> 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000003
> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: RBP:
> 0000000000002000 R08: 0000000000000000 R09: 00000000024bcfb0
> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R10:
> fffffffffffff4bf R11: 0000000000000293 R12: 00000000000006b7
> 2022-12-22T14:09:51.419440+08:00 [localhost] kernel: R13:
> 000000000000003d R14: 0000000000000000 R15: 00000000024a1680
> 2022-12-22T14:09:51.419441+08:00 [localhost] kernel: </TASK>
> 2022-12-22T14:09:51.419441+08:00 [localhost] kernel: Modules linked
> in: [last unloaded: ecc]
> 2022-12-22T14:09:51.419442+08:00 [localhost] kernel: CR2: 0000000000000024
> 2022-12-22T14:09:51.419442+08:00 [localhost] kernel: ---[ end trace
> 0000000000000000 ]---
> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RIP:
> 0010:f2fs_issue_flush+0x10e/0x180
> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: Code: ba 01 00 00
> 00 be 03 00 00 00 e8 ad e8 d5 ff 48 83 3b 00 74 1e 48 89 e7 e8 7f c1
> 84 00 f0 ff 4b 24 8b 44 24 2c e9 66 ff ff ff <f0> ff 43 24 e9 4a ff ff
> ff 45 31 ff 4c 87 7b 28 4d 85 ff 74 d6 44
> 2022-12-22T14:09:51.419443+08:00 [localhost] kernel: RSP:
> 0018:ffffc90003903df0 EFLAGS: 00010246
> 2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RAX:
> ffff888100106d80 RBX: 0000000000000000 RCX: 0000000000000000
> 2022-12-22T14:09:51.419444+08:00 [localhost] kernel: RDX:
> 0000000010000088 RSI: 0000000000b0e2ba RDI: ffff888116227000
> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: RBP:
> ffff888116227000 R08: 0000000000000000 R09: ffff8881162272a8
> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R10:
> 0000000000000000 R11: 0000000000000000 R12: 0000000000000024
> 2022-12-22T14:09:51.419445+08:00 [localhost] kernel: R13:
> 0000000000b0e2ba R14: 0000000000b0e2ba R15: 0000000000000000
> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: FS:
> 00007ff03fdf0b80(0000) GS:ffff88883f380000(0000)
> knlGS:0000000000000000
> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CS:  0010 DS:
> 0000 ES: 0000 CR0: 0000000080050033
> 2022-12-22T14:09:51.419446+08:00 [localhost] kernel: CR2:
> 0000000000000024 CR3: 000000013d64e006 CR4: 0000000000770ee0
> 2022-12-22T14:09:51.419447+08:00 [localhost] kernel: PKRU: 55555554

Thanks for the report! I'm adding this to regzbot:

#regzbot ^introduced v6.1.1..v6.2
#regzbot title f2fs: kernel NULL pointer dereference when writing file

--=20
An old man doll... just what I always wanted! - Clara

--73V9cWVAnlvQOfAi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6bz3gAKCRD2uYlJVVFO
owUUAQCppJJJG4N/qhLBTOEB/w+WcOZaHxDB5LbG9H8iI112VAD8C4I8cLR6ojGF
YOsgfnR9fQFRH2NX8sLkmR/ynHm8FQk=
=YH4j
-----END PGP SIGNATURE-----

--73V9cWVAnlvQOfAi--
