Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADA63A0C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 06:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiK1Fbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 00:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiK1Fbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 00:31:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F0FD00
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:31:31 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g12so15709462lfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 21:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1zE2v0u7Jw666HYaH0IZnXkKAiXC9cX8tI+hIdebbY=;
        b=NWBoPRoBxoNA0uIccD1pUOR8b0TxDFC/WsmwJqaqjX6QJZY1oDc+PCJqIZaVv4KHPg
         92ua2jVseAkoJP3W2SmnLw4O9wFSqYFPo4ketn138GZgMnSY6wo92Cn6wYtcQGsdRiRt
         iPL3uMV6nN0zrIQX0N2fFnlhYUMgRafZBb5wQ6ADdS2f1KV1nRuGZKPDVahiRvh8exR/
         wHw6f9pipszPieKQ09IgCVUD0rVe/wn75VESYPOgEkL6E4t2CDL42MeLZn8AcXdEJDUb
         oYtrVKBeng1Dxgk7AxWA3+pMiKUinoWlZmayE6P+WQXlIUFWe37Z92eIOjP8SCpISimq
         N7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1zE2v0u7Jw666HYaH0IZnXkKAiXC9cX8tI+hIdebbY=;
        b=09eDCXcMU93aOHfv1tfjAG4RM9L708YNboBmlPN6UdoKU5Q3rNuELG9NeNQ5Ml+Auj
         +rGcQQpyOKmDJjE+TkXUK8OKtiUjNeXBOpHVgpdKqob+3Ew2c+iE1ZTX6E6JNzrIz0Yr
         VN6dIoBh1rATWOtAjb0r2WiEdygeyNFkkZwpeU75C+kwhMtQDafMHCvG7SRgXb6U4F+c
         CtpE/PQrnQFqkGPpuIfwislewpA5UmQoaBCx2dGOfdv2g7MoyjVf/Ur6PxNDBZ8aMNov
         CIKeyIOFexg0vF3hGUrMipVzPk0hBsfgeapeB9zG33FkpASIUv7jBfuleMEu8HhMiigJ
         Rctw==
X-Gm-Message-State: ANoB5pmes2uzLmKr1iYaPvtQoRNwl1jTvqGzW21nNAmM4YCdV5JKQBmh
        FOkXi4GRhHR7IuF/XFeQfQej+aeYoX65Tt+zEacchVWtnJI=
X-Google-Smtp-Source: AA0mqf7mDK0sfkqQrQUGNOQVt+pYw/vDFs81hTVbx88WAr77nAKNynSjUbt+m5ggq2x0Pmn2SievjaQ0ZFnRGqw7UBw=
X-Received: by 2002:a05:6512:3603:b0:4b4:b5d8:880d with SMTP id
 f3-20020a056512360300b004b4b5d8880dmr15252103lfs.121.1669613489430; Sun, 27
 Nov 2022 21:31:29 -0800 (PST)
MIME-Version: 1.0
References: <CAM7-yPTWs8J6sGjcyDrRsXu5APDHm5Kr19G500y=72=FwYCq3g@mail.gmail.com>
 <Y4C94LluYLGcf1Wt@hirez.programming.kicks-ass.net>
In-Reply-To: <Y4C94LluYLGcf1Wt@hirez.programming.kicks-ass.net>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Mon, 28 Nov 2022 14:31:17 +0900
Message-ID: <CAM7-yPTxgndDR+c1at+y6GngkpKz9h8cFT68cTmdRkcMuGVBQA@mail.gmail.com>
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

Thanks Peter and Sorry for the late answer.

I got the same result on the vmlinux.o file when I compiled the recent version.

But when I try to test on some of distribution version of linux, (ex)
debian. and When I try to on vmlinux not on vmlinux.o

I got some different results like below.

$ readelf -Ws /usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 |
grep entry_SYSCALL_64
123448:    ffffffff81a00000 404 NOTYPE GLOBAL DEFAULT 1 entry_SYSCALL_64

$ readelf -WS /usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 | grep "\[1\]"
  [ 1] .text             PROGBITS        ffffffff81000000 200000
c01988 00  AX  0   0 4096

123448: ffffffff81a00000   404 NOTYPE  GLOBAL DEFAULT    1 entry_SYSCALL_64


123448: ffffffff81a00000   404 NOTYPE  GLOBAL DEFAULT    1 entry_SYSCALL_64

$ tools/objtool/objtool --dump=orc
/usr/lib/debug/boot/vmlinux-5.18.0-0.deb11.4-amd64 | grep
"text+a00000"
.text+a00000: sp:(und) bp:(und) type:call end:0

Am I wrong?

Thanks!

On Fri, Nov 25, 2022 at 10:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 25, 2022 at 07:41:46PM +0900, Yun Levi wrote:
> > Hello.
> >
> > While I try to see the information related to ORC in vmlinux,
> > I'm trying to find out ORC information related to entry_SYSCALL_64's address.
> >
> > For this, I've tried to take the following step:
> >     1. booting the kernel with the "nokaslr" option.
> >     2. Getting ORC information by "objdump orc dump vmlinux"
> >     3. cat /proc/kallsyms and check the address of "entry_SYSCALL_64"
> >           - In my kernel, It's address .text + a00000
> >     4. Find out related ORC entry gotten in step 2.
> >
> > But, I couldn't find the reason why entry_SYSCALL_64's orc info isn't
> > encoded with end =1.
> > Instead, It was encoded as INVALID ORC entry like:
> >
> >   .text+a00000: sp:(und) bp:(und) type:call end:0
> >
> > IIUC, Some of the code is started with UNWIND_HINT_ENTRY or UNWIND_HINT_EMPTY,
> > it should be encoded with end = 1. But it doesn't.
> >
> > Am I wrong?
>
> $ readelf -Ws defconfig-build/vmlinux.o | grep entry_SYSCALL_64
> 178466: 0000000000000029     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_safe_stack
> 188596: 0000000000000000   422 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64
> 210374: 0000000000000038     0 NOTYPE  GLOBAL DEFAULT   18 entry_SYSCALL_64_after_hwframe
>
> $ readelf -WS defconfig-build/vmlinux.o | grep "\[18\]"
> [18] .entry.text       PROGBITS        0000000000000000 e59f00 001838 00  AX  0   0 64
>
> $ tools/objtool/objtool --dump=orc defconfig-build/vmlinux.o | grep ".entry.text+0"
> .entry.text+0: sp:(und) bp:(und) type:call end:1
>
>
