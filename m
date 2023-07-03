Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94ECD7454DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 07:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGCFd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 01:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGCFdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 01:33:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6AC180;
        Sun,  2 Jul 2023 22:33:24 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-785d738d3feso97626839f.0;
        Sun, 02 Jul 2023 22:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688362404; x=1690954404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2OJkI5oE4uCqQWUEhyyoTu7x64zJyIZpzt0r/BY9EZI=;
        b=Ua8vKbeBJL7f7afD8YIkRD4woM1bj2cmfLtl3/kozt6R02oNruxffPXZ9ZlpfFQ3au
         yzIaL+ETdAP3qBG6rP06RgTWyDQi7xrB96lV3Ud5LyWuqIrCbrsdS4Esi8la9zurduvI
         ZInyjB1nmujCL4rAmiVbvKP5NHVh33xoAvXQkWX8JAb1s633idPLDK+AcJelfXosrMsC
         NRYugrkGzirT4sRU1NI52EbXuRNrDg0ngJ7hKG4UIvpA7uYRo87IPPT5uA0fBV7jhFxi
         QYXx+4SERBc9E3waqfhhlDinPOAjkYCFWangw9+LiLog0K+iEoZGD/IMsdKIOOfM20hd
         Drpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688362404; x=1690954404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OJkI5oE4uCqQWUEhyyoTu7x64zJyIZpzt0r/BY9EZI=;
        b=OGvd7anz3IQZrSUmX9ekDQ3fByl00y515F6gqufJihqpvYBk32Y7wO5tDCPLNp1vAN
         joDcDTRaOS6DR0Wn/LwdIKqb9DKnKrISaRgYWv19sMo1bcV70gQLGQ9RqG8OmdeaX3w0
         lNXN9kwnCKnBEjA4ff//8Ns5KfJ7iQeM+4cP0LMV7wRDPTQT01kn7kUVj2rjVOMChdGp
         4X1Mb8Uw6Gk60tfvZNZR400d+MaXoZmoaOztjKYzK1Mbggvn2khztYYo3qEb9M8hxjV5
         AEOmfuN4L6h/vf0rs+ZQY+5lLy0kFHigKXLTCcwSG29ifeR/RPv7inhH/L8AN5Tz65mq
         kNGw==
X-Gm-Message-State: AC+VfDw/rtUxInKN5R+T6GoGQoEScVMUHl7uvUhlki0QYir2WWqrFyr+
        8JosG5Fgd0nSZKfNED6kL90=
X-Google-Smtp-Source: ACHHUZ6Nhl+Ehz1EXA4qiJ7S0M+qmwtrtTY5VnwjX+qsjZeVNi58IEkGeAeGeFYv/fX6nA8E1OQUew==
X-Received: by 2002:a6b:5b02:0:b0:780:c872:5df7 with SMTP id v2-20020a6b5b02000000b00780c8725df7mr10205551ioh.9.1688362404118;
        Sun, 02 Jul 2023 22:33:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c14-20020a5d8b4e000000b007862c74cec6sm3370213iot.1.2023.07.02.22.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 22:33:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c21e8e95-3353-fc57-87fd-271b2c9cc000@roeck-us.net>
Date:   Sun, 2 Jul 2023 22:33:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Helge Deller <deller@gmx.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John David Anglin <dave.anglin@bell.net>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <2023063001-overlying-browse-de1a@gregkh>
 <0b2aefa4-7407-4936-6604-dedfb1614483@gmx.de>
 <5fd98a09-4792-1433-752d-029ae3545168@gmx.de>
 <CAHk-=wiHs1cL2Fb90NXVhtQsMuu+OLHB4rSDsPVe0ALmbvZXZQ@mail.gmail.com>
 <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
 <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
 <CAHk-=wgdC6RROG145_YB5yWoNtBQ0Xsrhdcu2TMAFTw52U2E0w@mail.gmail.com>
 <2a2387bf-f589-6856-3583-d3d848a17d34@roeck-us.net>
 <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAHk-=wgczy0dxK9vg-YWbq6YLP2gP8ix7Ys9K+Mr=S2NEj+hGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 21:49, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 21:46, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Sorry, you lost me. Isn't that the same patch as before ? Or
>> is it just time for me to go to bed ?
> 
> No, I think it's time for *me* to go to bed.
> 
> Let's get the right diff this time.
> 

Here you are:

[   31.188688] stack expand failed: ffeff000-fff00000 (ffefeff2)
[   31.189131] ------------[ cut here ]------------
[   31.189259] WARNING: CPU: 0 PID: 472 at fs/exec.c:217 get_arg_page+0x1e8/0x1f4
[   31.189827] Modules linked in:
[   31.190083] CPU: 0 PID: 472 Comm: sh Tainted: G                 N 6.4.0-32bit+ #1
[   31.190213] Hardware name: 9000/778/B160L
[   31.190347]
[   31.190407]      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
[   31.190496] PSW: 00000000000001001011111100001111 Tainted: G                 N
[   31.190625] r00-03  0004bf0f 11026240 1034a3ec 12bb41c0
[   31.190741] r04-07  127ec400 00000001 12b725a4 12b72530
[   31.190821] r08-11  129e6708 ffefeff2 2ff9d000 ffeff000
[   31.190895] r12-15  127ec400 10e463f0 10e34348 12a4d1a0
[   31.190962] r16-19  00000002 00001000 ffefe000 12a4d1a0
[   31.191033] r20-23  0000000f 00001a46 013ae000 12bb4498
[   31.191103] r24-27  11542330 00000000 115430a0 10ed98d8
[   31.191173] r28-31  00000031 00000310 12bb4240 0000000f
[   31.191251] sr00-03  00000000 00000000 00000000 000000a0
[   31.191332] sr04-07  00000000 00000000 00000000 00000000
[   31.191407]
[   31.191443] IASQ: 00000000 00000000 IAOQ: 1034a3ec 1034a3f0
[   31.191522]  IIR: 03ffe01f    ISR: 00000000  IOR: 1065d424
[   31.191593]  CPU:        0   CR30: 12a4d1a0 CR31: 00000000
[   31.192675]  ORIG_R28: 12a4d1a0
[   31.192770]  IAOQ[0]: get_arg_page+0x1e8/0x1f4
[   31.192851]  IAOQ[1]: get_arg_page+0x1ec/0x1f4
[   31.192922]  RP(r2): get_arg_page+0x1e8/0x1f4
[   31.193007] Backtrace:
[   31.193085]  [<1034a9cc>] copy_strings+0x148/0x3d8
[   31.193214]  [<1034ad94>] do_execveat_common+0x138/0x21c
[   31.193302]  [<1034bcc4>] sys_execve+0x3c/0x54
[   31.193400]  [<101af1b4>] syscall_exit+0x0/0x10
[   31.193562]
[   31.193698] ---[ end trace 0000000000000000 ]---
[   31.200551] stack expand failed: ffeff000-fff00000 (ffefefee)
/bin/sh: ls: Argument list too long

Guenter

