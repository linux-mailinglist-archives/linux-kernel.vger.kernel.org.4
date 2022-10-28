Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8315611A3E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJ1SkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJ1SkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:40:01 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D84DB2E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:39:58 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id o64so6986488oib.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 11:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrIU+PUJM24Rm/kCu0tWvDDSY2IDCqop9Rnups86MjA=;
        b=mkUDqkPr8W8Lrm9BaPW8IU15IBd626AXK0YxWFN8JEaqt9lpy5r1oGGwMTB1tXW2WL
         PAFNj1YY5btzKAGH+AFgscB1CoCxTKeU5U/9PbP5OD/epHIygfxQn7r8J0Qv1P/VgawY
         bVPKq6AAiZIUQFdq8CkT9wh+GFh/l6c5bxw3bsfeCTNZ1JZMqjg80RSjlPDrLw6bdW9z
         2Yv4AqRFB0dSOlqprMrlTMOBrigqIVYGveRXfJ62o5El1qydp1CizN9Q7Kxcopz65DJC
         vXC996kFdMIl3ULrvheIJes1OZIMUYyK2XRdfftmCSBcAY695gUtDpl9M2V6eJgtGJdW
         Nj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrIU+PUJM24Rm/kCu0tWvDDSY2IDCqop9Rnups86MjA=;
        b=vraK5Th1OCURjnUaxDvi6u1CtanH+26jiMVXvFlk3XyFFI+nG1lWtDD7CGkAZFvn7x
         54T0+vgXq814AjhsFdG9DuC7mBntXF9tIy77a2bE9MMxIHdXi2O3X9RGCxJUrhSGP5H0
         B5L6EMDV2y1puXj/lv9SrIYVk2TusB/wSshfPJaw/D+P7hb90SUnSppge6SN/AZP9rZh
         Qe5vcv0+9yItmVlZ8I/Fug87GOgcmJWeM8O+sV5ZA+Zh6onX6sgB/ylRKg6wcnoFV36L
         acc+lubWZsnXnSR0gtYgb/rVfalFhdjCfd0J8BzkYfKvGP6+RrBQzDtAVK/F7gL64UzJ
         7FRg==
X-Gm-Message-State: ACrzQf0BDDd4WXSFD2ZsEfIGknCv8+XdXD1Ef+ZYykqPXoJWbhU3PSIw
        slkiaZweQWrWwgXwTffFo88=
X-Google-Smtp-Source: AMsMyM6ZP/g3YYviCYnx6yk6/Cy7S0O0VY/+tw2CoqdHJVdQiwJsu4/TSY0bubdSG6bJz/bqVtrBWw==
X-Received: by 2002:aca:4057:0:b0:355:50f8:1753 with SMTP id n84-20020aca4057000000b0035550f81753mr437714oia.221.1666982397864;
        Fri, 28 Oct 2022 11:39:57 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id s83-20020aca5e56000000b003546cb60859sm1812584oib.14.2022.10.28.11.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:39:57 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:37:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
Message-ID: <Y1wheOT4yP7VCZ0p@yury-laptop>
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk>
 <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
 <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Alexey Klimov

On Fri, Oct 28, 2022 at 06:45:50PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 28, 2022 at 10:05:29AM -0700, Linus Torvalds wrote:
> > On Fri, Oct 28, 2022 at 9:47 AM Russell King (Oracle)
> > <rmk+kernel@armlinux.org.uk> wrote:
> > >
> > > Document the ARMv5 bit offset calculation code.
> > 
> > Hmm. Don't the generic bitop functions end up using this? We do have a
> > comment in the code that says
> > 
> >  * On ARMv5 and above, the gcc built-ins may rely on the clz instruction
> >  * and produce optimal inlined code in all cases. On ARMv7 it is even
> >  * better by also using the rbit instruction.
> 
> It's true that the generic code also makes use of the rbit and clz
> instructions - but in terms of the speed of the functions these only
> get used once we've found a word that is interesting to locate the
> bit we want in.
> 
> > but that 'may' makes me wonder...
> > 
> > IOW, what is it in the hand-written code that doesn't get done by the
> > generic code these days?
> 
> For the _find_first_bit, there isn't much difference in the number
> of instructions or really what is going on, only the organisation
> and flow of the code is more inline - but that shouldn't make much
> of a difference. Yet, there is a definite repeatable measurable
> difference between the two:
> 
> random-filled:
> arm    : find_first_bit:               17778911 ns,  16448 iterations
> generic: find_first_bit:               18596622 ns,  16401 iterations
> 
> sparse:
> arm    : find_first_bit:                7301363 ns,    656 iterations
> generic: find_first_bit:                7589120 ns,    655 iterations
> 
> The bigger difference is in the find_next_bit operations, and this
> likely comes from the arm32 code not having the hassles of the "_and"
> and other conditionals that the generic code has:
> 
> random-filled:
> arm    : find_next_bit:                 2242618 ns, 163949 iterations
> generic: find_next_bit:                 2632859 ns, 163743 iterations
> 
> sparse:
> arm    : find_next_bit:                   40078 ns,    656 iterations
> generic: find_next_bit:                   69943 ns,    655 iterations
> 
> find_next_zero_bit show a greater difference:
> 
> random-filled:
> arm    : find_next_zero_bit:            2049129 ns, 163732 iterations
> generic: find_next_zero_bit:            2844221 ns, 163938 iterations
> 
> sparse:
> arm    : find_next_zero_bit:            3939309 ns, 327025 iterations
> generic: find_next_zero_bit:            5529553 ns, 327026 iterations

Those numbers disagree with what Alexey has measured on Odroid board
for A15 but somewhat in line with what he had for A7:

https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/

Can you please share details about your methodology: what CPU did you use;
did you lock cpu frequencies; in addition to mean, can you also show
standard deviation, raw logs?

To Alexey: if you have time, can you please repeat those measurements
on top of v6 + this series? This would help a lot in understanding how
new code performs, both generic and arch.

If generic vs arch code comparison looks different for different CPU
versions, what should we prefer? 
 
> Here's the disassemblies for comparison. Note that the arm versions
> share code paths between the functions which makes the code even more
> compact - so the loop in the find_first gets re-used for find_next
> after we check the current word.
> 
> generic:

[...]
 
> 000000e8 <_find_next_bit>:
>   e8:   e92d4070        push    {r4, r5, r6, lr}
>   ec:   e1530002        cmp     r3, r2
>   f0:   e59d4010        ldr     r4, [sp, #16]
>   f4:   e59d5014        ldr     r5, [sp, #20]
>   f8:   2a000024        bcs     190 <_find_next_bit+0xa8>
>   fc:   e1a0e2a3        lsr     lr, r3, #5
>  100:   e3510000        cmp     r1, #0
>  104:   e203601f        and     r6, r3, #31
>  108:   e3c3301f        bic     r3, r3, #31
>  10c:   e790c10e        ldr     ip, [r0, lr, lsl #2]
>  110:   1791e10e        ldrne   lr, [r1, lr, lsl #2]
>  114:   100cc00e        andne   ip, ip, lr
>  118:   e3e0e000        mvn     lr, #0
>  11c:   e02cc004        eor     ip, ip, r4
>  120:   e3550000        cmp     r5, #0
>  124:   e1a0e61e        lsl     lr, lr, r6
>  128:   1a00001a        bne     198 <_find_next_bit+0xb0>
>  12c:   e01cc00e        ands    ip, ip, lr
>  130:   1a000011        bne     17c <_find_next_bit+0x94>
>  134:   e2833020        add     r3, r3, #32
>  138:   e1530002        cmp     r3, r2
>  13c:   3a000003        bcc     150 <_find_next_bit+0x68>
>  140:   ea000012        b       190 <_find_next_bit+0xa8>
>  144:   e2833020        add     r3, r3, #32
>  148:   e1520003        cmp     r2, r3
>  14c:   9a00000f        bls     190 <_find_next_bit+0xa8>
>  150:   e1a0e2a3        lsr     lr, r3, #5
>  154:   e3510000        cmp     r1, #0
>  158:   e790c10e        ldr     ip, [r0, lr, lsl #2]
>  15c:   1791e10e        ldrne   lr, [r1, lr, lsl #2]
>  160:   100cc00e        andne   ip, ip, lr
>  164:   e15c0004        cmp     ip, r4
>  168:   0afffff5        beq     144 <_find_next_bit+0x5c>
>  16c:   e02cc004        eor     ip, ip, r4
>  170:   e3550000        cmp     r5, #0
>  174:   0a000000        beq     17c <_find_next_bit+0x94>
>  178:   e6bfcf3c        rev     ip, ip
>  17c:   e6ffcf3c        rbit    ip, ip
>  180:   e16fcf1c        clz     ip, ip
>  184:   e08c3003        add     r3, ip, r3
>  188:   e1520003        cmp     r2, r3
>  18c:   21a02003        movcs   r2, r3
>  190:   e1a00002        mov     r0, r2
>  194:   e8bd8070        pop     {r4, r5, r6, pc}
>  198:   e6bfef3e        rev     lr, lr
>  19c:   e01cc00e        ands    ip, ip, lr
>  1a0:   0affffe3        beq     134 <_find_next_bit+0x4c>
>  1a4:   eafffff3        b       178 <_find_next_bit+0x90>

On top of master, my generic _find_next_bit looks different:

000000e4 <_find_next_bit>:
  e4:   e1510002        cmp     r1, r2
  e8:   e1a0c000        mov     ip, r0
  ec:   e1a00001        mov     r0, r1
  f0:   912fff1e        bxls    lr
  f4:   e1a012a2        lsr     r1, r2, #5
  f8:   e92d4010        push    {r4, lr}
  fc:   e202201f        and     r2, r2, #31
 100:   e3e03000        mvn     r3, #0
 104:   e79ce101        ldr     lr, [ip, r1, lsl #2]
 108:   e01ee213        ands    lr, lr, r3, lsl r2
 10c:   1a000012        bne     15c <_find_next_bit+0x78>
 110:   e2813001        add     r3, r1, #1
 114:   e1a04283        lsl     r4, r3, #5
 118:   e1540000        cmp     r4, r0
 11c:   28bd8010        popcs   {r4, pc}
 120:   e08c2101        add     r2, ip, r1, lsl #2
 124:   ea000002        b       134 <_find_next_bit+0x50>
 128:   e1a04283        lsl     r4, r3, #5
 12c:   e1500004        cmp     r0, r4
 130:   98bd8010        popls   {r4, pc}
 134:   e5b2e004        ldr     lr, [r2, #4]!
 138:   e2833001        add     r3, r3, #1
 13c:   e35e0000        cmp     lr, #0
 140:   0afffff8        beq     128 <_find_next_bit+0x44>
 144:   e6ffef3e        rbit    lr, lr
 148:   e16fef1e        clz     lr, lr
 14c:   e084400e        add     r4, r4, lr
 150:   e1500004        cmp     r0, r4
 154:   21a00004        movcs   r0, r4
 158:   e8bd8010        pop     {r4, pc}
 15c:   e1a04281        lsl     r4, r1, #5
 160:   eafffff7        b       144 <_find_next_bit+0x60>

Are you sure you're running latest kernel?

Thanks,
Yury
