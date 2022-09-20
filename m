Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658425BEE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiITUXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiITUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 16:23:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225895723B;
        Tue, 20 Sep 2022 13:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663705415;
        bh=h6gv9PlmKnvxPi82tH8JhJLH/uYc0Z0zySdp6jbifIY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=cwUs4Kqs8TYRV8OcOulZDB+c7ClXtN7kUSXhiSx1hFoGuCd4Twu2TP3xb4C5TqBzN
         l2LTISxJY7e2oGtNPL4Y1Qg50xjCzvl0Di8XSrlB341t/TzX3HpdGNe6cZyTXNgAOE
         jVp7noAgJuq+NsqKYzGGw8LN2PgSCYb2PwemJDhg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma24s-1op5mN1w2O-00Vyqz; Tue, 20
 Sep 2022 22:23:35 +0200
Message-ID: <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
Date:   Tue, 20 Sep 2022 22:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Build regressions/improvements in v6.0-rc5
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-parisc@vger.kernel.org
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <20220912091325.1780524-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9Jd6J4vdbb9Ym4yaWggKuO2dzkfsLwCz3ylb5YPuujlOPztUcMj
 aKqD20omebDaQ40+2enXelicrgSPGCvbNHoM1qJoJfxAxq2u2qLNK2QFyqUMWQYido1OgR5
 W0eQmv0zu4n/oKYVexrPs7uPAyLLD9UlCX3ZOlrYWozJxfe+U1/p15XOPYsqaBRSM8h0RNg
 cUgiP3bXzQQkxZClHvXtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mu/C18ZnMAk=:5TpbHaKIuvEaw79rNHE6Np
 LiN9ArMQjHB21ckRE5PtwhjwN0eHTW5WzxRTOfD7waDg1TCXASimLgoq9SZNxaSe1R91qgVRF
 kr71KdWofeIsgGgsJHRg68JVl3+G1oQB0RILUu/g8/jWJ55KOxXguISV9dF8y08BQ6hVt/fri
 63g+NgK0ZzkaOIvJGg7bIaxBf77tIhA3zWWMWvEVKidMV9hCm/52rtT9NEKuq5A9VrQdPisV+
 uD+8rm9g2bpNRCIl9aF4pvfakHFznzXpa9w4dwUuWT52O4gATFPzPxiLIXc53jOUhRs2k1mi3
 asxiJesdeKll3u3VFfuttfSpqpaPJYBV929Q4YlbayyVzsJtXP/3o3bv69dhFSbttdhmFAQd6
 hXx2JTjrdtVRG7NcB45ULzYRrlL85g2kMn874wjN+lQaTW6Lb17cYRyPoJUiqLf7dRwsKa/gx
 EGDQIbqLJ3Pbz33sEkb8zfQ3khom37OUCtmOiFGN1sBKMt/K1zPd6kW8W5h2kT1ux49wlNmQw
 ZXPzCJKYlUN+IKO1w7bFOM4HVhbZRFX7uAw4mlVnsxm4Ems/4T8ODC5avnxzNDIwrl2grNvAn
 Dva7n1P1pUTbMMPCVa+X8Y/DbeZ/31gQ/cWKqLPkH20qYBiI7SUqQ+Ki6Bt5wXTqSIfN7jQIC
 stnamCUdVt5qQw+OvtPAB5v0o1APB5Ej+/uYxdii1akfB3cWhTc8TZUmZ6HA5tWnPOQw7wOLt
 xGn8GhHQhiVyt556r4ObXgCUmt0MaajzvRVBbWFmnWzx/Xn5Dm/h3HxZzW4YqJz0MaaDs9j6C
 dbLgqdIaZNlK2Uf9oqhTiurfSCqNhJkpTowSuEyucPMJOVTbTa21UGY5fZ3YH46ti37BwsLck
 pO4NoWy3XCQQVq/YStnlSx4sQfS1OtjgadgC5f+LTJ3fpntz6JonmRN0Z9L3i8hI8YfibyQH/
 aN39znm154A4sOTijTC6mrkKbjvmVUioKDWTVfKjFckU9uAULmlpGvl9pkJysg1HaL1dc8Wv7
 hYlDeIagQv4djJcGjpj2xLOV6nnZPwQwxEDSLG4lGI5LGIfMBPWaA6dpeddah2BuBbdWE+Lvj
 oTBJTv3Im38IRPjljWyx5wzDLrtw+6Lsb/K6S6imOmygO4r7RF1XSreYZCB34qqEPxbAP8RGC
 fsukYPpZtSZyUqCYtdQ0n0shfj
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 11:22, Geert Uytterhoeven wrote:
> On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
>> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>> =C2=A0- build errors: +16/-1
>
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: .cfi_endproc without corresponding .cfi_startproc:=C2=A0 =3D> 32
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: bad or irreducible absolute expression:=C2=A0 =3D> 16
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: junk at end of line, first unrecognized character is `:':=C2=A0 =3D> 16
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: no such instruction: `be 0x100(%sr2,%r0)':=C2=A0 =3D> 29
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: no such instruction: `ldi 0,%r20':=C2=A0 =3D> 30
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error=
: no such instruction: `ldw 0(%sp),%r31':=C2=A0 =3D> 26
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no su=
ch instruction: `ble 0x100(%sr2,%r0)':=C2=A0 =3D> 46, 51
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no su=
ch instruction: `ldi 0,%r25':=C2=A0 =3D> 44
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no su=
ch instruction: `ldi 1,%r25':=C2=A0 =3D> 49
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no su=
ch instruction: `ldi 173,%r20':=C2=A0 =3D> 45, 50
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.callinfo':=C2=A0 =3D> 40
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.entry':=C2=A0 =3D> 41
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.exit':=C2=A0 =3D> 54
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.proc':=C2=A0 =3D> 39
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.procend':=C2=A0 =3D> 55
>  =C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unkno=
wn pseudo-op: `.stringz':=C2=A0 =3D> 76
>
> parisc-gcc8/generic-32bit_defconfig
>
>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce86de=
0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280=
c85b76967a9106a13ca61c16179/ (all 135 configs)

I see those errors on the kiss website, but I'm unable to reproduce them.
Downloaded that .config, used same compiler (from https://mirrors.edge.ker=
nel.org/pub/tools/crosstool/files/bin/x86_64/8.5.0/)....
Not sure how to get this fixed.
If someone has an idea or can reproduce, please let me know.

Helge
