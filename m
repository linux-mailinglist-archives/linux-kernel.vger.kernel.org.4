Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF0642567
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiLEJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLEJGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:06:47 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1286C19299
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:05:17 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-381662c78a9so111123827b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wdu4bsG5xgkThcYOXY86ahES33TNsVdoYqUgiSYsG/Y=;
        b=dpN/MeyyuLfiyJBCIeL6ELZAeGno4AXJefsrLhX7cHahmJhJ0s96UAJKVkhQSNEd4b
         SIUNcjtHFNBtzxlEiS07c6dsxpu46Qr06rJW62GzpRGTPsAYD5eTHExciZ3+PIhvmQW9
         5GLyh0VCiJdi3jXZ4RT/omv4EiipDtTVP6N4BQe+YEM7jJ4eYE5OMahTJFRMKz58Ujau
         CzaLxV4lzGbiioK0vDB6LSoXlZrl7UpQddkpKxs9RjALCYa5XFjDKpvaOr0VejpVwXje
         RTjD3THAKaAkRXHhzsAocCShqa4u63Vygy44+5KSWXEAcikXiC63ehOU6OZaodymm1Wd
         gLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wdu4bsG5xgkThcYOXY86ahES33TNsVdoYqUgiSYsG/Y=;
        b=nN/u5Il28mACYjJAkxxmwyjUMRdDm4atR81LLPbnKwQxqXpl7LqDdulf8Jcc/eWjQp
         M0z3WbX36aJvuBYomCE68aSghxWI2Ss661ihtp8cudxrb62e2Olhhhmr6vdbaZTujX4C
         hWYn631Gs/+06gxk/rkCf/UMJ3ekwThO2OcNut2svnLZOytDlBBLzYmU5kG5DWnbhQIS
         Biz+Aup3Vm+RUR2UzELKqU24V/EbURTfyb7h9zleuhH6qw31pyEU1YL/GWUPl728PbQ1
         rlfugdf1WCFOpq6qJNaFhdHOjdD5Fs2hknDvaNbx7UrXi2eJNDxj6V0BMI3+KrB6e5S+
         Nqqw==
X-Gm-Message-State: ANoB5pkv/HNXzdjqbUA7U65nYxf/zkRWcEvoGs71YWHElmwPF1YEVtBs
        p2Kal2h3zqbRiK7g2oSAuJVP+vva3UmgtOWZoOFX3U3ESG0=
X-Google-Smtp-Source: AA0mqf66u723hcFyUAvf7sJPf6iAL/2pHtFD70JMVkjMWqtITJbH+Uo+Ej0X4Ebq4G6rCQo7pc2TKcSddNEVRt20eps=
X-Received: by 2002:a05:690c:78e:b0:3d2:d9e7:a68d with SMTP id
 bw14-20020a05690c078e00b003d2d9e7a68dmr24384374ywb.224.1670231116068; Mon, 05
 Dec 2022 01:05:16 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPTWs8J6sGjcyDrRsXu5APDHm5Kr19G500y=72=FwYCq3g@mail.gmail.com>
 <Y4C94LluYLGcf1Wt@hirez.programming.kicks-ass.net> <CAM7-yPTxgndDR+c1at+y6GngkpKz9h8cFT68cTmdRkcMuGVBQA@mail.gmail.com>
In-Reply-To: <CAM7-yPTxgndDR+c1at+y6GngkpKz9h8cFT68cTmdRkcMuGVBQA@mail.gmail.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Mon, 5 Dec 2022 18:05:03 +0900
Message-ID: <CAM7-yPR3imeU_Zd5GUzv3mr8yv0SSbU58XxadroXSeidgCR-sg@mail.gmail.com>
Subject: Re: [Question] About UNWIND_HINT_ENTRY on entry_SYSCALL_64.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jpoimboe@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

When I try to orc dump on vmlinux.o and vmlinux of v6.1-rc8,

I got the below result.

In case of vmlinux.o:
$ readelf -Ws vmlinux.o  | grep entry_SYSCALL_64
    153848: 0000000000000029     0 NOTYPE  GLOBAL DEFAULT   20
entry_SYSCALL_64_safe_stack
    175564: 0000000000000038     0 NOTYPE  GLOBAL DEFAULT   20
entry_SYSCALL_64_after_hwframe
    178264: 00000000000310d0    26 NOTYPE  GLOBAL DEFAULT    4
xen_entry_SYSCALL_64
    182002: 0000000000000000   407 NOTYPE  GLOBAL DEFAULT   20 entry_SYSCALL_64
$ readelf -WS vmlinux.o | grep "\[20\]"
  [20] .entry.text       PROGBITS        0000000000000000 e47d40
001a00 00  AX  0   0 64

$ ./tools/objtool/objtool --dump=orc vmlinux.o
    .entry.text+0: sp:(und) bp:(und) type:call end:1
In case of vmlinux:
$ readelf -Ws vmlinux | grep entry_SYSCALL_64
134594: ffffffff81e00029     0 NOTYPE  GLOBAL DEFAULT    1
entry_SYSCALL_64_safe_stack
156328: ffffffff81e00038     0 NOTYPE  GLOBAL DEFAULT    1
entry_SYSCALL_64_after_hwframe
159033: ffffffff81031b30    26 NOTYPE  GLOBAL DEFAULT    1 xen_entry_SYSCALL_64
162772: ffffffff81e00000   407 NOTYPE  GLOBAL DEFAULT    1 entry_SYSCALL_64

$ readelf -WS vmlinux | grep "\[ 1\]"
  [ 1] .text             PROGBITS        ffffffff81000000 200000
1002288 00  AX  0   0 4096

$ ./tools/objtool/objtool --dump=orc vmlinux
    .text+e00000: sp:sp+8 bp:(und) type:call end:0



My question is "why vmlinux binary's orc information about
entry_SYSCALL_64 is different from vmlinux.o"?
IIUC, the result of .text+e00000 should be the same to vmlinux.o's
result -- sp:(und) bp:(und) type:call end:1

Am I missing?

Thankx.






On Mon, Nov 28, 2022 at 2:31 PM Yun Levi <ppbuk5246@gmail.com> wrote:
>
> Thanks Peter and Sorry for the late answer.
>
> I got the same result on the vmlinux.o file when I compiled the recent version.
>
> But when I try to test on some of distribution version of linux, (ex)
> debian. and When I try to on vmlinux not on vmlinux.o
>
> I got some different results like below.
>
> $ readelf -Ws /usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 |
> grep entry_SYSCALL_64
> 123448:    ffffffff81a00000 404 NOTYPE GLOBAL DEFAULT 1 entry_SYSCALL_64
>
> $ readelf -WS /usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 | grep "\[1\]"
>   [ 1] .text             PROGBITS        ffffffff81000000 200000
> c01988 00  AX  0   0 4096
>
> 123448: ffffffff81a00000   404 NOTYPE  GLOBAL DEFAULT    1 entry_SYSCALL_64
>
>
> 123448: ffffffff81a00000   404 NOTYPE  GLOBAL DEFAULT    1 entry_SYSCALL_64
>
> $ tools/objtool/objtool --dump=orc
> /usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 | grep
> "text+a00000"
> .text+a00000: sp:(und) bp:(und) type:call end:0
>
> Am I wrong?
>
> Thanks!
>
> On Fri, Nov 25, 2022 at 10:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Nov 25, 2022 at 07:41:46PM +0900, Yun Levi wrote:
> > > Hello.
> > >
> > > While I try to see the information related to ORC in vmlinux,
> > > I'm trying to find out ORC information related to entry_SYSCALL_64's address.
> > >
> > > For this, I've tried to take the following step:
> > >     1. booting the kernel with the "nokaslr" option.
> > >     2. Getting ORC information by "objdump orc dump vmlinux"
> > >     3. cat /proc/kallsyms and check the address of "entry_SYSCALL_64"
> > >           - In my kernel, It's address .text + a00000
> > >     4. Find out related ORC entry gotten in step 2.
> > >
> > > But, I couldn't find the reason why entry_SYSCALL_64's orc info isn't
> > > encoded with end =1.
> > > Instead, It was encoded as INVALID ORC entry like:
> > >
> > >   .text+a00000: sp:(und) bp:(und) type:call end:0
> > >
> > > IIUC, Some of the code is started with UNWIND_HINT_ENTRY or UNWIND_HINT_EMPTY,
> > > it should be encoded with end = 1. But it doesn't.
> > >
> > > Am I wrong?
> >
> > $ readelf -Ws defconfig-build/vmlinux.o | grep entry_SYSCALL_64
> > 178466: 0000000000000029     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_safe_stack
> > 188596: 0000000000000000   422 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64
> > 210374: 0000000000000038     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_after_hwframe
> >
> > $ readelf -WS defconfig-build/vmlinux.o | grep "\[18\]"
> > [18] .entry.text       PROGBITS        0000000000000000 e59f00 001838 00  AX  0   0 64
> >
> > $ tools/objtool/objtool --dump=orc defconfig-build/vmlinux.o | grep ".entry.text+0"
> > .entry.text+0: sp:(und) bp:(und) type:call end:1
> >
> >
