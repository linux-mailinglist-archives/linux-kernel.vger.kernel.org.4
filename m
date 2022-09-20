Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0BB5BEEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiITVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiITVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:07:56 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA602C65C;
        Tue, 20 Sep 2022 14:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663708067;
        bh=FY/027MdEt7VHiqxESLr1uiJg3YevGL8OTTvvD0CbN0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YRc16Aw56sOd4hdfXjMNPYiuTOSive/j6SRH4QaXBZkgZpbxYveGypuzhe0/Dcv+6
         pM8BNy0HKFNPI9T5/T98huA50hB/DHUxGjomd+1zQetjyhXpNrwIOlR22NfeafBktG
         yxPX/HKuZRhlC1hj9+nEHxip8E1l6GE+bEVANtfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.94]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1oUOfz3RvN-00Fnqm; Tue, 20
 Sep 2022 23:07:46 +0200
Message-ID: <812d649c-380b-8a7e-1584-891c7e643656@gmx.de>
Date:   Tue, 20 Sep 2022 23:07:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Build regressions/improvements in v6.0-rc5
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-parisc@vger.kernel.org
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <20220912091325.1780524-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
 <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
 <d54e7e26-7797-bedb-142a-2101a4e497de@infradead.org>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <d54e7e26-7797-bedb-142a-2101a4e497de@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTOw05CiQm9FZi1XZ3aPOy/ClzrYktLnB275kI/j/8DNf2beldX
 /ZhbbwtFu0J5jsRpnyZ4rn4kUzlXukmG40q01BLRmAn0w4VkE9KFWvP0arULnbRjEqPf5Xl
 EyaRCmTpAsHpVeA2ylihOtkiOYIKnCBGCe4njxuG17YH9IC4nSPzY0zWF43rq5/VyB1n3fE
 8cHoibmfAv+k53j90wk8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EiheGLCqqAc=:FaX+wciKOZwDaZzq8W+3qy
 ztkD63/D5m3ZzHNE2pdSdhbSWiBNuBPsZyA3xWVJDLXBoYv9O8dH9ignYOXf17fEzjTo70pbS
 ZZaJnmY3e1WFctHpgu4JKhSLFFTYpraQEehbPxXT3cMzlUAHVETh0PF8W3h0wCgSUZX21PGmo
 vQIoLc3SzK0pr5Pufw9G+7ZAUEv44xzhs6wGgbYjecoZ7606hS/gLBzH+8nY2SwnviaMTZBXl
 CwZ0qYokMuVt/PpsYqBRGbozu7lZ+wUnnYg7s6ngVw5bBZJ8W7op9PRmdJ4V4EfOsY0XKTYJH
 BjSAKuOlpykxQQkFK4G0xBrT49Rjc2nKFocBHirOaE5pMdDDJO/CInNOUmwi3bdBMVypyLBgq
 vUpzPkKsdzHJSTIJJFYlBH2yYTDdVdkTxLQkhyE7LwdHdHELaytyNg12DGAj/2Sa8Tp4Snwnx
 gIWHfjzc0IfpdKRs69JrJcB5WBa1yZceW734NbO5bqxLR8uhT9oCQVujvaQOQbJaYMPjCURde
 +0BrCYrM+PTsHkfp5jgnSZy+l93G0XO4kCETxX6cCDYQ0JcKGfQm2GFINECy2R3NZdf7+VTQq
 /esv57P5pKciwc2UoiAF6MOsRfY7GwN4BXU+/zNyFxARu0vLXrQLMM7oY1A7541iGzbBp1n6I
 r7dGvxjRTxwVq/IUn0tbMn1EHzBqCqw6xTraTZk05x7ULGM7wF+BG/UxsJ3s49qcVzNFgYbOr
 HWGxhCJSWwqW1X4vnfpR4kmvJxx5sQv32+HJwwQEJUEJxMB3XeJmqSCcNrqOiy6WpCFY3RWpe
 Z9Q1HXnm7XmHlWSa520uitJmkIcIdDy41JzA1h/2reAAoz/+1tk7fGhW335bFQuim9r+R8UbC
 vBhCKh1vig+hWz+QgW6qkB3SAcRBsA1ytfIK+5ltq9gwQtXc9lhdI50yrozHXOY/M+mjS6uBD
 5dc19f7NJTjnfHrugDVu+a7nueBnACylCk4kcJf2hDd3fSmIYmGLf9zlw1MmqkeSPu51B2F7E
 /H6N9bC5CPvutSCv04dIIzZ01NkEfPzQPnC6P9ew+WlB9/885+lPs1dU0pdF2R7AV1GsdiDBo
 sUzN1OonHRjBJfF6aWd0P8Bdvy2RG23VyT+N47pW1sKF/s+F99pL/T8ohTjSMkw3Gp+1CKuEz
 Zx7syH+sb/dGdh5yJsj5eVJYBe
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 22:29, Randy Dunlap wrote:
>
>
> On 9/20/22 13:23, Helge Deller wrote:
>> On 9/12/22 11:22, Geert Uytterhoeven wrote:
>>> On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
>>>> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>>>>  =C2=A0- build errors: +16/-1
>>>
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: .cfi_endproc without corresponding .cfi_startproc:=C2=A0 =3D> 32
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: bad or irreducible absolute expression:=C2=A0 =3D> 16
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: junk at end of line, first unrecognized character is `:':=C2=A0 =
=3D> 16
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: no such instruction: `be 0x100(%sr2,%r0)':=C2=A0 =3D> 29
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: no such instruction: `ldi 0,%r20':=C2=A0 =3D> 30
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.=
S: Error: no such instruction: `ldw 0(%sp),%r31':=C2=A0 =3D> 26
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: no such instruction: `ble 0x100(%sr2,%r0)':=C2=A0 =3D> 46, 51
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: no such instruction: `ldi 0,%r25':=C2=A0 =3D> 44
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: no such instruction: `ldi 1,%r25':=C2=A0 =3D> 49
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: no such instruction: `ldi 173,%r20':=C2=A0 =3D> 45, 50
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.callinfo':=C2=A0 =3D> 40
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.entry':=C2=A0 =3D> 41
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.exit':=C2=A0 =3D> 54
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.proc':=C2=A0 =3D> 39
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.procend':=C2=A0 =3D> 55
>>>  =C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Erro=
r: unknown pseudo-op: `.stringz':=C2=A0 =3D> 76
>>>
>>> parisc-gcc8/generic-32bit_defconfig
>>>
>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce86=
de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
>>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b2=
80c85b76967a9106a13ca61c16179/ (all 135 configs)
>>
>> I see those errors on the kiss website, but I'm unable to reproduce the=
m.
>> Downloaded that .config, used same compiler (from https://mirrors.edge.=
kernel.org/pub/tools/crosstool/files/bin/x86_64/8.5.0/)....
>> Not sure how to get this fixed.
>> If someone has an idea or can reproduce, please let me know.
>
> Hi,
> I can reproduce it using the (x86_64 hosted) crosstool gcc-12.1.0 from k=
ernel.org that Arnd builds/provides.
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Ah....
Building with "make  ARCH=3Dparisc  CROSS_COMPILE=3D/some/path/nolibc/hppa=
-linux/bin/hppa-linux-"
uses this CROSS_COMPILE prefix for compiling the .c files, but not for the=
 .S files.
So, you will end up with the default hppa-linux-gcc installed on the syste=
m, not the one provided
by CROSS_COMPILE.

Helge
