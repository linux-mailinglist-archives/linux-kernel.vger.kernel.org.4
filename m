Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF435E4F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIUSaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIUS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:29:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F979EE0;
        Wed, 21 Sep 2022 11:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663784984;
        bh=b3lVnjzHJnI2hox1U6bYkV03+nrOPmxwirOzuMk0ql8=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=ashkB3EVKY6wJv4SqMG43od/dABHvVr2MwAP/TFXvtJ7Toj7XBb9lw0G8ybJIHpDV
         gmMOigIxP1LETzuanRb/8Odzwg69ZQRG5OycR4LxuM8K/FiIIzvIuuPbIhcysncfmE
         KBXtkOiIk33tdSL41xni3bhIuc+wf15RNplB9zjc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.154.88]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MG9kM-1oVaIt3oR2-00GV44; Wed, 21
 Sep 2022 20:29:43 +0200
Message-ID: <a26ed5e3-1b87-22c5-2761-141a0bdb55e6@gmx.de>
Date:   Wed, 21 Sep 2022 20:29:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Build regressions/improvements in v6.0-rc5
Content-Language: en-US
From:   Helge Deller <deller@gmx.de>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-parisc@vger.kernel.org
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com>
 <20220912091325.1780524-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
 <647e2197-8f89-f5a0-a60b-476aff2fd134@gmx.de>
 <d54e7e26-7797-bedb-142a-2101a4e497de@infradead.org>
 <812d649c-380b-8a7e-1584-891c7e643656@gmx.de>
In-Reply-To: <812d649c-380b-8a7e-1584-891c7e643656@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pMW3MyEJ6WJm3MJXRP8eaTk9sCS5ZRC2bnbyPDBJsw27f2EW0k0
 dD4g3nlpt0K6PmTq5KiAhVG6O+uitUkyFfj1CagUG84P/01VgxTMhYJtlPiCbWdxKWl8TrR
 BTLM1oO+QJiCrFpaNEzJBjx3NpK98OWYN3WZsvh1sJxmxB47DGgoBh+lj3nX1HSqusdSSm4
 9n6yC/EDdYpLq6g3yZFRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHUQxoo7DIs=:Ig9YKERrLlKJ26inOBDJ4L
 AaF8rDDp345z/a5xtPyf2Poj8ItPosdinOpdNXC9KKvushGGirqXWj9xf0x8IMdjb9bSufShU
 qIuGX8dhWl6wPqlR+MwLpuQqbbddgmqqBbm5SlSbHZwVNSdZOg+nBO/Z94KqBRBTWv0fL4ujc
 uj6u5/LVjsgm4TgFFSO2iwFh19gjNw74pwom4XMLPzfP2A9N4idl4hZTLXf5ZjsYtY+x8F4SL
 Yqm3qpfqEsJhkCRBo1r/679iGbqNHJJ0GdGCd019jKgJ8h8tx3X62Bf+K6b63gVDSTMY8ifD7
 Rqyu3nIqOyio+QdwPzDR1GS8min8CliE9Nebt+B2KQbFQHCL5pOaY2+K8PGYRdgry9zuhk7wU
 5YjJsKzIkT3vDHv8c7ctQzL008CuUNorhq+waFgoYgSxpZv1pD8Qn/V7YZs6ehqWtfa1jqDWz
 e7MKBc4Cez52RpkgH48flJjhExtvdmsUaZ+6FdyL2p6kSz7yTiQdhBLGPFodBcVu9V0WPW4LE
 3t2t2a0MV3NfNOVYffJRNJZDuccyAzLGvWXJXwK6mOTBBCvsU0EWFdznzC9Hle629Cg070Jbb
 GLvgEBr5DY2mJ+MUstj0oGui1dAO7G3/3JiQGs50mm13ZZqUU2HBAkSdLG3KFvjduxrRi0MbP
 Eu+CH/wURsc8F1mZFjJ4W3JbmupGNzPWusxML2tyvxXJnJmWasMEJx3qkL03UHYNg/7f/kZhZ
 rgfiwb0bKS8Gmqz4SaGL2S/LJkZKcBVGhpZU74FRLM1wszVRJNyQ+KNxwsu+BXidhYLQX50kj
 YyyMyE++nq5I3gwmBcHcEbdCuHr7DmNYivzWrSGHTmVQhI6Qys8r1wq+aZJuDNWF6FUHJC+xo
 wVt5QS2Ujc46Po23aohIXy9QrkKT+Seev7qVYXTIxUjDAV4p69TAtah8Iv2w6pK8fTYCGqo2+
 8FblabLlBrj3zA62z9ufweqG94KqAwJchnMW3JK/h07zqPh45Z1XV0eEjXU096SlVrx9Ij6HJ
 gK4a1pnLfGEasZ6rd9hDhxYKnahXmeW/X5vob7Slv2OuseSUfhETa6i9TzCF1GUI6H7qm198j
 Qm8/bOnXUDF18d5EFswngLhZmJyGK9uR+6ZOmum00ezfOBDIeJvqlB3+gIRJCo3fNqtJCTTN7
 1QcdMn7Oa9rT5uRw+q2KvBDbFY
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 23:07, Helge Deller wrote:
> On 9/20/22 22:29, Randy Dunlap wrote:
>>
>>
>> On 9/20/22 13:23, Helge Deller wrote:
>>> On 9/12/22 11:22, Geert Uytterhoeven wrote:
>>>> On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
>>>>> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>>>>> =C2=A0=C2=A0- build errors: +16/-1
>>>>
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: .cfi_endproc without corresponding .cfi_startproc:=C2=A0 =
=3D> 32
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: bad or irreducible absolute expression:=C2=A0 =3D> 16
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: junk at end of line, first unrecognized character is `:':=
=C2=A0 =3D> 16
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':=C2=A0 =3D> 29
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `ldi 0,%r20':=C2=A0 =3D> 30
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/restart_sy=
scall.S: Error: no such instruction: `ldw 0(%sp),%r31':=C2=A0 =3D> 26
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ble 0x100(%sr2,%r0)':=C2=A0 =3D> 46, 51
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 0,%r25':=C2=A0 =3D> 44
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 1,%r25':=C2=A0 =3D> 49
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: no such instruction: `ldi 173,%r20':=C2=A0 =3D> 45, 50
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.callinfo':=C2=A0 =3D> 40
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.entry':=C2=A0 =3D> 41
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.exit':=C2=A0 =3D> 54
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.proc':=C2=A0 =3D> 39
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.procend':=C2=A0 =3D> 55
>>>> =C2=A0=C2=A0=C2=A0 + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S=
: Error: unknown pseudo-op: `.stringz':=C2=A0 =3D> 76
>>>>
>>>> parisc-gcc8/generic-32bit_defconfig
>>>>
>>>>> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce8=
6de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
>>>>> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b=
280c85b76967a9106a13ca61c16179/ (all 135 configs)
>>>
>>> I see those errors on the kiss website, but I'm unable to reproduce th=
em.
>>> Downloaded that .config, used same compiler (from https://mirrors.edge=
.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.5.0/)....
>>> Not sure how to get this fixed.
>>> If someone has an idea or can reproduce, please let me know.
>>
>> Hi,
>> I can reproduce it using the (x86_64 hosted) crosstool gcc-12.1.0 from =
kernel.org that Arnd builds/provides.
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/
>
> Ah....
> Building with "make=C2=A0 ARCH=3Dparisc=C2=A0 CROSS_COMPILE=3D/some/path=
/nolibc/hppa-linux/bin/hppa-linux-"
> uses this CROSS_COMPILE prefix for compiling the .c files, but not for t=
he .S files.
> So, you will end up with the default hppa-linux-gcc installed on the sys=
tem, not the one provided
> by CROSS_COMPILE.

Ok, it seems CROSS_COMPILE doesn't work as one would expect (and as it did=
 in the past).
I'm not sure if this can be fixed.

Since kernel v5.18 the parisc kernel comes with a 32-bit and a 64-bit vDSO=
.
On parisc we have two compilers:
- hppa-linux-gnu-gcc for 32-bit, and
- hppa64-linux-gnu-gcc for 64-bit code.
There is no -m64 flag like on x86 which can be used to just use one compil=
er for both targets.
If you provide a CROSS_COMPILE command, you can only provide either a 32- =
or 64-bit compiler,
so e.g. you won't be able to build the 64-bit kernel and a 32-bit vDSO wit=
h the same compiler.

Instead of using CROSS_COMPILE, please just install your compiler(s) and m=
ake sure that
the compiler(s) can be found via the PATH environment variable.
In arch/parisc/Makefile (line 42ff) various variants like hppa-linux-gnu-g=
cc or
hppa1.1-unknown-linux-gnu-gcc will be searched.

So, instead of
  make ARCH=3Dparisc CROSS_COMPILE=3D/opt/cross/kisskb/korg/gcc-8.5.0-noli=
bc/hppa-linux/bin/hppa-linux-
please use for 32-bit:
  PATH=3D/opt/cross/kisskb/korg/gcc-8.5.0-nolibc/hppa-linux/bin/:$PATH    =
 make ARCH=3Dparisc
or for 64-bit:
  PATH=3D/opt/cross/kisskb/korg/gcc-8.5.0-nolibc/hppa64-linux/bin/:$PATH  =
 make ARCH=3Dparisc64

I haven't yet checked how other platforms do it, but I'm open for any sugg=
estions
how this could be made easier.

Helge
