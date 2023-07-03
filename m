Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF574541F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCDX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:23:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD0B95;
        Sun,  2 Jul 2023 20:23:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b88e84bfb8so8820045ad.2;
        Sun, 02 Jul 2023 20:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688354603; x=1690946603;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tC2ikVsHLBbeocRmvK2qdglPhmmlZ6ytcOUovVJyZ8E=;
        b=fOUwfR0QcmqvhNFigYm30S1P+KvTRcNKGkuHkQmqRj9eF8QoajtfhOwLCp7P7ntAYf
         4d/LClaWc6BIAJu+Qaht9vpxry6pH9f5h1DcVMvYQmuz2j1hDxvsh6mdiW/5+iD77mFW
         H500HhpHcycqaVgLqNg+Myrn60ATPIJP8evNmh++1JoqUuBt4l9YI8RERDxzPp7ojiAp
         oPWDwcjjEGhQC6DgfmmWGRL827znhOaV+yjxPtmPw9c32mcxSmWNqFUjVw5hIGOSluzj
         U1k+D0naLz3sshqxGtcb4SCkBMyP7/hyeuJFsri4IrCPG8tbJDrizeKSde0US9yuxKjX
         VM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688354603; x=1690946603;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tC2ikVsHLBbeocRmvK2qdglPhmmlZ6ytcOUovVJyZ8E=;
        b=LpNbsiMzEtVajwUn+EdfHiy4IL691OrXWOmODca3Q8MUcNqf3+8lHQr8vfgTXQ1I9z
         jOD3RRv3KUFjMa0g7iyI9lGnViDhqkiFBv/se1yqdPg+WejVATgEGXb2Nk0gy+OFy0sW
         YjnhPNsJZjkJ1GEPSLczexjDRrj2J1EObKbIbJcT1XuAuXdMSRIV37JSpgsL7hFKaDAt
         Wgoqpf9Qw6gV6PPzWbTEqk+Yhcba24w60F5addXQGPaOHEN8Z52Tr00Y/giMHWJ1cIKi
         QOOGo20eS0DPJCIyrQ1Q375SanVaa+0wTRz73Kn3SKIUee2oQibm8HZNyJElBPNztLyW
         eG9A==
X-Gm-Message-State: ABy/qLZgUhKvVgn8qWE3MMknU9R1dh+W8eq1viH0oAp75kNi9eRTTpJz
        JaczdvBHohnQW+/PEZIxhgo//RJRkY8=
X-Google-Smtp-Source: APBJJlF24mVWYk1/hDvB4vhX4Rcp0QOntBWRfk/vlhd4cswA/btSkmp6FbHa5ex/wvGCjg/2Yqny5g==
X-Received: by 2002:a05:6a21:7898:b0:12e:7ca3:e22 with SMTP id bf24-20020a056a21789800b0012e7ca30e22mr2991655pzc.27.1688354603576;
        Sun, 02 Jul 2023 20:23:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b0066f37665a6asm8548659pfn.117.2023.07.02.20.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 20:23:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9b35a19d-800c-f9f9-6b45-cf2038ef235f@roeck-us.net>
Date:   Sun, 2 Jul 2023 20:23:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org,
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review - hppa argument list too long
In-Reply-To: <CAHk-=wj=0jkhj2=HkHVdezvuzV-djLsnyeE5zFfnXxgtS2MXFQ@mail.gmail.com>
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

On 7/2/23 16:30, Linus Torvalds wrote:
> On Sun, 2 Jul 2023 at 15:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Would you mind just verifying that yes, that commit on mainline is
>> broken for you, and the previous one works?
> 
> Also, while I looked at it again, and still didn't understand why
> parisc would be different here, I *did* realize that because parisc
> has a stack that grows up, the debug warning I added for GUP won't
> trigger.
> 
> So if I got that execve() logic wrong for STACK_GROWSUP (which I
> clearly must have), then exactly because it's grows-up, a GUP failure
> wouldn't warn about not expanding the stack.
> 
> IOW, would you mind applying something like this on top of the current
> kernel, and let me know if it warns?
> 

I can reproduce the problem in qemu. However, I do not see a warning
after applying your patch.

Guenter

