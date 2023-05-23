Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AAA70D039
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjEWBMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 21:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjEWBL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 21:11:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B62594;
        Mon, 22 May 2023 18:11:52 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1ae454844edso47474555ad.1;
        Mon, 22 May 2023 18:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684804312; x=1687396312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zer8l8b+HLR6p9Y6rOAVNAk3Mf+mytGElqdkx1hvfg=;
        b=XRjkEFgqsBq4G281uM5gCPGKUuLv6Z1mhjKaJc+g6HndU/0JHX19fP9ZumGm8Gq6SV
         KZzuaURaYVAb7sL2sCIE4Qo7TXIUZPP+Wfx9Ds76VMiQ8VwqhyKKPpZydL3OG0IelWPF
         a+iWXlbtABbGx3tkzOEXeqVy2N8sMmCTNpO2kpT/yVRGQSYFBt7s4OIkvfDINJVRSRgK
         dV6eD/aQDpQDvOUdwNelisfgp8jerQePhVq9To4IZ729vSxo6VXFPNrNzK7BIoJKWp0V
         LZhAZ5cwDSDk0LA6rZeY+5h/EjpqWxY3SWWmZ0YopJfPnX4bC3dKVYA+Ir19zfg0cOfS
         KmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684804312; x=1687396312;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zer8l8b+HLR6p9Y6rOAVNAk3Mf+mytGElqdkx1hvfg=;
        b=gG2jEbfoamp8RrujoGn3gH42DKUVBmmacpdRQHXl7nlxSPlo48y2UCCbr9kyIB7URX
         y6iw1uQSD2sMf4Dagxd/8KYCCfgsX6kyTKNeg9priycrfjN2LrhJOeDmZVUy5M0ZIMcr
         uOBRcvPbsZsHrbXSdICrEyUUdnCvEImksn2+UVtmyPjXTEcsNf97RwVl07s6S744Gdjp
         ZS/zxR944UOkpy7EXgPpezWNZqnYXDLEEy77YBwoP8e4ByPfaUDBDTszTH/S+OzGH8dU
         RRGQwW+VpGUfPbNHesVGag/JugY/VCxS7hllCoarFSEYTqZ0LvN4SRkkDWblw25og1G3
         qrcQ==
X-Gm-Message-State: AC+VfDw8Qj3ZUvHpwtsBASVtrARkI76SD7uYRt9yyMby8C34BgNVzhgL
        OQTQsSKXp8oCODTK4lEbJJKVJ9Xncgs=
X-Google-Smtp-Source: ACHHUZ7fMdZcLgvPTVew+0zN2KyVmCLZ5daLKGr46WzYmFf+BVc/XRUxb3EoZ/3bId3OSNTUy0Rskw==
X-Received: by 2002:a17:902:ce8a:b0:1af:cbe4:d953 with SMTP id f10-20020a170902ce8a00b001afcbe4d953mr685806plg.60.1684804311560;
        Mon, 22 May 2023 18:11:51 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:f952:4e63:79d7:bf10? ([2001:df0:0:200c:f952:4e63:79d7:bf10])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001ae2b94701fsm5411732plf.21.2023.05.22.18.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 18:11:51 -0700 (PDT)
Message-ID: <14e09781-6ffd-0834-fba4-427e5030f2be@gmail.com>
Date:   Tue, 23 May 2023 13:11:46 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] m68k: Move signal frame following exception on
 68020/030
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@linux-m68k.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>, stable@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1683365892.git.fthain@linux-m68k.org>
 <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org>
 <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdX_0F0hSZKqBBCN3876BmfwbQb1_+N3h-V8xs5ouRXF=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 22/05/23 23:41, Geert Uytterhoeven wrote:
> On Sat, May 6, 2023 at 11:36 AM Finn Thain <fthain@linux-m68k.org> wrote:
>> On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
>> a stack page fault during instruction execution (i.e. not at an
>> instruction boundary) and produce a format 0xB exception frame.
>>
>> In this situation, the value of USP will be unreliable. If a signal is to
>> be delivered following the exception, this USP value is used to calculate
>> the location for a signal frame. This can result in a corrupted user
>> stack.
>>
>> The corruption was detected in dash (actually in glibc) where it showed
>> up as an intermittent "stack smashing detected" message and crash
>> following signal delivery for SIGCHLD.
>>
>> It was hard to reproduce that failure because delivery of the signal
>> raced with the page fault and because the kernel places an unpredictable
>> gap of up to 7 bytes between the USP and the signal frame.
>>
>> A format 0xB exception frame can be produced by a bus error or an address
>> error. The 68030 Users Manual says that address errors occur immediately
>> upon detection during instruction prefetch. The instruction pipeline
>> allows prefetch to overlap with other instructions, which means an
>> address error can arise during the execution of a different instruction.
>> So it seems likely that this patch may help in the address error case also.
>>
>> Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
>> Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
>> Cc: Michael Schmitz <schmitzmic@gmail.com>
>> Cc: Andreas Schwab <schwab@linux-m68k.org>
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue as a fix in the m68k for-v6.4 branch.
>
> I plan to send this upstream later this week, so any additional
> testing would be appreciated.

I've given this some lengthy stress testing, and haven't seen it fail once.

In contrast, various attempts of mine to improve on the concept (by only 
moving the signal frame away from the USP in case it's likely to clash) 
sometimes came up against a kernel bus error in setup_frame() when 
copying the signo to the signal frame. I must be making some incorrect 
assumptions still ...

Limiting the signal frame shift to bus fault exceptions that happen 
mid-instruction is not too much of an overhead even in low memory 
settings, and using 256 bytes (the largest possible operand size, i.e. 
the largest adjustment to USP that might occur on completion of the 
interrupted instruction) did not seem to cause any issues with stack 
growth either.

I can give this some more testing in ARAnyM (extending the stack shift 
to format 7 frames) but I'd say it's got as much testing on 030 hardware 
as we can do.

Cheers,

     Michael


>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
